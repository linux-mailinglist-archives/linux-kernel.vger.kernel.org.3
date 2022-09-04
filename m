Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17F3A5AC45F
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 15:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233370AbiIDNHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 09:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIDNHA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 09:07:00 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A75D2F66A
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 06:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662296818; x=1693832818;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6A4OjJMzJBygfQiNsLjRMXrJIX/atc5UieMQINHuyWI=;
  b=TerYjO55HdnfuBiZDqToCIj4Y0iwgcy3+KPWQeAICEm4mrBen/P25nMa
   dFiwlL6TyjCo3KZwekGScpJOnPwQKUzId2YTXwItkDUPaDagCmxl9NUD8
   KI/YzvGknQ6N5JRGHtIr4ERdvtAQpQTrP8InSm+9R+UbjsyDmEiLMdu1k
   /1w4upgOZQeckSI+ZR55vH5M9KJ80U/WRWF+xZtZfCRm4Lk+/58gMYBfN
   JBLIQdnr+qC36Nu4+yjAi8dOxj0JjxTOaMi3EQpU/Oh65btwddgQVYodd
   u2YU4j1868y9tvdyBTCS+2saWcewPxQmEBKEHRN3ai9HW/EGOLd8gxcso
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="382538813"
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="382538813"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 06:06:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,289,1654585200"; 
   d="scan'208";a="681773224"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 04 Sep 2022 06:06:55 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUpKw-000359-3B;
        Sun, 04 Sep 2022 13:06:54 +0000
Date:   Sun, 4 Sep 2022 21:05:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evgenii Stepanov <eugenis@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Peter Collingbourne <pcc@google.com>
Cc:     kbuild-all@lists.01.org, Kenny Root <kroot@google.com>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Evgenii Stepanov <eugenis@google.com>
Subject: Re: [PATCH v3] arm64: mte: move register initialization to C
Message-ID: <202209042051.7ivKujfl-lkp@intel.com>
References: <20220901211954.750634-1-eugenis@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220901211954.750634-1-eugenis@google.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evgenii,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on linus/master v6.0-rc3 next-20220901]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Evgenii-Stepanov/arm64-mte-move-register-initialization-to-C/20220902-052059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-randconfig-c033-20220904 (https://download.01.org/0day-ci/archive/20220904/202209042051.7ivKujfl-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/23927b7e78758b39d3463ae0a79b6b1af8fdef8b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Evgenii-Stepanov/arm64-mte-move-register-initialization-to-C/20220902-052059
        git checkout 23927b7e78758b39d3463ae0a79b6b1af8fdef8b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arch/arm64/kernel/suspend.c:34:13: warning: no previous prototype for 'cpu_suspend_set_dbg_restorer' [-Wmissing-prototypes]
      34 | void __init cpu_suspend_set_dbg_restorer(int (*hw_bp_restore)(unsigned int))
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   arch/arm64/kernel/suspend.c: In function '__cpu_suspend_exit':
>> arch/arm64/kernel/suspend.c:46:9: error: implicit declaration of function 'mte_suspend_exit'; did you mean 'mte_suspend_enter'? [-Werror=implicit-function-declaration]
      46 |         mte_suspend_exit();
         |         ^~~~~~~~~~~~~~~~
         |         mte_suspend_enter
   cc1: some warnings being treated as errors


vim +46 arch/arm64/kernel/suspend.c

    41	
    42	void notrace __cpu_suspend_exit(void)
    43	{
    44		unsigned int cpu = smp_processor_id();
    45	
  > 46		mte_suspend_exit();
    47	
    48		/*
    49		 * We are resuming from reset with the idmap active in TTBR0_EL1.
    50		 * We must uninstall the idmap and restore the expected MMU
    51		 * state before we can possibly return to userspace.
    52		 */
    53		cpu_uninstall_idmap();
    54	
    55		/* Restore CnP bit in TTBR1_EL1 */
    56		if (system_supports_cnp())
    57			cpu_replace_ttbr1(lm_alias(swapper_pg_dir), idmap_pg_dir);
    58	
    59		/*
    60		 * PSTATE was not saved over suspend/resume, re-enable any detected
    61		 * features that might not have been set correctly.
    62		 */
    63		__uaccess_enable_hw_pan();
    64	
    65		/*
    66		 * Restore HW breakpoint registers to sane values
    67		 * before debug exceptions are possibly reenabled
    68		 * by cpu_suspend()s local_daif_restore() call.
    69		 */
    70		if (hw_breakpoint_restore)
    71			hw_breakpoint_restore(cpu);
    72	
    73		/*
    74		 * On resume, firmware implementing dynamic mitigation will
    75		 * have turned the mitigation on. If the user has forcefully
    76		 * disabled it, make sure their wishes are obeyed.
    77		 */
    78		spectre_v4_enable_mitigation(NULL);
    79	
    80		/* Restore additional feature-specific configuration */
    81		ptrauth_suspend_exit();
    82	}
    83	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
