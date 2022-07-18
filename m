Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1A25789D2
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 20:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235750AbiGRSxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 14:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235810AbiGRSxL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 14:53:11 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 325242F38D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658170390; x=1689706390;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ab0HUQfAeEYeW51NOZq+L53z0lf+uFBUJSdHTLaTBzQ=;
  b=dU9HmotrN5ZzDcW37hgC9KsA6feoJDhSXReUznDzrAepv+c2u7K61STK
   1TydAb+b41we2wk3j/piyL1GbToRnjZ/rYYuezIOclzMw59Dxebbn9jEj
   hsBl6TxtU58HWmnnUSj6rfmFp75zHVYA5rPO75uNoypBAR1Tfj6FheMpq
   6fjnZmVO8rMh9iZ5CaeVq88Dq6ZThyf+cAKV4SzUp3C5+CFjQ2LubYBbE
   hr30VmYpWFNtIFCPNT3pckXU1lMUKaReoyyRt+XO+zeqezI0ItdsJdRdq
   0LbjlB0aUzbkILOqRLHsO6qBcBpPTZjQVhu7LHfPb3F3DP7QtlwpljtCG
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="347985674"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="347985674"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 11:53:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="665126077"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 18 Jul 2022 11:53:07 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDVrf-0004ef-1t;
        Mon, 18 Jul 2022 18:53:07 +0000
Date:   Tue, 19 Jul 2022 02:53:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Zhang <zhangpeng.00@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, bsegall@google.com,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        "zhangpeng.00" <zhangpeng.00@bytedance.com>
Subject: Re: [PATCH] sched/fair: optimize entity_tick()
Message-ID: <202207190234.1dmTZy65-lkp@intel.com>
References: <20220718094937.37360-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718094937.37360-1-zhangpeng.00@bytedance.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v5.19-rc7 next-20220718]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Zhang/sched-fair-optimize-entity_tick/20220718-175245
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 401e4963bf45c800e3e9ea0d3a0289d738005fd4
config: nios2-randconfig-s042-20220718 (https://download.01.org/0day-ci/archive/20220719/202207190234.1dmTZy65-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/9dec20bda1c5d0d7a203d393fc1ffa6e296579a9
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Zhang/sched-fair-optimize-entity_tick/20220718-175245
        git checkout 9dec20bda1c5d0d7a203d393fc1ffa6e296579a9
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/target/ kernel/sched/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
   kernel/sched/fair.c:927:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct sched_entity *se @@     got struct sched_entity [noderef] __rcu * @@
   kernel/sched/fair.c:927:34: sparse:     expected struct sched_entity *se
   kernel/sched/fair.c:927:34: sparse:     got struct sched_entity [noderef] __rcu *
>> kernel/sched/fair.c:4760:75: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct task_struct *tsk @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:4760:75: sparse:     expected struct task_struct *tsk
   kernel/sched/fair.c:4760:75: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:5663:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:5663:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:5663:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7232:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7232:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7232:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:7530:38: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct task_struct *curr @@     got struct task_struct [noderef] __rcu *curr @@
   kernel/sched/fair.c:7530:38: sparse:     expected struct task_struct *curr
   kernel/sched/fair.c:7530:38: sparse:     got struct task_struct [noderef] __rcu *curr
   kernel/sched/fair.c:5592:35: sparse: sparse: marked inline, but without a definition
   kernel/sched/fair.c: note: in included file:
   kernel/sched/sched.h:2053:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2210:9: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2210:9: sparse:    struct task_struct *
   kernel/sched/sched.h:2053:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct *
   kernel/sched/sched.h:2053:25: sparse: sparse: incompatible types in comparison expression (different address spaces):
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct [noderef] __rcu *
   kernel/sched/sched.h:2053:25: sparse:    struct task_struct *

vim +4760 kernel/sched/fair.c

  4759	
> 4760		if (cfs_rq->nr_running > 1 && !test_tsk_need_resched(rq_of(cfs_rq)->curr))
  4761			check_preempt_tick(cfs_rq, curr);
  4762	}
  4763	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
