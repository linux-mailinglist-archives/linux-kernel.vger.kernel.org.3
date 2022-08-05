Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C609858B2AB
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 01:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbiHEXGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 19:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241715AbiHEXGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 19:06:17 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3676D7C189;
        Fri,  5 Aug 2022 16:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659740740; x=1691276740;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=No7nC8PIeuaUoN1nCFAreffB/gJ2AJPpBGbAJyjjlyY=;
  b=LxILr6egJph/VJMQaoEHURsfywWOGKz24NHJ3c7jp+UIW87nfMhKlZEA
   pc+W3tIgQ/ZB0nIenWzQgOKvNG5SS31g7Od2QYhJlwbZQMAV3/JQUtdvX
   /yYxfB+XTW38CjZlIPpp4fPyd8kOgaRGUmKCmSRRVRmaVnIrP7HhLhkZk
   Yo6z2/MKEVX77x5QuleCfFVltqVO+zJkpd3AHSyRMp1bgYkUWFa/LLEfD
   b3xTag+pVihjXgonjGCpLAZte8BiEcQ8BNWMxFZB3m2G3nvRKegtDcQ+W
   toVDBELDqOtzRTkCUy2tQEnweDISFsDNcghp7mPobn8WHrLY8WiSGwRDE
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10430"; a="316206197"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="316206197"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2022 16:05:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="779895308"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Aug 2022 16:05:35 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oK6Nq-000Jo3-3B;
        Fri, 05 Aug 2022 23:05:34 +0000
Date:   Sat, 6 Aug 2022 07:05:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Ben Dooks <ben.dooks@sifive.com>, linux-pwm@vger.kernel.org
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        u.kleine-koenig@pengutronix.de,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha --subject-prefix=PATCH v3 
        <jude.onyenegecha@sifive.com>, Ben Dooks <ben.dooks@sifive.com>
Subject: Re: [PATCH 4/8] pwm: dwc: add of/platform support
Message-ID: <202208060607.ojG964cE-lkp@intel.com>
References: <20220805165033.140958-5-ben.dooks@sifive.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805165033.140958-5-ben.dooks@sifive.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ben,

I love your patch! Yet something to improve:

[auto build test ERROR on thierry-reding-pwm/for-next]
[also build test ERROR on linus/master v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Ben-Dooks/dt-bindings-pwm-Document-Synopsys-DesignWare-snps-pwm-dw-apb-timers-pwm2/20220806-015142
base:   https://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git for-next
config: x86_64-randconfig-a002 (https://download.01.org/0day-ci/archive/20220806/202208060607.ojG964cE-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/3bd100d711908b7d16a2c4793b4f5b597acb8d7f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ben-Dooks/dt-bindings-pwm-Document-Synopsys-DesignWare-snps-pwm-dw-apb-timers-pwm2/20220806-015142
        git checkout 3bd100d711908b7d16a2c4793b4f5b597acb8d7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/pwm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/pwm/pwm-dwc.c:19:
   include/linux/module.h:131:49: error: redefinition of '__inittest'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:266:1: note: in expansion of macro 'module_init'
     266 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:264:9: note: in expansion of macro 'module_driver'
     264 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/pwm/pwm-dwc.c:369:1: note: in expansion of macro 'module_platform_driver'
     369 | module_platform_driver(dwc_pwm_plat_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:131:49: note: previous definition of '__inittest' with type 'int (*(void))(void)'
     131 |         static inline initcall_t __maybe_unused __inittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:266:1: note: in expansion of macro 'module_init'
     266 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/pci.h:1481:9: note: in expansion of macro 'module_driver'
    1481 |         module_driver(__pci_driver, pci_register_driver, pci_unregister_driver)
         |         ^~~~~~~~~~~~~
   drivers/pwm/pwm-dwc.c:321:1: note: in expansion of macro 'module_pci_driver'
     321 | module_pci_driver(dwc_pwm_driver);
         | ^~~~~~~~~~~~~~~~~
   include/linux/module.h:133:13: error: redefinition of 'init_module'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/device/driver.h:266:1: note: in expansion of macro 'module_init'
     266 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/platform_device.h:264:9: note: in expansion of macro 'module_driver'
     264 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/pwm/pwm-dwc.c:369:1: note: in expansion of macro 'module_platform_driver'
     369 | module_platform_driver(dwc_pwm_plat_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:133:13: note: previous definition of 'init_module' with type 'int(void)'
     133 |         int init_module(void) __copy(initfn)                    \
         |             ^~~~~~~~~~~
   include/linux/device/driver.h:266:1: note: in expansion of macro 'module_init'
     266 | module_init(__driver##_init); \
         | ^~~~~~~~~~~
   include/linux/pci.h:1481:9: note: in expansion of macro 'module_driver'
    1481 |         module_driver(__pci_driver, pci_register_driver, pci_unregister_driver)
         |         ^~~~~~~~~~~~~
   drivers/pwm/pwm-dwc.c:321:1: note: in expansion of macro 'module_pci_driver'
     321 | module_pci_driver(dwc_pwm_driver);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/module.h:139:49: error: redefinition of '__exittest'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:271:1: note: in expansion of macro 'module_exit'
     271 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:264:9: note: in expansion of macro 'module_driver'
     264 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/pwm/pwm-dwc.c:369:1: note: in expansion of macro 'module_platform_driver'
     369 | module_platform_driver(dwc_pwm_plat_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:139:49: note: previous definition of '__exittest' with type 'void (*(void))(void)'
     139 |         static inline exitcall_t __maybe_unused __exittest(void)                \
         |                                                 ^~~~~~~~~~
   include/linux/device/driver.h:271:1: note: in expansion of macro 'module_exit'
     271 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/pci.h:1481:9: note: in expansion of macro 'module_driver'
    1481 |         module_driver(__pci_driver, pci_register_driver, pci_unregister_driver)
         |         ^~~~~~~~~~~~~
   drivers/pwm/pwm-dwc.c:321:1: note: in expansion of macro 'module_pci_driver'
     321 | module_pci_driver(dwc_pwm_driver);
         | ^~~~~~~~~~~~~~~~~
>> include/linux/module.h:141:14: error: redefinition of 'cleanup_module'
     141 |         void cleanup_module(void) __copy(exitfn)                \
         |              ^~~~~~~~~~~~~~
   include/linux/device/driver.h:271:1: note: in expansion of macro 'module_exit'
     271 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/platform_device.h:264:9: note: in expansion of macro 'module_driver'
     264 |         module_driver(__platform_driver, platform_driver_register, \
         |         ^~~~~~~~~~~~~
   drivers/pwm/pwm-dwc.c:369:1: note: in expansion of macro 'module_platform_driver'
     369 | module_platform_driver(dwc_pwm_plat_driver);
         | ^~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:141:14: note: previous definition of 'cleanup_module' with type 'void(void)'
     141 |         void cleanup_module(void) __copy(exitfn)                \
         |              ^~~~~~~~~~~~~~
   include/linux/device/driver.h:271:1: note: in expansion of macro 'module_exit'
     271 | module_exit(__driver##_exit);
         | ^~~~~~~~~~~
   include/linux/pci.h:1481:9: note: in expansion of macro 'module_driver'
    1481 |         module_driver(__pci_driver, pci_register_driver, pci_unregister_driver)
         |         ^~~~~~~~~~~~~
   drivers/pwm/pwm-dwc.c:321:1: note: in expansion of macro 'module_pci_driver'
     321 | module_pci_driver(dwc_pwm_driver);
         | ^~~~~~~~~~~~~~~~~


vim +/__exittest +139 include/linux/module.h

0fd972a7d91d6e Paul Gortmaker 2015-05-01  128  
0fd972a7d91d6e Paul Gortmaker 2015-05-01  129  /* Each module must use one module_init(). */
0fd972a7d91d6e Paul Gortmaker 2015-05-01  130  #define module_init(initfn)					\
1f318a8bafcfba Arnd Bergmann  2017-02-01  131  	static inline initcall_t __maybe_unused __inittest(void)		\
0fd972a7d91d6e Paul Gortmaker 2015-05-01  132  	{ return initfn; }					\
cf68fffb66d60d Sami Tolvanen  2021-04-08  133  	int init_module(void) __copy(initfn)			\
cf68fffb66d60d Sami Tolvanen  2021-04-08  134  		__attribute__((alias(#initfn)));		\
cf68fffb66d60d Sami Tolvanen  2021-04-08  135  	__CFI_ADDRESSABLE(init_module, __initdata);
0fd972a7d91d6e Paul Gortmaker 2015-05-01  136  
0fd972a7d91d6e Paul Gortmaker 2015-05-01  137  /* This is only required if you want to be unloadable. */
0fd972a7d91d6e Paul Gortmaker 2015-05-01  138  #define module_exit(exitfn)					\
1f318a8bafcfba Arnd Bergmann  2017-02-01 @139  	static inline exitcall_t __maybe_unused __exittest(void)		\
0fd972a7d91d6e Paul Gortmaker 2015-05-01  140  	{ return exitfn; }					\
cf68fffb66d60d Sami Tolvanen  2021-04-08 @141  	void cleanup_module(void) __copy(exitfn)		\
cf68fffb66d60d Sami Tolvanen  2021-04-08  142  		__attribute__((alias(#exitfn)));		\
cf68fffb66d60d Sami Tolvanen  2021-04-08  143  	__CFI_ADDRESSABLE(cleanup_module, __exitdata);
0fd972a7d91d6e Paul Gortmaker 2015-05-01  144  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
