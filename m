Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A673E4AB11A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 18:57:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239379AbiBFR5r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 12:57:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiBFR5n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 12:57:43 -0500
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A71FEC06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 09:57:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644170262; x=1675706262;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=qB/KrCOoCkP70gdGOaXQ6La8fUne/1e99+wANfuP2xU=;
  b=dRYUtVa3K/+L7g45xVjvI26dMqykwhMiF57083a/gIHh/OlCLUHEqZw+
   s83KRqg7SQQabysyX2a52tR8eWK1RXy+w8+zx00IG96FkAC2p2dB4N8GI
   kbbpNLcwaHq/q0tY6aHLr0SPrw2d1/Z+Er8fpSA5uBGqHRrPOp7a+pJW7
   Nw3cYiQfD3e/ZzPF/U20ZT52eYo/rNlZfr8XBSbzrXn7ipQ3tV77mPyaz
   tAlovQoQdXfBiIqGJ+75jXf3RUZ7eT/KGTX/MHdIfOriQucnMgHy0aIpX
   GqtsIWeiEDsonVR0RzU8a2WIEA3ovixIAFj7gVG8luiPcijXk6KFhHNWj
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10249"; a="228568060"
X-IronPort-AV: E=Sophos;i="5.88,347,1635231600"; 
   d="scan'208";a="228568060"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 09:57:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,347,1635231600"; 
   d="scan'208";a="481339226"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 06 Feb 2022 09:57:40 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nGln9-000aZX-QU; Sun, 06 Feb 2022 17:57:39 +0000
Date:   Mon, 7 Feb 2022 01:56:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [willy-pagecache:for-next 49/75] mm/folio-compat.c:181:9: error:
 implicit declaration of function 'munlock_vma_folio'
Message-ID: <202202070124.y4SKcrhy-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://git.infradead.org/users/willy/pagecache for-next
head:   b1ccdc7664f5af97629b33fedf382af350edecf4
commit: 9ba2488442f0e6e010a0d5c9d34fc385a19c8db5 [49/75] mm/mlock: Turn munlock_vma_page() into munlock_vma_folio()
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20220207/202202070124.y4SKcrhy-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 6daaf5a44925592c764c59219b0024ee06317028)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        git remote add willy-pagecache git://git.infradead.org/users/willy/pagecache
        git fetch --no-tags willy-pagecache for-next
        git checkout 9ba2488442f0e6e010a0d5c9d34fc385a19c8db5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from mm/folio-compat.c:7:
   In file included from include/linux/migrate.h:6:
   In file included from include/linux/mempolicy.h:15:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from mm/folio-compat.c:7:
   In file included from include/linux/migrate.h:6:
   In file included from include/linux/mempolicy.h:15:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from mm/folio-compat.c:7:
   In file included from include/linux/migrate.h:6:
   In file included from include/linux/mempolicy.h:15:
   In file included from include/linux/pagemap.h:11:
   In file included from include/linux/highmem.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
   mm/folio-compat.c:169:6: warning: no previous prototype for function 'clear_page_mlock' [-Wmissing-prototypes]
   void clear_page_mlock(struct page *page)
        ^
   mm/folio-compat.c:169:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void clear_page_mlock(struct page *page)
   ^
   static 
   mm/folio-compat.c:174:6: error: redefinition of 'mlock_vma_page'
   void mlock_vma_page(struct page *page)
        ^
   mm/internal.h:500:20: note: previous definition is here
   static inline void mlock_vma_page(struct page *page) { }
                      ^
   mm/folio-compat.c:176:2: error: implicit declaration of function 'mlock_vma_folio' [-Werror,-Wimplicit-function-declaration]
           mlock_vma_folio(page_folio(page));
           ^
   mm/folio-compat.c:176:2: note: did you mean 'mlock_vma_page'?
   mm/folio-compat.c:174:6: note: 'mlock_vma_page' declared here
   void mlock_vma_page(struct page *page)
        ^
>> mm/folio-compat.c:181:9: error: implicit declaration of function 'munlock_vma_folio' [-Werror,-Wimplicit-function-declaration]
           return munlock_vma_folio(page_folio(page));
                  ^
   mm/folio-compat.c:181:9: note: did you mean 'munlock_vma_page'?
   mm/folio-compat.c:179:15: note: 'munlock_vma_page' declared here
   unsigned long munlock_vma_page(struct page *page)
                 ^
>> mm/folio-compat.c:179:15: warning: no previous prototype for function 'munlock_vma_page' [-Wmissing-prototypes]
   unsigned long munlock_vma_page(struct page *page)
                 ^
   mm/folio-compat.c:179:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   unsigned long munlock_vma_page(struct page *page)
   ^
   static 
   mm/folio-compat.c:186:2: error: implicit declaration of function 'folio_mlock' [-Werror,-Wimplicit-function-declaration]
           folio_mlock(page_folio(page));
           ^
   mm/folio-compat.c:186:2: note: did you mean 'folio_lock'?
   include/linux/pagemap.h:776:20: note: 'folio_lock' declared here
   static inline void folio_lock(struct folio *folio)
                      ^
   mm/folio-compat.c:184:6: warning: no previous prototype for function 'page_mlock' [-Wmissing-prototypes]
   void page_mlock(struct page *page)
        ^
   mm/folio-compat.c:184:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void page_mlock(struct page *page)
   ^
   static 
   10 warnings and 4 errors generated.


vim +/munlock_vma_folio +181 mm/folio-compat.c

   173	
   174	void mlock_vma_page(struct page *page)
   175	{
 > 176		mlock_vma_folio(page_folio(page));
   177	}
   178	
 > 179	unsigned long munlock_vma_page(struct page *page)
   180	{
 > 181		return munlock_vma_folio(page_folio(page));
   182	}
   183	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
