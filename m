Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6537058BA38
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234029AbiHGI3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232584AbiHGI3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:29:32 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0104BCE3D
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 01:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659860969; x=1691396969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Q6cW6BaUu06CbiBWisBOsh1UYBjZw11C5oqSw22Bzsc=;
  b=l2Km5mD+d2vGdZLzHlwAbfTAhMH5XwgHzDOlRQOyGdLWtS387/KfK0B+
   6M17gP+jVLxmIXemKflpyA++aDDpBP2AG6BT2Pl4zF86Wt1wpBsD+J1Hv
   FjQPGjkBlWv9X96bTBt/hhZdnjpqFfSxiBr82PN3aRy2VBZmylBCV6DAM
   XFW9UvOzMrUHmS+geQex/mdufTXBWIYHThxV/quY8GsgAE3n1/cCA3L2K
   uiPWYkX/uxisNox6EIIr9k9EzdArYUgRZWeiD3DrnLvXt4PHS02sj9qxv
   Sj9BLoCpvu4aCvIGj/jL//Di+wrshktDD9PYDpp2KcrDlu5oB3VlNWud8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="316323563"
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="316323563"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2022 01:29:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,219,1654585200"; 
   d="scan'208";a="600770283"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 07 Aug 2022 01:29:26 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKbf4-000L9h-0R;
        Sun, 07 Aug 2022 08:29:26 +0000
Date:   Sun, 7 Aug 2022 16:29:04 +0800
From:   kernel test robot <lkp@intel.com>
To:     Hao Lee <haolee.swjtu@gmail.com>, akpm@linux-foundation.org
Cc:     kbuild-all@lists.01.org, david@redhat.com,
        yang.shi@linux.alibaba.com, hannes@cmpxchg.org,
        haolee.swjtu@gmail.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH] mm: add DEVICE_ZONE to FOR_ALL_ZONES
Message-ID: <202208071620.pju0F2pW-lkp@intel.com>
References: <20220804074730.GA3269@haolee.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220804074730.GA3269@haolee.io>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hao,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on akpm-mm/mm-everything]

url:    https://github.com/intel-lab-lkp/linux/commits/Hao-Lee/mm-add-DEVICE_ZONE-to-FOR_ALL_ZONES/20220804-154805
base:   https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git mm-everything
config: ia64-tiger_defconfig (https://download.01.org/0day-ci/archive/20220807/202208071620.pju0F2pW-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/dba18359aee97f43008e19ffa78421e652b1b102
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Hao-Lee/mm-add-DEVICE_ZONE-to-FOR_ALL_ZONES/20220804-154805
        git checkout dba18359aee97f43008e19ffa78421e652b1b102
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=ia64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/vmstat.h:8,
                    from include/linux/mm.h:1668,
                    from include/linux/dax.h:6,
                    from mm/filemap.c:15:
   include/linux/vm_event_item.h:29:27: error: expected identifier before '(' token
      29 | #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
         |                           ^
   include/linux/vm_event_item.h:33:17: note: in expansion of macro 'FOR_ALL_ZONES'
      33 |                 FOR_ALL_ZONES(PGALLOC),
         |                 ^~~~~~~~~~~~~
   include/linux/vmstat.h:55:29: error: 'NR_VM_EVENT_ITEMS' undeclared here (not in a function); did you mean 'NR_VM_NUMA_EVENT_ITEMS'?
      55 |         unsigned long event[NR_VM_EVENT_ITEMS];
         |                             ^~~~~~~~~~~~~~~~~
         |                             NR_VM_NUMA_EVENT_ITEMS
   include/linux/vmstat.h: In function '__count_vm_event':
   include/linux/vmstat.h:64:56: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      64 | static inline void __count_vm_event(enum vm_event_item item)
         |                                     ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_event':
   include/linux/vmstat.h:69:54: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      69 | static inline void count_vm_event(enum vm_event_item item)
         |                                   ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function '__count_vm_events':
   include/linux/vmstat.h:74:57: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      74 | static inline void __count_vm_events(enum vm_event_item item, long delta)
         |                                      ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_events':
   include/linux/vmstat.h:79:55: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      79 | static inline void count_vm_events(enum vm_event_item item, long delta)
         |                                    ~~~~~~~~~~~~~~~~~~~^~~~
   mm/filemap.c: In function 'filemap_fault':
>> mm/filemap.c:3139:32: error: 'PGMAJFAULT' undeclared (first use in this function)
    3139 |                 count_vm_event(PGMAJFAULT);
         |                                ^~~~~~~~~~
   mm/filemap.c:3139:32: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from include/linux/vmstat.h:8,
                    from include/linux/mm.h:1668,
                    from include/linux/oom.h:11,
                    from mm/oom_kill.c:21:
   include/linux/vm_event_item.h:29:27: error: expected identifier before '(' token
      29 | #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
         |                           ^
   include/linux/vm_event_item.h:33:17: note: in expansion of macro 'FOR_ALL_ZONES'
      33 |                 FOR_ALL_ZONES(PGALLOC),
         |                 ^~~~~~~~~~~~~
   include/linux/vmstat.h:55:29: error: 'NR_VM_EVENT_ITEMS' undeclared here (not in a function); did you mean 'NR_VM_NUMA_EVENT_ITEMS'?
      55 |         unsigned long event[NR_VM_EVENT_ITEMS];
         |                             ^~~~~~~~~~~~~~~~~
         |                             NR_VM_NUMA_EVENT_ITEMS
   include/linux/vmstat.h: In function '__count_vm_event':
   include/linux/vmstat.h:64:56: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      64 | static inline void __count_vm_event(enum vm_event_item item)
         |                                     ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_event':
   include/linux/vmstat.h:69:54: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      69 | static inline void count_vm_event(enum vm_event_item item)
         |                                   ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function '__count_vm_events':
   include/linux/vmstat.h:74:57: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      74 | static inline void __count_vm_events(enum vm_event_item item, long delta)
         |                                      ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_events':
   include/linux/vmstat.h:79:55: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      79 | static inline void count_vm_events(enum vm_event_item item, long delta)
         |                                    ~~~~~~~~~~~~~~~~~~~^~~~
   mm/oom_kill.c: In function '__oom_kill_process':
>> mm/oom_kill.c:940:24: error: 'OOM_KILL' undeclared (first use in this function)
     940 |         count_vm_event(OOM_KILL);
         |                        ^~~~~~~~
   mm/oom_kill.c:940:24: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from include/linux/vmstat.h:8,
                    from include/linux/mm.h:1668,
                    from mm/swap.c:17:
   include/linux/vm_event_item.h:29:27: error: expected identifier before '(' token
      29 | #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
         |                           ^
   include/linux/vm_event_item.h:33:17: note: in expansion of macro 'FOR_ALL_ZONES'
      33 |                 FOR_ALL_ZONES(PGALLOC),
         |                 ^~~~~~~~~~~~~
   include/linux/vmstat.h:55:29: error: 'NR_VM_EVENT_ITEMS' undeclared here (not in a function); did you mean 'NR_VM_NUMA_EVENT_ITEMS'?
      55 |         unsigned long event[NR_VM_EVENT_ITEMS];
         |                             ^~~~~~~~~~~~~~~~~
         |                             NR_VM_NUMA_EVENT_ITEMS
   include/linux/vmstat.h: In function '__count_vm_event':
   include/linux/vmstat.h:64:56: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      64 | static inline void __count_vm_event(enum vm_event_item item)
         |                                     ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_event':
   include/linux/vmstat.h:69:54: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      69 | static inline void count_vm_event(enum vm_event_item item)
         |                                   ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function '__count_vm_events':
   include/linux/vmstat.h:74:57: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      74 | static inline void __count_vm_events(enum vm_event_item item, long delta)
         |                                      ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_events':
   include/linux/vmstat.h:79:55: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      79 | static inline void count_vm_events(enum vm_event_item item, long delta)
         |                                    ~~~~~~~~~~~~~~~~~~~^~~~
   mm/swap.c: In function '__page_cache_release':
>> mm/swap.c:97:33: error: 'UNEVICTABLE_PGCLEARED' undeclared (first use in this function)
      97 |                 count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
         |                                 ^~~~~~~~~~~~~~~~~~~~~
   mm/swap.c:97:33: note: each undeclared identifier is reported only once for each function it appears in
   mm/swap.c: In function 'lru_add_fn':
>> mm/swap.c:212:43: error: 'UNEVICTABLE_PGRESCUED' undeclared (first use in this function)
     212 |                         __count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
         |                                           ^~~~~~~~~~~~~~~~~~~~~
>> mm/swap.c:225:43: error: 'UNEVICTABLE_PGCULLED' undeclared (first use in this function)
     225 |                         __count_vm_events(UNEVICTABLE_PGCULLED, nr_pages);
         |                                           ^~~~~~~~~~~~~~~~~~~~
   mm/swap.c: In function 'lru_move_tail_fn':
>> mm/swap.c:272:35: error: 'PGROTATED' undeclared (first use in this function)
     272 |                 __count_vm_events(PGROTATED, folio_nr_pages(folio));
         |                                   ^~~~~~~~~
   mm/swap.c: In function 'folio_activate_fn':
>> mm/swap.c:354:35: error: 'PGACTIVATE' undeclared (first use in this function); did you mean 'SWP_ACTIVATED'?
     354 |                 __count_vm_events(PGACTIVATE, nr_pages);
         |                                   ^~~~~~~~~~
         |                                   SWP_ACTIVATED
   mm/swap.c: In function 'lru_deactivate_file_fn':
   mm/swap.c:566:35: error: 'PGROTATED' undeclared (first use in this function)
     566 |                 __count_vm_events(PGROTATED, nr_pages);
         |                                   ^~~~~~~~~
>> mm/swap.c:570:35: error: 'PGDEACTIVATE' undeclared (first use in this function)
     570 |                 __count_vm_events(PGDEACTIVATE, nr_pages);
         |                                   ^~~~~~~~~~~~
   mm/swap.c: In function 'lru_deactivate_fn':
   mm/swap.c:586:35: error: 'PGDEACTIVATE' undeclared (first use in this function)
     586 |                 __count_vm_events(PGDEACTIVATE, nr_pages);
         |                                   ^~~~~~~~~~~~
   mm/swap.c: In function 'lru_lazyfree_fn':
>> mm/swap.c:609:35: error: 'PGLAZYFREE' undeclared (first use in this function)
     609 |                 __count_vm_events(PGLAZYFREE, nr_pages);
         |                                   ^~~~~~~~~~
   mm/swap.c: In function 'release_pages':
   mm/swap.c:1003:40: error: 'UNEVICTABLE_PGCLEARED' undeclared (first use in this function)
    1003 |                         count_vm_event(UNEVICTABLE_PGCLEARED);
         |                                        ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/vmstat.h:8,
                    from include/linux/mm.h:1668,
                    from mm/vmscan.c:15:
   include/linux/vm_event_item.h:29:27: error: expected identifier before '(' token
      29 | #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
         |                           ^
   include/linux/vm_event_item.h:33:17: note: in expansion of macro 'FOR_ALL_ZONES'
      33 |                 FOR_ALL_ZONES(PGALLOC),
         |                 ^~~~~~~~~~~~~
   include/linux/vmstat.h:55:29: error: 'NR_VM_EVENT_ITEMS' undeclared here (not in a function); did you mean 'NR_VM_NUMA_EVENT_ITEMS'?
      55 |         unsigned long event[NR_VM_EVENT_ITEMS];
         |                             ^~~~~~~~~~~~~~~~~
         |                             NR_VM_NUMA_EVENT_ITEMS
   include/linux/vmstat.h: In function '__count_vm_event':
   include/linux/vmstat.h:64:56: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      64 | static inline void __count_vm_event(enum vm_event_item item)
         |                                     ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_event':
   include/linux/vmstat.h:69:54: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      69 | static inline void count_vm_event(enum vm_event_item item)
         |                                   ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function '__count_vm_events':
   include/linux/vmstat.h:74:57: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      74 | static inline void __count_vm_events(enum vm_event_item item, long delta)
         |                                      ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_events':
   include/linux/vmstat.h:79:55: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      79 | static inline void count_vm_events(enum vm_event_item item, long delta)
         |                                    ~~~~~~~~~~~~~~~~~~~^~~~
   mm/vmscan.c: In function 'do_shrink_slab':
>> mm/vmscan.c:836:33: error: 'SLABS_SCANNED' undeclared (first use in this function)
     836 |                 count_vm_events(SLABS_SCANNED, shrinkctl->nr_scanned);
         |                                 ^~~~~~~~~~~~~
   mm/vmscan.c:836:33: note: each undeclared identifier is reported only once for each function it appears in
   mm/vmscan.c: In function 'demote_page_list':
>> mm/vmscan.c:1563:35: error: 'PGDEMOTE_KSWAPD' undeclared (first use in this function)
    1563 |                 __count_vm_events(PGDEMOTE_KSWAPD, nr_succeeded);
         |                                   ^~~~~~~~~~~~~~~
>> mm/vmscan.c:1565:35: error: 'PGDEMOTE_DIRECT' undeclared (first use in this function)
    1565 |                 __count_vm_events(PGDEMOTE_DIRECT, nr_succeeded);
         |                                   ^~~~~~~~~~~~~~~
   mm/vmscan.c: In function 'shrink_page_list':
>> mm/vmscan.c:1971:41: error: 'PGLAZYFREED' undeclared (first use in this function)
    1971 |                         count_vm_events(PGLAZYFREED, nr_pages);
         |                                         ^~~~~~~~~~~
>> mm/vmscan.c:2015:57: error: 'PGACTIVATE' undeclared (first use in this function); did you mean 'PAGE_ACTIVATE'?
    2015 |                         count_memcg_folio_events(folio, PGACTIVATE, nr_pages);
         |                                                         ^~~~~~~~~~
         |                                                         PAGE_ACTIVATE
   mm/vmscan.c: In function 'isolate_lru_pages':
>> mm/vmscan.c:2219:47: error: 'PGSCAN_SKIP_NORMAL' undeclared (first use in this function)
    2219 |                         __count_zid_vm_events(PGSCAN_SKIP, zid, nr_skipped[zid]);
         |                                               ^~~~~~~~~~~
   include/linux/vmstat.h:135:27: note: in definition of macro '__count_zid_vm_events'
     135 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ^~~~
   mm/vmscan.c: In function 'shrink_inactive_list':
>> mm/vmscan.c:2436:38: error: 'PGSCAN_KSWAPD' undeclared (first use in this function); did you mean 'PF_KSWAPD'?
    2436 |         item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
         |                                      ^~~~~~~~~~~~~
         |                                      PF_KSWAPD
>> mm/vmscan.c:2436:54: error: 'PGSCAN_DIRECT' undeclared (first use in this function); did you mean 'IOCB_DIRECT'?
    2436 |         item = current_is_kswapd() ? PGSCAN_KSWAPD : PGSCAN_DIRECT;
         |                                                      ^~~~~~~~~~~~~
         |                                                      IOCB_DIRECT
>> mm/vmscan.c:2440:27: error: 'PGSCAN_ANON' undeclared (first use in this function)
    2440 |         __count_vm_events(PGSCAN_ANON + file, nr_scanned);
         |                           ^~~~~~~~~~~
>> mm/vmscan.c:2453:38: error: 'PGSTEAL_KSWAPD' undeclared (first use in this function)
    2453 |         item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
         |                                      ^~~~~~~~~~~~~~
>> mm/vmscan.c:2453:55: error: 'PGSTEAL_DIRECT' undeclared (first use in this function)
    2453 |         item = current_is_kswapd() ? PGSTEAL_KSWAPD : PGSTEAL_DIRECT;
         |                                                       ^~~~~~~~~~~~~~
>> mm/vmscan.c:2457:27: error: 'PGSTEAL_ANON' undeclared (first use in this function)
    2457 |         __count_vm_events(PGSTEAL_ANON + file, nr_reclaimed);
         |                           ^~~~~~~~~~~~
   mm/vmscan.c: In function 'shrink_active_list':
>> mm/vmscan.c:2535:35: error: 'PGREFILL' undeclared (first use in this function)
    2535 |                 __count_vm_events(PGREFILL, nr_scanned);
         |                                   ^~~~~~~~
>> mm/vmscan.c:2594:27: error: 'PGDEACTIVATE' undeclared (first use in this function); did you mean 'PAGE_ACTIVATE'?
    2594 |         __count_vm_events(PGDEACTIVATE, nr_deactivate);
         |                           ^~~~~~~~~~~~
         |                           PAGE_ACTIVATE
   mm/vmscan.c: In function 'do_try_to_free_pages':
>> mm/vmscan.c:3592:39: error: 'ALLOCSTALL_NORMAL' undeclared (first use in this function)
    3592 |                 __count_zid_vm_events(ALLOCSTALL, sc->reclaim_idx, 1);
         |                                       ^~~~~~~~~~
   include/linux/vmstat.h:135:27: note: in definition of macro '__count_zid_vm_events'
     135 |         __count_vm_events(item##_NORMAL - ZONE_NORMAL + zid, delta)
         |                           ^~~~
   mm/vmscan.c: In function 'throttle_direct_reclaim':
>> mm/vmscan.c:3774:24: error: 'PGSCAN_DIRECT_THROTTLE' undeclared (first use in this function)
    3774 |         count_vm_event(PGSCAN_DIRECT_THROTTLE);
         |                        ^~~~~~~~~~~~~~~~~~~~~~
   mm/vmscan.c: In function 'balance_pgdat':
>> mm/vmscan.c:4164:24: error: 'PAGEOUTRUN' undeclared (first use in this function)
    4164 |         count_vm_event(PAGEOUTRUN);
         |                        ^~~~~~~~~~
   mm/vmscan.c: In function 'kswapd_try_to_sleep':
>> mm/vmscan.c:4447:40: error: 'KSWAPD_LOW_WMARK_HIT_QUICKLY' undeclared (first use in this function)
    4447 |                         count_vm_event(KSWAPD_LOW_WMARK_HIT_QUICKLY);
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/vmscan.c:4449:40: error: 'KSWAPD_HIGH_WMARK_HIT_QUICKLY' undeclared (first use in this function)
    4449 |                         count_vm_event(KSWAPD_HIGH_WMARK_HIT_QUICKLY);
         |                                        ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/vmscan.c: In function 'node_reclaim':
>> mm/vmscan.c:4847:32: error: 'PGSCAN_ZONE_RECLAIM_FAILED' undeclared (first use in this function)
    4847 |                 count_vm_event(PGSCAN_ZONE_RECLAIM_FAILED);
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~
   mm/vmscan.c: In function 'check_move_unevictable_pages':
   mm/vmscan.c:4895:35: error: 'UNEVICTABLE_PGRESCUED' undeclared (first use in this function)
    4895 |                 __count_vm_events(UNEVICTABLE_PGRESCUED, pgrescued);
         |                                   ^~~~~~~~~~~~~~~~~~~~~
   mm/vmscan.c:4896:35: error: 'UNEVICTABLE_PGSCANNED' undeclared (first use in this function)
    4896 |                 __count_vm_events(UNEVICTABLE_PGSCANNED, pgscanned);
         |                                   ^~~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/vmstat.h:8,
                    from include/linux/mm.h:1668,
                    from include/linux/security.h:33,
                    from include/linux/fs_context.h:14,
                    from include/linux/fs_parser.h:11,
                    from include/linux/ramfs.h:5,
                    from mm/shmem.c:28:
   include/linux/vm_event_item.h:29:27: error: expected identifier before '(' token
      29 | #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
         |                           ^
   include/linux/vm_event_item.h:33:17: note: in expansion of macro 'FOR_ALL_ZONES'
      33 |                 FOR_ALL_ZONES(PGALLOC),
         |                 ^~~~~~~~~~~~~
   include/linux/vmstat.h:55:29: error: 'NR_VM_EVENT_ITEMS' undeclared here (not in a function); did you mean 'NR_VM_NUMA_EVENT_ITEMS'?
      55 |         unsigned long event[NR_VM_EVENT_ITEMS];
         |                             ^~~~~~~~~~~~~~~~~
         |                             NR_VM_NUMA_EVENT_ITEMS
   include/linux/vmstat.h: In function '__count_vm_event':
   include/linux/vmstat.h:64:56: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      64 | static inline void __count_vm_event(enum vm_event_item item)
         |                                     ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_event':
   include/linux/vmstat.h:69:54: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      69 | static inline void count_vm_event(enum vm_event_item item)
         |                                   ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function '__count_vm_events':
   include/linux/vmstat.h:74:57: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      74 | static inline void __count_vm_events(enum vm_event_item item, long delta)
         |                                      ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_events':
   include/linux/vmstat.h:79:55: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      79 | static inline void count_vm_events(enum vm_event_item item, long delta)
         |                                    ~~~~~~~~~~~~~~~~~~~^~~~
   mm/shmem.c: In function 'shmem_swapin_folio':
>> mm/shmem.c:1750:40: error: 'PGMAJFAULT' undeclared (first use in this function)
    1750 |                         count_vm_event(PGMAJFAULT);
         |                                        ^~~~~~~~~~
   mm/shmem.c:1750:40: note: each undeclared identifier is reported only once for each function it appears in
--
   In file included from include/linux/memcontrol.h:14,
                    from include/linux/swap.h:9,
                    from mm/compaction.c:12:
   include/linux/vm_event_item.h:29:27: error: expected identifier before '(' token
      29 | #define FOR_ALL_ZONES(xx) (DMA_ZONE(xx) DMA32_ZONE(xx) xx##_NORMAL, \
         |                           ^
   include/linux/vm_event_item.h:33:17: note: in expansion of macro 'FOR_ALL_ZONES'
      33 |                 FOR_ALL_ZONES(PGALLOC),
         |                 ^~~~~~~~~~~~~
   In file included from include/linux/mm.h:1668,
                    from include/linux/memcontrol.h:20:
   include/linux/vmstat.h:55:29: error: 'NR_VM_EVENT_ITEMS' undeclared here (not in a function); did you mean 'NR_VM_NUMA_EVENT_ITEMS'?
      55 |         unsigned long event[NR_VM_EVENT_ITEMS];
         |                             ^~~~~~~~~~~~~~~~~
         |                             NR_VM_NUMA_EVENT_ITEMS
   include/linux/vmstat.h: In function '__count_vm_event':
   include/linux/vmstat.h:64:56: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      64 | static inline void __count_vm_event(enum vm_event_item item)
         |                                     ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_event':
   include/linux/vmstat.h:69:54: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      69 | static inline void count_vm_event(enum vm_event_item item)
         |                                   ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function '__count_vm_events':
   include/linux/vmstat.h:74:57: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      74 | static inline void __count_vm_events(enum vm_event_item item, long delta)
         |                                      ~~~~~~~~~~~~~~~~~~~^~~~
   include/linux/vmstat.h: In function 'count_vm_events':
   include/linux/vmstat.h:79:55: warning: parameter 'item' set but not used [-Wunused-but-set-parameter]
      79 | static inline void count_vm_events(enum vm_event_item item, long delta)
         |                                    ~~~~~~~~~~~~~~~~~~~^~~~
   mm/compaction.c: In function 'isolate_freepages_block':
>> mm/compaction.c:667:38: error: 'COMPACTISOLATED' undeclared (first use in this function); did you mean 'COMPACT_SKIPPED'?
     667 |                 count_compact_events(COMPACTISOLATED, total_isolated);
         |                                      ^~~~~~~~~~~~~~~
         |                                      COMPACT_SKIPPED
   mm/compaction.c:667:38: note: each undeclared identifier is reported only once for each function it appears in
   mm/compaction.c: In function 'isolate_migratepages_block':
   mm/compaction.c:1198:38: error: 'COMPACTISOLATED' undeclared (first use in this function); did you mean 'COMPACT_SKIPPED'?
    1198 |                 count_compact_events(COMPACTISOLATED, nr_isolated);
         |                                      ^~~~~~~~~~~~~~~
         |                                      COMPACT_SKIPPED
   mm/compaction.c: In function 'fast_isolate_freepages':
   mm/compaction.c:1512:54: error: 'COMPACTISOLATED' undeclared (first use in this function); did you mean 'COMPACT_SKIPPED'?
    1512 |                                 count_compact_events(COMPACTISOLATED, nr_isolated);
         |                                                      ^~~~~~~~~~~~~~~
         |                                                      COMPACT_SKIPPED
   mm/compaction.c: In function 'compact_zone':
>> mm/compaction.c:2495:30: error: 'COMPACTMIGRATE_SCANNED' undeclared (first use in this function)
    2495 |         count_compact_events(COMPACTMIGRATE_SCANNED, cc->total_migrate_scanned);
         |                              ^~~~~~~~~~~~~~~~~~~~~~
>> mm/compaction.c:2496:30: error: 'COMPACTFREE_SCANNED' undeclared (first use in this function)
    2496 |         count_compact_events(COMPACTFREE_SCANNED, cc->total_free_scanned);
         |                              ^~~~~~~~~~~~~~~~~~~
   mm/compaction.c: In function 'kcompactd_do_work':
>> mm/compaction.c:2836:29: error: 'KCOMPACTD_WAKE' undeclared (first use in this function)
    2836 |         count_compact_event(KCOMPACTD_WAKE);
         |                             ^~~~~~~~~~~~~~
>> mm/compaction.c:2876:38: error: 'KCOMPACTD_MIGRATE_SCANNED' undeclared (first use in this function)
    2876 |                 count_compact_events(KCOMPACTD_MIGRATE_SCANNED,
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~
>> mm/compaction.c:2878:38: error: 'KCOMPACTD_FREE_SCANNED' undeclared (first use in this function)
    2878 |                 count_compact_events(KCOMPACTD_FREE_SCANNED,
         |                                      ^~~~~~~~~~~~~~~~~~~~~~
..


vim +/PGMAJFAULT +3139 mm/filemap.c

ef00e08e26dd5d Linus Torvalds          2009-06-16  3082  
485bb99b49a173 Randy Dunlap            2006-06-23  3083  /**
54cb8821de07f2 Nicholas Piggin         2007-07-19  3084   * filemap_fault - read in file data for page fault handling
d0217ac04ca659 Nicholas Piggin         2007-07-19  3085   * @vmf:	struct vm_fault containing details of the fault
485bb99b49a173 Randy Dunlap            2006-06-23  3086   *
54cb8821de07f2 Nicholas Piggin         2007-07-19  3087   * filemap_fault() is invoked via the vma operations vector for a
^1da177e4c3f41 Linus Torvalds          2005-04-16  3088   * mapped memory region to read in file data during a page fault.
^1da177e4c3f41 Linus Torvalds          2005-04-16  3089   *
^1da177e4c3f41 Linus Torvalds          2005-04-16  3090   * The goto's are kind of ugly, but this streamlines the normal case of having
^1da177e4c3f41 Linus Torvalds          2005-04-16  3091   * it in the page cache, and handles the special cases reasonably without
^1da177e4c3f41 Linus Torvalds          2005-04-16  3092   * having a lot of duplicated code.
9a95f3cf7b33d6 Paul Cassella           2014-08-06  3093   *
c1e8d7c6a7a682 Michel Lespinasse       2020-06-08  3094   * vma->vm_mm->mmap_lock must be held on entry.
9a95f3cf7b33d6 Paul Cassella           2014-08-06  3095   *
c1e8d7c6a7a682 Michel Lespinasse       2020-06-08  3096   * If our return value has VM_FAULT_RETRY set, it's because the mmap_lock
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3097)  * may be dropped before doing I/O or by lock_folio_maybe_drop_mmap().
9a95f3cf7b33d6 Paul Cassella           2014-08-06  3098   *
c1e8d7c6a7a682 Michel Lespinasse       2020-06-08  3099   * If our return value does not have VM_FAULT_RETRY set, the mmap_lock
9a95f3cf7b33d6 Paul Cassella           2014-08-06  3100   * has not been released.
9a95f3cf7b33d6 Paul Cassella           2014-08-06  3101   *
9a95f3cf7b33d6 Paul Cassella           2014-08-06  3102   * We never return with VM_FAULT_RETRY and a bit from VM_FAULT_ERROR set.
a862f68a8b3600 Mike Rapoport           2019-03-05  3103   *
a862f68a8b3600 Mike Rapoport           2019-03-05  3104   * Return: bitwise-OR of %VM_FAULT_ codes.
^1da177e4c3f41 Linus Torvalds          2005-04-16  3105   */
2bcd6454bae787 Souptick Joarder        2018-06-07  3106  vm_fault_t filemap_fault(struct vm_fault *vmf)
^1da177e4c3f41 Linus Torvalds          2005-04-16  3107  {
^1da177e4c3f41 Linus Torvalds          2005-04-16  3108  	int error;
11bac80004499e Dave Jiang              2017-02-24  3109  	struct file *file = vmf->vma->vm_file;
6b4c9f4469819a Josef Bacik             2019-03-13  3110  	struct file *fpin = NULL;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3111  	struct address_space *mapping = file->f_mapping;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3112  	struct inode *inode = mapping->host;
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3113) 	pgoff_t max_idx, index = vmf->pgoff;
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3114) 	struct folio *folio;
2bcd6454bae787 Souptick Joarder        2018-06-07  3115  	vm_fault_t ret = 0;
730633f0b7f951 Jan Kara                2021-01-28  3116  	bool mapping_locked = false;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3117  
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3118) 	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3119) 	if (unlikely(index >= max_idx))
5307cc1aa53850 Linus Torvalds          2007-10-31  3120  		return VM_FAULT_SIGBUS;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3121  
^1da177e4c3f41 Linus Torvalds          2005-04-16  3122  	/*
4942642080ea82 Johannes Weiner         2013-10-16  3123  	 * Do we have something in the page cache already?
^1da177e4c3f41 Linus Torvalds          2005-04-16  3124  	 */
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3125) 	folio = filemap_get_folio(mapping, index);
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3126) 	if (likely(folio)) {
3ea89ee86a82e9 Fengguang Wu            2007-07-19  3127  		/*
730633f0b7f951 Jan Kara                2021-01-28  3128  		 * We found the page, so try async readahead before waiting for
730633f0b7f951 Jan Kara                2021-01-28  3129  		 * the lock.
3ea89ee86a82e9 Fengguang Wu            2007-07-19  3130  		 */
730633f0b7f951 Jan Kara                2021-01-28  3131  		if (!(vmf->flags & FAULT_FLAG_TRIED))
79598cedad85d1 Matthew Wilcox (Oracle  2021-07-29  3132) 			fpin = do_async_mmap_readahead(vmf, folio);
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3133) 		if (unlikely(!folio_test_uptodate(folio))) {
730633f0b7f951 Jan Kara                2021-01-28  3134  			filemap_invalidate_lock_shared(mapping);
730633f0b7f951 Jan Kara                2021-01-28  3135  			mapping_locked = true;
730633f0b7f951 Jan Kara                2021-01-28  3136  		}
730633f0b7f951 Jan Kara                2021-01-28  3137  	} else {
ef00e08e26dd5d Linus Torvalds          2009-06-16  3138  		/* No page in the page cache at all */
ef00e08e26dd5d Linus Torvalds          2009-06-16 @3139  		count_vm_event(PGMAJFAULT);
2262185c5b287f Roman Gushchin          2017-07-06  3140  		count_memcg_event_mm(vmf->vma->vm_mm, PGMAJFAULT);
ef00e08e26dd5d Linus Torvalds          2009-06-16  3141  		ret = VM_FAULT_MAJOR;
6b4c9f4469819a Josef Bacik             2019-03-13  3142  		fpin = do_sync_mmap_readahead(vmf);
ef00e08e26dd5d Linus Torvalds          2009-06-16  3143  retry_find:
730633f0b7f951 Jan Kara                2021-01-28  3144  		/*
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3145) 		 * See comment in filemap_create_folio() why we need
730633f0b7f951 Jan Kara                2021-01-28  3146  		 * invalidate_lock
730633f0b7f951 Jan Kara                2021-01-28  3147  		 */
730633f0b7f951 Jan Kara                2021-01-28  3148  		if (!mapping_locked) {
730633f0b7f951 Jan Kara                2021-01-28  3149  			filemap_invalidate_lock_shared(mapping);
730633f0b7f951 Jan Kara                2021-01-28  3150  			mapping_locked = true;
730633f0b7f951 Jan Kara                2021-01-28  3151  		}
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3152) 		folio = __filemap_get_folio(mapping, index,
a75d4c33377277 Josef Bacik             2019-03-13  3153  					  FGP_CREAT|FGP_FOR_MMAP,
a75d4c33377277 Josef Bacik             2019-03-13  3154  					  vmf->gfp_mask);
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3155) 		if (!folio) {
6b4c9f4469819a Josef Bacik             2019-03-13  3156  			if (fpin)
6b4c9f4469819a Josef Bacik             2019-03-13  3157  				goto out_retry;
730633f0b7f951 Jan Kara                2021-01-28  3158  			filemap_invalidate_unlock_shared(mapping);
e520e932dcc607 Matthew Wilcox (Oracle  2020-04-01  3159) 			return VM_FAULT_OOM;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3160  		}
d88c0922fa0e2c Michel Lespinasse       2010-11-02  3161  	}
b522c94da5d9cb Michel Lespinasse       2010-10-26  3162  
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3163) 	if (!lock_folio_maybe_drop_mmap(vmf, folio, &fpin))
6b4c9f4469819a Josef Bacik             2019-03-13  3164  		goto out_retry;
6b4c9f4469819a Josef Bacik             2019-03-13  3165  
b522c94da5d9cb Michel Lespinasse       2010-10-26  3166  	/* Did it get truncated? */
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3167) 	if (unlikely(folio->mapping != mapping)) {
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3168) 		folio_unlock(folio);
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3169) 		folio_put(folio);
b522c94da5d9cb Michel Lespinasse       2010-10-26  3170  		goto retry_find;
b522c94da5d9cb Michel Lespinasse       2010-10-26  3171  	}
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3172) 	VM_BUG_ON_FOLIO(!folio_contains(folio, index), folio);
b522c94da5d9cb Michel Lespinasse       2010-10-26  3173  
^1da177e4c3f41 Linus Torvalds          2005-04-16  3174  	/*
d00806b183152a Nicholas Piggin         2007-07-19  3175  	 * We have a locked page in the page cache, now we need to check
d00806b183152a Nicholas Piggin         2007-07-19  3176  	 * that it's up-to-date. If not, it is going to be due to an error.
^1da177e4c3f41 Linus Torvalds          2005-04-16  3177  	 */
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3178) 	if (unlikely(!folio_test_uptodate(folio))) {
730633f0b7f951 Jan Kara                2021-01-28  3179  		/*
730633f0b7f951 Jan Kara                2021-01-28  3180  		 * The page was in cache and uptodate and now it is not.
730633f0b7f951 Jan Kara                2021-01-28  3181  		 * Strange but possible since we didn't hold the page lock all
730633f0b7f951 Jan Kara                2021-01-28  3182  		 * the time. Let's drop everything get the invalidate lock and
730633f0b7f951 Jan Kara                2021-01-28  3183  		 * try again.
730633f0b7f951 Jan Kara                2021-01-28  3184  		 */
730633f0b7f951 Jan Kara                2021-01-28  3185  		if (!mapping_locked) {
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3186) 			folio_unlock(folio);
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3187) 			folio_put(folio);
730633f0b7f951 Jan Kara                2021-01-28  3188  			goto retry_find;
730633f0b7f951 Jan Kara                2021-01-28  3189  		}
^1da177e4c3f41 Linus Torvalds          2005-04-16  3190  		goto page_not_uptodate;
730633f0b7f951 Jan Kara                2021-01-28  3191  	}
^1da177e4c3f41 Linus Torvalds          2005-04-16  3192  
6b4c9f4469819a Josef Bacik             2019-03-13  3193  	/*
c1e8d7c6a7a682 Michel Lespinasse       2020-06-08  3194  	 * We've made it this far and we had to drop our mmap_lock, now is the
6b4c9f4469819a Josef Bacik             2019-03-13  3195  	 * time to return to the upper layer and have it re-find the vma and
6b4c9f4469819a Josef Bacik             2019-03-13  3196  	 * redo the fault.
6b4c9f4469819a Josef Bacik             2019-03-13  3197  	 */
6b4c9f4469819a Josef Bacik             2019-03-13  3198  	if (fpin) {
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3199) 		folio_unlock(folio);
6b4c9f4469819a Josef Bacik             2019-03-13  3200  		goto out_retry;
6b4c9f4469819a Josef Bacik             2019-03-13  3201  	}
730633f0b7f951 Jan Kara                2021-01-28  3202  	if (mapping_locked)
730633f0b7f951 Jan Kara                2021-01-28  3203  		filemap_invalidate_unlock_shared(mapping);
6b4c9f4469819a Josef Bacik             2019-03-13  3204  
ef00e08e26dd5d Linus Torvalds          2009-06-16  3205  	/*
ef00e08e26dd5d Linus Torvalds          2009-06-16  3206  	 * Found the page and have a reference on it.
ef00e08e26dd5d Linus Torvalds          2009-06-16  3207  	 * We must recheck i_size under page lock.
ef00e08e26dd5d Linus Torvalds          2009-06-16  3208  	 */
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3209) 	max_idx = DIV_ROUND_UP(i_size_read(inode), PAGE_SIZE);
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3210) 	if (unlikely(index >= max_idx)) {
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3211) 		folio_unlock(folio);
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3212) 		folio_put(folio);
5307cc1aa53850 Linus Torvalds          2007-10-31  3213  		return VM_FAULT_SIGBUS;
d00806b183152a Nicholas Piggin         2007-07-19  3214  	}
d00806b183152a Nicholas Piggin         2007-07-19  3215  
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3216) 	vmf->page = folio_file_page(folio, index);
83c54070ee1a2d Nicholas Piggin         2007-07-19  3217  	return ret | VM_FAULT_LOCKED;
^1da177e4c3f41 Linus Torvalds          2005-04-16  3218  
^1da177e4c3f41 Linus Torvalds          2005-04-16  3219  page_not_uptodate:
^1da177e4c3f41 Linus Torvalds          2005-04-16  3220  	/*
^1da177e4c3f41 Linus Torvalds          2005-04-16  3221  	 * Umm, take care of errors if the page isn't up-to-date.
^1da177e4c3f41 Linus Torvalds          2005-04-16  3222  	 * Try to re-read it _once_. We do this synchronously,
^1da177e4c3f41 Linus Torvalds          2005-04-16  3223  	 * because there really aren't any performance issues here
^1da177e4c3f41 Linus Torvalds          2005-04-16  3224  	 * and we need to check for errors.
^1da177e4c3f41 Linus Torvalds          2005-04-16  3225  	 */
6b4c9f4469819a Josef Bacik             2019-03-13  3226  	fpin = maybe_unlock_mmap_for_io(vmf, fpin);
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3227) 	error = filemap_read_folio(file, mapping, folio);
6b4c9f4469819a Josef Bacik             2019-03-13  3228  	if (fpin)
6b4c9f4469819a Josef Bacik             2019-03-13  3229  		goto out_retry;
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3230) 	folio_put(folio);
d00806b183152a Nicholas Piggin         2007-07-19  3231  
d00806b183152a Nicholas Piggin         2007-07-19  3232  	if (!error || error == AOP_TRUNCATED_PAGE)
994fc28c7b1e69 Zach Brown              2005-12-15  3233  		goto retry_find;
730633f0b7f951 Jan Kara                2021-01-28  3234  	filemap_invalidate_unlock_shared(mapping);
^1da177e4c3f41 Linus Torvalds          2005-04-16  3235  
d0217ac04ca659 Nicholas Piggin         2007-07-19  3236  	return VM_FAULT_SIGBUS;
6b4c9f4469819a Josef Bacik             2019-03-13  3237  
6b4c9f4469819a Josef Bacik             2019-03-13  3238  out_retry:
6b4c9f4469819a Josef Bacik             2019-03-13  3239  	/*
c1e8d7c6a7a682 Michel Lespinasse       2020-06-08  3240  	 * We dropped the mmap_lock, we need to return to the fault handler to
6b4c9f4469819a Josef Bacik             2019-03-13  3241  	 * re-find the vma and come back and find our hopefully still populated
6b4c9f4469819a Josef Bacik             2019-03-13  3242  	 * page.
6b4c9f4469819a Josef Bacik             2019-03-13  3243  	 */
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3244) 	if (folio)
e292e6d644ce7b Matthew Wilcox (Oracle  2021-03-10  3245) 		folio_put(folio);
730633f0b7f951 Jan Kara                2021-01-28  3246  	if (mapping_locked)
730633f0b7f951 Jan Kara                2021-01-28  3247  		filemap_invalidate_unlock_shared(mapping);
6b4c9f4469819a Josef Bacik             2019-03-13  3248  	if (fpin)
6b4c9f4469819a Josef Bacik             2019-03-13  3249  		fput(fpin);
6b4c9f4469819a Josef Bacik             2019-03-13  3250  	return ret | VM_FAULT_RETRY;
54cb8821de07f2 Nicholas Piggin         2007-07-19  3251  }
54cb8821de07f2 Nicholas Piggin         2007-07-19  3252  EXPORT_SYMBOL(filemap_fault);
54cb8821de07f2 Nicholas Piggin         2007-07-19  3253  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
