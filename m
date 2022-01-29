Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 852254A2A9E
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 01:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235451AbiA2AfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 19:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234059AbiA2AfO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 19:35:14 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 504C7C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 16:35:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E161860A66
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 00:35:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 350A9C340E7;
        Sat, 29 Jan 2022 00:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643416513;
        bh=kw+3OTuPDX3/tG8tmhcjVaDk/mA/bOZLCX0XvOcKmD4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YaOC4DvVe8kU3LsMjzXMw9wjm5SiYfjaXhHKNuthOgxNYw9ArzXaEVQPqh0wNlQ7s
         ZoYEfSaoc8fjwbltCZQkywbTTmnO+n+n5rj/ySoSTjp3oDH7KDJKYvkorLiJIMVzxN
         BfXpBVA7IN1htEKssXqfgUZnD+xclxAZgyW0I353BjSavykv0S4Kt49qb18xbOGG8u
         3EwG9XkURp2V9Butaz+BcMDRAGB+j973hWaD4Se1csufGfa9+vW3E+Xz0Hx95UV7Vo
         iKJDOawtMg6v0jqX8CfddBzhTAPiQ+HW0XHDT6t8OqTxrC1oZtqkPqIFn6x1XboEzz
         i2TNzanbRPmtg==
Date:   Fri, 28 Jan 2022 16:35:11 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: don't check IPU policy during file defragment
Message-ID: <YfSLvyMUd3lam415@google.com>
References: <20220128091920.1556480-1-chao@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128091920.1556480-1-chao@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/28, Chao Yu wrote:
> Once IPU policy is enabled in some cases:
> a) f2fs forces to use F2FS_IPU_FORCE in a small-sized volume
> b) user configures IPU policy via sysfs

It's contradictory to each other. How about just letting users decide to do what
they want to do? IOWs, if user wants to do defrag, they should change ipu_policy
on the fly.

> 
> Then we may fail to defragment file via ioctl due to IPU policy check,
> it doesn't make sense, so let's change to use IPU policy for common
> data writeback, rather than for specific data writeback, e.g. GC,
> defragment, and so on.
> 
> Signed-off-by: Chao Yu <chao@kernel.org>
> ---
>  fs/f2fs/data.c | 15 ++++++++++-----
>  fs/f2fs/f2fs.h |  3 ++-
>  fs/f2fs/file.c | 17 ++++++++++-------
>  3 files changed, 22 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 0f124e8de1d4..bce7ecac8976 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -2530,6 +2530,9 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
>  	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
>  		return true;
>  
> +	if (is_inode_flag_set(inode, FI_DEFRAG_PROCESS))
> +		return true;
> +
>  	if (fio) {
>  		if (page_private_gcing(fio->page))
>  			return true;
> @@ -3154,8 +3157,8 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
>  			f2fs_available_free_memory(sbi, DIRTY_DENTS))
>  		goto skip_write;
>  
> -	/* skip writing during file defragment */
> -	if (is_inode_flag_set(inode, FI_DO_DEFRAG))
> +	/* skip writing in file defragment preparing stage */
> +	if (is_inode_flag_set(inode, FI_DEFRAG_PREPARE))
>  		goto skip_write;
>  
>  	trace_f2fs_writepages(mapping->host, wbc, DATA);
> @@ -3733,7 +3736,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
>  		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
>  		f2fs_unlock_op(sbi);
>  
> -		set_inode_flag(inode, FI_DO_DEFRAG);
> +		set_inode_flag(inode, FI_DEFRAG_PREPARE);
>  
>  		for (blkofs = 0; blkofs < blk_per_sec; blkofs++) {
>  			struct page *page;
> @@ -3750,9 +3753,11 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
>  			f2fs_put_page(page, 1);
>  		}
>  
> -		clear_inode_flag(inode, FI_DO_DEFRAG);
> +		clear_inode_flag(inode, FI_DEFRAG_PREPARE);
>  
> +		set_inode_flag(inode, FI_DEFRAG_PROCESS);
>  		ret = filemap_fdatawrite(inode->i_mapping);
> +		clear_inode_flag(inode, FI_DEFRAG_PROCESS);
>  
>  		f2fs_up_write(&sbi->pin_sem);
>  
> @@ -3761,7 +3766,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
>  	}
>  
>  done:
> -	clear_inode_flag(inode, FI_DO_DEFRAG);
> +	clear_inode_flag(inode, FI_DEFRAG_PREPARE);
>  	clear_inode_flag(inode, FI_ALIGNED_WRITE);
>  
>  	filemap_invalidate_unlock(inode->i_mapping);
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8178a9152e49..4b905059a81e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -733,7 +733,8 @@ enum {
>  	FI_DROP_CACHE,		/* drop dirty page cache */
>  	FI_DATA_EXIST,		/* indicate data exists */
>  	FI_INLINE_DOTS,		/* indicate inline dot dentries */
> -	FI_DO_DEFRAG,		/* indicate defragment is running */
> +	FI_DEFRAG_PREPARE,	/* indicate defragment is preparing */
> +	FI_DEFRAG_PROCESS,	/* indicate defragment is processing */
>  	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
>  	FI_PREALLOCATED_ALL,	/* all blocks for write were preallocated */
>  	FI_HOT_DATA,		/* indicate file is hot */
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6ccdd6e347e2..696f4a175228 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2559,10 +2559,6 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  	bool fragmented = false;
>  	int err;
>  
> -	/* if in-place-update policy is enabled, don't waste time here */
> -	if (f2fs_should_update_inplace(inode, NULL))
> -		return -EINVAL;
> -
>  	pg_start = range->start >> PAGE_SHIFT;
>  	pg_end = (range->start + range->len) >> PAGE_SHIFT;
>  
> @@ -2570,6 +2566,11 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  
>  	inode_lock(inode);
>  
> +	if (f2fs_is_pinned_file(inode)) {
> +		err = -EINVAL;
> +		goto out;
> +	}
> +
>  	/* writeback all dirty pages in the range */
>  	err = filemap_write_and_wait_range(inode->i_mapping, range->start,
>  						range->start + range->len - 1);
> @@ -2651,7 +2652,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  			goto check;
>  		}
>  
> -		set_inode_flag(inode, FI_DO_DEFRAG);
> +		set_inode_flag(inode, FI_DEFRAG_PREPARE);
>  
>  		idx = map.m_lblk;
>  		while (idx < map.m_lblk + map.m_len && cnt < blk_per_seg) {
> @@ -2676,14 +2677,16 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
>  		if (map.m_lblk < pg_end && cnt < blk_per_seg)
>  			goto do_map;
>  
> -		clear_inode_flag(inode, FI_DO_DEFRAG);
> +		clear_inode_flag(inode, FI_DEFRAG_PREPARE);
>  
> +		set_inode_flag(inode, FI_DEFRAG_PROCESS);
>  		err = filemap_fdatawrite(inode->i_mapping);
> +		clear_inode_flag(inode, FI_DEFRAG_PROCESS);
>  		if (err)
>  			goto out;
>  	}
>  clear_out:
> -	clear_inode_flag(inode, FI_DO_DEFRAG);
> +	clear_inode_flag(inode, FI_DEFRAG_PREPARE);
>  out:
>  	inode_unlock(inode);
>  	if (!err)
> -- 
> 2.25.1
