Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141A44EA596
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 04:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbiC2C6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 22:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229598AbiC2C62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 22:58:28 -0400
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40DA1C8D82
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 19:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648522605; x=1680058605;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Kn+nu2KMp61HXUAJqF8cVr2PTvTqBGDY5M/lzJLyoCE=;
  b=RdBA2QJ4qjxRI7A7eyoS9NY1oH3ZqRWfJGNvnl2bXIwSYxB1wC1NmK4W
   56BJ2bYycAuh3t7ikjeBytjLVgsEYetts2lrVeA/bZcexTqq9J2FYn3BL
   xdBpMF6ecQvFPXBOQE1bQhPvUFRV5ahyQyY7JpwqpStReQdu9QKucX0OA
   DRSxRBpJtO1JSAL7J+E306Lbc8VeNwTYA0V3TXk+jLYxadVaKVK3/+3AJ
   KUO3K3BRT9EZfHU7IdSIYzhkbXOxGgu0usuip1s3Hl7GaYZ/yllM9Vy/l
   6HY4zzO4X3IHuVXQlXyYUICGjjKGcMz19DpKwMbFYWmIXSUJYs2U0RTcJ
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10300"; a="319847275"
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="319847275"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2022 19:56:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,219,1643702400"; 
   d="scan'208";a="546199147"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 28 Mar 2022 19:56:43 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nZ22E-0002ZG-Te; Tue, 29 Mar 2022 02:56:42 +0000
Date:   Tue, 29 Mar 2022 10:56:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Evan Quan <evan.quan@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c:1641
 kv_get_acp_boot_level() warn: always true condition '(table->entries[i]->clk
 >= 0) => (0-u32max >= 0)'
Message-ID: <202203291016.neaMEWPm-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   1930a6e739c4b4a654a69164dbe39e554d228915
commit: 837d542a09cd533055423dfca7e621a9c1d13c5b drm/amd/pm: relocate the power related headers
date:   2 months ago
config: riscv-randconfig-m031-20220327 (https://download.01.org/0day-ci/archive/20220329/202203291016.neaMEWPm-lkp@intel.com/config)
compiler: riscv32-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c:1641 kv_get_acp_boot_level() warn: always true condition '(table->entries[i]->clk >= 0) => (0-u32max >= 0)'

vim +1641 drivers/gpu/drm/amd/amdgpu/../pm/legacy-dpm/kv_dpm.c

a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1633  
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1634  static u8 kv_get_acp_boot_level(struct amdgpu_device *adev)
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1635  {
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1636  	u8 i;
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1637  	struct amdgpu_clock_voltage_dependency_table *table =
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1638  		&adev->pm.dpm.dyn_state.acp_clock_voltage_dependency_table;
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1639  
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1640  	for (i = 0; i < table->count; i++) {
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20 @1641  		if (table->entries[i].clk >= 0) /* XXX */
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1642  			break;
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1643  	}
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1644  
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1645  	if (i >= table->count)
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1646  		i = table->count - 1;
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1647  
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1648  	return i;
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1649  }
a2e73f56fa6282 drivers/gpu/drm/amd/amdgpu/kv_dpm.c Alex Deucher 2015-04-20  1650  

:::::: The code at line 1641 was first introduced by commit
:::::: a2e73f56fa6282481927ec43aa9362c03c2e2104 drm/amdgpu: Add support for CIK parts

:::::: TO: Alex Deucher <alexander.deucher@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
