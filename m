Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13EB452CB44
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 06:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233792AbiESErF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 00:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232714AbiESErD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 00:47:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDEA4689B4
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 21:47:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 75F141042;
        Wed, 18 May 2022 21:47:01 -0700 (PDT)
Received: from [10.162.42.8] (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 750223F73D;
        Wed, 18 May 2022 21:46:58 -0700 (PDT)
Message-ID: <871657f3-9c26-a56a-03d2-29b1915001c9@arm.com>
Date:   Thu, 19 May 2022 10:16:55 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 3/5] mm: ioremap: Add arch_ioremap/iounmap()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, hch@infradead.org, arnd@arndb.de
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
 <20220429103225.75121-4-wangkefeng.wang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220429103225.75121-4-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

On 4/29/22 16:02, Kefeng Wang wrote:
> Add special hook for architecture to verify addr, size and prot
> or setup when ioremap() or iounmap(), which will make the generic
> ioremap more useful.
> 
>   arch_ioremap() return a 'void __iomem *',
>     - IS_ERR means return an error
>     - NULL means continue to remap
>     - a non-NULL, non-IS_ERR pointer is directly returned
>   arch_iounmap() return a int value,
>     - 0 means continue to vunmap
>     - error code means skip vunmap and return directly

Should not these comments be also included as in-code documentation, possibly
near generic fall back stubs for arch_ioremap()/arch_iounmap() in the header
include/asm-generic/io.h ?

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> ---
>  include/asm-generic/io.h | 14 ++++++++++++++
>  mm/ioremap.c             | 14 +++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index e6ffa2519f08..f2f9aeedb5e8 100644
> --- a/include/asm-generic/io.h
> +++ b/arch_iounmap
> @@ -964,6 +964,20 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>  
> +#ifndef arch_ioremap
> +static inline void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot)
> +{
> +	return NULL;
> +}
> +#endif
> +
> +#ifndef arch_iounmap
> +static inline int arch_iounmap(void __iomem *addr)
> +{
> +	return 0;
> +}
> +#endif

There is a function in arch/arm/ with exact same name although the platform does
not enable GENERIC_IOREMAP. That function would require renaming for these arch
callbacks to be added here in GENERIC_IOREMAP path. Otherwise, it might be just
confusing later.

git grep "arch_iounmap" arch/arm/

arch/arm/include/asm/io.h:extern void (*arch_iounmap)(volatile void __iomem *);
arch/arm/mm/ioremap.c:void (*arch_iounmap)(volatile void __iomem *) = __iounmap;
arch/arm/mm/ioremap.c:  arch_iounmap(cookie);
arch/arm/mm/nommu.c:void (*arch_iounmap)(volatile void __iomem *);

> +
>  void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
>  void iounmap(volatile void __iomem *addr);
>  
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 7cb9996b0c12..de5a2e899e14 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -16,6 +16,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
>  	unsigned long offset, vaddr;
>  	phys_addr_t last_addr;
>  	struct vm_struct *area;
> +	void __iomem *base;
>  
>  	/* Disallow wrap-around or zero size */
>  	last_addr = phys_addr + size - 1;
> @@ -27,6 +28,12 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
>  	phys_addr -= offset;
>  	size = PAGE_ALIGN(size + offset);
>  
> +	base = arch_ioremap(phys_addr, size, prot);
> +	if (IS_ERR(base))
> +		return NULL;
> +	else if (base)
> +		return base;
> +
>  	area = get_vm_area_caller(size, VM_IOREMAP,
>  			__builtin_return_address(0));
>  	if (!area)
> @@ -45,6 +52,11 @@ EXPORT_SYMBOL(ioremap_prot);
>  
>  void iounmap(volatile void __iomem *addr)
>  {
> -	vunmap((void *)((unsigned long)addr & PAGE_MASK));
> +	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);

Should not this variable be 'void __iomem *vaddr' instead, like above in
ioremap_prot(). Because arch_iounmap() takes 'void __iomem *' instead.

> +
> +	if (arch_iounmap(vaddr))
> +		return;
> +
> +	vunmap(vaddr);
>  }
>  EXPORT_SYMBOL(iounmap);
- Anshuman
