Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 215DD49F397
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346459AbiA1G1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:27:11 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59046 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242551AbiA1G1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:27:10 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A88BC21101;
        Fri, 28 Jan 2022 06:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643351229; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmcY6rQjztmhz8RTnKHfYdOR3tVFdDZGk/GHDzALr5I=;
        b=iU+icda/kGMAj3UGhqOh7R/tPdvoFLCyIdqJCRgX7bR/PA1BPycJtVPoETQh3t0Y1ssmZz
        iA5K1xlXRD+sEMUAVDAokG+yM6LJvEm1mtqxjSM2JYPfR7N7KZ+KHQzZv/J8yDOk34ksiX
        Y6awxU7AGeIbM3uJAHUG9hUZEv2eXwk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643351229;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FmcY6rQjztmhz8RTnKHfYdOR3tVFdDZGk/GHDzALr5I=;
        b=yL//OJyKBUc3yXZQY4ZhS6Gi1p6lEFwt+/8ft+wAxf8DG8nfTdqAnxJsD4nsWlUpxGk/wg
        KXjTrPjTIRaNQTAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 973BB13780;
        Fri, 28 Jan 2022 06:27:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Q+qlJL2M82ElMQAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 28 Jan 2022 06:27:09 +0000
MIME-Version: 1.0
Date:   Fri, 28 Jan 2022 07:27:09 +0100
From:   Oscar Salvador <osalvador@suse.de>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Alexey Makhalov <amakhalov@vmware.com>,
        Dennis Zhou <dennis@kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>,
        Nico Pache <npache@redhat.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        Rafael Aquini <raquini@redhat.com>,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH 2/6] mm: handle uninitialized numa nodes gracefully
In-Reply-To: <20220127085305.20890-3-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-3-mhocko@kernel.org>
User-Agent: Roundcube Webmail
Message-ID: <97904ddc17553119fe97801ef5f9193d@suse.de>
X-Sender: osalvador@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-27 09:53, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> We have had several reports [1][2][3] that page allocator blows up when
> an allocation from a possible node is requested. The underlying reason
> is that NODE_DATA for the specific node is not allocated.
> 
> NUMA specific initialization is arch specific and it can vary a lot.
> E.g. x86 tries to initialize all nodes that have some cpu affinity (see
> init_cpu_to_node) but this can be insufficient because the node might 
> be
> cpuless for example.
> 
> One way to address this problem would be to check for !node_online 
> nodes
> when trying to get a zonelist and silently fall back to another node.
> That is unfortunately adding a branch into allocator hot path and it
> doesn't handle any other potential NODE_DATA users.
> 
> This patch takes a different approach (following a lead of [3]) and it
> pre allocates pgdat for all possible nodes in an arch indipendent code
> - free_area_init. All uninitialized nodes are treated as memoryless
> nodes. node_state of the node is not changed because that would lead to
> other side effects - e.g. sysfs representation of such a node and from
> past discussions [4] it is known that some tools might have problems
> digesting that.
> 
> Newly allocated pgdat only gets a minimal initialization and the rest 
> of
> the work is expected to be done by the memory hotplug - 
> hotadd_new_pgdat
> (renamed to hotadd_init_pgdat).
> 
> generic_alloc_nodedata is changed to use the memblock allocator because
> neither page nor slab allocators are available at the stage when all
> pgdats are allocated. Hotplug doesn't allocate pgdat anymore so we can
> use the early boot allocator. The only arch specific implementation is
> ia64 and that is changed to use the early allocator as well.
> 
> Reported-by: Alexey Makhalov <amakhalov@vmware.com>
> Tested-by: Alexey Makhalov <amakhalov@vmware.com>
> Reported-by: Nico Pache <npache@redhat.com>
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Tested-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

With the mentioned fixups:

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs
