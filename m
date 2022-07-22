Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2977C57E480
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 18:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235770AbiGVQfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 12:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiGVQfe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 12:35:34 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D92C290D9C;
        Fri, 22 Jul 2022 09:35:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658507733; x=1690043733;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wct04tBZUBn/SLi+Q6yHNMxbcUkF4qzPsiApqCX08Nk=;
  b=jPNL1uwrw+myR0PDEiK1JdAF7IPeU0yu50Un7ABj8jR0rn7sSjaaRrQ0
   KIV64X5eG+FPmLT24W8kTvNwLSx92qqOv/JAADdTn9CAMTsIe3DhrGUjI
   /Upw9f0EI7J0Td9rmgrHvJE+YUqzCBMOnh7MlGlVx+uBKD2GghMW6ycdC
   0EPiGDw31Su3ky/huz9gyVFjTG7n/24Z8XFIFBYVrjqC9O+0wugkSV3cr
   tWL6hDl180MSLFhdhcCgdlBokPqBvOM0gzCb64kG+SrOlIKbD+CKC1pAV
   WLgzvmATHrNhoEMb2L+rpGQq1EUDnp41EnshmID9UDRLUmT5Y7X5Mj7Gv
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="286111314"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="286111314"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 09:35:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="701716621"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 22 Jul 2022 09:35:27 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oEvcd-0001bt-0B;
        Fri, 22 Jul 2022 16:35:27 +0000
Date:   Sat, 23 Jul 2022 00:35:13 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, l.stach@pengutronix.de
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        laurent.pinchart@ideasonboard.com, marex@denx.de,
        paul.elder@ideasonboard.com, aford173@gmail.com,
        Markus.Niebel@ew.tq-group.com, alexander.stein@ew.tq-group.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, aisheng.dong@nxp.com,
        Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V4 5/8] soc: imx: add i.MX8MP HDMI blk ctrl HDCP/HRV
Message-ID: <202207230052.uIae3wom-lkp@intel.com>
References: <20220722125730.3428017-6-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722125730.3428017-6-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on linus/master v5.19-rc7 next-20220722]
[cannot apply to robh/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Peng-Fan-OSS/imx-add-i-MX8MP-hdmi-blk-ctrl-hdcp-hrv-and-vpu-blk-ctrl/20220722-205748
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: arm-buildonly-randconfig-r004-20220722 (https://download.01.org/0day-ci/archive/20220723/202207230052.uIae3wom-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 72686d68c137551cce816416190a18d45b4d4e2a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/9f38a755e912ffee8cd2b25002016da6e121f448
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/imx-add-i-MX8MP-hdmi-blk-ctrl-hdcp-hrv-and-vpu-blk-ctrl/20220722-205748
        git checkout 9f38a755e912ffee8cd2b25002016da6e121f448
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/soc/imx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/soc/imx/imx8mp-blk-ctrl.c:375:4: error: field designator 'path_names' does not refer to any field in type 'const struct imx8mp_blk_ctrl_domain_data'
                   .path_names = (const char *[]){"hrv"},
                    ^
>> drivers/soc/imx/imx8mp-blk-ctrl.c:376:4: error: field designator 'num_paths' does not refer to any field in type 'const struct imx8mp_blk_ctrl_domain_data'
                   .num_paths = 1,
                    ^
   drivers/soc/imx/imx8mp-blk-ctrl.c:383:4: error: field designator 'path_names' does not refer to any field in type 'const struct imx8mp_blk_ctrl_domain_data'
                   .path_names = (const char *[]){"hdcp"},
                    ^
   drivers/soc/imx/imx8mp-blk-ctrl.c:384:4: error: field designator 'num_paths' does not refer to any field in type 'const struct imx8mp_blk_ctrl_domain_data'
                   .num_paths = 1,
                    ^
>> drivers/soc/imx/imx8mp-blk-ctrl.c:394:17: error: invalid application of 'sizeof' to an incomplete type 'const struct imx8mp_blk_ctrl_domain_data[]'
           .num_domains = ARRAY_SIZE(imx8mp_hdmi_domain_data),
                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:32: note: expanded from macro 'ARRAY_SIZE'
   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                  ^~~~~
   5 errors generated.


vim +375 drivers/soc/imx/imx8mp-blk-ctrl.c

   326	
   327	static const struct imx8mp_blk_ctrl_domain_data imx8mp_hdmi_domain_data[] = {
   328		[IMX8MP_HDMIBLK_PD_IRQSTEER] = {
   329			.name = "hdmiblk-irqsteer",
   330			.clk_names = (const char *[]){ "apb" },
   331			.num_clks = 1,
   332			.gpc_name = "irqsteer",
   333		},
   334		[IMX8MP_HDMIBLK_PD_LCDIF] = {
   335			.name = "hdmiblk-lcdif",
   336			.clk_names = (const char *[]){ "axi", "apb" },
   337			.num_clks = 2,
   338			.gpc_name = "lcdif",
   339		},
   340		[IMX8MP_HDMIBLK_PD_PAI] = {
   341			.name = "hdmiblk-pai",
   342			.clk_names = (const char *[]){ "apb" },
   343			.num_clks = 1,
   344			.gpc_name = "pai",
   345		},
   346		[IMX8MP_HDMIBLK_PD_PVI] = {
   347			.name = "hdmiblk-pvi",
   348			.clk_names = (const char *[]){ "apb" },
   349			.num_clks = 1,
   350			.gpc_name = "pvi",
   351		},
   352		[IMX8MP_HDMIBLK_PD_TRNG] = {
   353			.name = "hdmiblk-trng",
   354			.clk_names = (const char *[]){ "apb" },
   355			.num_clks = 1,
   356			.gpc_name = "trng",
   357		},
   358		[IMX8MP_HDMIBLK_PD_HDMI_TX] = {
   359			.name = "hdmiblk-hdmi-tx",
   360			.clk_names = (const char *[]){ "apb", "ref_266m" },
   361			.num_clks = 2,
   362			.gpc_name = "hdmi-tx",
   363		},
   364		[IMX8MP_HDMIBLK_PD_HDMI_TX_PHY] = {
   365			.name = "hdmiblk-hdmi-tx-phy",
   366			.clk_names = (const char *[]){ "apb", "ref_24m" },
   367			.num_clks = 2,
   368			.gpc_name = "hdmi-tx-phy",
   369		},
   370		[IMX8MP_HDMIBLK_PD_HRV] = {
   371			.name = "hdmiblk-hrv",
   372			.clk_names = (const char *[]){ "axi", "apb" },
   373			.num_clks = 2,
   374			.gpc_name = "hrv",
 > 375			.path_names = (const char *[]){"hrv"},
 > 376			.num_paths = 1,
   377		},
   378		[IMX8MP_HDMIBLK_PD_HDCP] = {
   379			.name = "hdmiblk-hdcp",
   380			.clk_names = (const char *[]){ "axi", "apb" },
   381			.num_clks = 2,
   382			.gpc_name = "hdcp",
   383			.path_names = (const char *[]){"hdcp"},
   384			.num_paths = 1,
   385		},
   386	};
   387	
   388	static const struct imx8mp_blk_ctrl_data imx8mp_hdmi_blk_ctl_dev_data = {
   389		.max_reg = 0x23c,
   390		.power_on = imx8mp_hdmi_blk_ctrl_power_on,
   391		.power_off = imx8mp_hdmi_blk_ctrl_power_off,
   392		.power_notifier_fn = imx8mp_hdmi_power_notifier,
   393		.domains = imx8mp_hdmi_domain_data,
 > 394		.num_domains = ARRAY_SIZE(imx8mp_hdmi_domain_data),
   395	};
   396	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
