Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C0A4A8A70
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 18:43:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353013AbiBCRma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 12:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242399AbiBCRm2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 12:42:28 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA9A3C061714
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 09:42:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6BEC8B83498
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 17:42:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D842C340E8;
        Thu,  3 Feb 2022 17:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643910145;
        bh=hi42ALnX9ZNQQ9Be9+mHS/um8jLPKbH4xkvdCxMsuZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lE/dfsrVwqEl4vqwi1NRpyUu1MaLV6/+TRgvqWd6dtt68H30vd1xFBOKIVRONa2Oj
         mnHWaWMkMyVTA1kelluN57kIBf5ZSGt4MK9nOZR9L6rzPqJGRnzmGEoXYK0FVceiCI
         JslM9cGJ51CwdtPNGJDfy7T4ZF3zdFPpERm9xn8RdPr0k62eKztiWh99uY7WwAk3L5
         av8HUYTSbQP5rkoxpge41F3z6fAzRzlhwSIBgfz2LEK5kWWYCqZ77w/22XniFBX3So
         DuITu78gg78306ZAhFxl9BMGv8R8Ty+63u2bwvVONVE582YCaj7z9FCU5YdTMd8WJ/
         hclbOYXvYFz3g==
Date:   Thu, 3 Feb 2022 09:42:23 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add a way to limit roll forward
 recovery time
Message-ID: <YfwT/6bSqUqUF/B3@google.com>
References: <20220127214102.2040254-1-jaegeuk@kernel.org>
 <YfsjEb2ii3eyPzng@google.com>
 <142d2cc9-73f2-f9fa-2543-6426c62e77a6@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <142d2cc9-73f2-f9fa-2543-6426c62e77a6@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/03, Chao Yu wrote:
> On 2022/2/3 8:34, Jaegeuk Kim wrote:
> > This adds a sysfs entry to call checkpoint during fsync() in order to avoid
> > long elapsed time to run roll-forward recovery when booting the device.
> > Default value doesn't enforce the limitation which is same as before.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> > v2 from v1:
> >   - make the default w/o enforcement
> > 
> >   Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
> >   fs/f2fs/checkpoint.c                    | 1 +
> >   fs/f2fs/f2fs.h                          | 3 +++
> >   fs/f2fs/node.c                          | 2 ++
> >   fs/f2fs/node.h                          | 3 +++
> >   fs/f2fs/recovery.c                      | 4 ++++
> >   fs/f2fs/sysfs.c                         | 2 ++
> >   7 files changed, 21 insertions(+)
> > 
> > diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
> > index 87d3884c90ea..ce8103f522cb 100644
> > --- a/Documentation/ABI/testing/sysfs-fs-f2fs
> > +++ b/Documentation/ABI/testing/sysfs-fs-f2fs
> > @@ -567,3 +567,9 @@ Contact:	"Daeho Jeong" <daehojeong@google.com>
> >   Description:	You can set the trial count limit for GC urgent high mode with this value.
> >   		If GC thread gets to the limit, the mode will turn back to GC normal mode.
> >   		By default, the value is zero, which means there is no limit like before.
> > +
> > +What:		/sys/fs/f2fs/<disk>/max_roll_forward_node_blocks
> > +Date:		January 2022
> > +Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
> > +Description:	Controls max # of node block writes to be used for roll forward
> > +		recovery. This can limit the roll forward recovery time.
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index deeda95688f0..57a2d9164bee 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -1543,6 +1543,7 @@ static int do_checkpoint(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> >   	/* update user_block_counts */
> >   	sbi->last_valid_block_count = sbi->total_valid_block_count;
> >   	percpu_counter_set(&sbi->alloc_valid_block_count, 0);
> > +	percpu_counter_set(&sbi->rf_node_block_count, 0);
> >   	/* Here, we have one bio having CP pack except cp pack 2 page */
> >   	f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_CP_META_IO);
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 63c90416364b..6ddb98ff0b7c 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -913,6 +913,7 @@ struct f2fs_nm_info {
> >   	nid_t max_nid;			/* maximum possible node ids */
> >   	nid_t available_nids;		/* # of available node ids */
> >   	nid_t next_scan_nid;		/* the next nid to be scanned */
> > +	nid_t max_rf_node_blocks;	/* max # of nodes for recovery */
> >   	unsigned int ram_thresh;	/* control the memory footprint */
> >   	unsigned int ra_nid_pages;	/* # of nid pages to be readaheaded */
> >   	unsigned int dirty_nats_ratio;	/* control dirty nats ratio threshold */
> > @@ -1684,6 +1685,8 @@ struct f2fs_sb_info {
> >   	atomic_t nr_pages[NR_COUNT_TYPE];
> >   	/* # of allocated blocks */
> >   	struct percpu_counter alloc_valid_block_count;
> > +	/* # of node block writes as roll forward recovery */
> > +	struct percpu_counter rf_node_block_count;
> >   	/* writeback control */
> >   	atomic_t wb_sync_req[META];	/* count # of WB_SYNC threads */
> > diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> > index 93512f8859d5..0d9883457579 100644
> > --- a/fs/f2fs/node.c
> > +++ b/fs/f2fs/node.c
> > @@ -1782,6 +1782,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
> >   			if (!atomic || page == last_page) {
> >   				set_fsync_mark(page, 1);
> > +				percpu_counter_inc(&sbi->rf_node_block_count);
> 
> if (NM_I(sbi)->max_rf_node_blocks)
> 	percpu_counter_inc(&sbi->rf_node_block_count);

I think we can just count this and adjust right away once sysfs is changed.

> 
> Thanks,
> 
> >   				if (IS_INODE(page)) {
> >   					if (is_inode_flag_set(inode,
> >   								FI_DIRTY_INODE))
> > @@ -3218,6 +3219,7 @@ static int init_node_manager(struct f2fs_sb_info *sbi)
> >   	nm_i->ram_thresh = DEF_RAM_THRESHOLD;
> >   	nm_i->ra_nid_pages = DEF_RA_NID_PAGES;
> >   	nm_i->dirty_nats_ratio = DEF_DIRTY_NAT_RATIO_THRESHOLD;
> > +	nm_i->max_rf_node_blocks = DEF_RF_NODE_BLOCKS;
> >   	INIT_RADIX_TREE(&nm_i->free_nid_root, GFP_ATOMIC);
> >   	INIT_LIST_HEAD(&nm_i->free_nid_list);
> > diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
> > index 18b98cf0465b..4c1d34bfea78 100644
> > --- a/fs/f2fs/node.h
> > +++ b/fs/f2fs/node.h
> > @@ -31,6 +31,9 @@
> >   /* control total # of nats */
> >   #define DEF_NAT_CACHE_THRESHOLD			100000
> > +/* control total # of node writes used for roll-fowrad recovery */
> > +#define DEF_RF_NODE_BLOCKS			0
> > +
> >   /* vector size for gang look-up from nat cache that consists of radix tree */
> >   #define NATVEC_SIZE	64
> >   #define SETVEC_SIZE	32
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index 10d152cfa58d..1c8041fd854e 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -53,9 +53,13 @@ extern struct kmem_cache *f2fs_cf_name_slab;
> >   bool f2fs_space_for_roll_forward(struct f2fs_sb_info *sbi)
> >   {
> >   	s64 nalloc = percpu_counter_sum_positive(&sbi->alloc_valid_block_count);
> > +	u32 rf_node = percpu_counter_sum_positive(&sbi->rf_node_block_count);
> >   	if (sbi->last_valid_block_count + nalloc > sbi->user_block_count)
> >   		return false;
> > +	if (NM_I(sbi)->max_rf_node_blocks &&
> > +			rf_node >= NM_I(sbi)->max_rf_node_blocks)
> > +		return false;
> >   	return true;
> >   }
> > diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> > index 281bc0133ee6..47efcf233afd 100644
> > --- a/fs/f2fs/sysfs.c
> > +++ b/fs/f2fs/sysfs.c
> > @@ -732,6 +732,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ssr_sections, min_ssr_sections);
> >   F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ram_thresh, ram_thresh);
> >   F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, ra_nid_pages, ra_nid_pages);
> >   F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, dirty_nats_ratio, dirty_nats_ratio);
> > +F2FS_RW_ATTR(NM_INFO, f2fs_nm_info, max_roll_forward_node_blocks, max_rf_node_blocks);
> >   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
> >   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, migration_granularity, migration_granularity);
> >   F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
> > @@ -855,6 +856,7 @@ static struct attribute *f2fs_attrs[] = {
> >   	ATTR_LIST(ram_thresh),
> >   	ATTR_LIST(ra_nid_pages),
> >   	ATTR_LIST(dirty_nats_ratio),
> > +	ATTR_LIST(max_roll_forward_node_blocks),
> >   	ATTR_LIST(cp_interval),
> >   	ATTR_LIST(idle_interval),
> >   	ATTR_LIST(discard_idle_interval),
