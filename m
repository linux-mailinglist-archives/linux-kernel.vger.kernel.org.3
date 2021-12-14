Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C11A474A42
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 19:00:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236825AbhLNSAo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 13:00:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233980AbhLNSAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 13:00:43 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F0FC061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:00:42 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id a83-20020a1c9856000000b00344731e044bso1412588wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 10:00:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+IqBfvBvBmcxlYVp+0RytaxVZtHRcBsFFTjJF1k6GHc=;
        b=syl17ArW/Ro29Zbp9gxKSi9F6jrmZBzC7sLm3nzXi7EDGIQAhTsYLLNgRXk//55C88
         FXwHZ4tjhLDscHK5n5Dc+L4fYzfAOUzN7KLxxGPCDCjo/OKaYq2czOXm+aWWSaQPikgD
         /By7bPwufuY0ptkpd2PNguMeBSwB+FFn+a3R8Q052GW/FrMn+vWAxAhXePCGp+AVHmol
         AqR1Qbscl47KT1NtO+1CpZYcaswAb8GIrg2HyXea0ttGSEeejRWKX/Js1p5f/YMOQOuy
         atrdpDXS/SwpEffOTYA/SMzSkIZwFj9/Sz7xu5tJZu8D9GPTVOgeemIpI/ZPrNSn1MHA
         CvVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+IqBfvBvBmcxlYVp+0RytaxVZtHRcBsFFTjJF1k6GHc=;
        b=B7An01v6nHcrKlxxBRoZodgL/hkllLgRlWYW07R2Xh0tQeRQedGWG+S/cInz2gsPEI
         KmW0F1kSOGckw5nF0CaXZFzB0pUgU6DEJ801iGPbGrxkw+FvWZHIhM/5tTcRHvnWbQ1t
         xQAo/4uieDEHw0aE7LqA2OoUChiPXDyZ8rdAvE7fa53J6BlR3z/dnFAu92XOpoAFsbhg
         TEFE1d+d0IAMHN2RWG+DAFAaUZ/RogV74ZSth1gX6RLj4S5Z1qRrZ4mDhbWNFW9pdRAc
         AH4dtmdXJ+9i5UZgWcexA+eSbvaMZNTy3rvvFvww65YRxJktAY40ElgPkMfUZlxzRvG/
         L1Pg==
X-Gm-Message-State: AOAM532vH9Q5E0EyKsE41fGSzOylm+n7wzIe4qcHJ2o9yBZbeNNw8xUi
        ULzwej/kLdvMWzC7s/OsuBTtug==
X-Google-Smtp-Source: ABdhPJx8XGNeI01OLB/kBYng+fTDxbTRqMS8BklKCp38WxzksFwtBiBht2PK8HWQTUdS3kbX1RMVJg==
X-Received: by 2002:a1c:f217:: with SMTP id s23mr694802wmc.70.1639504841398;
        Tue, 14 Dec 2021 10:00:41 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:15:13:b1a9:56e:da78:fa44])
        by smtp.gmail.com with ESMTPSA id n36sm1316753wmr.2.2021.12.14.10.00.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 10:00:40 -0800 (PST)
Date:   Tue, 14 Dec 2021 19:00:35 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH mm v3 28/38] kasan, page_alloc: allow skipping memory
 init for HW_TAGS
Message-ID: <Ybjbw5iPg2BWsgqF@elver.google.com>
References: <cover.1639432170.git.andreyknvl@google.com>
 <cd8667450f7a0daf6b4081276e11a5f7bed60128.1639432170.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd8667450f7a0daf6b4081276e11a5f7bed60128.1639432170.git.andreyknvl@google.com>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 10:54PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Add a new GFP flag __GFP_SKIP_ZERO that allows to skip memory
> initialization. The flag is only effective with HW_TAGS KASAN.
[...]
> - * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
> + * is being zeroed (either via __GFP_ZERO or via init_on_alloc, provided that
> + * __GFP_SKIP_ZERO is not set).
> + *
> + * %__GFP_SKIP_ZERO makes page_alloc skip zeroing memory.
> + * Only effective when HW_TAGS KASAN is enabled.
>   *
>   * %__GFP_SKIP_KASAN_UNPOISON makes KASAN skip unpoisoning on page allocation.
>   * Only effective in HW_TAGS mode.
> @@ -242,6 +247,7 @@ struct vm_area_struct;
>  #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
>  #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
>  #define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
> +#define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
>  #define __GFP_SKIP_KASAN_UNPOISON ((__force gfp_t)___GFP_SKIP_KASAN_UNPOISON)
>  #define __GFP_SKIP_KASAN_POISON   ((__force gfp_t)___GFP_SKIP_KASAN_POISON)
>  
> @@ -249,7 +255,7 @@ struct vm_area_struct;
>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>  
>  /* Room for N __GFP_FOO bits */
> -#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
> +#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))

You're adding several new flags, I think you should also make a
corresponding change to include/trace/events/mmflags.h?

At least __GFP_SKIP_KASAN_POISON is currently in there.
