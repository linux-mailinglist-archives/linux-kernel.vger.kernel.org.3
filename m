Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C972591D00
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 00:30:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiHMW3w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 18:29:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239807AbiHMW3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 18:29:36 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44DB261D46
        for <linux-kernel@vger.kernel.org>; Sat, 13 Aug 2022 15:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660429775; x=1691965775;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DZjr9G4ucd8jJdDQeBM7htSbac9Pmc0lmZx7Bm2IHlY=;
  b=EsqSL9sELJ0AGhUBKGHCFmd8NLKMoDC6duN/UWZg4OTc1n6dfrSGyqEB
   FRKzamkCV1p8KEbfI0HEK7+9w7HJxCoZy8K+looDMGl4IjcsYuzAwn/Er
   1uoyTn2R2E1lfghX1xJKfP5+jHJFpDvXInHV7YcmfZtJeyHPQUcyoj6CL
   Rc9ztUDh5Ta9NvfvvF/5X9kSqj4tBMWh1JrDjRrzpUpdgMHhYg/kp0GCq
   bVxQTHAlpEwpi2+rfXMZzZ5nle+BO442/jo/N7Xw6xVJlQUskBjTf4lxe
   6hhhf1IwHlqRVzsQursHgZB4siJKXOnkeXcjL6KelJoEUT+QhRuncF76t
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10437"; a="292576408"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="292576408"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2022 15:29:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="602824119"
Received: from lkp-server02.sh.intel.com (HELO 8745164cafc7) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 13 Aug 2022 15:29:32 -0700
Received: from kbuild by 8745164cafc7 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oMzdL-00029H-2e;
        Sat, 13 Aug 2022 22:29:31 +0000
Date:   Sun, 14 Aug 2022 06:29:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Zhang <zhangqing@loongson.cn>,
        Huacai Chen <chenhuacai@kernel.org>
Cc:     kbuild-all@lists.01.org, WANG Xuerui <kernel@xen0n.name>,
        loongarch@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jiaxun Yang <jiaxun.yang@flygoat.com>, hejinyang@loongson.cn,
        zhangqing@loongson.cn
Subject: Re: [PATCH 3/4] LoongArch: Add stacktrace support
Message-ID: <202208140621.UKarxp6n-lkp@intel.com>
References: <20220801121726.9681-4-zhangqing@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801121726.9681-4-zhangqing@loongson.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19]
[cannot apply to next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Qing-Zhang/LoongArch-Add-unwinder-support/20220801-204020
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 3d7cb6b04c3f3115719235cc6866b10326de34cd
config: loongarch-randconfig-s041-20220814 (https://download.01.org/0day-ci/archive/20220814/202208140621.UKarxp6n-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/102a43b57dafc9c0058a458a62d4133eb8020cbc
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qing-Zhang/LoongArch-Add-unwinder-support/20220801-204020
        git checkout 102a43b57dafc9c0058a458a62d4133eb8020cbc
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=loongarch SHELL=/bin/bash kernel/time/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

sparse warnings: (new ones prefixed by >>)
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got unsigned int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got unsigned int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *
>> kernel/time/tick-sched.c:1151:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *ptr @@     got int [noderef] __percpu * @@
   kernel/time/tick-sched.c:1151:9: sparse:     expected void *ptr
   kernel/time/tick-sched.c:1151:9: sparse:     got int [noderef] __percpu *

vim +1151 kernel/time/tick-sched.c

554c8aa8ecade2 Rafael J. Wysocki   2018-04-03  1141  
0e7767687fdabf Rafael J. Wysocki   2018-04-05  1142  /**
0e7767687fdabf Rafael J. Wysocki   2018-04-05  1143   * tick_nohz_idle_enter - prepare for entering idle on the current CPU
2bbb6817c0ac1b Frederic Weisbecker 2011-10-08  1144   *
0e7767687fdabf Rafael J. Wysocki   2018-04-05  1145   * Called when we start the idle loop.
280f06774afedf Frederic Weisbecker 2011-10-07  1146   */
1268fbc746ea1c Frederic Weisbecker 2011-11-17  1147  void tick_nohz_idle_enter(void)
280f06774afedf Frederic Weisbecker 2011-10-07  1148  {
280f06774afedf Frederic Weisbecker 2011-10-07  1149  	struct tick_sched *ts;
280f06774afedf Frederic Weisbecker 2011-10-07  1150  
ebf3adbad012b8 Frederic Weisbecker 2017-11-06 @1151  	lockdep_assert_irqs_enabled();
0db49b72bce263 Linus Torvalds      2012-01-06  1152  
1268fbc746ea1c Frederic Weisbecker 2011-11-17  1153  	local_irq_disable();
1268fbc746ea1c Frederic Weisbecker 2011-11-17  1154  
22127e93c587af Christoph Lameter   2014-08-17  1155  	ts = this_cpu_ptr(&tick_cpu_sched);
23a8d888107ce4 Rafael J. Wysocki   2018-04-05  1156  
23a8d888107ce4 Rafael J. Wysocki   2018-04-05  1157  	WARN_ON_ONCE(ts->timer_expires_base);
23a8d888107ce4 Rafael J. Wysocki   2018-04-05  1158  
280f06774afedf Frederic Weisbecker 2011-10-07  1159  	ts->inidle = 1;
0e7767687fdabf Rafael J. Wysocki   2018-04-05  1160  	tick_nohz_start_idle(ts);
1268fbc746ea1c Frederic Weisbecker 2011-11-17  1161  
1268fbc746ea1c Frederic Weisbecker 2011-11-17  1162  	local_irq_enable();
280f06774afedf Frederic Weisbecker 2011-10-07  1163  }
280f06774afedf Frederic Weisbecker 2011-10-07  1164  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
