Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 840474EA7FC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 08:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiC2Gep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 02:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbiC2Gen (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 02:34:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEC8199E0C;
        Mon, 28 Mar 2022 23:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648535581; x=1680071581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HAjzIPDUPCIXMGybDw6O6DfAGfp9ol1exT+WBflEwoI=;
  b=EAuh5622LmibLIpFj72SASHK1KH9R7gONKcD+pN7dH3aW7NkcnWxvq0m
   VwBySBGaKFNLnVWYov5MsXcNABGx9eMNZ6fUfyWdrgJgP+Q4MJ+KW+QlL
   wIunDw/XexJ9PADW71plVai7vBYXj0wBeqEajT5DwL4H376zM6o/BiUTl
   k4mPdeiq7yttQwqmj/z9+Hyc1oe7gvfGwoYNM0/MoCZ5i9BEcTg9EeMgG
   k56ouzF/FJXxG3Vo/9X4lvfKBtLkzyALRDFhjdWo0EF2+IdRAz06+P4HO
   t+dUWl6JD4NypGIKCui6n2zWCuwFse9psO7zhN6bgubFcbhxm2epREUnD
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="256750791"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="256750791"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 23:33:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="719404709"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 28 Mar 2022 23:32:59 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ5PW-0002kV-FH; Tue, 29 Mar 2022 06:32:58 +0000
Date:   Tue, 29 Mar 2022 14:32:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Huang Rui <ray.huang@amd.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        "open list:AMD PSTATE DRIVER" <linux-pm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2 1/3] cpufreq: Export acpu_cpufreq_exit for other
 drivers to call
Message-ID: <202203291402.XRbJXAas-lkp@intel.com>
References: <20220329015947.565-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329015947.565-2-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on rafael-pm/linux-next]
[also build test WARNING on v5.17 next-20220329]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mario-Limonciello/Improve-usability-for-amd-pstate/20220329-100211
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: x86_64-randconfig-a001 (https://download.01.org/0day-ci/archive/20220329/202203291402.XRbJXAas-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 0f6d9501cf49ce02937099350d08f20c4af86f3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/86835efc7d91d9fc921d7d425b1fdab9c13feafb
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mario-Limonciello/Improve-usability-for-amd-pstate/20220329-100211
        git checkout 86835efc7d91d9fc921d7d425b1fdab9c13feafb
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/cpufreq/acpi-cpufreq.c:1036:13: warning: no previous prototype for function 'acpi_cpufreq_exit' [-Wmissing-prototypes]
   void __exit acpi_cpufreq_exit(void)
               ^
   drivers/cpufreq/acpi-cpufreq.c:1036:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void __exit acpi_cpufreq_exit(void)
   ^
   static 
   1 warning generated.


vim +/acpi_cpufreq_exit +1036 drivers/cpufreq/acpi-cpufreq.c

  1035	
> 1036	void __exit acpi_cpufreq_exit(void)
  1037	{
  1038		pr_debug("%s\n", __func__);
  1039	
  1040		acpi_cpufreq_boost_exit();
  1041	
  1042		cpufreq_unregister_driver(&acpi_cpufreq_driver);
  1043	
  1044		free_acpi_perf_data();
  1045	}
  1046	EXPORT_SYMBOL_GPL(acpi_cpufreq_exit);
  1047	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
