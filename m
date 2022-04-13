Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59CC4FFBF6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 19:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237154AbiDMRDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 13:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237147AbiDMRDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 13:03:17 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA88739801
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 10:00:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 70C6A61E84
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 17:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8143C385A4;
        Wed, 13 Apr 2022 17:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649869254;
        bh=wo3Wo9GrccRUNVNFdx4h+0W9/sxWbdIkUAXNTds8zzo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LiH2UC/zXex0HeGiA9EV5VGeZ+86nnNRaHVKQHN0dhG22QaE5kgi+8s6YBJhfdawQ
         k5v2Y4YF4dIuPu/JlI1jEiSE3gUhDdgMKf+PXTmgaAcKiPH8oN+pTPlSfAT4082pxK
         Bdz+CDOFxhZ6T9ggxCD5DZ8gKQCde8dqXLUkH0tqwWGNhlMw+jl/KTGrK1oy8l6YHz
         j5eQ0o5h7gjPtE8L8aLIkZaKpGcXruhkUR+OK1Mig8/5RN88RFcs1pIK7Cp3uw/YKf
         V3S1Ha8NH4ouExHOwsYRheyZfqu0uyL728O+42/WTISlHfevoGSh76IjqqzqF3SXSM
         p7dMicmAElWxw==
Date:   Wed, 13 Apr 2022 10:00:53 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Rokudo Yan <wu-yan@tcl.com>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, tang.ding@tcl.com
Subject: Re: [PATCH] f2fs: avoid deadlock in gc thread under low memory
Message-ID: <YlcBxSA5qYN4z1ia@google.com>
References: <20220413084432.1312900-1-wu-yan@tcl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220413084432.1312900-1-wu-yan@tcl.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/13, Rokudo Yan wrote:
> There is a potential deadlock in gc thread may happen
> under low memory as below:
> 
> gc_thread_func
>  -f2fs_gc
>   -do_garbage_collect
>    -gc_data_segment
>     -move_data_block
>      -set_page_writeback(fio.encrypted_page);
>      -f2fs_submit_page_write
> as f2fs_submit_page_write try to do io merge when possible, so the
> encrypted_page is marked PG_writeback but may not submit to block
> layer immediately, if system enter low memory when gc thread try
> to move next data block, it may do direct reclaim and enter fs layer
> as below:
>    -move_data_block
>     -f2fs_grab_cache_page(index=?, for_write=false)
>      -grab_cache_page
>       -find_or_create_page
>        -pagecache_get_page
>         -__page_cache_alloc --  __GFP_FS is set
>          -alloc_pages_node
>           -__alloc_pages
>            -__alloc_pages_slowpath
>             -__alloc_pages_direct_reclaim
>              -__perform_reclaim
>               -try_to_free_pages
>                -do_try_to_free_pages
>                 -shrink_zones
>                  -mem_cgroup_soft_limit_reclaim
>                   -mem_cgroup_soft_reclaim
>                    -mem_cgroup_shrink_node
>                     -shrink_node_memcg
>                      -shrink_list
>                       -shrink_inactive_list
>                        -shrink_page_list
>                         -wait_on_page_writeback -- the page is marked
>                        writeback during previous move_data_block call
> 
> the gc thread wait for the encrypted_page writeback complete,
> but as gc thread held sbi->gc_lock, the writeback & sync thread
> may blocked waiting for sbi->gc_lock, so the bio contain the
> encrypted_page may nerver submit to block layer and complete the
> writeback, which cause deadlock. To avoid this deadlock condition,
> we mark the gc thread with PF_MEMALLOC_NOFS flag, then it will nerver
> enter fs layer when try to alloc cache page during move_data_block.
> 
> Signed-off-by: Rokudo Yan <wu-yan@tcl.com>
> ---
>  fs/f2fs/gc.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index e020804f7b07..cc71f77b98c8 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -38,6 +38,12 @@ static int gc_thread_func(void *data)
>  
>  	wait_ms = gc_th->min_sleep_time;
>  
> +	/*
> +	 * Make sure that no allocations from gc thread will ever
> +	 * recurse to the fs layer to avoid deadlock as it will
> +	 * hold sbi->gc_lock during garbage collection
> +	 */
> +	memalloc_nofs_save();

I think this cannot cover all the f2fs_gc() call cases. Can we just avoid by:

--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1233,7 +1233,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
                                CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;

        /* do not read out */
-       page = f2fs_grab_cache_page(inode->i_mapping, bidx, false);
+       page = f2fs_grab_cache_page(inode->i_mapping, bidx, true);
        if (!page)
                return -ENOMEM;

Thanks,

>  	set_freezable();
>  	do {
>  		bool sync_mode, foreground = false;
> -- 
> 2.25.1
