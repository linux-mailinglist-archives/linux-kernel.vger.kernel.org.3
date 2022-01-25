Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEA549BAD0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiAYR6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:58:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:59954 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243744AbiAYR4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:56:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643133374;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=E6rxjsOhNxfEiaxINggrBA6x75JFuMQB6f2O2kbHXzE=;
        b=BXIzrEbjlwjxscJl0uWRCufAHy8cPOcPBVccwf7ZxM9Vy0E9ox0oHYavSq4U86wMexezxM
        dM4o3oGuxN/YBhLE+UnvweemQpjSpKvkeEvb2P56u8fG/PW0AF4914A8tsZD2yMGpp/5xl
        1Tro+B8f0sLkVdYIEWP8tJhoaI95hmg=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-k7p6FB7yNK6NBuFrBehQQA-1; Tue, 25 Jan 2022 12:56:13 -0500
X-MC-Unique: k7p6FB7yNK6NBuFrBehQQA-1
Received: by mail-ot1-f72.google.com with SMTP id n99-20020a9d206c000000b00590dde2cca8so13846274ota.9
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 09:56:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=E6rxjsOhNxfEiaxINggrBA6x75JFuMQB6f2O2kbHXzE=;
        b=tvqkhUL8uh3n5YYokLN3ytxudBzkqxlY1GMwQq/qvJgfZ40xYAwAyWb50F48LSkVw5
         UwMZjFCyvqjC9ujprT5SaZfYiGvmvsMEJSOKTyhIdnOjQhwYMCyRAleUUGUH76vDbb4P
         B+fc5hlNzFpD15AE9cY3Jyl5xftpS4n9WJEgs4rZHq7qEGxp3V8IY5Hee+GQjInFl78A
         Q1WYYTmPaMZPgR7pN76Rq3kO5hgH594MPq9xikrAJw3jqXFGkYdJ2KPsFRR/5MjuAcqC
         gzwwb1VrbDmYtuY2tchspLPXOqbHldNtbE3MF8NFpt0VmJZ/L0z7zYrlcP5iuYlGzrbc
         OhYA==
X-Gm-Message-State: AOAM530+Tqq51q5tT39hUJ9SER6tEvsjYxOMAdPAh68y2bEelCIN1oVO
        Gthk49d9jkewat5Ip7qmiIMgAnShl7E3+ulzHuV8a2j0nGdj/Ub/RCmVoxlHp4Nd7Xxl4sDhz3e
        Q9Z+lqTPkZH8nzh58EWxLlOF8
X-Received: by 2002:a4a:dd98:: with SMTP id h24mr2975783oov.73.1643133372030;
        Tue, 25 Jan 2022 09:56:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxYU8KoqYoZGyScgfgxOyqhv/Nbcm50wK1ORJkXgLkUal4jqhtQ/iOtcNXKSPdPLYBPciII5g==
X-Received: by 2002:a4a:dd98:: with SMTP id h24mr2975775oov.73.1643133371841;
        Tue, 25 Jan 2022 09:56:11 -0800 (PST)
Received: from optiplex-fbsd (c-73-182-255-193.hsd1.nh.comcast.net. [73.182.255.193])
        by smtp.gmail.com with ESMTPSA id a15sm8138436oil.13.2022.01.25.09.56.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:56:11 -0800 (PST)
Date:   Tue, 25 Jan 2022 12:56:08 -0500
From:   Rafael Aquini <aquini@redhat.com>
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     akpm@linux-foundation.org, mst@redhat.com, david@redhat.com,
        virtualization@lists.linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/balloon_compaction: make balloon page compaction
 callbacks static
Message-ID: <YfA5uLd8ftDxcIrG@optiplex-fbsd>
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
> 
> 
Acked-by: Rafael Aquini <aquini@redhat.com>

