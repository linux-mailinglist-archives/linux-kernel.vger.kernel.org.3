Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565674FC6B9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 23:26:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350049AbiDKV2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 17:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244205AbiDKV2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 17:28:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B07132064
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 14:26:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id F1EDBB818BA
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 21:25:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DBE5C385A3;
        Mon, 11 Apr 2022 21:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649712357;
        bh=oaC6xPOA91VUGaoXvosYsO/Y5SsYoSLeukkWMf5PPWo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gYTlHPebD2S8HWRv1gwLvHb3cRiKNtmbJohllz5TUEs8seoCehj7aDTXfgxceZ7mr
         E7jxCNrF7cDJDvXdlyqZ3g7f44hgyzKwptbzV25l0v9Su8Bf8gZUzZVGM9yxLAXDjj
         Z8CgC2nf5+xTP/qV5irizDIFmBKir6KyBNUYy40YTLF2oPBhGVeY42ABm9XVr3+MBP
         bghS2bQb2QdC6sX84lyLjzc5KKPD3ae9kgvOLAzVSV++KOHftLt1kg4wr+sh53Goh8
         V751MLHQn1yQ3O+EsO/hDg0wueXLqFuoOEihFW3UACC4AggxmYzm8Zpro8RBGmTTag
         YahvyE5GZlH3w==
Date:   Mon, 11 Apr 2022 14:25:55 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: give priority to select unpinned
 section for foreground GC
Message-ID: <YlSc4xJ54jE43VPp@google.com>
References: <20220406152651.5142-1-chao@kernel.org>
 <YlSNjgQwoiENx5EK@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlSNjgQwoiENx5EK@google.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/11, Jaegeuk Kim wrote:
> On 04/06, Chao Yu wrote:
> > Previously, during foreground GC, if victims contain data of pinned file,
> > it will fail migration of the data, and meanwhile i_gc_failures of that
> > pinned file may increase, and when it exceeds threshold, GC will unpin
> > the file, result in breaking pinfile's semantics.
> > 
> > In order to mitigate such condition, let's record and skip section which
> > has pinned file's data and give priority to select unpinned one.
> > 
> > Signed-off-by: Chao Yu <chao.yu@oppo.com>
> > ---
> > v3:
> > - check pin status before pinning section in pin_section().
> >  fs/f2fs/gc.c      | 56 ++++++++++++++++++++++++++++++++++++++++++++---
> >  fs/f2fs/segment.c |  7 ++++++
> >  fs/f2fs/segment.h |  2 ++
> >  3 files changed, 62 insertions(+), 3 deletions(-)
> > 
> > diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> > index 6a7e4148ff9d..df23824ae3c2 100644
> > --- a/fs/f2fs/gc.c
> > +++ b/fs/f2fs/gc.c
> > @@ -646,6 +646,37 @@ static void release_victim_entry(struct f2fs_sb_info *sbi)
> >  	f2fs_bug_on(sbi, !list_empty(&am->victim_list));
> >  }
> >  
> > +static void pin_section(struct f2fs_sb_info *sbi, unsigned int segno)
> 
> Need f2fs_...?
> 
> > +{
> > +	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> > +	unsigned int secno = GET_SEC_FROM_SEG(sbi, segno);
> > +
> > +	if (test_bit(secno, dirty_i->pinned_secmap))
> > +		return;
> > +	set_bit(secno, dirty_i->pinned_secmap);
> > +	dirty_i->pinned_secmap_cnt++;
> > +}
> > +
> > +static bool pinned_section_exists(struct dirty_seglist_info *dirty_i)
> > +{
> > +	return dirty_i->pinned_secmap_cnt;
> > +}
> > +
> > +static bool section_is_pinned(struct dirty_seglist_info *dirty_i,
> > +						unsigned int secno)
> > +{
> > +	return pinned_section_exists(dirty_i) &&
> > +			test_bit(secno, dirty_i->pinned_secmap);
> > +}
> > +
> > +static void unpin_all_sections(struct f2fs_sb_info *sbi)
> > +{
> > +	unsigned int bitmap_size = f2fs_bitmap_size(MAIN_SECS(sbi));
> > +
> > +	memset(DIRTY_I(sbi)->pinned_secmap, 0, bitmap_size);
> > +	DIRTY_I(sbi)->pinned_secmap_cnt = 0;
> > +}
> > +
> >  /*
> >   * This function is called from two paths.
> >   * One is garbage collection and the other is SSR segment selection.
> > @@ -787,6 +818,9 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
> >  		if (gc_type == BG_GC && test_bit(secno, dirty_i->victim_secmap))
> >  			goto next;
> >  
> > +		if (gc_type == FG_GC && section_is_pinned(dirty_i, secno))
> > +			goto next;
> > +
> >  		if (is_atgc) {
> >  			add_victim_entry(sbi, &p, segno);
> >  			goto next;
> > @@ -1202,8 +1236,10 @@ static int move_data_block(struct inode *inode, block_t bidx,
> >  	}
> >  
> >  	if (f2fs_is_pinned_file(inode)) {
> > -		if (gc_type == FG_GC)
> > +		if (gc_type == FG_GC) {
> >  			f2fs_pin_file_control(inode, true);
> > +			pin_section(F2FS_I_SB(inode), segno);
> 
> Do we need to check unpinning the inode?
> 			if (!f2fs_pin_file_control())
> 				f2fs_set_pin_section();
> 
> > +		}
> >  		err = -EAGAIN;
> >  		goto out;
> >  	}
> > @@ -1352,8 +1388,10 @@ static int move_data_page(struct inode *inode, block_t bidx, int gc_type,
> >  		goto out;
> >  	}
> >  	if (f2fs_is_pinned_file(inode)) {
> > -		if (gc_type == FG_GC)
> > +		if (gc_type == FG_GC) {
> >  			f2fs_pin_file_control(inode, true);
> > +			pin_section(F2FS_I_SB(inode), segno);
> > +		}
> >  		err = -EAGAIN;
> >  		goto out;
> >  	}
> > @@ -1485,6 +1523,7 @@ static int gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
> >  							gc_type == FG_GC) {
> >  				f2fs_pin_file_control(inode, true);
> >  				iput(inode);
> > +				pin_section(sbi, segno);
> 
> We don't have this code.

Ok, you added this in other patch.

> 
> >  				return submitted;
> >  			}
> >  
> > @@ -1766,9 +1805,17 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  		ret = -EINVAL;
> >  		goto stop;
> >  	}
> > +retry:
> >  	ret = __get_victim(sbi, &segno, gc_type);
> > -	if (ret)
> > +	if (ret) {
> > +		/* allow to search victim from sections has pinned data */
> > +		if (ret == -ENODATA && gc_type == FG_GC &&
> > +				pinned_section_exists(DIRTY_I(sbi))) {
> > +			unpin_all_sections(sbi);
> > +			goto retry;
> > +		}
> >  		goto stop;
> > +	}
> >  
> >  	seg_freed = do_garbage_collect(sbi, segno, &gc_list, gc_type, force);
> >  	if (gc_type == FG_GC &&
> > @@ -1811,6 +1858,9 @@ int f2fs_gc(struct f2fs_sb_info *sbi, bool sync,
> >  	SIT_I(sbi)->last_victim[ALLOC_NEXT] = 0;
> >  	SIT_I(sbi)->last_victim[FLUSH_DEVICE] = init_segno;
> >  
> > +	if (gc_type == FG_GC && pinned_section_exists(DIRTY_I(sbi)))
> > +		unpin_all_sections(sbi);
> > +
> >  	trace_f2fs_gc_end(sbi->sb, ret, total_freed, sec_freed,
> >  				get_pages(sbi, F2FS_DIRTY_NODES),
> >  				get_pages(sbi, F2FS_DIRTY_DENTS),
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 012524db7437..1c20d7c9eca3 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -4736,6 +4736,12 @@ static int init_victim_secmap(struct f2fs_sb_info *sbi)
> >  	dirty_i->victim_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
> >  	if (!dirty_i->victim_secmap)
> >  		return -ENOMEM;
> > +
> > +	dirty_i->pinned_secmap = f2fs_kvzalloc(sbi, bitmap_size, GFP_KERNEL);
> > +	if (!dirty_i->pinned_secmap)
> > +		return -ENOMEM;
> > +
> > +	dirty_i->pinned_secmap_cnt = 0;
> >  	return 0;
> >  }
> >  
> > @@ -5324,6 +5330,7 @@ static void destroy_victim_secmap(struct f2fs_sb_info *sbi)
> >  {
> >  	struct dirty_seglist_info *dirty_i = DIRTY_I(sbi);
> >  
> > +	kvfree(dirty_i->pinned_secmap);
> >  	kvfree(dirty_i->victim_secmap);
> >  }
> >  
> > diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> > index 5c94caf0c0a1..fd6f246e649c 100644
> > --- a/fs/f2fs/segment.h
> > +++ b/fs/f2fs/segment.h
> > @@ -294,6 +294,8 @@ struct dirty_seglist_info {
> >  	struct mutex seglist_lock;		/* lock for segment bitmaps */
> >  	int nr_dirty[NR_DIRTY_TYPE];		/* # of dirty segments */
> >  	unsigned long *victim_secmap;		/* background GC victims */
> > +	unsigned long *pinned_secmap;		/* pinned victims from foreground GC */
> > +	unsigned int pinned_secmap_cnt;		/* count of victims which has pinned data */
> >  };
> >  
> >  /* victim selection function for cleaning and SSR */
> > -- 
> > 2.32.0
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
