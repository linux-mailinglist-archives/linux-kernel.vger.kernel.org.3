Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9555447FB4D
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233180AbhL0J0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:26:31 -0500
Received: from out30-54.freemail.mail.aliyun.com ([115.124.30.54]:41750 "EHLO
        out30-54.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229652AbhL0J0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:26:30 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04426;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0V.tz5g1_1640597185;
Received: from B-P7TQMD6M-0146.local(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0V.tz5g1_1640597185)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 27 Dec 2021 17:26:27 +0800
Date:   Mon, 27 Dec 2021 17:26:25 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     Yue Hu <zbestahu@gmail.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@yulong.com>,
        LKML <linux-kernel@vger.kernel.org>, geshifei@coolpad.com,
        zhangwen@coolpad.com, shaojunjun@coolpad.com
Subject: Re: [PATCH v3 4/5] erofs: support inline data decompression
Message-ID: <YcmGwXlhx4n04Pf2@B-P7TQMD6M-0146.local>
References: <20211225070626.74080-1-hsiangkao@linux.alibaba.com>
 <20211225070626.74080-5-hsiangkao@linux.alibaba.com>
 <20211227161819.00000148.zbestahu@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211227161819.00000148.zbestahu@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 27, 2021 at 04:18:19PM +0800, Yue Hu wrote:
> Hi Xiang,
> 
> On Sat, 25 Dec 2021 15:06:25 +0800
> Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> 
> > From: Yue Hu <huyue2@yulong.com>
> > 
> > Currently, we have already support tail-packing inline for
> > uncompressed file, let's also implement this for compressed
> > files to save I/Os and storage space.
> > 
> > Different from normal pclusters, compressed data is available
> > in advance because of other metadata I/Os. Therefore, they
> > directly move into the bypass queue without extra I/O submission.
> > 
> > It's the last compression feature before folio/subpage support.
> > 
> > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > ---
> >  fs/erofs/zdata.c | 128 ++++++++++++++++++++++++++++++++---------------
> >  fs/erofs/zdata.h |  24 ++++++++-
> >  2 files changed, 109 insertions(+), 43 deletions(-)
> > 
> > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > index bc765d8a6dc2..e6ef02634e08 100644
> > --- a/fs/erofs/zdata.c
> > +++ b/fs/erofs/zdata.c
> > @@ -82,12 +82,13 @@ static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int nrpages)
> >  
> >  static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
> >  {
> > +	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
> >  	int i;
> >  
> >  	for (i = 0; i < ARRAY_SIZE(pcluster_pool); ++i) {
> >  		struct z_erofs_pcluster_slab *pcs = pcluster_pool + i;
> >  
> > -		if (pcl->pclusterpages > pcs->maxpages)
> > +		if (pclusterpages > pcs->maxpages)
> >  			continue;
> >  
> >  		kmem_cache_free(pcs->slab, pcl);
> > @@ -298,6 +299,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
> >  		container_of(grp, struct z_erofs_pcluster, obj);
> >  	int i;
> >  
> > +	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
> >  	/*
> >  	 * refcount of workgroup is now freezed as 1,
> >  	 * therefore no need to worry about available decompression users.
> > @@ -331,6 +333,7 @@ int erofs_try_to_free_cached_page(struct page *page)
> >  	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
> >  		unsigned int i;
> >  
> > +		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
> >  		for (i = 0; i < pcl->pclusterpages; ++i) {
> >  			if (pcl->compressed_pages[i] == page) {
> >  				WRITE_ONCE(pcl->compressed_pages[i], NULL);
> > @@ -458,6 +461,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
> >  				       struct inode *inode,
> >  				       struct erofs_map_blocks *map)
> >  {
> > +	bool ztailpacking = map->m_flags & EROFS_MAP_META;
> >  	struct z_erofs_pcluster *pcl;
> >  	struct z_erofs_collection *cl;
> >  	struct erofs_workgroup *grp;
> > @@ -469,12 +473,12 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
> >  	}
> >  
> >  	/* no available pcluster, let's allocate one */
> > -	pcl = z_erofs_alloc_pcluster(map->m_plen >> PAGE_SHIFT);
> > +	pcl = z_erofs_alloc_pcluster(ztailpacking ? 1 :
> > +				     map->m_plen >> PAGE_SHIFT);
> >  	if (IS_ERR(pcl))
> >  		return PTR_ERR(pcl);
> >  
> >  	atomic_set(&pcl->obj.refcount, 1);
> > -	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
> >  	pcl->algorithmformat = map->m_algorithmformat;
> >  	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
> >  		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
> > @@ -494,16 +498,25 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
> >  	mutex_init(&cl->lock);
> >  	DBG_BUGON(!mutex_trylock(&cl->lock));
> >  
> > -	grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
> > -	if (IS_ERR(grp)) {
> > -		err = PTR_ERR(grp);
> > -		goto err_out;
> > -	}
> > +	if (ztailpacking) {
> > +		pcl->obj.index = 0;	/* which indicates ztailpacking */
> > +		pcl->pageofs_in = erofs_blkoff(map->m_pa);
> > +		pcl->tailpacking_size = map->m_plen;
> > +	} else {
> > +		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
> >  
> > -	if (grp != &pcl->obj) {
> > -		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
> > -		err = -EEXIST;
> > -		goto err_out;
> > +		grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
> > +		if (IS_ERR(grp)) {
> > +			err = PTR_ERR(grp);
> > +			goto err_out;
> > +		}
> > +
> > +		if (grp != &pcl->obj) {
> > +			clt->pcl = container_of(grp,
> > +					struct z_erofs_pcluster, obj);
> > +			err = -EEXIST;
> > +			goto err_out;
> > +		}
> >  	}
> >  	/* used to check tail merging loop due to corrupted images */
> >  	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
> > @@ -532,17 +545,20 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
> >  	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
> >  	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
> >  
> > -	if (!PAGE_ALIGNED(map->m_pa)) {
> > -		DBG_BUGON(1);
> > -		return -EINVAL;
> > +	if (map->m_flags & EROFS_MAP_META) {
> > +		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> > +			DBG_BUGON(1);
> > +			return -EFSCORRUPTED;
> > +		}
> > +		goto tailpacking;
> >  	}
> >  
> >  	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
> >  	if (grp) {
> >  		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
> >  	} else {
> > +tailpacking:
> >  		ret = z_erofs_register_collection(clt, inode, map);
> > -
> >  		if (!ret)
> >  			goto out;
> >  		if (ret != -EEXIST)
> > @@ -558,9 +574,9 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
> >  out:
> >  	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
> >  				  clt->cl->pagevec, clt->cl->vcnt);
> > -
> >  	/* since file-backed online pages are traversed in reverse order */
> > -	clt->icpage_ptr = clt->pcl->compressed_pages + clt->pcl->pclusterpages;
> > +	clt->icpage_ptr = clt->pcl->compressed_pages +
> > +			z_erofs_pclusterpages(clt->pcl);
> >  	return 0;
> >  }
> >  
> > @@ -687,8 +703,26 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> >  	else
> >  		cache_strategy = DONTALLOC;
> >  
> > -	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> > -				 cache_strategy, pagepool);
> > +	if (z_erofs_is_inline_pcluster(clt->pcl)) {
> 
> current cache_strategy is only for preload_compressed_pages(), so the cache_strategy should be
> needless for inline branch.
> 

Ok, you are right. will update.

> > +		struct page *mpage;
> > +
> > +		mpage = erofs_get_meta_page(inode->i_sb,
> > +					    erofs_blknr(map->m_pa));
> 
> could we just use the map->mpage directly if it's what we want(which is the most cases when test),
> if not we erofs_get_meta_page()?

Nope, I tend to avoid this since I will introduce a new subpage
feature to clean up all erofs_get_meta_page() usage.

Not because we cannot do like this, just to avoid coupling and messy.

> 
> > +		if (IS_ERR(mpage)) {
> > +			err = PTR_ERR(mpage);
> > +			erofs_err(inode->i_sb,
> > +				  "failed to get inline page, err %d", err);
> > +			goto err_out;
> > +		}
> > +		/* TODO: new subpage feature will get rid of it */
> > +		unlock_page(mpage);
> > +
> > +		WRITE_ONCE(clt->pcl->compressed_pages[0], mpage);
> > +		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
> > +	} else {
> > +		preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> > +					 cache_strategy, pagepool);
> > +	}
> >  
> >  hitted:
> >  	/*
> > @@ -844,6 +878,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> >  				       struct page **pagepool)
> >  {
> >  	struct erofs_sb_info *const sbi = EROFS_SB(sb);
> > +	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
> >  	struct z_erofs_pagevec_ctor ctor;
> >  	unsigned int i, inputsize, outputsize, llen, nr_pages;
> >  	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
> > @@ -925,16 +960,15 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> >  	overlapped = false;
> >  	compressed_pages = pcl->compressed_pages;
> >  
> > -	for (i = 0; i < pcl->pclusterpages; ++i) {
> > +	for (i = 0; i < pclusterpages; ++i) {
> >  		unsigned int pagenr;
> >  
> >  		page = compressed_pages[i];
> > -
> >  		/* all compressed pages ought to be valid */
> >  		DBG_BUGON(!page);
> > -		DBG_BUGON(z_erofs_page_is_invalidated(page));
> >  
> > -		if (!z_erofs_is_shortlived_page(page)) {
> > +		if (!z_erofs_is_inline_pcluster(pcl) &&
> 
> some inline checks may exist for noinline case if it's bigpcluster. And i understand the
> behavior of ztailpacking page is differ from normal page. So better to branch them? moving
> the inline check outside the for loop? 

The truth is that I really don't want to add any complexity of this code.
Also it's my next target to clean up. But I would never separate
ztailpacking cases alone....

Thanks,
Gao Xiang
