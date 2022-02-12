Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F288E4B3710
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 19:18:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229527AbiBLSST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 13:18:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiBLSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 13:18:16 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 355B85E767
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 10:18:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644689893; x=1676225893;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FVcgXrZ+Du2fSN7o3UgBvON225zfZCAjiMSNYgbiPfE=;
  b=EmhTf8qrEQ14WPF0PqcXdHJEbpVHDgutOsWi7tQnYFp3q8Xey/T34Rp6
   Zc+8jdTZnuJam7ZLy3r/tI3iPUMmdMkAisM1JZ4fLa/Uv81gFGMKe0hiH
   QPc3xp+n9mQgELmRYR/S+IMlH2IjKlqPf56f5LfhuDHOxFnWtFpUnaUzZ
   jOe2l4fiXZwVmN6SQgm99B7laMIgqOE3BEf4fN8gFb9NLnD3noHFgvWYS
   KDZTNok4/2f9E8IsjhvMqx27k7ZH4UQuqdGBOGpVmhkgYSVZhDUA2r8PP
   +r5HoAWbe2UMmzUiIpies30btkxIWyt0Y9ETHHk1443/gDv9jTD3mlZQL
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10256"; a="233448219"
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="233448219"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2022 10:18:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,364,1635231600"; 
   d="scan'208";a="491319262"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 12 Feb 2022 10:18:10 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIwyH-0006UH-TS; Sat, 12 Feb 2022 18:18:09 +0000
Date:   Sun, 13 Feb 2022 02:17:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Rik van Riel <riel@surriel.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, kernel-team@fb.com, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@suse.de>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] mm: clean up hwpoison page cache page in fault path
Message-ID: <202202122306.S9ByO64R-lkp@intel.com>
References: <20220211170557.7964a301@imladris.surriel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211170557.7964a301@imladris.surriel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rik,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/Rik-van-Riel/mm-clean-up-hwpoison-page-cache-page-in-fault-path/20220212-060643
base:   https://github.com/hnaz/linux-mm master
config: sparc-randconfig-s031-20220211 (https://download.01.org/0day-ci/archive/20220212/202202122306.S9ByO64R-lkp@intel.com/config)
compiler: sparc-linux-gcc (GCC) 11.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/abd960cdbc9487dbf0a0dc3b2395825a38f8fa44
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Rik-van-Riel/mm-clean-up-hwpoison-page-cache-page-in-fault-path/20220212-060643
        git checkout abd960cdbc9487dbf0a0dc3b2395825a38f8fa44
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=sparc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/memory.c:3913:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected int poisonret @@     got restricted vm_fault_t @@
   mm/memory.c:3913:33: sparse:     expected int poisonret
   mm/memory.c:3913:33: sparse:     got restricted vm_fault_t
>> mm/memory.c:3922:24: sparse: sparse: incorrect type in return expression (different base types) @@     expected restricted vm_fault_t @@     got int [assigned] poisonret @@
   mm/memory.c:3922:24: sparse:     expected restricted vm_fault_t
   mm/memory.c:3922:24: sparse:     got int [assigned] poisonret
   mm/memory.c:1024:17: sparse: sparse: context imbalance in 'copy_pte_range' - different lock contexts for basic block
   mm/memory.c:1740:16: sparse: sparse: context imbalance in '__get_locked_pte' - different lock contexts for basic block
   mm/memory.c:1788:9: sparse: sparse: context imbalance in 'insert_page' - different lock contexts for basic block
   mm/memory.c:2290:17: sparse: sparse: context imbalance in 'remap_pte_range' - different lock contexts for basic block
   mm/memory.c:2546:17: sparse: sparse: context imbalance in 'apply_to_pte_range' - unexpected unlock
   mm/memory.c:2834:17: sparse: sparse: context imbalance in 'wp_page_copy' - unexpected unlock
   mm/memory.c:3173:17: sparse: sparse: context imbalance in 'wp_pfn_shared' - unexpected unlock
   mm/memory.c:3236:19: sparse: sparse: context imbalance in 'do_wp_page' - different lock contexts for basic block
   mm/memory.c:4939:5: sparse: sparse: context imbalance in 'follow_invalidate_pte' - different lock contexts for basic block
   mm/memory.c: note: in included file (through arch/sparc/include/asm/pgtable.h, include/linux/pgtable.h, include/linux/mm.h):
   arch/sparc/include/asm/pgtable_32.h:275:29: sparse: sparse: context imbalance in 'follow_pfn' - unexpected unlock

vim +3913 mm/memory.c

  3875	
  3876	/*
  3877	 * The mmap_lock must have been held on entry, and may have been
  3878	 * released depending on flags and vma->vm_ops->fault() return value.
  3879	 * See filemap_fault() and __lock_page_retry().
  3880	 */
  3881	static vm_fault_t __do_fault(struct vm_fault *vmf)
  3882	{
  3883		struct vm_area_struct *vma = vmf->vma;
  3884		vm_fault_t ret;
  3885	
  3886		/*
  3887		 * Preallocate pte before we take page_lock because this might lead to
  3888		 * deadlocks for memcg reclaim which waits for pages under writeback:
  3889		 *				lock_page(A)
  3890		 *				SetPageWriteback(A)
  3891		 *				unlock_page(A)
  3892		 * lock_page(B)
  3893		 *				lock_page(B)
  3894		 * pte_alloc_one
  3895		 *   shrink_page_list
  3896		 *     wait_on_page_writeback(A)
  3897		 *				SetPageWriteback(B)
  3898		 *				unlock_page(B)
  3899		 *				# flush A, B to clear the writeback
  3900		 */
  3901		if (pmd_none(*vmf->pmd) && !vmf->prealloc_pte) {
  3902			vmf->prealloc_pte = pte_alloc_one(vma->vm_mm);
  3903			if (!vmf->prealloc_pte)
  3904				return VM_FAULT_OOM;
  3905		}
  3906	
  3907		ret = vma->vm_ops->fault(vmf);
  3908		if (unlikely(ret & (VM_FAULT_ERROR | VM_FAULT_NOPAGE | VM_FAULT_RETRY |
  3909				    VM_FAULT_DONE_COW)))
  3910			return ret;
  3911	
  3912		if (unlikely(PageHWPoison(vmf->page))) {
> 3913			int poisonret = VM_FAULT_HWPOISON;
  3914			if (ret & VM_FAULT_LOCKED) {
  3915				/* Retry if a clean page was removed from the cache. */
  3916				if (invalidate_inode_page(vmf->page))
  3917					poisonret = 0;
  3918				unlock_page(vmf->page);
  3919			}
  3920			put_page(vmf->page);
  3921			vmf->page = NULL;
> 3922			return poisonret;
  3923		}
  3924	
  3925		if (unlikely(!(ret & VM_FAULT_LOCKED)))
  3926			lock_page(vmf->page);
  3927		else
  3928			VM_BUG_ON_PAGE(!PageLocked(vmf->page), vmf->page);
  3929	
  3930		return ret;
  3931	}
  3932	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
