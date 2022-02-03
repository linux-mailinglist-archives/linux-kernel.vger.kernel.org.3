Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727E84A7CE7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 01:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348591AbiBCAdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 19:33:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237009AbiBCAdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 19:33:41 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81EAC061714
        for <linux-kernel@vger.kernel.org>; Wed,  2 Feb 2022 16:33:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 75D6860C3E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Feb 2022 00:33:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9F56C004E1;
        Thu,  3 Feb 2022 00:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643848419;
        bh=e+HdgRopwn2UhqdtWJTca6uBltLijXlvPOkk7ZodF8M=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WdXHoDdVlqUY6OBcFNFMZB3VyWvoopTJkRRKw3PD/53QOv9AsBSkhvhh9qBPHhQhm
         ALmOJYoWVQmSYDGPXPQ/ZxJKD7dBIGRcLenyHaTQN0TKpEFgDgQ/oOixg91hdjVl1I
         P2h7afY04Cdf3KeMTDc6OARyOeBXjR+WUyUwO0Z7TwqRUVlDUqw6VnsejdFCFZgHRq
         6d382ATutlmX0GO99atvh8vgQxNefDqh95gBlI2SD+30Mx9P32GMo6cVrxcEWr1GAR
         S9aZ+2+MPBhNpcHH3Rt0QVh0uxteG02pOtve1i6rhixujCejUyN0FV/6i83xjn83pt
         LDDabeVOHKhdw==
Date:   Wed, 2 Feb 2022 16:33:38 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Chao Yu <chao@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: add a way to limit roll forward
 recovery time
Message-ID: <Yfsi4hvdnLWGEZDB@google.com>
References: <20220127214102.2040254-1-jaegeuk@kernel.org>
 <63cd175a-d2ae-7808-a894-4fd57cc4fce0@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63cd175a-d2ae-7808-a894-4fd57cc4fce0@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/29, Chao Yu wrote:
> On 2022/1/28 5:41, Jaegeuk Kim wrote:
> > This adds a sysfs entry to call checkpoint during fsync() in order to avoid
> > long elapsed time to run roll-forward recovery when booting the device.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >   Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
> >   fs/f2fs/checkpoint.c                    | 1 +
> >   fs/f2fs/f2fs.h                          | 3 +++
> >   fs/f2fs/node.c                          | 2 ++
> >   fs/f2fs/node.h                          | 3 +++
> >   fs/f2fs/recovery.c                      | 3 +++
> >   fs/f2fs/sysfs.c                         | 2 ++
> >   7 files changed, 20 insertions(+)
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
> > index 18b98cf0465b..fe56fd29c0d3 100644
> > --- a/fs/f2fs/node.h
> > +++ b/fs/f2fs/node.h
> > @@ -31,6 +31,9 @@
> >   /* control total # of nats */
> >   #define DEF_NAT_CACHE_THRESHOLD			100000
> > +/* control total # of node writes used for roll-fowrad recovery */
> > +#define DEF_RF_NODE_BLOCKS			100
> 
> Will we suffer performance regression issue in some scenarios in where user triggers
> fsync/fdatasync frequently? e.g. performance test.
> 
> If this issue is a corner case, it's better to increase DEF_RF_NODE_BLOCKS to
> avoid affecting common case AMSP?

I got one report only. So, let me try to keep as is by default. (ref. v2)

> 
> Thanks,
> 
> > +
> >   /* vector size for gang look-up from nat cache that consists of radix tree */
> >   #define NATVEC_SIZE	64
> >   #define SETVEC_SIZE	32
> > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> > index 10d152cfa58d..f69b685fb2b2 100644
> > --- a/fs/f2fs/recovery.c
> > +++ b/fs/f2fs/recovery.c
> > @@ -53,9 +53,12 @@ extern struct kmem_cache *f2fs_cf_name_slab;
> >   bool f2fs_space_for_roll_forward(struct f2fs_sb_info *sbi)
> >   {
> >   	s64 nalloc = percpu_counter_sum_positive(&sbi->alloc_valid_block_count);
> > +	u32 rf_node = percpu_counter_sum_positive(&sbi->rf_node_block_count);
> >   	if (sbi->last_valid_block_count + nalloc > sbi->user_block_count)
> >   		return false;
> > +	if (rf_node >= NM_I(sbi)->max_rf_node_blocks)
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
