Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03701496651
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 21:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233052AbiAUUXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 15:23:06 -0500
Received: from mga17.intel.com ([192.55.52.151]:4526 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229947AbiAUUXF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 15:23:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642796585; x=1674332585;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=bckgLVD57DRjvgCLcAwRBUzB8RqqLPtmV+qet2QPNaY=;
  b=kdG1FTVqccWJcnEQNR33LD9/Av+uYkADDkDoZzAvFIjrh2SgcvjqUxkv
   wamU7rG7W6+vZTiEvG4xxPywX3Usl6qA4i88YbYa4PEgeHGbqJ/uHgx6B
   VeprhkZhshZt5eaShQo4jqY4w5ePTVMsCWIJDpH0Z8Pqxfy0x4+iZt/qb
   oF1NPI6330lpyqoYP6Ff38wLGWUJhgRA82k4P4fzQprdYcGSCglPp2F+6
   117Awj7K1AUw7mw8CSov8Ab1SrLTBnvu0qG94F9J3+Q6Pk4Owe6waNtVR
   gKFRf68XL+Di0ZLbEMAnr9GDy3h6/ICu+I8KrZMD3Nn1um1iCAlg3xVyv
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10234"; a="226413071"
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="226413071"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jan 2022 12:23:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,306,1635231600"; 
   d="scan'208";a="673051419"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 21 Jan 2022 12:23:03 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nB0R5-000Fdo-17; Fri, 21 Jan 2022 20:23:03 +0000
Date:   Sat, 22 Jan 2022 04:22:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     kbuild-all@lists.01.org, Mike Rapoport <rppt@kernel.org>,
        linux-kernel@vger.kernel.org
Subject: [rppt:gfp-unmapped/v0 1/3] include/linux/compiler_types.h:346:38:
 error: call to '__compiletime_assert_622' declared with attribute error:
 BUILD_BUG_ON failed: pageblock_order != PMD_ORDER
Message-ID: <202201220449.6A30CSDa-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-unmapped/v0
head:   53acd000a0eef1457aaa4930c0d2003d7785f799
commit: 253f456a5cb652a16a59cc4ac2e18669997d79cd [1/3] mm/page_alloc: introduce __GFP_UNMAPPED and MIGRETE_UNMAPPED
config: x86_64-randconfig-a012-20220117 (https://download.01.org/0day-ci/archive/20220122/202201220449.6A30CSDa-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git/commit/?id=253f456a5cb652a16a59cc4ac2e18669997d79cd
        git remote add rppt https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git
        git fetch --no-tags rppt gfp-unmapped/v0
        git checkout 253f456a5cb652a16a59cc4ac2e18669997d79cd
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/page_alloc.c:3955:15: warning: no previous prototype for 'should_fail_alloc_page' [-Wmissing-prototypes]
    3955 | noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
         |               ^~~~~~~~~~~~~~~~~~~~~~
   In file included from <command-line>:
   In function 'set_pageblock_unmapped',
       inlined from 'get_page_from_freelist' at mm/page_alloc.c:4301:8:
>> include/linux/compiler_types.h:346:38: error: call to '__compiletime_assert_622' declared with attribute error: BUILD_BUG_ON failed: pageblock_order != PMD_ORDER
     346 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                      ^
   include/linux/compiler_types.h:327:4: note: in definition of macro '__compiletime_assert'
     327 |    prefix ## suffix();    \
         |    ^~~~~~
   include/linux/compiler_types.h:346:2: note: in expansion of macro '_compiletime_assert'
     346 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   mm/page_alloc.c:2660:2: note: in expansion of macro 'BUILD_BUG_ON'
    2660 |  BUILD_BUG_ON(pageblock_order != PMD_ORDER);
         |  ^~~~~~~~~~~~


vim +/__compiletime_assert_622 +346 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  332  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  333  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  334  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  335  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  336  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  337   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  338   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  339   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  340   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  341   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  342   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  343   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  344   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  345  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @346  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  347  

:::::: The code at line 346 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
