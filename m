Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2444E86D6
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 10:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235654AbiC0IJp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 04:09:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbiC0IJk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 04:09:40 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8868F46177
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 01:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648368482; x=1679904482;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0bIVGGz5y2gYDf0tJIHOjgF6exLKgwLl1xxjM775mIw=;
  b=KJOcJ3Fnehyx+gFzuUc/qCGE2snzha4XAOBt7QSoN1sK9bYzYrbPPfym
   EuCdOCbLJvvUDv+uITFDehkBRSz0KcmLJCNCRV+m8DEnhWFa5ZrJeVdjc
   hfoVVAK/1VkFqn7Ab83q5WLLNfQAkYwgGZ62LnlU4ZKoxBp8a32ggEDFI
   urSpj1tGoiJsKeKfaNs+1taSILuB31GN7+5+qlasHBNDgRTXknBKmLjou
   d0pNmJf+BgCCycqIRLbvj4cY8ymCp+/9bJIkRCFFDmRWyMeC0ngZ/So9I
   LeKXdgNPBhibgL2T0hn8LUNX8Ip2c8JY1BivsFfdFQQNCjpY5cnecWDwB
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10298"; a="258801294"
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="258801294"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2022 01:08:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,214,1643702400"; 
   d="scan'208";a="617500213"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 27 Mar 2022 01:07:57 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nYNwK-0000qj-UH; Sun, 27 Mar 2022 08:07:56 +0000
Date:   Sun, 27 Mar 2022 16:07:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Muchun Song <songmuchun@bytedance.com>,
        torvalds@linux-foundation.org, glider@google.com, elver@google.com,
        dvyukov@google.com, akpm@linux-foundation.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, iamjoonsoo.kim@lge.com,
        vbabka@suse.cz, roman.gushchin@linux.dev
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH 2/2] mm: kfence: fix objcgs vector allocation
Message-ID: <202203271634.QymsHESG-lkp@intel.com>
References: <20220327051853.57647-2-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220327051853.57647-2-songmuchun@bytedance.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Muchun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Muchun-Song/mm-kfence-fix-missing-objcg-housekeeping-for-SLAB/20220327-132038
base:   https://github.com/hnaz/linux-mm master
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220327/202203271634.QymsHESG-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a33cf78311711db98d9f77541d0a4b50bc466875
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Muchun-Song/mm-kfence-fix-missing-objcg-housekeeping-for-SLAB/20220327-132038
        git checkout a33cf78311711db98d9f77541d0a4b50bc466875
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash mm/kfence/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> mm/kfence/core.c:593:36: warning: incompatible integer to pointer conversion passing 'unsigned long' to parameter of type 'const void *' [-Wint-conversion]
                   struct slab *slab = virt_to_slab(addr);
                                                    ^~~~
   mm/kfence/../slab.h:173:53: note: passing argument to parameter 'addr' here
   static inline struct slab *virt_to_slab(const void *addr)
                                                       ^
   mm/kfence/core.c:597:9: error: no member named 'memcg_data' in 'struct slab'
                   slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
                   ~~~~  ^
   mm/kfence/core.c:597:52: error: use of undeclared identifier 'MEMCG_DATA_OBJCGS'
                   slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
                                                                    ^
   1 warning and 2 errors generated.


vim +593 mm/kfence/core.c

   543	
   544	/*
   545	 * Initialization of the KFENCE pool after its allocation.
   546	 * Returns 0 on success; otherwise returns the address up to
   547	 * which partial initialization succeeded.
   548	 */
   549	static unsigned long kfence_init_pool(void)
   550	{
   551		unsigned long addr = (unsigned long)__kfence_pool;
   552		struct page *pages;
   553		int i;
   554	
   555		if (!arch_kfence_init_pool())
   556			return addr;
   557	
   558		pages = virt_to_page(addr);
   559	
   560		/*
   561		 * Set up object pages: they must have PG_slab set, to avoid freeing
   562		 * these as real pages.
   563		 *
   564		 * We also want to avoid inserting kfence_free() in the kfree()
   565		 * fast-path in SLUB, and therefore need to ensure kfree() correctly
   566		 * enters __slab_free() slow-path.
   567		 */
   568		for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
   569			if (!i || (i % 2))
   570				continue;
   571	
   572			/* Verify we do not have a compound head page. */
   573			if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
   574				return addr;
   575	
   576			__SetPageSlab(&pages[i]);
   577		}
   578	
   579		/*
   580		 * Protect the first 2 pages. The first page is mostly unnecessary, and
   581		 * merely serves as an extended guard page. However, adding one
   582		 * additional page in the beginning gives us an even number of pages,
   583		 * which simplifies the mapping of address to metadata index.
   584		 */
   585		for (i = 0; i < 2; i++) {
   586			if (unlikely(!kfence_protect(addr)))
   587				return addr;
   588	
   589			addr += PAGE_SIZE;
   590		}
   591	
   592		for (i = 0; i < CONFIG_KFENCE_NUM_OBJECTS; i++) {
 > 593			struct slab *slab = virt_to_slab(addr);
   594			struct kfence_metadata *meta = &kfence_metadata[i];
   595	
   596			/* Initialize metadata. */
   597			slab->memcg_data = (unsigned long)&meta->objcg | MEMCG_DATA_OBJCGS;
   598			INIT_LIST_HEAD(&meta->list);
   599			raw_spin_lock_init(&meta->lock);
   600			meta->state = KFENCE_OBJECT_UNUSED;
   601			meta->addr = addr; /* Initialize for validation in metadata_to_pageaddr(). */
   602			list_add_tail(&meta->list, &kfence_freelist);
   603	
   604			/* Protect the right redzone. */
   605			if (unlikely(!kfence_protect(addr + PAGE_SIZE)))
   606				return addr;
   607	
   608			addr += 2 * PAGE_SIZE;
   609		}
   610	
   611		/*
   612		 * The pool is live and will never be deallocated from this point on.
   613		 * Remove the pool object from the kmemleak object tree, as it would
   614		 * otherwise overlap with allocations returned by kfence_alloc(), which
   615		 * are registered with kmemleak through the slab post-alloc hook.
   616		 */
   617		kmemleak_free(__kfence_pool);
   618	
   619		return 0;
   620	}
   621	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
