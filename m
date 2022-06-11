Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A4654766A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 18:23:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbiFKQX2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 12:23:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiFKQX0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 12:23:26 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0996A64D2;
        Sat, 11 Jun 2022 09:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654964605; x=1686500605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5Zq9g8LTA+1hA+FsecBlfcG5IHjh6rZsFPf+8W/o9wk=;
  b=S+mX/JYDfl+sbOm6BQ4zR0dpRvvGl5AC3g2rPidUU4qZ/Kb7lM3sk9Rv
   S2zVPWB/ZUzbqKLsBYjhnorla1JiWBluqmZNn0O6Wwq1wYA6GG8HoWfjW
   +6vQxqL0TKZXJk2qV24OfQXTwbzBvHbh4QuecI6RasR9bxVtUOCCFtBbQ
   Fj8NzkwaX5ldQR7s2X/S6VOeel9taq7tnGWZEXtmkacSZ49UmOsdAVbsC
   1IYYLE5GDYQnDafJza8aLCucORHC+ZbfZq4vEBeJwSfjcpquPS/deaqR1
   Lz0eQHwFLks3doS/jEsmt6YqFG3m26fQbuxeSulRio3uY0DegRfINloig
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10375"; a="275437753"
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="275437753"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2022 09:23:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,293,1647327600"; 
   d="scan'208";a="725467052"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 11 Jun 2022 09:23:21 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o03tQ-000J4N-Qb;
        Sat, 11 Jun 2022 16:23:20 +0000
Date:   Sun, 12 Jun 2022 00:22:41 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>, sboyd@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        mturquette@baylibre.com, linux@armlinux.org.uk, arnd@arndb.de,
        olof@lixom.net, soc@kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Qin Jian <qinjian@cqplus1.com>, Marc Zyngier <maz@kernel.org>
Subject: Re: [PATCH v17 07/10] irqchip: Add Sunplus SP7021 interrupt
 controller driver
Message-ID: <202206120014.snDYJsw8-lkp@intel.com>
References: <0f1a1b0e38f4f0eaef245833c4c97a4e98619553.1654565776.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f1a1b0e38f4f0eaef245833c4c97a4e98619553.1654565776.git.qinjian@cqplus1.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
[also build test WARNING on robh/for-next clk/clk-next tip/irq/core linus/master v5.19-rc1 next-20220610]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220607-100746
base:   https://git.pengutronix.de/git/pza/linux reset/next
config: arm64-buildonly-randconfig-r005-20220611 (https://download.01.org/0day-ci/archive/20220612/202206120014.snDYJsw8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project ff4abe755279a3a47cc416ef80dbc900d9a98a19)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/5c7f5cae7ce9484dabe81e5a56fe42c5d1a37ca0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220607-100746
        git checkout 5c7f5cae7ce9484dabe81e5a56fe42c5d1a37ca0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/clk/qcom/ drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
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
