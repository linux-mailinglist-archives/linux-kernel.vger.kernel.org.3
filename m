Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0916D4D3E5E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 01:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239064AbiCJAsJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 19:48:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbiCJAsC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 19:48:02 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C52E124C32
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 16:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646873222; x=1678409222;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=q27IIFrTX5Auup0eZVnfDyI9JkxZl5YZITGEcx2+eug=;
  b=Z8+xFmF5i873EdHTFStf9Cc313nLq7ZnEObVzrbGsBfgkjQRGQMjXDy4
   VAXQFOAnVrfjb4fS4bRE1B82J2+ufMxj4rV9gvQFJZH6LSk8vwbUAep7j
   i2uSVRl4d4lt7spLC4+9EtOl6A3mwUV9FH1yA8c/fzicEHoa0Q+7Y0sDX
   DU6F8iK2gku0t+lP2JFmL+KdOoqyoyncExtFtOuyi5boXNYqUpqaASym8
   qBnsFjek9c6lEH8OoNowyaX839fIpU1SoStSeMj/P6y3WqtVpkN4DEDsX
   cKJhTC/t08yhmXn2uPdVWUBO4CzXg1Z5gjDm1Crep89DiDPb1CGME3Sti
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10281"; a="255313062"
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="255313062"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2022 16:47:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,169,1643702400"; 
   d="scan'208";a="712159825"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 09 Mar 2022 16:47:00 -0800
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nS6xH-00044i-RM; Thu, 10 Mar 2022 00:46:59 +0000
Date:   Thu, 10 Mar 2022 08:46:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: [davidhildenbrand:cow_fixes_part_3 23/37] mm/gup.c:2555:17: error:
 label 'pte_unmap' used but not defined
Message-ID: <202203100823.mNsrrOHO-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux cow_fixes_part_3
head:   d49a3c40226a6bb397e7c532c81eb7d91026acaf
commit: f88e4c489908eb7ca8f63ea3dae1b09febcff282 [23/37] mm/gup: trigger FAULT_FLAG_UNSHARE when R/O-pinning a possibly shared anonymous page
config: powerpc64-buildonly-randconfig-r004-20220309 (https://download.01.org/0day-ci/archive/20220310/202203100823.mNsrrOHO-lkp@intel.com/config)
compiler: powerpc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/davidhildenbrand/linux/commit/f88e4c489908eb7ca8f63ea3dae1b09febcff282
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand cow_fixes_part_3
        git checkout f88e4c489908eb7ca8f63ea3dae1b09febcff282
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/gup.c: In function 'gup_hugepte':
>> mm/gup.c:2555:17: error: label 'pte_unmap' used but not defined
    2555 |                 goto pte_unmap;
         |                 ^~~~


vim +/pte_unmap +2555 mm/gup.c

  2518	
  2519	static int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
  2520			       unsigned long end, unsigned int flags,
  2521			       struct page **pages, int *nr)
  2522	{
  2523		unsigned long pte_end;
  2524		struct page *head, *page;
  2525		pte_t pte;
  2526		int refs;
  2527	
  2528		pte_end = (addr + sz) & ~(sz-1);
  2529		if (pte_end < end)
  2530			end = pte_end;
  2531	
  2532		pte = huge_ptep_get(ptep);
  2533	
  2534		if (!pte_access_permitted(pte, flags & FOLL_WRITE))
  2535			return 0;
  2536	
  2537		/* hugepages are never "special" */
  2538		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
  2539	
  2540		head = pte_page(pte);
  2541		page = head + ((addr & (sz-1)) >> PAGE_SHIFT);
  2542		refs = record_subpages(page, addr, end, pages + *nr);
  2543	
  2544		head = try_grab_compound_head(head, refs, flags);
  2545		if (!head)
  2546			return 0;
  2547	
  2548		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
  2549			put_compound_head(head, refs, flags);
  2550			return 0;
  2551		}
  2552	
  2553		if (!pte_write(pte) && gup_must_unshare(flags, head)) {
  2554			put_compound_head(head, refs, flags);
> 2555			goto pte_unmap;
  2556		}
  2557	
  2558		*nr += refs;
  2559		SetPageReferenced(head);
  2560		return 1;
  2561	}
  2562	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
