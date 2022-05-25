Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CA075346D9
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 00:53:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344589AbiEYWx0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 18:53:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbiEYWxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 18:53:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373E73B032
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 15:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653519202; x=1685055202;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=xRZkjue+NYRSyVMHA58RBzLEOZ3CAriez1sGrHWvVmg=;
  b=PqlxEltX7/l6OTU+BiWRPmfRE9Xq9+tD3r81LyCHTiw6YWtO4i7S6nY/
   pI44PH38AzidQhsiOnPMa7Q/U0BiOZoyfNmW1kBa0tMP1Urn44AkVHGIZ
   ExOjZ1N7NzAws8cjloCq8YJMcAlwaWD9BUlTBujtGPpKj73OEgc7rrEyy
   MX/SX2IjB0GR1RF1ychAiLM52Id3C0alTWghzj+SeE7L+sVNqGMRNh5s/
   Xn0sqmLO7Ku8IMKqPSoYyc5xUSzoQRodtTsZwIG76g4X1I4ahtDUuehX6
   +R3hPCujO/tbrwhsKiTPbIo3irwRU7vzgIKOwKC13rSHzu6PiSH9hizhk
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10358"; a="360346412"
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="360346412"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 15:53:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,252,1647327600"; 
   d="scan'208";a="609402163"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 May 2022 15:53:20 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntzsV-0003NU-FZ;
        Wed, 25 May 2022 22:53:19 +0000
Date:   Thu, 26 May 2022 06:53:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: [frederic-dynticks:cpuset/nocb 1/4] include/linux/cpumask.h:636:26:
 warning: passing argument 1 of 'rcu_nocb_cpumask_update' discards 'const'
 qualifier from pointer target type
Message-ID: <202205260631.a3Mk6u8a-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git cpuset/nocb
head:   ad895c0b6a5e3c41d46f184900d193e70bfc90d3
commit: 25db09cc1131b612d5dbb474ea1640b90b2518ca [1/4] rcu/nocb: Pass a cpumask instead of a single CPU to offload/deoffload
config: mips-allyesconfig (https://download.01.org/0day-ci/archive/20220526/202205260631.a3Mk6u8a-lkp@intel.com/config)
compiler: mips-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git/commit/?id=25db09cc1131b612d5dbb474ea1640b90b2518ca
        git remote add frederic-dynticks https://git.kernel.org/pub/scm/linux/kernel/git/frederic/linux-dynticks.git
        git fetch --no-tags frederic-dynticks cpuset/nocb
        git checkout 25db09cc1131b612d5dbb474ea1640b90b2518ca
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash kernel/rcu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/smp.h:13,
                    from arch/mips/include/asm/cpu-type.h:12,
                    from arch/mips/include/asm/timex.h:19,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from kernel/rcu/rcutorture.c:18:
   kernel/rcu/rcutorture.c: In function 'rcu_nocb_toggle':
>> include/linux/cpumask.h:636:26: warning: passing argument 1 of 'rcu_nocb_cpumask_update' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     636 | #define cpumask_of(cpu) (get_cpu_mask(cpu))
         |                         ~^~~~~~~~~~~~~~~~~~
   kernel/rcu/rcutorture.c:1890:49: note: in expansion of macro 'cpumask_of'
    1890 |                         rcu_nocb_cpumask_update(cpumask_of(cpu), true);
         |                                                 ^~~~~~~~~~
   In file included from include/linux/rbtree.h:24,
                    from include/linux/mm_types.h:11,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from kernel/rcu/rcutorture.c:18:
   include/linux/rcupdate.h:117:45: note: expected 'struct cpumask *' but argument is of type 'const struct cpumask *'
     117 | int rcu_nocb_cpumask_update(struct cpumask *cpumask, bool offload);
         |                             ~~~~~~~~~~~~~~~~^~~~~~~
   In file included from include/linux/smp.h:13,
                    from arch/mips/include/asm/cpu-type.h:12,
                    from arch/mips/include/asm/timex.h:19,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from kernel/rcu/rcutorture.c:18:
>> include/linux/cpumask.h:636:26: warning: passing argument 1 of 'rcu_nocb_cpumask_update' discards 'const' qualifier from pointer target type [-Wdiscarded-qualifiers]
     636 | #define cpumask_of(cpu) (get_cpu_mask(cpu))
         |                         ~^~~~~~~~~~~~~~~~~~
   kernel/rcu/rcutorture.c:1893:49: note: in expansion of macro 'cpumask_of'
    1893 |                         rcu_nocb_cpumask_update(cpumask_of(cpu), false);
         |                                                 ^~~~~~~~~~
   In file included from include/linux/rbtree.h:24,
                    from include/linux/mm_types.h:11,
                    from include/linux/buildid.h:5,
                    from include/linux/module.h:14,
                    from kernel/rcu/rcutorture.c:18:
   include/linux/rcupdate.h:117:45: note: expected 'struct cpumask *' but argument is of type 'const struct cpumask *'
     117 | int rcu_nocb_cpumask_update(struct cpumask *cpumask, bool offload);
         |                             ~~~~~~~~~~~~~~~~^~~~~~~


vim +636 include/linux/cpumask.h

2d3854a37e8b767 Rusty Russell 2008-11-05  631  
cd83e42c6b0413d Rusty Russell 2008-11-07  632  /**
cd83e42c6b0413d Rusty Russell 2008-11-07  633   * cpumask_of - the cpumask containing just a given cpu
cd83e42c6b0413d Rusty Russell 2008-11-07  634   * @cpu: the cpu (<= nr_cpu_ids)
cd83e42c6b0413d Rusty Russell 2008-11-07  635   */
cd83e42c6b0413d Rusty Russell 2008-11-07 @636  #define cpumask_of(cpu) (get_cpu_mask(cpu))
cd83e42c6b0413d Rusty Russell 2008-11-07  637  

:::::: The code at line 636 was first introduced by commit
:::::: cd83e42c6b0413dcbb548c2ead799111ff7e6a13 cpumask: new API, v2

:::::: TO: Rusty Russell <rusty@rustcorp.com.au>
:::::: CC: Ingo Molnar <mingo@elte.hu>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
