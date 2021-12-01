Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9ECD5464F64
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 15:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349759AbhLAONg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 09:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349750AbhLAON2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 09:13:28 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D182C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 06:10:05 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id l16so52539615wrp.11
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 06:10:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=aUvgIVEScJ2chwYi4PLdpPCh/e6Qof2JA3Rw4wY6NeM=;
        b=KUnaUN2PNTK/x7spFYPPquL7JGhJnuKP77ipiJILvdOG/Y2DJ/DEUIXzal57vgLUIV
         Cabps9cVEDaB6qHXt2jEf7Fvu2kN0GKIe+g1sFJ/wKpJ0GG3S57tSeTIDx0ct/wgi8pG
         hrjYoB3WTMbTY1vWR6ZQNNk9nvDa3BHhFfCoAtSL1zjRYbF1f2kWg4vTMDI8/07DEniy
         j7ErHCLAuYHiu3XxZe5hazjh0Vpvffrv6EoxpnvfIauAWhLwPkRcmytVTHglJOjT9eUe
         8zJZxNh3fHGPwqoz0ZouznAZPw7wVipWixCOvYXpcY62NNKxYMyEjdeC1VB0fEbcTLCc
         E6kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aUvgIVEScJ2chwYi4PLdpPCh/e6Qof2JA3Rw4wY6NeM=;
        b=SOsSUX9TtuwlGAnE5wlNIYzQRrO/KPLnDVdHTvpTv0ggzfVxHZHoKhw1XB9dy3MWdn
         dWORupC578bYYAvMlG07a6jpnbOIdwWAMJ8ZmnvQEfCxewddXU93voMEYB3nu89YDyPt
         myD/WCQkEGWbdyeH8TTBl1DmjRAN6mE5KpzKx3IuhKy7lf0nio73xEFSgagIAn6XHYYL
         X9mygfxrR2Vd+hG0CmcuLd4FPXpx7B7N6NH2LzTfBpsmwNyI2sCNucPQ9/GS8AIoSXYO
         4NfqDWj+rmKg8pH/uSUtx9GGHU9e6LXDAemZA0hPWake+qLApNgXTQm5nqNvj+7o3Enz
         PuSw==
X-Gm-Message-State: AOAM532j/6+Ue0vY/uMYfs1iq7GubxlGT9XiHe/TmxD+ND4hkQdjfxY0
        IpO1TNBsjB2/w/izzeXYk15cJA==
X-Google-Smtp-Source: ABdhPJzykwV4hr6ZfUUQXvfgwBoaE3LE+ImTY7GtLFjEdbZ/Yd8kTcyj9WFwDYjClESvftHYnoDIFQ==
X-Received: by 2002:a5d:59ab:: with SMTP id p11mr7011310wrr.340.1638367803580;
        Wed, 01 Dec 2021 06:10:03 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:95ad:1401:cf07:6d1a])
        by smtp.gmail.com with ESMTPSA id k8sm19121353wrn.91.2021.12.01.06.10.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 06:10:02 -0800 (PST)
Date:   Wed, 1 Dec 2021 15:09:56 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 04/31] kasan, page_alloc: simplify kasan_poison_pages
 call site
Message-ID: <YaeCNIyblUAk5mmI@elver.google.com>
References: <cover.1638308023.git.andreyknvl@google.com>
 <b28f30ed5d662439fd2354b7a05e4d58a2889e5f.1638308023.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b28f30ed5d662439fd2354b7a05e4d58a2889e5f.1638308023.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 30, 2021 at 10:39PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Simplify the code around calling kasan_poison_pages() in
> free_pages_prepare().
> 
> Reording kasan_poison_pages() and kernel_init_free_pages() is OK,
> since kernel_init_free_pages() can handle poisoned memory.

Why did they have to be reordered?

> This patch does no functional changes besides reordering the calls.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  mm/page_alloc.c | 18 +++++-------------
>  1 file changed, 5 insertions(+), 13 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3f3ea41f8c64..0673db27dd12 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1289,6 +1289,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  {
>  	int bad = 0;
>  	bool skip_kasan_poison = should_skip_kasan_poison(page, fpi_flags);

skip_kasan_poison is only used once now, so you could remove the
variable -- unless later code will use it in more than once place again.

> +	bool init = want_init_on_free();
>  
>  	VM_BUG_ON_PAGE(PageTail(page), page);
>  
> @@ -1359,19 +1360,10 @@ static __always_inline bool free_pages_prepare(struct page *page,
>  	 * With hardware tag-based KASAN, memory tags must be set before the
>  	 * page becomes unavailable via debug_pagealloc or arch_free_page.
>  	 */
> -	if (kasan_has_integrated_init()) {
> -		bool init = want_init_on_free();
> -
> -		if (!skip_kasan_poison)
> -			kasan_poison_pages(page, order, init);
> -	} else {
> -		bool init = want_init_on_free();
> -
> -		if (init)
> -			kernel_init_free_pages(page, 1 << order);
> -		if (!skip_kasan_poison)
> -			kasan_poison_pages(page, order, init);
> -	}
> +	if (!skip_kasan_poison)
> +		kasan_poison_pages(page, order, init);
> +	if (init && !kasan_has_integrated_init())
> +		kernel_init_free_pages(page, 1 << order);
>  
>  	/*
>  	 * arch_free_page() can make the page's contents inaccessible.  s390
> -- 
> 2.25.1
