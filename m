Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 563CE477C7C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:24:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241022AbhLPTYK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:24:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236559AbhLPTYJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:24:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CE5FC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:24:09 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B1AD761F36
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:24:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08AC0C36AE3;
        Thu, 16 Dec 2021 19:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639682648;
        bh=+TVFAZTxInxw7zmpBcgQuQXT3yhZJYDamcGAgDcufWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dggFc5BJG1I5wNzZqpeqpnMRyQvHU7PdvqWygJsMQAJ03q9u8TLGolycgdzSbHmad
         YBb+bMRFMvedROs97+ouc/ZIaBB/q2D0YAQKxDA8LeU6lIgx+av16b7SGTr5o7Qp+Z
         q3bnuuJRQd6GQtqFLx0nqLY/m1UEJae1s2jVXG3BM16Qt9xIFCF1pAiethgWw1wlzA
         WuGhGQrzIOdB05+VhQMDKAKi4dNsk3vsf+RIRtB3WDjXv+ujU0z0J37+OXt2W64/Ys
         MtHfEyOGjlv5vjkww9lpFwJGQoxrd3fo8AOb+IZtHhnu9W8U90bmWWcBswiS9XNeMm
         8LWYuJ2D/Q6Zw==
Date:   Thu, 16 Dec 2021 11:24:06 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] f2fs: fix to reserve space for IO align feature
Message-ID: <YbuSVvznvVB6Zxr+@google.com>
References: <20211211132736.5283-1-chao@kernel.org>
 <bc4b6836-38de-3890-69f7-e9587af8a7c2@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bc4b6836-38de-3890-69f7-e9587af8a7c2@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/16, Chao Yu wrote:
> On 2021/12/11 21:27, Chao Yu wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=204137
> > 
> > With below script, we will hit panic during new segment allocation:
> > 
> > DISK=bingo.img
> > MOUNT_DIR=/mnt/f2fs
> > 
> > dd if=/dev/zero of=$DISK bs=1M count=105
> > mkfs.f2fe -a 1 -o 19 -t 1 -z 1 -f -q $DISK
> > 
> > mount -t f2fs $DISK $MOUNT_DIR -o "noinline_dentry,flush_merge,noextent_cache,mode=lfs,io_bits=7,fsync_mode=strict"
> > 
> > for (( i = 0; i < 4096; i++ )); do
> > 	name=`head /dev/urandom | tr -dc A-Za-z0-9 | head -c 10`
> > 	mkdir $MOUNT_DIR/$name
> > done
> > 
> > umount $MOUNT_DIR
> > rm $DISK
> > 
> > --- Core dump ---
> 
> Jaegeuk,
> 
> I guess below commit message was missed during applying patch due
> to above "---" string before "Core dump", could you please add them
> manually in the patch? or should I send a new version?

Updated. Thanks.

> 
> Thanks,
> 
> > Call Trace:
> >   allocate_segment_by_default+0x9d/0x100 [f2fs]
> >   f2fs_allocate_data_block+0x3c0/0x5c0 [f2fs]
> >   do_write_page+0x62/0x110 [f2fs]
> >   f2fs_outplace_write_data+0x43/0xc0 [f2fs]
> >   f2fs_do_write_data_page+0x386/0x560 [f2fs]
> >   __write_data_page+0x706/0x850 [f2fs]
> >   f2fs_write_cache_pages+0x267/0x6a0 [f2fs]
> >   f2fs_write_data_pages+0x19c/0x2e0 [f2fs]
> >   do_writepages+0x1c/0x70
> >   __filemap_fdatawrite_range+0xaa/0xe0
> >   filemap_fdatawrite+0x1f/0x30
> >   f2fs_sync_dirty_inodes+0x74/0x1f0 [f2fs]
> >   block_operations+0xdc/0x350 [f2fs]
> >   f2fs_write_checkpoint+0x104/0x1150 [f2fs]
> >   f2fs_sync_fs+0xa2/0x120 [f2fs]
> >   f2fs_balance_fs_bg+0x33c/0x390 [f2fs]
> >   f2fs_write_node_pages+0x4c/0x1f0 [f2fs]
> >   do_writepages+0x1c/0x70
> >   __writeback_single_inode+0x45/0x320
> >   writeback_sb_inodes+0x273/0x5c0
> >   wb_writeback+0xff/0x2e0
> >   wb_workfn+0xa1/0x370
> >   process_one_work+0x138/0x350
> >   worker_thread+0x4d/0x3d0
> >   kthread+0x109/0x140
> >   ret_from_fork+0x25/0x30
> > 
> > The root cause here is, with IO alignment feature enables, in worst
> > case, we need F2FS_IO_SIZE() free blocks space for single one 4k write
> > due to IO alignment feature will fill dummy pages to make IO being
> > aligned.
> > 
> > So we will easily run out of free segments during non-inline directory's
> > data writeback, even in process of foreground GC.
> > 
> > In order to fix this issue, I just propose to reserve additional free
> > space for IO alignment feature to handle worst case of free space usage
> > ratio during FGGC.
> > 
> > Fixes: 0a595ebaaa6b ("f2fs: support IO alignment for DATA and NODE writes")
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> > v3:
> > - rebase the codes.
> >   fs/f2fs/f2fs.h    | 11 +++++++++++
> >   fs/f2fs/segment.h |  3 ++-
> >   fs/f2fs/super.c   | 44 ++++++++++++++++++++++++++++++++++++++++++++
> >   fs/f2fs/sysfs.c   |  4 +++-
> >   4 files changed, 60 insertions(+), 2 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 5da592286721..d2d3b2332e79 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1023,6 +1023,7 @@ struct f2fs_sm_info {
> >   	unsigned int segment_count;	/* total # of segments */
> >   	unsigned int main_segments;	/* # of segments in main area */
> >   	unsigned int reserved_segments;	/* # of reserved segments */
> > +	unsigned int additional_reserved_segments;/* reserved segs for IO align feature */
> >   	unsigned int ovp_segments;	/* # of overprovision segments */
> >   	/* a threshold to reclaim prefree segments */
> > @@ -2200,6 +2201,11 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
> >   	if (!__allow_reserved_blocks(sbi, inode, true))
> >   		avail_user_block_count -= F2FS_OPTION(sbi).root_reserved_blocks;
> > +
> > +	if (F2FS_IO_ALIGNED(sbi))
> > +		avail_user_block_count -= sbi->blocks_per_seg *
> > +				SM_I(sbi)->additional_reserved_segments;
> > +
> >   	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
> >   		if (avail_user_block_count > sbi->unusable_block_count)
> >   			avail_user_block_count -= sbi->unusable_block_count;
> > @@ -2446,6 +2452,11 @@ static inline int inc_valid_node_count(struct f2fs_sb_info *sbi,
> >   	if (!__allow_reserved_blocks(sbi, inode, false))
> >   		valid_block_count += F2FS_OPTION(sbi).root_reserved_blocks;
> > +
> > +	if (F2FS_IO_ALIGNED(sbi))
> > +		valid_block_count += sbi->blocks_per_seg *
> > +				SM_I(sbi)->additional_reserved_segments;
> > +
> >   	user_block_count = sbi->user_block_count;
> >   	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED)))
> >   		user_block_count -= sbi->unusable_block_count;
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index 46fde9f3f28e..0291cd55cf09 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -538,7 +538,8 @@ static inline unsigned int free_segments(struct f2fs_sb_info *sbi)
> >   static inline unsigned int reserved_segments(struct f2fs_sb_info *sbi)
> >   {
> > -	return SM_I(sbi)->reserved_segments;
> > +	return SM_I(sbi)->reserved_segments +
> > +			SM_I(sbi)->additional_reserved_segments;
> >   }
> >   static inline unsigned int free_sections(struct f2fs_sb_info *sbi)
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 9acd76ea09ca..666dc9aed262 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -328,6 +328,46 @@ static inline void limit_reserve_root(struct f2fs_sb_info *sbi)
> >   					   F2FS_OPTION(sbi).s_resgid));
> >   }
> > +static inline int adjust_reserved_segment(struct f2fs_sb_info *sbi)
> > +{
> > +	unsigned int sec_blks = sbi->blocks_per_seg * sbi->segs_per_sec;
> > +	unsigned int avg_vblocks;
> > +	unsigned int wanted_reserved_segments;
> > +	block_t avail_user_block_count;
> > +
> > +	if (!F2FS_IO_ALIGNED(sbi))
> > +		return 0;
> > +
> > +	/* average valid block count in section in worst case */
> > +	avg_vblocks = sec_blks / F2FS_IO_SIZE(sbi);
> > +
> > +	/*
> > +	 * we need enough free space when migrating one section in worst case
> > +	 */
> > +	wanted_reserved_segments = (F2FS_IO_SIZE(sbi) / avg_vblocks) *
> > +						reserved_segments(sbi);
> > +	wanted_reserved_segments -= reserved_segments(sbi);
> > +
> > +	avail_user_block_count = sbi->user_block_count -
> > +				sbi->current_reserved_blocks -
> > +				F2FS_OPTION(sbi).root_reserved_blocks;
> > +
> > +	if (wanted_reserved_segments * sbi->blocks_per_seg >
> > +					avail_user_block_count) {
> > +		f2fs_err(sbi, "IO align feature can't grab additional reserved segment: %u, available segments: %u",
> > +			wanted_reserved_segments,
> > +			avail_user_block_count >> sbi->log_blocks_per_seg);
> > +		return -ENOSPC;
> > +	}
> > +
> > +	SM_I(sbi)->additional_reserved_segments = wanted_reserved_segments;
> > +
> > +	f2fs_info(sbi, "IO align feature needs additional reserved segment: %u",
> > +			 wanted_reserved_segments);
> > +
> > +	return 0;
> > +}
> > +
> >   static inline void adjust_unusable_cap_perc(struct f2fs_sb_info *sbi)
> >   {
> >   	if (!F2FS_OPTION(sbi).unusable_cap_perc)
> > @@ -4181,6 +4221,10 @@ static int f2fs_fill_super(struct super_block *sb, void *data, int silent)
> >   		goto free_nm;
> >   	}
> > +	err = adjust_reserved_segment(sbi);
> > +	if (err)
> > +		goto free_nm;
> > +
> >   	/* For write statistics */
> >   	sbi->sectors_written_start = f2fs_get_sectors_written(sbi);
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 55a7df17d5f3..c22bee84c8ec 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -424,7 +424,9 @@ static ssize_t __sbi_store(struct f2fs_attr *a,
> >   	if (a->struct_type == RESERVED_BLOCKS) {
> >   		spin_lock(&sbi->stat_lock);
> >   		if (t > (unsigned long)(sbi->user_block_count -
> > -				F2FS_OPTION(sbi).root_reserved_blocks)) {
> > +				F2FS_OPTION(sbi).root_reserved_blocks -
> > +				sbi->blocks_per_seg *
> > +				SM_I(sbi)->additional_reserved_segments)) {
> >   			spin_unlock(&sbi->stat_lock);
> >   			return -EINVAL;
> >   		}
