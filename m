Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 73490466B42
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 21:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349038AbhLBVBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 16:01:09 -0500
Received: from mga09.intel.com ([134.134.136.24]:39267 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239259AbhLBVBG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 16:01:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10185"; a="236644341"
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="236644341"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Dec 2021 12:57:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,282,1631602800"; 
   d="scan'208";a="513356532"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 02 Dec 2021 12:57:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mst9B-000GgC-64; Thu, 02 Dec 2021 20:57:41 +0000
Date:   Fri, 3 Dec 2021 04:56:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Fangzhi Zuo <Jerry.Zuo@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: [agd5f:drm-next 150/190]
 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343: warning:
 expecting prototype for Return PCON's post FRL link training supported BW if
 its non(). Prototype was for intersect_frl_link_bw_support() instead
Message-ID: <202112030412.UAkTA3x7-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://gitlab.freedesktop.org/agd5f/linux.git drm-next
head:   ee641f210a83efe4b32ea367555763e9a072d0f9
commit: c022375ae0955b6d97ec438d658ab43a857a010f [150/190] drm/amd/display: Add DP-HDMI FRL PCON Support in DC
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20211203/202112030412.UAkTA3x7-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git remote add agd5f https://gitlab.freedesktop.org/agd5f/linux.git
        git fetch --no-tags agd5f drm-next
        git checkout c022375ae0955b6d97ec438d658ab43a857a010f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=powerpc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343: warning: Function parameter or member 'max_supported_frl_bw_in_kbps' not described in 'intersect_frl_link_bw_support'
   drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343: warning: Function parameter or member 'hdmi_encoded_link_bw' not described in 'intersect_frl_link_bw_support'
>> drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c:4343: warning: expecting prototype for Return PCON's post FRL link training supported BW if its non(). Prototype was for intersect_frl_link_bw_support() instead


vim +4343 drivers/gpu/drm/amd/amdgpu/../display/dc/core/dc_link_dp.c

  4336	
  4337	/**
  4338	 * Return PCON's post FRL link training supported BW if its non-zero, otherwise return max_supported_frl_bw.
  4339	 */
  4340	static uint32_t intersect_frl_link_bw_support(
  4341		const uint32_t max_supported_frl_bw_in_kbps,
  4342		const union hdmi_encoded_link_bw hdmi_encoded_link_bw)
> 4343	{
  4344		uint32_t supported_bw_in_kbps = max_supported_frl_bw_in_kbps;
  4345	
  4346		// HDMI_ENCODED_LINK_BW bits are only valid if HDMI Link Configuration bit is 1 (FRL mode)
  4347		if (hdmi_encoded_link_bw.bits.FRL_MODE) {
  4348			if (hdmi_encoded_link_bw.bits.BW_48Gbps)
  4349				supported_bw_in_kbps = 48000000;
  4350			else if (hdmi_encoded_link_bw.bits.BW_40Gbps)
  4351				supported_bw_in_kbps = 40000000;
  4352			else if (hdmi_encoded_link_bw.bits.BW_32Gbps)
  4353				supported_bw_in_kbps = 32000000;
  4354			else if (hdmi_encoded_link_bw.bits.BW_24Gbps)
  4355				supported_bw_in_kbps = 24000000;
  4356			else if (hdmi_encoded_link_bw.bits.BW_18Gbps)
  4357				supported_bw_in_kbps = 18000000;
  4358			else if (hdmi_encoded_link_bw.bits.BW_9Gbps)
  4359				supported_bw_in_kbps = 9000000;
  4360		}
  4361	
  4362		return supported_bw_in_kbps;
  4363	}
  4364	#endif
  4365	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
