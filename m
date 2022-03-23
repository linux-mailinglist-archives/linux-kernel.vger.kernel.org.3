Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2142A4E4BC7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 05:08:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238784AbiCWEKX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 00:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiCWEKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 00:10:20 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DAC50B28
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 21:08:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648008531; x=1679544531;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FrzGS17QkT0C68ifo1QFYnbnGDIcFo2ZdF9OFfitl38=;
  b=BSI4OpL7s4Idht8/Bhac7YlOR+p1UDpHmw6x9gZFq0p+3PtdKiH71Wn1
   QMUHIB4L3kGQPVFbqdLgdwfun0nvaAkB6g6iB7OFUKPVXoRFfjdmzqPFR
   GRsLCIB3L5dMV0sunpAK5o1gl8sbNw+fuVQI0uIM4C6Jc+v2OFNaFQgSi
   M6Au+oTgObjFSn2Mprf6V+fKgSDB8XrcmGP/3Aq5tIcGXTu8xtJcFVfAa
   3R/zPeYizdcXB1IOlPxzScn2ELBd/PBe8SBVki6PCrlqTLRTXWGSNUMNK
   XtgKjFq/2KOs8HrF14cI+TKeeQWv/86xbOZVRPyHciEZwv/WQISA5o4C8
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10294"; a="344449516"
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="344449516"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2022 21:08:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,203,1643702400"; 
   d="scan'208";a="515636423"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 22 Mar 2022 21:08:48 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nWsIh-000JdP-IE; Wed, 23 Mar 2022 04:08:47 +0000
Date:   Wed, 23 Mar 2022 12:07:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     ryan_chen <ryan_chen@aspeedtech.com>, BMC-SW@aspeedtech.com,
        Rob Herring <robh+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Ryan Chen <ryan_chen@aspeedtech.com>
Subject: Re: [PATCH 2/2] i2c:aspeed:support ast2600 i2c new register mode
 driver
Message-ID: <202203231247.KCb0uKWD-lkp@intel.com>
References: <20220323004009.943298-3-ryan_chen@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220323004009.943298-3-ryan_chen@aspeedtech.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ryan_chen,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on wsa/i2c/for-next]
[also build test WARNING on robh/for-next pza/reset/next v5.17 next-20220322]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/ryan_chen/Add-ASPEED-AST2600-I2C-new-controller-driver/20220323-084205
base:   https://git.kernel.org/pub/scm/linux/kernel/git/wsa/linux.git i2c/for-next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220323/202203231247.KCb0uKWD-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/4fa1d6c517dfca057852514880a8e52e5da51572
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review ryan_chen/Add-ASPEED-AST2600-I2C-new-controller-driver/20220323-084205
        git checkout 4fa1d6c517dfca057852514880a8e52e5da51572
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=alpha SHELL=/bin/bash drivers/i2c/busses/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/i2c/busses/i2c-new-aspeed.c: In function 'aspeed_new_i2c_init':
>> drivers/i2c/busses/i2c-new-aspeed.c:1407:26: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
    1407 |         u8 i2c_count = (((u32)(i2c_bus->reg_base) & 0xFFF)/0x80);
         |                          ^


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
