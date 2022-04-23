Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD9850C78D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 07:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233210AbiDWFV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 01:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiDWFVr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 01:21:47 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1DD8D6B1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 22:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650691131; x=1682227131;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GofBlrhL+rqrvpcKXz6vxE+/FzKcz+kTY1qvk15MVuY=;
  b=adFLrWuAhRqo9GiFZYuB4Hc7bA40v5twSyCwcRLrMdr/kYrV27rFrIq1
   tWh/j7Hv0Gn0GMFnEl3vN1znl3I4yW2zNm4EJniSnQxtoXwAWld54cAjB
   7RZOWhaQjY8OzjhdbPXm88azHT2xqwOrJcBwwUjKQYhjfCf7Qt6hKpuwO
   9XinpQ19/mL7HYP+LJo5Qhb4DBo19HmCs5/DB6KZ3GjuuBKZY2TJAPk2w
   x03AFhEuCLTQVcK+gwKKp+z/a/u0YgOa2LV5pTBkY75iJ5fXuIJbjwJfm
   cv0SfOHEPQCwMcIZwa3uW0eypyB3QF/gaFXK6C23FJSKqWmaPg6j82a/3
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="265021529"
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="265021529"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 22:18:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,283,1643702400"; 
   d="scan'208";a="563329939"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 22 Apr 2022 22:18:46 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ni8AP-000B2v-Jo;
        Sat, 23 Apr 2022 05:18:45 +0000
Date:   Sat, 23 Apr 2022 13:17:52 +0800
From:   kernel test robot <lkp@intel.com>
To:     Donghai Qiao <dqiao@redhat.com>, akpm@linux-foundation.org,
        sfr@canb.auug.org.au, arnd@arndb.de, peterz@infradead.org,
        heying24@huawei.com, andriy.shevchenko@linux.intel.com,
        axboe@kernel.dk, rdunlap@infradead.org, tglx@linutronix.de,
        gor@linux.ibm.com
Cc:     kbuild-all@lists.01.org, donghai.w.qiao@gmail.com,
        linux-kernel@vger.kernel.org, Donghai Qiao <dqiao@redhat.com>
Subject: Re: [PATCH v2 11/11] smp: modify up.c to adopt the same format of
 cross CPU call.
Message-ID: <202204231333.D1x82f1d-lkp@intel.com>
References: <20220422200040.93813-12-dqiao@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422200040.93813-12-dqiao@redhat.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Donghai,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on powerpc/next]
[also build test ERROR on rafael-pm/linux-next linus/master v5.18-rc3]
[cannot apply to tip/x86/core next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Donghai-Qiao/smp-cross-CPU-call-interface/20220423-060436
base:   https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git next
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220423/202204231333.D1x82f1d-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/655b898028ef1555f6bec036db8d4681b551aaa8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Donghai-Qiao/smp-cross-CPU-call-interface/20220423-060436
        git checkout 655b898028ef1555f6bec036db8d4681b551aaa8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/up.c: In function 'smp_call_mask':
>> kernel/up.c:50:18: error: 'cpu' undeclared (first use in this function); did you mean 'fpu'?
      50 |         smp_call(cpu, func, info, type);
         |                  ^~~
         |                  fpu
   kernel/up.c:50:18: note: each undeclared identifier is reported only once for each function it appears in
   kernel/up.c:44:23: warning: unused variable 'flags' [-Wunused-variable]
      44 |         unsigned long flags;
         |                       ^~~~~
   kernel/up.c: In function 'smp_call_mask_cond':
   kernel/up.c:80:26: error: 'cpu' undeclared (first use in this function); did you mean 'fpu'?
      80 |                 smp_call(cpu, func, info, type);
         |                          ^~~
         |                          fpu
   kernel/up.c:76:23: warning: unused variable 'flags' [-Wunused-variable]
      76 |         unsigned long flags;
         |                       ^~~~~
   In file included from include/linux/percpu.h:7,
                    from include/linux/context_tracking_state.h:5,
                    from include/linux/hardirq.h:5,
                    from include/linux/interrupt.h:11,
                    from kernel/up.c:6:
   At top level:
   include/linux/smp.h:131:14: warning: 'seq_type' defined but not used [-Wunused-variable]
     131 | static char *seq_type[] = {
         |              ^~~~~~~~


vim +50 kernel/up.c

    41	
    42	void smp_call_mask(const struct cpumask *mask, smp_call_func_t func, void *info, unsigned int type)
    43	{
    44		unsigned long flags;
    45	
    46		if (!cpumask_test_cpu(0, mask))
    47			return;
    48	
    49		preempt_disable();
  > 50		smp_call(cpu, func, info, type);
    51		preempt_enable();
    52	}
    53	EXPORT_SYMBOL(smp_call_mask);
    54	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
