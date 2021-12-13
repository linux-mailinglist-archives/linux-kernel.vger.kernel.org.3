Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7A5473044
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 16:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240049AbhLMPRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 10:17:30 -0500
Received: from foss.arm.com ([217.140.110.172]:57838 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230072AbhLMPR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 10:17:29 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DC612D6E;
        Mon, 13 Dec 2021 07:17:28 -0800 (PST)
Received: from [10.0.0.183] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2D7D43F73B;
        Mon, 13 Dec 2021 07:17:24 -0800 (PST)
Subject: Re: [PATCH v2 24/34] kasan, vmalloc, arm64: mark vmalloc mappings as
 pgprot_tagged
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
 <a1f0413493eb7db125c3f8086f5d8635b627fd2c.1638825394.git.andreyknvl@google.com>
From:   Vincenzo Frascino <vincenzo.frascino@arm.com>
Message-ID: <d082aa66-8b6b-2a32-bf7e-8256b9ec3cc4@arm.com>
Date:   Mon, 13 Dec 2021 15:17:22 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <a1f0413493eb7db125c3f8086f5d8635b627fd2c.1638825394.git.andreyknvl@google.com>
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
> HW_TAGS KASAN relies on ARM Memory Tagging Extension (MTE). With MTE,
> a memory region must be mapped as MT_NORMAL_TAGGED to allow setting
> memory tags via MTE-specific instructions.
> 
> This change adds proper protection bits to vmalloc() allocations.

Please avoid "this patch/this change" in patch description and use imperative
mode as if you are giving a command to the code base ([1] paragraph 2).

> These allocations are always backed by page_alloc pages, so the tags
> will actually be getting set on the corresponding physical memory.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> Co-developed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

With the change to the commit message:

Signed-off-by: Vincenzo Frascino <vincenzo.frascino@arm.com>

> ---
>  arch/arm64/include/asm/vmalloc.h | 10 ++++++++++
>  include/linux/vmalloc.h          |  7 +++++++
>  mm/vmalloc.c                     |  2 ++
>  3 files changed, 19 insertions(+)
> 
> diff --git a/arch/arm64/include/asm/vmalloc.h b/arch/arm64/include/asm/vmalloc.h
> index b9185503feae..3d35adf365bf 100644
> --- a/arch/arm64/include/asm/vmalloc.h
> +++ b/arch/arm64/include/asm/vmalloc.h
> @@ -25,4 +25,14 @@ static inline bool arch_vmap_pmd_supported(pgprot_t prot)
>  
>  #endif
>  
> +#define arch_vmalloc_pgprot_modify arch_vmalloc_pgprot_modify
> +static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
> +{
> +	if (IS_ENABLED(CONFIG_KASAN_HW_TAGS) &&
> +			(pgprot_val(prot) == pgprot_val(PAGE_KERNEL)))
> +		prot = pgprot_tagged(prot);
> +
> +	return prot;
> +}
> +
>  #endif /* _ASM_ARM64_VMALLOC_H */
> diff --git a/include/linux/vmalloc.h b/include/linux/vmalloc.h
> index b22369f540eb..965c4bf475f1 100644
> --- a/include/linux/vmalloc.h
> +++ b/include/linux/vmalloc.h
> @@ -108,6 +108,13 @@ static inline int arch_vmap_pte_supported_shift(unsigned long size)
>  }
>  #endif
>  
> +#ifndef arch_vmalloc_pgprot_modify
> +static inline pgprot_t arch_vmalloc_pgprot_modify(pgprot_t prot)
> +{
> +	return prot;
> +}
> +#endif
> +
>  /*
>   *	Highlevel APIs for driver use
>   */
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 7be18b292679..f37d0ed99bf9 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3033,6 +3033,8 @@ void *__vmalloc_node_range(unsigned long size, unsigned long align,
>  		return NULL;
>  	}
>  
> +	prot = arch_vmalloc_pgprot_modify(prot);
> +
>  	if (vmap_allow_huge && !(vm_flags & VM_NO_HUGE_VMAP)) {
>  		unsigned long size_per_node;
>  
> 

-- 
Regards,
Vincenzo
