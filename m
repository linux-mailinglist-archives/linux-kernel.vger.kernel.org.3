Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E20A53A4F6
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242485AbiFAM3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237528AbiFAM26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:28:58 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF97E1D3
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:28:56 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id u3so2148414wrg.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 05:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IelEAvxuftzpFUTjVmjDc8U27FXmxMCPT7XI/4vcyT8=;
        b=Xa5y6uuLTlRYUa8V+e+/4JGPqwWm2HXsZWjGZeeynhrY/Xmyj9Sygw8VjuP/t1qO07
         b2+G7hy4jPbHYj4VR8+g6vNRSDiAMdMGrwakeY/Jt4oyrV/PIe9jYogIbXAChrQ1NX/q
         KXsVuA2nYTNvZ5hS+gagvPnv4SwP/A4pwD5iVVFUu6QJHdX5/k7C2a1KgXGwGds8f5JK
         OYOrIYqTFUmQF7dVZJDkxIqRh6wPMekV1sdfq2P8C7El1JNPpClVuKuDLuIDX/Iw4eOy
         SUxWIis9mGZjLv0zQTMoUkbN184rVl41TbSMBIS5Rt2lAWbYNJfVzMbeM1Q4aCD9ugYJ
         u/BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IelEAvxuftzpFUTjVmjDc8U27FXmxMCPT7XI/4vcyT8=;
        b=3kY8HMpRI6b1/z7LDv+055GaW4Plo49bgvzTVN4Ing+UEMz0wuU6R9FW3NG4E2eS+j
         mFz3mnUzgbNnDUlySW3pmTKhS2v7n/dYBacfqq7kKLBUR01yLI/tMbqk/6UsliLGW4Ey
         aoRopnqJ8zNgePxbinbXZjRelaToGP2VPzRmgeRxQF9bd1L97aGEM/GDAkP5QL2LGkMZ
         weI4BPuNo8Ph4d1OdKHRmbB5fkRVhgTTwXg9/AHNlfKfrf44WR5GRzJB8cm8vDcvXR0T
         PO5Jhy5N4kagFCzOl+W690QaGVafyRY8SGIkLJM7Xw0vrjycvhRi39vleiA2t5ozcWDU
         ViBg==
X-Gm-Message-State: AOAM531BpNGKSJS86EFR/ls2IdVNXfk+tvfRLZuKGGH6lygolLLxplfF
        2/GX29uhVDXUT+KxtD+hHEHC+g==
X-Google-Smtp-Source: ABdhPJzTQYqHD3AuswM6IObr0zI5e+8BOvSIy4TzO8YrDCGcOJI2pM6bUMd9ayvHvb5scIj0s/xyUQ==
X-Received: by 2002:a05:6000:16cb:b0:20e:63aa:7a31 with SMTP id h11-20020a05600016cb00b0020e63aa7a31mr54674152wrf.253.1654086534694;
        Wed, 01 Jun 2022 05:28:54 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:ed43:9390:62cb:50ee])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d410a000000b0020fc6590a12sm1447145wrp.41.2022.06.01.05.28.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 05:28:54 -0700 (PDT)
Date:   Wed, 1 Jun 2022 14:28:48 +0200
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 3/3] kasan: fix zeroing vmalloc memory with HW_TAGS
Message-ID: <YpdbgGjjz954Us/y@elver.google.com>
References: <4c76a95aff79723de76df146a10888a5a9196faf.1654011120.git.andreyknvl@google.com>
 <bbc30451228f670abeaf1b8aad678b9f6dda4ad3.1654011120.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbc30451228f670abeaf1b8aad678b9f6dda4ad3.1654011120.git.andreyknvl@google.com>
User-Agent: Mutt/2.1.4 (2021-12-11)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 05:43PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> HW_TAGS KASAN skips zeroing page_alloc allocations backing vmalloc
> mappings via __GFP_SKIP_ZERO. Instead, these pages are zeroed via
> kasan_unpoison_vmalloc() by passing the KASAN_VMALLOC_INIT flag.
> 
> The problem is that __kasan_unpoison_vmalloc() does not zero pages
> when either kasan_vmalloc_enabled() or is_vmalloc_or_module_addr() fail.
> 
> Thus:
> 
> 1. Change __vmalloc_node_range() to only set KASAN_VMALLOC_INIT when
>    __GFP_SKIP_ZERO is set.
> 
> 2. Change __kasan_unpoison_vmalloc() to always zero pages when the
>    KASAN_VMALLOC_INIT flag is set.
> 
> 3. Add WARN_ON() asserts to check that KASAN_VMALLOC_INIT cannot be set
>    in other early return paths of __kasan_unpoison_vmalloc().
> 
> Also clean up the comment in __kasan_unpoison_vmalloc.
> 
> Fixes: 23689e91fb22 ("kasan, vmalloc: add vmalloc tagging for HW_TAGS")
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/kasan/hw_tags.c | 30 ++++++++++++++++++++++--------
>  mm/vmalloc.c       | 10 +++++-----
>  2 files changed, 27 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 9e1b6544bfa8..c0ec01eadf20 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -263,21 +263,31 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
>  	u8 tag;
>  	unsigned long redzone_start, redzone_size;
>  
> -	if (!kasan_vmalloc_enabled())
> -		return (void *)start;
> +	if (!kasan_vmalloc_enabled() || !is_vmalloc_or_module_addr(start)) {
> +		struct page *page;
> +		const void *addr;
> +
> +		/* Initialize memory if required. */
> +

This whole block of code looks out-of-place in this function, since it's
not at all related to unpoisoning but a fallback if KASAN-vmalloc is off
but we still want to initialize the memory.

Maybe to ease readability here I'd change it to look like:


diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
index 11f661a2494b..227c20d09258 100644
--- a/mm/kasan/hw_tags.c
+++ b/mm/kasan/hw_tags.c
@@ -257,6 +257,21 @@ static void unpoison_vmalloc_pages(const void *addr, u8 tag)
 	}
 }
 
+/*
+ * Explicit initialization of pages if KASAN does not handle VM_ALLOC
+ * allocations.
+ */
+static void init_vmalloc_pages_explicit(const void *start, unsigned long size)
+{
+	const void *addr;
+
+	for (addr = start; addr < start + size; addr += PAGE_SIZE) {
+		struct page *page = virt_to_page(addr);
+
+		clear_highpage_kasan_tagged(page);
+	}
+}
+
 void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 				kasan_vmalloc_flags_t flags)
 {
@@ -264,19 +279,8 @@ void *__kasan_unpoison_vmalloc(const void *start, unsigned long size,
 	unsigned long redzone_start, redzone_size;
 
 	if (!kasan_vmalloc_enabled() || !is_vmalloc_or_module_addr(start)) {
-		struct page *page;
-		const void *addr;
-
-		/* Initialize memory if required. */
-
-		if (!(flags & KASAN_VMALLOC_INIT))
-			return (void *)start;
-
-		for (addr = start; addr < start + size; addr += PAGE_SIZE) {
-			page = virt_to_page(addr);
-			clear_highpage_kasan_tagged(page);
-		}
-
+		if (flags & KASAN_VMALLOC_INIT)
+			init_vmalloc_pages_explicit(start, size);
 		return (void *)start;
 	}
 
