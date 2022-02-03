Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4E4E4A7D7E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 02:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348838AbiBCBuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 20:50:51 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:42404 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230436AbiBCBuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 20:50:50 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9469EB832C8
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 01:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24E33C004E1;
        Thu,  3 Feb 2022 01:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643853048;
        bh=WlV+VOlxIMB7KE/ukafvV4Fp7I1v2Cm1b8oD+shESfg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GpFDYhReINkAi68f1tdvvaKFlHnT/iqsCrc9H1q3SDc/flyxErWnLAS1CRZV8nyrA
         SflO2LNYKjH/30BufO5wZbx9i+Cx6dp2k8ClAZbb3kj72lUP7blb/b3La9dReh+Ge3
         sLa7xehdDUM4hHbdim3Q1qfiPAoaJ4EpKg7aU2rH0nA1tok2gwDCQ2lBPTKSGIaQgi
         F+pSpmNa5sGd0J9GTtk2ZRv/HwI0qMqGBR72LP8CtUddiPito6tcJoqOeo3hNaZHvV
         SzO/qgj7jl3/ryMc1LvlWywiqiEVus/5s8nd5Zk8vGRrSRgrPufFlhPUOCNgV8SIch
         8Dx3XA6+4P5vQ==
Date:   Wed, 2 Feb 2022 17:50:46 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: don't check IPU policy during file defragment
Message-ID: <Yfs09i06EZASuLGI@google.com>
References: <20220128091920.1556480-1-chao@kernel.org>
 <YfSLvyMUd3lam415@google.com>
 <d5851f31-6eec-e00c-5412-59496c2c849e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5851f31-6eec-e00c-5412-59496c2c849e@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29, Chao Yu wrote:
> On 2022/1/29 8:35, Jaegeuk Kim wrote:
> > On 01/28, Chao Yu wrote:
> > > Once IPU policy is enabled in some cases:
> > > a) f2fs forces to use F2FS_IPU_FORCE in a small-sized volume
> > > b) user configures IPU policy via sysfs
> > 
> > It's contradictory to each other. How about just letting users decide to do what
> > they want to do? IOWs, if user wants to do defrag, they should change ipu_policy
> > on the fly.
> 
> How about the case user wants to do defrag for specified files, and also use
> ipu_policy for other common writes?
> 
> IMO, it may be not completely contradictory, if we try to treat userspace defraging
> requirement as specified OPU requirement, like kernel-side OPU requirement from
> node write or GC write.
> 
> Or maybe we can introduce a new ipu_policy which allow triggering OPU when defraging
> triggered from userspace?

OPU is the default as F2FS was originated from LFS. Then, IPU was added to
improve performance in some cases to avoid node updates. IPU_FORCE was added
to enforce IPU all the time. So, I think you can add another IPU bit which
can relax IPU_FORCE.

> 
> Thanks,
> 
> > 
> > > 
> > > Then we may fail to defragment file via ioctl due to IPU policy check,
> > > it doesn't make sense, so let's change to use IPU policy for common
> > > data writeback, rather than for specific data writeback, e.g. GC,
> > > defragment, and so on.
> > > 
> > > Signed-off-by: Chao Yu <chao@kernel.org>
> > > ---
> > >   fs/f2fs/data.c | 15 ++++++++++-----
> > >   fs/f2fs/f2fs.h |  3 ++-
> > >   fs/f2fs/file.c | 17 ++++++++++-------
> > >   3 files changed, 22 insertions(+), 13 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 0f124e8de1d4..bce7ecac8976 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -2530,6 +2530,9 @@ bool f2fs_should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
> > >   	if (is_inode_flag_set(inode, FI_ALIGNED_WRITE))
> > >   		return true;
> > > +	if (is_inode_flag_set(inode, FI_DEFRAG_PROCESS))
> > > +		return true;
> > > +
> > >   	if (fio) {
> > >   		if (page_private_gcing(fio->page))
> > >   			return true;
> > > @@ -3154,8 +3157,8 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
> > >   			f2fs_available_free_memory(sbi, DIRTY_DENTS))
> > >   		goto skip_write;
> > > -	/* skip writing during file defragment */
> > > -	if (is_inode_flag_set(inode, FI_DO_DEFRAG))
> > > +	/* skip writing in file defragment preparing stage */
> > > +	if (is_inode_flag_set(inode, FI_DEFRAG_PREPARE))
> > >   		goto skip_write;
> > >   	trace_f2fs_writepages(mapping->host, wbc, DATA);
> > > @@ -3733,7 +3736,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
> > >   		f2fs_allocate_new_section(sbi, CURSEG_COLD_DATA_PINNED, false);
> > >   		f2fs_unlock_op(sbi);
> > > -		set_inode_flag(inode, FI_DO_DEFRAG);
> > > +		set_inode_flag(inode, FI_DEFRAG_PREPARE);
> > >   		for (blkofs = 0; blkofs < blk_per_sec; blkofs++) {
> > >   			struct page *page;
> > > @@ -3750,9 +3753,11 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
> > >   			f2fs_put_page(page, 1);
> > >   		}
> > > -		clear_inode_flag(inode, FI_DO_DEFRAG);
> > > +		clear_inode_flag(inode, FI_DEFRAG_PREPARE);
> > > +		set_inode_flag(inode, FI_DEFRAG_PROCESS);
> > >   		ret = filemap_fdatawrite(inode->i_mapping);
> > > +		clear_inode_flag(inode, FI_DEFRAG_PROCESS);
> > >   		f2fs_up_write(&sbi->pin_sem);
> > > @@ -3761,7 +3766,7 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
> > >   	}
> > >   done:
> > > -	clear_inode_flag(inode, FI_DO_DEFRAG);
> > > +	clear_inode_flag(inode, FI_DEFRAG_PREPARE);
> > >   	clear_inode_flag(inode, FI_ALIGNED_WRITE);
> > >   	filemap_invalidate_unlock(inode->i_mapping);
> > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > > index 8178a9152e49..4b905059a81e 100644
> > > --- a/fs/f2fs/f2fs.h
> > > +++ b/fs/f2fs/f2fs.h
> > > @@ -733,7 +733,8 @@ enum {
> > >   	FI_DROP_CACHE,		/* drop dirty page cache */
> > >   	FI_DATA_EXIST,		/* indicate data exists */
> > >   	FI_INLINE_DOTS,		/* indicate inline dot dentries */
> > > -	FI_DO_DEFRAG,		/* indicate defragment is running */
> > > +	FI_DEFRAG_PREPARE,	/* indicate defragment is preparing */
> > > +	FI_DEFRAG_PROCESS,	/* indicate defragment is processing */
> > >   	FI_DIRTY_FILE,		/* indicate regular/symlink has dirty pages */
> > >   	FI_PREALLOCATED_ALL,	/* all blocks for write were preallocated */
> > >   	FI_HOT_DATA,		/* indicate file is hot */
> > > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > > index 6ccdd6e347e2..696f4a175228 100644
> > > --- a/fs/f2fs/file.c
> > > +++ b/fs/f2fs/file.c
> > > @@ -2559,10 +2559,6 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
> > >   	bool fragmented = false;
> > >   	int err;
> > > -	/* if in-place-update policy is enabled, don't waste time here */
> > > -	if (f2fs_should_update_inplace(inode, NULL))
> > > -		return -EINVAL;
> > > -
> > >   	pg_start = range->start >> PAGE_SHIFT;
> > >   	pg_end = (range->start + range->len) >> PAGE_SHIFT;
> > > @@ -2570,6 +2566,11 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
> > >   	inode_lock(inode);
> > > +	if (f2fs_is_pinned_file(inode)) {
> > > +		err = -EINVAL;
> > > +		goto out;
> > > +	}
> > > +
> > >   	/* writeback all dirty pages in the range */
> > >   	err = filemap_write_and_wait_range(inode->i_mapping, range->start,
> > >   						range->start + range->len - 1);
> > > @@ -2651,7 +2652,7 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
> > >   			goto check;
> > >   		}
> > > -		set_inode_flag(inode, FI_DO_DEFRAG);
> > > +		set_inode_flag(inode, FI_DEFRAG_PREPARE);
> > >   		idx = map.m_lblk;
> > >   		while (idx < map.m_lblk + map.m_len && cnt < blk_per_seg) {
> > > @@ -2676,14 +2677,16 @@ static int f2fs_defragment_range(struct f2fs_sb_info *sbi,
> > >   		if (map.m_lblk < pg_end && cnt < blk_per_seg)
> > >   			goto do_map;
> > > -		clear_inode_flag(inode, FI_DO_DEFRAG);
> > > +		clear_inode_flag(inode, FI_DEFRAG_PREPARE);
> > > +		set_inode_flag(inode, FI_DEFRAG_PROCESS);
> > >   		err = filemap_fdatawrite(inode->i_mapping);
> > > +		clear_inode_flag(inode, FI_DEFRAG_PROCESS);
> > >   		if (err)
> > >   			goto out;
> > >   	}
> > >   clear_out:
> > > -	clear_inode_flag(inode, FI_DO_DEFRAG);
> > > +	clear_inode_flag(inode, FI_DEFRAG_PREPARE);
> > >   out:
> > >   	inode_unlock(inode);
> > >   	if (!err)
> > > -- 
> > > 2.25.1
