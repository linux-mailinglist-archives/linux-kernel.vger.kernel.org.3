Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A24B452F79E
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 04:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350567AbiEUCje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 22:39:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbiEUCj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 22:39:29 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8854318FF0D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 19:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653100768; x=1684636768;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1HhJywIEmfL+qtTi5BFNwiwjLbhMBstdEXIaQHLOt2U=;
  b=IkSKOTNPNPLvVBSOyjnCnbVyG1rHvMQQNgcBin5p/21uuBt7YlcvSywE
   dHEoxVDUsToBdwnsayOtjt6wuRLIc6KtXlzZAGTHDB4iZJCVE5sQnMnuc
   /qe7wQ9D+SoDhC3z72rlaLdHRPzwn09+z525AMmsElk1DMoy+VBoPOT/a
   W2281QfHxM1MfbFsYS06n10AYPRrT3eqFuxGXs1EDC+x8lPZwbWUy4p0J
   RVdcB4JI7Mi0zTgzxhuqel7GBW9/FvQIgf3pDevn0nMcpHoSGdh0SRWoO
   5wGgKrmxuEquWqub8I9WAUOe+mQnbLylb/gh0Bvjj/UjA+tnxh8GjfDeZ
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10353"; a="298107480"
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="298107480"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 May 2022 19:39:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,240,1647327600"; 
   d="scan'208";a="599559957"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 20 May 2022 19:39:24 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nsF1X-0005nG-OF;
        Sat, 21 May 2022 02:39:23 +0000
Date:   Sat, 21 May 2022 10:38:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Josh Don <joshdon@google.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Tejun Heo <tj@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>,
        Josh Don <joshdon@google.com>
Subject: Re: [PATCH v2] sched/core: add forced idle accounting for cgroups
Message-ID: <202205211029.u32ZBjjj-lkp@intel.com>
References: <20220520235138.3140590-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520235138.3140590-1-joshdon@google.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
config: hexagon-randconfig-r033-20220519 (https://download.01.org/0day-ci/archive/20220521/202205211029.u32ZBjjj-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b369762beb70dfef22c7e793aed79b94d7dc0757)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/0575a42c9f10cda618b09b949cc42fe97abea479
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Josh-Don/sched-core-add-forced-idle-accounting-for-cgroups/20220521-075311
        git checkout 0575a42c9f10cda618b09b949cc42fe97abea479
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/cgroup/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> kernel/cgroup/rstat.c:489:9: warning: variable 'forceidle_time' is uninitialized when used here [-Wuninitialized]
           do_div(forceidle_time, NSEC_PER_USEC);
                  ^~~~~~~~~~~~~~
   include/asm-generic/div64.h:225:12: note: expanded from macro 'do_div'
                   __rem = (n) & (__base - 1);             \
                            ^
   kernel/cgroup/rstat.c:465:35: note: initialize the variable 'forceidle_time' to silence this warning
           u64 __maybe_unused forceidle_time;
                                            ^
                                             = 0
   1 warning generated.


vim +/forceidle_time +489 kernel/cgroup/rstat.c

   459	
   460	void cgroup_base_stat_cputime_show(struct seq_file *seq)
   461	{
   462		struct cgroup *cgrp = seq_css(seq)->cgroup;
   463		u64 usage, utime, stime;
   464		struct cgroup_base_stat bstat;
   465		u64 __maybe_unused forceidle_time;
   466	
   467		if (cgroup_parent(cgrp)) {
   468			cgroup_rstat_flush_hold(cgrp);
   469			usage = cgrp->bstat.cputime.sum_exec_runtime;
   470			cputime_adjust(&cgrp->bstat.cputime, &cgrp->prev_cputime,
   471				       &utime, &stime);
   472	#ifdef CONFIG_SCHED_CORE
   473			forceidle_time = cgrp->bstat.forceidle_sum;
   474	#endif
   475			cgroup_rstat_flush_release();
   476		} else {
   477			root_cgroup_cputime(&bstat);
   478			usage = bstat.cputime.sum_exec_runtime;
   479			utime = bstat.cputime.utime;
   480			stime = bstat.cputime.stime;
   481	#ifdef CONFIG_SCHED_CORE
   482			forceidle_time = bstat.forceidle_sum;
   483	#endif
   484		}
   485	
   486		do_div(usage, NSEC_PER_USEC);
   487		do_div(utime, NSEC_PER_USEC);
   488		do_div(stime, NSEC_PER_USEC);
 > 489		do_div(forceidle_time, NSEC_PER_USEC);
   490	
   491		seq_printf(seq, "usage_usec %llu\n"
   492			   "user_usec %llu\n"
   493			   "system_usec %llu\n",
   494			   usage, utime, stime);
   495	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
