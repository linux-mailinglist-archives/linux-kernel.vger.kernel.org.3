Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E187482D8F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 03:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbiACCdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 21:33:00 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:36680 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231346AbiACCc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 21:32:59 -0500
X-UUID: 18dc1dbfd22c420398ecef977ad9a2e2-20220103
X-UUID: 18dc1dbfd22c420398ecef977ad9a2e2-20220103
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1170971578; Mon, 03 Jan 2022 10:32:57 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 3 Jan 2022 10:32:56 +0800
Received: from mtksdccf07 (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 3 Jan 2022 10:32:56 +0800
Message-ID: <b968e485f4d7f201fdb4e39f64ca757180e7374a.camel@mediatek.com>
Subject: Re: [PATCH mm v5 29/39] kasan, page_alloc: allow skipping memory
 init for HW_TAGS
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     "andrey.konovalov@linux.dev" <andrey.konovalov@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Konovalov <andreyknvl@google.com>,
        <Kuan-Ying.Lee@mediatek.com>
Date:   Mon, 3 Jan 2022 10:32:55 +0800
In-Reply-To: <88f2964f4063aa6fd935ef8c8302d02d8d67005b.1640891329.git.andreyknvl@google.com>
References: <cover.1640891329.git.andreyknvl@google.com>
         <88f2964f4063aa6fd935ef8c8302d02d8d67005b.1640891329.git.andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2021-12-31 at 03:14 +0800, andrey.konovalov@linux.dev wrote:
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
> Changes v4->v5:
> - Cosmetic changes to __def_gfpflag_names_kasan and __GFP_BITS_SHIFT.
> 
> Changes v3->v4:
> - Only define __GFP_SKIP_ZERO when CONFIG_KASAN_HW_TAGS is enabled.
> - Add __GFP_SKIP_ZERO to include/trace/events/mmflags.h.
> - Use proper kasan_hw_tags_enabled() check instead of
>   IS_ENABLED(CONFIG_KASAN_HW_TAGS). Also add explicit checks for
>   software modes.
> 
> Changes v2->v3:
> - Update patch description.
> 
> Changes v1->v2:
> - Add this patch.
> ---
>  include/linux/gfp.h            | 18 +++++++++++-------
>  include/trace/events/mmflags.h |  1 +
>  mm/page_alloc.c                | 18 +++++++++++++++++-
>  3 files changed, 29 insertions(+), 8 deletions(-)
> 
> diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> index 487126f089e1..6eef3e447540 100644
> --- a/include/linux/gfp.h
> +++ b/include/linux/gfp.h
> @@ -55,14 +55,16 @@ struct vm_area_struct;
>  #define ___GFP_ACCOUNT		0x400000u
>  #define ___GFP_ZEROTAGS		0x800000u
>  #ifdef CONFIG_KASAN_HW_TAGS
> -#define ___GFP_SKIP_KASAN_UNPOISON	0x1000000u
> -#define ___GFP_SKIP_KASAN_POISON	0x2000000u
> +#define ___GFP_SKIP_ZERO		0x1000000u
> +#define ___GFP_SKIP_KASAN_UNPOISON	0x2000000u
> +#define ___GFP_SKIP_KASAN_POISON	0x4000000u
>  #else
> +#define ___GFP_SKIP_ZERO		0
>  #define ___GFP_SKIP_KASAN_UNPOISON	0
>  #define ___GFP_SKIP_KASAN_POISON	0
>  #endif
>  #ifdef CONFIG_LOCKDEP
> -#define ___GFP_NOLOCKDEP	0x4000000u
> +#define ___GFP_NOLOCKDEP	0x8000000u
>  #else
>  #define ___GFP_NOLOCKDEP	0
>  #endif
> @@ -235,9 +237,10 @@ struct vm_area_struct;
>   * %__GFP_ZERO returns a zeroed page on success.
>   *
>   * %__GFP_ZEROTAGS zeroes memory tags at allocation time if the
> memory itself
> - * is being zeroed (either via __GFP_ZERO or via init_on_alloc).
> This flag is
> - * intended for optimization: setting memory tags at the same time
> as zeroing
> - * memory has minimal additional performace impact.
> + * is being zeroed (either via __GFP_ZERO or via init_on_alloc,
> provided that
> + * __GFP_SKIP_ZERO is not set). This flag is intended for
> optimization: setting
> + * memory tags at the same time as zeroing memory has minimal
> additional
> + * performace impact.
>   *
>   * %__GFP_SKIP_KASAN_UNPOISON makes KASAN skip unpoisoning on page
> allocation.
>   * Only effective in HW_TAGS mode.
> @@ -249,6 +252,7 @@ struct vm_area_struct;
>  #define __GFP_COMP	((__force gfp_t)___GFP_COMP)
>  #define __GFP_ZERO	((__force gfp_t)___GFP_ZERO)
>  #define __GFP_ZEROTAGS	((__force gfp_t)___GFP_ZEROTAGS)
> +#define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
>  #define __GFP_SKIP_KASAN_UNPOISON ((__force
> gfp_t)___GFP_SKIP_KASAN_UNPOISON)
>  #define __GFP_SKIP_KASAN_POISON   ((__force
> gfp_t)___GFP_SKIP_KASAN_POISON)
>  
> @@ -257,7 +261,7 @@ struct vm_area_struct;
>  
>  /* Room for N __GFP_FOO bits */
>  #define __GFP_BITS_SHIFT (24 +					
> 	\
> -			  2 * IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
> +			  3 * IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
>  			  IS_ENABLED(CONFIG_LOCKDEP))
>  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) -
> 1))
>  
> diff --git a/include/trace/events/mmflags.h
> b/include/trace/events/mmflags.h
> index 5ffc7bdce91f..0698c5d0f194 100644
> --- a/include/trace/events/mmflags.h
> +++ b/include/trace/events/mmflags.h
> @@ -52,6 +52,7 @@
>  
>  #ifdef CONFIG_KASAN_HW_TAGS
>  #define __def_gfpflag_names_kasan ,					
>        \
> +	{(unsigned long)__GFP_SKIP_ZERO,	   "__GFP_SKIP_ZERO"},	     
>   \
>  	{(unsigned
> long)__GFP_SKIP_KASAN_POISON,   "__GFP_SKIP_KASAN_POISON"}, \
>  	{(unsigned long)__GFP_SKIP_KASAN_UNPOISON,
> "__GFP_SKIP_KASAN_UNPOISON"}
>  #else
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 102f0cd8815e..30da0e1f94f8 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -2415,10 +2415,26 @@ static inline bool
> should_skip_kasan_unpoison(gfp_t flags, bool init_tags)
>  	return init_tags || (flags & __GFP_SKIP_KASAN_UNPOISON);
>  }
>  
> +static inline bool should_skip_init(gfp_t flags)
> +{
> +	/* Don't skip if a software KASAN mode is enabled. */
> +	if (IS_ENABLED(CONFIG_KASAN_GENERIC) ||
> +	    IS_ENABLED(CONFIG_KASAN_SW_TAGS))
> +		return false;

Forget to drop the above check?

I saw v4 mentioned that this check can be dropped. [1]

Do I miss something?

[1] https://lkml.org/lkml/2021/12/30/450

> +
> +	/* Don't skip, if hardware tag-based KASAN is not enabled. */
> +	if (!kasan_hw_tags_enabled())
> +		return false;
> +
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

