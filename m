Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6F2446B1F4
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 05:36:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236219AbhLGEkU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 23:40:20 -0500
Received: from mga17.intel.com ([192.55.52.151]:49885 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236121AbhLGEkT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 23:40:19 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10190"; a="218177453"
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="218177453"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2021 20:36:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,293,1631602800"; 
   d="scan'208";a="679289237"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 06 Dec 2021 20:36:46 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muSDd-000MAl-RV; Tue, 07 Dec 2021 04:36:45 +0000
Date:   Tue, 7 Dec 2021 12:35:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Leo Li <sunpeng.li@amd.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Harry Wentland <Harry.Wentland@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:139:6:
 warning: no previous prototype for 'optc1_set_vupdate_keepout'
Message-ID: <202112071212.9wkItxOL-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Leo,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   cd8c917a56f20f48748dd43d9ae3caff51d5b987
commit: 9df857f930d6035996d481b4e5bc9ce082990afb drm/amd/display: Move vupdate keepout programming from DCN20 to DCN10
date:   8 months ago
config: i386-buildonly-randconfig-r002-20211205 (https://download.01.org/0day-ci/archive/20211207/202112071212.9wkItxOL-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=9df857f930d6035996d481b4e5bc9ce082990afb
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout 9df857f930d6035996d481b4e5bc9ce082990afb
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/gpu/drm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:139:6: warning: no previous prototype for 'optc1_set_vupdate_keepout' [-Wmissing-prototypes]
     139 | void optc1_set_vupdate_keepout(struct timing_generator *optc,
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:879:6: warning: no previous prototype for 'optc1_setup_manual_trigger' [-Wmissing-prototypes]
     879 | void optc1_setup_manual_trigger(struct timing_generator *optc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c:897:6: warning: no previous prototype for 'optc1_program_manual_trigger' [-Wmissing-prototypes]
     897 | void optc1_program_manual_trigger(struct timing_generator *optc)
         |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/optc1_set_vupdate_keepout +139 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn10/dcn10_optc.c

   133	
   134	/**
   135	 * Vupdate keepout can be set to a window to block the update lock for that pipe from changing.
   136	 * Start offset begins with vstartup and goes for x number of clocks,
   137	 * end offset starts from end of vupdate to x number of clocks.
   138	 */
 > 139	void optc1_set_vupdate_keepout(struct timing_generator *optc,
   140				       struct vupdate_keepout_params *params)
   141	{
   142		struct optc *optc1 = DCN10TG_FROM_TG(optc);
   143	
   144		REG_SET_3(OTG_VUPDATE_KEEPOUT, 0,
   145			  MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_START_OFFSET, params->start_offset,
   146			  MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_END_OFFSET, params->end_offset,
   147			  OTG_MASTER_UPDATE_LOCK_VUPDATE_KEEPOUT_EN, params->enable);
   148	}
   149	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
