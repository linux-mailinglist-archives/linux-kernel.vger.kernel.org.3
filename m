Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627F05A434B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 08:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbiH2Gcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 02:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2Gce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 02:32:34 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9BF52DAB4
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:32:32 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id d5so3754003wms.5
        for <linux-kernel@vger.kernel.org>; Sun, 28 Aug 2022 23:32:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=55VuaBCh3zKQULMorjkhEtdo9YxgKyyc9DWx8OVsrmM=;
        b=Q9bG4C/lzqI/HkM4WnO4cpc4zH/UG8bBgrrBbgVdTS7NTL6FoUXymtUtiZUfLhdqlI
         vNzIoae9pjeuErhoyALL285mDB05G2HivjfavrPWWasdGfZT84ljgH4pYvpcNbsxUcLV
         Scd56sSMOoZmsJWX4b8B2QQ7QpRU4O5mCvX1JePJi5XRz9byLtTy+mhocyVmrumMRart
         snYeZv6DRt6CISmR49x82ARa3CCHmCzoPe8R7zutuqybLgFuiDijeQdE+D5jQ0/GP8eh
         vKOVYCPksydgN4/UL7Wx3rf/xkFtB8GAR3IB1EEAkom5tXbVaajM8S2Cmm7o52/u/r2q
         SoWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=55VuaBCh3zKQULMorjkhEtdo9YxgKyyc9DWx8OVsrmM=;
        b=fkFLx3g16MY87oD0mYwC2utf1h/qruIh+9PvqqLxUNmK2B3pn8TXNV49WyrEBO1HXK
         GraKdV7/PBrMS2sfGYpHQTD5kACBIBs7LLElEftoOfkJcNlLc/OwJzHfz6p87Pf/NfG4
         76MWidPW8EB6wOywm5MrGY46XHB9C0L9EfYWlRVUhDoFoE0bzPB1kRlUSgn85xWewuXu
         Biq5tk8aLnv5yM4hiQ525UjlxXwr2qijJDp2o317O2/zxHZG43ctmSVFVaXaRh67Btd6
         IlYNpo9jWCjA6z0+SSsMszODBU4rh1PU36aUBv4/tL3+jwMfMSLBlO+FUDjGN4iYZdvQ
         +UFA==
X-Gm-Message-State: ACgBeo0VaHOsZIqlZoW0lm8GCngeDLvHHeH9v319Vsk6DC+vdpWNge7S
        GvktNsgmn+iQGa15jxq66pnGYSkRZe4=
X-Google-Smtp-Source: AA6agR7uMSQAUXvqF4+Dz9AUFt0qYpHytKUamL8rcU5KLzy/nN2z/dASIkuI+13tvn2+7XALg52gYA==
X-Received: by 2002:a05:600c:348f:b0:3a5:e28c:a1d5 with SMTP id a15-20020a05600c348f00b003a5e28ca1d5mr5725442wmq.33.1661754751411;
        Sun, 28 Aug 2022 23:32:31 -0700 (PDT)
Received: from localhost ([2a03:b0c0:1:d0::dee:c001])
        by smtp.gmail.com with ESMTPSA id b8-20020adff908000000b00223a50b1be8sm6141149wrr.50.2022.08.28.23.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Aug 2022 23:32:30 -0700 (PDT)
Date:   Mon, 29 Aug 2022 06:32:30 +0000
From:   Stafford Horne <shorne@gmail.com>
To:     Baoquan He <bhe@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <Ywxdfs4t1fB1EYec@oscomms1>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-8-bhe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220820003125.353570-8-bhe@redhat.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 20, 2022 at 08:31:21AM +0800, Baoquan He wrote:
> Add hooks arch_ioremap() and arch_iounmap() for operisc's special
> operation when ioremap() and iounmap.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Jonas Bonn <jonas@southpole.se>
> Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> Cc: Stafford Horne <shorne@gmail.com>
> Cc: openrisc@lists.librecores.org
> ---
>  arch/openrisc/Kconfig          |  1 +
>  arch/openrisc/include/asm/io.h | 16 ++++++++---
>  arch/openrisc/mm/ioremap.c     | 51 +++++++++++-----------------------
>  3 files changed, 29 insertions(+), 39 deletions(-)
> 
> diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> index c7f282f60f64..fd9bb76a610b 100644
> --- a/arch/openrisc/Kconfig
> +++ b/arch/openrisc/Kconfig
> @@ -21,6 +21,7 @@ config OPENRISC
>  	select GENERIC_IRQ_PROBE
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_PCI_IOMAP
> +	select GENERIC_IOREMAP
>  	select GENERIC_CPU_DEVICES
>  	select HAVE_PCI
>  	select HAVE_UID16
> diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
> index ee6043a03173..9db67938bfc4 100644
> --- a/arch/openrisc/include/asm/io.h
> +++ b/arch/openrisc/include/asm/io.h
> @@ -15,6 +15,8 @@
>  #define __ASM_OPENRISC_IO_H
>  
>  #include <linux/types.h>
> +#include <asm/pgtable.h>
> +#include <asm/pgalloc.h>

This seems to cause a compilation issue when building virt_defconig:

      CC      kernel/irq/generic-chip.o
    In file included from ./include/asm-generic/pgtable-nopud.h:7,
		     from ./include/asm-generic/pgtable-nopmd.h:7,
		     from ./arch/openrisc/include/asm/pgtable.h:24,
		     from ./arch/openrisc/include/asm/io.h:18,
		     from ./include/linux/io.h:13,
		     from kernel/irq/generic-chip.c:7:
    ./include/asm-generic/pgtable-nop4d.h:9:18: error: unknown type name 'pgd_t'
	9 | typedef struct { pgd_t pgd; } p4d_t;
	  |                  ^~~~~

It works if we swap the order arround:

    +#include <asm/pgalloc.h>
    +#include <asm/pgtable.h>

Otherwise we need to add an asm/page.h include to asm/pgtable.h (which is more
correct) but means you would touch more files.

>  /*
>   * PCI: We do not use IO ports in OpenRISC
> @@ -27,11 +29,17 @@
>  #define PIO_OFFSET		0
>  #define PIO_MASK		0
>  
> -#define ioremap ioremap
> -void __iomem *ioremap(phys_addr_t offset, unsigned long size);
> +/*
> + * I/O memory mapping functions.
> + */
> +void __iomem *
> +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
> +#define arch_ioremap arch_ioremap
> +
> +int arch_iounmap(void __iomem *addr);
> +#define arch_iounmap arch_iounmap
>  
> -#define iounmap iounmap
> -extern void iounmap(volatile void __iomem *addr);
> +#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
>  
>  #include <asm-generic/io.h>
>  
> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> index 8ec0dafecf25..bc41660e1fb0 100644
> --- a/arch/openrisc/mm/ioremap.c
> +++ b/arch/openrisc/mm/ioremap.c
> @@ -24,26 +24,18 @@ extern int mem_init_done;
>  
>  static unsigned int fixmaps_used __initdata;
>  
> -/*
> - * Remap an arbitrary physical address space into the kernel virtual
> - * address space. Needed when the kernel wants to access high addresses
> - * directly.
> - *
> - * NOTE! We need to allow non-page-aligned mappings too: we will obviously
> - * have to convert them into an offset in a page-aligned mapping, but the
> - * caller shouldn't need to know that small detail.
> - */
> -void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
> +void __iomem *
> +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
>  {
>  	phys_addr_t p;
>  	unsigned long v;
> -	unsigned long offset, last_addr;
> -	struct vm_struct *area = NULL;
> +	unsigned long offset, last_addr, addr = *paddr;
> +	int ret = -EINVAL;
>  
>  	/* Don't allow wraparound or zero size */
>  	last_addr = addr + size - 1;
>  	if (!size || last_addr < addr)
> -		return NULL;
> +		return IOMEM_ERR_PTR(ret);
>  
>  	/*
>  	 * Mappings have to be page-aligned
> @@ -52,32 +44,24 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
>  	p = addr & PAGE_MASK;
>  	size = PAGE_ALIGN(last_addr + 1) - p;
>  
> -	if (likely(mem_init_done)) {
> -		area = get_vm_area(size, VM_IOREMAP);
> -		if (!area)
> -			return NULL;
> -		v = (unsigned long)area->addr;
> -	} else {
> +	if (unlikely(!mem_init_done)) {
>  		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> -			return NULL;
> +			return IOMEM_ERR_PTR(ret);
>  		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
>  		fixmaps_used += (size >> PAGE_SHIFT);
> -	}
>  
> -	if (ioremap_page_range(v, v + size, p,
> -			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
> -		if (likely(mem_init_done))
> -			vfree(area->addr);
> -		else
> +		if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
>  			fixmaps_used -= (size >> PAGE_SHIFT);
> -		return NULL;
> +			return IOMEM_ERR_PTR(ret);
> +		}
> +
> +		return (void __iomem *)(offset + (char *)v);
>  	}
>  
> -	return (void __iomem *)(offset + (char *)v);
> +	return NULL;
>  }
> -EXPORT_SYMBOL(ioremap);
>  
> -void iounmap(volatile void __iomem *addr)
> +int arch_iounmap(void __iomem *addr)
>  {
>  	/* If the page is from the fixmap pool then we just clear out
>  	 * the fixmap mapping.
> @@ -97,13 +81,10 @@ void iounmap(volatile void __iomem *addr)
>  		 *   ii) invalid accesses to the freed areas aren't made
>  		 */
>  		flush_tlb_all();
> -		return;
> +		return -EINVAL;
>  	}
> -
> -	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
> +	return 0;
>  }
> -EXPORT_SYMBOL(iounmap);
> -
>  /**
>   * OK, this one's a bit tricky... ioremap can get called before memory is
>   * initialized (early serial console does this) and will want to alloc a page
> -- 
> 2.34.1

Other than that compiler issue, I fixed it and test booted this and it works
well.

Acked-by: Stafford Horne <shorne@gmail.com>

