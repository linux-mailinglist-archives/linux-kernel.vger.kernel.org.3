Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29DFC55ABA2
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 18:50:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233179AbiFYQuY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 12:50:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiFYQuV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 12:50:21 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E5D15716;
        Sat, 25 Jun 2022 09:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656175820; x=1687711820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8Q0dioCzz3XTdd+w1PxCy/WGmcYQp6+onw0I1dcoBHc=;
  b=P5YJWXZ8dwEyg2lgCn8J4t7yo1/OGeTunQapRl7PIP/3FWupyNaWBfZY
   wy7BkWmLaH7Nh/my3dZumAJeZ16x3vWAn42iIp3UY/YvuFl0/51TbOYA5
   7Fh8jg44c/CTQRyL9ylDSkY202rnzCJ2BAIEfjHZv0uqZlpAjBIOvMClb
   Xulb+MY3tK/vAlJ/3huOVM23UTgc0coMythnCEU7TOTvSiDOWNeo7Nrf5
   525GryzW7qXiLG5S52WtNwmMCMjoCdSEiOfgNHbzH5lm8Qxw6itrMl3FH
   pAnPGxac+mlZuDyE/VeK7aAb0jUflJkhOIShtjOqw9yq01kFw75wZsjE7
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10389"; a="282294341"
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="282294341"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jun 2022 09:50:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,222,1650956400"; 
   d="scan'208";a="589347679"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 25 Jun 2022 09:50:17 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o58zA-000608-N0;
        Sat, 25 Jun 2022 16:50:16 +0000
Date:   Sun, 26 Jun 2022 00:49:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: pressure: bmp280: Add support for BMP380 sensor
 family
Message-ID: <202206260003.Ptgw2sOp-lkp@intel.com>
References: <20220625150921.47769-1-ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625150921.47769-1-ang.iglesiasg@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Angel,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on robh/for-next linus/master v5.19-rc3 next-20220624]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Angel-Iglesias/dt-bindings-iio-pressure-bmp085-Add-BMP380-compatible-string/20220625-231424
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: x86_64-randconfig-a001
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 42a7ddb428c999229491b0effbb1a4059149fba8)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/56e3f8aecddacdbe204fbe5e28032ef2befae647
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Angel-Iglesias/dt-bindings-iio-pressure-bmp085-Add-BMP380-compatible-string/20220625-231424
        git checkout 56e3f8aecddacdbe204fbe5e28032ef2befae647
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iio/pressure/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/pressure/bmp280-core.c:1000:10: warning: use of logical '&&' with constant operand [-Wconstant-logical-operand]
           if (tmp && BMP380_ERR_CONF_MASK) {
                   ^  ~~~~~~~~~~~~~~~~~~~~
   drivers/iio/pressure/bmp280-core.c:1000:10: note: use '&' for a bitwise operation
           if (tmp && BMP380_ERR_CONF_MASK) {
                   ^~
                   &
   drivers/iio/pressure/bmp280-core.c:1000:10: note: remove constant to silence this warning
           if (tmp && BMP380_ERR_CONF_MASK) {
                  ~^~~~~~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +1000 drivers/iio/pressure/bmp280-core.c

   945	
   946	static int bmp380_chip_config(struct bmp280_data *data)
   947	{
   948		u8 osrs;
   949		unsigned int tmp;
   950		int ret;
   951	
   952		/* configure power control register */
   953		ret = regmap_write_bits(data->regmap, BMP380_REG_POWER_CONTROL,
   954					BMP380_CTRL_SENSORS_MASK |
   955					BMP380_MODE_MASK,
   956					BMP380_CTRL_SENSORS_PRESS_EN |
   957					BMP380_CTRL_SENSORS_TEMP_EN |
   958					BMP380_MODE_NORMAL);
   959		if (ret < 0) {
   960			dev_err(data->dev,
   961				"failed to write operation control register\n");
   962			return ret;
   963		}
   964	
   965		/* configure oversampling */
   966		osrs = BMP380_OSRS_TEMP_X(data->oversampling_temp) |
   967					BMP380_OSRS_PRESS_X(data->oversampling_press);
   968	
   969		ret = regmap_write_bits(data->regmap, BMP380_REG_OSR,
   970					BMP380_OSRS_TEMP_MASK | BMP380_OSRS_PRESS_MASK,
   971					osrs);
   972		if (ret < 0) {
   973			dev_err(data->dev, "failed to write oversampling register\n");
   974			return ret;
   975		}
   976	
   977		/* configure output data rate */
   978		ret = regmap_write_bits(data->regmap, BMP380_REG_ODR,
   979					BMP380_ODRS_MASK, BMP380_ODRS_50HZ);
   980		if (ret < 0) {
   981			dev_err(data->dev, "failed to write ODR selection register\n");
   982			return ret;
   983		}
   984	
   985		/* set filter data */
   986		ret = regmap_update_bits(data->regmap, BMP380_REG_CONFIG,
   987					BMP380_FILTER_MASK, BMP380_FILTER_3X);
   988		if (ret < 0) {
   989			dev_err(data->dev, "failed to write config register\n");
   990			return ret;
   991		}
   992	
   993		/* check config error flag */
   994		ret = regmap_read(data->regmap, BMP380_REG_ERROR, &tmp);
   995		if (ret < 0) {
   996			dev_err(data->dev,
   997				"failed to read error register\n");
   998			return ret;
   999		}
> 1000		if (tmp && BMP380_ERR_CONF_MASK) {
  1001			dev_warn(data->dev,
  1002				 "sensor flagged configuration as incompatible\n");
  1003			ret = -EINVAL;
  1004		}
  1005	
  1006		return ret;
  1007	}
  1008	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
