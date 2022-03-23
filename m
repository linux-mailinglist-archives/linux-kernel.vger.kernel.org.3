Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5A604E4CBE
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 07:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241963AbiCWGby (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 02:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCWGbx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 02:31:53 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EED554B5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 23:30:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648017024; x=1679553024;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qZkvh1I2LREwJGaLqOupj4PchKcSqpuLUelxy/Y1Fac=;
  b=WvvBlm7LtIuV9Tes3bruLJeP3R5Q90i38QqKUPSj3liWUBjqyDQQPhaD
   p4U+gLXn7YvI/8DRANPgdc3w0mD9dtFyvnP9pexCAsSA815B+YqW5HZ1C
   yCTPDo0i8LdRiYSLFuRPkEm28FR4IsXVJiZfMMdMBF+W+V26Z/u4yASjL
   8kvlSP0wG813o4I3IWSC/cjI0MgrtTMwQ7ftBGzTO+mUwtGwkdEerc+LN
   6UqEm5EOB+e6iZgsVdCdsu2RsADRPn18PzmjmvT5gW+lcgfCdujkV3MNe
   iwuKxXfa3pB0LOjRAwNlDbseAmoXAQ8BPLMZHDhTZabElfdaFAA1ZI6gL
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="255596125"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="255596125"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 23:30:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="515664615"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2022 23:30:20 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWuVf-000Jk6-NQ; Wed, 23 Mar 2022 06:30:19 +0000
Date:   Wed, 23 Mar 2022 14:30:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, akpm@linux-foundation.org, david@redhat.com
Cc:     kbuild-all@lists.01.org, yang.yang29@zte.com.cn,
        dave.hansen@linux.intel.com, yang.shi@linux.alibaba.com,
        ran.xiaokai@zte.com.cn, saravanand@fb.com, minchan@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        xu xin <xu.xin16@zte.com.cn>
Subject: Re: [PATCH] mm/vmstat: add events for ksm cow
Message-ID: <202203231454.DszZMI5Y-lkp@intel.com>
References: <20220323031730.2342930-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323031730.2342930-1-yang.yang29@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]

url:    https://github.com/0day-ci/linux/commits/cgel-zte-gmail-com/mm-vmstat-add-events-for-ksm-cow/20220323-111932
base:   https://github.com/hnaz/linux-mm master
config: nios2-defconfig (https://download.01.org/0day-ci/archive/20220323/202203231454.DszZMI5Y-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/cc1a5f6c95b38b1bebb673c7fe3a2b64e2362acc
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/mm-vmstat-add-events-for-ksm-cow/20220323-111932
        git checkout cc1a5f6c95b38b1bebb673c7fe3a2b64e2362acc
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nios2 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/memory.c: In function 'do_wp_page':
>> mm/memory.c:3341:40: error: 'KSM_COW_FAIL' undeclared (first use in this function)
    3341 |                         count_vm_event(KSM_COW_FAIL);
         |                                        ^~~~~~~~~~~~
   mm/memory.c:3341:40: note: each undeclared identifier is reported only once for each function it appears in
>> mm/memory.c:3343:40: error: 'KSM_COW_SUCCESS' undeclared (first use in this function)
    3343 |                         count_vm_event(KSM_COW_SUCCESS);
         |                                        ^~~~~~~~~~~~~~~


vim +/KSM_COW_FAIL +3341 mm/memory.c

  3229	
  3230	/*
  3231	 * This routine handles present pages, when users try to write
  3232	 * to a shared page. It is done by copying the page to a new address
  3233	 * and decrementing the shared-page counter for the old page.
  3234	 *
  3235	 * Note that this routine assumes that the protection checks have been
  3236	 * done by the caller (the low-level page fault routine in most cases).
  3237	 * Thus we can safely just mark it writable once we've done any necessary
  3238	 * COW.
  3239	 *
  3240	 * We also mark the page dirty at this point even though the page will
  3241	 * change only once the write actually happens. This avoids a few races,
  3242	 * and potentially makes it more efficient.
  3243	 *
  3244	 * We enter with non-exclusive mmap_lock (to exclude vma changes,
  3245	 * but allow concurrent faults), with pte both mapped and locked.
  3246	 * We return with mmap_lock still held, but pte unmapped and unlocked.
  3247	 */
  3248	static vm_fault_t do_wp_page(struct vm_fault *vmf)
  3249		__releases(vmf->ptl)
  3250	{
  3251		struct vm_area_struct *vma = vmf->vma;
  3252		vm_fault_t ret = 0;
  3253		bool ksm = 0;
  3254	
  3255		if (userfaultfd_pte_wp(vma, *vmf->pte)) {
  3256			pte_unmap_unlock(vmf->pte, vmf->ptl);
  3257			return handle_userfault(vmf, VM_UFFD_WP);
  3258		}
  3259	
  3260		/*
  3261		 * Userfaultfd write-protect can defer flushes. Ensure the TLB
  3262		 * is flushed in this case before copying.
  3263		 */
  3264		if (unlikely(userfaultfd_wp(vmf->vma) &&
  3265			     mm_tlb_flush_pending(vmf->vma->vm_mm)))
  3266			flush_tlb_page(vmf->vma, vmf->address);
  3267	
  3268		vmf->page = vm_normal_page(vma, vmf->address, vmf->orig_pte);
  3269		if (!vmf->page) {
  3270			/*
  3271			 * VM_MIXEDMAP !pfn_valid() case, or VM_SOFTDIRTY clear on a
  3272			 * VM_PFNMAP VMA.
  3273			 *
  3274			 * We should not cow pages in a shared writeable mapping.
  3275			 * Just mark the pages writable and/or call ops->pfn_mkwrite.
  3276			 */
  3277			if ((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
  3278					     (VM_WRITE|VM_SHARED))
  3279				return wp_pfn_shared(vmf);
  3280	
  3281			pte_unmap_unlock(vmf->pte, vmf->ptl);
  3282			return wp_page_copy(vmf);
  3283		}
  3284	
  3285		/*
  3286		 * Take out anonymous pages first, anonymous shared vmas are
  3287		 * not dirty accountable.
  3288		 */
  3289		if (PageAnon(vmf->page)) {
  3290			struct page *page = vmf->page;
  3291			ksm = PageKsm(page);
  3292	
  3293			/*
  3294			 * We have to verify under page lock: these early checks are
  3295			 * just an optimization to avoid locking the page and freeing
  3296			 * the swapcache if there is little hope that we can reuse.
  3297			 *
  3298			 * PageKsm() doesn't necessarily raise the page refcount.
  3299			 */
  3300			if (ksm || page_count(page) > 3)
  3301				goto copy;
  3302			if (!PageLRU(page))
  3303				/*
  3304				 * Note: We cannot easily detect+handle references from
  3305				 * remote LRU pagevecs or references to PageLRU() pages.
  3306				 */
  3307				lru_add_drain();
  3308			if (page_count(page) > 1 + PageSwapCache(page))
  3309				goto copy;
  3310			if (!trylock_page(page))
  3311				goto copy;
  3312			if (PageSwapCache(page))
  3313				try_to_free_swap(page);
  3314			if (ksm || page_count(page) != 1) {
  3315				unlock_page(page);
  3316				goto copy;
  3317			}
  3318			/*
  3319			 * Ok, we've got the only page reference from our mapping
  3320			 * and the page is locked, it's dark out, and we're wearing
  3321			 * sunglasses. Hit it.
  3322			 */
  3323			unlock_page(page);
  3324			wp_page_reuse(vmf);
  3325			return VM_FAULT_WRITE;
  3326		} else if (unlikely((vma->vm_flags & (VM_WRITE|VM_SHARED)) ==
  3327						(VM_WRITE|VM_SHARED))) {
  3328			return wp_page_shared(vmf);
  3329		}
  3330	copy:
  3331		/*
  3332		 * Ok, we need to copy. Oh, well..
  3333		 */
  3334		get_page(vmf->page);
  3335	
  3336		pte_unmap_unlock(vmf->pte, vmf->ptl);
  3337		ret = wp_page_copy(vmf);
  3338	
  3339		if (ksm) {
  3340			if (unlikely(ret & VM_FAULT_ERROR))
> 3341				count_vm_event(KSM_COW_FAIL);
  3342			else
> 3343				count_vm_event(KSM_COW_SUCCESS);
  3344		}
  3345	
  3346		return ret;
  3347	}
  3348	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
