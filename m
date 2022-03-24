Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2F894E60BA
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349079AbiCXI6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349100AbiCXI5y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:57:54 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 680CC9D076
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648112183; x=1679648183;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=C2952FGpo5poKrxvnx+hON8VkfkNKOtXpMXDlfWiN9M=;
  b=hXD5U65RT63nbooiWltobfiht046ttuyiedHSHFV0BI1q0pRWgkARL1S
   vADmbpUl0XREJMxrvOtZRTuswqPibfis7CgZ/Coc5alOQ0EJuZhq1e6cw
   D6HAyk8HAPYrjvCR4bEXJKFtWsadMdSYRaurbVq2gTxJE6layUQOXk5/V
   uC5lN50oFBWUJqoP5FptE385A5ABROU3wEsoVM+4wI4ttxDAE+X3I1pDN
   3pVogPBcrHU6j4W8QKFidDmIaamMGfNuZmjTz4Fr8hmzP0aQGZNtqK4BS
   2eQPDPsbTRKQLZAy0AnyUTYZZhLMv1IfDsSu6tOynvTlnINQNHsGl+aY8
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10295"; a="258034523"
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="258034523"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2022 01:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,206,1643702400"; 
   d="scan'208";a="516096414"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 24 Mar 2022 01:56:19 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nXJGV-000Ktv-55; Thu, 24 Mar 2022 08:56:19 +0000
Date:   Thu, 24 Mar 2022 16:56:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     ryan_chen <ryan_chen@aspeedtech.com>, BMC-SW@aspeedtech.com,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 2/2] i2c:aspeed:support ast2600 i2c new register mode
 driver
Message-ID: <202203241617.RVjnwFdn-lkp@intel.com>
References: <20220323004009.943298-3-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323004009.943298-3-ryan_chen@aspeedtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ryan_chen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on robh/for-next pza/reset/next v5.17 next-20220323]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/ryan_chen/Add-ASPEED-AST2600-I2C-new-controller-driver/20220323-084205
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220324/202203241617.RVjnwFdn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 902f4708fe1d03b0de7e5315ef875006a6adc319)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/0day-ci/linux/commit/4fa1d6c517dfca057852514880a8e52e5da51572
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review ryan_chen/Add-ASPEED-AST2600-I2C-new-controller-driver/20220323-084205
        git checkout 4fa1d6c517dfca057852514880a8e52e5da51572
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/i2c/busses/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/i2c/busses/i2c-new-aspeed.c:1407:19: warning: cast to smaller integer type 'u32' (aka 'unsigned int') from 'void *' [-Wvoid-pointer-to-int-cast]
           u8 i2c_count = (((u32)(i2c_bus->reg_base) & 0xFFF)/0x80);
                            ^~~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1407 drivers/i2c/busses/i2c-new-aspeed.c

  1402	
  1403	static void aspeed_new_i2c_init(struct aspeed_new_i2c_bus *i2c_bus)
  1404	{
  1405		struct platform_device *pdev = to_platform_device(i2c_bus->dev);
  1406		u32 fun_ctrl = AST_I2CC_BUS_AUTO_RELEASE | AST_I2CC_MASTER_EN;
> 1407		u8 i2c_count = (((u32)(i2c_bus->reg_base) & 0xFFF)/0x80);
  1408	
  1409		/* I2C Reset */
  1410		writel(0, i2c_bus->reg_base + AST_I2CC_FUN_CTRL);
  1411	
  1412		if (of_property_read_bool(pdev->dev.of_node, "multi-master"))
  1413			i2c_bus->multi_master = true;
  1414		else
  1415			fun_ctrl |= AST_I2CC_MULTI_MASTER_DIS;
  1416	
  1417		/* AST2600 i2c10 need to overcome sda glich with is flag. */
  1418		if (i2c_count == 0xA)
  1419			fun_ctrl |= AST_I2CC_SDA_DRIVE_1T_EN;
  1420	
  1421		/* Enable Master Mode */
  1422		writel(fun_ctrl, i2c_bus->reg_base + AST_I2CC_FUN_CTRL);
  1423		/* disable slave address */
  1424		writel(0, i2c_bus->reg_base + AST_I2CS_ADDR_CTRL);
  1425	
  1426		/* Set AC Timing */
  1427		writel(aspeed_select_i2c_clock(i2c_bus), i2c_bus->reg_base + AST_I2CC_AC_TIMING);
  1428	
  1429		/* Clear Interrupt */
  1430		writel(0xfffffff, i2c_bus->reg_base + AST_I2CM_ISR);
  1431	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
