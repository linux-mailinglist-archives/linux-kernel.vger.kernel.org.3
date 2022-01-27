Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9845049E859
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 18:05:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244295AbiA0RFL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 12:05:11 -0500
Received: from mga03.intel.com ([134.134.136.65]:7911 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238676AbiA0RFL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 12:05:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643303110; x=1674839110;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=uDZv+CAVKC/TFSZIS03I56ur49bybLhhFrnxROt4p0U=;
  b=FQ7vAx6PX9z52bK+Nqurexd3vft8tHdYGZT8gkXwCazvIypuPpiLncOG
   Ckqv+XorGb3w65qph0ZN4641BNEQOC8PsiNIuLfY/YUP43eNVPdUxzlGW
   n+5O8eOUU7IBZ7JKaceSFndUrw9q86umox0uh+3zy99ypkWFcwUcwLAcj
   m3OPjCHt2AcPSFAX7lsAZiMnYuojyb8si+idjp5E3oPth88VH4CIdxWd5
   2lClrpTo9kFqVxbYroRbO56WWGd4MjeYCcEjptahq8AdJ+6c1nN86C5Yp
   IdvB9FQos5tEsy4VRkFNKxUBrcLSJPh8y1i5D9vHWRABcTPCxKEFLxhQe
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10239"; a="246857165"
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="246857165"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jan 2022 09:05:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,321,1635231600"; 
   d="scan'208";a="618399062"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jan 2022 09:05:05 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nD8Cm-000MpV-Cl; Thu, 27 Jan 2022 17:05:04 +0000
Date:   Fri, 28 Jan 2022 01:04:25 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Ryuta NAKANISHI <nakanishi.ryuta@socionext.com>
Subject: Re: [PATCH 2/3] pinctrl: uniphier: Divide pinmux group to support
 1ch and 2ch I2S
Message-ID: <202201280003.icgPhtLw-lkp@intel.com>
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
config: arm-randconfig-r005-20220124 (https://download.01.org/0day-ci/archive/20220128/202201280003.icgPhtLw-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project f32dccb9a43b02ce4e540d6ba5dbbdb188f2dc7d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/0day-ci/linux/commit/e0e366a006b79517336423f8a2c72661178d5e41
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Kunihiko-Hayashi/pinctrl-uniphier-Add-some-more-pinmux-settings/20220127-193715
        git checkout e0e366a006b79517336423f8a2c72661178d5e41
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/pinctrl/uniphier/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:958:2: error: use of undeclared identifier 'aout4_groups'
           UNIPHIER_PINMUX_FUNCTION(aout4),
           ^
   drivers/pinctrl/uniphier/pinctrl-uniphier.h:179:13: note: expanded from macro 'UNIPHIER_PINMUX_FUNCTION'
                   .groups = func##_groups,                                \
                             ^
   <scratch space>:175:1: note: expanded from here
   aout4_groups
   ^
>> drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:958:2: error: use of undeclared identifier 'aout4_groups'
   drivers/pinctrl/uniphier/pinctrl-uniphier.h:180:28: note: expanded from macro 'UNIPHIER_PINMUX_FUNCTION'
                   .num_groups = ARRAY_SIZE(func##_groups),                \
                                            ^
   <scratch space>:176:1: note: expanded from here
   aout4_groups
   ^
>> drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:958:2: error: use of undeclared identifier 'aout4_groups'
   drivers/pinctrl/uniphier/pinctrl-uniphier.h:180:28: note: expanded from macro 'UNIPHIER_PINMUX_FUNCTION'
                   .num_groups = ARRAY_SIZE(func##_groups),                \
                                            ^
   <scratch space>:176:1: note: expanded from here
   aout4_groups
   ^
>> drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:958:2: error: use of undeclared identifier 'aout4_groups'
   drivers/pinctrl/uniphier/pinctrl-uniphier.h:180:28: note: expanded from macro 'UNIPHIER_PINMUX_FUNCTION'
                   .num_groups = ARRAY_SIZE(func##_groups),                \
                                            ^
   <scratch space>:176:1: note: expanded from here
   aout4_groups
   ^
>> drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c:1002:21: error: invalid application of 'sizeof' to an incomplete type 'const struct uniphier_pinmux_function[]'
           .functions_count = ARRAY_SIZE(uniphier_pxs2_functions),
                              ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:32: note: expanded from macro 'ARRAY_SIZE'
   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                  ^~~~~
   5 errors generated.


vim +/aout4_groups +958 drivers/pinctrl/uniphier/pinctrl-uniphier-pxs2.c

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
   986	static int uniphier_pxs2_get_gpio_muxval(unsigned int pin,
   987						 unsigned int gpio_offset)
   988	{
   989		if (gpio_offset >= 120 && gpio_offset <= 143)	/* XIRQx */
   990			/* 15 will do because XIRQ0-23 are aliases of PORT150-177. */
   991			return 14;
   992	
   993		return 15;
   994	}
   995	
   996	static const struct uniphier_pinctrl_socdata uniphier_pxs2_pindata = {
   997		.pins = uniphier_pxs2_pins,
   998		.npins = ARRAY_SIZE(uniphier_pxs2_pins),
   999		.groups = uniphier_pxs2_groups,
  1000		.groups_count = ARRAY_SIZE(uniphier_pxs2_groups),
  1001		.functions = uniphier_pxs2_functions,
> 1002		.functions_count = ARRAY_SIZE(uniphier_pxs2_functions),
  1003		.get_gpio_muxval = uniphier_pxs2_get_gpio_muxval,
  1004		.caps = 0,
  1005	};
  1006	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
