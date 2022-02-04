Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A714A9206
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 02:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356527AbiBDBav (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 20:30:51 -0500
Received: from mga05.intel.com ([192.55.52.43]:51665 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356509AbiBDBas (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 20:30:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643938248; x=1675474248;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RS5EDdaKbeY9w3oby6S3/7xPKbVHLIlV8/dpjRvORYQ=;
  b=ZiJ+cp8rjClw0IOgdq+mj+pB96vrIMxNn+CxAj36Iv4sshv1FyGBdiT5
   x0qLCOZwwD9kU7zJeBdR/4WDjHshg8C0UwBUgxesje873Ojb6YvCcdZz7
   ZArMKDy0twgGR66H94Rp+74Iln1cOsNkSpIJNyaNazyEbxZZ+HsrY05s9
   F2jeFB0WiUJlYVuQnXJlrH6ALrfGItZXZORx2WcezaTTcym4LXjyt1Lvm
   XXWvrYx3spsI2MS5+T8SJos9IMfYRVJEWC7UGf101QFlPUjt9+JXuLWS4
   soLAzEyKdmcifQJVV4qQdgJzK8pRSVOQErdiFxgww5DcLISuBkQVTDYnC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10247"; a="334684909"
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="334684909"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Feb 2022 17:30:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,340,1635231600"; 
   d="scan'208";a="483460718"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 03 Feb 2022 17:30:45 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFnQy-000Wuu-Ky; Fri, 04 Feb 2022 01:30:44 +0000
Date:   Fri, 4 Feb 2022 09:29:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Pedro Demarchi Gomes <pedrodemargomes@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Pedro Demarchi Gomes <pedrodemargomes@gmail.com>,
        SeongJae Park <sj@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/damon: Add option to monitor only writes
Message-ID: <202202040414.4fF2j3mp-lkp@intel.com>
References: <20220203131237.298090-1-pedrodemargomes@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220203131237.298090-1-pedrodemargomes@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pedro,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Pedro-Demarchi-Gomes/mm-damon-Add-option-to-monitor-only-writes/20220203-211407
base:   https://github.com/hnaz/linux-mm master
config: hexagon-randconfig-r041-20220130 (https://download.01.org/0day-ci/archive/20220204/202202040414.4fF2j3mp-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a73e4ce6a59b01f0e37037761c1e6889d539d233)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/0958bb7e2514b62f174b8e5ccfdcff07ce2a2b6b
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Pedro-Demarchi-Gomes/mm-damon-Add-option-to-monitor-only-writes/20220203-211407
        git checkout 0958bb7e2514b62f174b8e5ccfdcff07ce2a2b6b
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> mm/damon/prmtv-common.c:87:7: error: implicit declaration of function 'pmd_dirty' [-Werror,-Wimplicit-function-declaration]
                   if (pmd_dirty(old))
                       ^
   mm/damon/prmtv-common.c:87:7: note: did you mean 'pte_dirty'?
   arch/hexagon/include/asm/pgtable.h:301:19: note: 'pte_dirty' declared here
   static inline int pte_dirty(pte_t pte)
                     ^
>> mm/damon/prmtv-common.c:88:10: error: implicit declaration of function 'pmd_mkdirty' [-Werror,-Wimplicit-function-declaration]
                           pmd = pmd_mkdirty(pmd);
                                 ^
>> mm/damon/prmtv-common.c:88:8: error: assigning to 'pmd_t' from incompatible type 'int'
                           pmd = pmd_mkdirty(pmd);
                               ^ ~~~~~~~~~~~~~~~~
>> mm/damon/prmtv-common.c:89:7: error: implicit declaration of function 'pmd_young' [-Werror,-Wimplicit-function-declaration]
                   if (pmd_young(old))
                       ^
   mm/damon/prmtv-common.c:89:7: note: did you mean 'pte_young'?
   arch/hexagon/include/asm/pgtable.h:295:19: note: 'pte_young' declared here
   static inline int pte_young(pte_t pte)
                     ^
>> mm/damon/prmtv-common.c:90:10: error: implicit declaration of function 'pmd_mkyoung' [-Werror,-Wimplicit-function-declaration]
                           pmd = pmd_mkyoung(pmd);
                                 ^
   mm/damon/prmtv-common.c:90:8: error: assigning to 'pmd_t' from incompatible type 'int'
                           pmd = pmd_mkyoung(pmd);
                               ^ ~~~~~~~~~~~~~~~~
>> mm/damon/prmtv-common.c:92:9: error: implicit declaration of function 'pmd_wrprotect' [-Werror,-Wimplicit-function-declaration]
                   pmd = pmd_wrprotect(pmd);
                         ^
   mm/damon/prmtv-common.c:92:9: note: did you mean 'pte_wrprotect'?
   arch/hexagon/include/asm/pgtable.h:315:21: note: 'pte_wrprotect' declared here
   static inline pte_t pte_wrprotect(pte_t pte)
                       ^
   mm/damon/prmtv-common.c:92:7: error: assigning to 'pmd_t' from incompatible type 'int'
                   pmd = pmd_wrprotect(pmd);
                       ^ ~~~~~~~~~~~~~~~~~~
>> mm/damon/prmtv-common.c:95:3: error: implicit declaration of function 'set_pmd_at' [-Werror,-Wimplicit-function-declaration]
                   set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
                   ^
   mm/damon/prmtv-common.c:98:3: error: implicit declaration of function 'set_pmd_at' [-Werror,-Wimplicit-function-declaration]
                   set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
                   ^
   10 errors generated.


vim +/pmd_dirty +87 mm/damon/prmtv-common.c

    78	
    79	static inline void clear_soft_dirty_pmd(struct vm_area_struct *vma,
    80			unsigned long addr, pmd_t *pmdp)
    81	{
    82		pmd_t old, pmd = *pmdp;
    83	
    84		if (pmd_present(pmd)) {
    85			/* See comment in change_huge_pmd() */
    86			old = pmdp_invalidate(vma, addr, pmdp);
  > 87			if (pmd_dirty(old))
  > 88				pmd = pmd_mkdirty(pmd);
  > 89			if (pmd_young(old))
  > 90				pmd = pmd_mkyoung(pmd);
    91	
  > 92			pmd = pmd_wrprotect(pmd);
    93			pmd = pmd_clear_soft_dirty(pmd);
    94	
  > 95			set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
    96		} else if (is_migration_entry(pmd_to_swp_entry(pmd))) {
    97			pmd = pmd_swp_clear_soft_dirty(pmd);
    98			set_pmd_at(vma->vm_mm, addr, pmdp, pmd);
    99		}
   100	}
   101	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
