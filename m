Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5F6A47B920
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Dec 2021 05:08:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhLUEGr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 23:06:47 -0500
Received: from mga02.intel.com ([134.134.136.20]:19335 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231712AbhLUEGq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 23:06:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640059606; x=1671595606;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=r71zaEIuAEQeMFE7Y1W6sqpqmcXX2WGJbCj0egKvCzA=;
  b=Ybuq6uVKrPqBvmy+hMGMUij5++0340jYp7fyXBC3l5QELIZJJfSRUlnC
   hVT+HQyFgqpd7e3eFYRgFiHGHNl3aHel/CIOirxlMkXlG5txvdNtEGCLz
   ftZ/t1JsfwDwnLiBtza0Al318EAJnle2AWhku79/CJYZ24ZTj6i2rfZcz
   gr7tnzFuTBTmYOWyo4gGTDR3Elscy8YsPIV8qy9Ihcyp94LySh4pP9ZP/
   jEdUR++tcfTDmG+WIjO0QGRprhLyzi2CNhjOjE50zJelpxI1KN3YJBmwA
   /CLjA889qPOGDS7r20ul+DrtciqMVSB68vuXtaMeN//PLlE4SRgggDwqI
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10204"; a="227613561"
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="227613561"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 20:06:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,222,1635231600"; 
   d="scan'208";a="606935736"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 20 Dec 2021 20:06:44 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzWQF-0008fM-Al; Tue, 21 Dec 2021 04:06:43 +0000
Date:   Tue, 21 Dec 2021 12:06:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>
Subject: [davidhildenbrand:unshare_new 3/4] mm/gup.c:39:6: error: conflicting
 types for 'gup_must_unshare'
Message-ID: <202112211124.akx29yxL-lkp@intel.com>
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
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211221/202112211124.akx29yxL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/davidhildenbrand/linux/commit/d3eb6d68346c3d9e89ae68461e0eabb5bc7def17
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand unshare_new
        git checkout d3eb6d68346c3d9e89ae68461e0eabb5bc7def17
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/gup.c:7:
   include/linux/mm.h: In function 'page_needs_cow_for_dma':
   include/linux/mm.h:1384:24: error: implicit declaration of function 'PageAnonUnshared' [-Werror=implicit-function-declaration]
    1384 |  if (PageAnon(page) && PageAnonUnshared(page)) {
         |                        ^~~~~~~~~~~~~~~~
   include/linux/mm.h:1386:4: error: implicit declaration of function 'ClearPageAnonUnshared' [-Werror=implicit-function-declaration]
    1386 |    ClearPageAnonUnshared(page);
         |    ^~~~~~~~~~~~~~~~~~~~~
   mm/gup.c: At top level:
>> mm/gup.c:39:6: error: conflicting types for 'gup_must_unshare'
      39 | bool gup_must_unshare(unsigned int flags, struct page *page)
         |      ^~~~~~~~~~~~~~~~
   In file included from mm/gup.c:7:
   include/linux/mm.h:3086:13: note: previous declaration of 'gup_must_unshare' was here
    3086 | extern bool gup_must_unshare(unsigned int flags, struct page *page,
         |             ^~~~~~~~~~~~~~~~
   mm/gup.c: In function 'follow_page_pte':
   mm/gup.c:595:7: error: implicit declaration of function 'mark_anon_page_exclusive' [-Werror=implicit-function-declaration]
     595 |   if (mark_anon_page_exclusive(page, pte_write(pte))) {
         |       ^~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/gup_must_unshare +39 mm/gup.c

     6	
   > 7	#include <linux/mm.h>
     8	#include <linux/memremap.h>
     9	#include <linux/pagemap.h>
    10	#include <linux/rmap.h>
    11	#include <linux/swap.h>
    12	#include <linux/swapops.h>
    13	#include <linux/secretmem.h>
    14	
    15	#include <linux/sched/signal.h>
    16	#include <linux/rwsem.h>
    17	#include <linux/hugetlb.h>
    18	#include <linux/migrate.h>
    19	#include <linux/mm_inline.h>
    20	#include <linux/sched/mm.h>
    21	
    22	#include <asm/mmu_context.h>
    23	#include <asm/tlbflush.h>
    24	
    25	#include "internal.h"
    26	
    27	struct follow_page_context {
    28		struct dev_pagemap *pgmap;
    29		unsigned int page_mask;
    30	};
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
