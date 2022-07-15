Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4CD575B73
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 08:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiGOGVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 02:21:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiGOGVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 02:21:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60B9C5018A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:21:31 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g4so3594237pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 23:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rq3ZLvSfaj/cFZPRn+lx4DRT0BE9U/2W83PKsNZWj1s=;
        b=Yb65uxZ0JwdEi2YnumbgLo4unXamYQjpmzYMAsIekvbPjByORenik6tJzperLMqC4M
         XNs0Mi85goSOF4c/K2dXyB58R1wU0DH3OBWg7rkHF6+63TWV5R67GJwyMSh273oDNzn1
         JbugledOwpO/yRszJx+qx+uivOk7wbKxjUN4joIeH/wAY5o7PJgarauZjc6TbOs4WI7k
         GLcBcaDZHgpkxlxkzrnhkfHg/HFyEYuZ0nU3SB0K9Z6CthoEpx+ao7FskwI29cllkBde
         XZc3BMIsyZz95M/uf3GJ+poXbnj71nSHIJbfGsEfdOYMV/LalNtTKV75jILl5OhPjZX7
         hoCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rq3ZLvSfaj/cFZPRn+lx4DRT0BE9U/2W83PKsNZWj1s=;
        b=Jl+O1DS5O+S7BOWHVyv28rd/3mn8VgMU9wiy4tp1uIOlcJM7yg8PeA3IQsCqVNMPu/
         XIlhU3oSnAVboVwHJlf8bvMJrqXeBZN/YwXdV9SneKekRYd5Hh7xB7S8togEyH1rPoA/
         Ys0ywF+G8eJ2UW+8cesmvEppYVkIiKHDj60RG4kDWOfL549vAwiFo0Ea57nLQfu9sjVt
         W/RlOotFNwdv2A45KcXWN/KuCwnubXl/SB2wdUnQsyxysRN9oK0uRkdaGwb2Qvh5KIRE
         WKcQkbFyNXiQ6tgdtDp1c3S50kfPJ+RR2cBd1rfV2qvqoSsUNLkEd5GUsWgr2U5g5ZjI
         Pqfw==
X-Gm-Message-State: AJIora9ZJ/JmBUL52XdOncJyHOGQFdri2KB33yI27muz7anBgxNUfEoN
        ETz0TtG1xq/UJ3pTrD5Cbn0=
X-Google-Smtp-Source: AGRyM1vbt2/3dZUin7L+IVctThOXGlOhmUoFD9CD7iB43RcnxOg0CbpC28VFfTm+XcUiSiAFfdvRDg==
X-Received: by 2002:a65:57c6:0:b0:415:c329:5d49 with SMTP id q6-20020a6557c6000000b00415c3295d49mr10514856pgr.581.1657866090932;
        Thu, 14 Jul 2022 23:21:30 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id h16-20020a170902f55000b00168f08d0d12sm2578421plf.89.2022.07.14.23.21.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Jul 2022 23:21:30 -0700 (PDT)
Date:   Fri, 15 Jul 2022 14:22:53 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, zhangwen@coolpad.com
Subject: Re: [PATCH 03/16] erofs: introduce `z_erofs_parse_out_bvecs()'
Message-ID: <20220715142253.00005239.zbestahu@gmail.com>
In-Reply-To: <20220714132051.46012-4-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
        <20220714132051.46012-4-hsiangkao@linux.alibaba.com>
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

On Thu, 14 Jul 2022 21:20:38 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> `z_erofs_decompress_pcluster()' is too long therefore it'd be better
> to introduce another helper to parse decompressed pages (or laterly,
> decompressed bvecs.)
> 
> BTW, since `decompressed_bvecs' is too long as a part of the function
> name, `out_bvecs' is used instead.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 81 +++++++++++++++++++++++++-----------------------
>  1 file changed, 43 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index c7be447ac64d..c183cd0bc42b 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -778,18 +778,58 @@ static bool z_erofs_page_is_invalidated(struct page *page)
>  	return !page->mapping && !z_erofs_is_shortlived_page(page);
>  }
>  
> +static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
> +				   struct page **pages, struct page **pagepool)
> +{
> +	struct z_erofs_pagevec_ctor ctor;
> +	enum z_erofs_page_type page_type;
> +	int i, err = 0;
> +
> +	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
> +				  pcl->pagevec, 0);
> +	for (i = 0; i < pcl->vcnt; ++i) {
> +		struct page *page = z_erofs_pagevec_dequeue(&ctor, &page_type);
> +		unsigned int pagenr;
> +
> +		/* all pages in pagevec ought to be valid */
> +		DBG_BUGON(!page);
> +		DBG_BUGON(z_erofs_page_is_invalidated(page));
> +
> +		if (z_erofs_put_shortlivedpage(pagepool, page))
> +			continue;
> +
> +		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
> +			pagenr = 0;
> +		else
> +			pagenr = z_erofs_onlinepage_index(page);
> +
> +		DBG_BUGON(pagenr >= pcl->nr_pages);
> +		/*
> +		 * currently EROFS doesn't support multiref(dedup),
> +		 * so here erroring out one multiref page.
> +		 */
> +		if (pages[pagenr]) {
> +			DBG_BUGON(1);
> +			SetPageError(pages[pagenr]);
> +			z_erofs_onlinepage_endio(pages[pagenr]);
> +			err = -EFSCORRUPTED;
> +		}
> +		pages[pagenr] = page;
> +	}
> +	z_erofs_pagevec_ctor_exit(&ctor, true);
> +	return err;
> +}
> +
>  static int z_erofs_decompress_pcluster(struct super_block *sb,
>  				       struct z_erofs_pcluster *pcl,
>  				       struct page **pagepool)
>  {
>  	struct erofs_sb_info *const sbi = EROFS_SB(sb);
>  	unsigned int pclusterpages = z_erofs_pclusterpages(pcl);
> -	struct z_erofs_pagevec_ctor ctor;
>  	unsigned int i, inputsize, outputsize, llen, nr_pages;
>  	struct page *pages_onstack[Z_EROFS_VMAP_ONSTACK_PAGES];
>  	struct page **pages, **compressed_pages, *page;
>  
> -	enum z_erofs_page_type page_type;
>  	bool overlapped, partial;
>  	int err;
>  
> @@ -823,42 +863,7 @@ static int z_erofs_decompress_pcluster(struct super_block *sb,
>  	for (i = 0; i < nr_pages; ++i)
>  		pages[i] = NULL;
>  
> -	err = 0;
> -	z_erofs_pagevec_ctor_init(&ctor, Z_EROFS_NR_INLINE_PAGEVECS,
> -				  pcl->pagevec, 0);
> -
> -	for (i = 0; i < pcl->vcnt; ++i) {
> -		unsigned int pagenr;
> -
> -		page = z_erofs_pagevec_dequeue(&ctor, &page_type);
> -
> -		/* all pages in pagevec ought to be valid */
> -		DBG_BUGON(!page);
> -		DBG_BUGON(z_erofs_page_is_invalidated(page));
> -
> -		if (z_erofs_put_shortlivedpage(pagepool, page))
> -			continue;
> -
> -		if (page_type == Z_EROFS_VLE_PAGE_TYPE_HEAD)
> -			pagenr = 0;
> -		else
> -			pagenr = z_erofs_onlinepage_index(page);
> -
> -		DBG_BUGON(pagenr >= nr_pages);
> -
> -		/*
> -		 * currently EROFS doesn't support multiref(dedup),
> -		 * so here erroring out one multiref page.
> -		 */
> -		if (pages[pagenr]) {
> -			DBG_BUGON(1);
> -			SetPageError(pages[pagenr]);
> -			z_erofs_onlinepage_endio(pages[pagenr]);
> -			err = -EFSCORRUPTED;
> -		}
> -		pages[pagenr] = page;
> -	}
> -	z_erofs_pagevec_ctor_exit(&ctor, true);
> +	err = z_erofs_parse_out_bvecs(pcl, pages, pagepool);
>  
>  	overlapped = false;
>  	compressed_pages = pcl->compressed_pages;

Reviewed-by: Yue Hu <huyue2@coolpad.com>
