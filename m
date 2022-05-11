Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE8B5238BC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 18:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344623AbiEKQT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 12:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344587AbiEKQTy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 12:19:54 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A92237240
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 09:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652285992; x=1683821992;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KZA+b2KwiXUtSRcO3dJQiKs6XgHBt2Eu3grD6WobVio=;
  b=V6VrCeIEfTKVedERGis/zwpXZGkhblf+MrY/OLI7LTTJj2NjQZBPcdLj
   9JWF7dbBQTZrrcT9TleLWb4UMMaipYv+QH6Pa3Go/ivsQH1DFCnP+xmba
   gDl/JpLVJMjnDOrc5kj6PSAITPjJmsG9sk0XYoNqKpLstcNi5CEO7hT25
   99ZxltVbgZEn38TAiGjAzIojfrW/tI3oYHACx6VQ+BjQGlIGN5o8959CK
   Fzr7vYAcjRA4PILAyAf0HzRDwfzlFTX9o5nsyDHscwYZKPlSndYP9Hp8e
   gW3diIA5x5sNk3ceBmkzw1u17Kz9ZQ2Jwgxlq3uvjOAuWPq9aC2rB2l0O
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10344"; a="249641600"
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="249641600"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2022 09:16:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,217,1647327600"; 
   d="scan'208";a="602998585"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 May 2022 09:16:57 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nop1E-000JHr-Ne;
        Wed, 11 May 2022 16:16:56 +0000
Date:   Thu, 12 May 2022 00:16:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [intel-tdx:guest-unaccepted-memory 3/15] mm/page_alloc.c:1183:12:
 warning: 'page_needs_acceptance' is used uninitialized
Message-ID: <202205120007.cudgBgVI-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/intel/tdx.git guest-unaccepted-memory
head:   83a8442434ff3bbf432df7508f1fefd447ca2c86
commit: 0845556ccd9555f5245d3bdd6cb646c2ea3fa9c2 [3/15] mm: Add support for unaccepted memory
config: x86_64-randconfig-a016-20220509 (https://download.01.org/0day-ci/archive/20220512/202205120007.cudgBgVI-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel/tdx/commit/0845556ccd9555f5245d3bdd6cb646c2ea3fa9c2
        git remote add intel-tdx https://github.com/intel/tdx.git
        git fetch --no-tags intel-tdx guest-unaccepted-memory
        git checkout 0845556ccd9555f5245d3bdd6cb646c2ea3fa9c2
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/page_alloc.c: In function '__free_one_page':
>> mm/page_alloc.c:1183:12: warning: 'page_needs_acceptance' is used uninitialized [-Wuninitialized]
    1183 |         if (!page_needs_acceptance && (fpi_flags & FPI_UNACCEPTED_SLOWPATH))
         |            ^


vim +/page_needs_acceptance +1183 mm/page_alloc.c

  1056	
  1057	/*
  1058	 * Freeing function for a buddy system allocator.
  1059	 *
  1060	 * The concept of a buddy system is to maintain direct-mapped table
  1061	 * (containing bit values) for memory blocks of various "orders".
  1062	 * The bottom level table contains the map for the smallest allocatable
  1063	 * units of memory (here, pages), and each level above it describes
  1064	 * pairs of units from the levels below, hence, "buddies".
  1065	 * At a high level, all that happens here is marking the table entry
  1066	 * at the bottom level available, and propagating the changes upward
  1067	 * as necessary, plus some accounting needed to play nicely with other
  1068	 * parts of the VM system.
  1069	 * At each level, we keep a list of pages, which are heads of continuous
  1070	 * free pages of length of (1 << order) and marked with PageBuddy.
  1071	 * Page's order is recorded in page_private(page) field.
  1072	 * So when we are allocating or freeing one, we can derive the state of the
  1073	 * other.  That is, if we allocate a small block, and both were
  1074	 * free, the remainder of the region must be split into blocks.
  1075	 * If a block is freed, and its buddy is also free, then this
  1076	 * triggers coalescing into a block of larger size.
  1077	 *
  1078	 * -- nyc
  1079	 */
  1080	
  1081	static inline void __free_one_page(struct page *page,
  1082			unsigned long pfn,
  1083			struct zone *zone, unsigned int order,
  1084			int migratetype, fpi_t fpi_flags)
  1085	{
  1086		struct capture_control *capc = task_capc(zone);
  1087		unsigned int max_order = pageblock_order;
  1088		unsigned long buddy_pfn;
  1089		unsigned long combined_pfn;
  1090		struct page *buddy;
  1091		bool to_tail;
  1092		bool page_needs_acceptance;
  1093	
  1094		VM_BUG_ON(!zone_is_initialized(zone));
  1095		VM_BUG_ON_PAGE(page->flags & PAGE_FLAGS_CHECK_AT_PREP, page);
  1096	
  1097		VM_BUG_ON(migratetype == -1);
  1098		if (likely(!is_migrate_isolate(migratetype)))
  1099			__mod_zone_freepage_state(zone, 1 << order, migratetype);
  1100	
  1101		VM_BUG_ON_PAGE(pfn & ((1 << order) - 1), page);
  1102		VM_BUG_ON_PAGE(bad_range(zone, page), page);
  1103	
  1104		if (PageUnaccepted(page)) {
  1105			page_needs_acceptance = true;
  1106			__ClearPageUnaccepted(page);
  1107		}
  1108	
  1109	continue_merging:
  1110		while (order < max_order) {
  1111			if (compaction_capture(capc, page, order, migratetype)) {
  1112				__mod_zone_freepage_state(zone, -(1 << order),
  1113									migratetype);
  1114				return;
  1115			}
  1116			buddy_pfn = __find_buddy_pfn(pfn, order);
  1117			buddy = page + (buddy_pfn - pfn);
  1118	
  1119			if (!page_is_buddy(page, buddy, order))
  1120				goto done_merging;
  1121			/*
  1122			 * Our buddy is free or it is CONFIG_DEBUG_PAGEALLOC guard page,
  1123			 * merge with it and move up one order.
  1124			 */
  1125			if (page_is_guard(buddy))
  1126				clear_page_guard(zone, buddy, order, migratetype);
  1127			else
  1128				del_page_from_free_list(buddy, zone, order);
  1129	
  1130			/* Mark page unaccepted if any of merged pages were unaccepted */
  1131			if (PageUnaccepted(buddy)) {
  1132				page_needs_acceptance = true;
  1133				__ClearPageUnaccepted(buddy);
  1134			}
  1135	
  1136			combined_pfn = buddy_pfn & pfn;
  1137			page = page + (combined_pfn - pfn);
  1138			pfn = combined_pfn;
  1139			order++;
  1140		}
  1141		if (order < MAX_ORDER - 1) {
  1142			/* If we are here, it means order is >= pageblock_order.
  1143			 * We want to prevent merge between freepages on pageblock
  1144			 * without fallbacks and normal pageblock. Without this,
  1145			 * pageblock isolation could cause incorrect freepage or CMA
  1146			 * accounting or HIGHATOMIC accounting.
  1147			 *
  1148			 * We don't want to hit this code for the more frequent
  1149			 * low-order merging.
  1150			 */
  1151			int buddy_mt;
  1152	
  1153			buddy_pfn = __find_buddy_pfn(pfn, order);
  1154			buddy = page + (buddy_pfn - pfn);
  1155	
  1156			if (!page_is_buddy(page, buddy, order))
  1157				goto done_merging;
  1158			buddy_mt = get_pageblock_migratetype(buddy);
  1159	
  1160			if (migratetype != buddy_mt
  1161					&& (!migratetype_is_mergeable(migratetype) ||
  1162						!migratetype_is_mergeable(buddy_mt)))
  1163				goto done_merging;
  1164			max_order = order + 1;
  1165			goto continue_merging;
  1166		}
  1167	
  1168	done_merging:
  1169		set_buddy_order(page, order);
  1170	
  1171		/*
  1172		 * The page gets marked as PageUnaccepted() if any of merged-in pages
  1173		 * is PageUnaccepted().
  1174		 *
  1175		 * New pages, just being added to buddy allocator, do not have
  1176		 * PageUnaccepted() set. FPI_UNACCEPTED_SLOWPATH indicates that the
  1177		 * page is new and page_is_unaccepted() check is required to
  1178		 * determinate if acceptance is required.
  1179		 *
  1180		 * Avoid calling page_is_unaccepted() if it is known that the page
  1181		 * needs acceptance. It can be costly.
  1182		 */
> 1183		if (!page_needs_acceptance && (fpi_flags & FPI_UNACCEPTED_SLOWPATH))
  1184			page_needs_acceptance = page_is_unaccepted(page, order);
  1185		if (page_needs_acceptance)
  1186			__SetPageUnaccepted(page);
  1187	
  1188		if (fpi_flags & FPI_TO_TAIL)
  1189			to_tail = true;
  1190		else if (is_shuffle_order(order))
  1191			to_tail = shuffle_pick_tail();
  1192		else
  1193			to_tail = buddy_merge_likely(pfn, buddy_pfn, page, order);
  1194	
  1195		if (to_tail)
  1196			add_to_free_list_tail(page, zone, order, migratetype);
  1197		else
  1198			add_to_free_list(page, zone, order, migratetype);
  1199	
  1200		/* Notify page reporting subsystem of freed page */
  1201		if (!(fpi_flags & FPI_SKIP_REPORT_NOTIFY))
  1202			page_reporting_notify_free(order);
  1203	}
  1204	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
