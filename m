Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2D054CADB3
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241405AbiCBShP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242995AbiCBShM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:37:12 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 822A6D8371
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:36:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1646246187; x=1677782187;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=P0U7Q/yazxD84c4kQUYlKKDrEeJF19pk8j8NIb7iKJU=;
  b=CsS42kZaV41VnaGg5+hBZVnIGNraSy9gqnhi4/bmujXjGG+JMEbUe+DS
   is1cOgoZtWTOapLsOKBm08o76ywxOIw+pPVT+EuLAPTx5OdlR70Xaq03n
   YkSdDrpE9R0Mf+oNK24Xb7hOkiQhu+tekK2j8cgoLKbt5rRYyE6BCVSjG
   /h9rs2rI+Iaae9iSE/e5/CgsddQm62oHJ4uKemBtsXEyhYZt3pfNxtO/s
   Lf7la4fkBdLX1VkTYMteetGTgs+MeaeCp8AiXXUIzmd8l4I678YEO3DxC
   DDiu2dy5G5Gecz7PIhNZrCmW+VF6JLoXr7QF+z2z8gv3oMh3NI3cvMRsT
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10274"; a="253670329"
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="253670329"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2022 10:36:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,149,1643702400"; 
   d="scan'208";a="508298794"
Received: from lkp-server02.sh.intel.com (HELO e9605edfa585) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 02 Mar 2022 10:36:22 -0800
Received: from kbuild by e9605edfa585 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nPTpl-0001ju-UR; Wed, 02 Mar 2022 18:36:21 +0000
Date:   Thu, 3 Mar 2022 02:35:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xuewei Zhang <xueweiz@google.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>
Subject: [linux-stable-rc:queue/4.9 3392/9999] kernel/sched/fair.c:4428:1:
 warning: the frame size of 1152 bytes is larger than 1024 bytes
Message-ID: <202203030251.fqUkx508-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xuewei,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git queue/4.9
head:   443d6630b05c3eaff71448a86e4b776194f317ef
commit: bdb6fa8234e59dfb1e0136352adf7684ac9c11af [3392/9999] sched/fair: Scale bandwidth quota and period without losing quota/period ratio precision
config: parisc-randconfig-r004-20220123 (https://download.01.org/0day-ci/archive/20220303/202203030251.fqUkx508-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 7.5.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit/?id=bdb6fa8234e59dfb1e0136352adf7684ac9c11af
        git remote add linux-stable-rc https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
        git fetch --no-tags linux-stable-rc queue/4.9
        git checkout bdb6fa8234e59dfb1e0136352adf7684ac9c11af
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-7.5.0 make.cross O=build_dir ARCH=parisc SHELL=/bin/bash kernel/sched/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   kernel/sched/fair.c: In function 'sched_cfs_period_timer':
>> kernel/sched/fair.c:4428:1: warning: the frame size of 1152 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    }
    ^


vim +4428 kernel/sched/fair.c

33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4376  
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4377  static enum hrtimer_restart sched_cfs_period_timer(struct hrtimer *timer)
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4378  {
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4379  	struct cfs_bandwidth *cfs_b =
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4380  		container_of(timer, struct cfs_bandwidth, period_timer);
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4381  	int overrun;
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4382  	int idle = 0;
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4383  	int count = 0;
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4384  
51f2176d74ace4c kernel/sched/fair.c Ben Segall     2014-05-19  4385  	raw_spin_lock(&cfs_b->lock);
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4386  	for (;;) {
77a4d1a1b9a122c kernel/sched/fair.c Peter Zijlstra 2015-04-15  4387  		overrun = hrtimer_forward_now(timer, cfs_b->period);
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4388  		if (!overrun)
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4389  			break;
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4390  
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4391  		if (++count > 3) {
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4392  			u64 new, old = ktime_to_ns(cfs_b->period);
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4393  
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4394  			/*
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4395  			 * Grow period by a factor of 2 to avoid losing precision.
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4396  			 * Precision loss in the quota/period ratio can cause __cfs_schedulable
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4397  			 * to fail.
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4398  			 */
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4399  			new = old * 2;
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4400  			if (new < max_cfs_quota_period) {
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4401  				cfs_b->period = ns_to_ktime(new);
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4402  				cfs_b->quota *= 2;
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4403  
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4404  				pr_warn_ratelimited(
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4405  	"cfs_period_timer[cpu%d]: period too short, scaling up (new cfs_period_us = %lld, cfs_quota_us = %lld)\n",
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4406  					smp_processor_id(),
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4407  					div_u64(new, NSEC_PER_USEC),
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4408  					div_u64(cfs_b->quota, NSEC_PER_USEC));
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4409  			} else {
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4410  				pr_warn_ratelimited(
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4411  	"cfs_period_timer[cpu%d]: period too short, but cannot scale up without losing precision (cfs_period_us = %lld, cfs_quota_us = %lld)\n",
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4412  					smp_processor_id(),
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4413  					div_u64(old, NSEC_PER_USEC),
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4414  					div_u64(cfs_b->quota, NSEC_PER_USEC));
bdb6fa8234e59df kernel/sched/fair.c Xuewei Zhang   2019-10-03  4415  			}
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4416  
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4417  			/* reset count so we don't come right back in here */
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4418  			count = 0;
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4419  		}
33f2a3e176bd508 kernel/sched/fair.c Phil Auld      2019-04-23  4420  
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4421  		idle = do_sched_cfs_period_timer(cfs_b, overrun);
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4422  	}
4cfafd3082afc70 kernel/sched/fair.c Peter Zijlstra 2015-05-14  4423  	if (idle)
4cfafd3082afc70 kernel/sched/fair.c Peter Zijlstra 2015-05-14  4424  		cfs_b->period_active = 0;
51f2176d74ace4c kernel/sched/fair.c Ben Segall     2014-05-19  4425  	raw_spin_unlock(&cfs_b->lock);
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4426  
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4427  	return idle ? HRTIMER_NORESTART : HRTIMER_RESTART;
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25 @4428  }
029632fbb7b7c9d kernel/sched_fair.c Peter Zijlstra 2011-10-25  4429  

:::::: The code at line 4428 was first introduced by commit
:::::: 029632fbb7b7c9d85063cc9eb470de6c54873df3 sched: Make separate sched*.c translation units

:::::: TO: Peter Zijlstra <a.p.zijlstra@chello.nl>
:::::: CC: Ingo Molnar <mingo@elte.hu>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
