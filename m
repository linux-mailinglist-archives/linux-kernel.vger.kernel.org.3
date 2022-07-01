Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 727F45633EE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 15:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236608AbiGANCx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 09:02:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiGANCs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 09:02:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A04043AE0;
        Fri,  1 Jul 2022 06:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656680567; x=1688216567;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uxWgnXDJDLxeqJd6HJODgjUp8PptkZ+c/9CcJyYl8cY=;
  b=ChWYLn0BPN0X8Nx15W1vggvS8sOgOn/tk6LVImD4uLQh98S/qG+ANkY6
   7gzcE1B9rqMytDhlsaBG3iYd+TkE00zDlnLDmSWxYXa6AmcA6KDtpXdGP
   Y6mV+kaZQBvxNJzhBCg2Fgv5CQd0KdUzMZTG7hXZxir8hWuX9r8mIsho7
   b09uhWAV6/VTrF85LwryJcMFAhH9QgGWH5rU0RUR1oTgRlt31dZA/aC1m
   bazb8Ki5zVlUsEYv7L7bp/dLG3l4hruYG/xtuuUQqkAipREUsc2LazZvw
   rvmQ/ju/dhmNNoFSdf15EQuRSD9jWlbb80WQeID8g/EiwQrwMRKXohQdv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="344331640"
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="344331640"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jul 2022 06:02:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,237,1650956400"; 
   d="scan'208";a="718618430"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 01 Jul 2022 06:02:45 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o7GIG-000Dwq-BL;
        Fri, 01 Jul 2022 13:02:44 +0000
Date:   Fri, 1 Jul 2022 21:01:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-pm@vger.kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 03/10] ACPI: LPIT: Use new
 `pm_suspend_preferred_s2idle`
Message-ID: <202207012033.3AjPSdQe-lkp@intel.com>
References: <20220701023328.2783-3-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220701023328.2783-3-mario.limonciello@amd.com>
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
config: x86_64-randconfig-a004 (https://download.01.org/0day-ci/archive/20220701/202207012033.3AjPSdQe-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/9603006925839aeb40b8a65adc7be87f4e89813f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Mario-Limonciello/PM-suspend-Introduce-pm_suspend_preferred_s2idle/20220701-103534
        git checkout 9603006925839aeb40b8a65adc7be87f4e89813f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/acpi/acpi_lpit.c: In function 'lpit_update_residency':
>> drivers/acpi/acpi_lpit.c:113:22: error: implicit declaration of function 'pm_suspend_preferred_s2idle'; did you mean 'pm_suspend_default_s2idle'? [-Werror=implicit-function-declaration]
     113 |                 if (!pm_suspend_preferred_s2idle())
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                      pm_suspend_default_s2idle
   drivers/acpi/acpi_lpit.c: At top level:
   drivers/acpi/acpi_lpit.c:149:6: warning: no previous prototype for 'acpi_init_lpit' [-Wmissing-prototypes]
     149 | void acpi_init_lpit(void)
         |      ^~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +113 drivers/acpi/acpi_lpit.c

    97	
    98	static void lpit_update_residency(struct lpit_residency_info *info,
    99					 struct acpi_lpit_native *lpit_native)
   100	{
   101		info->frequency = lpit_native->counter_frequency ?
   102					lpit_native->counter_frequency : tsc_khz * 1000;
   103		if (!info->frequency)
   104			info->frequency = 1;
   105	
   106		info->gaddr = lpit_native->residency_counter;
   107		if (info->gaddr.space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
   108			info->iomem_addr = ioremap(info->gaddr.address,
   109							   info->gaddr.bit_width / 8);
   110			if (!info->iomem_addr)
   111				return;
   112	
 > 113			if (!pm_suspend_preferred_s2idle())
   114				return;
   115	
   116			/* Silently fail, if cpuidle attribute group is not present */
   117			sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
   118						&dev_attr_low_power_idle_system_residency_us.attr,
   119						"cpuidle");
   120		} else if (info->gaddr.space_id == ACPI_ADR_SPACE_FIXED_HARDWARE) {
   121			if (!pm_suspend_preferred_s2idle())
   122				return;
   123	
   124			/* Silently fail, if cpuidle attribute group is not present */
   125			sysfs_add_file_to_group(&cpu_subsys.dev_root->kobj,
   126						&dev_attr_low_power_idle_cpu_residency_us.attr,
   127						"cpuidle");
   128		}
   129	}
   130	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
