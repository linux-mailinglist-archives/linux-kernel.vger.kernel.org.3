Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 676825363B9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 16:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352902AbiE0OEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 10:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236013AbiE0OED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 10:04:03 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF7AF07
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 07:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653660242; x=1685196242;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=etwPxYibWnptX1yjvwUTVHcGKmHAVjw5AngBkzDp9c0=;
  b=UBIyx5jI/JQLLY/cbjaDKsvQQVpJ6tQU8Kw8gneONbUwjwDzq+LwiOw4
   rC1CncHjRyYCU9YBQ66l2QEVo56A96/CBVJjTtxHiCl0hKRpWzcBDziXe
   xNmMF+pg05d7fimsJdFB1YpcMIjSOV8A3G++LhhBpAbw7pA45tXacw6wi
   cm0UfKtwFU8y7ttaMKmuOffPKEDNQchTtHjwlSvVlqynnXjyl597LQMHv
   aXDLp4NQ/Kypg0UcD0j0Y4G0h5Jbg337kiON6ldWIoUtRO58S18BPuOqT
   Kd+FygtgLV+d0cqWA+MIagJfpiyWfUpqWJNMBwcpIYgvY1r2xun+FAzq1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="254362324"
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="254362324"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 May 2022 07:04:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,255,1647327600"; 
   d="scan'208";a="631611515"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 27 May 2022 07:03:59 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuaZK-0004pw-Hc;
        Fri, 27 May 2022 14:03:58 +0000
Date:   Fri, 27 May 2022 22:03:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tong Tiangen <tongtiangen@huawei.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Pasha Tatashin <pasha.tatashin@soleen.com>
Subject: mm/page_table_check.c:162:36: error: call to undeclared function
 'pmd_pfn'; ISO C99 and later do not support implicit function declarations
Message-ID: <202205272115.jTU9BRH9-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tong,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   7e284070abe53d448517b80493863595af4ab5f0
commit: 3fee229a8eb936b96933c6b2cd02d2e87a4cc997 riscv/mm: enable ARCH_SUPPORTS_PAGE_TABLE_CHECK
date:   2 weeks ago
config: riscv-buildonly-randconfig-r002-20220527 (https://download.01.org/0day-ci/archive/20220527/202205272115.jTU9BRH9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 134d7f9a4b97e9035150d970bd9e376043c4577e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=3fee229a8eb936b96933c6b2cd02d2e87a4cc997
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 3fee229a8eb936b96933c6b2cd02d2e87a4cc997
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   mm/page_table_check.c:148:6: error: call to undeclared function 'pte_user_accessible_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (pte_user_accessible_page(pte)) {
               ^
>> mm/page_table_check.c:149:36: error: call to undeclared function 'pte_pfn'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   page_table_check_clear(mm, addr, pte_pfn(pte),
                                                    ^
   mm/page_table_check.c:161:6: error: call to undeclared function 'pmd_user_accessible_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (pmd_user_accessible_page(pmd)) {
               ^
>> mm/page_table_check.c:162:36: error: call to undeclared function 'pmd_pfn'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   page_table_check_clear(mm, addr, pmd_pfn(pmd),
                                                    ^
   mm/page_table_check.c:162:36: note: did you mean '_pmd_pfn'?
   arch/riscv/include/asm/pgtable-64.h:144:29: note: '_pmd_pfn' declared here
   static inline unsigned long _pmd_pfn(pmd_t pmd)
                               ^
   mm/page_table_check.c:174:6: error: call to undeclared function 'pud_user_accessible_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (pud_user_accessible_page(pud)) {
               ^
>> mm/page_table_check.c:175:36: error: call to undeclared function 'pud_pfn'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   page_table_check_clear(mm, addr, pud_pfn(pud),
                                                    ^
   mm/page_table_check.c:175:36: note: did you mean '_pud_pfn'?
   arch/riscv/include/asm/pgtable-64.h:104:29: note: '_pud_pfn' declared here
   static inline unsigned long _pud_pfn(pud_t pud)
                               ^
   mm/page_table_check.c:188:6: error: call to undeclared function 'pte_user_accessible_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (pte_user_accessible_page(pte)) {
               ^
   mm/page_table_check.c:189:34: error: call to undeclared function 'pte_pfn'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   page_table_check_set(mm, addr, pte_pfn(pte),
                                                  ^
>> mm/page_table_check.c:191:10: error: call to undeclared function 'pte_write'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                        pte_write(pte));
                                        ^
   mm/page_table_check.c:203:6: error: call to undeclared function 'pmd_user_accessible_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (pmd_user_accessible_page(pmd)) {
               ^
   mm/page_table_check.c:204:34: error: call to undeclared function 'pmd_pfn'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   page_table_check_set(mm, addr, pmd_pfn(pmd),
                                                  ^
>> mm/page_table_check.c:206:10: error: call to undeclared function 'pmd_write'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                        pmd_write(pmd));
                                        ^
   mm/page_table_check.c:218:6: error: call to undeclared function 'pud_user_accessible_page'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (pud_user_accessible_page(pud)) {
               ^
   mm/page_table_check.c:219:34: error: call to undeclared function 'pud_pfn'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   page_table_check_set(mm, addr, pud_pfn(pud),
                                                  ^
>> mm/page_table_check.c:221:10: error: call to undeclared function 'pud_write'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                                        pud_write(pud));
                                        ^
   mm/page_table_check.c:221:10: note: did you mean 'up_write'?
   include/linux/rwsem.h:202:13: note: 'up_write' declared here
   extern void up_write(struct rw_semaphore *sem);
               ^
>> mm/page_table_check.c:233:7: error: call to undeclared function 'pmd_bad'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
                ^
>> mm/page_table_check.c:234:17: error: call to undeclared function 'pte_offset_map'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   pte_t *ptep = pte_offset_map(&pmd, addr);
                                 ^
>> mm/page_table_check.c:234:10: warning: incompatible integer to pointer conversion initializing 'pte_t *' with an expression of type 'int' [-Wint-conversion]
                   pte_t *ptep = pte_offset_map(&pmd, addr);
                          ^      ~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/page_table_check.c:237:3: error: call to undeclared function 'pte_unmap'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   pte_unmap(ptep);
                   ^
   mm/page_table_check.c:237:3: note: did you mean 'pte_devmap'?
   include/linux/mm.h:2113:19: note: 'pte_devmap' declared here
   static inline int pte_devmap(pte_t pte)
                     ^
>> mm/page_table_check.c:238:19: error: use of undeclared identifier 'PTRS_PER_PTE'
                   for (i = 0; i < PTRS_PER_PTE; i++) {
                                   ^
   1 warning and 19 errors generated.


vim +/pmd_pfn +162 mm/page_table_check.c

df4e817b710809 Pasha Tatashin 2022-01-14  141  
df4e817b710809 Pasha Tatashin 2022-01-14  142  void __page_table_check_pte_clear(struct mm_struct *mm, unsigned long addr,
df4e817b710809 Pasha Tatashin 2022-01-14  143  				  pte_t pte)
df4e817b710809 Pasha Tatashin 2022-01-14  144  {
df4e817b710809 Pasha Tatashin 2022-01-14  145  	if (&init_mm == mm)
df4e817b710809 Pasha Tatashin 2022-01-14  146  		return;
df4e817b710809 Pasha Tatashin 2022-01-14  147  
df4e817b710809 Pasha Tatashin 2022-01-14  148  	if (pte_user_accessible_page(pte)) {
df4e817b710809 Pasha Tatashin 2022-01-14 @149  		page_table_check_clear(mm, addr, pte_pfn(pte),
df4e817b710809 Pasha Tatashin 2022-01-14  150  				       PAGE_SIZE >> PAGE_SHIFT);
df4e817b710809 Pasha Tatashin 2022-01-14  151  	}
df4e817b710809 Pasha Tatashin 2022-01-14  152  }
df4e817b710809 Pasha Tatashin 2022-01-14  153  EXPORT_SYMBOL(__page_table_check_pte_clear);
df4e817b710809 Pasha Tatashin 2022-01-14  154  
df4e817b710809 Pasha Tatashin 2022-01-14  155  void __page_table_check_pmd_clear(struct mm_struct *mm, unsigned long addr,
df4e817b710809 Pasha Tatashin 2022-01-14  156  				  pmd_t pmd)
df4e817b710809 Pasha Tatashin 2022-01-14  157  {
df4e817b710809 Pasha Tatashin 2022-01-14  158  	if (&init_mm == mm)
df4e817b710809 Pasha Tatashin 2022-01-14  159  		return;
df4e817b710809 Pasha Tatashin 2022-01-14  160  
df4e817b710809 Pasha Tatashin 2022-01-14  161  	if (pmd_user_accessible_page(pmd)) {
df4e817b710809 Pasha Tatashin 2022-01-14 @162  		page_table_check_clear(mm, addr, pmd_pfn(pmd),
92fb05242a1b1e Tong Tiangen   2022-05-12  163  				       PMD_SIZE >> PAGE_SHIFT);
df4e817b710809 Pasha Tatashin 2022-01-14  164  	}
df4e817b710809 Pasha Tatashin 2022-01-14  165  }
df4e817b710809 Pasha Tatashin 2022-01-14  166  EXPORT_SYMBOL(__page_table_check_pmd_clear);
df4e817b710809 Pasha Tatashin 2022-01-14  167  
df4e817b710809 Pasha Tatashin 2022-01-14  168  void __page_table_check_pud_clear(struct mm_struct *mm, unsigned long addr,
df4e817b710809 Pasha Tatashin 2022-01-14  169  				  pud_t pud)
df4e817b710809 Pasha Tatashin 2022-01-14  170  {
df4e817b710809 Pasha Tatashin 2022-01-14  171  	if (&init_mm == mm)
df4e817b710809 Pasha Tatashin 2022-01-14  172  		return;
df4e817b710809 Pasha Tatashin 2022-01-14  173  
df4e817b710809 Pasha Tatashin 2022-01-14  174  	if (pud_user_accessible_page(pud)) {
df4e817b710809 Pasha Tatashin 2022-01-14 @175  		page_table_check_clear(mm, addr, pud_pfn(pud),
92fb05242a1b1e Tong Tiangen   2022-05-12  176  				       PUD_SIZE >> PAGE_SHIFT);
df4e817b710809 Pasha Tatashin 2022-01-14  177  	}
df4e817b710809 Pasha Tatashin 2022-01-14  178  }
df4e817b710809 Pasha Tatashin 2022-01-14  179  EXPORT_SYMBOL(__page_table_check_pud_clear);
df4e817b710809 Pasha Tatashin 2022-01-14  180  
df4e817b710809 Pasha Tatashin 2022-01-14  181  void __page_table_check_pte_set(struct mm_struct *mm, unsigned long addr,
df4e817b710809 Pasha Tatashin 2022-01-14  182  				pte_t *ptep, pte_t pte)
df4e817b710809 Pasha Tatashin 2022-01-14  183  {
df4e817b710809 Pasha Tatashin 2022-01-14  184  	if (&init_mm == mm)
df4e817b710809 Pasha Tatashin 2022-01-14  185  		return;
df4e817b710809 Pasha Tatashin 2022-01-14  186  
64d8b9e14512ce Pasha Tatashin 2022-02-03  187  	__page_table_check_pte_clear(mm, addr, *ptep);
df4e817b710809 Pasha Tatashin 2022-01-14  188  	if (pte_user_accessible_page(pte)) {
df4e817b710809 Pasha Tatashin 2022-01-14  189  		page_table_check_set(mm, addr, pte_pfn(pte),
df4e817b710809 Pasha Tatashin 2022-01-14  190  				     PAGE_SIZE >> PAGE_SHIFT,
df4e817b710809 Pasha Tatashin 2022-01-14 @191  				     pte_write(pte));
df4e817b710809 Pasha Tatashin 2022-01-14  192  	}
df4e817b710809 Pasha Tatashin 2022-01-14  193  }
df4e817b710809 Pasha Tatashin 2022-01-14  194  EXPORT_SYMBOL(__page_table_check_pte_set);
df4e817b710809 Pasha Tatashin 2022-01-14  195  
df4e817b710809 Pasha Tatashin 2022-01-14  196  void __page_table_check_pmd_set(struct mm_struct *mm, unsigned long addr,
df4e817b710809 Pasha Tatashin 2022-01-14  197  				pmd_t *pmdp, pmd_t pmd)
df4e817b710809 Pasha Tatashin 2022-01-14  198  {
df4e817b710809 Pasha Tatashin 2022-01-14  199  	if (&init_mm == mm)
df4e817b710809 Pasha Tatashin 2022-01-14  200  		return;
df4e817b710809 Pasha Tatashin 2022-01-14  201  
64d8b9e14512ce Pasha Tatashin 2022-02-03  202  	__page_table_check_pmd_clear(mm, addr, *pmdp);
df4e817b710809 Pasha Tatashin 2022-01-14  203  	if (pmd_user_accessible_page(pmd)) {
df4e817b710809 Pasha Tatashin 2022-01-14  204  		page_table_check_set(mm, addr, pmd_pfn(pmd),
92fb05242a1b1e Tong Tiangen   2022-05-12  205  				     PMD_SIZE >> PAGE_SHIFT,
df4e817b710809 Pasha Tatashin 2022-01-14 @206  				     pmd_write(pmd));
df4e817b710809 Pasha Tatashin 2022-01-14  207  	}
df4e817b710809 Pasha Tatashin 2022-01-14  208  }
df4e817b710809 Pasha Tatashin 2022-01-14  209  EXPORT_SYMBOL(__page_table_check_pmd_set);
df4e817b710809 Pasha Tatashin 2022-01-14  210  
df4e817b710809 Pasha Tatashin 2022-01-14  211  void __page_table_check_pud_set(struct mm_struct *mm, unsigned long addr,
df4e817b710809 Pasha Tatashin 2022-01-14  212  				pud_t *pudp, pud_t pud)
df4e817b710809 Pasha Tatashin 2022-01-14  213  {
df4e817b710809 Pasha Tatashin 2022-01-14  214  	if (&init_mm == mm)
df4e817b710809 Pasha Tatashin 2022-01-14  215  		return;
df4e817b710809 Pasha Tatashin 2022-01-14  216  
64d8b9e14512ce Pasha Tatashin 2022-02-03  217  	__page_table_check_pud_clear(mm, addr, *pudp);
df4e817b710809 Pasha Tatashin 2022-01-14  218  	if (pud_user_accessible_page(pud)) {
df4e817b710809 Pasha Tatashin 2022-01-14  219  		page_table_check_set(mm, addr, pud_pfn(pud),
92fb05242a1b1e Tong Tiangen   2022-05-12  220  				     PUD_SIZE >> PAGE_SHIFT,
df4e817b710809 Pasha Tatashin 2022-01-14 @221  				     pud_write(pud));
df4e817b710809 Pasha Tatashin 2022-01-14  222  	}
df4e817b710809 Pasha Tatashin 2022-01-14  223  }
df4e817b710809 Pasha Tatashin 2022-01-14  224  EXPORT_SYMBOL(__page_table_check_pud_set);
80110bbfbba6f0 Pasha Tatashin 2022-02-03  225  
80110bbfbba6f0 Pasha Tatashin 2022-02-03  226  void __page_table_check_pte_clear_range(struct mm_struct *mm,
80110bbfbba6f0 Pasha Tatashin 2022-02-03  227  					unsigned long addr,
80110bbfbba6f0 Pasha Tatashin 2022-02-03  228  					pmd_t pmd)
80110bbfbba6f0 Pasha Tatashin 2022-02-03  229  {
80110bbfbba6f0 Pasha Tatashin 2022-02-03  230  	if (&init_mm == mm)
80110bbfbba6f0 Pasha Tatashin 2022-02-03  231  		return;
80110bbfbba6f0 Pasha Tatashin 2022-02-03  232  
80110bbfbba6f0 Pasha Tatashin 2022-02-03 @233  	if (!pmd_bad(pmd) && !pmd_leaf(pmd)) {
80110bbfbba6f0 Pasha Tatashin 2022-02-03 @234  		pte_t *ptep = pte_offset_map(&pmd, addr);
80110bbfbba6f0 Pasha Tatashin 2022-02-03  235  		unsigned long i;
80110bbfbba6f0 Pasha Tatashin 2022-02-03  236  
80110bbfbba6f0 Pasha Tatashin 2022-02-03 @237  		pte_unmap(ptep);
80110bbfbba6f0 Pasha Tatashin 2022-02-03 @238  		for (i = 0; i < PTRS_PER_PTE; i++) {

:::::: The code at line 162 was first introduced by commit
:::::: df4e817b710809425d899340dbfa8504a3ca4ba5 mm: page table check

:::::: TO: Pasha Tatashin <pasha.tatashin@soleen.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
