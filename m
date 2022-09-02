Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29B865AABBC
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 11:48:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235646AbiIBJsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 05:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232755AbiIBJsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 05:48:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8668C9E81
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 02:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662112127;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L5hlwTGXpG9hUxZCZE5KZ7NE2krlb6FbDoRXg5yfQZY=;
        b=IbCiGoPSnbyDmYyKCxHc57iB95d0zIJwN4kb+qK9pdn8QfpqyWHI3poXc3/b5JgPcYny1O
        0RJRW470JPthpBOqTB6NJpv+urs3zCAoU2kMUNX3towpW7JkiXyR4dmauwesCmuNigv8kU
        i5QHBa+GzQe/QkTzwcCmwmNElO5YUzY=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-533-s4DrPB4TOryG3kiNBNPaMw-1; Fri, 02 Sep 2022 05:48:43 -0400
X-MC-Unique: s4DrPB4TOryG3kiNBNPaMw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9AD273C0ED64;
        Fri,  2 Sep 2022 09:48:42 +0000 (UTC)
Received: from localhost (ovpn-12-173.pek2.redhat.com [10.72.12.173])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 5809640C141D;
        Fri,  2 Sep 2022 09:48:40 +0000 (UTC)
Date:   Fri, 2 Sep 2022 17:48:37 +0800
From:   Baoquan He <bhe@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     linux-kernel@vger.kernel.org, kbuild-all@lists.01.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: Re: [PATCH v2 10/11] sh: mm: Convert to GENERIC_IOREMAP
Message-ID: <YxHRdQft06rIBM+j@MiWiFi-R3L-srv>
References: <20220820003125.353570-11-bhe@redhat.com>
 <202208201146.8VeY9pez-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202208201146.8VeY9pez-lkp@intel.com>
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/20/22 at 11:41am, kernel test robot wrote:
> Hi Baoquan,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on akpm-mm/mm-everything]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
> config: sh-allmodconfig
> compiler: sh4-linux-gcc (GCC) 12.1.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # https://github.com/intel-lab-lkp/linux/commit/503a31451202f89e58bc5f0a49261398fafbd90e
>         git remote add linux-review https://github.com/intel-lab-lkp/linux
>         git fetch --no-tags linux-review Baoquan-He/mm-ioremap-Convert-architectures-to-take-GENERIC_IOREMAP-way/20220820-083435
>         git checkout 503a31451202f89e58bc5f0a49261398fafbd90e
>         # save the config file
>         mkdir build_dir && cp config build_dir/.config
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh prepare

I finally find gcc-sh-linux-gnu and its dependency on rpmfind.net, and
succeeded to reproduce the building failure.
isl-0.16.1-13
cross-gcc-common
gcc-sh-linux-gnu

Based on previous fixing patch for parisc, below draft patch can fix all
reported building issues on sh.

diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index 3c5ff82a511a..eb550c72922d 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -225,6 +225,9 @@ __BUILD_IOPORT_STRING(q, u64)
 #define IO_SPACE_LIMIT 0xffffffff
 
 /* We really want to try and get these to memcpy etc */
+#define memset_io memset_io
+#define memcpy_fromio memcpy_fromio
+#define memcpy_toio memcpy_toio
 void memcpy_fromio(void *, const volatile void __iomem *, unsigned long);
 void memcpy_toio(volatile void __iomem *, const void *, unsigned long);
 void memset_io(volatile void __iomem *, int, unsigned long);
@@ -256,18 +259,17 @@ int arch_iounmap(void __iomem *addr);
 
 #define ioremap_cache(addr, size)  \
 	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
-#define ioremap_cache ioremap_cache
 
 #define ioremap_uc	ioremap
 
-#include <asm-generic/io.h>
-
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
  */
 #define xlate_dev_mem_ptr(p)	__va(p)
 
+#include <asm-generic/io.h>
+
 #define ARCH_HAS_VALID_PHYS_ADDR_RANGE
 int valid_phys_addr_range(phys_addr_t addr, size_t size);
 int valid_mmap_phys_addr_range(unsigned long pfn, size_t size);
diff --git a/arch/sh/include/asm/io_noioport.h b/arch/sh/include/asm/io_noioport.h
index f7938fe0f911..5ba4116b4265 100644
--- a/arch/sh/include/asm/io_noioport.h
+++ b/arch/sh/include/asm/io_noioport.h
@@ -53,6 +53,13 @@ static inline void ioport_unmap(void __iomem *addr)
 #define outw_p(x, addr)	outw((x), (addr))
 #define outl_p(x, addr)	outl((x), (addr))
 
+#define insb insb
+#define insw insw
+#define insl insl
+#define outsb outsb
+#define outsw outsw
+#define outsl outsl
+
 static inline void insb(unsigned long port, void *dst, unsigned long count)
 {
 	BUG();
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 720a9186b06b..725a1623675a 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -72,7 +72,7 @@ __ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
 #define __ioremap_29bit(offset, size, prot)		NULL
 #endif /* CONFIG_29BIT */
 
-void __iomem *
+void __iomem * __ref
 arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
 	unsigned long last_addr, phys_addr = *paddr;
@@ -102,7 +102,8 @@ arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 	 * First try to remap through the PMB.
 	 * PMB entries are all pre-faulted.
 	 */
-	mapped = pmb_remap_caller(phys_addr, size, pgprot, caller);
+	mapped = pmb_remap_caller(phys_addr, size, pgprot,
+			__builtin_return_address(0));
 	if (mapped && !IS_ERR(mapped))
 		return mapped;
 
@@ -129,7 +130,6 @@ static inline int iomapping_nontranslatable(unsigned long offset)
 int arch_iounmap(void __iomem *addr)
 {
 	unsigned long vaddr = (unsigned long __force)addr;
-	struct vm_struct *p;
 
 	/*
 	 * Nothing to do if there is no translatable mapping.

