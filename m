Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 643E054400C
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 01:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234622AbiFHXoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 19:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232615AbiFHXnn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 19:43:43 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBAC864BF8;
        Wed,  8 Jun 2022 16:45:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654731911; x=1686267911;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+QQGNxbXfmrAkH/8Zr0jWsDMVO1KlxTDhrWPFlWKtII=;
  b=A6xIFmZzXbzuSbcSnH/yDOrssMmwnZmsLZFIEkdoKWqrX6L1n9/GqNYz
   o4pddaRnMYPy/540jPk04f3gkrDrbEcO3bcMyRjoOBAf/5pJL1BrmvMWI
   ct3TaugkXTH+SLSJIdD+grxeOsDwjXkB03zpXQIqU4/JyBMuemZwer0Xg
   Z1O/C+JIABqpb32dmg9eEIMOl/n5o24dUIZqxHkpzQd7AFpGbJJrXBRH1
   IaQ2egvPV3GGP9B9L4JsNHVjONhkJa+gNGugAHb3ukKi6mUtmC/NAfW8p
   6qusOioOQLv1wAEF2U5v1xNLrMy86/T59j00+WsEYmDU62pNe1e9FEUuR
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="341179506"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="341179506"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 16:45:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="555647682"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 08 Jun 2022 16:45:07 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz5MJ-000FEx-2s;
        Wed, 08 Jun 2022 23:45:07 +0000
Date:   Thu, 9 Jun 2022 07:44:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jongpil Jung <jongpil19.jung@samsung.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH 1/1] iio:proximity:sx9360: Fix hardware gain read/write
Message-ID: <202206090719.8FcfVgxx-lkp@intel.com>
References: <20220608010857.1720-1-xiaohuizhang@ruc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608010857.1720-1-xiaohuizhang@ruc.edu.cn>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xiaohui,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on v5.19-rc1 next-20220608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Xiaohui-Zhang/iio-proximity-sx9360-Fix-hardware-gain-read-write/20220608-125912
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: hexagon-randconfig-r041-20220608 (https://download.01.org/0day-ci/archive/20220609/202206090719.8FcfVgxx-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bdc0a6947530604152de0d152635e144a486ee32
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xiaohui-Zhang/iio-proximity-sx9360-Fix-hardware-gain-read-write/20220608-125912
        git checkout bdc0a6947530604152de0d152635e144a486ee32
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/iio/proximity/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/proximity/sx9360.c:297:21: error: use of undeclared identifier 'SX9360_REG_PROX_CTRL0_GAIN_RSVD'
           else if (regval == SX9360_REG_PROX_CTRL0_GAIN_RSVD ||
                              ^
>> drivers/iio/proximity/sx9360.c:298:13: error: use of undeclared identifier 'SX9360_REG_PROX_CTRL0_GAIN_8'
                    regval > SX9360_REG_PROX_CTRL0_GAIN_8)
                             ^
   drivers/iio/proximity/sx9360.c:646:25: error: use of undeclared identifier 'SX9360_REG_PROX_CTRL0_GAIN_8'
           if (val <= 0 || gain > SX9360_REG_PROX_CTRL0_GAIN_8)
                                  ^
>> drivers/iio/proximity/sx9360.c:699:3: error: use of undeclared identifier 'SX9360_REG_PROX_CTRL0_GAIN_1'
                   SX9360_REG_PROX_CTRL0_GAIN_1 << SX9360_REG_PROX_CTRL0_GAIN_SHIFT |
                   ^
>> drivers/iio/proximity/sx9360.c:699:35: error: use of undeclared identifier 'SX9360_REG_PROX_CTRL0_GAIN_SHIFT'
                   SX9360_REG_PROX_CTRL0_GAIN_1 << SX9360_REG_PROX_CTRL0_GAIN_SHIFT |
                                                   ^
   drivers/iio/proximity/sx9360.c:702:3: error: use of undeclared identifier 'SX9360_REG_PROX_CTRL0_GAIN_1'
                   SX9360_REG_PROX_CTRL0_GAIN_1 << SX9360_REG_PROX_CTRL0_GAIN_SHIFT |
                   ^
   drivers/iio/proximity/sx9360.c:702:35: error: use of undeclared identifier 'SX9360_REG_PROX_CTRL0_GAIN_SHIFT'
                   SX9360_REG_PROX_CTRL0_GAIN_1 << SX9360_REG_PROX_CTRL0_GAIN_SHIFT |
                                                   ^
>> drivers/iio/proximity/sx9360.c:796:22: error: invalid application of 'sizeof' to an incomplete type 'const struct sx_common_reg_default[]'
           .num_default_regs = ARRAY_SIZE(sx9360_default_regs),
                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/kernel.h:55:32: note: expanded from macro 'ARRAY_SIZE'
   #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) + __must_be_array(arr))
                                  ^~~~~
   8 errors generated.


vim +/SX9360_REG_PROX_CTRL0_GAIN_RSVD +297 drivers/iio/proximity/sx9360.c

   282	
   283	static int sx9360_read_gain(struct sx_common_data *data,
   284				    const struct iio_chan_spec *chan, int *val)
   285	{
   286		unsigned int reg, regval;
   287		int ret;
   288	
   289		reg = SX9360_REG_PROX_CTRL0_PHR + chan->channel;
   290		ret = regmap_read(data->regmap, reg, &regval);
   291		if (ret)
   292			return ret;
   293	
   294		regval = FIELD_GET(SX9360_REG_PROX_CTRL0_GAIN_MASK, regval);
   295		if (regval)
   296			regval--;
 > 297		else if (regval == SX9360_REG_PROX_CTRL0_GAIN_RSVD ||
 > 298			 regval > SX9360_REG_PROX_CTRL0_GAIN_8)
   299			return -EINVAL;
   300	
   301		*val = 1 << regval;
   302	
   303		return IIO_VAL_INT;
   304	}
   305	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
