Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2D394FDC74
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 13:05:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233982AbiDLK3p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 06:29:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380840AbiDLKZs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 06:25:48 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3703213D6C;
        Tue, 12 Apr 2022 02:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649755751; x=1681291751;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Rb2OhLPdmdoOp2xQrfaVfs6H3bBcZA5IDC3PKqaob3g=;
  b=bYOJH8NGQfBqrL0nLEI7MD+FZq+zK3wAfIys0YcjO4xWRgb9xMLkepjA
   gvj1K09aknzZDWgKKu+H6ZvXMNnqqiNLVjx4bOb+mvg/0O1XxhqblvP+S
   kacxBAxmZGDIShzYScQ/xYrf9dV08KmmAQlpYUDReMQK1kUOm4o1iYmCc
   2hkkRQFOjpGA0KRrGYUL2Pn0dlLGfoKSIZ+jlJxQNZdls1gM64bfW/A+X
   U4Dgvz9QkLoUUnWlyzdN/mywCGa8KDvFHEyMCjqWIg/u/UJ6Pjb7o9gyw
   VGtyxYnwaCt8TpgVfx9TdrytPY2VwEL7Qc9rbzeqQSyklJyaNJ93NoFjv
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="261766254"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="261766254"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 02:29:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="854289795"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 12 Apr 2022 02:28:59 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neCpW-0002hb-W8;
        Tue, 12 Apr 2022 09:28:59 +0000
Date:   Tue, 12 Apr 2022 17:28:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qin Jian <qinjian@cqplus1.com>, krzysztof.kozlowski@linaro.org
Cc:     kbuild-all@lists.01.org, robh+dt@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, tglx@linutronix.de,
        maz@kernel.org, p.zabel@pengutronix.de, linux@armlinux.org.uk,
        arnd@arndb.de, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, Qin Jian <qinjian@cqplus1.com>
Subject: Re: [PATCH v13 7/9] irqchip: Add Sunplus SP7021 interrupt controller
 driver
Message-ID: <202204121739.itrMS2oq-lkp@intel.com>
References: <20437e316e49a3a66e7003a7dc5258086558ce9a.1649659095.git.qinjian@cqplus1.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20437e316e49a3a66e7003a7dc5258086558ce9a.1649659095.git.qinjian@cqplus1.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qin,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pza/reset/next]
[also build test WARNING on clk/clk-next tip/irq/core linus/master v5.18-rc2 next-20220411]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220411-145949
base:   https://git.pengutronix.de/git/pza/linux reset/next
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220412/202204121739.itrMS2oq-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/75f77401bb7a6f669659aab4efb2779bdd6aae9e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qin-Jian/Add-Sunplus-SP7021-SoC-Support/20220411-145949
        git checkout 75f77401bb7a6f669659aab4efb2779bdd6aae9e
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-sp7021-intc.c: In function 'sp_intc_handle_ext_cascaded':
>> drivers/irqchip/irq-sp7021-intc.c:170:23: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     170 |         int ext_num = (int)irq_desc_get_handler_data(desc);
         |                       ^
   drivers/irqchip/irq-sp7021-intc.c: In function 'sp_intc_irq_map':
>> drivers/irqchip/irq-sp7021-intc.c:218:76: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
     218 |         irq_set_chained_handler_and_data(irq, sp_intc_handle_ext_cascaded, (void *)i);
         |                                                                            ^


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
