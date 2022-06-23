Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B049F557207
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbiFWEsz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:48:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239533AbiFWDcQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:32:16 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD6835A85
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655955134; x=1687491134;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=C0UxTz3SU09BlRqhh033JLtXJpxFWAq4zdFdL9m7teY=;
  b=Jf6A7gUDWcpihE93qpkSKAwNXRbpMV5xUYJoKk3KSc6IekfWVRMQ3q6k
   RWriyNNkZl0XSwxZZiR3vtptblDm8dyV6avCEoMx1CquFFZOy75lPmrZF
   Yzjc163s1kcRsrA+IctC6FK1zfg8kVCm4XjKI6STvwfYslKyj3xrajlvH
   QVTNHa3ERdZV/B2Zi7B+GmqX7XZzQFaNoQ0uHXfCL3GZ78KpOMVddINEz
   vg4e/GYOmWEQMs32gN7m0hHexTN5yycc5/kqHaAnnKl7l8IIQC9eWQPSf
   lg1qMoA7zb+CcnsdsuZE76dpnfvPvQF1yJzbcg8lUvJWRNIJGA5+HNoON
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10386"; a="260431524"
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="260431524"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2022 20:32:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,215,1650956400"; 
   d="scan'208";a="765141102"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 22 Jun 2022 20:32:12 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o4DZj-0000e7-Ki;
        Thu, 23 Jun 2022 03:32:11 +0000
Date:   Thu, 23 Jun 2022 11:31:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [stable:linux-5.4.y 384/4398]
 drivers/staging/comedi/drivers/comedi_isadma.c:25:17: error: implicit
 declaration of function 'claim_dma_lock'
Message-ID: <202206231116.2lc9b5qT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.4.y
head:   f0c280af0ec7c79cf043594974206d87c3c46524
commit: 53a72858bcae7eaa7df8d167dbf60682d70f82a6 [384/4398] m68knommu: only set CONFIG_ISA_DMA_API for ColdFire sub-arch
config: m68k-randconfig-r001-20220622 (https://download.01.org/0day-ci/archive/20220623/202206231116.2lc9b5qT-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git/commit/?id=53a72858bcae7eaa7df8d167dbf60682d70f82a6
        git remote add stable https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git
        git fetch --no-tags stable linux-5.4.y
        git checkout 53a72858bcae7eaa7df8d167dbf60682d70f82a6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/staging/comedi/drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/m68k/include/asm/bug.h:32,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:12,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from include/linux/spinlock.h:51,
                    from include/linux/seqlock.h:36,
                    from include/linux/time.h:6,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:10,
                    from drivers/staging/comedi/drivers/comedi_isadma.c:7:
   include/linux/dma-mapping.h: In function 'dma_map_resource':
   arch/m68k/include/asm/page_mm.h:169:50: warning: ordered comparison of pointer with null pointer [-Wextra]
     169 | #define virt_addr_valid(kaddr)  ((void *)(kaddr) >= (void *)PAGE_OFFSET && (void *)(kaddr) < high_memory)
         |                                                  ^~
   include/asm-generic/bug.h:139:34: note: in definition of macro 'WARN_ON_ONCE'
     139 |         int __ret_warn_once = !!(condition);                    \
         |                                  ^~~~~~~~~
   arch/m68k/include/asm/page_mm.h:170:33: note: in expansion of macro 'virt_addr_valid'
     170 | #define pfn_valid(pfn)          virt_addr_valid(pfn_to_virt(pfn))
         |                                 ^~~~~~~~~~~~~~~
   include/linux/dma-mapping.h:355:26: note: in expansion of macro 'pfn_valid'
     355 |         if (WARN_ON_ONCE(pfn_valid(PHYS_PFN(phys_addr))))
         |                          ^~~~~~~~~
   drivers/staging/comedi/drivers/comedi_isadma.c: In function 'comedi_isadma_program':
>> drivers/staging/comedi/drivers/comedi_isadma.c:25:17: error: implicit declaration of function 'claim_dma_lock' [-Werror=implicit-function-declaration]
      25 |         flags = claim_dma_lock();
         |                 ^~~~~~~~~~~~~~
>> drivers/staging/comedi/drivers/comedi_isadma.c:31:9: error: implicit declaration of function 'release_dma_lock' [-Werror=implicit-function-declaration]
      31 |         release_dma_lock(flags);
         |         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/claim_dma_lock +25 drivers/staging/comedi/drivers/comedi_isadma.c

20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  16  
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  17  /**
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  18   * comedi_isadma_program - program and enable an ISA DMA transfer
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  19   * @desc:	the ISA DMA cookie to program and enable
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  20   */
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  21  void comedi_isadma_program(struct comedi_isadma_desc *desc)
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  22  {
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  23  	unsigned long flags;
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  24  
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14 @25  	flags = claim_dma_lock();
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  26  	clear_dma_ff(desc->chan);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  27  	set_dma_mode(desc->chan, desc->mode);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  28  	set_dma_addr(desc->chan, desc->hw_addr);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  29  	set_dma_count(desc->chan, desc->size);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  30  	enable_dma(desc->chan);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14 @31  	release_dma_lock(flags);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  32  }
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  33  EXPORT_SYMBOL_GPL(comedi_isadma_program);
20a1ea7d6ba184 H Hartley Sweeten 2015-01-14  34  

:::::: The code at line 25 was first introduced by commit
:::::: 20a1ea7d6ba184a1f6e25e85786738003387cada staging: comedi: comedi_isadma: introduce helper module for ISA DMA

:::::: TO: H Hartley Sweeten <hsweeten@visionengravers.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
