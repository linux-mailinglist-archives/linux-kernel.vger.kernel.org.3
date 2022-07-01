Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D7A5632ED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 13:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235753AbiGALvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 07:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235808AbiGALvp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 07:51:45 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D202983F1C;
        Fri,  1 Jul 2022 04:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656676304; x=1688212304;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=OLXHbADubhqmD0kqklxc8Slb/CATWcYqQM8m+MGGNRQ=;
  b=RRMU5MQKpuBC5ElQmQcvgkybCKMb/2ivDMv1wgy47FVCJQfbtHXV45pB
   lc0xWfFDoVsT1BbnSw/EED8nDGm8V7OkSZIq0uDF8mcnisdJ6tFItnU/P
   fSy59d8/eEEA/YLZ/Li9k0HOeWWM5jmHrbnqNfTcQuCQzctK0olLPjnCS
   Hub2qskSlMFFC78GkyFCo3uL4btC+tLV7L+nhS3Mg4Dx8OcXEsmYK3Avc
   knKxNfbCfVLBr8Ff84BgtqhECPciTVXHNjGC5WnWRVQvJfrUFRhPA5bq/
   DBqLCIrfYiHlrIJe3bvBnrTbs2prmHqZ67ui/rtXn9exqxQvJcREX+t+j
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="263034011"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="263034011"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 04:51:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="659407919"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 01 Jul 2022 04:51:42 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7FBW-000DuE-2R;
        Fri, 01 Jul 2022 11:51:42 +0000
Date:   Fri, 1 Jul 2022 19:50:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 05/10] rtc: cmos: Use `pm_suspend_preferred_s2idle`
Message-ID: <202207011940.s0fsRy23-lkp@intel.com>
References: <20220701023328.2783-5-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701023328.2783-5-mario.limonciello@amd.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on drm-misc/drm-misc-next hid/for-next linus/master v5.19-rc4 next-20220701]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Mario-Limonciello/PM-suspend-Introduce-pm_suspend_preferred_s2idle/20220701-103534
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: i386-randconfig-a001 (https://download.01.org/0day-ci/archive/20220701/202207011940.s0fsRy23-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/f5c9ad12802ecfaf2fc73e35ee9b563d7283b049
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/PM-suspend-Introduce-pm_suspend_preferred_s2idle/20220701-103534
        git checkout f5c9ad12802ecfaf2fc73e35ee9b563d7283b049
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/rtc/rtc-cmos.c: In function 'use_acpi_alarm_quirks':
>> drivers/rtc/rtc-cmos.c:1264:14: error: implicit declaration of function 'pm_suspend_preferred_s2idle'; did you mean 'pm_suspend_default_s2idle'? [-Werror=implicit-function-declaration]
    1264 |         if (!pm_suspend_preferred_s2idle())
         |              ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |              pm_suspend_default_s2idle
   cc1: some warnings being treated as errors


vim +1264 drivers/rtc/rtc-cmos.c

  1256	
  1257	#ifdef CONFIG_X86
  1258	/* Enable use_acpi_alarm mode for Intel platforms no earlier than 2015 */
  1259	static void use_acpi_alarm_quirks(void)
  1260	{
  1261		if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
  1262			return;
  1263	
> 1264		if (!pm_suspend_preferred_s2idle())
  1265			return;
  1266	
  1267		if (!is_hpet_enabled())
  1268			return;
  1269	
  1270		if (dmi_get_bios_year() < 2015)
  1271			return;
  1272	
  1273		use_acpi_alarm = true;
  1274	}
  1275	#else
  1276	static inline void use_acpi_alarm_quirks(void) { }
  1277	#endif
  1278	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
