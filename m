Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3AA6539A7B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 02:45:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348843AbiFAAok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 20:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243000AbiFAAoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 20:44:38 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5EC8D69D;
        Tue, 31 May 2022 17:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654044277; x=1685580277;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Edfpulig+ThWc0bbiQuZikx3D/q8pZAAGANvXImqB7M=;
  b=cyIuT93ZHseURS5e5aue8hnMr9BNUPOsBgH8cuDCdmCFtSFPUTUsOdwF
   DUky9M/fOcubqWuzbBx3Rd4ZF+C0gordV0NQUKAuGTgeoIc/hkt8MMqNM
   tIQVuLrD9FjDjVMTwwFu3Drty/YycZN8ElA0glJwL4e5CF33zE5y+k7Lu
   kgNhJI9q1KZMM1Xd6jqnQ5C014hnnpG34eyXxsgZPT3HeWF2Lg/eCdNpD
   g05Q+f6R7LB9hOuLMcyfCjh6l7iNQdDISIzLwwun9Y86MYDHDK8O6lz6S
   7AvRFpiXdLJlWiOtIiYi2paYgnT3pHQDCeY/sOgyx5Dy38UGHDE0VcM87
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10364"; a="272995977"
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="272995977"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 17:44:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,266,1647327600"; 
   d="scan'208";a="720549427"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 31 May 2022 17:44:35 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nwCTS-0003Ie-Gz;
        Wed, 01 Jun 2022 00:44:34 +0000
Date:   Wed, 1 Jun 2022 08:44:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: Re: [PATCH v1 3/3] iio: adc: meson_saradc: Use temporary variable
 for struct device
Message-ID: <202206010812.Xy2yMeXw-lkp@intel.com>
References: <20220531211842.71998-3-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220531211842.71998-3-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on v5.18 next-20220531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/iio-adc-meson_saradc-Convert-to-use-dev_err_probe/20220601-052117
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: m68k-allyesconfig (https://download.01.org/0day-ci/archive/20220601/202206010812.Xy2yMeXw-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d2d128394df620a157f32fab808d46e5983f73e5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/iio-adc-meson_saradc-Convert-to-use-dev_err_probe/20220601-052117
        git checkout d2d128394df620a157f32fab808d46e5983f73e5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/iio/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iio/adc/meson_saradc.c: In function 'meson_sar_adc_clk_init':
>> drivers/iio/adc/meson_saradc.c:652:24: warning: 'dev' is used uninitialized [-Wuninitialized]
     652 |         struct device *dev = dev->parent;
         |                        ^~~


vim +/dev +652 drivers/iio/adc/meson_saradc.c

   646	
   647	static int meson_sar_adc_clk_init(struct iio_dev *indio_dev,
   648					  void __iomem *base)
   649	{
   650		struct meson_sar_adc_priv *priv = iio_priv(indio_dev);
   651		struct device *idev = &indio_dev->dev;
 > 652		struct device *dev = dev->parent;
   653		struct clk_init_data init;
   654		const char *clk_parents[1];
   655	
   656		init.name = devm_kasprintf(idev, GFP_KERNEL, "%s#adc_div", dev_name(dev));
   657		if (!init.name)
   658			return -ENOMEM;
   659	
   660		init.flags = 0;
   661		init.ops = &clk_divider_ops;
   662		clk_parents[0] = __clk_get_name(priv->clkin);
   663		init.parent_names = clk_parents;
   664		init.num_parents = 1;
   665	
   666		priv->clk_div.reg = base + MESON_SAR_ADC_REG3;
   667		priv->clk_div.shift = MESON_SAR_ADC_REG3_ADC_CLK_DIV_SHIFT;
   668		priv->clk_div.width = MESON_SAR_ADC_REG3_ADC_CLK_DIV_WIDTH;
   669		priv->clk_div.hw.init = &init;
   670		priv->clk_div.flags = 0;
   671	
   672		priv->adc_div_clk = devm_clk_register(idev, &priv->clk_div.hw);
   673		if (WARN_ON(IS_ERR(priv->adc_div_clk)))
   674			return PTR_ERR(priv->adc_div_clk);
   675	
   676		init.name = devm_kasprintf(idev, GFP_KERNEL, "%s#adc_en", dev_name(dev));
   677		if (!init.name)
   678			return -ENOMEM;
   679	
   680		init.flags = CLK_SET_RATE_PARENT;
   681		init.ops = &clk_gate_ops;
   682		clk_parents[0] = __clk_get_name(priv->adc_div_clk);
   683		init.parent_names = clk_parents;
   684		init.num_parents = 1;
   685	
   686		priv->clk_gate.reg = base + MESON_SAR_ADC_REG3;
   687		priv->clk_gate.bit_idx = __ffs(MESON_SAR_ADC_REG3_CLK_EN);
   688		priv->clk_gate.hw.init = &init;
   689	
   690		priv->adc_clk = devm_clk_register(idev, &priv->clk_gate.hw);
   691		if (WARN_ON(IS_ERR(priv->adc_clk)))
   692			return PTR_ERR(priv->adc_clk);
   693	
   694		return 0;
   695	}
   696	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
