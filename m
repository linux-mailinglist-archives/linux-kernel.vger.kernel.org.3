Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C614E4818F5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 04:30:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235408AbhL3Dag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 22:30:36 -0500
Received: from mga12.intel.com ([192.55.52.136]:42672 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231751AbhL3Daf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 22:30:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640835035; x=1672371035;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=1Nb1Ngx1/BlbwNr2VlL5TMMKg2T9ajejGZIdtlHbkBE=;
  b=XCqatkouB8QG60Ou8lrXJjWIfqmiYKH8L2WfF58rNKlOSXBzW91NdMz6
   oFdS7UoHuLNHPF5GMQaMBU1Yk4ifGnH24HQ4sp9+QrybmMQvADWfr7EnY
   YM7E77eKLU5bZrxhpX8l3i/nZWwajhyV/Z7UJZnLn6fPDJrarAg/9mV27
   LZNYUbalTW3YIDYrwpJfoLnExW2lJL+F4EiEfdVVyKEwUHeasvkVyQWHL
   zDegZ1ki17LfXSNntwYu4hRl8owFRifynzocxxcnrCoYPTi4EdSua4XiW
   gu4xEsf2swPI5zl9ecK0m7kE2pcjHe9h/oCc1WI0gJCq+4Zu5d4cl21zf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10212"; a="221605061"
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="221605061"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Dec 2021 19:30:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,247,1635231600"; 
   d="scan'208";a="510744448"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 29 Dec 2021 19:30:33 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n2m9A-0009h5-SK; Thu, 30 Dec 2021 03:30:32 +0000
Date:   Thu, 30 Dec 2021 11:29:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [linux-stable-rc:queue/5.10 4931/9999]
 include/linux/compiler_types.h:315:38: error: call to
 '__compiletime_assert_227' declared with attribute error: BUILD_BUG_ON
 failed: sizeof(_i) > sizeof(long)
Message-ID: <202112301112.IeXjohsS-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/5.10
head:   eb967e323f7fb073c51401070f7d2cb381a003f7
commit: 7af299b97734c7e7f465b42a2139ce4d77246975 [4931/9999] kvm: avoid speculation-based attacks from out-of-range memslot accesses
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20211230/202112301112.IeXjohsS-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=7af299b97734c7e7f465b42a2139ce4d77246975
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/5.10
        git checkout 7af299b97734c7e7f465b42a2139ce4d77246975
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-stable-rc/queue/5.10 HEAD eb967e323f7fb073c51401070f7d2cb381a003f7 builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

   In file included from <command-line>:
   In function '__gfn_to_hva_memslot',
       inlined from 'host_pfn_mapping_level' at arch/x86/kvm/mmu/mmu.c:2767:8,
       inlined from 'kvm_mmu_hugepage_adjust' at arch/x86/kvm/mmu/mmu.c:2808:10:
>> include/linux/compiler_types.h:315:38: error: call to '__compiletime_assert_227' declared with attribute error: BUILD_BUG_ON failed: sizeof(_i) > sizeof(long)
     315 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |                                      ^
   include/linux/compiler_types.h:296:4: note: in definition of macro '__compiletime_assert'
     296 |    prefix ## suffix();    \
         |    ^~~~~~
   include/linux/compiler_types.h:315:2: note: in expansion of macro '_compiletime_assert'
     315 |  _compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
         |  ^~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:39:37: note: in expansion of macro 'compiletime_assert'
      39 | #define BUILD_BUG_ON_MSG(cond, msg) compiletime_assert(!(cond), msg)
         |                                     ^~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:50:2: note: in expansion of macro 'BUILD_BUG_ON_MSG'
      50 |  BUILD_BUG_ON_MSG(condition, "BUILD_BUG_ON failed: " #condition)
         |  ^~~~~~~~~~~~~~~~
   include/linux/nospec.h:57:2: note: in expansion of macro 'BUILD_BUG_ON'
      57 |  BUILD_BUG_ON(sizeof(_i) > sizeof(long));   \
         |  ^~~~~~~~~~~~
   include/linux/kvm_host.h:1113:25: note: in expansion of macro 'array_index_nospec'
    1113 |  unsigned long offset = array_index_nospec(gfn - slot->base_gfn,
         |                         ^~~~~~~~~~~~~~~~~~


vim +/__compiletime_assert_227 +315 include/linux/compiler_types.h

eb5c2d4b45e3d2 Will Deacon 2020-07-21  301  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  302  #define _compiletime_assert(condition, msg, prefix, suffix) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21  303  	__compiletime_assert(condition, msg, prefix, suffix)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  304  
eb5c2d4b45e3d2 Will Deacon 2020-07-21  305  /**
eb5c2d4b45e3d2 Will Deacon 2020-07-21  306   * compiletime_assert - break build and emit msg if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  307   * @condition: a compile-time constant condition to check
eb5c2d4b45e3d2 Will Deacon 2020-07-21  308   * @msg:       a message to emit if condition is false
eb5c2d4b45e3d2 Will Deacon 2020-07-21  309   *
eb5c2d4b45e3d2 Will Deacon 2020-07-21  310   * In tradition of POSIX assert, this macro will break the build if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  311   * supplied condition is *false*, emitting the supplied error message if the
eb5c2d4b45e3d2 Will Deacon 2020-07-21  312   * compiler has support to do so.
eb5c2d4b45e3d2 Will Deacon 2020-07-21  313   */
eb5c2d4b45e3d2 Will Deacon 2020-07-21  314  #define compiletime_assert(condition, msg) \
eb5c2d4b45e3d2 Will Deacon 2020-07-21 @315  	_compiletime_assert(condition, msg, __compiletime_assert_, __COUNTER__)
eb5c2d4b45e3d2 Will Deacon 2020-07-21  316  

:::::: The code at line 315 was first introduced by commit
:::::: eb5c2d4b45e3d2d5d052ea6b8f1463976b1020d5 compiler.h: Move compiletime_assert() macros into compiler_types.h

:::::: TO: Will Deacon <will@kernel.org>
:::::: CC: Will Deacon <will@kernel.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
