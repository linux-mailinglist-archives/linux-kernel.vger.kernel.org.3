Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1D14F98F2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 17:03:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237362AbiDHPFv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 11:05:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237357AbiDHPFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 11:05:42 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A9612F067F;
        Fri,  8 Apr 2022 08:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649430218; x=1680966218;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gaqjzmur0Tu/xRmFAowXDiaWHMs/lzvpbqrClJNEVeI=;
  b=YQz56/spGCDf0MTsEu5KC/o7mBHNe5GTYFnpbNX1PJFvyk4nlsC7hGAW
   vobEQRnNo3irgo2RpJa5g2rrfQ8zuNHs0BZfpPv4raCn565YaC3PySeEL
   GUZY+P/qtg1swlFRHWWseAP1A/kbSYJHypn0TagInTxdFs1oqv5m5LdOE
   09JHt92/piacxg3qlthOHWz2vwnSZVINvmv+JqVIOizacNo5xEpA3+U1Z
   E77QKzUzhabpwmWSXFAzABN/LrmdlO2912/pcJ5ZbNH2IB6hmS5+/lVfr
   +WIA2AZ8XS0zjfoj1lEZZy1+acGS7UHRY2leFj2BWEIoQ2zOn/2iAsId7
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="259209930"
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="259209930"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 08:03:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,245,1643702400"; 
   d="scan'208";a="852099002"
Received: from lkp-server02.sh.intel.com (HELO 7e80bc2a00a0) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 08 Apr 2022 08:03:32 -0700
Received: from kbuild by 7e80bc2a00a0 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ncq96-0000NT-5w;
        Fri, 08 Apr 2022 15:03:32 +0000
Date:   Fri, 8 Apr 2022 23:02:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     cgel.zte@gmail.com, akpm@linux-foundation.org, david@redhat.com
Cc:     kbuild-all@lists.01.org, corbet@lwn.net, bsingharora@gmail.com,
        mike.kravetz@oracle.com, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn, peterz@infradead.org,
        jiang.xuexin@zte.com.cn, sfr@canb.auug.org.au,
        thomas.orgis@uni-hamburg.de, ran.xiaokai@zte.com.cn,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] delayacct: track delays from write-protect copy
Message-ID: <202204082220.1w5xTsNt-lkp@intel.com>
References: <20220408103708.2495882-1-yang.yang29@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408103708.2495882-1-yang.yang29@zte.com.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on hnaz-mm/master]
[also build test ERROR on next-20220408]
[cannot apply to linus/master linux/master v5.18-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/cgel-zte-gmail-com/delayacct-track-delays-from-write-protect-copy/20220408-183941
base:   https://github.com/hnaz/linux-mm master
config: parisc-randconfig-r036-20220408 (https://download.01.org/0day-ci/archive/20220408/202204082220.1w5xTsNt-lkp@intel.com/config)
compiler: hppa64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6ae63c8c70d9597a9e67cb06b6a23a5b01e52da6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review cgel-zte-gmail-com/delayacct-track-delays-from-write-protect-copy/20220408-183941
        git checkout 6ae63c8c70d9597a9e67cb06b6a23a5b01e52da6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=parisc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/hugetlb.c: In function 'hugetlb_wp':
>> mm/hugetlb.c:5176:9: error: implicit declaration of function 'delayacct_wpcopy_start' [-Werror=implicit-function-declaration]
    5176 |         delayacct_wpcopy_start();
         |         ^~~~~~~~~~~~~~~~~~~~~~
>> mm/hugetlb.c:5189:17: error: implicit declaration of function 'delayacct_wpcopy_end' [-Werror=implicit-function-declaration]
    5189 |                 delayacct_wpcopy_end();
         |                 ^~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/delayacct_wpcopy_start +5176 mm/hugetlb.c

  5150	
  5151	/*
  5152	 * hugetlb_wp() should be called with page lock of the original hugepage held.
  5153	 * Called with hugetlb_fault_mutex_table held and pte_page locked so we
  5154	 * cannot race with other handlers or page migration.
  5155	 * Keep the pte_same checks anyway to make transition from the mutex easier.
  5156	 */
  5157	static vm_fault_t hugetlb_wp(struct mm_struct *mm, struct vm_area_struct *vma,
  5158			       unsigned long address, pte_t *ptep, unsigned int flags,
  5159			       struct page *pagecache_page, spinlock_t *ptl)
  5160	{
  5161		const bool unshare = flags & FAULT_FLAG_UNSHARE;
  5162		pte_t pte;
  5163		struct hstate *h = hstate_vma(vma);
  5164		struct page *old_page, *new_page;
  5165		int outside_reserve = 0;
  5166		vm_fault_t ret = 0;
  5167		unsigned long haddr = address & huge_page_mask(h);
  5168		struct mmu_notifier_range range;
  5169	
  5170		VM_BUG_ON(unshare && (flags & FOLL_WRITE));
  5171		VM_BUG_ON(!unshare && !(flags & FOLL_WRITE));
  5172	
  5173		pte = huge_ptep_get(ptep);
  5174		old_page = pte_page(pte);
  5175	
> 5176		delayacct_wpcopy_start();
  5177	
  5178	retry_avoidcopy:
  5179		/*
  5180		 * If no-one else is actually using this page, we're the exclusive
  5181		 * owner and can reuse this page.
  5182		 */
  5183		if (page_mapcount(old_page) == 1 && PageAnon(old_page)) {
  5184			if (!PageAnonExclusive(old_page))
  5185				page_move_anon_rmap(old_page, vma);
  5186			if (likely(!unshare))
  5187				set_huge_ptep_writable(vma, haddr, ptep);
  5188	
> 5189			delayacct_wpcopy_end();
  5190			return 0;
  5191		}
  5192		VM_BUG_ON_PAGE(PageAnon(old_page) && PageAnonExclusive(old_page),
  5193			       old_page);
  5194	
  5195		/*
  5196		 * If the process that created a MAP_PRIVATE mapping is about to
  5197		 * perform a COW due to a shared page count, attempt to satisfy
  5198		 * the allocation without using the existing reserves. The pagecache
  5199		 * page is used to determine if the reserve at this address was
  5200		 * consumed or not. If reserves were used, a partial faulted mapping
  5201		 * at the time of fork() could consume its reserves on COW instead
  5202		 * of the full address range.
  5203		 */
  5204		if (is_vma_resv_set(vma, HPAGE_RESV_OWNER) &&
  5205				old_page != pagecache_page)
  5206			outside_reserve = 1;
  5207	
  5208		get_page(old_page);
  5209	
  5210		/*
  5211		 * Drop page table lock as buddy allocator may be called. It will
  5212		 * be acquired again before returning to the caller, as expected.
  5213		 */
  5214		spin_unlock(ptl);
  5215		new_page = alloc_huge_page(vma, haddr, outside_reserve);
  5216	
  5217		if (IS_ERR(new_page)) {
  5218			/*
  5219			 * If a process owning a MAP_PRIVATE mapping fails to COW,
  5220			 * it is due to references held by a child and an insufficient
  5221			 * huge page pool. To guarantee the original mappers
  5222			 * reliability, unmap the page from child processes. The child
  5223			 * may get SIGKILLed if it later faults.
  5224			 */
  5225			if (outside_reserve) {
  5226				struct address_space *mapping = vma->vm_file->f_mapping;
  5227				pgoff_t idx;
  5228				u32 hash;
  5229	
  5230				put_page(old_page);
  5231				BUG_ON(huge_pte_none(pte));
  5232				/*
  5233				 * Drop hugetlb_fault_mutex and i_mmap_rwsem before
  5234				 * unmapping.  unmapping needs to hold i_mmap_rwsem
  5235				 * in write mode.  Dropping i_mmap_rwsem in read mode
  5236				 * here is OK as COW mappings do not interact with
  5237				 * PMD sharing.
  5238				 *
  5239				 * Reacquire both after unmap operation.
  5240				 */
  5241				idx = vma_hugecache_offset(h, vma, haddr);
  5242				hash = hugetlb_fault_mutex_hash(mapping, idx);
  5243				mutex_unlock(&hugetlb_fault_mutex_table[hash]);
  5244				i_mmap_unlock_read(mapping);
  5245	
  5246				unmap_ref_private(mm, vma, old_page, haddr);
  5247	
  5248				i_mmap_lock_read(mapping);
  5249				mutex_lock(&hugetlb_fault_mutex_table[hash]);
  5250				spin_lock(ptl);
  5251				ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
  5252				if (likely(ptep &&
  5253					   pte_same(huge_ptep_get(ptep), pte)))
  5254					goto retry_avoidcopy;
  5255				/*
  5256				 * race occurs while re-acquiring page table
  5257				 * lock, and our job is done.
  5258				 */
  5259				delayacct_wpcopy_end();
  5260				return 0;
  5261			}
  5262	
  5263			ret = vmf_error(PTR_ERR(new_page));
  5264			goto out_release_old;
  5265		}
  5266	
  5267		/*
  5268		 * When the original hugepage is shared one, it does not have
  5269		 * anon_vma prepared.
  5270		 */
  5271		if (unlikely(anon_vma_prepare(vma))) {
  5272			ret = VM_FAULT_OOM;
  5273			goto out_release_all;
  5274		}
  5275	
  5276		copy_user_huge_page(new_page, old_page, address, vma,
  5277				    pages_per_huge_page(h));
  5278		__SetPageUptodate(new_page);
  5279	
  5280		mmu_notifier_range_init(&range, MMU_NOTIFY_CLEAR, 0, vma, mm, haddr,
  5281					haddr + huge_page_size(h));
  5282		mmu_notifier_invalidate_range_start(&range);
  5283	
  5284		/*
  5285		 * Retake the page table lock to check for racing updates
  5286		 * before the page tables are altered
  5287		 */
  5288		spin_lock(ptl);
  5289		ptep = huge_pte_offset(mm, haddr, huge_page_size(h));
  5290		if (likely(ptep && pte_same(huge_ptep_get(ptep), pte))) {
  5291			ClearHPageRestoreReserve(new_page);
  5292	
  5293			/* Break COW or unshare */
  5294			huge_ptep_clear_flush(vma, haddr, ptep);
  5295			mmu_notifier_invalidate_range(mm, range.start, range.end);
  5296			page_remove_rmap(old_page, vma, true);
  5297			hugepage_add_new_anon_rmap(new_page, vma, haddr);
  5298			set_huge_pte_at(mm, haddr, ptep,
  5299					make_huge_pte(vma, new_page, !unshare));
  5300			SetHPageMigratable(new_page);
  5301			/* Make the old page be freed below */
  5302			new_page = old_page;
  5303		}
  5304		spin_unlock(ptl);
  5305		mmu_notifier_invalidate_range_end(&range);
  5306	out_release_all:
  5307		/*
  5308		 * No restore in case of successful pagetable update (Break COW or
  5309		 * unshare)
  5310		 */
  5311		if (new_page != old_page)
  5312			restore_reserve_on_error(h, vma, haddr, new_page);
  5313		put_page(new_page);
  5314	out_release_old:
  5315		put_page(old_page);
  5316	
  5317		spin_lock(ptl); /* Caller expects lock to be held */
  5318	
  5319		delayacct_wpcopy_end();
  5320		return ret;
  5321	}
  5322	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
