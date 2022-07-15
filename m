Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3446575B86
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230480AbiGOG2L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:28:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiGOG2I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:28:08 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4138E2619
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:28:07 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id c3so2941037pfb.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8kmi8AfLRusjbPaMpL/XvEdRcnYGR/Uxs4EIkcVdWhs=;
        b=p+6Sw8Japq791+36CCQAPQERuxAZqGewtsXIDyh5Qc+hIAuG4lJSw7yxzX/9EEmcwp
         NLt+6YodSGKme8Zv6b/a0qljGt2c9N869UhgKKpMY3SaJf8T5j+dkIxp9IwaSLTGvqn5
         MeFCGbOD7GokvzxrxYNdSIWZyPdmQ2Arjih9nkuwSpZo4umgcL7/Ko8irrpnpkZdpyoQ
         44QHSeIzsVYgmqMAWhpe0J7152sBnD3GyrN5pBEbvMu8FyM2dBLuQAKxqAPTk0IDBnFr
         PMihxwv+779jqXyUuoaB9VKRsOTCcUlMF7dY7MfLbf+rWWCLy7zPXmD3b1eUC3naxiwB
         WBuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8kmi8AfLRusjbPaMpL/XvEdRcnYGR/Uxs4EIkcVdWhs=;
        b=S65jYuhCJceu2ozeRNoQx91Q9eFYk5RU1Msp83ImMSAPR6/IksHVLZD0kHkWm3n3TB
         +gGPJUElqddaBdmxQXc9n+FkwdPhAPbHDDbTU5OlVRnJ0yYnietrdryzaDQGFK3OV7zb
         8OebQHBPnO8xKGM2FweRR9YTdBii2cVHxyHcCm+zyfCU9NQRz7EQ4b5rs55BP3l1jqfJ
         emIE0sIv6k1ItbHh1c1GdQGoR7cpPp88wEVyTLvXfKPkXTeRR3O4xCP5akgb1DUJiC3N
         V0QvRnEnySdpYoONyUAIdqN0i8ND09JKfmx5s5npg/iT4jzZXjaoZhDMGOHe1rp5hcDU
         NQBA==
X-Gm-Message-State: AJIora9vUSDFY3HEHFaKPn9ScIuhcopnPVAkJCs+M8A5BDT1KOydOyi7
        PQmfzr7a7m/cKrIDckhZ3Oo=
X-Google-Smtp-Source: AGRyM1uJSHYklFWWJDezdTqlddpsM1KuZM2+qDfa8KLs3xWmqBe1OCmiGnK4bhl1U+6hcualLHjluQ==
X-Received: by 2002:a05:6a00:16c1:b0:520:6ede:24fb with SMTP id l1-20020a056a0016c100b005206ede24fbmr12325670pfc.7.1657866486683;
        Thu, 14 Jul 2022 23:28:06 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id d66-20020a621d45000000b00528669a770esm2880994pfd.90.2022.07.14.23.28.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jul 2022 23:28:06 -0700 (PDT)
Date:   Fri, 15 Jul 2022 14:29:30 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 04/16] erofs: introduce bufvec to store decompressed
 buffers
Message-ID: <20220715142930.00001cdd.zbestahu@gmail.com>
In-Reply-To: <20220714132051.46012-5-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
        <20220714132051.46012-5-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 14 Jul 2022 21:20:39 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> For each pcluster, the total compressed buffers are determined in
> advance, yet the number of decompressed buffers actually vary.  Too
> many decompressed pages can be recorded if one pcluster is highly
> compressed or its pcluster size is large.  That takes extra memory
> footprints compared to uncompressed filesystems, especially a lot of
> I/O in flight on low-ended devices.
> 
> Therefore, similar to inplace I/O, pagevec was introduced to reuse
> page cache to store these pointers in the time-sharing way since
> these pages are actually unused before decompressing.
> 
> In order to make it more flexable, a cleaner bufvec is used to
> replace the old pagevec stuffs so that
> 
>  - Decompressed offsets can be stored inline, thus it can be used
>    for the upcoming feature like compressed data deduplication;
> 
>  - Towards supporting large folios for compressed inodes since
>    our final goal is to completely avoid page->private but use
>    folio->private only for all page cache pages.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 177 +++++++++++++++++++++++++++++++++++------------
>  fs/erofs/zdata.h |  26 +++++--
>  2 files changed, 153 insertions(+), 50 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index c183cd0bc42b..f52c54058f31 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -2,6 +2,7 @@
>  /*
>   * Copyright (C) 2018 HUAWEI, Inc.
>   *             https://www.huawei.com/
> + * Copyright (C) 2022 Alibaba Cloud
>   */
>  #include "zdata.h"
>  #include "compress.h"
> @@ -26,6 +27,82 @@ static struct z_erofs_pcluster_slab pcluster_pool[] __read_mostly = {
>  	_PCLP(Z_EROFS_PCLUSTER_MAX_PAGES)
>  };
>  
> +struct z_erofs_bvec_iter {
> +	struct page *bvpage;
> +	struct z_erofs_bvset *bvset;
> +	unsigned int nr, cur;
> +};
> +
> +static struct page *z_erofs_bvec_iter_end(struct z_erofs_bvec_iter *iter)
> +{
> +	if (iter->bvpage)
> +		kunmap_local(iter->bvset);
> +	return iter->bvpage;
> +}
> +
> +static struct page *z_erofs_bvset_flip(struct z_erofs_bvec_iter *iter)
> +{
> +	unsigned long base = (unsigned long)((struct z_erofs_bvset *)0)->bvec;
> +	/* have to access nextpage in advance, otherwise it will be unmapped */
> +	struct page *nextpage = iter->bvset->nextpage;
> +	struct page *oldpage;
> +
> +	DBG_BUGON(!nextpage);
> +	oldpage = z_erofs_bvec_iter_end(iter);
> +	iter->bvpage = nextpage;
> +	iter->bvset = kmap_local_page(nextpage);
> +	iter->nr = (PAGE_SIZE - base) / sizeof(struct z_erofs_bvec);
> +	iter->cur = 0;
> +	return oldpage;
> +}
> +
> +static void z_erofs_bvec_iter_begin(struct z_erofs_bvec_iter *iter,
> +				    struct z_erofs_bvset_inline *bvset,
> +				    unsigned int bootstrap_nr,
> +				    unsigned int cur)
> +{
> +	*iter = (struct z_erofs_bvec_iter) {
> +		.nr = bootstrap_nr,
> +		.bvset = (struct z_erofs_bvset *)bvset,
> +	};
> +
> +	while (cur > iter->nr) {
> +		cur -= iter->nr;
> +		z_erofs_bvset_flip(iter);
> +	}
> +	iter->cur = cur;
> +}
> +
> +static int z_erofs_bvec_enqueue(struct z_erofs_bvec_iter *iter,
> +				struct z_erofs_bvec *bvec,
> +				struct page **candidate_bvpage)
> +{
> +	if (iter->cur == iter->nr) {
> +		if (!*candidate_bvpage)
> +			return -EAGAIN;
> +
> +		DBG_BUGON(iter->bvset->nextpage);
> +		iter->bvset->nextpage = *candidate_bvpage;
> +		z_erofs_bvset_flip(iter);
> +
> +		iter->bvset->nextpage = NULL;
> +		*candidate_bvpage = NULL;
> +	}
> +	iter->bvset->bvec[iter->cur++] = *bvec;
> +	return 0;
> +}
> +
> +static void z_erofs_bvec_dequeue(struct z_erofs_bvec_iter *iter,
> +				 struct z_erofs_bvec *bvec,
> +				 struct page **old_bvpage)
> +{
> +	if (iter->cur == iter->nr)
> +		*old_bvpage = z_erofs_bvset_flip(iter);
> +	else
> +		*old_bvpage = NULL;
> +	*bvec = iter->bvset->bvec[iter->cur++];
> +}
> +

Touch a new file to include bufvec related code? call it zbvec.c/h?

>  static void z_erofs_destroy_pcluster_pool(void)
>  {
>  	int i;
> @@ -195,9 +272,10 @@ enum z_erofs_collectmode {
>  struct z_erofs_decompress_frontend {
>  	struct inode *const inode;
>  	struct erofs_map_blocks map;
> -
> +	struct z_erofs_bvec_iter biter;
>  	struct z_erofs_pagevec_ctor vector;
>  
> +	struct page *candidate_bvpage;
>  	struct z_erofs_pcluster *pcl, *tailpcl;
>  	/* a pointer used to pick up inplace I/O pages */
>  	struct page **icpage_ptr;
> @@ -358,21 +436,24 @@ static bool z_erofs_try_inplace_io(struct z_erofs_decompress_frontend *fe,
>  
>  /* callers must be with pcluster lock held */
>  static int z_erofs_attach_page(struct z_erofs_decompress_frontend *fe,
> -			       struct page *page, enum z_erofs_page_type type,
> -			       bool pvec_safereuse)
> +			       struct z_erofs_bvec *bvec,
> +			       enum z_erofs_page_type type)
>  {
>  	int ret;
>  
> -	/* give priority for inplaceio */
>  	if (fe->mode >= COLLECT_PRIMARY &&
> -	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
> -	    z_erofs_try_inplace_io(fe, page))
> -		return 0;
> -
> -	ret = z_erofs_pagevec_enqueue(&fe->vector, page, type,
> -				      pvec_safereuse);
> -	fe->pcl->vcnt += (unsigned int)ret;
> -	return ret ? 0 : -EAGAIN;
> +	    type == Z_EROFS_PAGE_TYPE_EXCLUSIVE) {
> +		/* give priority for inplaceio to use file pages first */
> +		if (z_erofs_try_inplace_io(fe, bvec->page))
> +			return 0;
> +		/* otherwise, check if it can be used as a bvpage */
> +		if (fe->mode >= COLLECT_PRIMARY_FOLLOWED &&
> +		    !fe->candidate_bvpage)
> +			fe->candidate_bvpage = bvec->page;
> +	}
> +	ret = z_erofs_bvec_enqueue(&fe->biter, bvec, &fe->candidate_bvpage);
> +	fe->pcl->vcnt += (ret >= 0);
> +	return ret;
>  }
>  
>  static void z_erofs_try_to_claim_pcluster(struct z_erofs_decompress_frontend *f)
> @@ -554,9 +635,8 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
>  	} else if (ret) {
>  		return ret;
>  	}
> -
> -	z_erofs_pagevec_ctor_init(&fe->vector, Z_EROFS_NR_INLINE_PAGEVECS,
> -				  fe->pcl->pagevec, fe->pcl->vcnt);
> +	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
> +				Z_EROFS_NR_INLINE_PAGEVECS, fe->pcl->vcnt);
>  	/* since file-backed online pages are traversed in reverse order */
>  	fe->icpage_ptr = fe->pcl->compressed_pages +
>  			z_erofs_pclusterpages(fe->pcl);
> @@ -588,9 +668,14 @@ static bool z_erofs_collector_end(struct z_erofs_decompress_frontend *fe)
>  	if (!pcl)
>  		return false;
>  
> -	z_erofs_pagevec_ctor_exit(&fe->vector, false);
> +	z_erofs_bvec_iter_end(&fe->biter);
>  	mutex_unlock(&pcl->lock);
>  
> +	if (fe->candidate_bvpage) {
> +		DBG_BUGON(z_erofs_is_shortlived_page(fe->candidate_bvpage));
> +		fe->candidate_bvpage = NULL;
> +	}
> +
>  	/*
>  	 * if all pending pages are added, don't hold its reference
>  	 * any longer if the pcluster isn't hosted by ourselves.
> @@ -712,22 +797,23 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  		tight &= (fe->mode >= COLLECT_PRIMARY_FOLLOWED);
>  
>  retry:
> -	err = z_erofs_attach_page(fe, page, page_type,
> -				  fe->mode >= COLLECT_PRIMARY_FOLLOWED);
> -	/* should allocate an additional short-lived page for pagevec */
> -	if (err == -EAGAIN) {
> -		struct page *const newpage =
> -				alloc_page(GFP_NOFS | __GFP_NOFAIL);
> -
> -		set_page_private(newpage, Z_EROFS_SHORTLIVED_PAGE);
> -		err = z_erofs_attach_page(fe, newpage,
> -					  Z_EROFS_PAGE_TYPE_EXCLUSIVE, true);
> -		if (!err)
> -			goto retry;
> +	err = z_erofs_attach_page(fe, &((struct z_erofs_bvec) {
> +					.page = page,
> +					.offset = offset - map->m_la,
> +					.end = end,
> +				  }), page_type);
> +	/* should allocate an additional short-lived page for bvset */
> +	if (err == -EAGAIN && !fe->candidate_bvpage) {
> +		fe->candidate_bvpage = alloc_page(GFP_NOFS | __GFP_NOFAIL);
> +		set_page_private(fe->candidate_bvpage,
> +				 Z_EROFS_SHORTLIVED_PAGE);
> +		goto retry;
>  	}
>  
> -	if (err)
> +	if (err) {
> +		DBG_BUGON(err == -EAGAIN && fe->candidate_bvpage);
>  		goto err_out;
> +	}
>  
>  	index = page->index - (map->m_la >> PAGE_SHIFT);
>  
> @@ -781,29 +867,24 @@ static bool z_erofs_page_is_invalidated(struct page *page)
>  static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
>  				   struct page **pages, struct page **pagepool)
>  {
> -	struct z_erofs_pagevec_ctor ctor;
> -	enum z_erofs_page_type page_type;
> +	struct z_erofs_bvec_iter biter;
> +	struct page *old_bvpage;
>  	int i, err = 0;
>  
> -	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
> -				  pcl->pagevec, 0);
> +	z_erofs_bvec_iter_begin(&biter, &pcl->bvset,
> +				Z_EROFS_NR_INLINE_PAGEVECS, 0);
>  	for (i = 0; i < pcl->vcnt; ++i) {
> -		struct page *page = z_erofs_pagevec_dequeue(&ctor, &page_type);
> +		struct z_erofs_bvec bvec;
>  		unsigned int pagenr;
>  
> -		/* all pages in pagevec ought to be valid */
> -		DBG_BUGON(!page);
> -		DBG_BUGON(z_erofs_page_is_invalidated(page));
> -
> -		if (z_erofs_put_shortlivedpage(pagepool, page))
> -			continue;
> +		z_erofs_bvec_dequeue(&biter, &bvec, &old_bvpage);
>  
> -		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
> -			pagenr = 0;
> -		else
> -			pagenr = z_erofs_onlinepage_index(page);
> +		if (old_bvpage)
> +			z_erofs_put_shortlivedpage(pagepool, old_bvpage);
>  
> +		pagenr = (bvec.offset + pcl->pageofs_out) >> PAGE_SHIFT;
>  		DBG_BUGON(pagenr >= pcl->nr_pages);
> +		DBG_BUGON(z_erofs_page_is_invalidated(bvec.page));
>  		/*
>  		 * currently EROFS doesn't support multiref(dedup),
>  		 * so here erroring out one multiref page.
> @@ -814,9 +895,12 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
>  			z_erofs_onlinepage_endio(pages[pagenr]);
>  			err = -EFSCORRUPTED;
>  		}
> -		pages[pagenr] = page;
> +		pages[pagenr] = bvec.page;
>  	}
> -	z_erofs_pagevec_ctor_exit(&ctor, true);
> +
> +	old_bvpage = z_erofs_bvec_iter_end(&biter);
> +	if (old_bvpage)
> +		z_erofs_put_shortlivedpage(pagepool, old_bvpage);
>  	return err;
>  }
>  
> @@ -986,6 +1070,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  		kvfree(pages);
>  
>  	pcl->nr_pages = 0;
> +	pcl->bvset.nextpage = NULL;
>  	pcl->vcnt = 0;
>  
>  	/* pcluster lock MUST be taken before the following line */
> diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
> index 58053bb5066f..d03e333e4fde 100644
> --- a/fs/erofs/zdata.h
> +++ b/fs/erofs/zdata.h
> @@ -21,6 +21,21 @@
>   */
>  typedef void *z_erofs_next_pcluster_t;
>  
> +struct z_erofs_bvec {
> +	struct page *page;
> +	int offset;
> +	unsigned int end;
> +};
> +
> +#define __Z_EROFS_BVSET(name, total) \
> +struct name { \
> +	/* point to the next page which contains the following bvecs */ \
> +	struct page *nextpage; \
> +	struct z_erofs_bvec bvec[total]; \
> +}
> +__Z_EROFS_BVSET(z_erofs_bvset,);
> +__Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_NR_INLINE_PAGEVECS);
> +
>  /*
>   * Structure fields follow one of the following exclusion rules.
>   *
> @@ -41,22 +56,25 @@ struct z_erofs_pcluster {
>  	/* A: lower limit of decompressed length and if full length or not */
>  	unsigned int length;
>  
> +	/* L: total number of bvecs */
> +	unsigned int vcnt;
> +
>  	/* I: page offset of start position of decompression */
>  	unsigned short pageofs_out;
>  
>  	/* I: page offset of inline compressed data */
>  	unsigned short pageofs_in;
>  
> -	/* L: maximum relative page index in pagevec[] */
> +	/* L: maximum relative page index in bvecs */
>  	unsigned short nr_pages;
>  
> -	/* L: total number of pages in pagevec[] */
> -	unsigned int vcnt;
> -
>  	union {
>  		/* L: inline a certain number of pagevecs for bootstrap */
>  		erofs_vtptr_t pagevec[Z_EROFS_NR_INLINE_PAGEVECS];
>  
> +		/* L: inline a certain number of bvec for bootstrap */
> +		struct z_erofs_bvset_inline bvset;
> +
>  		/* I: can be used to free the pcluster by RCU. */
>  		struct rcu_head rcu;
>  	};

