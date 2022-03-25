Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67B654E73DB
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359202AbiCYNAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 09:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242241AbiCYNAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 09:00:20 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B0770916
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:58:46 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 2567F210DD;
        Fri, 25 Mar 2022 12:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1648213125; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j1OTytgc37TnxYn/42F/JXOrrT0mgLkreFQ2GEEDzWE=;
        b=WckXdQMHBOwB6P7CFtPU3xE9SzUK9jNqYJfHOWAjWFyikgp5efNUPSKu8ux8xwturW4DOb
        pCuTKhJsl2/ItW6dfv8/Dm2iYQP7tizc1/zw3pOTBA2e+M1tIj9tKltwoLd8S6s/ButTT8
        QO3R+unU+hCvR+Bxi6JGEOxwWZsQzOM=
Received: from suse.cz (unknown [10.100.201.86])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 0A144A3B82;
        Fri, 25 Mar 2022 12:58:45 +0000 (UTC)
Date:   Fri, 25 Mar 2022 13:58:42 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, Baoquan He <bhe@redhat.com>
Cc:     John Donnelly <john.p.donnelly@oracle.com>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] dma/pool: do not complain if DMA pool is not allocated
Message-ID: <Yj28gjonUa9+0yae@dhcp22.suse.cz>
References: <20220325122559.14251-1-mhocko@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220325122559.14251-1-mhocko@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri 25-03-22 13:25:59, Michal Hocko wrote:
> From: Michal Hocko <mhocko@suse.com>
> 
> we have a system complainging about order-5 allocation for the DMA pool.
> This is something that a674e48c5443 ("dma/pool: create dma atomic pool
> only if dma zone has managed pages") has already tried to achieve but I
> do not think it went all the way to have it covered completely. In this
> particular case has_managed_dma() will not work because:
> [    0.678539][    T0] Initmem setup node 0 [mem 0x0000000000001000-0x000000027dffffff]
> [    0.686316][    T0] On node 0, zone DMA: 1 pages in unavailable ranges
> [    0.687093][    T0] On node 0, zone DMA32: 36704 pages in unavailable ranges
> [    0.694278][    T0] On node 0, zone Normal: 53252 pages in unavailable ranges
> [    0.701257][    T0] On node 0, zone Normal: 8192 pages in unavailable ranges

Dang, I have just realized that I have misread the boot log and it has
turned out that a674e48c5443 is covering my situation because the
allocation failure message says:
Node 0 DMA free:0kB boost:0kB min:0kB low:0kB high:0kB reserved_highatomic:0KB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:636kB managed:0kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB

I thought there are only few pages in the managed by the DMA zone. This
is still theoretically possible so I think __GFP_NOWARN makes sense here
but it would require to change the patch description.

Is this really worth it?

> 
> The allocation failure on the DMA zone shouldn't be really critical for
> the system operation so just silence the warning instead.
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

-- 
Michal Hocko
SUSE Labs
