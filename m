Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237315A44E2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 10:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbiH2IUA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 04:20:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbiH2IT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 04:19:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13256E080
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 01:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661761195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F7P/ZjAfkCSPemarCbD5q5Qjvl0zNrpaxHX3SmkPK3U=;
        b=P6vsQvE8B3dXjanrm6+f1DEllvQZNz4+A1tOA1dyno2syTuukcpTYGzL27pyQLQGzwYL+O
        U2C0wRLT/suxFPocniQ1hKp/4c7osHlDRBWgpQeXzCNDoo2b73yxDHTLZ/YvbkpjmomFBy
        ObU3VMvTa2PClNcJbWdRymQxeIAx160=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-288-3mWRC6R1Nvum5zgvcutp-A-1; Mon, 29 Aug 2022 04:19:50 -0400
X-MC-Unique: 3mWRC6R1Nvum5zgvcutp-A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8357B29ABA1B;
        Mon, 29 Aug 2022 08:19:49 +0000 (UTC)
Received: from localhost (ovpn-12-153.pek2.redhat.com [10.72.12.153])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id AB8781121314;
        Mon, 29 Aug 2022 08:19:48 +0000 (UTC)
Date:   Mon, 29 Aug 2022 16:19:44 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Stafford Horne <shorne@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <Ywx2oNXOeFUZ8MPy@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-8-bhe@redhat.com>
 <Ywxdfs4t1fB1EYec@oscomms1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ywxdfs4t1fB1EYec@oscomms1>
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/29/22 at 06:32am, Stafford Horne wrote:
> On Sat, Aug 20, 2022 at 08:31:21AM +0800, Baoquan He wrote:
> > Add hooks arch_ioremap() and arch_iounmap() for operisc's special
> > operation when ioremap() and iounmap.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Jonas Bonn <jonas@southpole.se>
> > Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
> > Cc: Stafford Horne <shorne@gmail.com>
> > Cc: openrisc@lists.librecores.org
> > ---
> >  arch/openrisc/Kconfig          |  1 +
> >  arch/openrisc/include/asm/io.h | 16 ++++++++---
> >  arch/openrisc/mm/ioremap.c     | 51 +++++++++++-----------------------
> >  3 files changed, 29 insertions(+), 39 deletions(-)
> > 
> > diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
> > index c7f282f60f64..fd9bb76a610b 100644
> > --- a/arch/openrisc/Kconfig
> > +++ b/arch/openrisc/Kconfig
> > @@ -21,6 +21,7 @@ config OPENRISC
> >  	select GENERIC_IRQ_PROBE
> >  	select GENERIC_IRQ_SHOW
> >  	select GENERIC_PCI_IOMAP
> > +	select GENERIC_IOREMAP
> >  	select GENERIC_CPU_DEVICES
> >  	select HAVE_PCI
> >  	select HAVE_UID16
> > diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
> > index ee6043a03173..9db67938bfc4 100644
> > --- a/arch/openrisc/include/asm/io.h
> > +++ b/arch/openrisc/include/asm/io.h
> > @@ -15,6 +15,8 @@
> >  #define __ASM_OPENRISC_IO_H
> >  
> >  #include <linux/types.h>
> > +#include <asm/pgtable.h>
> > +#include <asm/pgalloc.h>
> 
> This seems to cause a compilation issue when building virt_defconig:
> 
>       CC      kernel/irq/generic-chip.o
>     In file included from ./include/asm-generic/pgtable-nopud.h:7,
> 		     from ./include/asm-generic/pgtable-nopmd.h:7,
> 		     from ./arch/openrisc/include/asm/pgtable.h:24,
> 		     from ./arch/openrisc/include/asm/io.h:18,
> 		     from ./include/linux/io.h:13,
> 		     from kernel/irq/generic-chip.c:7:
>     ./include/asm-generic/pgtable-nop4d.h:9:18: error: unknown type name 'pgd_t'
> 	9 | typedef struct { pgd_t pgd; } p4d_t;
> 	  |                  ^~~~~
> 
> It works if we swap the order arround:
> 
>     +#include <asm/pgalloc.h>
>     +#include <asm/pgtable.h>

Thanks a lot, add this change to patch.

> 
> Otherwise we need to add an asm/page.h include to asm/pgtable.h (which is more
> correct) but means you would touch more files.
> 
> >  /*
> >   * PCI: We do not use IO ports in OpenRISC
> > @@ -27,11 +29,17 @@
> >  #define PIO_OFFSET		0
> >  #define PIO_MASK		0
> >  
> > -#define ioremap ioremap
> > -void __iomem *ioremap(phys_addr_t offset, unsigned long size);
> > +/*
> > + * I/O memory mapping functions.
> > + */
> > +void __iomem *
> > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
> > +#define arch_ioremap arch_ioremap
> > +
> > +int arch_iounmap(void __iomem *addr);
> > +#define arch_iounmap arch_iounmap
> >  
> > -#define iounmap iounmap
> > -extern void iounmap(volatile void __iomem *addr);
> > +#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
> >  
> >  #include <asm-generic/io.h>
> >  
> > diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
> > index 8ec0dafecf25..bc41660e1fb0 100644
> > --- a/arch/openrisc/mm/ioremap.c
> > +++ b/arch/openrisc/mm/ioremap.c
> > @@ -24,26 +24,18 @@ extern int mem_init_done;
> >  
> >  static unsigned int fixmaps_used __initdata;
> >  
> > -/*
> > - * Remap an arbitrary physical address space into the kernel virtual
> > - * address space. Needed when the kernel wants to access high addresses
> > - * directly.
> > - *
> > - * NOTE! We need to allow non-page-aligned mappings too: we will obviously
> > - * have to convert them into an offset in a page-aligned mapping, but the
> > - * caller shouldn't need to know that small detail.
> > - */
> > -void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
> > +void __iomem *
> > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
> >  {
> >  	phys_addr_t p;
> >  	unsigned long v;
> > -	unsigned long offset, last_addr;
> > -	struct vm_struct *area = NULL;
> > +	unsigned long offset, last_addr, addr = *paddr;
> > +	int ret = -EINVAL;
> >  
> >  	/* Don't allow wraparound or zero size */
> >  	last_addr = addr + size - 1;
> >  	if (!size || last_addr < addr)
> > -		return NULL;
> > +		return IOMEM_ERR_PTR(ret);
> >  
> >  	/*
> >  	 * Mappings have to be page-aligned
> > @@ -52,32 +44,24 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
> >  	p = addr & PAGE_MASK;
> >  	size = PAGE_ALIGN(last_addr + 1) - p;
> >  
> > -	if (likely(mem_init_done)) {
> > -		area = get_vm_area(size, VM_IOREMAP);
> > -		if (!area)
> > -			return NULL;
> > -		v = (unsigned long)area->addr;
> > -	} else {
> > +	if (unlikely(!mem_init_done)) {
> >  		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
> > -			return NULL;
> > +			return IOMEM_ERR_PTR(ret);
> >  		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
> >  		fixmaps_used += (size >> PAGE_SHIFT);
> > -	}
> >  
> > -	if (ioremap_page_range(v, v + size, p,
> > -			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
> > -		if (likely(mem_init_done))
> > -			vfree(area->addr);
> > -		else
> > +		if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
> >  			fixmaps_used -= (size >> PAGE_SHIFT);
> > -		return NULL;
> > +			return IOMEM_ERR_PTR(ret);
> > +		}
> > +
> > +		return (void __iomem *)(offset + (char *)v);
> >  	}
> >  
> > -	return (void __iomem *)(offset + (char *)v);
> > +	return NULL;
> >  }
> > -EXPORT_SYMBOL(ioremap);
> >  
> > -void iounmap(volatile void __iomem *addr)
> > +int arch_iounmap(void __iomem *addr)
> >  {
> >  	/* If the page is from the fixmap pool then we just clear out
> >  	 * the fixmap mapping.
> > @@ -97,13 +81,10 @@ void iounmap(volatile void __iomem *addr)
> >  		 *   ii) invalid accesses to the freed areas aren't made
> >  		 */
> >  		flush_tlb_all();
> > -		return;
> > +		return -EINVAL;
> >  	}
> > -
> > -	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
> > +	return 0;
> >  }
> > -EXPORT_SYMBOL(iounmap);
> > -
> >  /**
> >   * OK, this one's a bit tricky... ioremap can get called before memory is
> >   * initialized (early serial console does this) and will want to alloc a page
> > -- 
> > 2.34.1
> 
> Other than that compiler issue, I fixed it and test booted this and it works
> well.
> 
> Acked-by: Stafford Horne <shorne@gmail.com>

Thanks, will add this tag when repost.

