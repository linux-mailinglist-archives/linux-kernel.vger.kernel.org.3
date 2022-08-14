Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D101259203D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 16:45:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbiHNOpN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 10:45:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiHNOpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 10:45:10 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 440E713D0D;
        Sun, 14 Aug 2022 07:45:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660488308; x=1692024308;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AYYB80h5J0hH7YIzGUq77C10XX9XcCKmL2B3VlWTR9M=;
  b=VCH5dxcP98W5kdGVjpgvJdqFmoIDfrbMSpR2ot9VCxCMqqMDUorP3Cnx
   Oyek7eVoLL3H/MyEnKmYQaGoGkgJcpjvO7MUEumqOiCI+rMROp64wM4Fh
   icqUIp6iCNA+NeVO5LkV6pT30kyky1UwFn5guQ287BEg/WNxKqtAU+YDx
   u9Qh8sbZnbpcAqcA5pQlb9NzYsKOSPjTgUCKE6w4t0KGy2ITIwrIkZS0c
   olXEmKViZ0D1XUbCpEnyCDXAbcj7UABTkDNXBe4qmh4ajm67UOnql2aV1
   EojrXj61VKweB5aYP0CDNmdSDkcqWyc6LqKldOZ84kqZuwYer6DJQq2mm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10439"; a="271603477"
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="271603477"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2022 07:45:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,236,1654585200"; 
   d="scan'208";a="709510885"
Received: from lkp-server02.sh.intel.com (HELO 3d2a4d02a2a9) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 14 Aug 2022 07:45:00 -0700
Received: from kbuild by 3d2a4d02a2a9 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oNErL-0000Be-1j;
        Sun, 14 Aug 2022 14:44:59 +0000
Date:   Sun, 14 Aug 2022 22:44:52 +0800
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
Message-ID: <202208142248.DFj3YiOA-lkp@intel.com>
References: <20220723160513.271692-8-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220723160513.271692-8-Mr.Bossman075@gmail.com>
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jesse,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on abelvesa/clk/imx v5.19]
[cannot apply to soc/for-next linus/master next-20220812]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jesse-Taube/Add-support-for-the-i-MXRT1170-evk/20220724-000710
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220814/202208142248.DFj3YiOA-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/clk/imx/clk-imx6q.c:21:
   drivers/clk/imx/clk.h:268:74: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     268 |                 const char *parent_name, void __iomem *base, u32 div_mask);
         |                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6q.c: In function 'imx6q_clocks_init':
>> drivers/clk/imx/clk-imx6q.c:477:101: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     477 |         hws[IMX6QDL_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc", base + 0x00, 0x7f);
         |                                                                                                     ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6q.c:478:100: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     478 |         hws[IMX6QDL_CLK_PLL2] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc", base + 0x30, 0x1);
         |                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6q.c:479:100: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     479 |         hws[IMX6QDL_CLK_PLL3] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll3", "osc", base + 0x10, 0x3);
         |                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6q.c:480:101: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     480 |         hws[IMX6QDL_CLK_PLL4] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll4", "osc", base + 0x70, 0x7f);
         |                                                                                                     ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6q.c:481:101: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     481 |         hws[IMX6QDL_CLK_PLL5] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll5", "osc", base + 0xa0, 0x7f);
         |                                                                                                     ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6q.c:482:100: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     482 |         hws[IMX6QDL_CLK_PLL6] = imx_clk_hw_pllv3(IMX_PLLV3_ENET,    "pll6", "osc", base + 0xe0, 0x3);
         |                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6q.c:483:100: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     483 |         hws[IMX6QDL_CLK_PLL7] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll7", "osc", base + 0x20, 0x3);
         |                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
--
   In file included from drivers/clk/imx/clk-imx6sl.c:16:
   drivers/clk/imx/clk.h:268:74: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     268 |                 const char *parent_name, void __iomem *base, u32 div_mask);
         |                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sl.c: In function 'imx6sl_clocks_init':
>> drivers/clk/imx/clk-imx6sl.c:217:100: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     217 |         hws[IMX6SL_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc", base + 0x00, 0x7f);
         |                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sl.c:218:99: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     218 |         hws[IMX6SL_CLK_PLL2] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc", base + 0x30, 0x1);
         |                                                                                                   ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sl.c:219:99: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     219 |         hws[IMX6SL_CLK_PLL3] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll3", "osc", base + 0x10, 0x3);
         |                                                                                                   ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sl.c:220:100: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     220 |         hws[IMX6SL_CLK_PLL4] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll4", "osc", base + 0x70, 0x7f);
         |                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sl.c:221:100: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     221 |         hws[IMX6SL_CLK_PLL5] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll5", "osc", base + 0xa0, 0x7f);
         |                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sl.c:222:99: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     222 |         hws[IMX6SL_CLK_PLL6] = imx_clk_hw_pllv3(IMX_PLLV3_ENET,    "pll6", "osc", base + 0xe0, 0x3);
         |                                                                                                   ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sl.c:223:99: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     223 |         hws[IMX6SL_CLK_PLL7] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll7", "osc", base + 0x20, 0x3);
         |                                                                                                   ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
--
   In file included from drivers/clk/imx/clk-imx6sll.c:17:
   drivers/clk/imx/clk.h:268:74: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     268 |                 const char *parent_name, void __iomem *base, u32 div_mask);
         |                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sll.c: In function 'imx6sll_clocks_init':
>> drivers/clk/imx/clk-imx6sll.c:123:110: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     123 |         hws[IMX6SLL_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,  "pll1", "pll1_bypass_src", base + 0x00, 0x7f);
         |                                                                                                              ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sll.c:124:112: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     124 |         hws[IMX6SLL_CLK_PLL2] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "pll2_bypass_src", base + 0x30, 0x1);
         |                                                                                                                ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sll.c:125:109: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     125 |         hws[IMX6SLL_CLK_PLL3] = imx_clk_hw_pllv3(IMX_PLLV3_USB,  "pll3", "pll3_bypass_src", base + 0x10, 0x3);
         |                                                                                                             ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sll.c:126:110: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     126 |         hws[IMX6SLL_CLK_PLL4] = imx_clk_hw_pllv3(IMX_PLLV3_AV,   "pll4", "pll4_bypass_src", base + 0x70, 0x7f);
         |                                                                                                              ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sll.c:127:110: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     127 |         hws[IMX6SLL_CLK_PLL5] = imx_clk_hw_pllv3(IMX_PLLV3_AV,   "pll5", "pll5_bypass_src", base + 0xa0, 0x7f);
         |                                                                                                              ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sll.c:128:117: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     128 |         hws[IMX6SLL_CLK_PLL6] = imx_clk_hw_pllv3(IMX_PLLV3_ENET,         "pll6", "pll6_bypass_src", base + 0xe0, 0x3);
         |                                                                                                                     ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sll.c:129:109: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     129 |         hws[IMX6SLL_CLK_PLL7] = imx_clk_hw_pllv3(IMX_PLLV3_USB,  "pll7", "pll7_bypass_src", base + 0x20, 0x3);
         |                                                                                                             ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
--
   In file included from drivers/clk/imx/clk-imx6sx.c:19:
   drivers/clk/imx/clk.h:268:74: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     268 |                 const char *parent_name, void __iomem *base, u32 div_mask);
         |                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sx.c: In function 'imx6sx_clocks_init':
>> drivers/clk/imx/clk-imx6sx.c:160:100: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     160 |         hws[IMX6SX_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc", base + 0x00, 0x7f);
         |                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sx.c:161:99: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     161 |         hws[IMX6SX_CLK_PLL2] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc", base + 0x30, 0x1);
         |                                                                                                   ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sx.c:162:99: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     162 |         hws[IMX6SX_CLK_PLL3] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll3", "osc", base + 0x10, 0x3);
         |                                                                                                   ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sx.c:163:100: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     163 |         hws[IMX6SX_CLK_PLL4] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll4", "osc", base + 0x70, 0x7f);
         |                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sx.c:164:100: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     164 |         hws[IMX6SX_CLK_PLL5] = imx_clk_hw_pllv3(IMX_PLLV3_AV,      "pll5", "osc", base + 0xa0, 0x7f);
         |                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sx.c:165:99: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     165 |         hws[IMX6SX_CLK_PLL6] = imx_clk_hw_pllv3(IMX_PLLV3_ENET,    "pll6", "osc", base + 0xe0, 0x3);
         |                                                                                                   ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6sx.c:166:99: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     166 |         hws[IMX6SX_CLK_PLL7] = imx_clk_hw_pllv3(IMX_PLLV3_USB,     "pll7", "osc", base + 0x20, 0x3);
         |                                                                                                   ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
--
   In file included from drivers/clk/imx/clk-imx6ul.c:18:
   drivers/clk/imx/clk.h:268:74: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     268 |                 const char *parent_name, void __iomem *base, u32 div_mask);
         |                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6ul.c: In function 'imx6ul_clocks_init':
>> drivers/clk/imx/clk-imx6ul.c:149:98: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     149 |         hws[IMX6UL_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,   "pll1", "osc", base + 0x00, 0x7f);
         |                                                                                                  ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6ul.c:150:99: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     150 |         hws[IMX6UL_CLK_PLL2] = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll2", "osc", base + 0x30, 0x1);
         |                                                                                                   ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6ul.c:151:97: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     151 |         hws[IMX6UL_CLK_PLL3] = imx_clk_hw_pllv3(IMX_PLLV3_USB,   "pll3", "osc", base + 0x10, 0x3);
         |                                                                                                 ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6ul.c:152:98: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     152 |         hws[IMX6UL_CLK_PLL4] = imx_clk_hw_pllv3(IMX_PLLV3_AV,    "pll4", "osc", base + 0x70, 0x7f);
         |                                                                                                  ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6ul.c:153:98: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     153 |         hws[IMX6UL_CLK_PLL5] = imx_clk_hw_pllv3(IMX_PLLV3_AV,    "pll5", "osc", base + 0xa0, 0x7f);
         |                                                                                                  ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6ul.c:154:97: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     154 |         hws[IMX6UL_CLK_PLL6] = imx_clk_hw_pllv3(IMX_PLLV3_ENET,  "pll6", "osc", base + 0xe0, 0x3);
         |                                                                                                 ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx6ul.c:155:97: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     155 |         hws[IMX6UL_CLK_PLL7] = imx_clk_hw_pllv3(IMX_PLLV3_USB,   "pll7", "osc", base + 0x20, 0x3);
         |                                                                                                 ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
--
   In file included from drivers/clk/imx/clk-imx7d.c:19:
   drivers/clk/imx/clk.h:268:74: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     268 |                 const char *parent_name, void __iomem *base, u32 div_mask);
         |                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx7d.c: In function 'imx7d_clocks_init':
>> drivers/clk/imx/clk-imx7d.c:409:108: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     409 |         hws[IMX7D_PLL_ARM_MAIN]  = imx_clk_hw_pllv3(IMX_PLLV3_SYS, "pll_arm_main", "osc", base + 0x60, 0x7f);
         |                                                                                                            ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx7d.c:410:114: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     410 |         hws[IMX7D_PLL_DRAM_MAIN] = imx_clk_hw_pllv3(IMX_PLLV3_DDR_IMX7, "pll_dram_main", "osc", base + 0x70, 0x7f);
         |                                                                                                                  ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx7d.c:411:111: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     411 |         hws[IMX7D_PLL_SYS_MAIN]  = imx_clk_hw_pllv3(IMX_PLLV3_GENERIC, "pll_sys_main", "osc", base + 0xb0, 0x1);
         |                                                                                                               ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx7d.c:412:114: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     412 |         hws[IMX7D_PLL_ENET_MAIN] = imx_clk_hw_pllv3(IMX_PLLV3_ENET_IMX7, "pll_enet_main", "osc", base + 0xe0, 0x0);
         |                                                                                                                  ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx7d.c:413:115: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     413 |         hws[IMX7D_PLL_AUDIO_MAIN] = imx_clk_hw_pllv3(IMX_PLLV3_AV_IMX7, "pll_audio_main", "osc", base + 0xf0, 0x7f);
         |                                                                                                                   ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-imx7d.c:414:116: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     414 |         hws[IMX7D_PLL_VIDEO_MAIN] = imx_clk_hw_pllv3(IMX_PLLV3_AV_IMX7, "pll_video_main", "osc", base + 0x130, 0x7f);
         |                                                                                                                    ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
--
   In file included from drivers/clk/imx/clk-vf610.c:12:
   drivers/clk/imx/clk.h:268:74: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     268 |                 const char *parent_name, void __iomem *base, u32 div_mask);
         |                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-vf610.c: In function 'vf610_clocks_init':
>> drivers/clk/imx/clk-vf610.c:219:107: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     219 |         clk[VF610_CLK_PLL1] = imx_clk_pllv3(IMX_PLLV3_SYS_VF610, "pll1", "pll1_bypass_src", PLL1_CTRL, 0x1);
         |                                                                                                           ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-vf610.c:220:107: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     220 |         clk[VF610_CLK_PLL2] = imx_clk_pllv3(IMX_PLLV3_SYS_VF610, "pll2", "pll2_bypass_src", PLL2_CTRL, 0x1);
         |                                                                                                           ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-vf610.c:221:111: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     221 |         clk[VF610_CLK_PLL3] = imx_clk_pllv3(IMX_PLLV3_USB_VF610,     "pll3", "pll3_bypass_src", PLL3_CTRL, 0x2);
         |                                                                                                               ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-vf610.c:222:106: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     222 |         clk[VF610_CLK_PLL4] = imx_clk_pllv3(IMX_PLLV3_AV,      "pll4", "pll4_bypass_src", PLL4_CTRL, 0x7f);
         |                                                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-vf610.c:223:105: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     223 |         clk[VF610_CLK_PLL5] = imx_clk_pllv3(IMX_PLLV3_ENET,    "pll5", "pll5_bypass_src", PLL5_CTRL, 0x3);
         |                                                                                                         ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-vf610.c:224:106: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     224 |         clk[VF610_CLK_PLL6] = imx_clk_pllv3(IMX_PLLV3_AV,      "pll6", "pll6_bypass_src", PLL6_CTRL, 0x7f);
         |                                                                                                          ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 
   drivers/clk/imx/clk-vf610.c:225:111: error: macro "imx_clk_hw_pllv3" requires 8 arguments, but only 5 given
     225 |         clk[VF610_CLK_PLL7] = imx_clk_pllv3(IMX_PLLV3_USB_VF610,     "pll7", "pll7_bypass_src", PLL7_CTRL, 0x2);
         |                                                                                                               ^
   drivers/clk/imx/clk.h:107: note: macro "imx_clk_hw_pllv3" defined here
     107 | #define imx_clk_hw_pllv3(name, parent_names, num_parents, parent,       \
         | 


vim +/imx_clk_hw_pllv3 +477 drivers/clk/imx/clk-imx6q.c

992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  430  
53bb71da1c5c14 arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2013-05-21  431  static void __init imx6q_clocks_init(struct device_node *ccm_node)
2acd1b6f889c04 arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2012-04-04  432  {
2acd1b6f889c04 arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2012-04-04  433  	struct device_node *np;
5d283b08380086 drivers/clk/imx/clk-imx6q.c   Fabio Estevam 2016-10-17  434  	void __iomem *anatop_base, *base;
a94f8ecb2f778f arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2013-07-18  435  	int ret;
2acd1b6f889c04 arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2012-04-04  436  
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  437  	clk_hw_data = kzalloc(struct_size(clk_hw_data, hws,
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  438  					  IMX6QDL_CLK_END), GFP_KERNEL);
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  439  	if (WARN_ON(!clk_hw_data))
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  440  		return;
2acd1b6f889c04 arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2012-04-04  441  
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  442  	clk_hw_data->num = IMX6QDL_CLK_END;
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  443  	hws = clk_hw_data->hws;
a29be9185d195b drivers/clk/imx/clk-imx6q.c   Lucas Stach   2018-11-15  444  
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  445  	hws[IMX6QDL_CLK_DUMMY] = imx_clk_hw_fixed("dummy", 0);
a29be9185d195b drivers/clk/imx/clk-imx6q.c   Lucas Stach   2018-11-15  446  
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  447  	hws[IMX6QDL_CLK_CKIL] = imx6q_obtain_fixed_clk_hw(ccm_node, "ckil", 0);
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  448  	hws[IMX6QDL_CLK_CKIH] = imx6q_obtain_fixed_clk_hw(ccm_node, "ckih1", 0);
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  449  	hws[IMX6QDL_CLK_OSC] = imx6q_obtain_fixed_clk_hw(ccm_node, "osc", 0);
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  450  
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  451  	/* Clock source from external clock via CLK1/2 PADs */
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  452  	hws[IMX6QDL_CLK_ANACLK1] = imx6q_obtain_fixed_clk_hw(ccm_node, "anaclk1", 0);
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  453  	hws[IMX6QDL_CLK_ANACLK2] = imx6q_obtain_fixed_clk_hw(ccm_node, "anaclk2", 0);
2acd1b6f889c04 arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2012-04-04  454  
2acd1b6f889c04 arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2012-04-04  455  	np = of_find_compatible_node(NULL, NULL, "fsl,imx6q-anatop");
5d283b08380086 drivers/clk/imx/clk-imx6q.c   Fabio Estevam 2016-10-17  456  	anatop_base = base = of_iomap(np, 0);
2acd1b6f889c04 arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2012-04-04  457  	WARN_ON(!base);
c9ec1d8fef31b5 drivers/clk/imx/clk-imx6q.c   Yangtao Li    2018-12-26  458  	of_node_put(np);
2acd1b6f889c04 arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2012-04-04  459  
2df1d026edc11e arch/arm/mach-imx/clk-imx6q.c Philipp Zabel 2013-03-29  460  	/* Audio/video PLL post dividers do not work on i.MX6q revision 1.0 */
961dfd37fa165c arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2015-04-26  461  	if (clk_on_imx6q() && imx_get_soc_revision() == IMX_CHIP_REVISION_1_0) {
2df1d026edc11e arch/arm/mach-imx/clk-imx6q.c Philipp Zabel 2013-03-29  462  		post_div_table[1].div = 1;
2df1d026edc11e arch/arm/mach-imx/clk-imx6q.c Philipp Zabel 2013-03-29  463  		post_div_table[2].div = 1;
2df1d026edc11e arch/arm/mach-imx/clk-imx6q.c Philipp Zabel 2013-03-29  464  		video_div_table[1].div = 1;
81ef447950bf09 arch/arm/mach-imx/clk-imx6q.c Gary Bisson   2014-12-03  465  		video_div_table[3].div = 1;
d2a10a1727b394 arch/arm/mach-imx/clk-imx6q.c Dmitry Voytik 2014-11-06  466  	}
2df1d026edc11e arch/arm/mach-imx/clk-imx6q.c Philipp Zabel 2013-03-29  467  
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  468  	hws[IMX6QDL_PLL1_BYPASS_SRC] = imx_clk_hw_mux("pll1_bypass_src", base + 0x00, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  469  	hws[IMX6QDL_PLL2_BYPASS_SRC] = imx_clk_hw_mux("pll2_bypass_src", base + 0x30, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  470  	hws[IMX6QDL_PLL3_BYPASS_SRC] = imx_clk_hw_mux("pll3_bypass_src", base + 0x10, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  471  	hws[IMX6QDL_PLL4_BYPASS_SRC] = imx_clk_hw_mux("pll4_bypass_src", base + 0x70, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  472  	hws[IMX6QDL_PLL5_BYPASS_SRC] = imx_clk_hw_mux("pll5_bypass_src", base + 0xa0, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  473  	hws[IMX6QDL_PLL6_BYPASS_SRC] = imx_clk_hw_mux("pll6_bypass_src", base + 0xe0, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29  474  	hws[IMX6QDL_PLL7_BYPASS_SRC] = imx_clk_hw_mux("pll7_bypass_src", base + 0x20, 14, 2, pll_bypass_src_sels, ARRAY_SIZE(pll_bypass_src_sels));
b1f156db47ae91 arch/arm/mach-imx/clk-imx6q.c Shawn Guo     2014-09-01  475  
2b254693bef4f1 arch/arm/mach-imx/clk-imx6q.c Sascha Hauer  2012-11-22  476  	/*                                    type               name    parent_name        base         div_mask */
992b703b5b3897 drivers/clk/imx/clk-imx6q.c   Abel Vesa     2019-05-29 @477  	hws[IMX6QDL_CLK_PLL1] = imx_clk_hw_pllv3(IMX_PLLV3_SYS,     "pll1", "osc", base + 0x00, 0x7f);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
