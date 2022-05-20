Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DE752E11C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343957AbiETAVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343956AbiETAUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:20:55 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C274224BE0;
        Thu, 19 May 2022 17:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653006054; x=1684542054;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AX9u0AjfkhQIv902pkLIaB2pcFVPrNmehZjTGBz16NU=;
  b=mtdNsYRF+q2AdF6JvRpi9EUz8Qwia2g7y2xkHHWUnQGdev+VW+5yPics
   qubndh+n8FMLi9x+3hNsrUwl4LvDkA5nbVC/VsZYS2FCzIddNqF0jDAtS
   ebN+wsypSB6luy265BQy1d1Q5F6jati6qsXeYqY/XfEvMzdzpb0hPWChY
   ghH+vYtWAXId7tBjSdcb+oiNbdtQ8NusS+PAgAlLVPc6AjwRGRfPnc8jf
   HxMDcRhkdvfCVliekjAwSTxhse0S0ARg5QpvVsh69wpOh3zDbNgDz2tQe
   6l+yN1RyuExN57sa5jNkXgWJ24AnEY1oF4WcKwqZoDo/ndCEayA3n5Fwc
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10352"; a="272394418"
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="272394418"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 17:20:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,238,1647327600"; 
   d="scan'208";a="546392359"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 19 May 2022 17:20:48 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrqNs-000459-6h;
        Fri, 20 May 2022 00:20:48 +0000
Date:   Fri, 20 May 2022 08:20:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Meng Li <li.meng@amd.com>, Shuah Khan <skhan@linuxfoundation.org>,
        Huang Rui <ray.huang@amd.com>, linux-pm@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Nathan Fontenot <nathan.fontenot@amd.com>,
        Deepak Sharma <deepak.sharma@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Jinzhou Su <Jinzhou.Su@amd.com>,
        Perry Yuan <Perry.Yuan@amd.com>,
        Xiaojian Du <Xiaojian.Du@amd.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        Meng Li <li.meng@amd.com>
Subject: Re: [PATCH V6 2/4] cpufreq: amd-pstate: Add test module for
 amd-pstate driver
Message-ID: <202205200812.g9S1SWP3-lkp@intel.com>
References: <20220519134737.359290-3-li.meng@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519134737.359290-3-li.meng@amd.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Meng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on shuah-kselftest/next]
[also build test WARNING on rafael-pm/linux-next linux/master linus/master v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Meng-Li/Add-unit-test-module-for-AMD-P-State-driver/20220519-215444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest.git next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220520/202205200812.g9S1SWP3-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-1) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/5a00a68d142a32f76cf2e770d75463802273e7ed
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Meng-Li/Add-unit-test-module-for-AMD-P-State-driver/20220519-215444
        git checkout 5a00a68d142a32f76cf2e770d75463802273e7ed
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/cpufreq/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from arch/x86/include/asm/percpu.h:27,
                    from arch/x86/include/asm/current.h:6,
                    from arch/x86/include/asm/processor.h:17,
                    from arch/x86/include/asm/timex.h:5,
                    from include/linux/timex.h:65,
                    from include/linux/time32.h:13,
                    from include/linux/time.h:60,
                    from include/linux/stat.h:19,
                    from include/linux/module.h:13,
                    from include/../tools/testing/selftests/kselftest_module.h:5,
                    from drivers/cpufreq/amd-pstate-ut.c:23:
   drivers/cpufreq/amd-pstate-ut.c: In function 'get_shared_mem':
>> include/linux/kern_levels.h:5:25: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'ssize_t' {aka 'int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:418:25: note: in definition of macro 'printk_index_wrap'
     418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:489:9: note: in expansion of macro 'printk'
     489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:489:16: note: in expansion of macro 'KERN_ERR'
     489 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   drivers/cpufreq/amd-pstate-ut.c:83:33: note: in expansion of macro 'pr_err'
      83 |                                 pr_err("%s ret=%ld unable to read from param file!\n",
         |                                 ^~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
