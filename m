Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66BF55B2256
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:32:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229812AbiIHPc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiIHPc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:32:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06BC2DF91;
        Thu,  8 Sep 2022 08:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662651144; x=1694187144;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hgS6CotZ3Q2j2e4c7OneYE8xCiB3LwVd0bcM6e338KU=;
  b=Z1yM4pYmVBJrf1NUvVMbZvrha2/FoFapo7+71Q43l3z7b9mxpLttCzCs
   sDf6XD1PTj+srU1XCOOzex2d1jAIfU7GfE8iRV4GLgGb/r6dUZYBCK0sg
   Jj6Jqn7koYWdYxYjtedUSJ2ynF33cooDECe+TDskL9gKjAQ1CkRrKF5QJ
   G9mxdLO9pS0a1HNjf+omEH8c8FMdlR94NS6Ze/npuaPEqFesr5XHF2Rlg
   O5QveMt19n9TgaQAsV5+c3sDtc+NuKFHEthmA4EFqR3oZQTKJ6ydFH/Jk
   9KlyX9iIh5z4qfPIMkK0jLZWOQ9UPMfFY+tS5zcviAUie1HoTmKTRK8Y/
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10464"; a="276951192"
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="276951192"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 08:32:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,300,1654585200"; 
   d="scan'208";a="614927447"
Received: from lkp-server02.sh.intel.com (HELO b2938d2e5c5a) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 08 Sep 2022 08:32:14 -0700
Received: from kbuild by b2938d2e5c5a with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oWJVm-00005N-10;
        Thu, 08 Sep 2022 15:32:14 +0000
Date:   Thu, 8 Sep 2022 23:31:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, peterz@infradead.org,
        acme@kernel.org, mark.rutland@arm.com, will@kernel.org,
        catalin.marinas@arm.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        James Clark <james.clark@arm.com>,
        Rob Herring <robh@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH V2 5/7] arm64/perf: Drive BRBE from perf event states
Message-ID: <202209082350.lDY2EvGx-lkp@intel.com>
References: <20220908051046.465307-6-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908051046.465307-6-anshuman.khandual@arm.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on acme/perf/core]
[also build test WARNING on tip/perf/core arm64/for-next/core linus/master v6.0-rc4 next-20220908]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220908-131425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf/core
config: arm64-randconfig-r025-20220907 (https://download.01.org/0day-ci/archive/20220908/202209082350.lDY2EvGx-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 1546df49f5a6d09df78f569e4137ddb365a3e827)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/5c7c07e050abb38b80d0c129fdef3a6f4b761017
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Anshuman-Khandual/arm64-perf-Enable-branch-stack-sampling/20220908-131425
        git checkout 5c7c07e050abb38b80d0c129fdef3a6f4b761017
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/perf/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/perf/arm_pmu.c:535:12: warning: stack frame size (2064) exceeds limit (2048) in 'armpmu_event_init' [-Wframe-larger-than]
   static int armpmu_event_init(struct perf_event *event)
              ^
   1 warning generated.


vim +/armpmu_event_init +535 drivers/perf/arm_pmu.c

1b8873a0c6ec51 arch/arm/kernel/perf_event.c Jamie Iles       2010-02-02  534  
b0a873ebbf87bf arch/arm/kernel/perf_event.c Peter Zijlstra   2010-06-11 @535  static int armpmu_event_init(struct perf_event *event)
1b8873a0c6ec51 arch/arm/kernel/perf_event.c Jamie Iles       2010-02-02  536  {
8a16b34e21199e arch/arm/kernel/perf_event.c Mark Rutland     2011-04-28  537  	struct arm_pmu *armpmu = to_arm_pmu(event->pmu);
1b8873a0c6ec51 arch/arm/kernel/perf_event.c Jamie Iles       2010-02-02  538  
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  539  	/*
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  540  	 * Reject CPU-affine events for CPUs that are of a different class to
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  541  	 * that which this PMU handles. Process-following events (where
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  542  	 * event->cpu == -1) can be migrated between CPUs, and thus we have to
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  543  	 * reject them later (in armpmu_add) if they're scheduled on a
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  544  	 * different class of CPU.
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  545  	 */
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  546  	if (event->cpu != -1 &&
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  547  		!cpumask_test_cpu(event->cpu, &armpmu->supported_cpus))
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  548  		return -ENOENT;
cc88116da0d18b arch/arm/kernel/perf_event.c Mark Rutland     2015-05-13  549  
2481c5fa6db023 arch/arm/kernel/perf_event.c Stephane Eranian 2012-02-09  550  	/* does not support taken branch sampling */
2481c5fa6db023 arch/arm/kernel/perf_event.c Stephane Eranian 2012-02-09  551  	if (has_branch_stack(event))
2481c5fa6db023 arch/arm/kernel/perf_event.c Stephane Eranian 2012-02-09  552  		return -EOPNOTSUPP;
2481c5fa6db023 arch/arm/kernel/perf_event.c Stephane Eranian 2012-02-09  553  
e1f431b57ef9e4 arch/arm/kernel/perf_event.c Mark Rutland     2011-04-28  554  	if (armpmu->map_event(event) == -ENOENT)
b0a873ebbf87bf arch/arm/kernel/perf_event.c Peter Zijlstra   2010-06-11  555  		return -ENOENT;
b0a873ebbf87bf arch/arm/kernel/perf_event.c Peter Zijlstra   2010-06-11  556  
c09adab01e4aee drivers/perf/arm_pmu.c       Mark Rutland     2017-03-10  557  	return __hw_perf_event_init(event);
1b8873a0c6ec51 arch/arm/kernel/perf_event.c Jamie Iles       2010-02-02  558  }
1b8873a0c6ec51 arch/arm/kernel/perf_event.c Jamie Iles       2010-02-02  559  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
