Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600CA59E5A5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 17:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242896AbiHWPGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 11:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244146AbiHWPF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 11:05:57 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19426153017;
        Tue, 23 Aug 2022 05:30:51 -0700 (PDT)
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27NCQFvv019729;
        Tue, 23 Aug 2022 12:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=0npaJrcwr/1u22VhfyYvdTUsR3qJhjDBMzgoWkFuwzs=;
 b=h0wLI/tNLdpOmNkiXkwfFED/1V5D/fv6GNsEhvnmQwv8LNooyVjhj1hzZvzzZGZ6bfed
 5B0pyUEOwGZVQB6nZC6wwhPxmAs115PAVJs0jDYTFQ5Kq8rLm7LhqW36XhbPKAlBzllz
 GmDELcZ+VLizjvPSswncis4fdwibwKbE9lC1pmPgOQnHi7mb8edMdkQGDb5EssweAz9X
 3loNyP+CQTFssQ7zx8jdYRj+3bnMQA2nOYdYdZRtiTuJKDEv4z6nZmehyfwCvYwqVLt9
 DvzS7LWn1XTiob0w3lW62kAdC2YJEev8O93ph620X10iGAkdLDWWw2zBv5m3ms5GjkDa rw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4xw5g2a8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 12:30:21 +0000
Received: from m0187473.ppops.net (m0187473.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 27NCU2JB033471;
        Tue, 23 Aug 2022 12:30:20 GMT
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3j4xw5g28k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 12:30:20 +0000
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 27NCNJ9L021768;
        Tue, 23 Aug 2022 12:30:18 GMT
Received: from b06cxnps3074.portsmouth.uk.ibm.com (d06relay09.portsmouth.uk.ibm.com [9.149.109.194])
        by ppma06ams.nl.ibm.com with ESMTP id 3j2pvj3srw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 Aug 2022 12:30:18 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 27NCUFdx32440776
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 23 Aug 2022 12:30:15 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3305F42041;
        Tue, 23 Aug 2022 12:30:15 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id BEDE142047;
        Tue, 23 Aug 2022 12:30:14 +0000 (GMT)
Received: from oc-nschnelle.boeblingen.de.ibm.com (unknown [9.155.199.46])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Tue, 23 Aug 2022 12:30:14 +0000 (GMT)
Message-ID: <376889563c9da4d6f97ea8a412697e0867a0d4bd.camel@linux.ibm.com>
Subject: Re: [PATCH v2 09/11] s390: mm: Convert to GENERIC_IOREMAP
From:   Niklas Schnelle <schnelle@linux.ibm.com>
To:     Baoquan He <bhe@redhat.com>, linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Date:   Tue, 23 Aug 2022 14:30:14 +0200
In-Reply-To: <20220820003125.353570-10-bhe@redhat.com>
References: <20220820003125.353570-1-bhe@redhat.com>
         <20220820003125.353570-10-bhe@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bzKEo_tu4kET95yAtSRkCupSln-3hD_9
X-Proofpoint-ORIG-GUID: TEislebOP0p_FPvz37-H8NxrCsfUGppc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-23_04,2022-08-22_02,2022-06-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 impostorscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 phishscore=0 mlxscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2207270000 definitions=main-2208230048
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2022-08-20 at 08:31 +0800, Baoquan He wrote:
> Add hooks arch_ioremap() and arch_iounmap() for s390's special
> operation when ioremap() and iounmap(), then ioremap_[wc|wt]() are
> converted to use ioremap_prot() from GENERIC_IOREMAP.
> 
> Signed-off-by: Baoquan He <bhe@redhat.com>
> Cc: Heiko Carstens <hca@linux.ibm.com>
> Cc: Vasily Gorbik <gor@linux.ibm.com>
> Cc: Alexander Gordeev <agordeev@linux.ibm.com>
> Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
> Cc: Sven Schnelle <svens@linux.ibm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/Kconfig          |  1 +
>  arch/s390/include/asm/io.h | 26 +++++++++++------
>  arch/s390/pci/pci.c        | 60 +++++---------------------------------
>  3 files changed, 26 insertions(+), 61 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 318fce77601d..c59e1b25f59d 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -135,6 +135,7 @@ config S390
>  	select GENERIC_SMP_IDLE_THREAD
>  	select GENERIC_TIME_VSYSCALL
>  	select GENERIC_VDSO_TIME_NS
> +	select GENERIC_IOREMAP
>  	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
>  	select HAVE_ARCH_AUDITSYSCALL
>  	select HAVE_ARCH_JUMP_LABEL
> diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
> index e3882b012bfa..f837e20b7bbd 100644
> --- a/arch/s390/include/asm/io.h
> +++ b/arch/s390/include/asm/io.h
> @@ -22,11 +22,23 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
>  
>  #define IO_SPACE_LIMIT 0
>  
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
> -void __iomem *ioremap(phys_addr_t addr, size_t size);
> -void __iomem *ioremap_wc(phys_addr_t addr, size_t size);
> -void __iomem *ioremap_wt(phys_addr_t addr, size_t size);
> -void iounmap(volatile void __iomem *addr);
> +

Checkpatch nitpick, remove the empty line addition above so as not to
create two consecutive empty lines.

> +/*
> + * I/O memory mapping functions.
> + */
> +void __iomem *
> +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
> +#define arch_ioremap arch_ioremap
> +
> +int arch_iounmap(void __iomem *addr);
> +#define arch_iounmap arch_iounmap
> +
> +#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
> +
> +#define ioremap_wc(addr, size)  \
> +	ioremap_prot((addr), (size), pgprot_val(pgprot_writecombine(PAGE_KERNEL)))
> +#define ioremap_wt(addr, size)  \
> +	ioremap_prot((addr), (size), pgprot_val(pgprot_writethrough(PAGE_KERNEL)))
>  
>  static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
>  {
> @@ -51,10 +63,6 @@ static inline void ioport_unmap(void __iomem *p)
>  #define pci_iomap_wc pci_iomap_wc
>  #define pci_iomap_wc_range pci_iomap_wc_range
>  
> -#define ioremap ioremap
> -#define ioremap_wt ioremap_wt
> -#define ioremap_wc ioremap_wc
> -
>  #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
>  #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
>  #define memset_io(dst, val, count)	zpci_memset_io(dst, val, count)
> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 73cdc5539384..984cad9cd5a1 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -244,64 +244,20 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
>         zpci_memcpy_toio(to, from, count);
>  }
>  
> -static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
> +void __iomem *
> +arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
>  {
> -	unsigned long offset, vaddr;
> -	struct vm_struct *area;
> -	phys_addr_t last_addr;
> -
> -	last_addr = addr + size - 1;
> -	if (!size || last_addr < addr)
> -		return NULL;
> -
>  	if (!static_branch_unlikely(&have_mio))
> -		return (void __iomem *) addr;
> -
> -	offset = addr & ~PAGE_MASK;
> -	addr &= PAGE_MASK;
> -	size = PAGE_ALIGN(size + offset);
> -	area = get_vm_area(size, VM_IOREMAP);
> -	if (!area)
> -		return NULL;
> -
> -	vaddr = (unsigned long) area->addr;
> -	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
> -		free_vm_area(area);
> -		return NULL;
> -	}
> -	return (void __iomem *) ((unsigned long) area->addr + offset);
> -}
> -
> -void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
> -{
> -	return __ioremap(addr, size, __pgprot(prot));
> +		return (void __iomem *) *paddr;

Another checkpatch nitpick no space after the cast.

> +	return NULL;
>  }
> -EXPORT_SYMBOL(ioremap_prot);
>  
> -void __iomem *ioremap(phys_addr_t addr, size_t size)
> +int arch_iounmap(void __iomem *addr)
>  {
> -	return __ioremap(addr, size, PAGE_KERNEL);
> -}
> -EXPORT_SYMBOL(ioremap);
> -
> -void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
> -}
> -EXPORT_SYMBOL(ioremap_wc);
> -
> -void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
> -{
> -	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
> -}
> -EXPORT_SYMBOL(ioremap_wt);
> -
> -void iounmap(volatile void __iomem *addr)
> -{
> -	if (static_branch_likely(&have_mio))
> -		vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
> +	if (!static_branch_likely(&have_mio))
> +		return -EINVAL;

As Christoph suggested this might be a good opportunity to add a
comment for this branch.

One other nitpick. The return value doesn't really matter here since
anything != NULL turns iounmap() into a no-op so this looks correct but
semantically I think returning -EINVAL wrongly suggests that addr was
invalid. Maybe -ENXIO would be better at conveying that there is
nothing to unmap.

Looking at your patch 1 another idea would be to have 3 kinds of return
values for arch_iounmap() too e.g.:

 arch_iounmap() return an __iomem pointer
   - IS_ERR means skip vunmap and return directly
   - NULL means continue to vunmap
   - a non-NULL, non-IS_ERR pointer has been unmapped successfully

Then we would simply return addr in case of
!static_branch_likely(&have_mio) and NULL otherwise.

What do you think? Either way no strong opinion on my side,
functionally it makes no difference.

> +	return 0;
>  }
> -EXPORT_SYMBOL(iounmap);
>  
>  /* Create a virtual mapping cookie for a PCI BAR */
>  static void __iomem *pci_iomap_range_fh(struct pci_dev *pdev, int bar,

Apart from the above nitpicks and suggestion this looks good to me.
I did also test this with and without PCI MIO support including use of
PCI MIO instructions in user-space (added in rdma-core v40).

So feel free to add:
Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Acked-by: Niklas Schnelle <schnelle@linux.ibm.com>

Since it looks like there will be a v3 due to other comments anyway
please Cc me on that directly and I'm sure I can upgrade the Acked-by
to Reviewed-by when we're closer to the final code.

