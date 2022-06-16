Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09B7954EC0F
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 23:07:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379039AbiFPVGh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 17:06:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379023AbiFPVGV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 17:06:21 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6855C60A95;
        Thu, 16 Jun 2022 14:06:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655413580; x=1686949580;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WK2j77TFJ/70U37ZeB4rzHVUzdPEhxO1yxy3ztiMc/4=;
  b=TsDrAkC3ymJtbIriuDIrXYkmzS7EnbqUNK8pXgslS8QHoH+YDxN3yHEc
   DM6fXSZB3l6hy8lspHfD0x/hJGFXlTUYiBPkABRDlWhEx5hY1vnJdDDL9
   2jpbAQ8OGIzVd1jRUKYwKqe+AWIZZmeov6xmEmORzbUKeESslR4kSmT4j
   u3blMg4fN+s3TknfwPeEW7Ze/AtWCL/iONantGko/1tP72ioyNkOX+Hmt
   b/ED83T/ACvAv5lG/1MqCb8gKsDrVsSOkE7loKby74s1BvKHoznjr3Oht
   E6JVw0mNKYLdG/JIlYBRa1hveYA2r66K2gmHDdKNAeXgH2/cM9pck4pLe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="304800319"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="304800319"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jun 2022 14:06:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="619027433"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 16 Jun 2022 14:06:15 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o1wgw-000OmT-UJ;
        Thu, 16 Jun 2022 21:06:14 +0000
Date:   Fri, 17 Jun 2022 05:06:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        dri-devel@lists.freedesktop.org, robdclark@gmail.com,
        sean@poorly.run, swboyd@chromium.org, dianders@chromium.org,
        vkoul@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        agross@kernel.org, dmitry.baryshkov@linaro.org,
        bjorn.andersson@linaro.org
Cc:     kbuild-all@lists.01.org, quic_sbillaka@quicinc.com,
        linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com,
        Kuogee Hsieh <quic_khsieh@quicinc.com>,
        quic_aravindh@quicinc.com, freedreno@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 2/2] drm/msm/dp: clean up pixel_rate from dp_ctrl.c
Message-ID: <202206170505.2U1jLZVk-lkp@intel.com>
References: <1655399361-10842-3-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1655399361-10842-3-git-send-email-quic_khsieh@quicinc.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
[also build test WARNING on drm-exynos/exynos-drm-next drm-tip/drm-tip linus/master v5.19-rc2 next-20220616]
[cannot apply to drm-intel/for-linux-next tegra-drm/drm/tegra/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kuogee-Hsieh/force-link-training-for-display-resolution-change/20220617-011110
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220617/202206170505.2U1jLZVk-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b04f0b39a03a9fc3728e9414157f9d5f0b8b2366
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kuogee-Hsieh/force-link-training-for-display-resolution-change/20220617-011110
        git checkout b04f0b39a03a9fc3728e9414157f9d5f0b8b2366
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/gpu/drm/msm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/msm/dp/dp_ctrl.c:1587:5: warning: no previous prototype for 'dp_ctrl_on_stream_phy_test_report' [-Wmissing-prototypes]
    1587 | int dp_ctrl_on_stream_phy_test_report(struct dp_ctrl *dp_ctrl)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


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
