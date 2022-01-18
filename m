Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75AA9491E05
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 04:47:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347531AbiARDqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 22:46:08 -0500
Received: from mga03.intel.com ([134.134.136.65]:21503 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1350999AbiARDog (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 22:44:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642477476; x=1674013476;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=JIZt+BBPCrKRvIyvCxVNyN5k2B+dinlbHL5UaLyC6RQ=;
  b=Ij50cIZpWxZv63wxarwthVkJqFKQUKvhedzFH5HkRET2rFQff9nOsIbM
   YyK+3Q0huHcSGsk0TjtiKlgZ32BMYtcX1MBZvt2RmefeD5RJMDS3YQ2bg
   ICuW3k6oV/WUPWiyXn5jGWxv0slQ6OjrZOuhZOGd/tRxTj77Ncq1k4dji
   wsVBMpu+bhKcQOHotHTlNjhWqTl8N1mXaS47wq4wo0j52uXSjDYV5V5Fp
   MP1Q0qPFwQ8gqzIQySWroeRrakz8D5A2YVjlBl8xvcdvKU6LUPf4CLQyc
   IF0s4EKsYjXa+p2rWWePKqpU41e21I7SBB2gKLGyUBPfkvLk7ST6oZQBF
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10230"; a="244690289"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="244690289"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 19:44:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="517611852"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 17 Jan 2022 19:44:00 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n9fPb-000C7i-Ng; Tue, 18 Jan 2022 03:43:59 +0000
Date:   Tue, 18 Jan 2022 11:43:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Alex Deucher <alexander.deucher@amd.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:2106:13:
 warning: stack frame size (2136) exceeds limit (2048) in
 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation'
Message-ID: <202201181113.zMONHfro-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0c947b893d69231a9add855939da7c66237ab44f
commit: 8fe44c080a53ac0ccbe88053a2e40f9acca33091 drm/amdgpu/display: fold DRM_AMD_DC_DCN3_1 into DRM_AMD_DC_DCN
date:   7 months ago
config: x86_64-randconfig-r004-20220117 (https://download.01.org/0day-ci/archive/20220118/202201181113.zMONHfro-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project c63a3175c2947e8c1a2d3bbe16a8586600705c54)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8fe44c080a53ac0ccbe88053a2e40f9acca33091
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 8fe44c080a53ac0ccbe88053a2e40f9acca33091
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:2106:13: warning: stack frame size (2136) exceeds limit (2048) in 'DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation' [-Wframe-larger-than]
   static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(struct display_mode_lib *mode_lib)
               ^
   drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c:3957:6: warning: stack frame size (3384) exceeds limit (2048) in 'dml31_ModeSupportAndSystemConfigurationFull' [-Wframe-larger-than]
   void dml31_ModeSupportAndSystemConfigurationFull(struct display_mode_lib *mode_lib)
        ^
   2 warnings generated.


vim +/DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation +2106 drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dcn31/display_mode_vba_31.c

74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2105  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19 @2106  static void DISPCLKDPPCLKDCFCLKDeepSleepPrefetchParametersWatermarksAndPerformanceCalculation(struct display_mode_lib *mode_lib)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2107  {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2108  	struct vba_vars_st *v = &mode_lib->vba;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2109  	unsigned int j, k;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2110  	double HostVMInefficiencyFactor = 1.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2111  	bool NoChromaPlanes = true;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2112  	int ReorderBytes;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2113  	double VMDataOnlyReturnBW;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2114  	double MaxTotalRDBandwidth = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2115  	int PrefetchMode = v->PrefetchModePerState[v->VoltageLevel][v->maxMpcComb];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2116  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2117  	v->WritebackDISPCLK = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2118  	v->DISPCLKWithRamping = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2119  	v->DISPCLKWithoutRamping = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2120  	v->GlobalDPPCLK = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2121  	/* DAL custom code: need to update ReturnBW in case min dcfclk is overriden */
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2122  	{
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2123  	double IdealFabricAndSDPPortBandwidthPerState = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2124  			v->ReturnBusWidth * v->DCFCLKState[v->VoltageLevel][v->maxMpcComb],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2125  			v->FabricClockPerState[v->VoltageLevel] * v->FabricDatapathToDCNDataReturn);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2126  	double IdealDRAMBandwidthPerState = v->DRAMSpeedPerState[v->VoltageLevel] * v->NumberOfChannels * v->DRAMChannelWidth;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2127  	if (v->HostVMEnable != true) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2128  		v->ReturnBW = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2129  				IdealFabricAndSDPPortBandwidthPerState * v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2130  				IdealDRAMBandwidthPerState * v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyPixelDataOnly / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2131  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2132  		v->ReturnBW = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2133  				IdealFabricAndSDPPortBandwidthPerState * v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2134  				IdealDRAMBandwidthPerState * v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyPixelMixedWithVMData / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2135  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2136  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2137  	/* End DAL custom code */
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2138  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2139  	// DISPCLK and DPPCLK Calculation
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2140  	//
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2141  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2142  		if (v->WritebackEnable[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2143  			v->WritebackDISPCLK = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2144  					v->WritebackDISPCLK,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2145  					dml31_CalculateWriteBackDISPCLK(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2146  							v->WritebackPixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2147  							v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2148  							v->WritebackHRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2149  							v->WritebackVRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2150  							v->WritebackHTaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2151  							v->WritebackVTaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2152  							v->WritebackSourceWidth[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2153  							v->WritebackDestinationWidth[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2154  							v->HTotal[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2155  							v->WritebackLineBufferSize));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2156  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2157  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2158  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2159  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2160  		if (v->HRatio[k] > 1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2161  			v->PSCL_THROUGHPUT_LUMA[k] = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2162  					v->MaxDCHUBToPSCLThroughput,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2163  					v->MaxPSCLToLBThroughput * v->HRatio[k] / dml_ceil(v->htaps[k] / 6.0, 1));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2164  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2165  			v->PSCL_THROUGHPUT_LUMA[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2166  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2167  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2168  		v->DPPCLKUsingSingleDPPLuma = v->PixelClock[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2169  				* dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2170  						v->vtaps[k] / 6.0 * dml_min(1.0, v->HRatio[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2171  						dml_max(v->HRatio[k] * v->VRatio[k] / v->PSCL_THROUGHPUT_LUMA[k], 1.0));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2172  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2173  		if ((v->htaps[k] > 6 || v->vtaps[k] > 6) && v->DPPCLKUsingSingleDPPLuma < 2 * v->PixelClock[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2174  			v->DPPCLKUsingSingleDPPLuma = 2 * v->PixelClock[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2175  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2176  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2177  		if ((v->SourcePixelFormat[k] != dm_420_8 && v->SourcePixelFormat[k] != dm_420_10 && v->SourcePixelFormat[k] != dm_420_12
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2178  				&& v->SourcePixelFormat[k] != dm_rgbe_alpha)) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2179  			v->PSCL_THROUGHPUT_CHROMA[k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2180  			v->DPPCLKUsingSingleDPP[k] = v->DPPCLKUsingSingleDPPLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2181  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2182  			if (v->HRatioChroma[k] > 1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2183  				v->PSCL_THROUGHPUT_CHROMA[k] = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2184  						v->MaxDCHUBToPSCLThroughput,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2185  						v->MaxPSCLToLBThroughput * v->HRatioChroma[k] / dml_ceil(v->HTAPsChroma[k] / 6.0, 1.0));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2186  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2187  				v->PSCL_THROUGHPUT_CHROMA[k] = dml_min(v->MaxDCHUBToPSCLThroughput, v->MaxPSCLToLBThroughput);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2188  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2189  			v->DPPCLKUsingSingleDPPChroma = v->PixelClock[k]
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2190  					* dml_max3(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2191  							v->VTAPsChroma[k] / 6.0 * dml_min(1.0, v->HRatioChroma[k]),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2192  							v->HRatioChroma[k] * v->VRatioChroma[k] / v->PSCL_THROUGHPUT_CHROMA[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2193  							1.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2194  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2195  			if ((v->HTAPsChroma[k] > 6 || v->VTAPsChroma[k] > 6) && v->DPPCLKUsingSingleDPPChroma < 2 * v->PixelClock[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2196  				v->DPPCLKUsingSingleDPPChroma = 2 * v->PixelClock[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2197  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2198  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2199  			v->DPPCLKUsingSingleDPP[k] = dml_max(v->DPPCLKUsingSingleDPPLuma, v->DPPCLKUsingSingleDPPChroma);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2200  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2201  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2202  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2203  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2204  		if (v->BlendingAndTiming[k] != k)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2205  			continue;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2206  		if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_4to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2207  			v->DISPCLKWithRamping = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2208  					v->DISPCLKWithRamping,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2209  					v->PixelClock[k] / 4 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2210  							* (1 + v->DISPCLKRampingMargin / 100));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2211  			v->DISPCLKWithoutRamping = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2212  					v->DISPCLKWithoutRamping,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2213  					v->PixelClock[k] / 4 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2214  		} else if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_2to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2215  			v->DISPCLKWithRamping = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2216  					v->DISPCLKWithRamping,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2217  					v->PixelClock[k] / 2 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2218  							* (1 + v->DISPCLKRampingMargin / 100));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2219  			v->DISPCLKWithoutRamping = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2220  					v->DISPCLKWithoutRamping,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2221  					v->PixelClock[k] / 2 * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2222  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2223  			v->DISPCLKWithRamping = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2224  					v->DISPCLKWithRamping,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2225  					v->PixelClock[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100) * (1 + v->DISPCLKRampingMargin / 100));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2226  			v->DISPCLKWithoutRamping = dml_max(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2227  					v->DISPCLKWithoutRamping,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2228  					v->PixelClock[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2229  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2230  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2231  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2232  	v->DISPCLKWithRamping = dml_max(v->DISPCLKWithRamping, v->WritebackDISPCLK);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2233  	v->DISPCLKWithoutRamping = dml_max(v->DISPCLKWithoutRamping, v->WritebackDISPCLK);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2234  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2235  	ASSERT(v->DISPCLKDPPCLKVCOSpeed != 0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2236  	v->DISPCLKWithRampingRoundedToDFSGranularity = RoundToDFSGranularityUp(v->DISPCLKWithRamping, v->DISPCLKDPPCLKVCOSpeed);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2237  	v->DISPCLKWithoutRampingRoundedToDFSGranularity = RoundToDFSGranularityUp(v->DISPCLKWithoutRamping, v->DISPCLKDPPCLKVCOSpeed);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2238  	v->MaxDispclkRoundedToDFSGranularity = RoundToDFSGranularityDown(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2239  			v->soc.clock_limits[v->soc.num_states - 1].dispclk_mhz,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2240  			v->DISPCLKDPPCLKVCOSpeed);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2241  	if (v->DISPCLKWithoutRampingRoundedToDFSGranularity > v->MaxDispclkRoundedToDFSGranularity) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2242  		v->DISPCLK_calculated = v->DISPCLKWithoutRampingRoundedToDFSGranularity;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2243  	} else if (v->DISPCLKWithRampingRoundedToDFSGranularity > v->MaxDispclkRoundedToDFSGranularity) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2244  		v->DISPCLK_calculated = v->MaxDispclkRoundedToDFSGranularity;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2245  	} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2246  		v->DISPCLK_calculated = v->DISPCLKWithRampingRoundedToDFSGranularity;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2247  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2248  	v->DISPCLK = v->DISPCLK_calculated;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2249  	DTRACE("   dispclk_mhz (calculated) = %f", v->DISPCLK_calculated);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2250  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2251  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2252  		v->DPPCLK_calculated[k] = v->DPPCLKUsingSingleDPP[k] / v->DPPPerPlane[k] * (1 + v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2253  		v->GlobalDPPCLK = dml_max(v->GlobalDPPCLK, v->DPPCLK_calculated[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2254  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2255  	v->GlobalDPPCLK = RoundToDFSGranularityUp(v->GlobalDPPCLK, v->DISPCLKDPPCLKVCOSpeed);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2256  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2257  		v->DPPCLK_calculated[k] = v->GlobalDPPCLK / 255 * dml_ceil(v->DPPCLK_calculated[k] * 255.0 / v->GlobalDPPCLK, 1);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2258  		DTRACE("   dppclk_mhz[%i] (calculated) = %f", k, v->DPPCLK_calculated[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2259  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2260  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2261  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2262  		v->DPPCLK[k] = v->DPPCLK_calculated[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2263  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2264  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2265  	// Urgent and B P-State/DRAM Clock Change Watermark
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2266  	DTRACE("   dcfclk_mhz         = %f", v->DCFCLK);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2267  	DTRACE("   return_bus_bw      = %f", v->ReturnBW);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2268  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2269  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2270  		CalculateBytePerPixelAnd256BBlockSizes(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2271  				v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2272  				v->SurfaceTiling[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2273  				&v->BytePerPixelY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2274  				&v->BytePerPixelC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2275  				&v->BytePerPixelDETY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2276  				&v->BytePerPixelDETC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2277  				&v->BlockHeight256BytesY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2278  				&v->BlockHeight256BytesC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2279  				&v->BlockWidth256BytesY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2280  				&v->BlockWidth256BytesC[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2281  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2282  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2283  	CalculateSwathWidth(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2284  			false,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2285  			v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2286  			v->SourcePixelFormat,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2287  			v->SourceScan,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2288  			v->ViewportWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2289  			v->ViewportHeight,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2290  			v->SurfaceWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2291  			v->SurfaceWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2292  			v->SurfaceHeightY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2293  			v->SurfaceHeightC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2294  			v->ODMCombineEnabled,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2295  			v->BytePerPixelY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2296  			v->BytePerPixelC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2297  			v->BlockHeight256BytesY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2298  			v->BlockHeight256BytesC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2299  			v->BlockWidth256BytesY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2300  			v->BlockWidth256BytesC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2301  			v->BlendingAndTiming,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2302  			v->HActive,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2303  			v->HRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2304  			v->DPPPerPlane,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2305  			v->SwathWidthSingleDPPY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2306  			v->SwathWidthSingleDPPC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2307  			v->SwathWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2308  			v->SwathWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2309  			v->dummyinteger3,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2310  			v->dummyinteger4,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2311  			v->swath_width_luma_ub,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2312  			v->swath_width_chroma_ub);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2313  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2314  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2315  		v->ReadBandwidthPlaneLuma[k] = v->SwathWidthSingleDPPY[k] * v->BytePerPixelY[k] / (v->HTotal[k] / v->PixelClock[k])
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2316  				* v->VRatio[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2317  		v->ReadBandwidthPlaneChroma[k] = v->SwathWidthSingleDPPC[k] * v->BytePerPixelC[k] / (v->HTotal[k] / v->PixelClock[k])
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2318  				* v->VRatioChroma[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2319  		DTRACE("   read_bw[%i] = %fBps", k, v->ReadBandwidthPlaneLuma[k] + v->ReadBandwidthPlaneChroma[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2320  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2321  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2322  	// DCFCLK Deep Sleep
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2323  	CalculateDCFCLKDeepSleep(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2324  			mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2325  			v->NumberOfActivePlanes,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2326  			v->BytePerPixelY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2327  			v->BytePerPixelC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2328  			v->VRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2329  			v->VRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2330  			v->SwathWidthY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2331  			v->SwathWidthC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2332  			v->DPPPerPlane,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2333  			v->HRatio,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2334  			v->HRatioChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2335  			v->PixelClock,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2336  			v->PSCL_THROUGHPUT_LUMA,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2337  			v->PSCL_THROUGHPUT_CHROMA,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2338  			v->DPPCLK,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2339  			v->ReadBandwidthPlaneLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2340  			v->ReadBandwidthPlaneChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2341  			v->ReturnBusWidth,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2342  			&v->DCFCLKDeepSleep);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2343  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2344  	// DSCCLK
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2345  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2346  		if ((v->BlendingAndTiming[k] != k) || !v->DSCEnabled[k]) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2347  			v->DSCCLK_calculated[k] = 0.0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2348  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2349  			if (v->OutputFormat[k] == dm_420)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2350  				v->DSCFormatFactor = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2351  			else if (v->OutputFormat[k] == dm_444)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2352  				v->DSCFormatFactor = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2353  			else if (v->OutputFormat[k] == dm_n422)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2354  				v->DSCFormatFactor = 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2355  			else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2356  				v->DSCFormatFactor = 1;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2357  			if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_4to1)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2358  				v->DSCCLK_calculated[k] = v->PixelClockBackEnd[k] / 12 / v->DSCFormatFactor
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2359  						/ (1 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2360  			else if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_2to1)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2361  				v->DSCCLK_calculated[k] = v->PixelClockBackEnd[k] / 6 / v->DSCFormatFactor
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2362  						/ (1 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2363  			else
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2364  				v->DSCCLK_calculated[k] = v->PixelClockBackEnd[k] / 3 / v->DSCFormatFactor
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2365  						/ (1 - v->DISPCLKDPPCLKDSCCLKDownSpreading / 100);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2366  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2367  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2368  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2369  	// DSC Delay
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2370  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2371  		double BPP = v->OutputBpp[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2372  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2373  		if (v->DSCEnabled[k] && BPP != 0) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2374  			if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_disabled) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2375  				v->DSCDelay[k] = dscceComputeDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2376  						v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2377  						BPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2378  						dml_ceil((double) v->HActive[k] / v->NumberOfDSCSlices[k], 1),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2379  						v->NumberOfDSCSlices[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2380  						v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2381  						v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2382  			} else if (v->ODMCombineEnabled[k] == dm_odm_combine_mode_2to1) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2383  				v->DSCDelay[k] = 2
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2384  						* (dscceComputeDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2385  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2386  								BPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2387  								dml_ceil((double) v->HActive[k] / v->NumberOfDSCSlices[k], 1),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2388  								v->NumberOfDSCSlices[k] / 2.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2389  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2390  								v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2391  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2392  				v->DSCDelay[k] = 4
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2393  						* (dscceComputeDelay(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2394  								v->DSCInputBitPerComponent[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2395  								BPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2396  								dml_ceil((double) v->HActive[k] / v->NumberOfDSCSlices[k], 1),
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2397  								v->NumberOfDSCSlices[k] / 4.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2398  								v->OutputFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2399  								v->Output[k]) + dscComputeDelay(v->OutputFormat[k], v->Output[k]));
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2400  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2401  			v->DSCDelay[k] = v->DSCDelay[k] * v->PixelClock[k] / v->PixelClockBackEnd[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2402  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2403  			v->DSCDelay[k] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2404  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2405  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2406  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2407  	for (k = 0; k < v->NumberOfActivePlanes; ++k)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2408  		for (j = 0; j < v->NumberOfActivePlanes; ++j) // NumberOfPlanes
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2409  			if (j != k && v->BlendingAndTiming[k] == j && v->DSCEnabled[j])
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2410  				v->DSCDelay[k] = v->DSCDelay[j];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2411  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2412  	// Prefetch
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2413  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2414  		unsigned int PDEAndMetaPTEBytesFrameY;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2415  		unsigned int PixelPTEBytesPerRowY;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2416  		unsigned int MetaRowByteY;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2417  		unsigned int MetaRowByteC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2418  		unsigned int PDEAndMetaPTEBytesFrameC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2419  		unsigned int PixelPTEBytesPerRowC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2420  		bool PTEBufferSizeNotExceededY;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2421  		bool PTEBufferSizeNotExceededC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2422  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2423  		if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2424  				|| v->SourcePixelFormat[k] == dm_rgbe_alpha) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2425  			if ((v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12) && v->SourceScan[k] != dm_vert) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2426  				v->PTEBufferSizeInRequestsForLuma = (v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma) / 2;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2427  				v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsForLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2428  			} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2429  				v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2430  				v->PTEBufferSizeInRequestsForChroma = v->PTEBufferSizeInRequestsChroma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2431  			}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2432  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2433  			PDEAndMetaPTEBytesFrameC = CalculateVMAndRowBytes(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2434  					mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2435  					v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2436  					v->BlockHeight256BytesC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2437  					v->BlockWidth256BytesC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2438  					v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2439  					v->SurfaceTiling[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2440  					v->BytePerPixelC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2441  					v->SourceScan[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2442  					v->SwathWidthC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2443  					v->ViewportHeightChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2444  					v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2445  					v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2446  					v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2447  					v->GPUVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2448  					v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2449  					v->PTEBufferSizeInRequestsForChroma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2450  					v->PitchC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2451  					v->DCCMetaPitchC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2452  					&v->MacroTileWidthC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2453  					&MetaRowByteC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2454  					&PixelPTEBytesPerRowC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2455  					&PTEBufferSizeNotExceededC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2456  					&v->dpte_row_width_chroma_ub[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2457  					&v->dpte_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2458  					&v->meta_req_width_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2459  					&v->meta_req_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2460  					&v->meta_row_width_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2461  					&v->meta_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2462  					&v->dummyinteger1,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2463  					&v->dummyinteger2,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2464  					&v->PixelPTEReqWidthC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2465  					&v->PixelPTEReqHeightC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2466  					&v->PTERequestSizeC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2467  					&v->dpde0_bytes_per_frame_ub_c[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2468  					&v->meta_pte_bytes_per_frame_ub_c[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2469  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2470  			v->PrefetchSourceLinesC[k] = CalculatePrefetchSourceLines(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2471  					mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2472  					v->VRatioChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2473  					v->VTAPsChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2474  					v->Interlace[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2475  					v->ProgressiveToInterlaceUnitInOPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2476  					v->SwathHeightC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2477  					v->ViewportYStartC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2478  					&v->VInitPreFillC[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2479  					&v->MaxNumSwathC[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2480  		} else {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2481  			v->PTEBufferSizeInRequestsForLuma = v->PTEBufferSizeInRequestsLuma + v->PTEBufferSizeInRequestsChroma;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2482  			v->PTEBufferSizeInRequestsForChroma = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2483  			PixelPTEBytesPerRowC = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2484  			PDEAndMetaPTEBytesFrameC = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2485  			MetaRowByteC = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2486  			v->MaxNumSwathC[k] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2487  			v->PrefetchSourceLinesC[k] = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2488  		}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2489  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2490  		PDEAndMetaPTEBytesFrameY = CalculateVMAndRowBytes(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2491  				mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2492  				v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2493  				v->BlockHeight256BytesY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2494  				v->BlockWidth256BytesY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2495  				v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2496  				v->SurfaceTiling[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2497  				v->BytePerPixelY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2498  				v->SourceScan[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2499  				v->SwathWidthY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2500  				v->ViewportHeight[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2501  				v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2502  				v->HostVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2503  				v->HostVMMaxNonCachedPageTableLevels,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2504  				v->GPUVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2505  				v->HostVMMinPageSize,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2506  				v->PTEBufferSizeInRequestsForLuma,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2507  				v->PitchY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2508  				v->DCCMetaPitchY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2509  				&v->MacroTileWidthY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2510  				&MetaRowByteY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2511  				&PixelPTEBytesPerRowY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2512  				&PTEBufferSizeNotExceededY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2513  				&v->dpte_row_width_luma_ub[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2514  				&v->dpte_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2515  				&v->meta_req_width[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2516  				&v->meta_req_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2517  				&v->meta_row_width[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2518  				&v->meta_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2519  				&v->vm_group_bytes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2520  				&v->dpte_group_bytes[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2521  				&v->PixelPTEReqWidthY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2522  				&v->PixelPTEReqHeightY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2523  				&v->PTERequestSizeY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2524  				&v->dpde0_bytes_per_frame_ub_l[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2525  				&v->meta_pte_bytes_per_frame_ub_l[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2526  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2527  		v->PrefetchSourceLinesY[k] = CalculatePrefetchSourceLines(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2528  				mode_lib,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2529  				v->VRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2530  				v->vtaps[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2531  				v->Interlace[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2532  				v->ProgressiveToInterlaceUnitInOPP,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2533  				v->SwathHeightY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2534  				v->ViewportYStartY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2535  				&v->VInitPreFillY[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2536  				&v->MaxNumSwathY[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2537  		v->PixelPTEBytesPerRow[k] = PixelPTEBytesPerRowY + PixelPTEBytesPerRowC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2538  		v->PDEAndMetaPTEBytesFrame[k] = PDEAndMetaPTEBytesFrameY + PDEAndMetaPTEBytesFrameC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2539  		v->MetaRowByte[k] = MetaRowByteY + MetaRowByteC;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2540  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2541  		CalculateRowBandwidth(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2542  				v->GPUVMEnable,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2543  				v->SourcePixelFormat[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2544  				v->VRatio[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2545  				v->VRatioChroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2546  				v->DCCEnable[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2547  				v->HTotal[k] / v->PixelClock[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2548  				MetaRowByteY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2549  				MetaRowByteC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2550  				v->meta_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2551  				v->meta_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2552  				PixelPTEBytesPerRowY,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2553  				PixelPTEBytesPerRowC,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2554  				v->dpte_row_height[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2555  				v->dpte_row_height_chroma[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2556  				&v->meta_row_bw[k],
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2557  				&v->dpte_row_bw[k]);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2558  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2559  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2560  	v->TotalDCCActiveDPP = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2561  	v->TotalActiveDPP = 0;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2562  	for (k = 0; k < v->NumberOfActivePlanes; ++k) {
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2563  		v->TotalActiveDPP = v->TotalActiveDPP + v->DPPPerPlane[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2564  		if (v->DCCEnable[k])
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2565  			v->TotalDCCActiveDPP = v->TotalDCCActiveDPP + v->DPPPerPlane[k];
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2566  		if (v->SourcePixelFormat[k] == dm_420_8 || v->SourcePixelFormat[k] == dm_420_10 || v->SourcePixelFormat[k] == dm_420_12
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2567  				|| v->SourcePixelFormat[k] == dm_rgbe_alpha)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2568  			NoChromaPlanes = false;
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2569  	}
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2570  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2571  	ReorderBytes = v->NumberOfChannels
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2572  			* dml_max3(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2573  					v->UrgentOutOfOrderReturnPerChannelPixelDataOnly,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2574  					v->UrgentOutOfOrderReturnPerChannelPixelMixedWithVMData,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2575  					v->UrgentOutOfOrderReturnPerChannelVMDataOnly);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2576  
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2577  	VMDataOnlyReturnBW = dml_min(
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2578  			dml_min(v->ReturnBusWidth * v->DCFCLK, v->FabricClock * v->FabricDatapathToDCNDataReturn)
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2579  					* v->PercentOfIdealFabricAndSDPPortBWReceivedAfterUrgLatency / 100.0,
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2580  			v->DRAMSpeed * v->NumberOfChannels * v->DRAMChannelWidth
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2581  					* v->PercentOfIdealDRAMBWReceivedAfterUrgLatencyVMDataOnly / 100.0);
74458c081fcfb0 Nicholas Kazlauskas 2021-05-19  2582  

:::::: The code at line 2106 was first introduced by commit
:::::: 74458c081fcfb0423877e630de2746daefdb16e4 drm/amd/display: Add DCN3.1 DML calculation support

:::::: TO: Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
:::::: CC: Alex Deucher <alexander.deucher@amd.com>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
