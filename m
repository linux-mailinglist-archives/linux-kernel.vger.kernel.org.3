Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5276525E42
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 11:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378897AbiEMJKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 05:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378891AbiEMJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 05:10:34 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A743B16D13D
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652433032; x=1683969032;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Veu5m7iYXG6x7nYTAQ0GJ7hDoiNSOwM4QvNljALKRcc=;
  b=DBu1qh+FvhjVRasLJ0fprAZ3nypTd8U3lX/8oZ+ujOjD/BCcEbiqKJUp
   kZASX3K7t5ZCv9IU8KBR78V4x/Y2FxvCs8+u6K/wRbADJeGWzdX3eCmGb
   FDOOi7aHQooSr7585VKCNeyzg8Uf9fO991QjCt7vhhFUdMOGu4+mGJ06F
   USvfjSWNFPNBnDbEcZw2ZYHbONteVdwAFWR0MqbPX/FGfXG0fteZ/NPzs
   Aa+Q+1AyFo5P7b8gZancWOhpj9XkYy4xwP1znNzAiMmx0ckZSRsCF7N75
   zqnXRQ3gRaisE+FoTITYxsV1xa23Kfc3vKuiXK3avp9XYDNRGGF3ABxiz
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="257805454"
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="257805454"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 02:10:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,221,1647327600"; 
   d="scan'208";a="671260310"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2022 02:10:28 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npRJb-000LZU-Do;
        Fri, 13 May 2022 09:10:27 +0000
Date:   Fri, 13 May 2022 17:09:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>,
        Tejun Heo <tj@kernel.org>, Josh Don <joshdon@google.com>
Subject: Re: [PATCH] sched/core: add forced idle accounting for cgroups
Message-ID: <202205131630.fQphKrzY-lkp@intel.com>
References: <20220513005427.2507335-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513005427.2507335-1-joshdon@google.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on tip/master linux/master linus/master v5.18-rc6 next-20220512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220513-085621
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 734387ec2f9d77b00276042b1fa7c95f48ee879d
config: s390-randconfig-r003-20220512 (https://download.01.org/0day-ci/archive/20220513/202205131630.fQphKrzY-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 38189438b69ca27b4c6ce707c52dbd217583d046)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/21dca7763777c1985d6f5ac289e6e0c20d429d05
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220513-085621
        git checkout 21dca7763777c1985d6f5ac289e6e0c20d429d05
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from kernel/sched/build_utility.c:15:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:37:59: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) __swab16((__force __u16)(__le16)(x))
                                                             ^
   include/uapi/linux/swab.h:102:54: note: expanded from macro '__swab16'
   #define __swab16(x) (__u16)__builtin_bswap16((__u16)(x))
                                                        ^
   In file included from kernel/sched/build_utility.c:15:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/big_endian.h:35:59: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) __swab32((__force __u32)(__le32)(x))
                                                             ^
   include/uapi/linux/swab.h:115:54: note: expanded from macro '__swab32'
   #define __swab32(x) (__u32)__builtin_bswap32((__u32)(x))
                                                        ^
   In file included from kernel/sched/build_utility.c:15:
   In file included from include/linux/sched/isolation.h:6:
   In file included from include/linux/tick.h:8:
   In file included from include/linux/clockchips.h:14:
   In file included from include/linux/clocksource.h:22:
   In file included from arch/s390/include/asm/io.h:75:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:609:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsb(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:617:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsw(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:625:20: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           readsl(PCI_IOBASE + addr, buffer, count);
                  ~~~~~~~~~~ ^
   include/asm-generic/io.h:634:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesb(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:643:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesw(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   include/asm-generic/io.h:652:21: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           writesl(PCI_IOBASE + addr, buffer, count);
                   ~~~~~~~~~~ ^
   In file included from kernel/sched/build_utility.c:93:
>> kernel/sched/core_sched.c:306:28: error: incomplete definition of type 'struct task_group'
           struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
                                   ~~^
   include/linux/sched.h:69:8: note: forward declaration of 'struct task_group'
   struct task_group;
          ^
   In file included from kernel/sched/build_utility.c:93:
   kernel/sched/core_sched.c:307:32: error: incomplete definition of type 'struct task_group'
           struct task_group *parent = tg->parent;
                                       ~~^
   include/linux/sched.h:69:8: note: forward declaration of 'struct task_group'
   struct task_group;
          ^
   In file included from kernel/sched/build_utility.c:93:
   kernel/sched/core_sched.c:319:12: error: incomplete definition of type 'struct task_group'
           delta = tg->forceidle_sum_pending;
                   ~~^
   include/linux/sched.h:69:8: note: forward declaration of 'struct task_group'
   struct task_group;
          ^
   In file included from kernel/sched/build_utility.c:93:
   kernel/sched/core_sched.c:321:5: error: incomplete definition of type 'struct task_group'
                   tg->forceidle_sum_pending = 0;
                   ~~^
   include/linux/sched.h:69:8: note: forward declaration of 'struct task_group'
   struct task_group;
          ^
   In file included from kernel/sched/build_utility.c:93:
   kernel/sched/core_sched.c:333:4: error: incomplete definition of type 'struct task_group'
           tg->forceidle_sum += delta;
           ~~^
   include/linux/sched.h:69:8: note: forward declaration of 'struct task_group'
   struct task_group;
          ^
   In file included from kernel/sched/build_utility.c:93:
   kernel/sched/core_sched.c:334:8: error: incomplete definition of type 'struct task_group'
           parent->forceidle_sum_pending += delta;
           ~~~~~~^
   include/linux/sched.h:69:8: note: forward declaration of 'struct task_group'
   struct task_group;
          ^
   In file included from kernel/sched/build_utility.c:93:
   kernel/sched/core_sched.c:340:9: error: incomplete definition of type 'struct task_group'
           if (!tg->parent) {
                ~~^
   include/linux/sched.h:69:8: note: forward declaration of 'struct task_group'
   struct task_group;
          ^
   In file included from kernel/sched/build_utility.c:93:
   kernel/sched/core_sched.c:353:12: error: incomplete definition of type 'struct task_group'
                   return tg->forceidle_sum;
                          ~~^
   include/linux/sched.h:69:8: note: forward declaration of 'struct task_group'
   struct task_group;
          ^
   12 warnings and 8 errors generated.


vim +306 kernel/sched/core_sched.c

   303	
   304	void sched_core_rstat_flush(struct task_group *tg, int cpu)
   305	{
 > 306		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
   307		struct task_group *parent = tg->parent;
   308		u64 delta, curr_sum;
   309	
   310		/* root uses cpustat */
   311		if (!parent)
   312			return;
   313	
   314		/*
   315		 * Note: cgroup_rstat_lock protects cfs_rq->forceidle_sum_prev and
   316		 * tg->{forceidle_sum, forceidle_sum_pending}.
   317		 */
   318	
   319		delta = tg->forceidle_sum_pending;
   320		if (delta)
   321			tg->forceidle_sum_pending = 0;
   322	
   323		/* rq lock not held; value may change concurrently */
   324		curr_sum = READ_ONCE(cfs_rq->forceidle_sum);
   325		if (curr_sum != cfs_rq->forceidle_sum_prev) {
   326			delta += curr_sum - cfs_rq->forceidle_sum_prev;
   327			cfs_rq->forceidle_sum_prev = curr_sum;
   328		}
   329	
   330		if (!delta)
   331			return;
   332	
   333		tg->forceidle_sum += delta;
   334		parent->forceidle_sum_pending += delta;
   335	}
   336	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
