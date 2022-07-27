Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3040581D6A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 04:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240035AbiG0CGu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 22:06:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240032AbiG0CGs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 22:06:48 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92DD83135D;
        Tue, 26 Jul 2022 19:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658887606; x=1690423606;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=HiZZmB3zhZMrYRQqM73N/5JPYTEqt0xeA6+nfmKQHKM=;
  b=SZOA1rzTf9ecksx/HHO2w3ku5Qf2BeEx8VXTb7MLhBJbl1qOa8TJ6BUw
   F+umTZ6xx5cBTt7TzkGcC85Tmn5zdnOldlhO8bSufG9OLImGKBPqQZi5p
   xLbpXoYY0+IvPRSIxnZc29InU4rNXg4ol/wBjRAAz/rahy3YCjdi4lDrf
   2OnV8ID6Sqhl1GhvkXip3vVzJvbt9DxfGZr+FCGz6lf+maQcCYzyDqOIK
   eWDOoclP/tYQROVs9QV21iSMa0AV2bdqKy5E+CMtomYBx3sx2GI30+aE2
   OgXs378qmuWJg1BGQYoAUI3Em8J2kjXpNJcr1+9MUu4eLVAeXekWNqCFa
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10420"; a="289314803"
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="289314803"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2022 19:06:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,194,1654585200"; 
   d="scan'208";a="703132242"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 26 Jul 2022 19:06:34 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oGWRW-0008AY-06;
        Wed, 27 Jul 2022 02:06:34 +0000
Date:   Wed, 27 Jul 2022 10:05:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jesse Taube <mr.bossman075@gmail.com>, linux-imx@nxp.com
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, robh+dt@kernel.org,
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
Message-ID: <202207270909.VypZ4wfI-lkp@intel.com>
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
config: arm-randconfig-c002-20220726 (https://download.01.org/0day-ci/archive/20220727/202207270909.VypZ4wfI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 9e88cbcc403bdf82f29259ad60ff60a8fc4434a1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/96413cc0300321ec18d27ca9983f349a41f99706
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jesse-Taube/Add-support-for-the-i-MXRT1170-evk/20220724-000710
        git checkout 96413cc0300321ec18d27ca9983f349a41f99706
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/imx/ drivers/firmware/efi/libstub/ drivers/pci/ drivers/soc/fsl/qe/ fs/ecryptfs/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/clk/imx/clk-imx6sl.c:16:
   drivers/clk/imx/clk.h:268:60: error: too few arguments provided to function-like macro invocation
                   const char *parent_name, void __iomem *base, u32 div_mask);
                                                                            ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
>> drivers/clk/imx/clk-imx6sl.c:217:93: error: too few arguments provided to function-like macro invocation
           hws[IMX6SL_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc", base + 0x00, 0x7f);
                                                                                                      ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sl.c:218:92: error: too few arguments provided to function-like macro invocation
           hws[IMX6SL_CLK_PLL2] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc", base + 0x30, 0x1);
                                                                                                     ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sl.c:219:92: error: too few arguments provided to function-like macro invocation
           hws[IMX6SL_CLK_PLL3] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll3", "osc", base + 0x10, 0x3);
                                                                                                     ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sl.c:220:93: error: too few arguments provided to function-like macro invocation
           hws[IMX6SL_CLK_PLL4] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll4", "osc", base + 0x70, 0x7f);
                                                                                                      ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sl.c:221:93: error: too few arguments provided to function-like macro invocation
           hws[IMX6SL_CLK_PLL5] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll5", "osc", base + 0xa0, 0x7f);
                                                                                                      ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sl.c:222:92: error: too few arguments provided to function-like macro invocation
           hws[IMX6SL_CLK_PLL6] = imx_clk_hw_pllv3(IMX_PLLV3_ENET,    "pll6", "osc", base + 0xe0, 0x3);
                                                                                                     ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sl.c:223:92: error: too few arguments provided to function-like macro invocation
           hws[IMX6SL_CLK_PLL7] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll7", "osc", base + 0x20, 0x3);
                                                                                                     ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   8 errors generated.
--
   In file included from drivers/clk/imx/clk-imx6sx.c:19:
   drivers/clk/imx/clk.h:268:60: error: too few arguments provided to function-like macro invocation
                   const char *parent_name, void __iomem *base, u32 div_mask);
                                                                            ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
>> drivers/clk/imx/clk-imx6sx.c:160:93: error: too few arguments provided to function-like macro invocation
           hws[IMX6SX_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc", base + 0x00, 0x7f);
                                                                                                      ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sx.c:161:92: error: too few arguments provided to function-like macro invocation
           hws[IMX6SX_CLK_PLL2] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc", base + 0x30, 0x1);
                                                                                                     ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sx.c:162:92: error: too few arguments provided to function-like macro invocation
           hws[IMX6SX_CLK_PLL3] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll3", "osc", base + 0x10, 0x3);
                                                                                                     ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sx.c:163:93: error: too few arguments provided to function-like macro invocation
           hws[IMX6SX_CLK_PLL4] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll4", "osc", base + 0x70, 0x7f);
                                                                                                      ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sx.c:164:93: error: too few arguments provided to function-like macro invocation
           hws[IMX6SX_CLK_PLL5] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll5", "osc", base + 0xa0, 0x7f);
                                                                                                      ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sx.c:165:92: error: too few arguments provided to function-like macro invocation
           hws[IMX6SX_CLK_PLL6] = imx_clk_hw_pllv3(IMX_PLLV3_ENET,    "pll6", "osc", base + 0xe0, 0x3);
                                                                                                     ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6sx.c:166:92: error: too few arguments provided to function-like macro invocation
           hws[IMX6SX_CLK_PLL7] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll7", "osc", base + 0x20, 0x3);
                                                                                                     ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   8 errors generated.
--
   In file included from drivers/clk/imx/clk-imx6ul.c:18:
   drivers/clk/imx/clk.h:268:60: error: too few arguments provided to function-like macro invocation
                   const char *parent_name, void __iomem *base, u32 div_mask);
                                                                            ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
>> drivers/clk/imx/clk-imx6ul.c:149:90: error: too few arguments provided to function-like macro invocation
           hws[IMX6UL_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,   "pll1", "osc", base + 0x00, 0x7f);
                                                                                                    ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6ul.c:150:92: error: too few arguments provided to function-like macro invocation
           hws[IMX6UL_CLK_PLL2] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc", base + 0x30, 0x1);
                                                                                                     ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6ul.c:151:89: error: too few arguments provided to function-like macro invocation
           hws[IMX6UL_CLK_PLL3] = imx_clk_hw_pllv3(IMX_PLLV3_USB,   "pll3", "osc", base + 0x10, 0x3);
                                                                                                   ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6ul.c:152:89: error: too few arguments provided to function-like macro invocation
           hws[IMX6UL_CLK_PLL4] = imx_clk_hw_pllv3(IMX_PLLV3_AV,    "pll4", "osc", base + 0x70, 0x7f);
                                                                                                    ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6ul.c:153:89: error: too few arguments provided to function-like macro invocation
           hws[IMX6UL_CLK_PLL5] = imx_clk_hw_pllv3(IMX_PLLV3_AV,    "pll5", "osc", base + 0xa0, 0x7f);
                                                                                                    ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6ul.c:154:90: error: too few arguments provided to function-like macro invocation
           hws[IMX6UL_CLK_PLL6] = imx_clk_hw_pllv3(IMX_PLLV3_ENET,  "pll6", "osc", base + 0xe0, 0x3);
                                                                                                   ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   drivers/clk/imx/clk-imx6ul.c:155:89: error: too few arguments provided to function-like macro invocation
           hws[IMX6UL_CLK_PLL7] = imx_clk_hw_pllv3(IMX_PLLV3_USB,   "pll7", "osc", base + 0x20, 0x3);
                                                                                                   ^
   drivers/clk/imx/clk.h:107:9: note: macro 'imx_clk_hw_pllv3' defined here
   #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
           ^
   8 errors generated.


vim +217 drivers/clk/imx/clk-imx6sl.c

751f7e999afcef1 arch/arm/mach-imx/clk-imx6sl.c Anson Huang 2014-01-09  181  
53bb71da1c5c142 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2013-05-21  182  static void __init imx6sl_clocks_init(struct device_node *ccm_node)
45fe6810347b0a8 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2013-05-03  183  {
45fe6810347b0a8 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2013-05-03  184  	struct device_node *np;
45fe6810347b0a8 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2013-05-03  185  	void __iomem *base;
848db4a0a17aaf9 arch/arm/mach-imx/clk-imx6sl.c Anson Huang 2014-01-07  186  	int ret;
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  187  
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  188  	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  189  					  IMX6SL_CLK_END), GFP_KERNEL);
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  190  	if (WARN_ON(!clk_hw_data))
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  191  		return;
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  192  
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  193  	clk_hw_data->num = IMX6SL_CLK_END;
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  194  	hws = clk_hw_data->hws;
45fe6810347b0a8 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2013-05-03  195  
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  196  	hws[IMX6SL_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  197  	hws[IMX6SL_CLK_CKIL] = imx_obtain_fixed_clock_hw("ckil", 0);
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  198  	hws[IMX6SL_CLK_OSC] = imx_obtain_fixed_clock_hw("osc", 0);
e90f41990dce355 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2014-09-01  199  	/* Clock source from external clock via CLK1 PAD */
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  200  	hws[IMX6SL_CLK_ANACLK1] = imx_obtain_fixed_clock_hw("anaclk1", 0);
45fe6810347b0a8 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2013-05-03  201  
45fe6810347b0a8 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2013-05-03  202  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6sl-anatop");
45fe6810347b0a8 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2013-05-03  203  	base = of_iomap(np, 0);
45fe6810347b0a8 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2013-05-03  204  	WARN_ON(!base);
8b1a3c0ba9b1cec drivers/clk/imx/clk-imx6sl.c   Anson Huang 2020-02-12  205  	of_node_put(np);
6e6cdf66563086c arch/arm/mach-imx/clk-imx6sl.c Anson Huang 2014-02-11  206  	anatop_base = base;
45fe6810347b0a8 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2013-05-03  207  
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  208  	hws[IMX6SL_PLL1_BYPASS_SRC] = imx_clk_hw_mux("pll1_bypass_src", base + 0x00, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  209  	hws[IMX6SL_PLL2_BYPASS_SRC] = imx_clk_hw_mux("pll2_bypass_src", base + 0x30, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  210  	hws[IMX6SL_PLL3_BYPASS_SRC] = imx_clk_hw_mux("pll3_bypass_src", base + 0x10, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  211  	hws[IMX6SL_PLL4_BYPASS_SRC] = imx_clk_hw_mux("pll4_bypass_src", base + 0x70, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  212  	hws[IMX6SL_PLL5_BYPASS_SRC] = imx_clk_hw_mux("pll5_bypass_src", base + 0xa0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  213  	hws[IMX6SL_PLL6_BYPASS_SRC] = imx_clk_hw_mux("pll6_bypass_src", base + 0xe0, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29  214  	hws[IMX6SL_PLL7_BYPASS_SRC] = imx_clk_hw_mux("pll7_bypass_src", base + 0x20, 14, 1, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
e90f41990dce355 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2014-09-01  215  
e90f41990dce355 arch/arm/mach-imx/clk-imx6sl.c Shawn Guo   2014-09-01  216  	/*                                    type               name    parent_name        base         div_mask */
3a1d8fe6f445b13 drivers/clk/imx/clk-imx6sl.c   Abel Vesa   2019-05-29 @217  	hws[IMX6SL_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc", base + 0x00, 0x7f);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
