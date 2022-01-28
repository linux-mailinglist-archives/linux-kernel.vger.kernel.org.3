Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A63049F7B9
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 11:59:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347965AbiA1K7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 05:59:14 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:53134 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347960AbiA1K7M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 05:59:12 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 1F002210FF;
        Fri, 28 Jan 2022 10:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643367551; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pystFP2vYov3Vxc1Z0w9mC7AIsr505xEnFkEvj9rtUo=;
        b=b7haf79VaENWYUVb0knzQk0KLlXqxGpK0QId3C/l7HDU1UNOY2d16lv3dTsgjMfopBnAT6
        fwoU4XUdV2OMIFHswkx4ab68+38zITTBbgmGNGi+ySzZu+8qXgDqnSrIzjKaf3/Y1WOIlm
        RxVo5fiOG6I1btYAyAs8caKjSolbU8w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643367551;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pystFP2vYov3Vxc1Z0w9mC7AIsr505xEnFkEvj9rtUo=;
        b=JXjeXSTLQdTJH1OjYQBlxze3Q5zgZvWr3/x5Rd9VBOLwU7W4J31ya9R318khDDLeh/HfZc
        IRxoGpNfMCcFdLBw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0CF9E13A83;
        Fri, 28 Jan 2022 10:59:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QFfzAn/M82F/KwAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 28 Jan 2022 10:59:11 +0000
MIME-Version: 1.0
Date:   Fri, 28 Jan 2022 11:59:10 +0100
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
Subject: Re: [PATCH 5/6] mm: make free_area_init_node aware of memory less
 nodes
In-Reply-To: <20220127085305.20890-6-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-6-mhocko@kernel.org>
User-Agent: Roundcube Webmail
Message-ID: <78ba9df432cb860275e295806f9d7f01@suse.de>
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
> free_area_init_node is also called from memory less node initialization
> path (free_area_init_memoryless_node). It doesn't really make much 
> sense
> to display the physical memory range for those nodes:
> Initmem setup node XX [mem 0x0000000000000000-0x0000000000000000]
> 
> Instead be explicit that the node is memoryless:
> Initmem setup node XX as memoryless
> 
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs
