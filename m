Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE95520311
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 18:58:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239422AbiEIRCI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 13:02:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239335AbiEIRCG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 13:02:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 599811E59C8
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 09:58:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DBD4E614A9
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 16:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31DE4C385B2;
        Mon,  9 May 2022 16:58:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652115491;
        bh=bg00mTeEJQQhF2bvuEXlUXbs4usNjbxrMcwtA5NAbZc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gzERY/WdQ+6NJN27Maq0PS32RyiTZEyjM7kGaiiETJFR3skMtdBWZsI2+VY6BIDe5
         +cUjeF8ya9rKZrqEOamv5knAIKVMSAW8w5HW5otxsAspiIY/w/e+65Pr+2cBplosmN
         OVYyeIWZyqERET3B+aBwfM97sCG9jwDa2VMNVW/XxLiKo5uRfPhdtNqCNbgjSxQUqg
         Xn+Vm+XsE2yAIilBa3Ux6cytpRrEyx3DEVImXYN+2zznxk+y8fC2GeU5y6MBdOcU4x
         5oAmDuv0FopjY4SqsKQb5qaT85H1Gujd/rPkexMVdnmiZ2RDUBdGIbxSualYsqyC0b
         5YWx0O1X+Ikrg==
Date:   Mon, 9 May 2022 09:58:09 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs: do not stop GC when requiring a
 free section
Message-ID: <YnlIIRoCtHQspUjX@google.com>
References: <20220506232032.1264078-1-jaegeuk@kernel.org>
 <20220506232032.1264078-4-jaegeuk@kernel.org>
 <a0fb04fc-21f6-e417-0160-4c7ef5c0b9c0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0fb04fc-21f6-e417-0160-4c7ef5c0b9c0@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/07, Chao Yu wrote:
> On 2022/5/7 7:20, Jaegeuk Kim wrote:
> > The f2fs_gc uses a bitmap to indicate pinned sections, but when disabling
> > chckpoint, we call f2fs_gc() with NULL_SEGNO which selects the same dirty
> > segment as a victim all the time, resulting in checkpoint=disable failure,
> > for example. Let's pick another one, if we fail to collect it.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   fs/f2fs/f2fs.h              |  1 +
> >   fs/f2fs/file.c              | 12 ++++++++----
> >   fs/f2fs/gc.c                | 11 +++++++----
> >   fs/f2fs/segment.c           |  3 ++-
> >   fs/f2fs/super.c             |  3 ++-
> >   include/trace/events/f2fs.h | 11 ++++++++---
> >   6 files changed, 28 insertions(+), 13 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index d49b9b476592..27871f6efb01 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1282,6 +1282,7 @@ struct f2fs_gc_control {
> >   	bool no_bg_gc;			/* check the space and stop bg_gc */
> >   	bool should_migrate_blocks;	/* should migrate blocks */
> >   	bool err_gc_skipped;		/* return EAGAIN if GC skipped */
> > +	unsigned int nr_free_secs;	/* # of free sections to do GC */
> >   };
> >   /* For s_flag in struct f2fs_sb_info */
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index 0e7d101c3e65..7072c2b86b2f 100644
> > --- a/fs/f2fs/file.c
> > +++ b/fs/f2fs/file.c
> > @@ -1650,7 +1650,8 @@ static int expand_inode_data(struct inode *inode, loff_t offset,
> >   	struct f2fs_gc_control gc_control = { .victim_segno = NULL_SEGNO,
> >   			.init_gc_type = FG_GC,
> >   			.should_migrate_blocks = false,
> > -			.err_gc_skipped = true };
> > +			.err_gc_skipped = true,
> > +			.nr_free_secs = 0 };
> >   	pgoff_t pg_start, pg_end;
> >   	loff_t new_size = i_size_read(inode);
> >   	loff_t off_end;
> > @@ -2453,7 +2454,8 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
> >   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >   	struct f2fs_gc_control gc_control = { .victim_segno = NULL_SEGNO,
> >   			.no_bg_gc = false,
> > -			.should_migrate_blocks = false };
> > +			.should_migrate_blocks = false,
> > +			.nr_free_secs = 0 };
> >   	__u32 sync;
> >   	int ret;
> > @@ -2494,7 +2496,8 @@ static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
> >   			.init_gc_type = range->sync ? FG_GC : BG_GC,
> >   			.no_bg_gc = false,
> >   			.should_migrate_blocks = false,
> > -			.err_gc_skipped = range->sync };
> > +			.err_gc_skipped = range->sync,
> > +			.nr_free_secs = 0 };
> >   	u64 end;
> >   	int ret;
> > @@ -2940,7 +2943,8 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
> >   	struct f2fs_gc_control gc_control = {
> >   			.init_gc_type = FG_GC,
> >   			.should_migrate_blocks = true,
> > -			.err_gc_skipped = true };
> > +			.err_gc_skipped = true,
> > +			.nr_free_secs = 0 };
> >   	int ret;
> >   	if (!capable(CAP_SYS_ADMIN))
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index ec3f6f876e76..f63576ff1c2d 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -147,6 +147,7 @@ static int gc_thread_func(void *data)
> >   		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
> >   		gc_control.no_bg_gc = foreground;
> > +		gc_control.nr_free_secs = foreground ? 1 : 0;
> >   		/* if return value is not zero, no victim was selected */
> >   		if (f2fs_gc(sbi, &gc_control))
> > @@ -1776,6 +1777,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >   	unsigned int skipped_round = 0, round = 0;
> >   	trace_f2fs_gc_begin(sbi->sb, gc_type, gc_control->no_bg_gc,
> > +				gc_control->nr_free_secs,
> >   				get_pages(sbi, F2FS_DIRTY_NODES),
> >   				get_pages(sbi, F2FS_DIRTY_DENTS),
> >   				get_pages(sbi, F2FS_DIRTY_IMETA),
> > @@ -1848,11 +1850,12 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >   	if (gc_type == FG_GC)
> >   		sbi->cur_victim_sec = NULL_SEGNO;
> > -	if (gc_control->init_gc_type == FG_GC)
> > -		goto stop;
> > -
> > -	if (!has_not_enough_free_secs(sbi, sec_freed, 0))
> > +	if ((gc_control->init_gc_type == FG_GC ||
> > +			!has_not_enough_free_secs(sbi, sec_freed, 0))) {
> > +		if (sec_freed < gc_control->nr_free_secs)
> 
> I missed to reset segno here, it may cause GC failure in next round due to
> sec_usage_check() returns true.
> 
> segno = NULL_SEGNO;

Added. Thanks.

> 
> Thanks,
> 
> > +			goto gc_more;
> >   		goto stop;
> > +	}
> >   	if (skipped_round <= MAX_SKIP_GC_COUNT || skipped_round * 2 < round) {
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index bc63f0572c64..d6b9231ab0e1 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -528,7 +528,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
> >   				.init_gc_type = BG_GC,
> >   				.no_bg_gc = true,
> >   				.should_migrate_blocks = false,
> > -				.err_gc_skipped = false };
> > +				.err_gc_skipped = false,
> > +				.nr_free_secs = 1 };
> >   			f2fs_down_write(&sbi->gc_lock);
> >   			f2fs_gc(sbi, &gc_control);
> >   		}
> > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> > index 8b23fa6fc6b7..5d5b35067c3d 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2084,7 +2084,8 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
> >   			.victim_segno = NULL_SEGNO,
> >   			.init_gc_type = FG_GC,
> >   			.should_migrate_blocks = false,
> > -			.err_gc_skipped = true };
> > +			.err_gc_skipped = true,
> > +			.nr_free_secs = 1 };
> >   		f2fs_down_write(&sbi->gc_lock);
> >   		err = f2fs_gc(sbi, &gc_control);
> > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> > index 6699174977a3..349679a72301 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -653,18 +653,21 @@ TRACE_EVENT(f2fs_background_gc,
> >   TRACE_EVENT(f2fs_gc_begin,
> >   	TP_PROTO(struct super_block *sb, int gc_type, bool no_bg_gc,
> > +			unsigned int nr_free_secs,
> >   			long long dirty_nodes, long long dirty_dents,
> >   			long long dirty_imeta, unsigned int free_sec,
> >   			unsigned int free_seg, int reserved_seg,
> >   			unsigned int prefree_seg),
> > -	TP_ARGS(sb, gc_type, no_bg_gc, dirty_nodes, dirty_dents, dirty_imeta,
> > +	TP_ARGS(sb, gc_type, no_bg_gc, nr_free_secs, dirty_nodes,
> > +		dirty_dents, dirty_imeta,
> >   		free_sec, free_seg, reserved_seg, prefree_seg),
> >   	TP_STRUCT__entry(
> >   		__field(dev_t,		dev)
> >   		__field(int,		gc_type)
> >   		__field(bool,		no_bg_gc)
> > +		__field(unsigned int,	nr_free_secs)
> >   		__field(long long,	dirty_nodes)
> >   		__field(long long,	dirty_dents)
> >   		__field(long long,	dirty_imeta)
> > @@ -678,6 +681,7 @@ TRACE_EVENT(f2fs_gc_begin,
> >   		__entry->dev		= sb->s_dev;
> >   		__entry->gc_type	= gc_type;
> >   		__entry->no_bg_gc	= no_bg_gc;
> > +		__entry->nr_free_secs	= nr_free_secs;
> >   		__entry->dirty_nodes	= dirty_nodes;
> >   		__entry->dirty_dents	= dirty_dents;
> >   		__entry->dirty_imeta	= dirty_imeta;
> > @@ -687,12 +691,13 @@ TRACE_EVENT(f2fs_gc_begin,
> >   		__entry->prefree_seg	= prefree_seg;
> >   	),
> > -	TP_printk("dev = (%d,%d), gc_type = %s, no_background_GC = %d, nodes = %lld, "
> > -		"dents = %lld, imeta = %lld, free_sec:%u, free_seg:%u, "
> > +	TP_printk("dev = (%d,%d), gc_type = %s, no_background_GC = %d, nr_free_secs = %u, "
> > +		"nodes = %lld, dents = %lld, imeta = %lld, free_sec:%u, free_seg:%u, "
> >   		"rsv_seg:%d, prefree_seg:%u",
> >   		show_dev(__entry->dev),
> >   		show_gc_type(__entry->gc_type),
> >   		__entry->no_bg_gc,
> > +		__entry->nr_free_secs,
> >   		__entry->dirty_nodes,
> >   		__entry->dirty_dents,
> >   		__entry->dirty_imeta,
