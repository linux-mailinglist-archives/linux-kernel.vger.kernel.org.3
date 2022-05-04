Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97582519563
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:14:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343606AbiEDCRZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245241AbiEDCRV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:17:21 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFF229CA8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 19:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651630427; x=1683166427;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3f3HG0h9nCWqmJcrLWcYRp7432pBxrDiYpucXtfGHoc=;
  b=EGc9kAbBcRSi5RnPEIZ1diC2OAC0VA3Ty1pn29J1/w1vPXmaerlfz+Kn
   IKVN+/AQJG+iJv/E7HRE0TdRtm6AWCS+yfDujFH+U4xkF9ahwnQ9j5MrK
   QImdceM7uf/Zf4zM2NrIDDnmBWzYC4l4ioyMrGJmZESCHBDrSv0U1dV4Q
   8abjHP47HgIxMiD1T7UgPBHYOdxE5oV1Z3BYL4gRAH8ZRZP/C7iFpqVbl
   Veh9B/suVvZAVxeRz4lyyXSCs5YZCsuUKkWgz0WJrYgoMuwE2CUyPxsfM
   Ikw3yBni04YWqGXwMOyEDl2wExb7rLFgG2RYd/Hu2BWrwatkz2dr4s5YM
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10336"; a="255104966"
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="255104966"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 May 2022 19:13:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,196,1647327600"; 
   d="scan'208";a="599334231"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 May 2022 19:13:34 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nm4WD-000AyR-RI;
        Wed, 04 May 2022 02:13:33 +0000
Date:   Wed, 4 May 2022 10:13:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Michal Hocko <mhocko@suse.com>,
        John Dias <joaodias@google.com>,
        Tim Murray <timmurray@google.com>,
        Minchan Kim <minchan@kernel.org>
Subject: Re: [PATCH] mm: don't be stuck to rmap lock on reclaim path
Message-ID: <202205041057.a78ABZ95-lkp@intel.com>
References: <20220503170341.1413961-1-minchan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220503170341.1413961-1-minchan@kernel.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Minchan,

I love your patch! Perhaps something to improve:

[auto build test WARNING on hnaz-mm/master]

url:    https://github.com/intel-lab-lkp/linux/commits/Minchan-Kim/mm-don-t-be-stuck-to-rmap-lock-on-reclaim-path/20220504-010625
base:   https://github.com/hnaz/linux-mm master
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220504/202205041057.a78ABZ95-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/0e190ce022ef259d63eb2cf50110b292ba17c79c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Minchan-Kim/mm-don-t-be-stuck-to-rmap-lock-on-reclaim-path/20220504-010625
        git checkout 0e190ce022ef259d63eb2cf50110b292ba17c79c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/page_idle.c: In function 'page_idle_clear_pte_refs':
>> mm/page_idle.c:106:26: warning: passing argument 2 of 'rmap_walk' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     106 |         rmap_walk(folio, &rwc);
         |                          ^~~~
   In file included from mm/page_idle.c:11:
   include/linux/rmap.h:403:63: note: expected 'struct rmap_walk_control *' but argument is of type 'const struct rmap_walk_control *'
     403 | void rmap_walk(struct folio *folio, struct rmap_walk_control *rwc);
         |                                     ~~~~~~~~~~~~~~~~~~~~~~~~~~^~~


vim +106 mm/page_idle.c

33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   85  
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   86  static void page_idle_clear_pte_refs(struct page *page)
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   87  {
4aed23a2f8aaaa Matthew Wilcox (Oracle  2022-01-29   88) 	struct folio *folio = page_folio(page);
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   89  	/*
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   90  	 * Since rwc.arg is unused, rwc is effectively immutable, so we
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   91  	 * can make it static const to save some cycles and stack.
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   92  	 */
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   93  	static const struct rmap_walk_control rwc = {
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   94  		.rmap_one = page_idle_clear_pte_refs_one,
2f031c6f042cb8 Matthew Wilcox (Oracle  2022-01-29   95) 		.anon_lock = folio_lock_anon_vma_read,
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   96  	};
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   97  	bool need_lock;
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09   98  
4aed23a2f8aaaa Matthew Wilcox (Oracle  2022-01-29   99) 	if (!folio_mapped(folio) || !folio_raw_mapping(folio))
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09  100  		return;
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09  101  
4aed23a2f8aaaa Matthew Wilcox (Oracle  2022-01-29  102) 	need_lock = !folio_test_anon(folio) || folio_test_ksm(folio);
4aed23a2f8aaaa Matthew Wilcox (Oracle  2022-01-29  103) 	if (need_lock && !folio_trylock(folio))
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09  104  		return;
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09  105  
84fbbe21894bb9 Matthew Wilcox (Oracle  2022-01-29 @106) 	rmap_walk(folio, &rwc);
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09  107  
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09  108  	if (need_lock)
4aed23a2f8aaaa Matthew Wilcox (Oracle  2022-01-29  109) 		folio_unlock(folio);
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09  110  }
33c3fc71c8cfa3 Vladimir Davydov        2015-09-09  111  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
