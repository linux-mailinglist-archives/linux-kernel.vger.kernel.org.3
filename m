Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79CA4466B8E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 22:17:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377028AbhLBVVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:21:17 -0500
Received: from mga14.intel.com ([192.55.52.115]:48712 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1377025AbhLBVVH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:21:07 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="237067816"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="237067816"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 13:17:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="500912546"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 02 Dec 2021 13:17:42 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mstSX-000Ggx-CJ; Thu, 02 Dec 2021 21:17:41 +0000
Date:   Fri, 3 Dec 2021 05:17:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [peterz-queue:x86/wip.ibt 7/15] arch/x86/mm/init.c:178:1: warning:
 'nocf_check' attribute ignored; use -fcf-protection to enable the attribute
Message-ID: <202112030502.YDiwVBKh-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git x86/wip.ibt
head:   a2453d618b87ec61000fecf66dee9cbd109e2e50
commit: d7103a390456460fd2b7d93081cd64b3e55c10f9 [7/15] x86: Don't generate ENDBR in .discard.text
config: x86_64-randconfig-r001-20211202 (https://download.01.org/0day-ci/archive/20211203/202112030502.YDiwVBKh-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 4b553297ef3ee4dc2119d5429adf3072e90fac38)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git/commit/?id=d7103a390456460fd2b7d93081cd64b3e55c10f9
        git remote add peterz-queue https://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git
        git fetch --no-tags peterz-queue x86/wip.ibt
        git checkout d7103a390456460fd2b7d93081cd64b3e55c10f9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash arch/x86/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/mm/init.c:178:1: warning: 'nocf_check' attribute ignored; use -fcf-protection to enable the attribute [-Wignored-attributes]
   RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE);
   ^
   arch/x86/include/asm/setup.h:122:56: note: expanded from macro 'RESERVE_BRK'
           static void __section(".discard.text") __attribute__((nocf_check)) __used notrace               \
                                                                 ^
   1 warning generated.


vim +/nocf_check +178 arch/x86/mm/init.c

167dcfc08b0b1f Lorenzo Stoakes 2020-12-15  176  
fb754f958f8e46 Thomas Garnier  2016-08-09  177  #define INIT_PGT_BUF_SIZE	(INIT_PGD_PAGE_COUNT * PAGE_SIZE)
8d57470d8f8596 Yinghai Lu      2012-11-16 @178  RESERVE_BRK(early_pgt_alloc, INIT_PGT_BUF_SIZE);
8d57470d8f8596 Yinghai Lu      2012-11-16  179  void  __init early_alloc_pgt_buf(void)
8d57470d8f8596 Yinghai Lu      2012-11-16  180  {
8d57470d8f8596 Yinghai Lu      2012-11-16  181  	unsigned long tables = INIT_PGT_BUF_SIZE;
8d57470d8f8596 Yinghai Lu      2012-11-16  182  	phys_addr_t base;
8d57470d8f8596 Yinghai Lu      2012-11-16  183  
8d57470d8f8596 Yinghai Lu      2012-11-16  184  	base = __pa(extend_brk(tables, PAGE_SIZE));
8d57470d8f8596 Yinghai Lu      2012-11-16  185  
8d57470d8f8596 Yinghai Lu      2012-11-16  186  	pgt_buf_start = base >> PAGE_SHIFT;
8d57470d8f8596 Yinghai Lu      2012-11-16  187  	pgt_buf_end = pgt_buf_start;
8d57470d8f8596 Yinghai Lu      2012-11-16  188  	pgt_buf_top = pgt_buf_start + (tables >> PAGE_SHIFT);
8d57470d8f8596 Yinghai Lu      2012-11-16  189  }
8d57470d8f8596 Yinghai Lu      2012-11-16  190  

:::::: The code at line 178 was first introduced by commit
:::::: 8d57470d8f859635deffe3919d7d4867b488b85a x86, mm: setup page table in top-down

:::::: TO: Yinghai Lu <yinghai@kernel.org>
:::::: CC: H. Peter Anvin <hpa@linux.intel.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
