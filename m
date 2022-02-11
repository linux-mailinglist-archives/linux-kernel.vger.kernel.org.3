Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 383134B2C4D
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 19:00:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352420AbiBKSAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 13:00:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243899AbiBKSAF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 13:00:05 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB99D45
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 10:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644602404; x=1676138404;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xtNkX6dwQ8Lqcqr+qo6pjnN8xX+gfxnoNJA5tO5md5g=;
  b=fAEFRPotLUM7gmge5tPb+blk3RFqbGUP+AEvUkzPxeYQoXasw3fPb7oA
   x2sV5biyFyZ0HzM50n6qQPlVesAo0ElDT8suToujod80uQMc3mCTOyI7r
   iiB0P6edILt3WmaozwdaYHIZz1Df1CJWKsHPmIS96/RTfeH1sENeBz1uO
   R0sxx2AHzQegt6MY6PAyJpdSnkaKogNZjg62NoVaHcjLnIgmbXJJroLLD
   z+8Oae3NL51TaYRZEx8WFy/PpZPXHlOHM90jhD2VRo/r/rPkkXEMbkK+j
   1lk6JjxVhk4d1t8toIlap2XZcYIBzArJBTj+o/2KgYe/Ys1cZ9dbng5dj
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10255"; a="233331005"
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="233331005"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Feb 2022 10:00:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,361,1635231600"; 
   d="scan'208";a="500850495"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Feb 2022 10:00:02 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nIaDB-0004w0-Cn; Fri, 11 Feb 2022 18:00:01 +0000
Date:   Sat, 12 Feb 2022 01:59:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: [hnaz-mm:master 185/280] mm/swap.c:637:9: error: implicit
 declaration of function 'mlock_page_drain'
Message-ID: <202202120048.jS44WAmd-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/hnaz/linux-mm master
head:   f3077ea7c68baf736944f1ebf7d8bae1668a9e51
commit: 4b3b8bd6c8287d44703aaaeeba94a500821703c9 [185/280] mm/munlock: mlock_page() munlock_page() batch by pagevec
config: h8300-allnoconfig (https://download.01.org/0day-ci/archive/20220212/202202120048.jS44WAmd-lkp@intel.com/config)
compiler: h8300-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/hnaz/linux-mm/commit/4b3b8bd6c8287d44703aaaeeba94a500821703c9
        git remote add hnaz-mm https://github.com/hnaz/linux-mm
        git fetch --no-tags hnaz-mm master
        git checkout 4b3b8bd6c8287d44703aaaeeba94a500821703c9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=h8300 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   mm/swap.c: In function 'lru_add_drain_cpu':
>> mm/swap.c:637:9: error: implicit declaration of function 'mlock_page_drain' [-Werror=implicit-function-declaration]
     637 |         mlock_page_drain(cpu);
         |         ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/mlock_page_drain +637 mm/swap.c

   600	
   601	/*
   602	 * Drain pages out of the cpu's pagevecs.
   603	 * Either "cpu" is the current CPU, and preemption has already been
   604	 * disabled; or "cpu" is being hot-unplugged, and is already dead.
   605	 */
   606	void lru_add_drain_cpu(int cpu)
   607	{
   608		struct pagevec *pvec = &per_cpu(lru_pvecs.lru_add, cpu);
   609	
   610		if (pagevec_count(pvec))
   611			__pagevec_lru_add(pvec);
   612	
   613		pvec = &per_cpu(lru_rotate.pvec, cpu);
   614		/* Disabling interrupts below acts as a compiler barrier. */
   615		if (data_race(pagevec_count(pvec))) {
   616			unsigned long flags;
   617	
   618			/* No harm done if a racing interrupt already did this */
   619			local_lock_irqsave(&lru_rotate.lock, flags);
   620			pagevec_lru_move_fn(pvec, pagevec_move_tail_fn);
   621			local_unlock_irqrestore(&lru_rotate.lock, flags);
   622		}
   623	
   624		pvec = &per_cpu(lru_pvecs.lru_deactivate_file, cpu);
   625		if (pagevec_count(pvec))
   626			pagevec_lru_move_fn(pvec, lru_deactivate_file_fn);
   627	
   628		pvec = &per_cpu(lru_pvecs.lru_deactivate, cpu);
   629		if (pagevec_count(pvec))
   630			pagevec_lru_move_fn(pvec, lru_deactivate_fn);
   631	
   632		pvec = &per_cpu(lru_pvecs.lru_lazyfree, cpu);
   633		if (pagevec_count(pvec))
   634			pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
   635	
   636		activate_page_drain(cpu);
 > 637		mlock_page_drain(cpu);
   638	}
   639	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
