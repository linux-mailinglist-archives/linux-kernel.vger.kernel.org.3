Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C8C591A24
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 14:40:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiHMMgZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 08:36:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230519AbiHMMgX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 08:36:23 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD12EE15
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 05:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660394181; x=1691930181;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=g5vB2EOfA4ei1Ch5o6lv4Wm153aeR0MtFVpUmK022dg=;
  b=BEOFzZYsODro57ow3kLvOi/h/A9h6vDdhiqNvWcdcUJTPDrZ4TQdgGVZ
   Q7e7/bqm8NF7igbhqjHzOytrnVx7P7j1wn2S526gAQpREQMngFYp9FDsM
   HgCFjoEI9oZwlcU7W8vSflmbSW6T5DVV9NYyEZiq9gttIu6E53huVHGT1
   0O1PnX/2t21NhBGdj69+rVSPxnDN3x/cjSR0wvykPgSYxEEViVB4ujuvW
   zQfYOZtnoQTlo3+dqdiSiWw1UDziSTIpiecGsXwju91BTHDy3KWhvMh95
   q5zZgjfFxzjPxM/nevplMfxM1hLAAvfyZVjASKRSuVwQw9AKgHu4kgv0f
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="290503900"
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="290503900"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 05:36:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,235,1654585200"; 
   d="scan'208";a="634965330"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 13 Aug 2022 05:36:18 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMqNF-0001fL-1y;
        Sat, 13 Aug 2022 12:36:17 +0000
Date:   Sat, 13 Aug 2022 20:36:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Palmer Dabbelt <palmer@rivosinc.com>,
        Christoph Hellwig <hch@lst.de>, Guo Ren <guoren@kernel.org>
Subject: kernel/dma/pool.c:105:9: error: call to undeclared function
 'pgprot_dmacoherent'; ISO C99 and later do not support implicit function
 declarations
Message-ID: <202208132019.8G3q7EhQ-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   69dac8e431af26173ca0a1ebc87054e01c585bcc
commit: 1631ba1259d6d7f49b6028f2a1a0fa02be1c522a riscv: Add support for non-coherent devices using zicbom extension
date:   2 weeks ago
config: riscv-randconfig-r031-20220812 (https://download.01.org/0day-ci/archive/20220813/202208132019.8G3q7EhQ-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 3329cec2f79185bafd678f310fafadba2a8c76d2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=1631ba1259d6d7f49b6028f2a1a0fa02be1c522a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 1631ba1259d6d7f49b6028f2a1a0fa02be1c522a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/dma/pool.c:8:
   In file included from include/linux/dma-map-ops.h:9:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
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
   In file included from kernel/dma/pool.c:8:
   In file included from include/linux/dma-map-ops.h:9:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from kernel/dma/pool.c:8:
   In file included from include/linux/dma-map-ops.h:9:
   In file included from include/linux/dma-mapping.h:10:
   In file included from include/linux/scatterlist.h:9:
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
>> kernel/dma/pool.c:105:9: error: call to undeclared function 'pgprot_dmacoherent'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                              pgprot_dmacoherent(PAGE_KERNEL),
                                              ^
>> kernel/dma/pool.c:105:9: error: passing 'int' to parameter of incompatible type 'pgprot_t'
                                              pgprot_dmacoherent(PAGE_KERNEL),
                                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dma-map-ops.h:235:76: note: passing argument to parameter 'prot' here
   void *dma_common_contiguous_remap(struct page *page, size_t size, pgprot_t prot,
                                                                              ^
   7 warnings and 2 errors generated.


vim +/pgprot_dmacoherent +105 kernel/dma/pool.c

d7e673ec2c8e0e Nicolas Saenz Julienne 2020-08-14   78  
54adadf9b08571 David Rientjes         2020-04-20   79  static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
54adadf9b08571 David Rientjes         2020-04-20   80  			      gfp_t gfp)
e860c299ac0d73 David Rientjes         2020-04-14   81  {
54adadf9b08571 David Rientjes         2020-04-20   82  	unsigned int order;
892fc9f6835ecf Dan Carpenter          2020-08-26   83  	struct page *page = NULL;
e860c299ac0d73 David Rientjes         2020-04-14   84  	void *addr;
54adadf9b08571 David Rientjes         2020-04-20   85  	int ret = -ENOMEM;
54adadf9b08571 David Rientjes         2020-04-20   86  
54adadf9b08571 David Rientjes         2020-04-20   87  	/* Cannot allocate larger than MAX_ORDER-1 */
54adadf9b08571 David Rientjes         2020-04-20   88  	order = min(get_order(pool_size), MAX_ORDER-1);
54adadf9b08571 David Rientjes         2020-04-20   89  
54adadf9b08571 David Rientjes         2020-04-20   90  	do {
54adadf9b08571 David Rientjes         2020-04-20   91  		pool_size = 1 << (PAGE_SHIFT + order);
d7e673ec2c8e0e Nicolas Saenz Julienne 2020-08-14   92  		if (cma_in_zone(gfp))
d7e673ec2c8e0e Nicolas Saenz Julienne 2020-08-14   93  			page = dma_alloc_from_contiguous(NULL, 1 << order,
d7e673ec2c8e0e Nicolas Saenz Julienne 2020-08-14   94  							 order, false);
d7e673ec2c8e0e Nicolas Saenz Julienne 2020-08-14   95  		if (!page)
c84dc6e68a1d24 David Rientjes         2020-04-14   96  			page = alloc_pages(gfp, order);
54adadf9b08571 David Rientjes         2020-04-20   97  	} while (!page && order-- > 0);
e860c299ac0d73 David Rientjes         2020-04-14   98  	if (!page)
e860c299ac0d73 David Rientjes         2020-04-14   99  		goto out;
e860c299ac0d73 David Rientjes         2020-04-14  100  
c84dc6e68a1d24 David Rientjes         2020-04-14  101  	arch_dma_prep_coherent(page, pool_size);
e860c299ac0d73 David Rientjes         2020-04-14  102  
76a19940bd62a8 David Rientjes         2020-04-14  103  #ifdef CONFIG_DMA_DIRECT_REMAP
c84dc6e68a1d24 David Rientjes         2020-04-14  104  	addr = dma_common_contiguous_remap(page, pool_size,
e860c299ac0d73 David Rientjes         2020-04-14 @105  					   pgprot_dmacoherent(PAGE_KERNEL),
e860c299ac0d73 David Rientjes         2020-04-14  106  					   __builtin_return_address(0));
e860c299ac0d73 David Rientjes         2020-04-14  107  	if (!addr)
54adadf9b08571 David Rientjes         2020-04-20  108  		goto free_page;
76a19940bd62a8 David Rientjes         2020-04-14  109  #else
76a19940bd62a8 David Rientjes         2020-04-14  110  	addr = page_to_virt(page);
76a19940bd62a8 David Rientjes         2020-04-14  111  #endif
76a19940bd62a8 David Rientjes         2020-04-14  112  	/*
76a19940bd62a8 David Rientjes         2020-04-14  113  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
2f5388a29be82a Christoph Hellwig      2020-08-17  114  	 * shrink so no re-encryption occurs in dma_direct_free().
76a19940bd62a8 David Rientjes         2020-04-14  115  	 */
76a19940bd62a8 David Rientjes         2020-04-14  116  	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
76a19940bd62a8 David Rientjes         2020-04-14  117  				   1 << order);
76a19940bd62a8 David Rientjes         2020-04-14  118  	if (ret)
76a19940bd62a8 David Rientjes         2020-04-14  119  		goto remove_mapping;
54adadf9b08571 David Rientjes         2020-04-20  120  	ret = gen_pool_add_virt(pool, (unsigned long)addr, page_to_phys(page),
54adadf9b08571 David Rientjes         2020-04-20  121  				pool_size, NUMA_NO_NODE);
e860c299ac0d73 David Rientjes         2020-04-14  122  	if (ret)
76a19940bd62a8 David Rientjes         2020-04-14  123  		goto encrypt_mapping;
e860c299ac0d73 David Rientjes         2020-04-14  124  
2edc5bb3c5cc42 David Rientjes         2020-04-14  125  	dma_atomic_pool_size_add(gfp, pool_size);
e860c299ac0d73 David Rientjes         2020-04-14  126  	return 0;
e860c299ac0d73 David Rientjes         2020-04-14  127  
76a19940bd62a8 David Rientjes         2020-04-14  128  encrypt_mapping:
76a19940bd62a8 David Rientjes         2020-04-14  129  	ret = set_memory_encrypted((unsigned long)page_to_virt(page),
76a19940bd62a8 David Rientjes         2020-04-14  130  				   1 << order);
76a19940bd62a8 David Rientjes         2020-04-14  131  	if (WARN_ON_ONCE(ret)) {
76a19940bd62a8 David Rientjes         2020-04-14  132  		/* Decrypt succeeded but encrypt failed, purposely leak */
76a19940bd62a8 David Rientjes         2020-04-14  133  		goto out;
76a19940bd62a8 David Rientjes         2020-04-14  134  	}
e860c299ac0d73 David Rientjes         2020-04-14  135  remove_mapping:
76a19940bd62a8 David Rientjes         2020-04-14  136  #ifdef CONFIG_DMA_DIRECT_REMAP
c84dc6e68a1d24 David Rientjes         2020-04-14  137  	dma_common_free_remap(addr, pool_size);
76a19940bd62a8 David Rientjes         2020-04-14  138  #endif
76a19940bd62a8 David Rientjes         2020-04-14  139  free_page: __maybe_unused
c84dc6e68a1d24 David Rientjes         2020-04-14  140  	__free_pages(page, order);
e860c299ac0d73 David Rientjes         2020-04-14  141  out:
54adadf9b08571 David Rientjes         2020-04-20  142  	return ret;
54adadf9b08571 David Rientjes         2020-04-20  143  }
54adadf9b08571 David Rientjes         2020-04-20  144  

:::::: The code at line 105 was first introduced by commit
:::::: e860c299ac0d738b44ff91693f11e63080a29698 dma-remap: separate DMA atomic pools from direct remap code

:::::: TO: David Rientjes <rientjes@google.com>
:::::: CC: Christoph Hellwig <hch@lst.de>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
