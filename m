Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DAD23468296
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:05:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238176AbhLDGII (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:08:08 -0500
Received: from mga07.intel.com ([134.134.136.100]:1898 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233865AbhLDGIG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:08:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10187"; a="300484717"
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="300484717"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 22:04:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,286,1631602800"; 
   d="scan'208";a="598219423"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 03 Dec 2021 22:04:39 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mtOA2-000IZ1-DZ; Sat, 04 Dec 2021 06:04:38 +0000
Date:   Sat, 4 Dec 2021 14:04:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nadav Amit <namit@vmware.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: include/asm-generic/tlb.h:530:42: sparse: sparse: cast truncates
 bits from constant value (200000000 becomes 0)
Message-ID: <202112041445.jjD0iW7P-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   12119cfa1052d512a92524e90ebee85029a918f8
commit: a4a118f2eead1d6c49e00765de89878288d4b890 hugetlbfs: flush TLBs correctly after huge_pmd_unshare
date:   11 days ago
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20211204/202112041445.jjD0iW7P-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a4a118f2eead1d6c49e00765de89878288d4b890
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a4a118f2eead1d6c49e00765de89878288d4b890
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   mm/hugetlb.c:454:12: sparse: sparse: context imbalance in 'allocate_file_region_entries' - wrong count at exit
   mm/hugetlb.c:527:13: sparse: sparse: context imbalance in 'region_add' - wrong count at exit
   mm/hugetlb.c:594:13: sparse: sparse: context imbalance in 'region_chg' - wrong count at exit
   mm/hugetlb.c: note: in included file:
   include/linux/mm.h:1386:17: sparse: sparse: context imbalance in 'demote_free_huge_page' - unexpected unlock
   mm/hugetlb.c:4877:20: sparse: sparse: context imbalance in 'move_huge_pte' - different lock contexts for basic block
   mm/hugetlb.c: note: in included file (through arch/sparc/include/asm/tlb_64.h, arch/sparc/include/asm/tlb.h):
>> include/asm-generic/tlb.h:530:42: sparse: sparse: cast truncates bits from constant value (200000000 becomes 0)
   mm/hugetlb.c: note: in included file:
   include/linux/mm.h:1199:22: sparse: sparse: context imbalance in 'hugetlb_cow' - unexpected unlock
   mm/hugetlb.c:6006:25: sparse: sparse: context imbalance in 'follow_hugetlb_page' - different lock contexts for basic block

vim +530 include/asm-generic/tlb.h

2631ed00b04988 Peter Zijlstra (Intel  2020-06-25  526) 
2631ed00b04988 Peter Zijlstra (Intel  2020-06-25  527) static inline void tlb_flush_pmd_range(struct mmu_gather *tlb,
2631ed00b04988 Peter Zijlstra (Intel  2020-06-25  528) 				     unsigned long address, unsigned long size)
2631ed00b04988 Peter Zijlstra (Intel  2020-06-25  529) {
2631ed00b04988 Peter Zijlstra (Intel  2020-06-25 @530) 	__tlb_adjust_range(tlb, address, size);
2631ed00b04988 Peter Zijlstra (Intel  2020-06-25  531) 	tlb->cleared_pmds = 1;
2631ed00b04988 Peter Zijlstra (Intel  2020-06-25  532) }
2631ed00b04988 Peter Zijlstra (Intel  2020-06-25  533) 

:::::: The code at line 530 was first introduced by commit
:::::: 2631ed00b0498810f8d5c2163c6b5270d893687b tlb: mmu_gather: add tlb_flush_*_range APIs

:::::: TO: Peter Zijlstra (Intel) <peterz@infradead.org>
:::::: CC: Catalin Marinas <catalin.marinas@arm.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
