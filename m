Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5A46D17D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 11:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231971AbhLHLDO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 06:03:14 -0500
Received: from mga06.intel.com ([134.134.136.31]:64196 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229496AbhLHLDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 06:03:14 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10191"; a="298601313"
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="298601313"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Dec 2021 02:59:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,297,1631602800"; 
   d="scan'208";a="612054355"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 08 Dec 2021 02:59:41 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1muufk-0000Sg-7u; Wed, 08 Dec 2021 10:59:40 +0000
Date:   Wed, 8 Dec 2021 18:58:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: [andersson:wip/sm8350-next-20211118 46/51]
 drivers/gpu/drm/msm/dp/dp_display.c:420:6: warning: no previous prototype
 for function 'dp_display_oob_hotplug_event'
Message-ID: <202112081851.ZhEZUbXt-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/andersson/kernel wip/sm8350-next-20211118
head:   d4e3c3fe1bf25b7e421edef192756bee5bc1ffac
commit: 6cc13d7c2d774fa5b1c7f024ce7e1c7313af4a2f [46/51] drm/msm/dp: Wire up oob callback
config: hexagon-randconfig-r041-20211207 (https://download.01.org/0day-ci/archive/20211208/202112081851.ZhEZUbXt-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/andersson/kernel/commit/6cc13d7c2d774fa5b1c7f024ce7e1c7313af4a2f
        git remote add andersson https://github.com/andersson/kernel
        git fetch --no-tags andersson wip/sm8350-next-20211118
        git checkout 6cc13d7c2d774fa5b1c7f024ce7e1c7313af4a2f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/dp/dp_display.c:420:6: warning: no previous prototype for function 'dp_display_oob_hotplug_event' [-Wmissing-prototypes]
   void dp_display_oob_hotplug_event(struct msm_dp *dp_display)
        ^
   drivers/gpu/drm/msm/dp/dp_display.c:420:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void dp_display_oob_hotplug_event(struct msm_dp *dp_display)
   ^
   static 
   1 warning generated.


vim +/dp_display_oob_hotplug_event +420 drivers/gpu/drm/msm/dp/dp_display.c

   419	
 > 420	void dp_display_oob_hotplug_event(struct msm_dp *dp_display)
   421	{
   422		struct dp_display_private *dp;
   423		static bool current_state;
   424	
   425		dp = container_of(dp_display, struct dp_display_private, dp_display);
   426	
   427		printk(KERN_ERR "=================================== %s() hpd_state: %d current_state: %d\n", __func__, dp->hpd_state, current_state);
   428	
   429		if (!current_state) {
   430			dp_display_host_init(dp, false);
   431			dp_display_process_hpd_high(dp);
   432		} else {
   433			dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
   434		}
   435	
   436		current_state = !current_state;
   437	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
