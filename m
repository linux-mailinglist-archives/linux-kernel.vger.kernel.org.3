Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECF1147FB60
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 10:39:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231665AbhL0JjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 04:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbhL0JjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 04:39:15 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9D6DC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:39:14 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id co15so13018502pjb.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Dec 2021 01:39:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0MTfeDrD4s6CQETZ+bCP0r0wHlG/QajpnwMYP0Ju9Yk=;
        b=f+YyA36S5zeXppUfS2VWgUe/F175DWEr/XNoe810Zv/09Rz/dNBMTt0ap6C8RKngiF
         UqgQ9UY3Beo6uUwCFWBjRDtHGaYpBQwIogzxEnKP9sEvrQL4ZWrOKgUjIKNHDnKnLtOz
         AN7I7e8ZzLzLr+bPRM3Dd64Zyj3U7HlKzPyyRt4IybmPzUFNSn8yBRjWXBx2OzeWp7iI
         paNDj3GKO+wKC+KYgDSZAzYAkEY4l4F5Jc4YI4um3bB+z3ifuu32rePQlojwTBTsH8W4
         o26eHGaN1d6bJZwG1OFwicGXcDFjZ5aqQUqHynqzx1h0pJzdkZ9I18YUq3XEs+L5WI3T
         b2kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0MTfeDrD4s6CQETZ+bCP0r0wHlG/QajpnwMYP0Ju9Yk=;
        b=m66EnUi26bpwJM6OfjM+LZdz+n0eQPLEuHHwpFGAQ8Lu0WhPDf9UVDIOwA7dnr0BUk
         ZUi4KarEYDR+e3YNuDRSmbXeQqTt2z9vXVqKVIaI0IjN49IWo01fa3T4tZwS19uz8Xyd
         mWA2HMEVU2g+PjQ/jN0Duyu750zpC9Cb7wFN0A76ZnUQxs73tcY+B+lQ6DbvgJO7Ith6
         NaZEqdjqab+hpaHQySguiLCe3m7zwbd0caHEnUpq2M651DCO/hpBwCzp7zW0/VXfRkOq
         CpnNGkjCgxa0is2098rU5bWOCuAsJkSCPvmnZv2ZXH838sGT/zBEJvv0QEyhHYkfjJs8
         hgzA==
X-Gm-Message-State: AOAM532qlzbGXP2doKEQN3rp4IfJ6/fJPrJwZahqZ+BJBrt6E6esnhPy
        SGNQT3VxX4p4AGr4vzuWe/4=
X-Google-Smtp-Source: ABdhPJy1knG3g+LLFd4JfNGwgBm+K4Fl6QjpYJ/gBaVCSj0XWop/wm9G8DCtrdUUycu2BVeGuvlAtA==
X-Received: by 2002:a17:90a:f402:: with SMTP id ch2mr19864336pjb.223.1640597954305;
        Mon, 27 Dec 2021 01:39:14 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id k70sm13800117pgd.19.2021.12.27.01.39.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 27 Dec 2021 01:39:14 -0800 (PST)
Date:   Mon, 27 Dec 2021 17:36:26 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Yue Hu <huyue2@yulong.com>,
        LKML <linux-kernel@vger.kernel.org>, geshifei@coolpad.com,
        zhangwen@coolpad.com, shaojunjun@coolpad.com
Subject: Re: [PATCH v3 4/5] erofs: support inline data decompression
Message-ID: <20211227173626.000036ee.zbestahu@gmail.com>
In-Reply-To: <YcmGwXlhx4n04Pf2@B-P7TQMD6M-0146.local>
References: <20211225070626.74080-1-hsiangkao@linux.alibaba.com>
        <20211225070626.74080-5-hsiangkao@linux.alibaba.com>
        <20211227161819.00000148.zbestahu@gmail.com>
        <YcmGwXlhx4n04Pf2@B-P7TQMD6M-0146.local>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Dec 2021 17:26:25 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> On Mon, Dec 27, 2021 at 04:18:19PM +0800, Yue Hu wrote:
> > Hi Xiang,
> > 
> > On Sat, 25 Dec 2021 15:06:25 +0800
> > Gao Xiang <hsiangkao@linux.alibaba.com> wrote:
> >   
> > > From: Yue Hu <huyue2@yulong.com>
> > > 
> > > Currently, we have already support tail-packing inline for
> > > uncompressed file, let's also implement this for compressed
> > > files to save I/Os and storage space.
> > > 
> > > Different from normal pclusters, compressed data is available
> > > in advance because of other metadata I/Os. Therefore, they
> > > directly move into the bypass queue without extra I/O submission.
> > > 
> > > It's the last compression feature before folio/subpage support.
> > > 
> > > Signed-off-by: Yue Hu <huyue2@yulong.com>
> > > Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > > ---
> > >  fs/erofs/zdata.c | 128 ++++++++++++++++++++++++++++++++---------------
> > >  fs/erofs/zdata.h |  24 ++++++++-
> > >  2 files changed, 109 insertions(+), 43 deletions(-)
> > > 
> > > diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> > > index bc765d8a6dc2..e6ef02634e08 100644
> > > --- a/fs/erofs/zdata.c
> > > +++ b/fs/erofs/zdata.c
> > > @@ -82,12 +82,13 @@ static struct z_erofs_pcluster *z_erofs_alloc_pcluster(unsigned int nrpages)
> > >  
> > >  static void z_erofs_free_pcluster(struct z_erofs_pcluster *pcl)
> > >  {
> > > +	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
> > >  	int i;
> > >  
> > >  	for (i = 0; i < ARRAY_SIZE(pcluster_pool); ++i) {
> > >  		struct z_erofs_pcluster_slab *pcs = pcluster_pool + i;
> > >  
> > > -		if (pcl->pclusterpages > pcs->maxpages)
> > > +		if (pclusterpages > pcs->maxpages)
> > >  			continue;
> > >  
> > >  		kmem_cache_free(pcs->slab, pcl);
> > > @@ -298,6 +299,7 @@ int erofs_try_to_free_all_cached_pages(struct erofs_sb_info *sbi,
> > >  		container_of(grp, struct z_erofs_pcluster, obj);
> > >  	int i;
> > >  
> > > +	DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
> > >  	/*
> > >  	 * refcount of workgroup is now freezed as 1,
> > >  	 * therefore no need to worry about available decompression users.
> > > @@ -331,6 +333,7 @@ int erofs_try_to_free_cached_page(struct page *page)
> > >  	if (erofs_workgroup_try_to_freeze(&pcl->obj, 1)) {
> > >  		unsigned int i;
> > >  
> > > +		DBG_BUGON(z_erofs_is_inline_pcluster(pcl));
> > >  		for (i = 0; i < pcl->pclusterpages; ++i) {
> > >  			if (pcl->compressed_pages[i] == page) {
> > >  				WRITE_ONCE(pcl->compressed_pages[i], NULL);
> > > @@ -458,6 +461,7 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
> > >  				       struct inode *inode,
> > >  				       struct erofs_map_blocks *map)
> > >  {
> > > +	bool ztailpacking = map->m_flags & EROFS_MAP_META;
> > >  	struct z_erofs_pcluster *pcl;
> > >  	struct z_erofs_collection *cl;
> > >  	struct erofs_workgroup *grp;
> > > @@ -469,12 +473,12 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
> > >  	}
> > >  
> > >  	/* no available pcluster, let's allocate one */
> > > -	pcl = z_erofs_alloc_pcluster(map->m_plen >> PAGE_SHIFT);
> > > +	pcl = z_erofs_alloc_pcluster(ztailpacking ? 1 :
> > > +				     map->m_plen >> PAGE_SHIFT);
> > >  	if (IS_ERR(pcl))
> > >  		return PTR_ERR(pcl);
> > >  
> > >  	atomic_set(&pcl->obj.refcount, 1);
> > > -	pcl->obj.index = map->m_pa >> PAGE_SHIFT;
> > >  	pcl->algorithmformat = map->m_algorithmformat;
> > >  	pcl->length = (map->m_llen << Z_EROFS_PCLUSTER_LENGTH_BIT) |
> > >  		(map->m_flags & EROFS_MAP_FULL_MAPPED ?
> > > @@ -494,16 +498,25 @@ static int z_erofs_register_collection(struct z_erofs_collector *clt,
> > >  	mutex_init(&cl->lock);
> > >  	DBG_BUGON(!mutex_trylock(&cl->lock));
> > >  
> > > -	grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
> > > -	if (IS_ERR(grp)) {
> > > -		err = PTR_ERR(grp);
> > > -		goto err_out;
> > > -	}
> > > +	if (ztailpacking) {
> > > +		pcl->obj.index = 0;	/* which indicates ztailpacking */
> > > +		pcl->pageofs_in = erofs_blkoff(map->m_pa);
> > > +		pcl->tailpacking_size = map->m_plen;
> > > +	} else {
> > > +		pcl->obj.index = map->m_pa >> PAGE_SHIFT;
> > >  
> > > -	if (grp != &pcl->obj) {
> > > -		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
> > > -		err = -EEXIST;
> > > -		goto err_out;
> > > +		grp = erofs_insert_workgroup(inode->i_sb, &pcl->obj);
> > > +		if (IS_ERR(grp)) {
> > > +			err = PTR_ERR(grp);
> > > +			goto err_out;
> > > +		}
> > > +
> > > +		if (grp != &pcl->obj) {
> > > +			clt->pcl = container_of(grp,
> > > +					struct z_erofs_pcluster, obj);
> > > +			err = -EEXIST;
> > > +			goto err_out;
> > > +		}
> > >  	}
> > >  	/* used to check tail merging loop due to corrupted images */
> > >  	if (clt->owned_head == Z_EROFS_PCLUSTER_TAIL)
> > > @@ -532,17 +545,20 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
> > >  	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_NIL);
> > >  	DBG_BUGON(clt->owned_head == Z_EROFS_PCLUSTER_TAIL_CLOSED);
> > >  
> > > -	if (!PAGE_ALIGNED(map->m_pa)) {
> > > -		DBG_BUGON(1);
> > > -		return -EINVAL;
> > > +	if (map->m_flags & EROFS_MAP_META) {
> > > +		if ((map->m_pa & ~PAGE_MASK) + map->m_plen > PAGE_SIZE) {
> > > +			DBG_BUGON(1);
> > > +			return -EFSCORRUPTED;
> > > +		}
> > > +		goto tailpacking;
> > >  	}
> > >  
> > >  	grp = erofs_find_workgroup(inode->i_sb, map->m_pa >> PAGE_SHIFT);
> > >  	if (grp) {
> > >  		clt->pcl = container_of(grp, struct z_erofs_pcluster, obj);
> > >  	} else {
> > > +tailpacking:
> > >  		ret = z_erofs_register_collection(clt, inode, map);
> > > -
> > >  		if (!ret)
> > >  			goto out;
> > >  		if (ret != -EEXIST)
> > > @@ -558,9 +574,9 @@ static int z_erofs_collector_begin(struct z_erofs_collector *clt,
> > >  out:
> > >  	z_erofs_pagevec_ctor_init(&clt->vector, Z_EROFS_NR_INLINE_PAGEVECS,
> > >  				  clt->cl->pagevec, clt->cl->vcnt);
> > > -
> > >  	/* since file-backed online pages are traversed in reverse order */
> > > -	clt->icpage_ptr = clt->pcl->compressed_pages + clt->pcl->pclusterpages;
> > > +	clt->icpage_ptr = clt->pcl->compressed_pages +
> > > +			z_erofs_pclusterpages(clt->pcl);
> > >  	return 0;
> > >  }
> > >  
> > > @@ -687,8 +703,26 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
> > >  	else
> > >  		cache_strategy = DONTALLOC;
> > >  
> > > -	preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> > > -				 cache_strategy, pagepool);
> > > +	if (z_erofs_is_inline_pcluster(clt->pcl)) {  
> > 
> > current cache_strategy is only for preload_compressed_pages(), so the cache_strategy should be
> > needless for inline branch.
> >   
> 
> Ok, you are right. will update.
> 
> > > +		struct page *mpage;
> > > +
> > > +		mpage = erofs_get_meta_page(inode->i_sb,
> > > +					    erofs_blknr(map->m_pa));  
> > 
> > could we just use the map->mpage directly if it's what we want(which is the most cases when test),
> > if not we erofs_get_meta_page()?  
> 
> Nope, I tend to avoid this since I will introduce a new subpage
> feature to clean up all erofs_get_meta_page() usage.
> 
> Not because we cannot do like this, just to avoid coupling and messy.

got it.

> 
> >   
> > > +		if (IS_ERR(mpage)) {
> > > +			err = PTR_ERR(mpage);
> > > +			erofs_err(inode->i_sb,
> > > +				  "failed to get inline page, err %d", err);
> > > +			goto err_out;
> > > +		}
> > > +		/* TODO: new subpage feature will get rid of it */
> > > +		unlock_page(mpage);
> > > +
> > > +		WRITE_ONCE(clt->pcl->compressed_pages[0], mpage);
> > > +		clt->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
> > > +	} else {
> > > +		preload_compressed_pages(clt, MNGD_MAPPING(sbi),
> > > +					 cache_strategy, pagepool);
> > > +	}
> > >  
> > >  hitted:
> > >  	/*
> > > @@ -844,6 +878,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > >  				       struct page **pagepool)
> > >  {
> > >  	struct erofs_sb_info *const sbi = EROFS_SB(sb);
> > > +	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
> > >  	struct z_erofs_pagevec_ctor ctor;
> > >  	unsigned int i, inputsize, outputsize, llen, nr_pages;
> > >  	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
> > > @@ -925,16 +960,15 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
> > >  	overlapped = false;
> > >  	compressed_pages = pcl->compressed_pages;
> > >  
> > > -	for (i = 0; i < pcl->pclusterpages; ++i) {
> > > +	for (i = 0; i < pclusterpages; ++i) {
> > >  		unsigned int pagenr;
> > >  
> > >  		page = compressed_pages[i];
> > > -
> > >  		/* all compressed pages ought to be valid */
> > >  		DBG_BUGON(!page);
> > > -		DBG_BUGON(z_erofs_page_is_invalidated(page));
> > >  
> > > -		if (!z_erofs_is_shortlived_page(page)) {
> > > +		if (!z_erofs_is_inline_pcluster(pcl) &&  
> > 
> > some inline checks may exist for noinline case if it's bigpcluster. And i understand the
> > behavior of ztailpacking page is differ from normal page. So better to branch them? moving
> > the inline check outside the for loop?   
> 
> The truth is that I really don't want to add any complexity of this code.
> Also it's my next target to clean up. But I would never separate
> ztailpacking cases alone....

got it.

> 
> Thanks,
> Gao Xiang

