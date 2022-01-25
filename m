Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E2DB49BAD8
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 19:01:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351529AbiAYSA6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 13:00:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:30257 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1351491AbiAYR7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:59:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643133555;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=tQwnOxnoIr5kWKtczEX49APK7YeWZviqLQA1sp5peAU=;
        b=QjHh+Hp8TizOE4FgVulGUllZmBkvmk5dtJVN74+84RUT7cKIdFXDrGu3PWSEh8P3NjJvs1
        agTsfTuTjzioaRv+tQYvoONcr0Dkf9UJJ7WJ6rsj3GxLA7lanU+oCTkAw62tUHN+L19xFy
        6silaCCw/sO8Bru5wCqGg9JDsPrJNuw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-345-HisVQRKKOmeQNvhXVOZbKg-1; Tue, 25 Jan 2022 12:59:13 -0500
X-MC-Unique: HisVQRKKOmeQNvhXVOZbKg-1
Received: by mail-ed1-f69.google.com with SMTP id a18-20020aa7d752000000b00403d18712beso15429504eds.17
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tQwnOxnoIr5kWKtczEX49APK7YeWZviqLQA1sp5peAU=;
        b=pyJC15o6gqhKiyLoIsyVNpjex3Rg9NAaaBEP8hM3E5dyKPtbzff2vIiYIOOo6Ymz2Q
         1B3BcQR1W+GovwyzIA9dZvXsmwCELi00e2lO60iX1tQNFXMtnN/rn7BJVmpzKwP5H/Cp
         Wxzl4DKCNY5xObcLsiOe7sMZTaiZB0fzShCiCnNaLc1xgu8Jkl4O2GfRORuYomZYKqPQ
         XHjmUQ4zjGcHTBfenc7falxmyW00GjVSpqs+h5TjceXduvrZdCeFLbxENtiVE1bg2ePF
         iz6xCx+6M7GC27axlCQ+/PslWnPMEfeASmn5ZYC2qR9rgQLBsLMcUW6TwHQHXieJokXq
         6biQ==
X-Gm-Message-State: AOAM531PWrelispUkQsLlvU1QSZQ81/mHsn9C7TumPcE8fefad7vftH/
        vGONOzomCXu0gN2/KifNRN1y6eK2JS3t+Am9ZZuGzQzfeqgCVBElvNrDQbqJIJLQvazh5qS+Nts
        9wpdO0yPke5oZ2QwUzq1HLK/D
X-Received: by 2002:a17:907:72c4:: with SMTP id du4mr9152823ejc.243.1643133552622;
        Tue, 25 Jan 2022 09:59:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz7m6XPepvwD9UHHPdetVwWNbg/dFQ1MV8dbRVv9I9eBjYFCvpX/V21GrFvuzJV6aICXTe9mQ==
X-Received: by 2002:a17:907:72c4:: with SMTP id du4mr9152815ejc.243.1643133552428;
        Tue, 25 Jan 2022 09:59:12 -0800 (PST)
Received: from redhat.com ([176.12.185.204])
        by smtp.gmail.com with ESMTPSA id d5sm8562973edz.78.2022.01.25.09.59.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:59:11 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:59:08 -0500
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, david@redhat.com,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/balloon_compaction: make balloon page compaction
 callbacks static
Message-ID: <20220125125853-mutt-send-email-mst@kernel.org>
References: <20220125132221.2220-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220125132221.2220-1-linmiaohe@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 09:22:21PM +0800, Miaohe Lin wrote:
> Since commit b1123ea6d3b3 ("mm: balloon: use general non-lru movable page
> feature"), these functions are called via balloon_aops callbacks. They're
> not called directly outside this file. So make them static and clean up
> the relevant code.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

I'll queue this unless someone else does first.

> ---
>  include/linux/balloon_compaction.h | 22 ----------------------
>  mm/balloon_compaction.c            |  6 +++---
>  2 files changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/include/linux/balloon_compaction.h b/include/linux/balloon_compaction.h
> index 338aa27e4773..edb7f6d41faa 100644
> --- a/include/linux/balloon_compaction.h
> +++ b/include/linux/balloon_compaction.h
> @@ -80,12 +80,6 @@ static inline void balloon_devinfo_init(struct balloon_dev_info *balloon)
>  
>  #ifdef CONFIG_BALLOON_COMPACTION
>  extern const struct address_space_operations balloon_aops;
> -extern bool balloon_page_isolate(struct page *page,
> -				isolate_mode_t mode);
> -extern void balloon_page_putback(struct page *page);
> -extern int balloon_page_migrate(struct address_space *mapping,
> -				struct page *newpage,
> -				struct page *page, enum migrate_mode mode);
>  
>  /*
>   * balloon_page_insert - insert a page into the balloon's page list and make
> @@ -155,22 +149,6 @@ static inline void balloon_page_delete(struct page *page)
>  	list_del(&page->lru);
>  }
>  
> -static inline bool balloon_page_isolate(struct page *page)
> -{
> -	return false;
> -}
> -
> -static inline void balloon_page_putback(struct page *page)
> -{
> -	return;
> -}
> -
> -static inline int balloon_page_migrate(struct page *newpage,
> -				struct page *page, enum migrate_mode mode)
> -{
> -	return 0;
> -}
> -
>  static inline gfp_t balloon_mapping_gfp_mask(void)
>  {
>  	return GFP_HIGHUSER;
> diff --git a/mm/balloon_compaction.c b/mm/balloon_compaction.c
> index 907fefde2572..4b8eab4b3f45 100644
> --- a/mm/balloon_compaction.c
> +++ b/mm/balloon_compaction.c
> @@ -203,7 +203,7 @@ EXPORT_SYMBOL_GPL(balloon_page_dequeue);
>  
>  #ifdef CONFIG_BALLOON_COMPACTION
>  
> -bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
> +static bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
>  
>  {
>  	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
> @@ -217,7 +217,7 @@ bool balloon_page_isolate(struct page *page, isolate_mode_t mode)
>  	return true;
>  }
>  
> -void balloon_page_putback(struct page *page)
> +static void balloon_page_putback(struct page *page)
>  {
>  	struct balloon_dev_info *b_dev_info = balloon_page_device(page);
>  	unsigned long flags;
> @@ -230,7 +230,7 @@ void balloon_page_putback(struct page *page)
>  
>  
>  /* move_to_new_page() counterpart for a ballooned page */
> -int balloon_page_migrate(struct address_space *mapping,
> +static int balloon_page_migrate(struct address_space *mapping,
>  		struct page *newpage, struct page *page,
>  		enum migrate_mode mode)
>  {
> -- 
> 2.23.0

