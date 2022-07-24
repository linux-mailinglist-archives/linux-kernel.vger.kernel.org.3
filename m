Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2731757F59B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 17:09:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229702AbiGXPJI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 11:09:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXPJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 11:09:06 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C0952606
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 08:09:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658675345; x=1690211345;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2zj2twotAMLMf+lSvVuLZC+JMvHB8j7TGi2OmvSBZhE=;
  b=kbGqS7WEcWarb23thqXQbnSDuKPz4Q2DTwiFtkrEuBrM/t+VjMN7AWJk
   hj1nl1blosyETc2O1spgxs/bMB7Rjd6bFjOS/Foa1TXZQtlrt/Z0ECsko
   sr6PziyVO//0NWzfrRCRscj6yugn8tMECygoZ/8CzWLDCIOGHPekdiZw5
   lHy0oiHoCbAs5B2oGq0yXfR8pTguz8dHVLMnqRTOYKt7dFkI0hnHiRfHA
   kyuf9pH5aTECnnZpD14QohPOtPTdIexk/R9wkCdIcyeXUTxQWLZWFt0ZL
   7vt09xvqodwqDS04kvW+3IJnJoOLjo88iogNdURnZTokiz0LJjKYO2msb
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10418"; a="288309734"
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="288309734"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2022 08:09:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,190,1654585200"; 
   d="scan'208";a="667199237"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 24 Jul 2022 08:09:04 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oFdE7-0003wZ-18;
        Sun, 24 Jul 2022 15:09:03 +0000
Date:   Sun, 24 Jul 2022 23:08:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Yuanjun Gong <ruc_gongyuanjun@163.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 1/1] drivers/clk/keystone: avoid a memory leak
Message-ID: <202207242329.TdOMfM0N-lkp@intel.com>
References: <20220722041343.39492-1-ruc_gongyuanjun@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220722041343.39492-1-ruc_gongyuanjun@163.com>
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
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
config: arm-defconfig (https://download.01.org/0day-ci/archive/20220724/202207242329.TdOMfM0N-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c8db4a192822cdb1e77a32238a893d7a81081f80
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Yuanjun-Gong/drivers-clk-keystone-avoid-a-memory-leak/20220722-121453
        git checkout c8db4a192822cdb1e77a32238a893d7a81081f80
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/clk/keystone/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/clk/keystone/syscon-clk.c: In function 'ti_syscon_gate_clk_register':
>> drivers/clk/keystone/syscon-clk.c:86:9: warning: this 'if' clause does not guard... [-Wmisleading-indentation]
      86 |         if (ret)
         |         ^~
   drivers/clk/keystone/syscon-clk.c:88:17: note: ...this statement, but the latter is misleadingly indented as if it were guarded by the 'if'
      88 |                 return ERR_PTR(ret);
         |                 ^~~~~~


vim +/if +86 drivers/clk/keystone/syscon-clk.c

1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  61  
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  62  static struct clk_hw
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  63  *ti_syscon_gate_clk_register(struct device *dev, struct regmap *regmap,
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  64  			     const struct ti_syscon_gate_clk_data *data)
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  65  {
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  66  	struct ti_syscon_gate_clk_priv *priv;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  67  	struct clk_init_data init;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  68  	int ret;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  69  
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  70  	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  71  	if (!priv)
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  72  		return ERR_PTR(-ENOMEM);
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  73  
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  74  	init.name = data->name;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  75  	init.ops = &ti_syscon_gate_clk_ops;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  76  	init.parent_names = NULL;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  77  	init.num_parents = 0;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  78  	init.flags = 0;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  79  
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  80  	priv->regmap = regmap;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  81  	priv->reg = data->offset;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  82  	priv->idx = BIT(data->bit_idx);
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  83  	priv->hw.init = &init;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  84  
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  85  	ret = devm_clk_hw_register(dev, &priv->hw);
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27 @86  	if (ret)
c8db4a192822cdb1 Yuanjun Gong        2022-07-22  87  		devm_kfree(dev, priv);
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  88  		return ERR_PTR(ret);
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  89  
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  90  	return &priv->hw;
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  91  }
1aa0817e43c525c3 Vignesh Raghavendra 2020-02-27  92  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
