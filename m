Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5375564A7F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 01:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231905AbiGCXP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 19:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbiGCXP5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 19:15:57 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 015C65FE3
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 16:15:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9502BB8015B
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8E80C341C6;
        Sun,  3 Jul 2022 23:15:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1656890153;
        bh=6ZlA7AQwed1b+Qbqhl49hZpBrdZGq0u3Y8Xc/8IfGvM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=I9H7MVvwCGyF5EotDM1U20idIoHdP25AYE3YpwidP8cFIoPSvTlU1Z79MBXQDiAN+
         U2ENsuk5lCHzaIsstSbPuR2Mm7MYzwGy+4XA3COkrhr3Iyyk8mJ1xrVBGeqJSEYxHZ
         c7Q8J/EwSTU2lHZPw6EGto+1c+WFT4P0LOJXoH9Y=
Date:   Sun, 3 Jul 2022 16:15:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
Cc:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <chinwen.chang@mediatek.com>, <yee.lee@mediatek.com>,
        <casper.li@mediatek.com>, <andrew.yang@mediatek.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: Re: [PATCH] kasan: separate double free case from invalid free
Message-Id: <20220703161552.6a3304c8d316e4fdcce42caa@linux-foundation.org>
In-Reply-To: <20220615062219.22618-1-Kuan-Ying.Lee@mediatek.com>
References: <20220615062219.22618-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Jun 2022 14:22:18 +0800 Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com> wrote:

> Currently, KASAN describes all invalid-free/double-free bugs as
> "double-free or invalid-free". This is ambiguous.
> 
> KASAN should report "double-free" when a double-free is a more
> likely cause (the address points to the start of an object) and
> report "invalid-free" otherwise [1].
> 
> [1] https://bugzilla.kernel.org/show_bug.cgi?id=212193
> 
> ...

Could we please have some review of this?

Thanks.

> 
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index c40c0e7b3b5f..707c3a527fcb 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -343,7 +343,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  
>  	if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
>  	    object)) {
> -		kasan_report_invalid_free(tagged_object, ip);
> +		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_INVALID_FREE);
>  		return true;
>  	}
>  
> @@ -352,7 +352,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
>  		return false;
>  
>  	if (!kasan_byte_accessible(tagged_object)) {
> -		kasan_report_invalid_free(tagged_object, ip);
> +		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_DOUBLE_FREE);
>  		return true;
>  	}
>  
> @@ -377,12 +377,12 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object,
>  static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
>  {
>  	if (ptr != page_address(virt_to_head_page(ptr))) {
> -		kasan_report_invalid_free(ptr, ip);
> +		kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
>  		return true;
>  	}
>  
>  	if (!kasan_byte_accessible(ptr)) {
> -		kasan_report_invalid_free(ptr, ip);
> +		kasan_report_invalid_free(ptr, ip, KASAN_REPORT_DOUBLE_FREE);
>  		return true;
>  	}
>  
> diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
> index 610d60d6e5b8..01c03e45acd4 100644
> --- a/mm/kasan/kasan.h
> +++ b/mm/kasan/kasan.h
> @@ -125,6 +125,7 @@ static inline bool kasan_sync_fault_possible(void)
>  enum kasan_report_type {
>  	KASAN_REPORT_ACCESS,
>  	KASAN_REPORT_INVALID_FREE,
> +	KASAN_REPORT_DOUBLE_FREE,
>  };
>  
>  struct kasan_report_info {
> @@ -277,7 +278,7 @@ static inline void kasan_print_address_stack_frame(const void *addr) { }
>  
>  bool kasan_report(unsigned long addr, size_t size,
>  		bool is_write, unsigned long ip);
> -void kasan_report_invalid_free(void *object, unsigned long ip);
> +void kasan_report_invalid_free(void *object, unsigned long ip, enum kasan_report_type type);
>  
>  struct page *kasan_addr_to_page(const void *addr);
>  struct slab *kasan_addr_to_slab(const void *addr);
> diff --git a/mm/kasan/report.c b/mm/kasan/report.c
> index b341a191651d..fe3f606b3a98 100644
> --- a/mm/kasan/report.c
> +++ b/mm/kasan/report.c
> @@ -176,8 +176,12 @@ static void end_report(unsigned long *flags, void *addr)
>  static void print_error_description(struct kasan_report_info *info)
>  {
>  	if (info->type == KASAN_REPORT_INVALID_FREE) {
> -		pr_err("BUG: KASAN: double-free or invalid-free in %pS\n",
> -		       (void *)info->ip);
> +		pr_err("BUG: KASAN: invalid-free in %pS\n", (void *)info->ip);
> +		return;
> +	}
> +
> +	if (info->type == KASAN_REPORT_DOUBLE_FREE) {
> +		pr_err("BUG: KASAN: double-free in %pS\n", (void *)info->ip);
>  		return;
>  	}
>  
> @@ -433,7 +437,7 @@ static void print_report(struct kasan_report_info *info)
>  	}
>  }
>  
> -void kasan_report_invalid_free(void *ptr, unsigned long ip)
> +void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_type type)
>  {
>  	unsigned long flags;
>  	struct kasan_report_info info;
> @@ -448,7 +452,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip)
>  
>  	start_report(&flags, true);
>  
> -	info.type = KASAN_REPORT_INVALID_FREE;
> +	info.type = type;
>  	info.access_addr = ptr;
>  	info.first_bad_addr = kasan_reset_tag(ptr);
>  	info.access_size = 0;
> -- 
> 2.18.0
> 
