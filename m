Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5F5952DF0B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:16:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245097AbiESVQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245085AbiESVPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:15:52 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D374910F7
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652994950; x=1684530950;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=nX+KNtxV6LhwhQ+aMKM6gPlNwu/uEushJibQXpPwDkg=;
  b=JoE4SOhJykWOBZjaGRY3U7n0RWPQg7EJ1nfeW5jR8hDMZ2UrPIEj77SD
   HPB3oyj2byMQ6Prn+q8MP+T+2Mzjs3B9URw3KjT9KPeGd8jThvKg1kPkz
   QlOaUq3wwEAhbn+7MQ+gwicSJdm0jJDiSbMpZDP7Pj3CbDNQqdO7prtQH
   EoUEafeHlisZXjv6ouO/xMeRbjsYLYdt2uI2p3v7jXIYGVHwAp8dzNYBw
   xbQNb9zmigK0x1U65WdtVxz76Yd28q+Y/1T9Ax47iFxX7CRq+QDzmMfJM
   /v4ZF/FX4HeacH1vuMD5cFtpvG0g7DJurpyTjZctgn0qLsN16GaH6EfXB
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="269970872"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="269970872"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 14:15:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="818197143"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 19 May 2022 14:15:36 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrnUd-0003xD-P2;
        Thu, 19 May 2022 21:15:35 +0000
Date:   Fri, 20 May 2022 05:14:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mel Gorman <mgorman@suse.de>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: mm/page_alloc.c:984:9: warning: iteration 119304648 invokes
 undefined behavior
Message-ID: <202205200521.65W2rpLt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b015dcd62b86d298829990f8261d5d154b8d7af5
commit: 44042b4498728f4376e84bae1ac8016d146d850b mm/page_alloc: allow high-order pages to be stored on the per-cpu lists
date:   11 months ago
config: powerpc-randconfig-r002-20220519 (https://download.01.org/0day-ci/archive/20220520/202205200521.65W2rpLt-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=44042b4498728f4376e84bae1ac8016d146d850b
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 44042b4498728f4376e84bae1ac8016d146d850b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   mm/page_alloc.c:3823:15: warning: no previous prototype for 'should_fail_alloc_page' [-Wmissing-prototypes]
    3823 | noinline bool should_fail_alloc_page(gfp_t gfp_mask, unsigned int order)
         |               ^~~~~~~~~~~~~~~~~~~~~~
   {standard input}: Assembler messages:
   {standard input}:6471: Error: unrecognized opcode: `wrteei'
   {standard input}:6700: Error: unrecognized opcode: `wrtee'
   mm/page_alloc.c: In function 'rmqueue.isra':
>> mm/page_alloc.c:984:9: warning: iteration 119304648 invokes undefined behavior [-Waggressive-loop-optimizations]
     984 |         list_add(&page->lru, &area->free_list[migratetype]);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/page_alloc.c:2305:21: note: within this loop
    2305 |         while (high > low) {
         |                ~~~~~^~~~~
   {standard input}:9878: Error: unrecognized opcode: `wrteei'
   {standard input}:10902: Error: unrecognized opcode: `wrtee'
   {standard input}:11103: Error: unrecognized opcode: `wrteei'
   {standard input}:11321: Error: unrecognized opcode: `wrtee'
   {standard input}:12224: Error: unrecognized opcode: `wrteei'
   {standard input}:12816: Error: unrecognized opcode: `wrtee'
   {standard input}:12822: Error: unrecognized opcode: `wrteei'
   {standard input}:12831: Error: unrecognized opcode: `wrtee'
   {standard input}:14310: Error: unrecognized opcode: `wrteei'
   {standard input}:14402: Error: unrecognized opcode: `wrteei'
   {standard input}:14431: Error: unrecognized opcode: `wrteei'
   {standard input}:14476: Error: unrecognized opcode: `wrtee'
   {standard input}:14484: Error: unrecognized opcode: `wrtee'
   {standard input}:14503: Error: unrecognized opcode: `wrtee'
   {standard input}:17180: Error: unrecognized opcode: `wrteei'
   {standard input}:17816: Error: unrecognized opcode: `wrtee'
   {standard input}:17828: Error: unrecognized opcode: `wrtee'


vim +984 mm/page_alloc.c

5e1f0f098b4649 Mel Gorman      2019-03-05  977  
6ab0136310961e Alexander Duyck 2020-04-06  978  /* Used for pages not on another list */
6ab0136310961e Alexander Duyck 2020-04-06  979  static inline void add_to_free_list(struct page *page, struct zone *zone,
6ab0136310961e Alexander Duyck 2020-04-06  980  				    unsigned int order, int migratetype)
6ab0136310961e Alexander Duyck 2020-04-06  981  {
6ab0136310961e Alexander Duyck 2020-04-06  982  	struct free_area *area = &zone->free_area[order];
6ab0136310961e Alexander Duyck 2020-04-06  983  
6ab0136310961e Alexander Duyck 2020-04-06 @984  	list_add(&page->lru, &area->free_list[migratetype]);
6ab0136310961e Alexander Duyck 2020-04-06  985  	area->nr_free++;
6ab0136310961e Alexander Duyck 2020-04-06  986  }
6ab0136310961e Alexander Duyck 2020-04-06  987  

:::::: The code at line 984 was first introduced by commit
:::::: 6ab0136310961ebf4b5ecb565f0bf52c233dc093 mm: use zone and order instead of free area in free_list manipulators

:::::: TO: Alexander Duyck <alexander.h.duyck@linux.intel.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
