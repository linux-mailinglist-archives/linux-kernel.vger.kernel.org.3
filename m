Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856D45A6447
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:01:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230055AbiH3NBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:01:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229802AbiH3NBJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:01:09 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B110C67C89
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661864466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iv6IMkbAGjUEL0iKdewetvnAmdcUSjAh3M2r1ewdBzU=;
        b=W5KM0VExCa3t5a0AZr2Kk8WRUVp7wfvwGmXEYzqrNBtl7oFmsgbjt72iV7G2jb8+3WRBzZ
        uHngRMdGhRZqS3PvluAR4lkqjZZkT55EkawHr4KVE0MeLodD3hJHcd1EYhgB+LcgyHFgTJ
        XRU/1Q7f0U6KBKYxJDkalkRZwFpkQx4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-F-0no9dBN3OrFadA13g47g-1; Tue, 30 Aug 2022 09:01:05 -0400
X-MC-Unique: F-0no9dBN3OrFadA13g47g-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A034385A58D;
        Tue, 30 Aug 2022 13:01:03 +0000 (UTC)
Received: from localhost (ovpn-12-78.pek2.redhat.com [10.72.12.78])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 4B8A640CFD05;
        Tue, 30 Aug 2022 13:01:01 +0000 (UTC)
Date:   Tue, 30 Aug 2022 21:00:57 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>, deller@gmx.de
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: Re: [PATCH v2 08/11] parisc: mm: Convert to GENERIC_IOREMAP
Message-ID: <Yw4KCQxAJonhQNKu@MiWiFi-R3L-srv>
References: <20220820003125.353570-9-bhe@redhat.com>
 <202208201135.YyN9CXsu-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208201135.YyN9CXsu-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 08/20/22 at 12:03pm, kernel test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: parisc-randconfig-r005-20220820 (https://download.01.org/0day-ci/archive/20220820/202208201135.YyN9CXsu-lkp@intel.com/config)
> compiler: hppa-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/570f2a3347cc83c9ea71d3dbbebfad8ea085ecc6
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
>         git checkout 570f2a3347cc83c9ea71d3dbbebfad8ea085ecc6
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc prepare
> 
> If you fix the issue, kindly add following tag where applicable
> Reported-by: kernel test robot <lkp@intel.com>

I finally installed below RPM packages and run command to reproduce
the build errors. Thanks for your help, Helge.

binutils-hppa64-linux-gnu
gcc-hppa64-linux-gnu
binutils-hppa-linux-gnu
gcc-hppa-linux-gnu
make ARCH=parisc defconfig
make ARCH=parisc -j320 CROSS_COMPILE=/usr/bin/hppa-linux-gnu-
make ARCH=parisc64 defconfig
make ARCH=parisc64 -j320 CROSS_COMPILE=/usr/bin/hppa64-linux-gnu-

The below draft patch can fix all build errors. There are some symbol
declaration or defination conflict among asm-generic/io.h,
asm-generic/iomap.h, asm-generic/pci-iomap.h and asm/io.h. Some of them
may need be taken out to be an independent patch since it could be a
generic issue if enable GENERIC_IOREMAP. I saw the build error on superH
too.

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 614e21d9749f..879578edf342 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -126,7 +126,7 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
  * I/O memory mapping functions.
  */
 void __iomem *
-arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long prot);
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
 #define arch_ioremap arch_ioremap
 
 #define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | \
@@ -137,6 +137,8 @@ arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long prot);
 #define ioremap_uc(addr, size)  \
 	ioremap_prot((addr), (size), _PAGE_IOREMAP)
 
+#define ARCH_HAS_IOREMAP_WC
+
 static inline unsigned char __raw_readb(const volatile void __iomem *addr)
 {
 	return (*(volatile unsigned char __force *) (addr));
@@ -205,6 +207,15 @@ static inline void writeq(unsigned long long q, volatile void __iomem *addr)
 	__raw_writeq((__u64 __force) cpu_to_le64(q), addr);
 }
 
+#define __raw_readb __raw_readb
+#define __raw_readw __raw_readw
+#define __raw_readl __raw_readl
+#define __raw_readq __raw_readq
+#define __raw_writeb __raw_writeb
+#define __raw_writew __raw_writew
+#define __raw_writel __raw_writel
+#define __raw_writeq __raw_writeq
+
 #define	readb	readb
 #define	readw	readw
 #define	readl	readl
@@ -223,6 +234,9 @@ static inline void writeq(unsigned long long q, volatile void __iomem *addr)
 #define writel_relaxed(l, addr)	writel(l, addr)
 #define writeq_relaxed(q, addr)	writeq(q, addr)
 
+#define memset_io memset_io
+#define memcpy_fromio memcpy_fromio
+#define memcpy_toio memcpy_toio
 void memset_io(volatile void __iomem *addr, unsigned char val, int count);
 void memcpy_fromio(void *dst, const volatile void __iomem *src, int count);
 void memcpy_toio(volatile void __iomem *dst, const void *src, int count);
@@ -244,10 +258,17 @@ extern void eisa_out16(unsigned short data, unsigned short port);
 extern void eisa_out32(unsigned int data, unsigned short port);
 
 #if defined(CONFIG_PCI)
+#define inb inb
+#define inw inw
+#define inl inl
 extern unsigned char inb(int addr);
 extern unsigned short inw(int addr);
 extern unsigned int inl(int addr);
 
+#define outb outb
+#define outw outw
+#define outl outl
+#define inl inl
 extern void outb(unsigned char b, int addr);
 extern void outw(unsigned short b, int addr);
 extern void outl(unsigned int b, int addr);
@@ -292,6 +313,13 @@ extern void outsb (unsigned long port, const void *src, unsigned long count);
 extern void outsw (unsigned long port, const void *src, unsigned long count);
 extern void outsl (unsigned long port, const void *src, unsigned long count);
 
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+
 
 /* IO Port space is :      BBiiii   where BB is HBA number. */
 #define IO_SPACE_LIMIT 0x00ffffff
@@ -320,6 +348,7 @@ extern void iowrite64be(u64 val, void __iomem *addr);
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
+#include <asm-generic/io.h>
 extern int devmem_is_allowed(unsigned long pfn);
 
 #endif
diff --git a/include/asm-generic/iomap.h b/include/asm-generic/iomap.h
index 08237ae8b840..7bf3581ecb0e 100644
--- a/include/asm-generic/iomap.h
+++ b/include/asm-generic/iomap.h
@@ -26,12 +26,19 @@
  * in the low address range. Architectures for which this is not
  * true can't use this generic implementation.
  */
+#define ioread8 ioread8
+#define ioread16 ioread16
+#define ioread16be ioread16be
+#define ioread32 ioread32
+#define ioread32be ioread32be
 extern unsigned int ioread8(const void __iomem *);
 extern unsigned int ioread16(const void __iomem *);
 extern unsigned int ioread16be(const void __iomem *);
 extern unsigned int ioread32(const void __iomem *);
 extern unsigned int ioread32be(const void __iomem *);
 #ifdef CONFIG_64BIT
+#define ioread64 ioread64
+#define ioread64be ioread64be
 extern u64 ioread64(const void __iomem *);
 extern u64 ioread64be(const void __iomem *);
 #endif
@@ -47,12 +54,19 @@ extern u64 ioread64be_lo_hi(const void __iomem *addr);
 extern u64 ioread64be_hi_lo(const void __iomem *addr);
 #endif
 
+#define iowrite8 iowrite8
+#define iowrite16 iowrite16
+#define iowrite16be iowrite16be
+#define iowrite32 iowrite32
+#define iowrite32be iowrite32be
 extern void iowrite8(u8, void __iomem *);
 extern void iowrite16(u16, void __iomem *);
 extern void iowrite16be(u16, void __iomem *);
 extern void iowrite32(u32, void __iomem *);
 extern void iowrite32be(u32, void __iomem *);
 #ifdef CONFIG_64BIT
+#define iowrite64 iowrite64
+#define iowrite64be iowrite64be
 extern void iowrite64(u64, void __iomem *);
 extern void iowrite64be(u64, void __iomem *);
 #endif
@@ -79,16 +93,24 @@ extern void iowrite64be_hi_lo(u64 val, void __iomem *addr);
  * memory across multiple ports, use "memcpy_toio()"
  * and friends.
  */
+#define ioread8_rep ioread8_rep
+#define ioread16_rep ioread16_rep
+#define ioread32_rep ioread32_rep
 extern void ioread8_rep(const void __iomem *port, void *buf, unsigned long count);
 extern void ioread16_rep(const void __iomem *port, void *buf, unsigned long count);
 extern void ioread32_rep(const void __iomem *port, void *buf, unsigned long count);
 
+#define iowrite8_rep iowrite8_rep
+#define iowrite16_rep iowrite16_rep
+#define iowrite32_rep iowrite32_rep
 extern void iowrite8_rep(void __iomem *port, const void *buf, unsigned long count);
 extern void iowrite16_rep(void __iomem *port, const void *buf, unsigned long count);
 extern void iowrite32_rep(void __iomem *port, const void *buf, unsigned long count);
 
 #ifdef CONFIG_HAS_IOPORT_MAP
 /* Create a virtual mapping cookie for an IO port range */
+#define ioport_map ioport_map
+#define ioport_unmap ioport_unmap
 extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
 extern void ioport_unmap(void __iomem *);
 #endif
diff --git a/include/asm-generic/pci_iomap.h b/include/asm-generic/pci_iomap.h
index 8fbb0a55545d..f6889ea449fa 100644
--- a/include/asm-generic/pci_iomap.h
+++ b/include/asm-generic/pci_iomap.h
@@ -19,6 +19,7 @@ extern void __iomem *pci_iomap_wc_range(struct pci_dev *dev, int bar,
 					unsigned long offset,
 					unsigned long maxlen);
 extern void pci_iounmap(struct pci_dev *dev, void __iomem *);
+#define pci_iounmap pci_iounmap
 /* Create a virtual mapping cookie for a port on a given PCI device.
  * Do not call this directly, it exists to make it easier for architectures
  * to override */

