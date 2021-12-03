Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16169467306
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 09:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379090AbhLCIF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 03:05:27 -0500
Received: from mga12.intel.com ([192.55.52.136]:28976 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350557AbhLCIF0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 03:05:26 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10186"; a="216953605"
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="216953605"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Dec 2021 00:02:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,283,1631602800"; 
   d="scan'208";a="501101674"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga007.jf.intel.com with ESMTP; 03 Dec 2021 00:02:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mt3W4-000HFy-JJ; Fri, 03 Dec 2021 08:02:00 +0000
Date:   Fri, 3 Dec 2021 16:01:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [agd5f:drm-next 189/190]
 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c:37:5: warning: no previous
 prototype for function 'amdgpu_profile_ioctl'
Message-ID: <202112031515.7czND0Ti-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   ee641f210a83efe4b32ea367555763e9a072d0f9
commit: aeae40911ee65eaebbba9ab6ded0a3da8e7ea8d5 [189/190] drm/amdgpu/UAPI: add new PROFILE IOCTL
config: i386-randconfig-r012-20211203 (https://download.01.org/0day-ci/archive/20211203/202112031515.7czND0Ti-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 1e328b06c15273edf4a40a27ca24931b5efb3a87)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout aeae40911ee65eaebbba9ab6ded0a3da8e7ea8d5
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/amd/amdgpu/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c:37:5: warning: no previous prototype for function 'amdgpu_profile_ioctl' [-Wmissing-prototypes]
   int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
       ^
   drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c:37:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
   ^
   static 
   1 warning generated.


vim +/amdgpu_profile_ioctl +37 drivers/gpu/drm/amd/amdgpu/amdgpu_profile.c

    26	
    27	/**
    28	 * amdgpu_profile_ioctl - Manages settings for profiling.
    29	 *
    30	 * @dev: drm device pointer
    31	 * @data: drm_amdgpu_vm
    32	 * @filp: drm file pointer
    33	 *
    34	 * Returns:
    35	 * 0 for success, -errno for errors.
    36	 */
  > 37	int amdgpu_profile_ioctl(struct drm_device *dev, void *data,
    38				 struct drm_file *filp)
    39	{
    40		union drm_amdgpu_profile *args = data;
    41		struct amdgpu_device *adev = drm_to_adev(dev);
    42		const struct amd_pm_funcs *pp_funcs = adev->powerplay.pp_funcs;
    43		enum amd_dpm_forced_level current_level, requested_level;
    44		int r;
    45	
    46		if (pp_funcs->get_performance_level)
    47			current_level = amdgpu_dpm_get_performance_level(adev);
    48		else
    49			current_level = adev->pm.dpm.forced_level;
    50	
    51		switch (args->in.op) {
    52		case AMDGPU_PROFILE_OP_GET_STABLE_PSTATE:
    53			if (args->in.flags)
    54				return -EINVAL;
    55			switch (current_level) {
    56			case AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD:
    57				args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD;
    58				break;
    59			case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK:
    60				args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK;
    61				break;
    62			case AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK:
    63				args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK;
    64				break;
    65			case AMD_DPM_FORCED_LEVEL_PROFILE_PEAK:
    66				args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK;
    67				break;
    68			default:
    69				args->out.flags = AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE;
    70				break;
    71			}
    72			break;
    73		case AMDGPU_PROFILE_OP_SET_STABLE_PSTATE:
    74			if (args->in.flags & ~AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK)
    75				return -EINVAL;
    76			switch (args->in.flags & AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MASK) {
    77			case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_STANDARD:
    78				requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_STANDARD;
    79				break;
    80			case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_SCLK:
    81				requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_SCLK;
    82				break;
    83			case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_MIN_MCLK:
    84				requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_MIN_MCLK;
    85				break;
    86			case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_PEAK:
    87				requested_level = AMD_DPM_FORCED_LEVEL_PROFILE_PEAK;
    88				break;
    89			case AMDGPU_PROFILE_FLAGS_STABLE_PSTATE_NONE:
    90				requested_level = AMD_DPM_FORCED_LEVEL_AUTO;
    91				break;
    92			default:
    93				return -EINVAL;
    94			}
    95	
    96			if ((current_level != requested_level) && pp_funcs->force_performance_level) {
    97				mutex_lock(&adev->pm.mutex);
    98				r = amdgpu_dpm_force_performance_level(adev, requested_level);
    99				if (!r)
   100					adev->pm.dpm.forced_level = requested_level;
   101				mutex_unlock(&adev->pm.mutex);
   102				if (r)
   103					return r;
   104			}
   105			break;
   106		default:
   107			return -EINVAL;
   108		}
   109	
   110		return 0;
   111	}
   112	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
