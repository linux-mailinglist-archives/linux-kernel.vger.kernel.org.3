Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104075470EC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 03:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345134AbiFKB1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 21:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiFKB1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 21:27:02 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D56E3A480D
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 18:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654910820; x=1686446820;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=TIUOvRGCPBAsNmnP5ojI/BiOOG+isqh2wDUlcHutjh4=;
  b=Xl64QfdtTdMJBa1byenWYPOuwJnt4lSZGUdG//TQNYkfXb3X96BZ5hCH
   KptWkPyspSmG+prViuPxhSzvKhGWGsXLpLoag+GP531NTYwymKiVMWfPf
   jinfpvMeyoZdNSRSYy3fwlO4zffjAI9alcTxjdoVxfdgxNCSAL5N20h3G
   jAzmsWsKOrwA80LGJUmExMoUbXKU+w0CRYrunA9pXDZ7vH1Ol/FO0jExG
   P4xEZ0NmA0vd+tp5PhpAPn1m2zsNAtcdVO2u0zMUMePev2agI5SVByIpH
   jp2rOar41GfxM+UjBVPJzcDlPVHJwVOFvq8mfbTvj9Pqgcc8S0K0+OG6a
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10374"; a="257632463"
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="257632463"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2022 18:26:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,292,1647327600"; 
   d="scan'208";a="828539685"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Jun 2022 18:26:58 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzptx-000IRB-S6;
        Sat, 11 Jun 2022 01:26:57 +0000
Date:   Sat, 11 Jun 2022 09:26:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Anup Patel <anup@brainfault.org>
Subject: [avpatel:virtio_rpmsg_bus_fix_v1 45/52] kernel/dma/pool.c:105:44:
 error: implicit declaration of function 'pgprot_dmacoherent'
Message-ID: <202206110959.EzmHiqM2-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

First bad commit (maybe != root cause):

tree:   https://github.com/avpatel/linux.git virtio_rpmsg_bus_fix_v1
head:   390aaf641ff2f8919268d611e864227265c3f3f2
commit: 3485f5450237db107c3601d2b726458fb98027a6 [45/52] riscv: Implement Zicbom-based cache management operations
config: riscv-nommu_k210_defconfig (https://download.01.org/0day-ci/archive/20220611/202206110959.EzmHiqM2-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/avpatel/linux/commit/3485f5450237db107c3601d2b726458fb98027a6
        git remote add avpatel https://github.com/avpatel/linux.git
        git fetch --no-tags avpatel virtio_rpmsg_bus_fix_v1
        git checkout 3485f5450237db107c3601d2b726458fb98027a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash kernel/dma/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/dma/pool.c: In function 'atomic_pool_expand':
>> kernel/dma/pool.c:105:44: error: implicit declaration of function 'pgprot_dmacoherent' [-Werror=implicit-function-declaration]
     105 |                                            pgprot_dmacoherent(PAGE_KERNEL),
         |                                            ^~~~~~~~~~~~~~~~~~
>> kernel/dma/pool.c:105:44: error: incompatible type for argument 3 of 'dma_common_contiguous_remap'
     105 |                                            pgprot_dmacoherent(PAGE_KERNEL),
         |                                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                            |
         |                                            int
   In file included from kernel/dma/pool.c:8:
   include/linux/dma-map-ops.h:235:76: note: expected 'pgprot_t' but argument is of type 'int'
     235 | void *dma_common_contiguous_remap(struct page *page, size_t size, pgprot_t prot,
         |                                                                   ~~~~~~~~~^~~~
   cc1: some warnings being treated as errors


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
