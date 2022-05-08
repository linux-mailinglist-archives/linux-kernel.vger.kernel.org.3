Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3B451EDC1
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 15:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbiEHN15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 09:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233354AbiEHN1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 09:27:53 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA588DE96;
        Sun,  8 May 2022 06:23:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652016235; x=1683552235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=psDk1P7wyWAseUdXJBcbmzY0aYvncXmFOfzhn5uJ3xM=;
  b=CBl6C+MjWo6RpG+uN45nt+uxA2QpFIisUL1dofsw5/uOUg/6ZDhTFUXO
   3UKx4vQvG+Apex924ZVBTbyfSRVrmLSg7awiI3TP8rBzWDtEASHJ05KZd
   K4jlHVsIrt1evdCfJzfS7pBFpHW/TFbBIbn276kTTMMhr5/VAPKbHthfl
   1eBJs9MOGvIFnjiGhpigDhpZ3UOfjovsuUrpw3wdeNfUatmv+qdOnmn9l
   OBq+K96vltH1IlpKy0C6Z+f8zpXy6Y4JhZYwFgiaQR35ElUO+vxOEYrIb
   8xYlLU6745OsMT83HIMWn6YhlNrDrUX9zDZl7gAhF19nJnXhC/zMh3qjt
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="267678969"
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="267678969"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 May 2022 06:23:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,208,1647327600"; 
   d="scan'208";a="622565927"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 May 2022 06:23:50 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nngt4-000FVH-16;
        Sun, 08 May 2022 13:23:50 +0000
Date:   Sun, 8 May 2022 21:22:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Wesley Cheng <wcheng@codeaurora.org>
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_vpulyala@quicinc.com,
        Krishna Kurapati <quic_kriskura@quicinc.com>
Subject: Re: [v3 2/3] phy: qcom-snps: Add support for overriding phy tuning
 parameters
Message-ID: <202205082118.cd3B5WOH-lkp@intel.com>
References: <1652011947-18575-3-git-send-email-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652011947-18575-3-git-send-email-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on krzk/for-next linus/master v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Krishna-Kurapati/Add-QCOM-SNPS-PHY-overriding-params-support/20220508-201506
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220508/202205082118.cd3B5WOH-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/4f3771418951e9e3fcb6357959dbd668cdb54fb1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Krishna-Kurapati/Add-QCOM-SNPS-PHY-overriding-params-support/20220508-201506
        git checkout 4f3771418951e9e3fcb6357959dbd668cdb54fb1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/phy/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c: In function 'phy_read_param_override_seq':
>> drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c:530:33: warning: variable 'hsphy' set but not used [-Wunused-but-set-variable]
     530 |         struct qcom_snps_hsphy *hsphy;
         |                                 ^~~~~


vim +/hsphy +530 drivers/phy/qualcomm/phy-qcom-snps-femto-v2.c

   524	
   525	static void phy_read_param_override_seq(struct device *dev)
   526	{
   527		struct device_node *node = dev->of_node;
   528		s32 val;
   529		int ret, i;
 > 530		struct qcom_snps_hsphy *hsphy;
   531		struct override_param_map *cfg = (struct override_param_map* ) of_device_get_match_data(dev);
   532		hsphy = dev_get_drvdata(dev);
   533	
   534		for (i = 0; i < ARRAY_SIZE(phy_seq_props); i++) {
   535			ret = of_property_read_s32(node, phy_seq_props[i], &val);
   536			if (!ret)
   537				hsphy_override_param_update_val(cfg[i], val, &update_seq_cfg[i]);
   538		}
   539	}
   540	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
