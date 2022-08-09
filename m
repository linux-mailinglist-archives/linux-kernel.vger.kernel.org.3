Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9AD58D1DD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Aug 2022 03:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbiHIB7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 21:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiHIB7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 21:59:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9111D0E7
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 18:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660010388; x=1691546388;
  h=date:from:to:cc:subject:message-id:mime-version:
   in-reply-to;
  bh=85WhgFCin9EwWy//wwf8deMyJCuKpGxzXomii+8FcsE=;
  b=ls9EvRVmDpfgUgdXgwiWbDHgTVJzvBPVYC0dXXcka8R7RN5y8IT3Q/JC
   PHiB1IWh/VS7GU7AJ6IEcNwmC5gFoyNy2yNkS+DRL3bewjMRV0b2uNkvM
   PkXCPUnZUT7XqNOjbQE/ZKVzJLOzSIKwBTRAEQSVT664LUH2ruZNj2L4N
   xmPc6Xh+mF42sp77nSgvkwEgnxYQNwXE/CKyT45twq9Q1ZKd4u6NXIBGA
   bAk5dcNDsnog0Jm0NbCv8Vdpy9WgDhHg3QEpjbt1OFhX73JtUsY1zuaHu
   913U2LbZCVLtRlzCoaN85PnR1YS87ttKSyNjpR+cwVWGYXoAVs37lTYfT
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10433"; a="352462510"
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="352462510"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 18:59:47 -0700
X-IronPort-AV: E=Sophos;i="5.93,223,1654585200"; 
   d="scan'208";a="580604154"
Received: from rongch2-desk.sh.intel.com (HELO localhost) ([10.239.159.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2022 18:59:45 -0700
Date:   Tue, 9 Aug 2022 09:59:43 +0800
From:   kernel test robot <rong.a.chen@intel.com>
To:     Huacai Chen <chenhuacai@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Xuefeng Li <lixuefeng@loongson.cn>,
        Huacai Chen <chenhuacai@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH] irqchip: Select downstream irqchip drivers for LoongArch
 CPU
Message-ID: <YvG/jwZLwJoLla/V@rongch2-desk2>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220808085319.3350111-1-chenhuacai@loongson.cn>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Huacai,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on linus/master next-20220808]
[cannot apply to v5.19]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Huacai-Chen/irqchip-Select-downstream-irqchip-drivers-for-LoongArch-CPU/20220808-165519
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 779fda86bdeb86bad6daa4f0ecf37788dfc26f6c
config: loongarch-randconfig-r022-20220807 (https://download.01.org/0day-ci/archive/20220808/202208082052.rYETKVqt-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/72710986a76f9fec9c8c467de4960ccd8320a33e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Huacai-Chen/irqchip-Select-downstream-irqchip-drivers-for-LoongArch-CPU/20220808-165519
        git checkout 72710986a76f9fec9c8c467de4960ccd8320a33e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/irqchip/irq-loongson-pch-msi.c:88:15: error: variable 'pch_msi_domain_info' has initializer but incomplete type
      88 | static struct msi_domain_info pch_msi_domain_info = {
         |               ^~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-pch-msi.c:89:10: error: 'struct msi_domain_info' has no member named 'flags'
      89 |         .flags  = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
         |          ^~~~~
   drivers/irqchip/irq-loongson-pch-msi.c:89:19: error: 'MSI_FLAG_USE_DEF_DOM_OPS' undeclared here (not in a function)
      89 |         .flags  = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-pch-msi.c:89:46: error: 'MSI_FLAG_USE_DEF_CHIP_OPS' undeclared here (not in a function)
      89 |         .flags  = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
         |                                              ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-pch-msi.c:90:19: error: 'MSI_FLAG_MULTI_PCI_MSI' undeclared here (not in a function)
      90 |                   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
         |                   ^~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-pch-msi.c:90:44: error: 'MSI_FLAG_PCI_MSIX' undeclared here (not in a function)
      90 |                   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
         |                                            ^~~~~~~~~~~~~~~~~
>> drivers/irqchip/irq-loongson-pch-msi.c:89:19: warning: excess elements in struct initializer
      89 |         .flags  = MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
         |                   ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/irqchip/irq-loongson-pch-msi.c:89:19: note: (near initialization for 'pch_msi_domain_info')
   drivers/irqchip/irq-loongson-pch-msi.c:91:10: error: 'struct msi_domain_info' has no member named 'chip'
      91 |         .chip   = &pch_msi_irq_chip,
         |          ^~~~
   drivers/irqchip/irq-loongson-pch-msi.c:91:19: warning: excess elements in struct initializer
      91 |         .chip   = &pch_msi_irq_chip,
         |                   ^
   drivers/irqchip/irq-loongson-pch-msi.c:91:19: note: (near initialization for 'pch_msi_domain_info')
   drivers/irqchip/irq-loongson-pch-msi.c: In function 'pch_msi_init_domains':
   drivers/irqchip/irq-loongson-pch-msi.c:178:22: error: implicit declaration of function 'pci_msi_create_irq_domain'; did you mean 'pci_msi_get_device_domain'? [-Werror=implicit-function-declaration]
     178 |         msi_domain = pci_msi_create_irq_domain(domain_handle,
         |                      ^~~~~~~~~~~~~~~~~~~~~~~~~
         |                      pci_msi_get_device_domain
>> drivers/irqchip/irq-loongson-pch-msi.c:178:20: warning: assignment to 'struct irq_domain *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     178 |         msi_domain = pci_msi_create_irq_domain(domain_handle,
         |                    ^
   drivers/irqchip/irq-loongson-pch-msi.c: At top level:
   drivers/irqchip/irq-loongson-pch-msi.c:88:31: error: storage size of 'pch_msi_domain_info' isn't known
      88 | static struct msi_domain_info pch_msi_domain_info = {
         |                               ^~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for LOONGSON_PCH_MSI
   Depends on [n]: MACH_LOONGSON64 [=y] && PCI [=n]
   Selected by [y]:
   - IRQ_LOONGARCH_CPU [=y]


vim +89 drivers/irqchip/irq-loongson-pch-msi.c

632dcc2c75ef6d Jiaxun Yang 2020-05-28   87  
632dcc2c75ef6d Jiaxun Yang 2020-05-28   88  static struct msi_domain_info pch_msi_domain_info = {
632dcc2c75ef6d Jiaxun Yang 2020-05-28  @89  	.flags	= MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
632dcc2c75ef6d Jiaxun Yang 2020-05-28   90  		  MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX,
632dcc2c75ef6d Jiaxun Yang 2020-05-28   91  	.chip	= &pch_msi_irq_chip,
632dcc2c75ef6d Jiaxun Yang 2020-05-28   92  };
632dcc2c75ef6d Jiaxun Yang 2020-05-28   93  
632dcc2c75ef6d Jiaxun Yang 2020-05-28   94  static struct irq_chip middle_irq_chip = {
632dcc2c75ef6d Jiaxun Yang 2020-05-28   95  	.name			= "PCH MSI",
632dcc2c75ef6d Jiaxun Yang 2020-05-28   96  	.irq_mask		= irq_chip_mask_parent,
632dcc2c75ef6d Jiaxun Yang 2020-05-28   97  	.irq_unmask		= irq_chip_unmask_parent,
632dcc2c75ef6d Jiaxun Yang 2020-05-28   98  	.irq_ack		= irq_chip_ack_parent,
632dcc2c75ef6d Jiaxun Yang 2020-05-28   99  	.irq_set_affinity	= irq_chip_set_affinity_parent,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  100  	.irq_compose_msi_msg	= pch_msi_compose_msi_msg,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  101  };
632dcc2c75ef6d Jiaxun Yang 2020-05-28  102  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  103  static int pch_msi_parent_domain_alloc(struct irq_domain *domain,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  104  					unsigned int virq, int hwirq)
632dcc2c75ef6d Jiaxun Yang 2020-05-28  105  {
632dcc2c75ef6d Jiaxun Yang 2020-05-28  106  	struct irq_fwspec fwspec;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  107  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  108  	fwspec.fwnode = domain->parent->fwnode;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  109  	fwspec.param_count = 1;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  110  	fwspec.param[0] = hwirq;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  111  
b10cbca8f03dd1 Tiezhu Yang 2020-07-07  112  	return irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  113  }
632dcc2c75ef6d Jiaxun Yang 2020-05-28  114  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  115  static int pch_msi_middle_domain_alloc(struct irq_domain *domain,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  116  					   unsigned int virq,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  117  					   unsigned int nr_irqs, void *args)
632dcc2c75ef6d Jiaxun Yang 2020-05-28  118  {
632dcc2c75ef6d Jiaxun Yang 2020-05-28  119  	struct pch_msi_data *priv = domain->host_data;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  120  	int hwirq, err, i;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  121  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  122  	hwirq = pch_msi_allocate_hwirq(priv, nr_irqs);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  123  	if (hwirq < 0)
632dcc2c75ef6d Jiaxun Yang 2020-05-28  124  		return hwirq;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  125  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  126  	for (i = 0; i < nr_irqs; i++) {
632dcc2c75ef6d Jiaxun Yang 2020-05-28  127  		err = pch_msi_parent_domain_alloc(domain, virq + i, hwirq + i);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  128  		if (err)
632dcc2c75ef6d Jiaxun Yang 2020-05-28  129  			goto err_hwirq;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  130  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  131  		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  132  					      &middle_irq_chip, priv);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  133  	}
632dcc2c75ef6d Jiaxun Yang 2020-05-28  134  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  135  	return 0;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  136  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  137  err_hwirq:
632dcc2c75ef6d Jiaxun Yang 2020-05-28  138  	pch_msi_free_hwirq(priv, hwirq, nr_irqs);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  139  	irq_domain_free_irqs_parent(domain, virq, i - 1);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  140  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  141  	return err;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  142  }
632dcc2c75ef6d Jiaxun Yang 2020-05-28  143  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  144  static void pch_msi_middle_domain_free(struct irq_domain *domain,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  145  					   unsigned int virq,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  146  					   unsigned int nr_irqs)
632dcc2c75ef6d Jiaxun Yang 2020-05-28  147  {
632dcc2c75ef6d Jiaxun Yang 2020-05-28  148  	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  149  	struct pch_msi_data *priv = irq_data_get_irq_chip_data(d);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  150  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  151  	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  152  	pch_msi_free_hwirq(priv, d->hwirq, nr_irqs);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  153  }
632dcc2c75ef6d Jiaxun Yang 2020-05-28  154  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  155  static const struct irq_domain_ops pch_msi_middle_domain_ops = {
632dcc2c75ef6d Jiaxun Yang 2020-05-28  156  	.alloc	= pch_msi_middle_domain_alloc,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  157  	.free	= pch_msi_middle_domain_free,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  158  };
632dcc2c75ef6d Jiaxun Yang 2020-05-28  159  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  160  static int pch_msi_init_domains(struct pch_msi_data *priv,
023087324000ae Huacai Chen 2022-07-20  161  				struct irq_domain *parent,
023087324000ae Huacai Chen 2022-07-20  162  				struct fwnode_handle *domain_handle)
632dcc2c75ef6d Jiaxun Yang 2020-05-28  163  {
632dcc2c75ef6d Jiaxun Yang 2020-05-28  164  	struct irq_domain *middle_domain, *msi_domain;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  165  
023087324000ae Huacai Chen 2022-07-20  166  	middle_domain = irq_domain_create_linear(domain_handle,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  167  						priv->num_irqs,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  168  						&pch_msi_middle_domain_ops,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  169  						priv);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  170  	if (!middle_domain) {
632dcc2c75ef6d Jiaxun Yang 2020-05-28  171  		pr_err("Failed to create the MSI middle domain\n");
632dcc2c75ef6d Jiaxun Yang 2020-05-28  172  		return -ENOMEM;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  173  	}
632dcc2c75ef6d Jiaxun Yang 2020-05-28  174  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  175  	middle_domain->parent = parent;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  176  	irq_domain_update_bus_token(middle_domain, DOMAIN_BUS_NEXUS);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  177  
023087324000ae Huacai Chen 2022-07-20 @178  	msi_domain = pci_msi_create_irq_domain(domain_handle,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  179  					       &pch_msi_domain_info,
632dcc2c75ef6d Jiaxun Yang 2020-05-28  180  					       middle_domain);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  181  	if (!msi_domain) {
632dcc2c75ef6d Jiaxun Yang 2020-05-28  182  		pr_err("Failed to create PCI MSI domain\n");
632dcc2c75ef6d Jiaxun Yang 2020-05-28  183  		irq_domain_remove(middle_domain);
632dcc2c75ef6d Jiaxun Yang 2020-05-28  184  		return -ENOMEM;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  185  	}
632dcc2c75ef6d Jiaxun Yang 2020-05-28  186  
632dcc2c75ef6d Jiaxun Yang 2020-05-28  187  	return 0;
632dcc2c75ef6d Jiaxun Yang 2020-05-28  188  }
632dcc2c75ef6d Jiaxun Yang 2020-05-28  189  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
