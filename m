Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B430550D4D3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238638AbiDXT2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:28:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237458AbiDXT2F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:28:05 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB64512772
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 12:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650828301; x=1682364301;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/c8Hp3fLsUIryinor/1uRxQ5rrS7P0JWeBM5qeL0Gto=;
  b=UZvCHSX1P3l1eNTqwiR2xAu5WtBGvkrZY6zynrG3wfp2pMvP8BQESe1r
   ZtKdcMndEm9oiZSDd3+5i2KKSWuknjglkRs29kFwRvxlHU0VOGWtIe5Hu
   p/79Ilpz6rYsBjm3PfvKPOwPvRe0lMDwcmRzgmNvaCIB/gmj2PzMMShsU
   WFzqkPqziBKvT0v9WjQDZlGhgPS4OyNTzXKuVnhGphbn/u5wvU2ktyus1
   TvIv6Pxp5MH0a5M+HjXzrRKhcHxpDK7/6HwnqAk+X0Tyevjj2OLVYl/vO
   +aA6Am3n1vA8zbwGbcoGKp0RQoRPWfPhd13YR0OlG6wvM0TV6toWEiNPX
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10327"; a="245005836"
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="245005836"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2022 12:25:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,287,1643702400"; 
   d="scan'208";a="531776655"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 24 Apr 2022 12:24:56 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nihqp-0001iL-G6;
        Sun, 24 Apr 2022 19:24:55 +0000
Date:   Mon, 25 Apr 2022 03:23:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cruz Zhao <CruzZhao@linux.alibaba.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        akpm@linux-foundation.org, tglx@linutronix.de, luto@kernel.org,
        legion@kernel.org, fenghua.yu@intel.com, david@redhat.com,
        bristot@redhat.com, bigeasy@linutronix.de, ebiederm@xmission.com
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched/core: Skip sched_core_fork/free() when core sched
 is disabled
Message-ID: <202204250352.INhpElgh-lkp@intel.com>
References: <1650818276-129374-1-git-send-email-CruzZhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650818276-129374-1-git-send-email-CruzZhao@linux.alibaba.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cruz,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on tip/sched/core]
[also build test ERROR on hnaz-mm/master linus/master v5.18-rc3 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Cruz-Zhao/sched-core-Skip-sched_core_fork-free-when-core-sched-is-disabled/20220425-003934
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a658353167bf2ea6052cee071dbcc13e0f229dc9
config: ia64-allyesconfig (https://download.01.org/0day-ci/archive/20220425/202204250352.INhpElgh-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/211b98683083c1f71c1821b89877743bd1a4cc99
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cruz-Zhao/sched-core-Skip-sched_core_fork-free-when-core-sched-is-disabled/20220425-003934
        git checkout 211b98683083c1f71c1821b89877743bd1a4cc99
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=ia64 prepare

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   scripts/genksyms/parse.y: warning: 9 shift/reduce conflicts [-Wconflicts-sr]
   scripts/genksyms/parse.y: warning: 5 reduce/reduce conflicts [-Wconflicts-rr]
   scripts/genksyms/parse.y: note: rerun with option '-Wcounterexamples' to generate conflict counterexamples
   In file included from include/linux/sched/signal.h:7,
                    from arch/ia64/kernel/asm-offsets.c:10:
>> include/linux/sched.h:2400:1: warning: data definition has no type or storage class
    2400 | DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
         | ^~~~~~~~~~~~~~~~~~~~~~~~
>> include/linux/sched.h:2400:1: error: type defaults to 'int' in declaration of 'DECLARE_STATIC_KEY_FALSE' [-Werror=implicit-int]
>> include/linux/sched.h:2400:1: warning: parameter names (without types) in function declaration
   include/linux/sched.h: In function 'sched_core_disabled':
>> include/linux/sched.h:2403:17: error: implicit declaration of function 'static_branch_unlikely' [-Werror=implicit-function-declaration]
    2403 |         return !static_branch_unlikely(&__sched_core_enabled);
         |                 ^~~~~~~~~~~~~~~~~~~~~~
>> include/linux/sched.h:2403:41: error: '__sched_core_enabled' undeclared (first use in this function); did you mean 'sched_core_disabled'?
    2403 |         return !static_branch_unlikely(&__sched_core_enabled);
         |                                         ^~~~~~~~~~~~~~~~~~~~
         |                                         sched_core_disabled
   include/linux/sched.h:2403:41: note: each undeclared identifier is reported only once for each function it appears in
   arch/ia64/kernel/asm-offsets.c: At top level:
   arch/ia64/kernel/asm-offsets.c:23:6: warning: no previous prototype for 'foo' [-Wmissing-prototypes]
      23 | void foo(void)
         |      ^~~
   cc1: some warnings being treated as errors
   make[2]: *** [scripts/Makefile.build:120: arch/ia64/kernel/asm-offsets.s] Error 1
   make[2]: Target '__build' not remade because of errors.
   make[1]: *** [Makefile:1194: prepare0] Error 2
   make[1]: Target 'prepare' not remade because of errors.
   make: *** [Makefile:219: __sub-make] Error 2
   make: Target 'prepare' not remade because of errors.


vim +2400 include/linux/sched.h

  2394	
  2395	#ifdef CONFIG_SCHED_CORE
  2396	extern void sched_core_free(struct task_struct *tsk);
  2397	extern void sched_core_fork(struct task_struct *p);
  2398	extern int sched_core_share_pid(unsigned int cmd, pid_t pid, enum pid_type type,
  2399					unsigned long uaddr);
> 2400	DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
  2401	static inline bool sched_core_disabled(void)
  2402	{
> 2403		return !static_branch_unlikely(&__sched_core_enabled);
  2404	}
  2405	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
