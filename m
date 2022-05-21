Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA70152F757
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 03:31:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239040AbiEUBb3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 21:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiEUBb1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 21:31:27 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E7E323BD3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 18:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653096686; x=1684632686;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=md3cCOl0EMuZcAaSqgZvOzox2NciGnz8N/r+pU7M6NA=;
  b=Ax1/jxOTgMwdc6J7emTpzI8Lz5n8Td6I9TKap0vthumuWK71LU98Pb15
   bse9RUrKQfv8twPYV2PLB6mv/+oPo6bqA5YGjATh3yw7+fa4mGzKR97lr
   f2+/ecv47KTgEquvMS6jMqj/opZp9xgPc6VI5u1XeFzlcM4Z1U3EOwSSV
   W0WDziz6s1jKeEq8YqSywwMMSv6he0UuuG6L8RT1RvaKg+jxDEnGMKnpZ
   nfq9dqSFDdxhKgZE8N/kirqfunX0NNpLjxuDa9ygvYV+IgM7KuCk+hiyU
   MxjT9dX0IqsyQwoOoa4zl14JICvx9xlfEbS4dqnJHHleBdLZ7oqQS9CE3
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="270369572"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="270369572"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 18:31:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="571112499"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 20 May 2022 18:31:22 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsDxh-0005jC-P5;
        Sat, 21 May 2022 01:31:21 +0000
Date:   Sat, 21 May 2022 09:31:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>,
        Josh Don <joshdon@google.com>
Subject: Re: [PATCH v2] sched/core: add forced idle accounting for cgroups
Message-ID: <202205210945.s3TGKFfR-lkp@intel.com>
References: <20220520235138.3140590-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520235138.3140590-1-joshdon@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tj-cgroup/for-next]
[also build test WARNING on tip/sched/core tip/master v5.18-rc7 next-20220520]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220521-075311
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tj/cgroup.git for-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220521/202205210945.s3TGKFfR-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0575a42c9f10cda618b09b949cc42fe97abea479
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220521-075311
        git checkout 0575a42c9f10cda618b09b949cc42fe97abea479
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/math.h:6,
                    from include/linux/math64.h:6,
                    from include/linux/time64.h:5,
                    from include/linux/restart_block.h:10,
                    from include/linux/thread_info.h:14,
                    from include/asm-generic/preempt.h:5,
                    from ./arch/m68k/include/generated/asm/preempt.h:1,
                    from include/linux/preempt.h:78,
                    from arch/m68k/include/asm/irqflags.h:6,
                    from include/linux/irqflags.h:16,
                    from arch/m68k/include/asm/atomic.h:6,
                    from include/linux/atomic.h:7,
                    from include/linux/rcupdate.h:25,
                    from include/linux/rculist.h:11,
                    from include/linux/pid.h:5,
                    from include/linux/sched.h:14,
                    from include/linux/cgroup.h:12,
                    from kernel/cgroup/cgroup-internal.h:5,
                    from kernel/cgroup/rstat.c:2:
   kernel/cgroup/rstat.c: In function 'cgroup_base_stat_cputime_show':
>> arch/m68k/include/asm/div64.h:21:17: warning: 'forceidle_time' is used uninitialized [-Wuninitialized]
      21 |         __n.n64 = (n);                                          \
         |                 ^
   kernel/cgroup/rstat.c:465:28: note: 'forceidle_time' was declared here
     465 |         u64 __maybe_unused forceidle_time;
         |                            ^~~~~~~~~~~~~~


vim +/forceidle_time +21 arch/m68k/include/asm/div64.h

d20f5aa338dc75 Greg Ungerer   2009-02-06  12  
d20f5aa338dc75 Greg Ungerer   2009-02-06  13  #define do_div(n, base) ({					\
d20f5aa338dc75 Greg Ungerer   2009-02-06  14  	union {							\
d20f5aa338dc75 Greg Ungerer   2009-02-06  15  		unsigned long n32[2];				\
d20f5aa338dc75 Greg Ungerer   2009-02-06  16  		unsigned long long n64;				\
d20f5aa338dc75 Greg Ungerer   2009-02-06  17  	} __n;							\
d20f5aa338dc75 Greg Ungerer   2009-02-06  18  	unsigned long __rem, __upper;				\
ea077b1b96e073 Andreas Schwab 2013-08-09  19  	unsigned long __base = (base);				\
d20f5aa338dc75 Greg Ungerer   2009-02-06  20  								\
d20f5aa338dc75 Greg Ungerer   2009-02-06 @21  	__n.n64 = (n);						\
d20f5aa338dc75 Greg Ungerer   2009-02-06  22  	if ((__upper = __n.n32[0])) {				\
d20f5aa338dc75 Greg Ungerer   2009-02-06  23  		asm ("divul.l %2,%1:%0"				\
d20f5aa338dc75 Greg Ungerer   2009-02-06  24  		     : "=d" (__n.n32[0]), "=d" (__upper)	\
ea077b1b96e073 Andreas Schwab 2013-08-09  25  		     : "d" (__base), "0" (__n.n32[0]));		\
d20f5aa338dc75 Greg Ungerer   2009-02-06  26  	}							\
d20f5aa338dc75 Greg Ungerer   2009-02-06  27  	asm ("divu.l %2,%1:%0"					\
d20f5aa338dc75 Greg Ungerer   2009-02-06  28  	     : "=d" (__n.n32[1]), "=d" (__rem)			\
ea077b1b96e073 Andreas Schwab 2013-08-09  29  	     : "d" (__base), "1" (__upper), "0" (__n.n32[1]));	\
d20f5aa338dc75 Greg Ungerer   2009-02-06  30  	(n) = __n.n64;						\
d20f5aa338dc75 Greg Ungerer   2009-02-06  31  	__rem;							\
d20f5aa338dc75 Greg Ungerer   2009-02-06  32  })
d20f5aa338dc75 Greg Ungerer   2009-02-06  33  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
