Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0067C516D79
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384275AbiEBJlO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 05:41:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384251AbiEBJlJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 05:41:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9CCBCE09B
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 02:37:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 274661FB;
        Mon,  2 May 2022 02:37:40 -0700 (PDT)
Received: from [10.163.32.39] (unknown [10.163.32.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E9D673F774;
        Mon,  2 May 2022 02:37:33 -0700 (PDT)
Message-ID: <204421f9-a0d9-35bb-ea86-ea4cea3b4f83@arm.com>
Date:   Mon, 2 May 2022 15:08:30 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 1/5] mm: ioremap: Use more sensibly name in
 ioremap_prot()
Content-Language: en-US
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, hch@infradead.org, arnd@arndb.de
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
 <20220429103225.75121-2-wangkefeng.wang@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220429103225.75121-2-wangkefeng.wang@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/29/22 16:02, Kefeng Wang wrote:
> Use more meaningful and sensibly naming phys_addr
> instead addr in ioremap_prot().
> 
> Suggested-by: Andrew Morton <akpm@linux-foundation.org>
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  include/asm-generic/io.h |  2 +-
>  mm/ioremap.c             | 12 ++++++------
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index 7ce93aaf69f8..e6ffa2519f08 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -964,7 +964,7 @@ static inline void iounmap(volatile void __iomem *addr)
>  #elif defined(CONFIG_GENERIC_IOREMAP)
>  #include <linux/pgtable.h>
>  
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
>  void iounmap(volatile void __iomem *addr);
>  
>  static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
> diff --git a/mm/ioremap.c b/mm/ioremap.c
> index 5fe598ecd9b7..1f9597fbcc07 100644
> --- a/mm/ioremap.c
> +++ b/mm/ioremap.c
> @@ -11,20 +11,20 @@
>  #include <linux/io.h>
>  #include <linux/export.h>
>  
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> +void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot)
>  {
>  	unsigned long offset, vaddr;
>  	phys_addr_t last_addr;
>  	struct vm_struct *area;
>  
>  	/* Disallow wrap-around or zero size */
> -	last_addr = addr + size - 1;
> -	if (!size || last_addr < addr)
> +	last_addr = phys_addr + size - 1;
> +	if (!size || last_addr < phys_addr)
>  		return NULL;
>  
>  	/* Page-align mappings */
> -	offset = addr & (~PAGE_MASK);
> -	addr -= offset;
> +	offset = phys_addr & (~PAGE_MASK);
> +	phys_addr -= offset;
>  	size = PAGE_ALIGN(size + offset);
>  
>  	area = get_vm_area_caller(size, VM_IOREMAP,
> @@ -33,7 +33,7 @@ void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
>  		return NULL;
>  	vaddr = (unsigned long)area->addr;
>  
> -	if (ioremap_page_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
> +	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, __pgprot(prot))) {
>  		free_vm_area(area);
>  		return NULL;
>  	}
