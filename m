Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E40535990
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 08:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbiE0Goe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 02:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343946AbiE0GoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 02:44:23 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC62ED79D;
        Thu, 26 May 2022 23:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653633862; x=1685169862;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fQI6cbTw2kPlUwwHwJseatTgtASIlX3ZxniUjFCz3CU=;
  b=m+uFmTatl5ljLbRAdFa0qeCUAH1Ym5DaJdCvd7tVI7dbW+yPkC1Vq3Xu
   pHrU6HpNgo9fcAAxxUZhN1z37Az2vcAJHPSDyMxPUT2fVar5SuIBCBCv8
   PHAzPxX8z0In4qGunvaXFcaLBgDawS3/xrLN2DZBc8R2gbxBA/w6X1Dfd
   3RDJSniLYxaYZYDrfqmwH3B1MvHDPvMrYkmM6cYMC37pscP233rphuJGh
   i/a35KzyMnw4yoCw69b50JOztTDNJYcFfuWFjB50jcjI/LMnKWTWVJt2h
   3SbeJXFMsfJTA0mAIUNahQfzJjHcsnVW6OgZpwh7+Hf+aNAz+28F4Jyzq
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10359"; a="254892679"
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="254892679"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 May 2022 23:44:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,254,1647327600"; 
   d="scan'208";a="718706904"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 26 May 2022 23:44:18 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nuThp-0004Uk-Cr;
        Fri, 27 May 2022 06:44:17 +0000
Date:   Fri, 27 May 2022 14:43:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        bjorn.andersson@linaro.org
Cc:     kbuild-all@lists.01.org, quic_sbillaka@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        dri-devel@lists.freedesktop.org, quic_khsieh@quicinc.com,
        quic_aravindh@quicinc.com, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/msm/dp: force link training for display
 resolution change
Message-ID: <202205271424.ApfrMbAm-lkp@intel.com>
References: <1653606555-18675-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653606555-18675-1-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kuogee,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on next-20220526]
[cannot apply to v5.18]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuogee-Hsieh/drm-msm-dp-force-link-training-for-display-resolution-change/20220527-071202
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: sparc-allmodconfig (https://download.01.org/0day-ci/archive/20220527/202205271424.ApfrMbAm-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/42816831cad7ced23cdedbb77ef2ebf13247c623
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kuogee-Hsieh/drm-msm-dp-force-link-training-for-display-resolution-change/20220527-071202
        git checkout 42816831cad7ced23cdedbb77ef2ebf13247c623
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/msm/dp/dp_ctrl.c: In function 'dp_ctrl_on_stream':
>> drivers/gpu/drm/msm/dp/dp_ctrl.c:1852:13: error: 'force_link_tarin' undeclared (first use in this function); did you mean 'force_link_train'?
    1852 |         if (force_link_tarin || !dp_ctrl_channel_eq_ok(ctrl))
         |             ^~~~~~~~~~~~~~~~
         |             force_link_train
   drivers/gpu/drm/msm/dp/dp_ctrl.c:1852:13: note: each undeclared identifier is reported only once for each function it appears in


vim +1852 drivers/gpu/drm/msm/dp/dp_ctrl.c

  1810	
  1811	int dp_ctrl_on_stream(struct dp_ctrl *dp_ctrl, bool force_link_train)
  1812	{
  1813		int ret = 0;
  1814		bool mainlink_ready = false;
  1815		struct dp_ctrl_private *ctrl;
  1816		unsigned long pixel_rate_orig;
  1817	
  1818		if (!dp_ctrl)
  1819			return -EINVAL;
  1820	
  1821		ctrl = container_of(dp_ctrl, struct dp_ctrl_private, dp_ctrl);
  1822	
  1823		ctrl->dp_ctrl.pixel_rate = ctrl->panel->dp_mode.drm_mode.clock;
  1824	
  1825		pixel_rate_orig = ctrl->dp_ctrl.pixel_rate;
  1826		if (dp_ctrl->wide_bus_en)
  1827			ctrl->dp_ctrl.pixel_rate >>= 1;
  1828	
  1829		drm_dbg_dp(ctrl->drm_dev, "rate=%d, num_lanes=%d, pixel_rate=%d\n",
  1830			ctrl->link->link_params.rate,
  1831			ctrl->link->link_params.num_lanes, ctrl->dp_ctrl.pixel_rate);
  1832	
  1833		if (!dp_power_clk_status(ctrl->power, DP_CTRL_PM)) { /* link clk is off */
  1834			ret = dp_ctrl_enable_mainlink_clocks(ctrl);
  1835			if (ret) {
  1836				DRM_ERROR("Failed to start link clocks. ret=%d\n", ret);
  1837				goto end;
  1838			}
  1839		}
  1840	
  1841		ret = dp_ctrl_enable_stream_clocks(ctrl);
  1842		if (ret) {
  1843			DRM_ERROR("Failed to start pixel clocks. ret=%d\n", ret);
  1844			goto end;
  1845		}
  1846	
  1847		if (ctrl->link->sink_request & DP_TEST_LINK_PHY_TEST_PATTERN) {
  1848			dp_ctrl_send_phy_test_pattern(ctrl);
  1849			return 0;
  1850		}
  1851	
> 1852		if (force_link_tarin || !dp_ctrl_channel_eq_ok(ctrl))
  1853			dp_ctrl_link_retrain(ctrl);
  1854	
  1855		/* stop txing train pattern to end link training */
  1856		dp_ctrl_clear_training_pattern(ctrl);
  1857	
  1858		/*
  1859		 * Set up transfer unit values and set controller state to send
  1860		 * video.
  1861		 */
  1862		reinit_completion(&ctrl->video_comp);
  1863	
  1864		dp_ctrl_configure_source_params(ctrl);
  1865	
  1866		dp_catalog_ctrl_config_msa(ctrl->catalog,
  1867			ctrl->link->link_params.rate,
  1868			pixel_rate_orig, dp_ctrl_use_fixed_nvid(ctrl));
  1869	
  1870		dp_ctrl_setup_tr_unit(ctrl);
  1871	
  1872		dp_catalog_ctrl_state_ctrl(ctrl->catalog, DP_STATE_CTRL_SEND_VIDEO);
  1873	
  1874		ret = dp_ctrl_wait4video_ready(ctrl);
  1875		if (ret)
  1876			return ret;
  1877	
  1878		mainlink_ready = dp_catalog_ctrl_mainlink_ready(ctrl->catalog);
  1879		drm_dbg_dp(ctrl->drm_dev,
  1880			"mainlink %s\n", mainlink_ready ? "READY" : "NOT READY");
  1881	
  1882	end:
  1883		return ret;
  1884	}
  1885	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
