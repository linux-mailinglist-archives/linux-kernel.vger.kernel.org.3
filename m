Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAA65886DC
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 07:44:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235873AbiHCFn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 01:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233757AbiHCFnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 01:43:55 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 120014333C
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 22:43:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659505434; x=1691041434;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=j14V2gi5DoHtAPyvxqS2p+5jVSeoHoji9A/I48YCA/g=;
  b=jMmFEzinZ9hL0yiZWPgi7BuHwOVgAV7/CrCyxfK4vfbe8numsBPfl8F3
   971+4GXgELHMPzfiPKEy42nDFJmPvyhufB/EncWxV3MjlFECRnokpuB28
   hwsnHVxaBocjytFvutTdT6rUSPHE53DmPsJ9bsEyt4Nj7I/x0dgO7tPNX
   og+dHpmPQ0whE89tcPC40JR/tiflnPWnrG898qAEqC380GSa4uSKrCwrQ
   QF6C56V8YlgJX2YyCj7HuddoyskSUnKHCCysRmAolQjF7MOWu4B4v9clU
   49zVWVsRQugdmXGRjQCRCZKBKyWHXQA6EBG+/xFHydhmcBPKu5A7MuTEv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="315445340"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="315445340"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 22:43:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="602698531"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 02 Aug 2022 22:43:51 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ7Ac-000Gsr-0z;
        Wed, 03 Aug 2022 05:43:50 +0000
Date:   Wed, 3 Aug 2022 13:43:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aaron Tomlin <atomlin@redhat.com>, frederic@kernel.org,
        mtosatti@redhat.com
Cc:     kbuild-all@lists.01.org, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v5 2/2] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <202208031315.Wwa9w3jr-lkp@intel.com>
References: <20220801234258.134609-3-atomlin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220801234258.134609-3-atomlin@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aaron,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19 next-20220802]
[cannot apply to tip/timers/nohz]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Aaron-Tomlin/tick-sched-Ensure-quiet_vmstat-is-called-when-the-idle-tick-was-stopped-too/20220802-074341
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 9de1f9c8ca5100a02a2e271bdbde36202e251b4b
config: x86_64-randconfig-a016-20220801 (https://download.01.org/0day-ci/archive/20220803/202208031315.Wwa9w3jr-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/a0d3b9fe31484c4c44c430d10d0b60e2e0551525
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aaron-Tomlin/tick-sched-Ensure-quiet_vmstat-is-called-when-the-idle-tick-was-stopped-too/20220802-074341
        git checkout a0d3b9fe31484c4c44c430d10d0b60e2e0551525
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   ld: vmlinux.o: in function `exit_to_user_mode_loop':
>> kernel/entry/common.c:182: undefined reference to `tick_nohz_user_enter_prepare'
   ld: vmlinux.o: in function `exit_to_user_mode_prepare':
   kernel/entry/common.c:198: undefined reference to `tick_nohz_user_enter_prepare'


vim +182 kernel/entry/common.c

a9f3a74a29af095 Thomas Gleixner     2020-07-22  144  
a9f3a74a29af095 Thomas Gleixner     2020-07-22  145  static unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
a9f3a74a29af095 Thomas Gleixner     2020-07-22  146  					    unsigned long ti_work)
a9f3a74a29af095 Thomas Gleixner     2020-07-22  147  {
a9f3a74a29af095 Thomas Gleixner     2020-07-22  148  	/*
a9f3a74a29af095 Thomas Gleixner     2020-07-22  149  	 * Before returning to user space ensure that all pending work
a9f3a74a29af095 Thomas Gleixner     2020-07-22  150  	 * items have been completed.
a9f3a74a29af095 Thomas Gleixner     2020-07-22  151  	 */
a9f3a74a29af095 Thomas Gleixner     2020-07-22  152  	while (ti_work & EXIT_TO_USER_MODE_WORK) {
a9f3a74a29af095 Thomas Gleixner     2020-07-22  153  
a9f3a74a29af095 Thomas Gleixner     2020-07-22  154  		local_irq_enable_exit_to_user(ti_work);
a9f3a74a29af095 Thomas Gleixner     2020-07-22  155  
a9f3a74a29af095 Thomas Gleixner     2020-07-22  156  		if (ti_work & _TIF_NEED_RESCHED)
a9f3a74a29af095 Thomas Gleixner     2020-07-22  157  			schedule();
a9f3a74a29af095 Thomas Gleixner     2020-07-22  158  
a9f3a74a29af095 Thomas Gleixner     2020-07-22  159  		if (ti_work & _TIF_UPROBE)
a9f3a74a29af095 Thomas Gleixner     2020-07-22  160  			uprobe_notify_resume(regs);
a9f3a74a29af095 Thomas Gleixner     2020-07-22  161  
a9f3a74a29af095 Thomas Gleixner     2020-07-22  162  		if (ti_work & _TIF_PATCH_PENDING)
a9f3a74a29af095 Thomas Gleixner     2020-07-22  163  			klp_update_patch_state(current);
a9f3a74a29af095 Thomas Gleixner     2020-07-22  164  
12db8b690010ccf Jens Axboe          2020-10-26  165  		if (ti_work & (_TIF_SIGPENDING | _TIF_NOTIFY_SIGNAL))
8ba62d37949e248 Eric W. Biederman   2022-02-09  166  			arch_do_signal_or_restart(regs);
a9f3a74a29af095 Thomas Gleixner     2020-07-22  167  
a68de80f61f6af3 Sean Christopherson 2021-09-01  168  		if (ti_work & _TIF_NOTIFY_RESUME)
03248addadf1a5e Eric W. Biederman   2022-02-09  169  			resume_user_mode_work(regs);
a9f3a74a29af095 Thomas Gleixner     2020-07-22  170  
a9f3a74a29af095 Thomas Gleixner     2020-07-22  171  		/* Architecture specific TIF work */
a9f3a74a29af095 Thomas Gleixner     2020-07-22  172  		arch_exit_to_user_mode_work(regs, ti_work);
a9f3a74a29af095 Thomas Gleixner     2020-07-22  173  
a9f3a74a29af095 Thomas Gleixner     2020-07-22  174  		/*
a9f3a74a29af095 Thomas Gleixner     2020-07-22  175  		 * Disable interrupts and reevaluate the work flags as they
a9f3a74a29af095 Thomas Gleixner     2020-07-22  176  		 * might have changed while interrupts and preemption was
a9f3a74a29af095 Thomas Gleixner     2020-07-22  177  		 * enabled above.
a9f3a74a29af095 Thomas Gleixner     2020-07-22  178  		 */
a9f3a74a29af095 Thomas Gleixner     2020-07-22  179  		local_irq_disable_exit_to_user();
47b8ff194c1fd73 Frederic Weisbecker 2021-02-01  180  
47b8ff194c1fd73 Frederic Weisbecker 2021-02-01  181  		/* Check if any of the above work has queued a deferred wakeup */
f268c3737ecaefc Frederic Weisbecker 2021-05-27 @182  		tick_nohz_user_enter_prepare();
47b8ff194c1fd73 Frederic Weisbecker 2021-02-01  183  
6ce895128b3bff7 Mark Rutland        2021-11-29  184  		ti_work = read_thread_flags();
a9f3a74a29af095 Thomas Gleixner     2020-07-22  185  	}
a9f3a74a29af095 Thomas Gleixner     2020-07-22  186  
a9f3a74a29af095 Thomas Gleixner     2020-07-22  187  	/* Return the latest work state for arch_exit_to_user_mode() */
a9f3a74a29af095 Thomas Gleixner     2020-07-22  188  	return ti_work;
a9f3a74a29af095 Thomas Gleixner     2020-07-22  189  }
a9f3a74a29af095 Thomas Gleixner     2020-07-22  190  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
