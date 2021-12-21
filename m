Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 627B747C7D1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 20:54:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241935AbhLUTyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Dec 2021 14:54:18 -0500
Received: from mga11.intel.com ([192.55.52.93]:3774 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241930AbhLUTyR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Dec 2021 14:54:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640116457; x=1671652457;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=KqyXKHG7JsPgxEKwB6VpV/smJwmPoEUQbrSxZ2bCCV0=;
  b=McwmaTZ5ytP6YQPtrCnNBYpu+c3QqjgV2Kbw97+KPn+lQw4vFWOPD/MO
   RpQyHTe60D7kDE8hDAgj1g7ljEaByrc9OA5DagzK7JGQv17Fymv/Hua61
   18B7rDji9Fa/XMZQy5rCarnuWLc7nurOaqc4p0qPQ6CqQ2wB4QpuxQ8oj
   XVY7sctN6k2RPJtpdw75MQ/Wr78c6OQDJcLuzVap671hrIoczxGjPQ97K
   Z9jjpf+FOr8KzFP5tpg9INZAyhEHa4o3jqFDI4Fv1Pk+9TTK76vvIseET
   c6Doaf6aaMjrnxYfdne3QdJH1Y8WeDov0i5dj1ebyKVffTPVQYUBPmPul
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10205"; a="238017031"
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="238017031"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Dec 2021 11:54:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,224,1635231600"; 
   d="scan'208";a="548317016"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 21 Dec 2021 11:54:14 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzlDB-0009U5-NV; Tue, 21 Dec 2021 19:54:13 +0000
Date:   Wed, 22 Dec 2021 03:54:02 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: [davidhildenbrand:unshare_new 3/4] mm/gup.c:39:6: error: conflicting
 types for 'gup_must_unshare'
Message-ID: <202112220333.iWZqSzKw-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux unshare_new
head:   0b0d58f51fe2675e4dcfb11263ad4cbec053711f
commit: d3eb6d68346c3d9e89ae68461e0eabb5bc7def17 [3/4] mm: gup: trigger unsharing via FAULT_FLAG_UNSHARE when required (!hugetlb)
config: hexagon-randconfig-r045-20211220 (https://download.01.org/0day-ci/archive/20211222/202112220333.iWZqSzKw-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 555eacf75f21cd1dfc6363d73ad187b730349543)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/davidhildenbrand/linux/commit/d3eb6d68346c3d9e89ae68461e0eabb5bc7def17
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand unshare_new
        git checkout d3eb6d68346c3d9e89ae68461e0eabb5bc7def17
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   In file included from mm/gup.c:7:
   include/linux/mm.h:1384:24: error: implicit declaration of function 'PageAnonUnshared' [-Werror,-Wimplicit-function-declaration]
           if (PageAnon(page) && PageAnonUnshared(page)) {
                                 ^
   include/linux/mm.h:1386:4: error: implicit declaration of function 'ClearPageAnonUnshared' [-Werror,-Wimplicit-function-declaration]
                           ClearPageAnonUnshared(page);
                           ^
   include/linux/mm.h:1386:4: note: did you mean 'PageAnonUnshared'?
   include/linux/mm.h:1384:24: note: 'PageAnonUnshared' declared here
           if (PageAnon(page) && PageAnonUnshared(page)) {
                                 ^
>> mm/gup.c:39:6: error: conflicting types for 'gup_must_unshare'
   bool gup_must_unshare(unsigned int flags, struct page *page)
        ^
   include/linux/mm.h:3086:13: note: previous declaration is here
   extern bool gup_must_unshare(unsigned int flags, struct page *page,
               ^
>> mm/gup.c:593:34: error: too few arguments to function call, expected 3, have 2
           if (gup_must_unshare(flags, page)) {
               ~~~~~~~~~~~~~~~~            ^
   include/linux/mm.h:3086:13: note: 'gup_must_unshare' declared here
   extern bool gup_must_unshare(unsigned int flags, struct page *page,
               ^
>> mm/gup.c:595:7: error: implicit declaration of function 'mark_anon_page_exclusive' [-Werror,-Wimplicit-function-declaration]
                   if (mark_anon_page_exclusive(page, pte_write(pte))) {
                       ^
   5 errors generated.
--
   In file included from mm/memory.c:43:
   include/linux/mm.h:1384:24: error: implicit declaration of function 'PageAnonUnshared' [-Werror,-Wimplicit-function-declaration]
           if (PageAnon(page) && PageAnonUnshared(page)) {
                                 ^
   include/linux/mm.h:1386:4: error: implicit declaration of function 'ClearPageAnonUnshared' [-Werror,-Wimplicit-function-declaration]
                           ClearPageAnonUnshared(page);
                           ^
   include/linux/mm.h:1386:4: note: did you mean 'PageAnonUnshared'?
   include/linux/mm.h:1384:24: note: 'PageAnonUnshared' declared here
           if (PageAnon(page) && PageAnonUnshared(page)) {
                                 ^
   mm/memory.c:3018:3: error: implicit declaration of function '__SetPageAnonUnshared' [-Werror,-Wimplicit-function-declaration]
                   __SetPageAnonUnshared(new_page);
                   ^
   mm/memory.c:3191:24: error: implicit declaration of function 'PageAnonUnshared' [-Werror,-Wimplicit-function-declaration]
                   if (PageKsm(page) || PageAnonUnshared(page))
                                        ^
   mm/memory.c:3207:4: error: implicit declaration of function 'SetPageAnonUnshared' [-Werror,-Wimplicit-function-declaration]
                           SetPageAnonUnshared(page);
                           ^
   mm/memory.c:3207:4: note: did you mean 'PageAnonUnshared'?
   include/linux/mm.h:1384:24: note: 'PageAnonUnshared' declared here
           if (PageAnon(page) && PageAnonUnshared(page)) {
                                 ^
   mm/memory.c:3215:10: error: implicit declaration of function 'wp_page_unshare' [-Werror,-Wimplicit-function-declaration]
                   return wp_page_unshare(vmf);
                          ^
   mm/memory.c:3215:10: note: did you mean 'do_wp_page_unshare'?
   mm/memory.c:3177:19: note: 'do_wp_page_unshare' declared here
   static vm_fault_t do_wp_page_unshare(struct vm_fault *vmf)
                     ^
>> mm/memory.c:3247:3: error: implicit declaration of function 'SetPageExclusive' [-Werror,-Wimplicit-function-declaration]
                   SetPageExclusive(page);
                   ^
   mm/memory.c:3247:3: note: did you mean 'SetPageAnonExclusive'?
   include/linux/page-flags.h:952:29: note: 'SetPageAnonExclusive' declared here
   static __always_inline void SetPageAnonExclusive(struct page *page)
                               ^
   mm/memory.c:3255:3: error: implicit declaration of function 'SetPageExclusive' [-Werror,-Wimplicit-function-declaration]
                   SetPageExclusive(page);
                   ^
>> mm/memory.c:3240:5: warning: no previous prototype for function 'mark_anon_page_exclusive' [-Wmissing-prototypes]
   int mark_anon_page_exclusive(struct page *page, bool mapped_writable)
       ^
   mm/memory.c:3240:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int mark_anon_page_exclusive(struct page *page, bool mapped_writable)
   ^
   static 
   mm/memory.c:3376:29: error: use of undeclared identifier 'page'
                   return do_wp_page_unshare(page);
                                             ^
   mm/memory.c:3415:7: error: implicit declaration of function 'PageAnonUnshared' [-Werror,-Wimplicit-function-declaration]
                   if (PageAnonUnshared(page))
                       ^
   mm/memory.c:4591:8: error: implicit declaration of function 'PageAnonUnshared' [-Werror,-Wimplicit-function-declaration]
                           if (PageAnonUnshared(page))
                               ^
   mm/memory.c:4591:25: error: use of undeclared identifier 'page'
                           if (PageAnonUnshared(page))
                                                ^
   mm/memory.c:4593:19: error: use of undeclared identifier 'page'
                           if (page_count(page) == 1) {
                                          ^
   mm/memory.c:4594:5: error: implicit declaration of function 'SetPageAnonUnshared' [-Werror,-Wimplicit-function-declaration]
                                   SetPageAnonUnshared(page);
                                   ^
   mm/memory.c:4594:25: error: use of undeclared identifier 'page'
                                   SetPageAnonUnshared(page);
                                                       ^
   1 warning and 15 errors generated.


vim +/gup_must_unshare +39 mm/gup.c

    31	
    32	/*
    33	 * Indicates for which pages we have to trigger unsharing first to make
    34	 * anonymous pages exclusive to the MM. Once exlusive, only fork() can
    35	 * turn the pages !exclusive -- and only if there are no additional references.
    36	 *
    37	 * This function is safe to be called in IRQ context.
    38	 */
  > 39	bool gup_must_unshare(unsigned int flags, struct page *page)
    40	{
    41		if (flags & FOLL_NOUNSHARE)
    42			return false;
    43		else if (!(flags & FOLL_UNSHARE)) {
    44			/*
    45			 * As a default, unshare only for FOLL_PIN. The corner cases
    46			 * that cannot use FOLL_PIN right now and have to use FOLL_GET
    47			 * (i.e., O_DIRECT), although they are reading/writing page
    48			 * content should manually set FOLL_UNSHARE with FOLL_GET.
    49			 */
    50			if (!(flags & FOLL_PIN))
    51				return false;
    52		}
    53		/*
    54		 * All of the following properties should be stable also during
    55		 * gup-fast-only, whereby we hold a reference to the compound page.
    56		 * (similarly to the page_is_secretmem() check) and require a proper
    57		 * sync on unmap from the page table to avoid use-after-free.
    58		 */
    59		if (!PageAnon(page))
    60			return false;
    61		if (PageKsm(page))
    62			return false;
    63		if (PageHuge(page))
    64			/* TODO: handle hugetlb as well. */
    65			return false;
    66		/*
    67		 * Without the mmap_lock, this can change during fork(). gup-fast-only
    68		 * is handled properly via the mm->write_protect_seq and undos the
    69		 * pinning in case we detect that fork() might have changed this.
    70		 */
    71		return !PageAnonExclusive(page);
    72	}
    73	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
