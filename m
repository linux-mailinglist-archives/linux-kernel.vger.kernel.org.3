Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAC315A7974
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 10:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiHaIvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 04:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbiHaIvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 04:51:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A042ACACA0
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661935847;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BcuExXOje6YQsvLQPHuRRDjqA+jrbJ+6wXiicLOONYo=;
        b=Lim4u0ocyvjVcdunFtcS5oPaYu+qqUUJoqOwscgeymc14OSTW6nM7kivWv1bBw9sGUDqGe
        KZqpn2HHo283I0dPrBaa12BgcFF4YM0TsaW3ku0AjBaDWNMZoWBznEYHwHXNh/0q5menFv
        d7eUN+jPyNyRLe7TAjC03oCj7D8SdIE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-508-MWdj9omAOaSzhl6Kj6s-nw-1; Wed, 31 Aug 2022 04:50:46 -0400
X-MC-Unique: MWdj9omAOaSzhl6Kj6s-nw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4B9AE800124;
        Wed, 31 Aug 2022 08:50:45 +0000 (UTC)
Received: from localhost (ovpn-13-50.pek2.redhat.com [10.72.13.50])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 991F51415133;
        Wed, 31 Aug 2022 08:50:42 +0000 (UTC)
Date:   Wed, 31 Aug 2022 16:50:38 +0800
From:   Baoquan He <bhe@redhat.com>
To:     Niklas Schnelle <schnelle@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2 09/11] s390: mm: Convert to GENERIC_IOREMAP
Message-ID: <Yw8g3igVMrlde0QA@MiWiFi-R3L-srv>
References: <20220820003125.353570-1-bhe@redhat.com>
 <20220820003125.353570-10-bhe@redhat.com>
 <376889563c9da4d6f97ea8a412697e0867a0d4bd.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <376889563c9da4d6f97ea8a412697e0867a0d4bd.camel@linux.ibm.com>
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Niklas,

On 08/23/22 at 02:30pm, Niklas Schnelle wrote:
> On Sat, 2022-08-20 at 08:31 +0800, Baoquan He wrote:
> > Add hooks arch_ioremap() and arch_iounmap() for s390's special
> > operation when ioremap() and iounmap(), then ioremap_[wc|wt]() are
> > converted to use ioremap_prot() from GENERIC_IOREMAP.
> > 
> > Signed-off-by: Baoquan He <bhe@redhat.com>
> > Cc: Heiko Carstens <hca@linux.ibm.com>
> > Cc: Vasily Gorbik <gor@linux.ibm.com>
> > Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> > Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> > Cc: Sven Schnelle <svens@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > ---
> >  arch/s390/Kconfig          |  1 +
> >  arch/s390/include/asm/io.h | 26 +++++++++++------
> >  arch/s390/pci/pci.c        | 60 +++++---------------------------------
> >  3 files changed, 26 insertions(+), 61 deletions(-)
> > 
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index 318fce77601d..c59e1b25f59d 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -135,6 +135,7 @@ config S390
> >  	select GENERIC_SMP_IDLE_THREAD
> >  	select GENERIC_TIME_VSYSCALL
> >  	select GENERIC_VDSO_TIME_NS
> > +	select GENERIC_IOREMAP
> >  	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
> >  	select HAVE_ARCH_AUDITSYSCALL
> >  	select HAVE_ARCH_JUMP_LABEL
> > diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> > index e3882b012bfa..f837e20b7bbd 100644
> > --- a/arch/s390/include/asm/io.h
> > +++ b/arch/s390/include/asm/io.h
> > @@ -22,11 +22,23 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
> >  
> >  #define IO_SPACE_LIMIT 0
> >  
> > -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
> > -void __iomem *ioremap(phys_addr_t addr, size_t size);
> > -void __iomem *ioremap_wc(phys_addr_t addr, size_t size);
> > -void __iomem *ioremap_wt(phys_addr_t addr, size_t size);
> > -void iounmap(volatile void __iomem *addr);
> > +
> 

Thanks a lot for reviewing, and sorry for late response.

> Checkpatch nitpick, remove the empty line addition above so as not to
> create two consecutive empty lines.

Will do, thanks.

> 
> > +/*
> > + * I/O memory mapping functions.
> > + */
> > +void __iomem *
> > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
> > +#define arch_ioremap arch_ioremap
> > +
> > +int arch_iounmap(void __iomem *addr);
> > +#define arch_iounmap arch_iounmap
> > +
> > +#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
> > +
> > +#define ioremap_wc(addr, size)  \
> > +	ioremap_prot((addr), (size), pgprot_val(pgprot_writecombine(PAGE_KERNEL)))
> > +#define ioremap_wt(addr, size)  \
> > +	ioremap_prot((addr), (size), pgprot_val(pgprot_writethrough(PAGE_KERNEL)))
> >  
> >  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
> >  {
> > @@ -51,10 +63,6 @@ static inline void ioport_unmap(void __iomem *p)
> >  #define pci_iomap_wc pci_iomap_wc
> >  #define pci_iomap_wc_range pci_iomap_wc_range
> >  
> > -#define ioremap ioremap
> > -#define ioremap_wt ioremap_wt
> > -#define ioremap_wc ioremap_wc
> > -
> >  #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
> >  #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
> >  #define memset_io(dst, val, count)	zpci_memset_io(dst, val, count)
> > diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> > index 73cdc5539384..984cad9cd5a1 100644
> > --- a/arch/s390/pci/pci.c
> > +++ b/arch/s390/pci/pci.c
> > @@ -244,64 +244,20 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
> >         zpci_memcpy_toio(to, from, count);
> >  }
> >  
> > -static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
> > +void __iomem *
> > +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
> >  {
> > -	unsigned long offset, vaddr;
> > -	struct vm_struct *area;
> > -	phys_addr_t last_addr;
> > -
> > -	last_addr = addr + size - 1;
> > -	if (!size || last_addr < addr)
> > -		return NULL;
> > -
> >  	if (!static_branch_unlikely(&have_mio))
> > -		return (void __iomem *) addr;
> > -
> > -	offset = addr & ~PAGE_MASK;
> > -	addr &= PAGE_MASK;
> > -	size = PAGE_ALIGN(size + offset);
> > -	area = get_vm_area(size, VM_IOREMAP);
> > -	if (!area)
> > -		return NULL;
> > -
> > -	vaddr = (unsigned long) area->addr;
> > -	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
> > -		free_vm_area(area);
> > -		return NULL;
> > -	}
> > -	return (void __iomem *) ((unsigned long) area->addr + offset);
> > -}
> > -
> > -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> > -{
> > -	return __ioremap(addr, size, __pgprot(prot));
> > +		return (void __iomem *) *paddr;
> 
> Another checkpatch nitpick no space after the cast.

Will fix.

> 
> > +	return NULL;
> >  }
> > -EXPORT_SYMBOL(ioremap_prot);
> >  
> > -void __iomem *ioremap(phys_addr_t addr, size_t size)
> > +int arch_iounmap(void __iomem *addr)
> >  {
> > -	return __ioremap(addr, size, PAGE_KERNEL);
> > -}
> > -EXPORT_SYMBOL(ioremap);
> > -
> > -void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
> > -{
> > -	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
> > -}
> > -EXPORT_SYMBOL(ioremap_wc);
> > -
> > -void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
> > -{
> > -	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
> > -}
> > -EXPORT_SYMBOL(ioremap_wt);
> > -
> > -void iounmap(volatile void __iomem *addr)
> > -{
> > -	if (static_branch_likely(&have_mio))
> > -		vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
> > +	if (!static_branch_likely(&have_mio))
> > +		return -EINVAL;
> 
> As Christoph suggested this might be a good opportunity to add a
> comment for this branch.
> 
> One other nitpick. The return value doesn't really matter here since
> anything != NULL turns iounmap() into a no-op so this looks correct but
> semantically I think returning -EINVAL wrongly suggests that addr was
> invalid. Maybe -ENXIO would be better at conveying that there is
> nothing to unmap.
> 
> Looking at your patch 1 another idea would be to have 3 kinds of return
> values for arch_iounmap() too e.g.:
> 
>  arch_iounmap() return an __iomem pointer
>    - IS_ERR means skip vunmap and return directly
>    - NULL means continue to vunmap
>    - a non-NULL, non-IS_ERR pointer has been unmapped successfully

I agree with you, The returned -EINVAL does cause confusion.

I checked all ARCHes related in this patchset, we only do the arch
specific address filtering (or address checking), then call vunmap().
Seems no error case or error handling in iounmap(). I'm thinking if
we should make the return value as boolean value. Ture indicates
address checking passed, false indicates not passed.


> 
> Then we would simply return addr in case of
> !static_branch_likely(&have_mio) and NULL otherwise.
> 
> What do you think? Either way no strong opinion on my side,
> functionally it makes no difference.
> 
> > +	return 0;
> >  }
> > -EXPORT_SYMBOL(iounmap);
> >  
> >  /* Create a virtual mapping cookie for a PCI BAR */
> >  static void __iomem *pci_iomap_range_fh(struct pci_dev *pdev, int bar,
> 
> Apart from the above nitpicks and suggestion this looks good to me.
> I did also test this with and without PCI MIO support including use of
> PCI MIO instructions in user-space (added in rdma-core v40).
> 
> So feel free to add:
> Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
> Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>
> 
> Since it looks like there will be a v3 due to other comments anyway
> please Cc me on that directly and I'm sure I can upgrade the Acked-by
> to Reviewed-by when we're closer to the final code.

Sure, I will add you in Cc when repost. Thank again for these details.


> 

