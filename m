Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E842851DFA2
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 21:27:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390582AbiEFTbB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 15:31:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236285AbiEFTbA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 15:31:00 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BD6B6A071;
        Fri,  6 May 2022 12:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651865236; x=1683401236;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AW906yaOruqYoLxGe4BkeNY7iQOHYqZeONTXC8+tXQs=;
  b=Yhf5rPi2R7+jgFG71/+bgThISjVgAL3nsVyVw0np9Uc7468BZvObfy/x
   JgyJOfliO/UtfYauC513Jd+uKdSh8gMAUnLYRQ9WgFsrmlm1m/iqUnVeF
   QooJGnYKE8xITLP/Bfl5oV5SaDK73WeBHI2JXmrYFKz7zw2a9YfZp/Q5y
   bkr2kutmrDQouZGSia8lydTDhXVz3OqmjEXyeUnwav4p3qumx5aEG9XKJ
   JFQlLx+H4mxHvyl1/ixNUZK232KvAJWXjYnQHuHZZWl8g1KfgpUVjKqVw
   V5JLRWodAZKafrRkSmtiLwY832IBOFpV7Z1ecFnMk3kTjyHP8OtxdKfRu
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10339"; a="266148817"
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="266148817"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 12:27:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,205,1647327600"; 
   d="scan'208";a="586155393"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 06 May 2022 12:27:01 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nn3bQ-000Dnw-GL;
        Fri, 06 May 2022 19:27:00 +0000
Date:   Sat, 7 May 2022 03:26:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>, krzysztof.kozlowski@linaro.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Qin Jian <qinjian@cqplus1.com>
Subject: Re: [PATCH v14 7/9] irqchip: Add Sunplus SP7021 interrupt controller
 driver
Message-ID: <202205070356.RRuPT69d-lkp@intel.com>
References: <7e469fb049959f88cf2b37649e6f3eb1d0fd3440.1651805790.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7e469fb049959f88cf2b37649e6f3eb1d0fd3440.1651805790.git.qinjian@cqplus1.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
[also build test WARNING on clk/clk-next tip/irq/core linus/master v5.18-rc5 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220506-113239
base:   https://git.pengutronix.de/git/pza/linux reset/next
config: arm64-allmodconfig (https://download.01.org/0day-ci/archive/20220507/202205070356.RRuPT69d-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 5e004fb787698440a387750db7f8028e7cb14cfc)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/e4d57016693163887d81dfa4c0b0db3e4437cf2b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220506-113239
        git checkout e4d57016693163887d81dfa4c0b0db3e4437cf2b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-sp7021-intc.c:170:16: warning: cast to smaller integer type 'int' from 'void *' [-Wvoid-pointer-to-int-cast]
           int ext_num = (int)irq_desc_get_handler_data(desc);
                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/irqchip/irq-sp7021-intc.c:218:69: warning: cast to 'void *' from smaller integer type 'int' [-Wint-to-void-pointer-cast]
           irq_set_chained_handler_and_data(irq, sp_intc_handle_ext_cascaded, (void *)i);
                                                                              ^~~~~~~~~
   2 warnings generated.


vim +170 drivers/irqchip/irq-sp7021-intc.c

   166	
   167	static void sp_intc_handle_ext_cascaded(struct irq_desc *desc)
   168	{
   169		struct irq_chip *chip = irq_desc_get_chip(desc);
 > 170		int ext_num = (int)irq_desc_get_handler_data(desc);
   171		int hwirq;
   172	
   173		chained_irq_enter(chip, desc);
   174	
   175		while ((hwirq = sp_intc_get_ext_irq(ext_num)) >= 0) {
   176			if (unlikely(IS_GPIO_INT(hwirq) && TEST_STATE(hwirq, _IS_ACTIVE))) { // WORKAROUND
   177				ASSIGN_STATE(hwirq, _IS_ACTIVE, false);
   178				sp_intc_assign_bit(hwirq, REG_INTR_POLARITY, TEST_STATE(hwirq, _IS_LOW));
   179			} else {
   180				generic_handle_domain_irq(sp_intc.domain, hwirq);
   181			}
   182		}
   183	
   184		chained_irq_exit(chip, desc);
   185	}
   186	
   187	static struct irq_chip sp_intc_chip = {
   188		.name = "sp_intc",
   189		.irq_ack = sp_intc_ack_irq,
   190		.irq_mask = sp_intc_mask_irq,
   191		.irq_unmask = sp_intc_unmask_irq,
   192		.irq_set_type = sp_intc_set_type,
   193	};
   194	
   195	static int sp_intc_irq_domain_map(struct irq_domain *domain,
   196					  unsigned int irq, irq_hw_number_t hwirq)
   197	{
   198		irq_set_chip_and_handler(irq, &sp_intc_chip, handle_level_irq);
   199		irq_set_chip_data(irq, &sp_intc_chip);
   200		irq_set_noprobe(irq);
   201	
   202		return 0;
   203	}
   204	
   205	static const struct irq_domain_ops sp_intc_dm_ops = {
   206		.xlate = irq_domain_xlate_twocell,
   207		.map = sp_intc_irq_domain_map,
   208	};
   209	
   210	static int sp_intc_irq_map(struct device_node *node, int i)
   211	{
   212		unsigned int irq;
   213	
   214		irq = irq_of_parse_and_map(node, i);
   215		if (!irq)
   216			return -ENOENT;
   217	
 > 218		irq_set_chained_handler_and_data(irq, sp_intc_handle_ext_cascaded, (void *)i);
   219	
   220		return 0;
   221	}
   222	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
