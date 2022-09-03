Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 885A65ABCBB
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 06:08:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiICEHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 00:07:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230173AbiICEHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 00:07:50 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4EC82F9D
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 21:07:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662178068; x=1693714068;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=IxxZUHHlxvMGIWHpFbOkVNJcLnq1HWJk2JHbvT4GlbI=;
  b=Wi8FIjsvR3Au9+r51rBvYzDUNnoz+ihgnVnoBvJ9RLWIhWHznmaqEcB9
   MlDyTJ0t0NWIrnOqb/WX6sb+awwTUaIyAiEnH5OUXPtMlSXA3fJ+e5m+I
   KPjZQ8EN1281NwZQKNlm1DdBvQ0OAE9rYexPUOvCQevL5LF4VXhXjGLPv
   ruKGwGyJ59RnIY0qDBdD9p/4rJZD8tAPk6aBsU0pr93TBVSNfYpJfLMlv
   lg0ZY8+WXlrHGfj1QF/dXReQre57gbD78Z+6I9jWvr5Vo4RosAChOu3de
   jkcdsLINE6nD7W/jdNjbOZ/WnTmVmziOiX2jGBtFjKPrhArUXOkPXyBQW
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10458"; a="275873586"
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="275873586"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Sep 2022 21:07:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,286,1654585200"; 
   d="scan'208";a="681493114"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 02 Sep 2022 21:07:47 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUKRe-000120-1S;
        Sat, 03 Sep 2022 04:07:46 +0000
Date:   Sat, 3 Sep 2022 12:07:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [djbw-nvdimm:libnvdimm-pending 12/16] drivers/dax/mapping.c:402:13:
 error: redefinition of 'dax_lock_page'
Message-ID: <202209031146.ZUuNeq2r-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git libnvdimm-pending
head:   ac9d6b3ba0a537b67bdc8e525308dc371da91e1b
commit: fd2e18c05d353b59283b4cb5508bafecd766b304 [12/16] devdax: Move address_space helpers to the DAX core
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220903/202209031146.ZUuNeq2r-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git/commit/?id=fd2e18c05d353b59283b4cb5508bafecd766b304
        git remote add djbw-nvdimm https://git.kernel.org/pub/scm/linux/kernel/git/djbw/nvdimm.git
        git fetch --no-tags djbw-nvdimm libnvdimm-pending
        git checkout fd2e18c05d353b59283b4cb5508bafecd766b304
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/dax/mapping.c: In function 'dax_associate_entry':
   drivers/dax/mapping.c:345:17: error: implicit declaration of function 'get_dev_pagemap_many'; did you mean 'put_dev_pagemap_many'? [-Werror=implicit-function-declaration]
     345 |         pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
         |                 ^~~~~~~~~~~~~~~~~~~~
         |                 put_dev_pagemap_many
   drivers/dax/mapping.c:345:15: warning: assignment to 'struct dev_pagemap *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     345 |         pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
         |               ^
   drivers/dax/mapping.c: At top level:
>> drivers/dax/mapping.c:402:13: error: redefinition of 'dax_lock_page'
     402 | dax_entry_t dax_lock_page(struct page *page)
         |             ^~~~~~~~~~~~~
   In file included from drivers/dax/mapping.c:11:
   include/linux/dax.h:187:27: note: previous definition of 'dax_lock_page' with type 'dax_entry_t(struct page *)' {aka 'long unsigned int(struct page *)'}
     187 | static inline dax_entry_t dax_lock_page(struct page *page)
         |                           ^~~~~~~~~~~~~
>> drivers/dax/mapping.c:449:6: error: redefinition of 'dax_unlock_page'
     449 | void dax_unlock_page(struct page *page, dax_entry_t cookie)
         |      ^~~~~~~~~~~~~~~
   include/linux/dax.h:194:20: note: previous definition of 'dax_unlock_page' with type 'void(struct page *, dax_entry_t)' {aka 'void(struct page *, long unsigned int)'}
     194 | static inline void dax_unlock_page(struct page *page, dax_entry_t cookie)
         |                    ^~~~~~~~~~~~~~~
>> drivers/dax/mapping.c:469:13: error: redefinition of 'dax_lock_mapping_entry'
     469 | dax_entry_t dax_lock_mapping_entry(struct address_space *mapping, pgoff_t index,
         |             ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dax.h:198:27: note: previous definition of 'dax_lock_mapping_entry' with type 'dax_entry_t(struct address_space *, long unsigned int,  struct page **)' {aka 'long unsigned int(struct address_space *, long unsigned int,  struct page **)'}
     198 | static inline dax_entry_t dax_lock_mapping_entry(struct address_space *mapping,
         |                           ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/dax/mapping.c:512:6: error: redefinition of 'dax_unlock_mapping_entry'
     512 | void dax_unlock_mapping_entry(struct address_space *mapping, pgoff_t index,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dax.h:204:20: note: previous definition of 'dax_unlock_mapping_entry' with type 'void(struct address_space *, long unsigned int,  dax_entry_t)' {aka 'void(struct address_space *, long unsigned int,  long unsigned int)'}
     204 | static inline void dax_unlock_mapping_entry(struct address_space *mapping,
         |                    ^~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dax/mapping.c:656:14: error: conflicting types for 'dax_layout_pinned_page_range'; have 'struct page *(struct address_space *, loff_t,  loff_t)' {aka 'struct page *(struct address_space *, long long int,  long long int)'}
     656 | struct page *dax_layout_pinned_page_range(struct address_space *mapping,
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dax.h:175:1: note: previous definition of 'dax_layout_pinned_page_range' with type 'struct page *(struct address_space *, long unsigned int,  long unsigned int)'
     175 | dax_layout_pinned_page_range(struct address_space *mapping, pgoff_t start,
         | ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/dax/mapping.c:718:14: error: redefinition of 'dax_layout_pinned_page'
     718 | struct page *dax_layout_pinned_page(struct address_space *mapping)
         |              ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/dax.h:169:28: note: previous definition of 'dax_layout_pinned_page' with type 'struct page *(struct address_space *)'
     169 | static inline struct page *dax_layout_pinned_page(struct address_space *mapping)
         |                            ^~~~~~~~~~~~~~~~~~~~~~
   drivers/dax/mapping.c: In function 'dax_writeback_one':
>> drivers/dax/mapping.c:904:17: error: implicit declaration of function 'pfn_mkclean_range' [-Werror=implicit-function-declaration]
     904 |                 pfn_mkclean_range(pfn, count, index, vma);
         |                 ^~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/dax_lock_page +402 drivers/dax/mapping.c

   324	
   325	/*
   326	 * When it is called in dax_insert_entry(), the cow flag will indicate that
   327	 * whether this entry is shared by multiple files.  If so, set the page->mapping
   328	 * FS_DAX_MAPPING_COW, and use page->index as refcount.
   329	 */
   330	static vm_fault_t dax_associate_entry(void *entry,
   331					      struct address_space *mapping,
   332					      struct vm_fault *vmf, unsigned long flags)
   333	{
   334		unsigned long size = dax_entry_size(entry), pfn, index;
   335		struct dev_pagemap *pgmap;
   336		int i = 0;
   337	
   338		if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
   339			return 0;
   340	
   341		if (!size)
   342			return 0;
   343	
   344		pfn = dax_to_pfn(entry);
 > 345		pgmap = get_dev_pagemap_many(pfn, NULL, PHYS_PFN(size));
   346		if (!pgmap)
   347			return VM_FAULT_SIGBUS;
   348	
   349		index = linear_page_index(vmf->vma, ALIGN(vmf->address, size));
   350		for_each_mapped_pfn(entry, pfn) {
   351			struct page *page = pfn_to_page(pfn);
   352	
   353			if (flags & DAX_COW) {
   354				dax_mapping_set_cow(page);
   355			} else {
   356				WARN_ON_ONCE(page->mapping);
   357				page->mapping = mapping;
   358				page->index = index + i++;
   359			}
   360		}
   361	
   362		return 0;
   363	}
   364	
   365	static void dax_disassociate_entry(void *entry, struct address_space *mapping,
   366					   bool trunc)
   367	{
   368		unsigned long size = dax_entry_size(entry), pfn;
   369		struct page *page;
   370	
   371		if (IS_ENABLED(CONFIG_FS_DAX_LIMITED))
   372			return;
   373	
   374		if (!size)
   375			return;
   376	
   377		page = pfn_to_page(dax_to_pfn(entry));
   378		put_dev_pagemap_many(page->pgmap, PHYS_PFN(size));
   379	
   380		for_each_mapped_pfn(entry, pfn) {
   381			page = pfn_to_page(pfn);
   382			WARN_ON_ONCE(trunc && page_maybe_dma_pinned(page));
   383			if (dax_mapping_is_cow(page->mapping)) {
   384				/* keep the CoW flag if this page is still shared */
   385				if (page->index-- > 0)
   386					continue;
   387			} else
   388				WARN_ON_ONCE(page->mapping && page->mapping != mapping);
   389			page->mapping = NULL;
   390			page->index = 0;
   391		}
   392	}
   393	
   394	/*
   395	 * dax_lock_page - Lock the DAX entry corresponding to a page
   396	 * @page: The page whose entry we want to lock
   397	 *
   398	 * Context: Process context.
   399	 * Return: A cookie to pass to dax_unlock_page() or 0 if the entry could
   400	 * not be locked.
   401	 */
 > 402	dax_entry_t dax_lock_page(struct page *page)
   403	{
   404		XA_STATE(xas, NULL, 0);
   405		void *entry;
   406	
   407		/* Ensure page->mapping isn't freed while we look at it */
   408		rcu_read_lock();
   409		for (;;) {
   410			struct address_space *mapping = READ_ONCE(page->mapping);
   411	
   412			entry = NULL;
   413			if (!mapping || !dax_mapping(mapping))
   414				break;
   415	
   416			/*
   417			 * In the device-dax case there's no need to lock, a
   418			 * struct dev_pagemap pin is sufficient to keep the
   419			 * inode alive, and we assume we have dev_pagemap pin
   420			 * otherwise we would not have a valid pfn_to_page()
   421			 * translation.
   422			 */
   423			entry = (void *)~0UL;
   424			if (S_ISCHR(mapping->host->i_mode))
   425				break;
   426	
   427			xas.xa = &mapping->i_pages;
   428			xas_lock_irq(&xas);
   429			if (mapping != page->mapping) {
   430				xas_unlock_irq(&xas);
   431				continue;
   432			}
   433			xas_set(&xas, page->index);
   434			entry = xas_load(&xas);
   435			if (dax_is_locked(entry)) {
   436				rcu_read_unlock();
   437				wait_entry_unlocked(&xas, entry);
   438				rcu_read_lock();
   439				continue;
   440			}
   441			dax_lock_entry(&xas, entry);
   442			xas_unlock_irq(&xas);
   443			break;
   444		}
   445		rcu_read_unlock();
   446		return (dax_entry_t)entry;
   447	}
   448	
 > 449	void dax_unlock_page(struct page *page, dax_entry_t cookie)
   450	{
   451		struct address_space *mapping = page->mapping;
   452		XA_STATE(xas, &mapping->i_pages, page->index);
   453	
   454		if (S_ISCHR(mapping->host->i_mode))
   455			return;
   456	
   457		dax_unlock_entry(&xas, (void *)cookie);
   458	}
   459	
   460	/*
   461	 * dax_lock_mapping_entry - Lock the DAX entry corresponding to a mapping
   462	 * @mapping: the file's mapping whose entry we want to lock
   463	 * @index: the offset within this file
   464	 * @page: output the dax page corresponding to this dax entry
   465	 *
   466	 * Return: A cookie to pass to dax_unlock_mapping_entry() or 0 if the entry
   467	 * could not be locked.
   468	 */
 > 469	dax_entry_t dax_lock_mapping_entry(struct address_space *mapping, pgoff_t index,
   470					   struct page **page)
   471	{
   472		XA_STATE(xas, NULL, 0);
   473		void *entry;
   474	
   475		rcu_read_lock();
   476		for (;;) {
   477			entry = NULL;
   478			if (!dax_mapping(mapping))
   479				break;
   480	
   481			xas.xa = &mapping->i_pages;
   482			xas_lock_irq(&xas);
   483			xas_set(&xas, index);
   484			entry = xas_load(&xas);
   485			if (dax_is_locked(entry)) {
   486				rcu_read_unlock();
   487				wait_entry_unlocked(&xas, entry);
   488				rcu_read_lock();
   489				continue;
   490			}
   491			if (!entry || dax_is_zero_entry(entry) ||
   492			    dax_is_empty_entry(entry)) {
   493				/*
   494				 * Because we are looking for entry from file's mapping
   495				 * and index, so the entry may not be inserted for now,
   496				 * or even a zero/empty entry.  We don't think this is
   497				 * an error case.  So, return a special value and do
   498				 * not output @page.
   499				 */
   500				entry = (void *)~0UL;
   501			} else {
   502				*page = pfn_to_page(dax_to_pfn(entry));
   503				dax_lock_entry(&xas, entry);
   504			}
   505			xas_unlock_irq(&xas);
   506			break;
   507		}
   508		rcu_read_unlock();
   509		return (dax_entry_t)entry;
   510	}
   511	
 > 512	void dax_unlock_mapping_entry(struct address_space *mapping, pgoff_t index,
   513				      dax_entry_t cookie)
   514	{
   515		XA_STATE(xas, &mapping->i_pages, index);
   516	
   517		if (cookie == ~0UL)
   518			return;
   519	
   520		dax_unlock_entry(&xas, (void *)cookie);
   521	}
   522	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
