Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C2F5479D0
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 12:44:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236170AbiFLKoM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 06:44:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236009AbiFLKoJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 06:44:09 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8373E625B;
        Sun, 12 Jun 2022 03:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655030648; x=1686566648;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=oY4m7/TA+RKNO4Qsg0G2e91Q7hQxCUmosIWjYQ/l6PU=;
  b=PCwsomosCvftuoIGVb6uQs9Se/vjFsVMdYyO/sqQB3K/oLNkjU3EVvO9
   ixOIJAcAzwGMsWHTs/2V5Wf94RiIHb0LVO6P4M9sAhBs5PvhsUhkLiAZ3
   IdecYktAm3F0Hckr5X1Mlee2WDkFGf6aTkBw8LolLAwOjv6WDber+uqVX
   efCiNnkag+XUrlIo08tZ1yrRtk5w8m+iT5lnKCLrafu4pjBREv1l5FIkF
   7sXizNIfnkFW4D5Y/cniWTWajtb2YMIW1Y91fFAdD7wYtn+y5sON4SSv+
   X+6/nTINZI3EDPnLtKo1W06IK1i3GkMxOhtv3eTJat4nLsL0/zkZQ6jj9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="279099711"
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="279099711"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2022 03:44:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,294,1647327600"; 
   d="scan'208";a="611340376"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 12 Jun 2022 03:44:05 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0L4e-000Jqt-Dd;
        Sun, 12 Jun 2022 10:44:04 +0000
Date:   Sun, 12 Jun 2022 18:43:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>, sboyd@kernel.org
Cc:     kbuild-all@lists.01.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, mturquette@baylibre.com, linux@armlinux.org.uk,
        arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>
Subject: Re: [PATCH v17 05/10] clk: Add Sunplus SP7021 clock driver
Message-ID: <202206121806.C2ECo2lB-lkp@intel.com>
References: <65ef2bf7fc393eb373b966fe839852bcd1bacad8.1654565776.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65ef2bf7fc393eb373b966fe839852bcd1bacad8.1654565776.git.qinjian@cqplus1.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pza/reset/next]
[also build test WARNING on robh/for-next clk/clk-next tip/irq/core linus/master v5.19-rc1 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220607-100746
base:   https://git.pengutronix.de/git/pza/linux reset/next
config: microblaze-randconfig-c024-20220612 (https://download.01.org/0day-ci/archive/20220612/202206121806.C2ECo2lB-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


cocci warnings: (new ones prefixed by >>)
>> drivers/clk/clk-sp7021.c:584:2-7: WARNING: invalid free of devm_ allocated data

vim +584 drivers/clk/clk-sp7021.c

   550	
   551	static struct clk_hw *sp_pll_register(struct device *dev, const char *name,
   552					      const struct clk_parent_data *parent_data,
   553					      void __iomem *reg, int pd_bit, int bp_bit,
   554					      unsigned long brate, int shift, int width,
   555					      unsigned long flags)
   556	{
   557		struct sp_pll *pll;
   558		struct clk_hw *hw;
   559		struct clk_init_data initd = {
   560			.name = name,
   561			.parent_data = parent_data,
   562			.ops = (bp_bit >= 0) ? &sp_pll_ops : &sp_pll_sub_ops,
   563			.num_parents = 1,
   564			.flags = flags,
   565		};
   566		int ret;
   567	
   568		pll = devm_kzalloc(dev, sizeof(*pll), GFP_KERNEL);
   569		if (!pll)
   570			return ERR_PTR(-ENOMEM);
   571	
   572		pll->hw.init = &initd;
   573		pll->reg = reg;
   574		pll->pd_bit = pd_bit;
   575		pll->bp_bit = bp_bit;
   576		pll->brate = brate;
   577		pll->div_shift = shift;
   578		pll->div_width = width;
   579		spin_lock_init(&pll->lock);
   580	
   581		hw = &pll->hw;
   582		ret = devm_clk_hw_register(dev, hw);
   583		if (ret) {
 > 584			kfree(pll);
   585			return ERR_PTR(ret);
   586		}
   587	
   588		return hw;
   589	}
   590	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
