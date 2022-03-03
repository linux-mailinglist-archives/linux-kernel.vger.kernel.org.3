Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B440C4CB5D2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 05:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiCCEMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 23:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiCCEMH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 23:12:07 -0500
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4520E1637EF
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 20:11:23 -0800 (PST)
Received: by mail-pg1-x52c.google.com with SMTP id o23so3431549pgk.13
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 20:11:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/0gmcJoxVGLhp8QjDoOGXIW850+VpROypODCpoc/l/Y=;
        b=NRRxcvOAULZfW0eDMpnk22dYL2quKs0XFau2xaVDEEvhMi34Jvduh3PQboaYRvBH4S
         dzPai7HNhY+NT8SizIuMrOiTfrzWdxZDPqjVjx1yAaFJNY3mrlbN1cmJZf+g5jeHa38l
         V2KK/QHnfrp6LY+pD5qGL3lgymtKTcm4/68ql7YssnIpZTIm24eJrpSLb4/dZZJGTRkL
         OhnzEdLN9PqLP5efR8Y5PCF2mO/ds1wiqh/+6MCXOkCxr0GWkX3sHjVuMpLYHIGXmMF/
         xxucgaoLdyAxm7D4oF/Ord2Tm84d2tR16ee7pF/F/8Bu33uIQ3rS+ieOB/cnnp2xs4h0
         7RLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/0gmcJoxVGLhp8QjDoOGXIW850+VpROypODCpoc/l/Y=;
        b=Mqf/X6724IPl0WCWIiTyaBKYPjLtulTKc+PJjxwHe22WNGFnLewqnHxKSr62XNgHLs
         PIJebqivT5RJuhWvYigZAdWDPmBhQFSXotE44Hn7YSetVe7Au5ubHiqjBhON+TFlQXpE
         50yVpq6gghZae0GLluElXPXmRSJATnJaKopciQwV9wcgM5i9WUrASsN701mwE75IrlhD
         p4LuVgrCx3fLZGkMj9HM62c7+R5BuItDxNR12dh7zywktLQZWtmMQOu7YRADpINXYk7b
         KTLI8kLcpXptSSu+qgxYhh3sie9Dg9q41KNJF2gpyY95+FiaOeLGCuyt5aROWNlHSDN+
         DSMg==
X-Gm-Message-State: AOAM533lGiHtbEkI1STe5NSroSjUOqdi5wY/ZknkFbGwWR0cqhOnEY7q
        EoXSrWeGJvWhW2FVRMDACaLw2VOO3kg=
X-Google-Smtp-Source: ABdhPJxD3zIUdv9FDDVS3XTBezqyk7zhzKfvGQNUBsrrwAQeG/w8Ht1BpAIT3dcuCmW1TxXo03YtVA==
X-Received: by 2002:a05:6a00:26e2:b0:4e1:296b:f24e with SMTP id p34-20020a056a0026e200b004e1296bf24emr36402283pfw.49.1646280682661;
        Wed, 02 Mar 2022 20:11:22 -0800 (PST)
Received: from localhost ([103.220.76.197])
        by smtp.gmail.com with ESMTPSA id j17-20020a634a51000000b00378f9c90e66sm634379pgl.39.2022.03.02.20.11.20
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 02 Mar 2022 20:11:22 -0800 (PST)
Date:   Thu, 3 Mar 2022 12:09:55 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH 2/2] erofs: clean up preload_compressed_pages()
Message-ID: <20220303120955.00002c81.zbestahu@gmail.com>
In-Reply-To: <20220301194951.106227-2-hsiangkao@linux.alibaba.com>
References: <20220301194951.106227-1-hsiangkao@linux.alibaba.com>
        <20220301194951.106227-2-hsiangkao@linux.alibaba.com>
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

On Wed,  2 Mar 2022 03:49:51 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Rename preload_compressed_pages() as z_erofs_bind_cache()
> since we're try to prepare for adapting folios.
> 
> Also, add a comment for the gfp setting. No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> ---
>  fs/erofs/zdata.c | 18 ++++++++++--------
>  1 file changed, 10 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
> index 2673fc105861..59aecf42e45c 100644
> --- a/fs/erofs/zdata.c
> +++ b/fs/erofs/zdata.c
> @@ -219,13 +219,17 @@ struct z_erofs_decompress_frontend {
>  static struct page *z_pagemap_global[Z_EROFS_VMAP_GLOBAL_PAGES];
>  static DEFINE_MUTEX(z_pagemap_global_lock);
>  
> -static void preload_compressed_pages(struct z_erofs_decompress_frontend *fe,
> -				     struct address_space *mc,
> -				     enum z_erofs_cache_alloctype type,
> -				     struct page **pagepool)
> +static void z_erofs_bind_cache(struct z_erofs_decompress_frontend *fe,
> +			       enum z_erofs_cache_alloctype type,
> +			       struct page **pagepool)
>  {
> +	struct address_space *mc = MNGD_MAPPING(EROFS_I_SB(fe->inode));
>  	struct z_erofs_pcluster *pcl = fe->pcl;
>  	bool standalone = true;
> +	/*
> +	 * optimistic allocation without direct reclaim since inplace I/O
> +	 * can be used if low memory otherwise.
> +	 */
>  	gfp_t gfp = (mapping_gfp_mask(mc) & ~__GFP_DIRECT_RECLAIM) |
>  			__GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN;
>  	struct page **pages;
> @@ -703,17 +707,15 @@ static int z_erofs_do_read_page(struct z_erofs_decompress_frontend *fe,
>  		WRITE_ONCE(fe->pcl->compressed_pages[0], fe->map.buf.page);
>  		fe->mode = COLLECT_PRIMARY_FOLLOWED_NOINPLACE;
>  	} else {
> -		/* preload all compressed pages (can change mode if needed) */
> +		/* bind cache first when cached decompression is preferred */
>  		if (should_alloc_managed_pages(fe, sbi->opt.cache_strategy,
>  					       map->m_la))
>  			cache_strategy = TRYALLOC;
>  		else
>  			cache_strategy = DONTALLOC;
>  
> -		preload_compressed_pages(fe, MNGD_MAPPING(sbi),
> -					 cache_strategy, pagepool);
> +		z_erofs_bind_cache(fe, cache_strategy, pagepool);
>  	}
> -
>  hitted:
>  	/*
>  	 * Ensure the current partial page belongs to this submit chain rather

Reviewed-by: Yue Hu <huyue2@coolpad.com>
