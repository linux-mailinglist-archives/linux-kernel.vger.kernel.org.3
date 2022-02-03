Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DD314A8CD5
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 21:00:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353916AbiBCT7t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 14:59:49 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:51164 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiBCT7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 14:59:47 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CB0CEB83580
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 19:59:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71363C340E8;
        Thu,  3 Feb 2022 19:59:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643918385;
        bh=dou+5I9pbMU/xeR/7VvG7DSIRN8IgpRudJTeJooph/g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKw617YZQEGR6HYDK4cwRHvcrxayXi4h5c4WwzuezQ+Rz5YKi8shLs8mO2Tci+52i
         prnqJkb1zcn+98cUo0Akb8kTElLpNqlBLA+35n6phZowRTfZRt2haqTcdjcYdlB0+p
         ujFvaFJw0RRgsE+SEMmf1bYLyHcl2TS+4Ch/tA1pB7M3ArijR9AuZJbYPnqOQsV56q
         CaSZY41020DSneTyaogQPsCgZ8JwG0Cbdv5obDt+b/OaatAgOZsvZcpRiSkX7w1eFx
         MH5w3y/bSDIlHnOtU7EYv3C/c4CULhNjS/eE363zvqfzn3W3nC/VLw2wbPL6srg9Q+
         v34TsbgM8grmw==
Date:   Thu, 3 Feb 2022 11:59:44 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] f2fs: adjust readahead block number during recovery
Message-ID: <Yfw0MPPdDjSP6mxk@google.com>
References: <20220129082112.1814398-1-chao@kernel.org>
 <9d450a33-41eb-0caf-aba1-427c5ae547ed@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9d450a33-41eb-0caf-aba1-427c5ae547ed@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03, Chao Yu wrote:
> Jaegeuk, any comments on this patch?

Yea, looks good to me.

> 
> Thanks,
> 
> On 2022/1/29 16:21, Chao Yu wrote:
> > In a fragmented image, entries in dnode block list may locate in
> > incontiguous physical block address space, however, in recovery flow,
> > we will always readahead BIO_MAX_VECS size blocks, so in such case,
> > current readahead policy is low efficient, let's adjust readahead
> > window size dynamically based on consecutiveness of dnode blocks.
> > 
> > Signed-off-by: Chao Yu <chao@kernel.org>
> > ---
> >   fs/f2fs/checkpoint.c |  8 ++++++--
> >   fs/f2fs/f2fs.h       |  6 +++++-
> >   fs/f2fs/recovery.c   | 27 ++++++++++++++++++++++++---
> >   3 files changed, 35 insertions(+), 6 deletions(-)
> > 
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index 57a2d9164bee..203a1577942d 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -282,18 +282,22 @@ int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
> >   	return blkno - start;
> >   }
> > -void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index)
> > +void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index,
> > +							unsigned int ra_blocks)
> >   {
> >   	struct page *page;
> >   	bool readahead = false;
> > +	if (ra_blocks == RECOVERY_MIN_RA_BLOCKS)
> > +		return;
> > +
> >   	page = find_get_page(META_MAPPING(sbi), index);
> >   	if (!page || !PageUptodate(page))
> >   		readahead = true;
> >   	f2fs_put_page(page, 0);
> >   	if (readahead)
> > -		f2fs_ra_meta_pages(sbi, index, BIO_MAX_VECS, META_POR, true);
> > +		f2fs_ra_meta_pages(sbi, index, ra_blocks, META_POR, true);
> >   }
> >   static int __f2fs_write_meta_page(struct page *page,
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 5af415208488..1fa6b3f98a71 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -590,6 +590,9 @@ enum {
> >   /* number of extent info in extent cache we try to shrink */
> >   #define EXTENT_CACHE_SHRINK_NUMBER	128
> > +#define RECOVERY_MAX_RA_BLOCKS		BIO_MAX_VECS
> > +#define RECOVERY_MIN_RA_BLOCKS		1
> > +
> >   struct rb_entry {
> >   	struct rb_node rb_node;		/* rb node located in rb-tree */
> >   	union {
> > @@ -3655,7 +3658,8 @@ bool f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
> >   					block_t blkaddr, int type);
> >   int f2fs_ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
> >   			int type, bool sync);
> > -void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index);
> > +void f2fs_ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index,
> > +							unsigned int ra_blocks);
> >   long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
> >   			long nr_to_write, enum iostat_type io_type);
> >   void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type);
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index f69b685fb2b2..0b88d0ce284a 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -346,6 +346,19 @@ static int recover_inode(struct inode *inode, struct page *page)
> >   	return 0;
> >   }
> > +static unsigned int adjust_por_ra_blocks(struct f2fs_sb_info *sbi,
> > +				unsigned int ra_blocks, unsigned int blkaddr,
> > +				unsigned int next_blkaddr)
> > +{
> > +	if (blkaddr + 1 == next_blkaddr)
> > +		ra_blocks = min_t(unsigned int, RECOVERY_MIN_RA_BLOCKS,
> > +							ra_blocks * 2);
> > +	else if (next_blkaddr % sbi->blocks_per_seg)
> > +		ra_blocks = max_t(unsigned int, RECOVERY_MAX_RA_BLOCKS,
> > +							ra_blocks / 2);
> > +	return ra_blocks;
> > +}
> > +
> >   static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
> >   				bool check_only)
> >   {
> > @@ -353,6 +366,7 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
> >   	struct page *page = NULL;
> >   	block_t blkaddr;
> >   	unsigned int loop_cnt = 0;
> > +	unsigned int ra_blocks = RECOVERY_MAX_RA_BLOCKS;
> >   	unsigned int free_blocks = MAIN_SEGS(sbi) * sbi->blocks_per_seg -
> >   						valid_user_blocks(sbi);
> >   	int err = 0;
> > @@ -427,11 +441,14 @@ static int find_fsync_dnodes(struct f2fs_sb_info *sbi, struct list_head *head,
> >   			break;
> >   		}
> > +		ra_blocks = adjust_por_ra_blocks(sbi, ra_blocks, blkaddr,
> > +						next_blkaddr_of_node(page));
> > +
> >   		/* check next segment */
> >   		blkaddr = next_blkaddr_of_node(page);
> >   		f2fs_put_page(page, 1);
> > -		f2fs_ra_meta_pages_cond(sbi, blkaddr);
> > +		f2fs_ra_meta_pages_cond(sbi, blkaddr, ra_blocks);
> >   	}
> >   	return err;
> >   }
> > @@ -707,6 +724,7 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
> >   	struct page *page = NULL;
> >   	int err = 0;
> >   	block_t blkaddr;
> > +	unsigned int ra_blocks = RECOVERY_MAX_RA_BLOCKS;
> >   	/* get node pages in the current segment */
> >   	curseg = CURSEG_I(sbi, CURSEG_WARM_NODE);
> > @@ -718,8 +736,6 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
> >   		if (!f2fs_is_valid_blkaddr(sbi, blkaddr, META_POR))
> >   			break;
> > -		f2fs_ra_meta_pages_cond(sbi, blkaddr);
> > -
> >   		page = f2fs_get_tmp_page(sbi, blkaddr);
> >   		if (IS_ERR(page)) {
> >   			err = PTR_ERR(page);
> > @@ -762,9 +778,14 @@ static int recover_data(struct f2fs_sb_info *sbi, struct list_head *inode_list,
> >   		if (entry->blkaddr == blkaddr)
> >   			list_move_tail(&entry->list, tmp_inode_list);
> >   next:
> > +		ra_blocks = adjust_por_ra_blocks(sbi, ra_blocks, blkaddr,
> > +						next_blkaddr_of_node(page));
> > +
> >   		/* check next segment */
> >   		blkaddr = next_blkaddr_of_node(page);
> >   		f2fs_put_page(page, 1);
> > +
> > +		f2fs_ra_meta_pages_cond(sbi, blkaddr, ra_blocks);
> >   	}
> >   	if (!err)
> >   		f2fs_allocate_new_segments(sbi);
