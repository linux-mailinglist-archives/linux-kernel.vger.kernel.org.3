Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A45CB58E4D4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 04:20:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbiHJCTf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 22:19:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbiHJCTd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 22:19:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 357F165831
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 19:19:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660097971;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XsWDjZjgsNfjUxr0LgY37t8NCq9KD2p+0KhKiqkyXmI=;
        b=Veg4BqEoi33BjpUf6IwixZgrKtSZ6ivc3Vjp/FmFsCUxieCbXoKHZNhSo9oAIY9eNVsCKb
        KLZDaoEJXnSMAdRFuvPoWg1VZDigMHozsa/StsbWbXArLhmDr40NzhFUFD6ulfqIxjyqKH
        mrI+m6cKsl5glcqjQyvktZNcX7EPIKc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-13-43TqtEO5OVeMSC6f11rkWQ-1; Tue, 09 Aug 2022 22:19:30 -0400
X-MC-Unique: 43TqtEO5OVeMSC6f11rkWQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7C80A1824602;
        Wed, 10 Aug 2022 02:19:29 +0000 (UTC)
Received: from localhost (ovpn-12-32.pek2.redhat.com [10.72.12.32])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 3990740CFD0A;
        Wed, 10 Aug 2022 02:19:27 +0000 (UTC)
Date:   Wed, 10 Aug 2022 10:19:23 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <20220810021923.GD373960@MiWiFi-R3L-srv>
References: <YupFSpXOrcfXJNya@dhcp22.suse.cz>
 <YuqNToCACD8kKBG+@MiWiFi-R3L-srv>
 <YuqOrJKcgfamdXkk@dhcp22.suse.cz>
 <YuqU87SDwP0zg+c7@MiWiFi-R3L-srv>
 <YuqX0OAItlMDfRUV@dhcp22.suse.cz>
 <YuunCO2lsLDWTGw+@MiWiFi-R3L-srv>
 <Yuu1EyC95XL98XNI@dhcp22.suse.cz>
 <Yu0OWLbzLxCkSGVJ@MiWiFi-R3L-srv>
 <Yu1VTAxd9/jP/iEk@dhcp22.suse.cz>
 <YvJ/V2bor9Q3P6ov@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvJ/V2bor9Q3P6ov@dhcp22.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/09/22 at 05:37pm, Michal Hocko wrote:
> Here we go again.
> ---
> From 1dc9d7504624b273de47a88a9907f43533bfe08e Mon Sep 17 00:00:00 2001
> From: Michal Hocko <mhocko@suse.com>
> Date: Fri, 25 Mar 2022 13:25:59 +0100
> Subject: [PATCH] dma/pool: do not complain if DMA pool is not allocated
> 
> we have a system complainging about order-10 allocation for the DMA pool.
> 
> [   14.017417][    T1] swapper/0: page allocation failure: order:10, mode:0xcc1(GFP_KERNEL|GFP_DMA), nodemask=(null),cpuset=/,mems_allowed=0-7
> [   14.017429][    T1] CPU: 4 PID: 1 Comm: swapper/0 Not tainted 5.14.21-150400.22-default #1 SLE15-SP4 0b6a6578ade2de5c4a0b916095dff44f76ef1704
> [   14.017434][    T1] Hardware name: XXXX
> [   14.017437][    T1] Call Trace:
> [   14.017444][    T1]  <TASK>
> [   14.017449][    T1]  dump_stack_lvl+0x45/0x57
> [   14.017469][    T1]  warn_alloc+0xfe/0x160
> [   14.017490][    T1]  __alloc_pages_slowpath.constprop.112+0xc27/0xc60
> [   14.017497][    T1]  ? rdinit_setup+0x2b/0x2b
> [   14.017509][    T1]  ? rdinit_setup+0x2b/0x2b
> [   14.017512][    T1]  __alloc_pages+0x2d5/0x320
> [   14.017517][    T1]  alloc_page_interleave+0xf/0x70
> [   14.017531][    T1]  atomic_pool_expand+0x4a/0x200
> [   14.017541][    T1]  ? rdinit_setup+0x2b/0x2b
> [   14.017544][    T1]  __dma_atomic_pool_init+0x44/0x90
> [   14.017556][    T1]  dma_atomic_pool_init+0xad/0x13f
> [   14.017560][    T1]  ? __dma_atomic_pool_init+0x90/0x90
> [   14.017562][    T1]  do_one_initcall+0x41/0x200
> [   14.017581][    T1]  kernel_init_freeable+0x236/0x298
> [   14.017589][    T1]  ? rest_init+0xd0/0xd0
> [   14.017596][    T1]  kernel_init+0x16/0x120
> [   14.017599][    T1]  ret_from_fork+0x22/0x30
> [   14.017604][    T1]  </TASK>
> [...]
> [   14.018026][    T1] Node 0 DMA free:160kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
> [   14.018035][    T1] lowmem_reserve[]: 0 0 0 0 0
> [   14.018339][    T1] Node 0 DMA: 0*4kB 0*8kB 0*16kB 1*32kB (U) 0*64kB 1*128kB (U) 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 160kB
> 
> The usable memory in the DMA zone is obviously too small for the pool
> pre-allocation. The allocation failure raises concern by admins because
> this is considered an error state.
> 
> In fact the preallocation itself doesn't expose any actual problem. It
> is not even clear whether anybody is ever going to use this pool. If yes
> then a warning will be triggered anyway.
> 
> Silence the warning to prevent confusion and bug reports.

LGTM,

Reviewed-by: Baoquan He <bhe@redhat.com>

> 
> Signed-off-by: Michal Hocko <mhocko@suse.com>
> ---
>  kernel/dma/pool.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 4d40dcce7604..1bf6de398986 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c
> @@ -205,7 +205,7 @@ static int __init dma_atomic_pool_init(void)
>  		ret = -ENOMEM;
>  	if (has_managed_dma()) {
>  		atomic_pool_dma = __dma_atomic_pool_init(atomic_pool_size,
> -						GFP_KERNEL | GFP_DMA);
> +						GFP_KERNEL | GFP_DMA | __GFP_NOWARN);
>  		if (!atomic_pool_dma)
>  			ret = -ENOMEM;
>  	}
> -- 
> 2.30.2
> 
> -- 
> Michal Hocko
> SUSE Labs
> 

