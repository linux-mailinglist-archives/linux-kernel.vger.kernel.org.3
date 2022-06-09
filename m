Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFB3544070
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 02:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235987AbiFIAPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 20:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiFIAPN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 20:15:13 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50A224090;
        Wed,  8 Jun 2022 17:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654733711; x=1686269711;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AuKmeHqO8kg5TU3QFi7lo4/x+Zz36zZKWeKouXntz5o=;
  b=iLC9tGnFYZjomwW74F8qegclpBWLETu/bqbh6FYgobi8Kr3XCbitWtDl
   AJZbMrsfQlAbyYFxqGm5x39A+6WodGtrzISbnYdC9kRF8dGRuyrFG03fW
   qayCXoQpefvAXVaeSJqTdLOaRZ0e10NV7REQ/NIE3B42lwT5/aQDk+23d
   snCQhIacUfPKLHG3jGPwk7l2uL82GcUlkfC8YwQat4x7JrnM/CIcY9LQz
   AflDSAYSgFXxtcmXN0DLBLgFb5ApReKyGc7BKQYJLQtT70SXhh0rCDE6O
   ALmWLTK0LS7XDMQHUlQRpfXURW798gwd0tt4Nv30V9dYeRAtz7+7jt6u0
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="278254905"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="278254905"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 17:15:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="670858357"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2022 17:15:08 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz5pL-000FGB-OC;
        Thu, 09 Jun 2022 00:15:07 +0000
Date:   Thu, 9 Jun 2022 08:14:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xiaohui Zhang <xiaohuizhang@ruc.edu.cn>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Gwendal Grignou <gwendal@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jongpil Jung <jongpil19.jung@samsung.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 1/1] iio:proximity:sx9360: Fix hardware gain read/write
Message-ID: <202206090828.1Q7GljFY-lkp@intel.com>
References: <20220608010857.1720-1-xiaohuizhang@ruc.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220608010857.1720-1-xiaohuizhang@ruc.edu.cn>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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
config: openrisc-randconfig-r033-20220608 (https://download.01.org/0day-ci/archive/20220609/202206090828.1Q7GljFY-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/bdc0a6947530604152de0d152635e144a486ee32
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xiaohui-Zhang/iio-proximity-sx9360-Fix-hardware-gain-read-write/20220608-125912
        git checkout bdc0a6947530604152de0d152635e144a486ee32
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/iio/proximity/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iio/proximity/sx9360.c: In function 'sx9360_read_gain':
>> drivers/iio/proximity/sx9360.c:297:28: error: 'SX9360_REG_PROX_CTRL0_GAIN_RSVD' undeclared (first use in this function); did you mean 'SX9324_REG_PROX_CTRL0_GAIN_RSVD'?
     297 |         else if (regval == SX9360_REG_PROX_CTRL0_GAIN_RSVD ||
         |                            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                            SX9324_REG_PROX_CTRL0_GAIN_RSVD
   drivers/iio/proximity/sx9360.c:297:28: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/iio/proximity/sx9360.c:298:27: error: 'SX9360_REG_PROX_CTRL0_GAIN_8' undeclared (first use in this function); did you mean 'SX9324_REG_PROX_CTRL0_GAIN_8'?
     298 |                  regval > SX9360_REG_PROX_CTRL0_GAIN_8)
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                           SX9324_REG_PROX_CTRL0_GAIN_8
   drivers/iio/proximity/sx9360.c: In function 'sx9360_write_gain':
   drivers/iio/proximity/sx9360.c:646:32: error: 'SX9360_REG_PROX_CTRL0_GAIN_8' undeclared (first use in this function); did you mean 'SX9324_REG_PROX_CTRL0_GAIN_8'?
     646 |         if (val <= 0 || gain > SX9360_REG_PROX_CTRL0_GAIN_8)
         |                                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                SX9324_REG_PROX_CTRL0_GAIN_8
   drivers/iio/proximity/sx9360.c: At top level:
>> drivers/iio/proximity/sx9360.c:699:17: error: 'SX9360_REG_PROX_CTRL0_GAIN_1' undeclared here (not in a function); did you mean 'SX9324_REG_PROX_CTRL0_GAIN_1'?
     699 |                 SX9360_REG_PROX_CTRL0_GAIN_1 << SX9360_REG_PROX_CTRL0_GAIN_SHIFT |
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 SX9324_REG_PROX_CTRL0_GAIN_1
>> drivers/iio/proximity/sx9360.c:699:49: error: 'SX9360_REG_PROX_CTRL0_GAIN_SHIFT' undeclared here (not in a function); did you mean 'SX9324_REG_PROX_CTRL0_GAIN_SHIFT'?
     699 |                 SX9360_REG_PROX_CTRL0_GAIN_1 << SX9360_REG_PROX_CTRL0_GAIN_SHIFT |
         |                                                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                                 SX9324_REG_PROX_CTRL0_GAIN_SHIFT


vim +297 drivers/iio/proximity/sx9360.c

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
