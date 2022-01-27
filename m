Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F380E49ECEF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 22:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbiA0VBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 16:01:22 -0500
Received: from mga18.intel.com ([134.134.136.126]:47747 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229692AbiA0VBV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 16:01:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643317281; x=1674853281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8HYA3pRzGvCeXfHQMOUwAEwKPlfREa0XmkBpFiIDmsg=;
  b=Zv2ToDu0GZ/xtp96dheiE8WNABQ87fCA3YP9BtYNgKfIvZeBQ4aJcn53
   SxPSXNNzGCtr4wCfSbFc1/E6GG7sDtCNG7NSyGurojvPTI7DbKxsMqx1a
   iW1cLQ4xpgjrypb4aApsEpiqWIE1e9SQSOVWGYYeSh9sFidt3dEKmiBJZ
   FJUfaxYuePvgRCT/VkpaN3CX/5SnU9GlcEYK13qaT5XhVLLA0TVB6POyy
   OThUtJshok82Svkqefs9EqqWaVfutcaQwoPCji6QJjQhFbj0ZOZ0Wjoxi
   MmZuIVG8b4JxXyAVZ3IZnnqhVDRBCv84AbXcn8Vl6xg35gTtlVtb2KVLM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="230537940"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="230537940"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 13:01:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="563934143"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 27 Jan 2022 13:01:17 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nDBtM-000N2Z-RE; Thu, 27 Jan 2022 21:01:16 +0000
Date:   Fri, 28 Jan 2022 05:00:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Ryuta NAKANISHI <nakanishi.ryuta@socionext.com>
Subject: Re: [PATCH 2/3] pinctrl: uniphier: Divide pinmux group to support
 1ch and 2ch I2S
Message-ID: <202201280448.njc6LUNd-lkp@intel.com>
References: <1643283344-24911-3-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643283344-24911-3-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kunihiko,

I love your patch! Yet something to improve:

[auto build test ERROR on linusw-pinctrl/devel]
[also build test ERROR on v5.17-rc1 next-20220127]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Kunihiko-Hayashi/pinctrl-uniphier-Add-some-more-pinmux-settings/20220127-193715
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: openrisc-buildonly-randconfig-r003-20220124 (https://download.01.org/0day-ci/archive/20220128/202201280448.njc6LUNd-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e0e366a006b79517336423f8a2c72661178d5e41
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kunihiko-Hayashi/pinctrl-uniphier-Add-some-more-pinmux-settings/20220127-193715
        git checkout e0e366a006b79517336423f8a2c72661178d5e41
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=openrisc SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:12:
>> drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:958:34: error: 'aout4_groups' undeclared here (not in a function); did you mean 'aout3_groups'?
     958 |         UNIPHIER_PINMUX_FUNCTION(aout4),
         |                                  ^~~~~
   drivers/pinctrl/uniphier/pinctrl-uniphier.h:179:27: note: in definition of macro 'UNIPHIER_PINMUX_FUNCTION'
     179 |                 .groups = func##_groups,                                \
         |                           ^~~~
   In file included from include/linux/container_of.h:5,
                    from include/linux/kernel.h:21,
                    from drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:6:
>> include/linux/build_bug.h:16:51: error: bit-field '<anonymous>' width not an integer constant
      16 | #define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
         |                                                   ^
   include/linux/compiler.h:258:33: note: in expansion of macro 'BUILD_BUG_ON_ZERO'
     258 | #define __must_be_array(a)      BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
         |                                 ^~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:59: note: in expansion of macro '__must_be_array'
      55 | #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
         |                                                           ^~~~~~~~~~~~~~~
   drivers/pinctrl/uniphier/pinctrl-uniphier.h:180:31: note: in expansion of macro 'ARRAY_SIZE'
     180 |                 .num_groups = ARRAY_SIZE(func##_groups),                \
         |                               ^~~~~~~~~~
   drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:958:9: note: in expansion of macro 'UNIPHIER_PINMUX_FUNCTION'
     958 |         UNIPHIER_PINMUX_FUNCTION(aout4),
         |         ^~~~~~~~~~~~~~~~~~~~~~~~


vim +958 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c

   949	
   950	static const struct uniphier_pinmux_function uniphier_pxs2_functions[] = {
   951		UNIPHIER_PINMUX_FUNCTION(ain1),
   952		UNIPHIER_PINMUX_FUNCTION(ain2),
   953		UNIPHIER_PINMUX_FUNCTION(ain3),
   954		UNIPHIER_PINMUX_FUNCTION(ainiec1),
   955		UNIPHIER_PINMUX_FUNCTION(aout1),
   956		UNIPHIER_PINMUX_FUNCTION(aout2),
   957		UNIPHIER_PINMUX_FUNCTION(aout3),
 > 958		UNIPHIER_PINMUX_FUNCTION(aout4),
   959		UNIPHIER_PINMUX_FUNCTION(aoutiec1),
   960		UNIPHIER_PINMUX_FUNCTION(aoutiec2),
   961		UNIPHIER_PINMUX_FUNCTION(emmc),
   962		UNIPHIER_PINMUX_FUNCTION(ether_mii),
   963		UNIPHIER_PINMUX_FUNCTION(ether_rgmii),
   964		UNIPHIER_PINMUX_FUNCTION(ether_rmii),
   965		UNIPHIER_PINMUX_FUNCTION(i2c0),
   966		UNIPHIER_PINMUX_FUNCTION(i2c1),
   967		UNIPHIER_PINMUX_FUNCTION(i2c2),
   968		UNIPHIER_PINMUX_FUNCTION(i2c3),
   969		UNIPHIER_PINMUX_FUNCTION(i2c5),
   970		UNIPHIER_PINMUX_FUNCTION(i2c6),
   971		UNIPHIER_PINMUX_FUNCTION(nand),
   972		UNIPHIER_PINMUX_FUNCTION(sd),
   973		UNIPHIER_PINMUX_FUNCTION(spi0),
   974		UNIPHIER_PINMUX_FUNCTION(spi1),
   975		UNIPHIER_PINMUX_FUNCTION(system_bus),
   976		UNIPHIER_PINMUX_FUNCTION(uart0),
   977		UNIPHIER_PINMUX_FUNCTION(uart1),
   978		UNIPHIER_PINMUX_FUNCTION(uart2),
   979		UNIPHIER_PINMUX_FUNCTION(uart3),
   980		UNIPHIER_PINMUX_FUNCTION(usb0),
   981		UNIPHIER_PINMUX_FUNCTION(usb1),
   982		UNIPHIER_PINMUX_FUNCTION(usb2),
   983		UNIPHIER_PINMUX_FUNCTION(usb3),
   984	};
   985	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
