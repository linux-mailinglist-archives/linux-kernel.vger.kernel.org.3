Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C10D47B2B3
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 19:15:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240321AbhLTSPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 13:15:20 -0500
Received: from mga07.intel.com ([134.134.136.100]:35096 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232777AbhLTSPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 13:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640024119; x=1671560119;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xn3SfHAVBBxgPNY/hfMHHIDWLipvyx6cHeleLt7x/qI=;
  b=ZLT1fuI6bUi4rFwLyKh5YnsUM6IOACWTQ69QIfG8TFS0H1XJOw8TwkoD
   DafifOtphkympgkgdGi7lOliDHxt68MyPDF6sQ1PbtPWypZvXE1+Z4JGz
   ByK+krBV42NymwnUnqGx1lAzRZL8kVib6wdXY4mBzNc1LYoZmyPhkpJUD
   q9Gd8mmQCPYWvmQJfOYaeHJ4oXb3pAhCj29FKly4enhE0fsuz/csXLwDO
   LSY4I3kLioneB039ezT9flMZs3iQmGIb5bPmif5fShyrSYVC8P0+RPRKw
   k2M8rMWE5uZsb4HJ+rADVhynNyxkMm39/80TsOdBEWcy368yAiG5Avf2G
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10203"; a="303615285"
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="303615285"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2021 10:15:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,221,1635231600"; 
   d="scan'208";a="684370606"
Received: from lkp-server02.sh.intel.com (HELO 9f38c0981d9f) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 20 Dec 2021 10:15:15 -0800
Received: from kbuild by 9f38c0981d9f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mzNBr-00085W-6H; Mon, 20 Dec 2021 18:15:15 +0000
Date:   Tue, 21 Dec 2021 02:14:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Wander Lairson Costa <wander@redhat.com>,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>, linux-block@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wander Lairson Costa <wander@redhat.com>
Subject: Re: [PATCH v4 1/1] blktrace: switch trace spinlock to a raw spinlock
Message-ID: <202112210258.y6u1AZpZ-lkp@intel.com>
References: <20211220130357.8790-2-wander@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211220130357.8790-2-wander@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Wander,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on linux/master linus/master v5.16-rc6 next-20211220]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Wander-Lairson-Costa/blktrace-switch-trace-spinlock-to-a-raw-spinlock/20211220-210538
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: hexagon-randconfig-r045-20211220 (https://download.01.org/0day-ci/archive/20211221/202112210258.y6u1AZpZ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 555eacf75f21cd1dfc6363d73ad187b730349543)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/b270731108ecba0d77a6db93d057290406c51a20
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Wander-Lairson-Costa/blktrace-switch-trace-spinlock-to-a-raw-spinlock/20211220-210538
        git checkout b270731108ecba0d77a6db93d057290406c51a20
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/ kernel/trace/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/trace/blktrace.c:148:63: warning: parameter 'blkcg' set but not used [-Wunused-but-set-parameter]
   void __trace_note_message(struct blk_trace *bt, struct blkcg *blkcg,
                                                                 ^
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
   1 warning and 2 errors generated.


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
