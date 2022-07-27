Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAED5826E3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 14:44:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233295AbiG0Moe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 08:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiG0Moa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 08:44:30 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEC93FA2B;
        Wed, 27 Jul 2022 05:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658925868; x=1690461868;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D0G6aGwdYxp0yUy/25RSiklGLnlguj+2vNO4QUmu184=;
  b=FaDdAUbTn6oLocoyBXV5m5kU2lIQHPTWo9gl17RA2b9Kgim0omc46zaS
   mN3j8ZS0nTuVw5Iy++bvsc/l5f8TpQ+QzWEDkzRC9Bnf7BEtP8w3QZp9Y
   KLBmRO4IZjPlbKQI8u8gbxB6JdRB782HSNVT/mZfbcNkS3gJXH3Psqp6C
   VZO0EQ9WxWD7jRmUXBYcwhFlVfW9RDXWdhhT4RKUVzcjf/JG37HTjWDtu
   uUIu5BOCOxz8PQOFSUOyvxxrwtvSN/aDEFd2cUWwnU2tZwXNNKSn+Zey9
   lUL34Ko4IbUWJjQnWOFstVaoXtrdwr3L9Us8Mt1+2OHNp63KJ2k0vWLFX
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="349926875"
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="349926875"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2022 05:44:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,195,1654585200"; 
   d="scan'208";a="703295883"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 27 Jul 2022 05:44:21 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGgOi-0008iA-1R;
        Wed, 27 Jul 2022 12:44:20 +0000
Date:   Wed, 27 Jul 2022 20:43:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     kbuild-all@lists.01.org, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        aisheng.dong@nxp.com, stefan@agner.ch, linus.walleij@linaro.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com,
        sebastian.reichel@collabora.com, cniedermaier@dh-electronics.com,
        Mr.Bossman075@gmail.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: Re: [PATCH v5 07/12] clk: imx: Update pllv3 to support i.MXRT1170
Message-ID: <202207272045.F8viHzgx-lkp@intel.com>
References: <20220723160513.271692-8-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723160513.271692-8-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on abelvesa/clk/imx linus/master v5.19-rc8]
[cannot apply to soc/for-next next-20220726]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesse-Taube/Add-support-for-the-i-MXRT1170-evk/20220724-000710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-randconfig-p001-20220727 (https://download.01.org/0day-ci/archive/20220727/202207272045.F8viHzgx-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/96413cc0300321ec18d27ca9983f349a41f99706
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jesse-Taube/Add-support-for-the-i-MXRT1170-evk/20220724-000710
        git checkout 96413cc0300321ec18d27ca9983f349a41f99706
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/imx/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/clk/imx/clk-imxrt1050.c:14:
   drivers/clk/imx/clk.h:268:74: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     268 |                 const char *parent_name, void __iomem *base, u32 div_mask);
         |                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imxrt1050.c: In function 'imxrt1050_clocks_probe':
>> drivers/clk/imx/clk-imxrt1050.c:74:57: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
      74 |                 "pll1_arm_ref_sel", pll_base + 0x0, 0x7f);
         |                                                         ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imxrt1050.c:76:57: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
      76 |                 "pll2_sys_ref_sel", pll_base + 0x30, 0x1);
         |                                                         ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imxrt1050.c:78:61: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
      78 |                 "pll3_usb_otg_ref_sel", pll_base + 0x10, 0x1);
         |                                                             ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imxrt1050.c:80:60: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
      80 |                 "pll5_video_ref_sel", pll_base + 0xa0, 0x7f);
         |                                                            ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 


vim +/imx_clk_hw_pllv3 +74 drivers/clk/imx/clk-imxrt1050.c

7154b046d8f3a44 Jesse Taube 2022-01-11   35  
7154b046d8f3a44 Jesse Taube 2022-01-11   36  static int imxrt1050_clocks_probe(struct platform_device *pdev)
7154b046d8f3a44 Jesse Taube 2022-01-11   37  {
7154b046d8f3a44 Jesse Taube 2022-01-11   38  	void __iomem *ccm_base;
7154b046d8f3a44 Jesse Taube 2022-01-11   39  	void __iomem *pll_base;
7154b046d8f3a44 Jesse Taube 2022-01-11   40  	struct device *dev = &pdev->dev;
7154b046d8f3a44 Jesse Taube 2022-01-11   41  	struct device_node *np = dev->of_node;
7154b046d8f3a44 Jesse Taube 2022-01-11   42  	struct device_node *anp;
7154b046d8f3a44 Jesse Taube 2022-01-11   43  	int ret;
7154b046d8f3a44 Jesse Taube 2022-01-11   44  
7154b046d8f3a44 Jesse Taube 2022-01-11   45  	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
7154b046d8f3a44 Jesse Taube 2022-01-11   46  					  IMXRT1050_CLK_END), GFP_KERNEL);
7154b046d8f3a44 Jesse Taube 2022-01-11   47  	if (WARN_ON(!clk_hw_data))
7154b046d8f3a44 Jesse Taube 2022-01-11   48  		return -ENOMEM;
7154b046d8f3a44 Jesse Taube 2022-01-11   49  
7154b046d8f3a44 Jesse Taube 2022-01-11   50  	clk_hw_data->num = IMXRT1050_CLK_END;
7154b046d8f3a44 Jesse Taube 2022-01-11   51  	hws = clk_hw_data->hws;
7154b046d8f3a44 Jesse Taube 2022-01-11   52  
7154b046d8f3a44 Jesse Taube 2022-01-11   53  	hws[IMXRT1050_CLK_OSC] = imx_obtain_fixed_clk_hw(np, "osc");
7154b046d8f3a44 Jesse Taube 2022-01-11   54  
7154b046d8f3a44 Jesse Taube 2022-01-11   55  	anp = of_find_compatible_node(NULL, NULL, "fsl,imxrt-anatop");
7154b046d8f3a44 Jesse Taube 2022-01-11   56  	pll_base = of_iomap(anp, 0);
7154b046d8f3a44 Jesse Taube 2022-01-11   57  	of_node_put(anp);
7154b046d8f3a44 Jesse Taube 2022-01-11   58  	if (WARN_ON(!pll_base))
7154b046d8f3a44 Jesse Taube 2022-01-11   59  		return -ENOMEM;
7154b046d8f3a44 Jesse Taube 2022-01-11   60  
7154b046d8f3a44 Jesse Taube 2022-01-11   61  	/* Anatop clocks */
7154b046d8f3a44 Jesse Taube 2022-01-11   62  	hws[IMXRT1050_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0UL);
7154b046d8f3a44 Jesse Taube 2022-01-11   63  
7154b046d8f3a44 Jesse Taube 2022-01-11   64  	hws[IMXRT1050_CLK_PLL1_REF_SEL] = imx_clk_hw_mux("pll1_arm_ref_sel",
7154b046d8f3a44 Jesse Taube 2022-01-11   65  		pll_base + 0x0, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11   66  	hws[IMXRT1050_CLK_PLL2_REF_SEL] = imx_clk_hw_mux("pll2_sys_ref_sel",
7154b046d8f3a44 Jesse Taube 2022-01-11   67  		pll_base + 0x30, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11   68  	hws[IMXRT1050_CLK_PLL3_REF_SEL] = imx_clk_hw_mux("pll3_usb_otg_ref_sel",
7154b046d8f3a44 Jesse Taube 2022-01-11   69  		pll_base + 0x10, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11   70  	hws[IMXRT1050_CLK_PLL5_REF_SEL] = imx_clk_hw_mux("pll5_video_ref_sel",
7154b046d8f3a44 Jesse Taube 2022-01-11   71  		pll_base + 0xa0, 14, 2, pll_ref_sels, ARRAY_SIZE(pll_ref_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11   72  
7154b046d8f3a44 Jesse Taube 2022-01-11   73  	hws[IMXRT1050_CLK_PLL1_ARM] = imx_clk_hw_pllv3(IMX_PLLV3_SYS, "pll1_arm",
7154b046d8f3a44 Jesse Taube 2022-01-11  @74  		"pll1_arm_ref_sel", pll_base + 0x0, 0x7f);
7154b046d8f3a44 Jesse Taube 2022-01-11   75  	hws[IMXRT1050_CLK_PLL2_SYS] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2_sys",
7154b046d8f3a44 Jesse Taube 2022-01-11   76  		"pll2_sys_ref_sel", pll_base + 0x30, 0x1);
7154b046d8f3a44 Jesse Taube 2022-01-11   77  	hws[IMXRT1050_CLK_PLL3_USB_OTG] = imx_clk_hw_pllv3(IMX_PLLV3_USB, "pll3_usb_otg",
7154b046d8f3a44 Jesse Taube 2022-01-11   78  		"pll3_usb_otg_ref_sel", pll_base + 0x10, 0x1);
7154b046d8f3a44 Jesse Taube 2022-01-11   79  	hws[IMXRT1050_CLK_PLL5_VIDEO] = imx_clk_hw_pllv3(IMX_PLLV3_AV, "pll5_video",
7154b046d8f3a44 Jesse Taube 2022-01-11   80  		"pll5_video_ref_sel", pll_base + 0xa0, 0x7f);
7154b046d8f3a44 Jesse Taube 2022-01-11   81  
7154b046d8f3a44 Jesse Taube 2022-01-11   82  	/* PLL bypass out */
7154b046d8f3a44 Jesse Taube 2022-01-11   83  	hws[IMXRT1050_CLK_PLL1_BYPASS] = imx_clk_hw_mux_flags("pll1_bypass", pll_base + 0x0, 16, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11   84  		pll1_bypass_sels, ARRAY_SIZE(pll1_bypass_sels), CLK_SET_RATE_PARENT);
7154b046d8f3a44 Jesse Taube 2022-01-11   85  	hws[IMXRT1050_CLK_PLL2_BYPASS] = imx_clk_hw_mux_flags("pll2_bypass", pll_base + 0x30, 16, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11   86  		pll2_bypass_sels, ARRAY_SIZE(pll2_bypass_sels), CLK_SET_RATE_PARENT);
7154b046d8f3a44 Jesse Taube 2022-01-11   87  	hws[IMXRT1050_CLK_PLL3_BYPASS] = imx_clk_hw_mux_flags("pll3_bypass", pll_base + 0x10, 16, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11   88  		pll3_bypass_sels, ARRAY_SIZE(pll3_bypass_sels), CLK_SET_RATE_PARENT);
7154b046d8f3a44 Jesse Taube 2022-01-11   89  	hws[IMXRT1050_CLK_PLL5_BYPASS] = imx_clk_hw_mux_flags("pll5_bypass", pll_base + 0xa0, 16, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11   90  		pll5_bypass_sels, ARRAY_SIZE(pll5_bypass_sels), CLK_SET_RATE_PARENT);
7154b046d8f3a44 Jesse Taube 2022-01-11   91  
7154b046d8f3a44 Jesse Taube 2022-01-11   92  	hws[IMXRT1050_CLK_VIDEO_POST_DIV_SEL] = imx_clk_hw_divider("video_post_div_sel",
7154b046d8f3a44 Jesse Taube 2022-01-11   93  		"pll5_video", pll_base + 0xa0, 19, 2);
7154b046d8f3a44 Jesse Taube 2022-01-11   94  	hws[IMXRT1050_CLK_VIDEO_DIV] = imx_clk_hw_divider("video_div",
7154b046d8f3a44 Jesse Taube 2022-01-11   95  		"video_post_div_sel", pll_base + 0x170, 30, 2);
7154b046d8f3a44 Jesse Taube 2022-01-11   96  
7154b046d8f3a44 Jesse Taube 2022-01-11   97  	hws[IMXRT1050_CLK_PLL3_80M] = imx_clk_hw_fixed_factor("pll3_80m",  "pll3_usb_otg", 1, 6);
7154b046d8f3a44 Jesse Taube 2022-01-11   98  
7154b046d8f3a44 Jesse Taube 2022-01-11   99  	hws[IMXRT1050_CLK_PLL2_PFD0_352M] = imx_clk_hw_pfd("pll2_pfd0_352m", "pll2_sys", pll_base + 0x100, 0);
7154b046d8f3a44 Jesse Taube 2022-01-11  100  	hws[IMXRT1050_CLK_PLL2_PFD1_594M] = imx_clk_hw_pfd("pll2_pfd1_594m", "pll2_sys", pll_base + 0x100, 1);
7154b046d8f3a44 Jesse Taube 2022-01-11  101  	hws[IMXRT1050_CLK_PLL2_PFD2_396M] = imx_clk_hw_pfd("pll2_pfd2_396m", "pll2_sys", pll_base + 0x100, 2);
7154b046d8f3a44 Jesse Taube 2022-01-11  102  	hws[IMXRT1050_CLK_PLL3_PFD1_664_62M] = imx_clk_hw_pfd("pll3_pfd1_664_62m", "pll3_usb_otg", pll_base + 0xf0, 1);
7154b046d8f3a44 Jesse Taube 2022-01-11  103  	hws[IMXRT1050_CLK_PLL3_PFD3_454_74M] = imx_clk_hw_pfd("pll3_pfd3_454_74m", "pll3_usb_otg", pll_base + 0xf0, 3);
7154b046d8f3a44 Jesse Taube 2022-01-11  104  
7154b046d8f3a44 Jesse Taube 2022-01-11  105  	/* CCM clocks */
7154b046d8f3a44 Jesse Taube 2022-01-11  106  	ccm_base = devm_platform_ioremap_resource(pdev, 0);
7154b046d8f3a44 Jesse Taube 2022-01-11  107  	if (WARN_ON(IS_ERR(ccm_base)))
7154b046d8f3a44 Jesse Taube 2022-01-11  108  		return PTR_ERR(ccm_base);
7154b046d8f3a44 Jesse Taube 2022-01-11  109  
7154b046d8f3a44 Jesse Taube 2022-01-11  110  	hws[IMXRT1050_CLK_ARM_PODF] = imx_clk_hw_divider("arm_podf", "pll1_arm", ccm_base + 0x10, 0, 3);
7154b046d8f3a44 Jesse Taube 2022-01-11  111  	hws[IMXRT1050_CLK_PRE_PERIPH_SEL] = imx_clk_hw_mux("pre_periph_sel", ccm_base + 0x18, 18, 2,
7154b046d8f3a44 Jesse Taube 2022-01-11  112  		pre_periph_sels, ARRAY_SIZE(pre_periph_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11  113  	hws[IMXRT1050_CLK_PERIPH_SEL] = imx_clk_hw_mux("periph_sel", ccm_base + 0x14, 25, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11  114  		periph_sels, ARRAY_SIZE(periph_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11  115  	hws[IMXRT1050_CLK_USDHC1_SEL] = imx_clk_hw_mux("usdhc1_sel", ccm_base + 0x1c, 16, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11  116  		usdhc_sels, ARRAY_SIZE(usdhc_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11  117  	hws[IMXRT1050_CLK_USDHC2_SEL] = imx_clk_hw_mux("usdhc2_sel", ccm_base + 0x1c, 17, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11  118  		usdhc_sels, ARRAY_SIZE(usdhc_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11  119  	hws[IMXRT1050_CLK_LPUART_SEL] = imx_clk_hw_mux("lpuart_sel", ccm_base + 0x24, 6, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11  120  		lpuart_sels, ARRAY_SIZE(lpuart_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11  121  	hws[IMXRT1050_CLK_LCDIF_SEL] = imx_clk_hw_mux("lcdif_sel", ccm_base + 0x38, 15, 3,
7154b046d8f3a44 Jesse Taube 2022-01-11  122  		lcdif_sels, ARRAY_SIZE(lcdif_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11  123  	hws[IMXRT1050_CLK_PER_CLK_SEL] = imx_clk_hw_mux("per_sel", ccm_base + 0x1C, 6, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11  124  		per_sels, ARRAY_SIZE(per_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11  125  	hws[IMXRT1050_CLK_SEMC_ALT_SEL] = imx_clk_hw_mux("semc_alt_sel", ccm_base + 0x14, 7, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11  126  		semc_alt_sels, ARRAY_SIZE(semc_alt_sels));
7154b046d8f3a44 Jesse Taube 2022-01-11  127  	hws[IMXRT1050_CLK_SEMC_SEL] = imx_clk_hw_mux_flags("semc_sel", ccm_base + 0x14, 6, 1,
7154b046d8f3a44 Jesse Taube 2022-01-11  128  		semc_sels, ARRAY_SIZE(semc_sels), CLK_IS_CRITICAL);
7154b046d8f3a44 Jesse Taube 2022-01-11  129  
7154b046d8f3a44 Jesse Taube 2022-01-11  130  	hws[IMXRT1050_CLK_AHB_PODF] = imx_clk_hw_divider("ahb", "periph_sel", ccm_base + 0x14, 10, 3);
7154b046d8f3a44 Jesse Taube 2022-01-11  131  	hws[IMXRT1050_CLK_IPG_PDOF] = imx_clk_hw_divider("ipg", "ahb", ccm_base + 0x14, 8, 2);
7154b046d8f3a44 Jesse Taube 2022-01-11  132  	hws[IMXRT1050_CLK_PER_PDOF] = imx_clk_hw_divider("per", "per_sel", ccm_base + 0x1C, 0, 5);
7154b046d8f3a44 Jesse Taube 2022-01-11  133  
7154b046d8f3a44 Jesse Taube 2022-01-11  134  	hws[IMXRT1050_CLK_USDHC1_PODF] = imx_clk_hw_divider("usdhc1_podf", "usdhc1_sel", ccm_base + 0x24, 11, 3);
7154b046d8f3a44 Jesse Taube 2022-01-11  135  	hws[IMXRT1050_CLK_USDHC2_PODF] = imx_clk_hw_divider("usdhc2_podf", "usdhc2_sel", ccm_base + 0x24, 16, 3);
7154b046d8f3a44 Jesse Taube 2022-01-11  136  	hws[IMXRT1050_CLK_LPUART_PODF] = imx_clk_hw_divider("lpuart_podf", "lpuart_sel", ccm_base + 0x24, 0, 6);
7154b046d8f3a44 Jesse Taube 2022-01-11  137  	hws[IMXRT1050_CLK_LCDIF_PRED] = imx_clk_hw_divider("lcdif_pred", "lcdif_sel", ccm_base + 0x38, 12, 3);
7154b046d8f3a44 Jesse Taube 2022-01-11  138  	hws[IMXRT1050_CLK_LCDIF_PODF] = imx_clk_hw_divider("lcdif_podf", "lcdif_pred", ccm_base + 0x18, 23, 3);
7154b046d8f3a44 Jesse Taube 2022-01-11  139  
7154b046d8f3a44 Jesse Taube 2022-01-11  140  	hws[IMXRT1050_CLK_USDHC1] = imx_clk_hw_gate2("usdhc1", "usdhc1_podf", ccm_base + 0x80, 2);
7154b046d8f3a44 Jesse Taube 2022-01-11  141  	hws[IMXRT1050_CLK_USDHC2] = imx_clk_hw_gate2("usdhc2", "usdhc2_podf", ccm_base + 0x80, 4);
7154b046d8f3a44 Jesse Taube 2022-01-11  142  	hws[IMXRT1050_CLK_LPUART1] = imx_clk_hw_gate2("lpuart1", "lpuart_podf", ccm_base + 0x7c, 24);
7154b046d8f3a44 Jesse Taube 2022-01-11  143  	hws[IMXRT1050_CLK_LCDIF_APB] = imx_clk_hw_gate2("lcdif", "lcdif_podf", ccm_base + 0x74, 10);
7154b046d8f3a44 Jesse Taube 2022-01-11  144  	hws[IMXRT1050_CLK_DMA] = imx_clk_hw_gate("dma", "ipg", ccm_base + 0x7C, 6);
7154b046d8f3a44 Jesse Taube 2022-01-11  145  	hws[IMXRT1050_CLK_DMA_MUX] = imx_clk_hw_gate("dmamux0", "ipg", ccm_base + 0x7C, 7);
7154b046d8f3a44 Jesse Taube 2022-01-11  146  	imx_check_clk_hws(hws, IMXRT1050_CLK_END);
7154b046d8f3a44 Jesse Taube 2022-01-11  147  
7154b046d8f3a44 Jesse Taube 2022-01-11  148  	ret = of_clk_add_hw_provider(np, of_clk_hw_onecell_get, clk_hw_data);
7154b046d8f3a44 Jesse Taube 2022-01-11  149  	if (ret < 0) {
7154b046d8f3a44 Jesse Taube 2022-01-11  150  		dev_err(dev, "Failed to register clks for i.MXRT1050.\n");
7154b046d8f3a44 Jesse Taube 2022-01-11  151  		imx_unregister_hw_clocks(hws, IMXRT1050_CLK_END);
7154b046d8f3a44 Jesse Taube 2022-01-11  152  	}
7154b046d8f3a44 Jesse Taube 2022-01-11  153  	return ret;
7154b046d8f3a44 Jesse Taube 2022-01-11  154  }
7154b046d8f3a44 Jesse Taube 2022-01-11  155  static const struct of_device_id imxrt1050_clk_of_match[] = {
7154b046d8f3a44 Jesse Taube 2022-01-11  156  	{ .compatible = "fsl,imxrt1050-ccm" },
7154b046d8f3a44 Jesse Taube 2022-01-11  157  	{ /* Sentinel */ }
7154b046d8f3a44 Jesse Taube 2022-01-11  158  };
7154b046d8f3a44 Jesse Taube 2022-01-11  159  MODULE_DEVICE_TABLE(of, imxrt1050_clk_of_match);
7154b046d8f3a44 Jesse Taube 2022-01-11  160  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
