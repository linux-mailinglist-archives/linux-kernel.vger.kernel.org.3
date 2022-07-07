Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29C65569A23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 07:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234248AbiGGF6d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 01:58:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233652AbiGGF6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 01:58:30 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BB9624B;
        Wed,  6 Jul 2022 22:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657173508; x=1688709508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1mcSycqF0G5MTVNt6gTs3pvaqAtfai1uUIeXSb6aiy0=;
  b=QVsfqVSWEBVXtAOABtDxkmwihRsrYQ/JO/Hv3R+CM6Tu6tqR7BIpVvK4
   qvTpS8LRp9UYdnXw9QYT605YBCZVm+bfBlL+fskviJCED8JxW+eZ2G8t/
   vtjTPjv5vsDaMKckW5BhauCG+UdHeX0ojOnJhytWYf8aCnRj604UIm7L9
   lVXpmh2B38C8Cj3hYKH/1iY2EB15iszADOzpWjw5UgRkVE2QpmnNX7TsU
   ubw+LBq4Xgp7J1w9532rrzCllhIShq5MveYk7wprTbV9q7k5tgfxsgQxn
   ZHz4Hn3Ve+HavAXEaiZlcbHxi3fEedxcxpyMeA8iwiKHvqq5cavGShuNP
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10400"; a="283963220"
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="283963220"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2022 22:58:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,252,1650956400"; 
   d="scan'208";a="735843781"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 06 Jul 2022 22:58:25 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9KWu-000LcW-Ty;
        Thu, 07 Jul 2022 05:58:24 +0000
Date:   Thu, 7 Jul 2022 13:57:48 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christian Marangi <ansuelsmth@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Christian Marangi <ansuelsmth@gmail.com>
Subject: Re: [PATCH v3 3/3] clk: qcom: lcc-ipq806x: convert to parent data
Message-ID: <202207071312.S69DPP30-lkp@intel.com>
References: <20220706221327.14169-3-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220706221327.14169-3-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on clk/clk-next]
[also build test ERROR on linus/master v5.19-rc5 next-20220706]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Christian-Marangi/dt-bindings-clock-add-pcm-reset-for-ipq806x-lcc/20220707-061833
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: riscv-randconfig-r022-20220706 (https://download.01.org/0day-ci/archive/20220707/202207071312.S69DPP30-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 66ae1d60bb278793fd651cece264699d522bab84)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/c0d7cedbc9ad0201d611bbb386c4fda498e5449d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Christian-Marangi/dt-bindings-clock-add-pcm-reset-for-ipq806x-lcc/20220707-061833
        git checkout c0d7cedbc9ad0201d611bbb386c4fda498e5449d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/clk/qcom/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/clk/qcom/lcc-ipq806x.c:38:6: error: designator in initializer for scalar type 'const struct clk_parent_data *'
                           { .fw_name = "pxo", .name = "pxo_board" },
                             ^~~~~~~~~~~~~~~~
   1 error generated.


vim +38 drivers/clk/qcom/lcc-ipq806x.c

    26	
    27	static struct clk_pll pll4 = {
    28		.l_reg = 0x4,
    29		.m_reg = 0x8,
    30		.n_reg = 0xc,
    31		.config_reg = 0x14,
    32		.mode_reg = 0x0,
    33		.status_reg = 0x18,
    34		.status_bit = 16,
    35		.clkr.hw.init = &(struct clk_init_data){
    36			.name = "pll4",
    37			.parent_data = (const struct clk_parent_data*[]){
  > 38				{ .fw_name = "pxo", .name = "pxo_board" },
    39			}
    40			.num_parents = 1,
    41			.ops = &clk_pll_ops,
    42		},
    43	};
    44	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
