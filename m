Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 433A3528BFE
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 19:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344286AbiEPR3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 13:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbiEPR3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 13:29:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98D336B43
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 10:29:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EB3C612B9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 17:29:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2943C385AA;
        Mon, 16 May 2022 17:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652722145;
        bh=0lhwBcj8jh6H1Y/I/vkWTZnz3qTYaoEcznl+3wunXeI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FfIlbs5U/M6U51e5xOmI+zMP+ADedQ4ALui5nD9yTjezNik1b2crhhbfMRIONW1Z8
         JU5CRUoPnjPFQkS0668tHqitVeoOjOqTQHNv0F1qvdCVxjr/BVxzssMDzQTYxdZpDe
         Pn52cO26crQWeyFEyPEfvYUlSBuByvatpm63DVDgyvUsL9jnuDfo2ECr/kohEtYKh6
         gs1EUtaNFMHLoa8AilM78+4N+HwewMJmgN9E707HyHc+UkLUdsBouELVAEYV2BOcpS
         W1myHqvKxGXPNcrMQ9UpcZjYNToQwMVPs7qKMi/qUpgODOv0+VuWaBOY0bMGaURJ1z
         KeBrBDH/YYdzg==
Date:   Mon, 16 May 2022 10:29:04 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH 4/5 v2] f2fs: do not stop GC when requiring a
 free section
Message-ID: <YoKJ4MSoZqVWiYxG@google.com>
References: <20220506232032.1264078-1-jaegeuk@kernel.org>
 <20220506232032.1264078-4-jaegeuk@kernel.org>
 <Yn1zC6MUZOEbSlWK@google.com>
 <c4a1b40f-469c-8e27-5fef-cd0d3ccd0089@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4a1b40f-469c-8e27-5fef-cd0d3ccd0089@kernel.org>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/15, Chao Yu wrote:
> On 2022/5/13 4:50, Jaegeuk Kim wrote:
> > The f2fs_gc uses a bitmap to indicate pinned sections, but when disabling
> > chckpoint, we call f2fs_gc() with NULL_SEGNO which selects the same dirty
> > segment as a victim all the time, resulting in checkpoint=disable failure,
> > for example. Let's pick another one, if we fail to collect it.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > 
> >   Change log from v1:
> >    - refactor the code path to avoid ambiguous condition like BG_GC/sec_freed
> > 
> >   fs/f2fs/f2fs.h              |  1 +
> >   fs/f2fs/file.c              | 12 ++++++++----
> >   fs/f2fs/gc.c                | 14 +++++++++-----
> >   fs/f2fs/segment.c           |  3 ++-
> >   fs/f2fs/super.c             |  3 ++-
> >   include/trace/events/f2fs.h | 11 ++++++++---
> >   6 files changed, 30 insertions(+), 14 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 9920b2d6af8f..492af5b96de1 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -1271,6 +1271,7 @@ struct f2fs_gc_control {
> >   	bool no_bg_gc;			/* check the space and stop bg_gc */
> >   	bool should_migrate_blocks;	/* should migrate blocks */
> >   	bool err_gc_skipped;		/* return EAGAIN if GC skipped */
> > +	unsigned int nr_free_secs;	/* # of free sections to do GC */
> >   };
> >   /* For s_flag in struct f2fs_sb_info */
> > diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> > index d0547bef0851..216081ea8c81 100644
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
> > @@ -2350,7 +2351,8 @@ static int f2fs_ioc_gc(struct file *filp, unsigned long arg)
> >   	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
> >   	struct f2fs_gc_control gc_control = { .victim_segno = NULL_SEGNO,
> >   			.no_bg_gc = false,
> > -			.should_migrate_blocks = false };
> > +			.should_migrate_blocks = false,
> > +			.nr_free_secs = 0 };
> >   	__u32 sync;
> >   	int ret;
> > @@ -2391,7 +2393,8 @@ static int __f2fs_ioc_gc_range(struct file *filp, struct f2fs_gc_range *range)
> >   			.init_gc_type = range->sync ? FG_GC : BG_GC,
> >   			.no_bg_gc = false,
> >   			.should_migrate_blocks = false,
> > -			.err_gc_skipped = range->sync };
> > +			.err_gc_skipped = range->sync,
> > +			.nr_free_secs = 0 };
> >   	u64 end;
> >   	int ret;
> > @@ -2837,7 +2840,8 @@ static int f2fs_ioc_flush_device(struct file *filp, unsigned long arg)
> >   	struct f2fs_gc_control gc_control = {
> >   			.init_gc_type = FG_GC,
> >   			.should_migrate_blocks = true,
> > -			.err_gc_skipped = true };
> > +			.err_gc_skipped = true,
> > +			.nr_free_secs = 0 };
> >   	int ret;
> >   	if (!capable(CAP_SYS_ADMIN))
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index e275b72bc65f..10b24b0f13a5 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -147,6 +147,7 @@ static int gc_thread_func(void *data)
> >   		gc_control.init_gc_type = sync_mode ? FG_GC : BG_GC;
> >   		gc_control.no_bg_gc = foreground;
> > +		gc_control.nr_free_secs = foreground ? 1 : 0;
> >   		/* if return value is not zero, no victim was selected */
> >   		if (f2fs_gc(sbi, &gc_control))
> > @@ -1761,6 +1762,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >   	unsigned int skipped_round = 0, round = 0;
> >   	trace_f2fs_gc_begin(sbi->sb, gc_type, gc_control->no_bg_gc,
> > +				gc_control->nr_free_secs,
> >   				get_pages(sbi, F2FS_DIRTY_NODES),
> >   				get_pages(sbi, F2FS_DIRTY_DENTS),
> >   				get_pages(sbi, F2FS_DIRTY_IMETA),
> > @@ -1823,12 +1825,13 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >   	if (gc_type == FG_GC)
> >   		sbi->cur_victim_sec = NULL_SEGNO;
> > -	if (gc_control->init_gc_type == FG_GC)
> > -		goto stop;
> > -
> > -	if (!has_not_enough_free_secs(sbi,
> > -			(gc_type == FG_GC) ? sec_freed : 0, 0))
> > +	if (gc_control->init_gc_type == FG_GC ||
> > +	    !has_not_enough_free_secs(sbi,
> > +				(gc_type == FG_GC) ? sec_freed : 0, 0)) {
> 
> In all gc_control->init_gc_type = BG_GC cases, gc_control->no_bg_gc is true,
> if gc_type = BG_GC, then it should break out due to below condition.
> 
> 	/* f2fs_balance_fs doesn't need to do BG_GC in critical path. */
> 	if (gc_type == BG_GC && gc_control->no_bg_gc) {
> 		ret = -EINVAL;
> 		goto stop;
> 	}
> 
> Otherwise gc_type should always be FG_GC in
> !has_not_enough_free_secs(sbi, (gc_type == FG_GC) ? sec_freed : 0, 0), right?

We can have gc_type=BG_GC and gc_control->no_bg_gc=false, which is a normal
background GC path.

> 
> Thanks,
> 
> > +		if (gc_mode == FG_GC && sec_freed < gc_control->nr_free_secs)
> > +			goto go_gc_more;
> >   		goto stop;
> > +	}
> >   	/* FG_GC stops GC by skip_count */
> >   	if (gc_type == FG_GC) {
> > @@ -1849,6 +1852,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
> >   		if (ret)
> >   			goto stop;
> >   	}
> > +go_gc_more:
> >   	segno = NULL_SEGNO;
> >   	goto gc_more;
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 8b4f2b1d2cca..0a4180f64291 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -404,7 +404,8 @@ void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
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
> > index a28c27eed6d0..63daae67a9d9 100644
> > --- a/fs/f2fs/super.c
> > +++ b/fs/f2fs/super.c
> > @@ -2080,7 +2080,8 @@ static int f2fs_disable_checkpoint(struct f2fs_sb_info *sbi)
> >   			.victim_segno = NULL_SEGNO,
> >   			.init_gc_type = FG_GC,
> >   			.should_migrate_blocks = false,
> > -			.err_gc_skipped = true };
> > +			.err_gc_skipped = true,
> > +			.nr_free_secs = 1 };
> >   		f2fs_down_write(&sbi->gc_lock);
> >   		err = f2fs_gc(sbi, &gc_control);
> > diff --git a/include/trace/events/f2fs.h b/include/trace/events/f2fs.h
> > index 54ec9e543f09..16c67ede85b6 100644
> > --- a/include/trace/events/f2fs.h
> > +++ b/include/trace/events/f2fs.h
> > @@ -645,18 +645,21 @@ TRACE_EVENT(f2fs_background_gc,
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
> > @@ -670,6 +673,7 @@ TRACE_EVENT(f2fs_gc_begin,
> >   		__entry->dev		= sb->s_dev;
> >   		__entry->gc_type	= gc_type;
> >   		__entry->no_bg_gc	= no_bg_gc;
> > +		__entry->nr_free_secs	= nr_free_secs;
> >   		__entry->dirty_nodes	= dirty_nodes;
> >   		__entry->dirty_dents	= dirty_dents;
> >   		__entry->dirty_imeta	= dirty_imeta;
> > @@ -679,12 +683,13 @@ TRACE_EVENT(f2fs_gc_begin,
> >   		__entry->prefree_seg	= prefree_seg;
> >   	),
> > -	TP_printk("dev = (%d,%d), gc_type = %s, no_background_GC = %d, nodes = %lld, "
> > -		"dents = %lld, imeta = %lld, free_sec:%u, free_seg:%u, "
> > +	TP_printk("dev = (%d,%d), gc_type = %s, no_background_GC = %d, nr_free_secs = %u, "
> > +		"nodes = %lld, dents = %lld, imeta = %lld, free_sec:%u, free_seg:%u, "
> >   		"rsv_seg:%d, prefree_seg:%u",
> >   		show_dev(__entry->dev),
> >   		show_gc_type(__entry->gc_type),
> >   		(__entry->gc_type == BG_GC) ? __entry->no_bg_gc : -1,
> > +		__entry->nr_free_secs,
> >   		__entry->dirty_nodes,
> >   		__entry->dirty_dents,
> >   		__entry->dirty_imeta,
