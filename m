Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0D557EB24
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 03:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiGWByK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 21:54:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbiGWBx6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 21:53:58 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2841BBB8DF
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 18:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658541233; x=1690077233;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7JtBDVGVVgdUslbHkdrQhs/lqMmJRI+S9rhzt0JivF0=;
  b=AYSxbxEYcLhz7CEZPjszV38ge8tAbgcNQkffUzldJpwtTuYtFLZpD8PC
   4ThljY8fi4d1ST8lDDzQSg7vbn8nDTQvFxpAmP65tsavGPQYNRWTiUoKW
   LGmWpNzhCHqthLpbApviFCfi2BSnxM07suNgAyL/Su7XGdXddITfDvDUD
   ETPTKSv2puq8UnxUabWBSQX7KHA4656bpyjv/NOBiJmwyGLJH3WmdW00j
   78fBfwp7FL8+ThNpm3BBT1VnJ2lzbEz009MqkUH0vxdKnWBbISC7r5t/u
   6fu9t8Fjm2K8oz2QUOA5VJ2soD3qYCy4CsNqrkF33PzvABwVLAdcz1Mup
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10416"; a="284984572"
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="284984572"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jul 2022 18:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,186,1654585200"; 
   d="scan'208";a="631758819"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 22 Jul 2022 18:53:50 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oF4L0-00022x-0W;
        Sat, 23 Jul 2022 01:53:50 +0000
Date:   Sat, 23 Jul 2022 09:53:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org
Subject: Re: [PATCH 1/1] drivers/clk/keystone: avoid a memory leak
Message-ID: <202207230958.CDbs3UDB-lkp@intel.com>
References: <20220722041343.39492-1-ruc_gongyuanjun@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722041343.39492-1-ruc_gongyuanjun@163.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Yuanjun,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on clk/clk-next]
[also build test WARNING on linus/master v5.19-rc7 next-20220722]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Yuanjun-Gong/drivers-clk-keystone-avoid-a-memory-leak/20220722-121453
base:   https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git clk-next
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220723/202207230958.CDbs3UDB-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 72686d68c137551cce816416190a18d45b4d4e2a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/c8db4a192822cdb1e77a32238a893d7a81081f80
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yuanjun-Gong/drivers-clk-keystone-avoid-a-memory-leak/20220722-121453
        git checkout c8db4a192822cdb1e77a32238a893d7a81081f80
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/keystone/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/clk/keystone/syscon-clk.c:88:3: warning: misleading indentation; statement is not part of the previous 'if' [-Wmisleading-indentation]
                   return ERR_PTR(ret);
                   ^
   drivers/clk/keystone/syscon-clk.c:86:2: note: previous statement is here
           if (ret)
           ^
   1 warning generated.


vim +/if +88 drivers/clk/keystone/syscon-clk.c

1aa0817e43c525 Vignesh Raghavendra 2020-02-27  61  
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  62  static struct clk_hw
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  63  *ti_syscon_gate_clk_register(struct device *dev, struct regmap *regmap,
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  64  			     const struct ti_syscon_gate_clk_data *data)
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  65  {
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  66  	struct ti_syscon_gate_clk_priv *priv;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  67  	struct clk_init_data init;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  68  	int ret;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  69  
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  70  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  71  	if (!priv)
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  72  		return ERR_PTR(-ENOMEM);
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  73  
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  74  	init.name = data->name;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  75  	init.ops = &ti_syscon_gate_clk_ops;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  76  	init.parent_names = NULL;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  77  	init.num_parents = 0;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  78  	init.flags = 0;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  79  
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  80  	priv->regmap = regmap;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  81  	priv->reg = data->offset;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  82  	priv->idx = BIT(data->bit_idx);
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  83  	priv->hw.init = &init;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  84  
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  85  	ret = devm_clk_hw_register(dev, &priv->hw);
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  86  	if (ret)
c8db4a192822cd Yuanjun Gong        2022-07-22  87  		devm_kfree(dev, priv);
1aa0817e43c525 Vignesh Raghavendra 2020-02-27 @88  		return ERR_PTR(ret);
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  89  
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  90  	return &priv->hw;
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  91  }
1aa0817e43c525 Vignesh Raghavendra 2020-02-27  92  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
