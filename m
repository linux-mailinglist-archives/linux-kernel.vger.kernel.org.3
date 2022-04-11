Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D12424FC7EB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 00:58:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236305AbiDKXAl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 19:00:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiDKXAi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 19:00:38 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C23581A392
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 15:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649717902; x=1681253902;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4Z9VI6tEyTt8ATI/3X1UsbKKq6JOuVqvsq8x+y0yhEY=;
  b=l7SERkq6TNh66heLunYPzVxeZZDeD18TiJanQNUoTzCtf6UrF4syYxmg
   OMXrbi9v8gBOzYgFb0qxoiqnZitNUE2q35EvAUBeScZbwMf8gBnFLkkzw
   MkrrArHLuTE3D2a+8py3t+FVkNocZQg0IQ5fezJtAgE8BAnVLAgDtMPAZ
   wlN8aCGYBTZGOW68rH16I7cRE+2+g9aoVNJNtlgU6AL9egTbDzq7ZtzoX
   mLQnl9fV3f1E7fV4zNjezjXeIrQRcpdndDlZVdDWggWujrBx5/W+phBjt
   fMisIVMEMsOF/n9ueb3Axme4I1KCyvk2G2nlQXPphv1fdLzSUgwpGBe1T
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="325144854"
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="325144854"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2022 15:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,252,1643702400"; 
   d="scan'208";a="525761722"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2022 15:58:19 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ne2zC-0002IA-Ba;
        Mon, 11 Apr 2022 22:58:18 +0000
Date:   Tue, 12 Apr 2022 06:57:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Richard Gong <richard.gong@amd.com>, alexander.deucher@amd.com,
        christian.koenig@amd.com, xinhui.pan@amd.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     kbuild-all@lists.01.org, mario.limonciello@amd.com,
        richard.gong@amd.com, dri-devel@lists.freedesktop.org,
        amd-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2] drm/amdgpu: disable ASPM on Intel AlderLake based
 systems
Message-ID: <202204120618.4I6dOUw9-lkp@intel.com>
References: <20220408190502.4103670-1-richard.gong@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220408190502.4103670-1-richard.gong@amd.com>
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

Hi Richard,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Richard-Gong/drm-amdgpu-disable-ASPM-on-Intel-AlderLake-based-systems/20220409-030656
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: um-allmodconfig (https://download.01.org/0day-ci/archive/20220412/202204120618.4I6dOUw9-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-19) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/bb9a037cafa91918c2ece823591d1d04b812ae17
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Richard-Gong/drm-amdgpu-disable-ASPM-on-Intel-AlderLake-based-systems/20220409-030656
        git checkout bb9a037cafa91918c2ece823591d1d04b812ae17
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=um SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from arch/x86/um/asm/processor.h:41,
                    from include/linux/mutex.h:19,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/pci.h:35,
                    from drivers/gpu/drm/amd/amdgpu/vi.c:24:
   drivers/gpu/drm/amd/amdgpu/vi.c: In function 'intel_core_apsm_chk':
   arch/um/include/asm/processor-generic.h:103:19: error: called object is not a function or function pointer
     103 | #define cpu_data (&boot_cpu_data)
         |                  ~^~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/vi.c:1144:34: note: in expansion of macro 'cpu_data'
    1144 |         struct cpuinfo_x86 *c = &cpu_data(0);
         |                                  ^~~~~~~~
>> drivers/gpu/drm/amd/amdgpu/vi.c:1146:18: error: invalid use of undefined type 'struct cpuinfo_x86'
    1146 |         return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
         |                  ^~
   drivers/gpu/drm/amd/amdgpu/vi.c:1146:33: error: invalid use of undefined type 'struct cpuinfo_x86'
    1146 |         return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
         |                                 ^~
   drivers/gpu/drm/amd/amdgpu/vi.c:1150:1: error: control reaches end of non-void function [-Werror=return-type]
    1150 | }
         | ^
   cc1: some warnings being treated as errors


vim +1146 drivers/gpu/drm/amd/amdgpu/vi.c

  1140	
  1141	static bool intel_core_apsm_chk(void)
  1142	{
  1143	#if IS_ENABLED(CONFIG_X86_64)
  1144		struct cpuinfo_x86 *c = &cpu_data(0);
  1145	
> 1146		return (c->x86 == 6 && c->x86_model == INTEL_FAM6_ALDERLAKE);
  1147	#else
  1148		return false;
  1149	#endif
  1150	}
  1151	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
