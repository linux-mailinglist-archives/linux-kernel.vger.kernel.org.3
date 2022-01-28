Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63D8549F3A6
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 07:29:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346504AbiA1G3Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 01:29:16 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:59108 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242495AbiA1G3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 01:29:06 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 7D31C21101;
        Fri, 28 Jan 2022 06:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643351345; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xpapT37KcxaYOeeQYt+sGcIsazRv7BTtatupftedrF0=;
        b=jOIkTwXv8I/BNPcVaUZMccPLMdv7gYAcODw3KAsgpoZi3HbCyu+UzuoaCrgTBTfUx7RO6a
        8G/7Z0FRbD8ncn4CZQRF+hNelwTjHKj+i2xzIqSBSgj6N167UPwE9wW2Eo0PNRBY1WYPs1
        9STYjKzmKUvIKQhu8dhmgZszLhJQWFc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643351345;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xpapT37KcxaYOeeQYt+sGcIsazRv7BTtatupftedrF0=;
        b=fRLo7kpURe7NYcJahmFg5gZfZCivitQUKm75iwXxaJJ0+gRNvm0D8C6fTOQJzVSDlIViri
        seKhrDL40QzkXKDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6DA0F13780;
        Fri, 28 Jan 2022 06:29:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id QYCPGjGN82G3MQAAMHmgww
        (envelope-from <osalvador@suse.de>); Fri, 28 Jan 2022 06:29:05 +0000
MIME-Version: 1.0
Date:   Fri, 28 Jan 2022 07:29:05 +0100
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
Subject: Re: [PATCH 3/6] mm, memory_hotplug: drop arch_free_nodedata
In-Reply-To: <20220127085305.20890-4-mhocko@kernel.org>
References: <20220127085305.20890-1-mhocko@kernel.org>
 <20220127085305.20890-4-mhocko@kernel.org>
User-Agent: Roundcube Webmail
Message-ID: <51a7daf7815d000ac0fdb57755a054b2@suse.de>
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
> Prior to "mm: handle uninitialized numa nodes gracefully" memory 
> hotplug
> used to allocate pgdat when memory has been added to a node
> (hotadd_init_pgdat) arch_free_nodedata has been only used in the
> failure path because once the pgdat is exported (to be visible
> by NODA_DATA(nid)) it cannot really be freed because there is no
> synchronization available for that.
> 
> pgdat is allocated for each possible nodes now so the memory hotplug
> doesn't need to do the ever use arch_free_nodedata so drop it.
> 
> This patch doesn't introduce any functional change.
> 
> Acked-by: Rafael Aquini <raquini@redhat.com>
> Signed-off-by: Michal Hocko <mhocko@suse.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>

-- 
Oscar Salvador
SUSE Labs
