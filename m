Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4800A46DDFA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 23:03:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240088AbhLHWG7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 17:06:59 -0500
Received: from mga12.intel.com ([192.55.52.136]:2653 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240001AbhLHWG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 17:06:58 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10192"; a="217985661"
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="217985661"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 14:02:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,190,1635231600"; 
   d="scan'208";a="462963188"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 08 Dec 2021 14:01:58 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mv50g-00016Y-5V; Wed, 08 Dec 2021 22:01:58 +0000
Date:   Thu, 9 Dec 2021 06:01:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [davidhildenbrand:foll_unshare 1/2] include/linux/seqlock.h:141:30:
 error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
Message-ID: <202112090511.tFh8KCmb-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   git://github.com/davidhildenbrand/linux foll_unshare
head:   f4b54ddc31ca94dedc57a3aab1f42d348537a31b
commit: f270db76384cb1df5a7f1b67226a8c8515583e5f [1/2] seqlock: provide lockdep-free raw_seqcount_t variant
config: um-i386_defconfig (https://download.01.org/0day-ci/archive/20211209/202112090511.tFh8KCmb-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/davidhildenbrand/linux/commit/f270db76384cb1df5a7f1b67226a8c8515583e5f
        git remote add davidhildenbrand git://github.com/davidhildenbrand/linux
        git fetch --no-tags davidhildenbrand foll_unshare
        git checkout f270db76384cb1df5a7f1b67226a8c8515583e5f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SUBARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/mm_types.h:18,
                    from mm/init-mm.c:2:
>> include/linux/seqlock.h:141:30: error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
     141 | #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
         |                              ^~~~~~~~
   mm/init-mm.c:34:23: note: in expansion of macro 'SEQCNT_ZERO'
      34 |  .write_protect_seq = SEQCNT_ZERO(init_mm.write_protect_seq),
         |                       ^~~~~~~~~~~
--
   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:19,
                    from include/linux/ratelimit.h:6,
                    from fs/dcache.c:18:
>> include/linux/seqlock.h:141:30: error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
     141 | #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
         |                              ^~~~~~~~
   include/linux/seqlock.h:353:15: note: in expansion of macro 'SEQCNT_ZERO'
     353 |  .seqcount  = SEQCNT_ZERO(seq_name.seqcount), \
         |               ^~~~~~~~~~~
   include/linux/seqlock.h:358:42: note: in expansion of macro 'SEQCOUNT_LOCKNAME_ZERO'
     358 | #define SEQCNT_SPINLOCK_ZERO(name, lock) SEQCOUNT_LOCKNAME_ZERO(name, lock)
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:888:15: note: in expansion of macro 'SEQCNT_SPINLOCK_ZERO'
     888 |   .seqcount = SEQCNT_SPINLOCK_ZERO(lockname, &(lockname).lock), \
         |               ^~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:907:18: note: in expansion of macro '__SEQLOCK_UNLOCKED'
     907 |   seqlock_t sl = __SEQLOCK_UNLOCKED(sl)
         |                  ^~~~~~~~~~~~~~~~~~
   fs/dcache.c:77:28: note: in expansion of macro 'DEFINE_SEQLOCK'
      77 | __cacheline_aligned_in_smp DEFINE_SEQLOCK(rename_lock);
         |                            ^~~~~~~~~~~~~~
--
   In file included from include/linux/dcache.h:11,
                    from include/linux/fs.h:8,
                    from include/uapi/linux/aio_abi.h:31,
                    from include/linux/syscalls.h:77,
                    from fs/namespace.c:11:
>> include/linux/seqlock.h:141:30: error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
     141 | #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
         |                              ^~~~~~~~
   include/linux/seqlock.h:353:15: note: in expansion of macro 'SEQCNT_ZERO'
     353 |  .seqcount  = SEQCNT_ZERO(seq_name.seqcount), \
         |               ^~~~~~~~~~~
   include/linux/seqlock.h:358:42: note: in expansion of macro 'SEQCOUNT_LOCKNAME_ZERO'
     358 | #define SEQCNT_SPINLOCK_ZERO(name, lock) SEQCOUNT_LOCKNAME_ZERO(name, lock)
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:888:15: note: in expansion of macro 'SEQCNT_SPINLOCK_ZERO'
     888 |   .seqcount = SEQCNT_SPINLOCK_ZERO(lockname, &(lockname).lock), \
         |               ^~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:907:18: note: in expansion of macro '__SEQLOCK_UNLOCKED'
     907 |   seqlock_t sl = __SEQLOCK_UNLOCKED(sl)
         |                  ^~~~~~~~~~~~~~~~~~
   fs/namespace.c:98:28: note: in expansion of macro 'DEFINE_SEQLOCK'
      98 | __cacheline_aligned_in_smp DEFINE_SEQLOCK(mount_lock);
         |                            ^~~~~~~~~~~~~~
--
   In file included from include/linux/hrtimer.h:20,
                    from include/linux/sched.h:19,
                    from include/linux/sched/signal.h:7,
                    from fs/fs_struct.c:3:
>> include/linux/seqlock.h:141:30: error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
     141 | #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
         |                              ^~~~~~~~
   include/linux/seqlock.h:353:15: note: in expansion of macro 'SEQCNT_ZERO'
     353 |  .seqcount  = SEQCNT_ZERO(seq_name.seqcount), \
         |               ^~~~~~~~~~~
   include/linux/seqlock.h:358:42: note: in expansion of macro 'SEQCOUNT_LOCKNAME_ZERO'
     358 | #define SEQCNT_SPINLOCK_ZERO(name, lock) SEQCOUNT_LOCKNAME_ZERO(name, lock)
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
   fs/fs_struct.c:166:10: note: in expansion of macro 'SEQCNT_SPINLOCK_ZERO'
     166 |  .seq  = SEQCNT_SPINLOCK_ZERO(init_fs.seq, &init_fs.lock),
         |          ^~~~~~~~~~~~~~~~~~~~
--
   In file included from include/linux/mm_types.h:18,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from net/ipv4/tcp_metrics.c:5:
>> include/linux/seqlock.h:141:30: error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
     141 | #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
         |                              ^~~~~~~~
   include/linux/seqlock.h:353:15: note: in expansion of macro 'SEQCNT_ZERO'
     353 |  .seqcount  = SEQCNT_ZERO(seq_name.seqcount), \
         |               ^~~~~~~~~~~
   include/linux/seqlock.h:358:42: note: in expansion of macro 'SEQCOUNT_LOCKNAME_ZERO'
     358 | #define SEQCNT_SPINLOCK_ZERO(name, lock) SEQCOUNT_LOCKNAME_ZERO(name, lock)
         |                                          ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:888:15: note: in expansion of macro 'SEQCNT_SPINLOCK_ZERO'
     888 |   .seqcount = SEQCNT_SPINLOCK_ZERO(lockname, &(lockname).lock), \
         |               ^~~~~~~~~~~~~~~~~~~~
   include/linux/seqlock.h:907:18: note: in expansion of macro '__SEQLOCK_UNLOCKED'
     907 |   seqlock_t sl = __SEQLOCK_UNLOCKED(sl)
         |                  ^~~~~~~~~~~~~~~~~~
   net/ipv4/tcp_metrics.c:541:8: note: in expansion of macro 'DEFINE_SEQLOCK'
     541 | static DEFINE_SEQLOCK(fastopen_seqlock);
         |        ^~~~~~~~~~~~~~
--
   In file included from include/linux/mmzone.h:16,
                    from include/linux/gfp.h:6,
                    from include/linux/mm.h:10,
                    from kernel/printk/printk.c:23:
>> include/linux/seqlock.h:141:30: error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
     141 | #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
         |                              ^~~~~~~~
   include/linux/seqlock.h:737:15: note: in expansion of macro 'SEQCNT_ZERO'
     737 |  .seqcount  = SEQCNT_ZERO(seq_name.seqcount), \
         |               ^~~~~~~~~~~
   kernel/printk/printk.c:381:12: note: in expansion of macro 'SEQCNT_LATCH_ZERO'
     381 |  .latch  = SEQCNT_LATCH_ZERO(clear_seq.latch),
         |            ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/mmzone.h:16,
                    from include/linux/gfp.h:6,
                    from include/linux/radix-tree.h:12,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/clocksource.h:19,
                    from include/linux/timekeeper_internal.h:10,
                    from kernel/time/timekeeping.c:6:
>> include/linux/seqlock.h:141:30: error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
     141 | #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
         |                              ^~~~~~~~
   include/linux/seqlock.h:353:15: note: in expansion of macro 'SEQCNT_ZERO'
     353 |  .seqcount  = SEQCNT_ZERO(seq_name.seqcount), \
         |               ^~~~~~~~~~~
   include/linux/seqlock.h:357:46: note: in expansion of macro 'SEQCOUNT_LOCKNAME_ZERO'
     357 | #define SEQCNT_RAW_SPINLOCK_ZERO(name, lock) SEQCOUNT_LOCKNAME_ZERO(name, lock)
         |                                              ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/timekeeping.c:52:9: note: in expansion of macro 'SEQCNT_RAW_SPINLOCK_ZERO'
      52 |  .seq = SEQCNT_RAW_SPINLOCK_ZERO(tk_core.seq, &timekeeper_lock),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/seqlock.h:141:30: error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
     141 | #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
         |                              ^~~~~~~~
   include/linux/seqlock.h:737:15: note: in expansion of macro 'SEQCNT_ZERO'
     737 |  .seqcount  = SEQCNT_ZERO(seq_name.seqcount), \
         |               ^~~~~~~~~~~
   kernel/time/timekeeping.c:104:13: note: in expansion of macro 'SEQCNT_LATCH_ZERO'
     104 |  .seq     = SEQCNT_LATCH_ZERO(tk_fast_mono.seq),
         |             ^~~~~~~~~~~~~~~~~
>> include/linux/seqlock.h:141:30: error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
     141 | #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
         |                              ^~~~~~~~
   include/linux/seqlock.h:737:15: note: in expansion of macro 'SEQCNT_ZERO'
     737 |  .seqcount  = SEQCNT_ZERO(seq_name.seqcount), \
         |               ^~~~~~~~~~~
   kernel/time/timekeeping.c:110:13: note: in expansion of macro 'SEQCNT_LATCH_ZERO'
     110 |  .seq     = SEQCNT_LATCH_ZERO(tk_fast_raw.seq),
         |             ^~~~~~~~~~~~~~~~~
--
   In file included from include/linux/mmzone.h:16,
                    from include/linux/gfp.h:6,
                    from include/linux/radix-tree.h:12,
                    from include/linux/idr.h:15,
                    from include/linux/kernfs.h:13,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/clocksource.h:19,
                    from kernel/time/jiffies.c:7:
>> include/linux/seqlock.h:141:30: error: 'seqcount_t' {aka 'struct seqcount'} has no member named 'seqcount'
     141 | #define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
         |                              ^~~~~~~~
   include/linux/seqlock.h:353:15: note: in expansion of macro 'SEQCNT_ZERO'
     353 |  .seqcount  = SEQCNT_ZERO(seq_name.seqcount), \
         |               ^~~~~~~~~~~
   include/linux/seqlock.h:357:46: note: in expansion of macro 'SEQCOUNT_LOCKNAME_ZERO'
     357 | #define SEQCNT_RAW_SPINLOCK_ZERO(name, lock) SEQCOUNT_LOCKNAME_ZERO(name, lock)
         |                                              ^~~~~~~~~~~~~~~~~~~~~~
   kernel/time/jiffies.c:45:2: note: in expansion of macro 'SEQCNT_RAW_SPINLOCK_ZERO'
      45 |  SEQCNT_RAW_SPINLOCK_ZERO(jiffies_seq, &jiffies_lock);
         |  ^~~~~~~~~~~~~~~~~~~~~~~~


vim +141 include/linux/seqlock.h

   136	
   137	/**
   138	 * SEQCNT_ZERO() - static initializer for seqcount_t
   139	 * @name: Name of the seqcount_t instance
   140	 */
 > 141	#define SEQCNT_ZERO(name) { .seqcount = RAW_SEQCNT_ZERO(), SEQCOUNT_DEP_MAP_INIT(name) }
   142	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
