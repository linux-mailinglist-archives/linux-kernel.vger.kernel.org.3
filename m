Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A0C5478266
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 02:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbhLQBu1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 20:50:27 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:52332 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229662AbhLQBu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 20:50:26 -0500
X-UUID: 7e41e068975f4003b105575a15179857-20211217
X-UUID: 7e41e068975f4003b105575a15179857-20211217
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 316835896; Fri, 17 Dec 2021 09:50:21 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 17 Dec 2021 09:50:20 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 17 Dec
 2021 09:50:20 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 17 Dec 2021 09:50:20 +0800
Message-ID: <bf06044e10b5eae36c9ac6ad0d56c77b35ca8585.camel@mediatek.com>
Subject: Re: [PATCH mm v3 28/38] kasan, page_alloc: allow skipping memory
 init for HW_TAGS
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "Will Deacon" <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        <kuan-ying.lee@mediatek.com>
Date:   Fri, 17 Dec 2021 09:50:19 +0800
In-Reply-To: <cd8667450f7a0daf6b4081276e11a5f7bed60128.1639432170.git.andreyknvl@google.com>
References: <cover.1639432170.git.andreyknvl@google.com>
         <cd8667450f7a0daf6b4081276e11a5f7bed60128.1639432170.git.andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2021-12-14 at 05:54 +0800, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Add a new GFP flag __GFP_SKIP_ZERO that allows to skip memory
> initialization. The flag is only effective with HW_TAGS KASAN.
> 
> This flag will be used by vmalloc code for page_alloc allocations
> backing vmalloc() mappings in a following patch. The reason to skip
> memory initialization for these pages in page_alloc is because
> vmalloc
> code will be initializing them instead.
> 
> With the current implementation, when __GFP_SKIP_ZERO is provided,
> __GFP_ZEROTAGS is ignored. This doesn't matter, as these two flags
> are
> never provided at the same time. However, if this is changed in the
> future, this particular implementation detail can be changed as well.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> 
> ---
> 
> Changes v2->v3:
> - Update patch description.
> 
> Changes v1->v2:
> - Add this patch.
> ---
>  include/linux/gfp.h | 16 +++++++++++-----
>  mm/page_alloc.c     | 13 ++++++++++++-
>  2 files changed, 23 insertions(+), 6 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 6781f84345d1..b8b1a7198186 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -54,10 +54,11 @@ struct vm_area_struct;
>  #define ___GFP_THISNODE		0x200000u
>  #define ___GFP_ACCOUNT		0x400000u
>  #define ___GFP_ZEROTAGS		0x800000u
> -#define ___GFP_SKIP_KASAN_UNPOISON	0x1000000u
> -#define ___GFP_SKIP_KASAN_POISON	0x2000000u
> +#define ___GFP_SKIP_ZERO	0x1000000u
> +#define ___GFP_SKIP_KASAN_UNPOISON	0x2000000u
> +#define ___GFP_SKIP_KASAN_POISON	0x4000000u
>  #ifdef CONFIG_LOCKDEP
> -#define ___GFP_NOLOCKDEP	0x4000000u
> +#define ___GFP_NOLOCKDEP	0x8000000u
>  #else
>  #define ___GFP_NOLOCKDEP	0
>  #endif
> @@ -230,7 +231,11 @@ struct vm_area_struct;
>   * %__GFP_ZERO returns a zeroed page on success.
>   *
>   * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the
> memory itself
> - * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
> + * is being zeroed (either via __GFP_ZERO or via init_on_alloc,
> provided that
> + * __GFP_SKIP_ZERO is not set).
> + *
> + * %__GFP_SKIP_ZERO makes page_alloc skip zeroing memory.
> + * Only effective when HW_TAGS KASAN is enabled.
>   *
>   * %__GFP_SKIP_KASAN_UNPOISON makes KASAN skip unpoisoning on page
> allocation.
>   * Only effective in HW_TAGS mode.
> @@ -242,6 +247,7 @@ struct vm_area_struct;
>  #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
>  #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
>  #define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
> +#define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
>  #define __GFP_SKIP_KASAN_UNPOISON ((__force
> gfp_t)___GFP_SKIP_KASAN_UNPOISON)
>  #define __GFP_SKIP_KASAN_POISON   ((__force
> gfp_t)___GFP_SKIP_KASAN_POISON)
>  
> @@ -249,7 +255,7 @@ struct vm_area_struct;
>  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
>  
>  /* Room for N __GFP_FOO bits */
> -#define __GFP_BITS_SHIFT (26 + IS_ENABLED(CONFIG_LOCKDEP))
> +#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
>  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) -
> 1))
>  
>  /**
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index f1d5b80591c4..af7516a2d5ea 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2409,10 +2409,21 @@ static inline bool
> should_skip_kasan_unpoison(gfp_t flags, bool init_tags)
>  	return init_tags || (flags & __GFP_SKIP_KASAN_UNPOISON);
>  }
>  
> +static inline bool should_skip_init(gfp_t flags)
> +{
> +	/* Don't skip if a software KASAN mode is enabled. */
> +	if (!IS_ENABLED(CONFIG_KASAN_HW_TAGS))
> +		return false;
> +

Hi Andrey,

Should we use kasan_hw_tags_enabled() in should_skip_init() function
instead of checking the config?

I think we should handle the condition which is CONFIG_KASAN_HW_TAGS=y
and command line="kasan=off".


> +	/* For hardware tag-based KASAN, skip if requested. */
> +	return (flags & __GFP_SKIP_ZERO);
> +}
> +
>  inline void post_alloc_hook(struct page *page, unsigned int order,
>  				gfp_t gfp_flags)
>  {
> -	bool init = !want_init_on_free() &&
> want_init_on_alloc(gfp_flags);
> +	bool init = !want_init_on_free() &&
> want_init_on_alloc(gfp_flags) &&
> +			!should_skip_init(gfp_flags);
>  	bool init_tags = init && (gfp_flags & __GFP_ZEROTAGS);
>  
>  	set_page_private(page, 0);
> -- 
> 2.25.1
> 
> 

