Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1BC54FB5B
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 18:46:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382549AbiFQQqp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 12:46:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234569AbiFQQqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 12:46:44 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B36E02898E;
        Fri, 17 Jun 2022 09:46:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655484402; x=1687020402;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2VC7mik9w+9dUx7rYCUaY4bTWFXVK+BGRfFpvu1g5bI=;
  b=F247KLP/eqCPlwQXpHGZXMTcqw8loBMKqafVkthrCYPP2AaWEapvSmuv
   AI6ncwgMLYkF0mqL4JFNi4nzZXPWXCyK6GPzPauV+1GZf7rbWs2qWZEeE
   SCSnEG57k2tsBaFHTTL9fZa1v/LcZwyhHPQ8osQ3zHylYKx2q48CpOamN
   b9gZmn2nQUISR22PotOH8bpGz2/IA18yA5N7ulM+Gq1wJe4TpLiXWCIkl
   X4xbrEwtjoKO7+guZB0/UTaqcqSlD/uG1m+bEs85dTLjFwvp2JyAVNiOe
   MaQuwhmH2Ql2J0xHsWtw0LSpoG6Q6iOKmVyLolDH0+3te5Mvnx4jIWWHe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="268229683"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="268229683"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jun 2022 09:05:53 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="763288840"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 17 Jun 2022 09:05:48 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o2ETj-000Pa9-JG;
        Fri, 17 Jun 2022 16:05:47 +0000
Date:   Sat, 18 Jun 2022 00:05:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        bjorn.andersson@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        quic_sbillaka@quicinc.com, linux-arm-msm@vger.kernel.org,
        quic_abhinavk@quicinc.com, Kuogee Hsieh <quic_khsieh@quicinc.com>,
        quic_aravindh@quicinc.com, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] drm/msm/dp: clean up pixel_rate from dp_ctrl.c
Message-ID: <202206172356.J5CB8zDf-lkp@intel.com>
References: <1655399361-10842-3-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655399361-10842-3-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuogee,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on drm-exynos/exynos-drm-next]
[cannot apply to drm-intel/for-linux-next tegra-drm/drm/tegra/for-next airlied/drm-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuogee-Hsieh/force-link-training-for-display-resolution-change/20220617-011110
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: hexagon-allmodconfig (https://download.01.org/0day-ci/archive/20220617/202206172356.J5CB8zDf-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f0e608de27b3d568000046eebf3712ab542979d6)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b04f0b39a03a9fc3728e9414157f9d5f0b8b2366
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kuogee-Hsieh/force-link-training-for-display-resolution-change/20220617-011110
        git checkout b04f0b39a03a9fc3728e9414157f9d5f0b8b2366
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/dp/dp_ctrl.c:1587:5: warning: no previous prototype for function 'dp_ctrl_on_stream_phy_test_report' [-Wmissing-prototypes]
   int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
       ^
   drivers/gpu/drm/msm/dp/dp_ctrl.c:1587:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
   ^
   static 
   1 warning generated.


vim +/dp_ctrl_on_stream_phy_test_report +1587 drivers/gpu/drm/msm/dp/dp_ctrl.c

  1586	
> 1587	int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
  1588	{
  1589		int ret = 0;
  1590		struct dp_ctrl_private *ctrl;
  1591		unsigned long pixel_rate;
  1592	
  1593		ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
  1594	
  1595		pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
  1596		ret = dp_ctrl_enable_stream_clocks(ctrl, pixel_rate);
  1597		if (ret) {
  1598			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
  1599			return ret;
  1600		}
  1601	
  1602		dp_ctrl_send_phy_test_pattern(ctrl);
  1603	
  1604		return 0;
  1605	}
  1606	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
