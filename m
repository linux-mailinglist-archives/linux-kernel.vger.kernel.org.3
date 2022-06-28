Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 107A855D367
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:12:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243057AbiF1B30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 21:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243044AbiF1B3Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 21:29:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3104766D;
        Mon, 27 Jun 2022 18:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656379763; x=1687915763;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=zVM39Trhl2hg5S6mqEpQJmIRMAE8wh097bxFRFFGXL8=;
  b=ik8doJj4eEQ2GN5ht0IN+XgYFEV/q/WN2BkA5bbbi0SQr+l+rdB6es5w
   B31gFmpa4ij5mJZ3KhbjRBKD9yDi3H6HUugUP/fijqNzrJvzn152tZGCL
   e+FA3YKCIRuLzjwDg7kb8oZHAoWh+soBzbb8bXp5xguE0dgPA4mHSUwo1
   OYGQxOX+cN7ENDo1ar+rNbks8b/za/5QVtcuZ1O6P5jXoQo/qa+U/9Noy
   x9yr/HvyJPxe1f4CKHgvsVwbpWvWsoHc5yVKQvagR6TYQHuIN/me/MlHm
   LhWbsv4XZ1roAmIVQVjQ25RCnB5sj1yM/Z9r1fLU4omnC6WIJsXn5mL6f
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10391"; a="279149560"
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="279149560"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jun 2022 18:29:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,227,1650956400"; 
   d="scan'208";a="732546014"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 27 Jun 2022 18:29:19 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o602T-0009LC-S6;
        Tue, 28 Jun 2022 01:29:13 +0000
Date:   Tue, 28 Jun 2022 09:28:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sricharan R <quic_srichara@quicinc.com>, agross@kernel.org,
        bjorn.andersson@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linus.walleij@linaro.org,
        catalin.marinas@arm.com, p.zabel@pengutronix.de,
        quic_varada@quicinc.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH V2 3/8] clk: qcom: Add Global Clock controller (GCC)
 driver for IPQ5018
Message-ID: <202206280917.m3YJRqsF-lkp@intel.com>
References: <20220621161126.15883-4-quic_srichara@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621161126.15883-4-quic_srichara@quicinc.com>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sricharan,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on robh/for-next linusw-pinctrl/devel linus/master v5.19-rc4 next-20220627]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sricharan-R/Add-minimal-boot-support-for-IPQ5018/20220622-001751
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220628/202206280917.m3YJRqsF-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 016342e319fd31e41cf5ed16a6140a8ea2de74dd)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/d7a0e1d14ecebd407df120468035592246a71cd6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sricharan-R/Add-minimal-boot-support-for-IPQ5018/20220622-001751
        git checkout d7a0e1d14ecebd407df120468035592246a71cd6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/kernel/ drivers/clk/qcom/ drivers/pinctrl/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/qcom/gcc-ipq5018.c:118:37: warning: unused variable 'gcc_xo_gpll0_out_main_div2' [-Wunused-const-variable]
   static const struct clk_parent_data gcc_xo_gpll0_out_main_div2[] = {
                                       ^
>> drivers/clk/qcom/gcc-ipq5018.c:123:32: warning: unused variable 'gcc_xo_gpll0_out_main_div2_map' [-Wunused-const-variable]
   static const struct parent_map gcc_xo_gpll0_out_main_div2_map[] = {
                                  ^
>> drivers/clk/qcom/gcc-ipq5018.c:201:37: warning: unused variable 'gcc_xo_gpll0_gpll4_gpll2' [-Wunused-const-variable]
   static const struct clk_parent_data gcc_xo_gpll0_gpll4_gpll2[] = {
                                       ^
>> drivers/clk/qcom/gcc-ipq5018.c:208:32: warning: unused variable 'gcc_xo_gpll0_gpll4_gpll2_map' [-Wunused-const-variable]
   static const struct parent_map gcc_xo_gpll0_gpll4_gpll2_map[] = {
                                  ^
   4 warnings generated.


vim +/gcc_xo_gpll0_out_main_div2 +118 drivers/clk/qcom/gcc-ipq5018.c

   117	
 > 118	static const struct clk_parent_data gcc_xo_gpll0_out_main_div2[] = {
   119		{ .fw_name = "xo", .name = "xo", },
   120		{ .fw_name = "gpll0_out_main_div2", .name = "gpll0_out_main_div2", },
   121	};
   122	
 > 123	static const struct parent_map gcc_xo_gpll0_out_main_div2_map[] = {
   124		{ P_XO, 0 },
   125		{ P_GPLL0_DIV2, 1 },
   126	};
   127	
   128	static const struct clk_parent_data gcc_xo_gpll0_gpll4[] = {
   129		{ .fw_name = "xo", .name = "xo", },
   130		{ .fw_name = "gpll0", .name = "gpll0", },
   131		{ .fw_name = "gpll4", .name = "gpll4", },
   132	};
   133	
   134	static const struct parent_map gcc_xo_gpll0_gpll4_map[] = {
   135		{ P_XO, 0 },
   136		{ P_GPLL0, 1 },
   137		{ P_GPLL4, 2 },
   138	};
   139	
   140	static const struct clk_parent_data gcc_xo_gpll0_core_pi_sleep_clk[] = {
   141		{ .fw_name = "xo", .name = "xo", },
   142		{ .fw_name = "gpll0", .name = "gpll0", },
   143		{ .fw_name = "sleep_clk", .name = "sleep_clk", },
   144	};
   145	
   146	static const struct parent_map gcc_xo_gpll0_core_pi_sleep_clk_map[] = {
   147		{ P_XO, 0 },
   148		{ P_GPLL0, 2 },
   149		{ P_CORE_PI_SLEEP_CLK, 6 },
   150	};
   151	
   152	static const struct clk_parent_data gcc_xo_gpll0_gpll0_out_main_div2_sleep_clk[] = {
   153		{ .fw_name = "xo", .name = "xo", },
   154		{ .fw_name = "gpll0", .name = "gpll0", },
   155		{ .fw_name = "gpll0_out_main_div2", .name = "gpll0_out_main_div2", },
   156		{ .fw_name = "sleep_clk", .name = "sleep_clk", },
   157	};
   158	
   159	static const struct parent_map gcc_xo_gpll0_gpll0_out_main_div2_sleep_clk_map[] = {
   160		{ P_XO, 0 },
   161		{ P_GPLL0, 1 },
   162		{ P_GPLL0_DIV2, 4 },
   163		{ P_CORE_PI_SLEEP_CLK, 6 },
   164	};
   165	
   166	static const struct clk_parent_data gcc_xo_gpll0_gpll2_gpll0_out_main_div2[] = {
   167		{ .fw_name = "xo", .name = "xo", },
   168		{ .fw_name = "gpll0", .name = "gpll0", },
   169		{ .fw_name = "gpll2", .name = "gpll2", },
   170		{ .fw_name = "gpll0_out_main_div2", .name = "gpll0_out_main_div2", },
   171	};
   172	
   173	static const struct parent_map gcc_xo_gpll0_gpll2_gpll0_out_main_div2_map[] = {
   174		{ P_XO, 0 },
   175		{ P_GPLL0, 1 },
   176		{ P_GPLL2, 2 },
   177		{ P_GPLL0_DIV2, 4 },
   178	};
   179	
   180	static const struct clk_parent_data gcc_xo_gpll4_gpll0_gpll0_out_main_div2[] = {
   181		{ .fw_name = "xo", .name = "xo", },
   182		{ .fw_name = "gpll4", .name = "gpll4", },
   183		{ .fw_name = "gpll0", .name = "gpll0", },
   184		{ .fw_name = "gpll0_out_main_div2", .name = "gpll0_out_main_div2", },
   185	};
   186	
   187	static const struct parent_map gcc_xo_gpll4_gpll0_gpll0_out_main_div2_map1[] = {
   188		{ P_XO, 0 },
   189		{ P_GPLL4, 1 },
   190		{ P_GPLL0, 2 },
   191		{ P_GPLL0_DIV2, 4 },
   192	};
   193	
   194	static const struct parent_map gcc_xo_gpll4_gpll0_gpll0_out_main_div2_map2[] = {
   195		{ P_XO, 0 },
   196		{ P_GPLL4, 1 },
   197		{ P_GPLL0, 3 },
   198		{ P_GPLL0_DIV2, 4 },
   199	};
   200	
 > 201	static const struct clk_parent_data gcc_xo_gpll0_gpll4_gpll2[] = {
   202		{ .fw_name = "xo", .name = "xo", },
   203		{ .fw_name = "gpll0", .name = "gpll0", },
   204		{ .fw_name = "gpll4", .name = "gpll4", },
   205		{ .fw_name = "gpll2", .name = "gpll2", },
   206	};
   207	
 > 208	static const struct parent_map gcc_xo_gpll0_gpll4_gpll2_map[] = {
   209		{ P_XO, 0 },
   210		{ P_GPLL0, 1 },
   211		{ P_GPLL4, 3 },
   212		{ P_GPLL2, 4 },
   213	};
   214	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
