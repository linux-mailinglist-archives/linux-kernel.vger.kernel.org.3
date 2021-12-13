Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0CD4730A3
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:34:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240170AbhLMPeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:34:12 -0500
Received: from foss.arm.com ([217.140.110.172]:58324 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240168AbhLMPeK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:34:10 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2A7FA1FB;
        Mon, 13 Dec 2021 07:34:10 -0800 (PST)
Received: from [10.0.0.183] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A20B13F73B;
        Mon, 13 Dec 2021 07:34:06 -0800 (PST)
Subject: Re: [PATCH v2 28/34] kasan, vmalloc: add vmalloc support to HW_TAGS
To:     andrey.konovalov@linux.dev, Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Evgenii Stepanov <eugenis@google.com>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
References: <cover.1638825394.git.andreyknvl@google.com>
 <72a8a7aa09eb279d7eabf7ea1101556d13360950.1638825394.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <b777d2d2-421c-8854-e895-988ddc4ff9a6@arm.com>
Date:   Mon, 13 Dec 2021 15:34:00 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <72a8a7aa09eb279d7eabf7ea1101556d13360950.1638825394.git.andreyknvl@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrey,

On 12/6/21 9:44 PM, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> This patch adds vmalloc tagging support to HW_TAGS KASAN.
> 

Can we reorganize the patch description in line with what I commented on patch 24?

> The key difference between HW_TAGS and the other two KASAN modes
> when it comes to vmalloc: HW_TAGS KASAN can only assign tags to
> physical memory. The other two modes have shadow memory covering
> every mapped virtual memory region.
> 
> This patch makes __kasan_unpoison_vmalloc() for HW_TAGS KASAN:
> 
> - Skip non-VM_ALLOC mappings as HW_TAGS KASAN can only tag a single
>   mapping of normal physical memory; see the comment in the function.
> - Generate a random tag, tag the returned pointer and the allocation,
>   and initialize the allocation at the same time.
> - Propagate the tag into the page stucts to allow accesses through
>   page_address(vmalloc_to_page()).
> 
> The rest of vmalloc-related KASAN hooks are not needed:
> 
> - The shadow-related ones are fully skipped.
> - __kasan_poison_vmalloc() is kept as a no-op with a comment.
> 
> Poisoning and zeroing of physical pages that are backing vmalloc()
> allocations are skipped via __GFP_SKIP_KASAN_UNPOISON and
> __GFP_SKIP_ZERO: __kasan_unpoison_vmalloc() does that instead.
> 
> This patch allows enabling CONFIG_KASAN_VMALLOC with HW_TAGS
> and adjusts CONFIG_KASAN_VMALLOC description:
> 
> - Mention HW_TAGS support.
> - Remove unneeded internal details: they have no place in Kconfig
>   description and are already explained in the documentation.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
> 
> ---
> 
> Changes v1->v2:
> - Allow enabling CONFIG_KASAN_VMALLOC with HW_TAGS in this patch.
> - Move memory init for page_alloc pages backing vmalloc() into
>   kasan_unpoison_vmalloc().
> ---
>  include/linux/kasan.h | 30 +++++++++++++--
>  lib/Kconfig.kasan     | 20 +++++-----
>  mm/kasan/hw_tags.c    | 89 +++++++++++++++++++++++++++++++++++++++++++
>  mm/kasan/shadow.c     | 11 +++++-
>  mm/vmalloc.c          | 32 +++++++++++++---
>  5 files changed, 162 insertions(+), 20 deletions(-)
> 
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 6a2619759e93..0bdc2b824b9c 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -417,19 +417,40 @@ static inline void kasan_init_hw_tags(void) { }
>  
>  #ifdef CONFIG_KASAN_VMALLOC
>  
> +#if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
> +
>  void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
>  int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
>  void kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
>  			   unsigned long free_region_end);
>  
> +#else /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> +
> +static inline void kasan_populate_early_vm_area_shadow(void *start,
> +						       unsigned long size)
> +{ }
> +static inline int kasan_populate_vmalloc(unsigned long start,
> +					unsigned long size)
> +{
> +	return 0;
> +}
> +static inline void kasan_release_vmalloc(unsigned long start,
> +					 unsigned long end,
> +					 unsigned long free_region_start,
> +					 unsigned long free_region_end) { }
> +
> +#endif /* CONFIG_KASAN_GENERIC || CONFIG_KASAN_SW_TAGS */
> +
>  void * __must_check __kasan_unpoison_vmalloc(const void *start,
> -					     unsigned long size);
> +					     unsigned long size,
> +					     bool vm_alloc, bool init);
>  static __always_inline void * __must_check kasan_unpoison_vmalloc(
> -					const void *start, unsigned long size)
> +					const void *start, unsigned long size,
> +					bool vm_alloc, bool init)

Can we replace booleans with enumerations? It should make the code clearer on
the calling site.

...

With these changes:

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

---

Regards,
Vincenzo
