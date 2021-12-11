Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 294E8471340
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 11:10:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230292AbhLKKKk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 05:10:40 -0500
Received: from mga03.intel.com ([134.134.136.65]:35589 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229841AbhLKKKj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 05:10:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639217439; x=1670753439;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RsECYxBD/UCZ2DAs+eLKtYAuhwWefdi+0MEcv9sVRow=;
  b=Q2SobdVEIQ6MUWf7Kv10YuOr5p4i5P5NPDJt1q69pVS1+rxebXqN4O9d
   x0+LqPD/lW+BCUyIZzgpc5RgxiSUJCeCA9NMLI6x7m64+5A3hsyAFQqiA
   aQ/iYgj1Pfn0HuZ7F96XIAVDTzIaxJJjQwbw8HS7f9SZFfpRDSYjb3KqX
   hO5nV9ROB23MfrhCdUMJGPVrU8W/5XuVv9YqBhKheVYdxVDqF2RWKr4S+
   zby+ReY/NJgNWXrOEKSkE8rDvISu/rrQsBye4doSw25DNg8W2d5cgdomY
   K1T9Y3QHU8NOwIEEIELuil3ov4cB2/JwbD6Qf3/aV5njhpLTsHvbJmKKD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="238467545"
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="238467545"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Dec 2021 02:10:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,198,1635231600"; 
   d="scan'208";a="613212344"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 11 Dec 2021 02:10:37 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvzKu-0004Rs-Ew; Sat, 11 Dec 2021 10:10:36 +0000
Date:   Sat, 11 Dec 2021 18:09:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-rt-users@vger.kernel.org,
        Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PREEMPT_RT PATCH 2/2] blktrace: switch trace spinlock to a raw
 spinlock
Message-ID: <202112111754.ivCXr0cu-lkp@intel.com>
References: <20211210204156.96336-3-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210204156.96336-3-wander@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wander,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linux/master linus/master v5.16-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Wander-Lairson-Costa/Fix-warnings-in-blktrace/20211211-044405
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: arm64-randconfig-r014-20211210 (https://download.01.org/0day-ci/archive/20211211/202112111754.ivCXr0cu-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/78ab0023d3b1ba3f3dc5703b4d4fac1dd24aa0c2
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Wander-Lairson-Costa/Fix-warnings-in-blktrace/20211211-044405
        git checkout 78ab0023d3b1ba3f3dc5703b4d4fac1dd24aa0c2
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/trace/blktrace.c:1611:17: error: incompatible pointer types passing 'raw_spinlock_t *' (aka 'struct raw_spinlock *') to parameter of type 'spinlock_t *' (aka 'struct spinlock *') [-Werror,-Wincompatible-pointer-types]
                   spin_lock_irq(&running_trace_lock);
                                 ^~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:372:55: note: passing argument to parameter 'lock' here
   static __always_inline void spin_lock_irq(spinlock_t *lock)
                                                         ^
   kernel/trace/blktrace.c:1613:19: error: incompatible pointer types passing 'raw_spinlock_t *' (aka 'struct raw_spinlock *') to parameter of type 'spinlock_t *' (aka 'struct spinlock *') [-Werror,-Wincompatible-pointer-types]
                   spin_unlock_irq(&running_trace_lock);
                                   ^~~~~~~~~~~~~~~~~~~
   include/linux/spinlock.h:397:57: note: passing argument to parameter 'lock' here
   static __always_inline void spin_unlock_irq(spinlock_t *lock)
                                                           ^
   2 errors generated.


vim +1611 kernel/trace/blktrace.c

c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1599  
c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1600  static int blk_trace_remove_queue(struct request_queue *q)
c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1601  {
c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1602  	struct blk_trace *bt;
c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1603  
c3dbe541ef7775 kernel/trace/blktrace.c Jan Kara                 2020-06-05  1604  	bt = rcu_replace_pointer(q->blk_trace, NULL,
85e0cbbb8a7953 kernel/trace/blktrace.c Luis Chamberlain         2020-06-19  1605  				 lockdep_is_held(&q->debugfs_mutex));
c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1606  	if (bt == NULL)
c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1607  		return -EINVAL;
c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1608  
5afedf670caf30 kernel/trace/blktrace.c Zhihao Cheng             2021-09-23  1609  	if (bt->trace_state == Blktrace_running) {
5afedf670caf30 kernel/trace/blktrace.c Zhihao Cheng             2021-09-23  1610  		bt->trace_state = Blktrace_stopped;
5afedf670caf30 kernel/trace/blktrace.c Zhihao Cheng             2021-09-23 @1611  		spin_lock_irq(&running_trace_lock);
5afedf670caf30 kernel/trace/blktrace.c Zhihao Cheng             2021-09-23  1612  		list_del_init(&bt->running_list);
5afedf670caf30 kernel/trace/blktrace.c Zhihao Cheng             2021-09-23  1613  		spin_unlock_irq(&running_trace_lock);
5afedf670caf30 kernel/trace/blktrace.c Zhihao Cheng             2021-09-23  1614  		relay_flush(bt->rchan);
5afedf670caf30 kernel/trace/blktrace.c Zhihao Cheng             2021-09-23  1615  	}
5afedf670caf30 kernel/trace/blktrace.c Zhihao Cheng             2021-09-23  1616  
a6da0024ffc19e kernel/trace/blktrace.c Jens Axboe               2017-11-05  1617  	put_probe_ref();
c780e86dd48ef6 kernel/trace/blktrace.c Jan Kara                 2020-02-06  1618  	synchronize_rcu();
ad5dd5493a55e4 kernel/trace/blktrace.c Li Zefan                 2009-03-27  1619  	blk_trace_free(bt);
c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1620  	return 0;
c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1621  }
c71a896154119f block/blktrace.c        Arnaldo Carvalho de Melo 2009-01-23  1622  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
