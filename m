Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAD2515497
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380313AbiD2Tf4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:35:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238144AbiD2Tfz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:35:55 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED99692AA;
        Fri, 29 Apr 2022 12:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651260756; x=1682796756;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JndYmvyDHGDJ5FLMtua0mbKv4qhsfh22QdXtZJJmVlQ=;
  b=m91AYf/kuCNbT9zbjpYqz6+1uEpWL3ieA4Eggo+cmEzG/UeTJPhsZMwa
   KaAWOqyUXtJTOXa4Z5iCasuON5GPlH+wP+psoOD8upQRpumCMQjmM42oO
   iub29LBpzKDTK2jeibTFevSen7MYkBRYPU3UTpgNfoiMzL6FwsHvUqE5m
   1EQQ7mAgUtZXHT2R3rhPPELaBlYI5L8f73dQIpevofLYF8R1lUVTfE5sh
   Oh5uDZKc8a98VSl2PsF2gAoMFx7zMcp4BnfDGOALl0yWsi5KTLI08MbmU
   5VgQrLYZhtNL7fBUOq4MrrH50WPATWmckmTnbhswS4PYvytSkidBTWm25
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="266294483"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="266294483"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 12:32:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="566287859"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 29 Apr 2022 12:32:21 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkWLk-0006a3-Gm;
        Fri, 29 Apr 2022 19:32:20 +0000
Date:   Sat, 30 Apr 2022 03:31:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     kbuild-all@lists.01.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Elaine Zhang <zhangqing@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: Re: [PATCHv1 06/19] clk: rockchip: Add clock controller for the
 RK3588
Message-ID: <202204300329.BL2rwfwr-lkp@intel.com>
References: <20220422170920.401914-7-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422170920.401914-7-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on linusw-pinctrl/devel linus/master v5.18-rc4 next-20220429]
[cannot apply to rockchip/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Reichel/Basic-RK3588-Support/20220423-013425
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220430/202204300329.BL2rwfwr-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6736e6f1e32bb98780b77b5aa64fe5ac5dfaae26
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sebastian-Reichel/Basic-RK3588-Support/20220423-013425
        git checkout 6736e6f1e32bb98780b77b5aa64fe5ac5dfaae26
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clk/rockchip/ drivers/media/platform/qcom/venus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clk/rockchip/clk-rk3588.c: In function 'rk3588_clk_init':
>> drivers/clk/rockchip/clk-rk3588.c:2408:22: warning: variable 'clks' set but not used [-Wunused-but-set-variable]
    2408 |         struct clk **clks;
         |                      ^~~~


vim +/clks +2408 drivers/clk/rockchip/clk-rk3588.c

  2403	
  2404	static void __init rk3588_clk_init(struct device_node *np)
  2405	{
  2406		struct rockchip_clk_provider *ctx;
  2407		void __iomem *reg_base;
> 2408		struct clk **clks;
  2409	
  2410		reg_base = of_iomap(np, 0);
  2411		if (!reg_base) {
  2412			pr_err("%s: could not map cru region\n", __func__);
  2413			return;
  2414		}
  2415	
  2416		ctx = rockchip_clk_init(np, reg_base, CLK_NR_CLKS);
  2417		if (IS_ERR(ctx)) {
  2418			pr_err("%s: rockchip clk init failed\n", __func__);
  2419			iounmap(reg_base);
  2420			return;
  2421		}
  2422		clks = ctx->clk_data.clks;
  2423	
  2424		rockchip_clk_register_plls(ctx, rk3588_pll_clks,
  2425					   ARRAY_SIZE(rk3588_pll_clks),
  2426					   RK3588_GRF_SOC_STATUS0);
  2427	
  2428		rockchip_clk_register_armclk(ctx, ARMCLK_L, "armclk_l",
  2429				mux_armclkl_p, ARRAY_SIZE(mux_armclkl_p),
  2430				&rk3588_cpulclk_data, rk3588_cpulclk_rates,
  2431				ARRAY_SIZE(rk3588_cpulclk_rates));
  2432		rockchip_clk_register_armclk(ctx, ARMCLK_B01, "armclk_b01",
  2433				mux_armclkb01_p, ARRAY_SIZE(mux_armclkb01_p),
  2434				&rk3588_cpub0clk_data, rk3588_cpub0clk_rates,
  2435				ARRAY_SIZE(rk3588_cpub0clk_rates));
  2436		rockchip_clk_register_armclk(ctx, ARMCLK_B23, "armclk_b23",
  2437				mux_armclkb23_p, ARRAY_SIZE(mux_armclkb23_p),
  2438				&rk3588_cpub1clk_data, rk3588_cpub1clk_rates,
  2439				ARRAY_SIZE(rk3588_cpub1clk_rates));
  2440	
  2441		rockchip_clk_register_branches(ctx, rk3588_clk_branches,
  2442					       ARRAY_SIZE(rk3588_clk_branches));
  2443	
  2444		rockchip_register_softrst(np, 49158, reg_base + RK3588_SOFTRST_CON(0),
  2445					  ROCKCHIP_SOFTRST_HIWORD_MASK);
  2446	
  2447		rockchip_register_restart_notifier(ctx, RK3588_GLB_SRST_FST, NULL);
  2448	
  2449		rockchip_clk_of_add_provider(np, ctx);
  2450	}
  2451	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
