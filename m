Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84BD74A710E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 13:50:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbiBBMuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 07:50:01 -0500
Received: from mga07.intel.com ([134.134.136.100]:26298 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230258AbiBBMuA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 07:50:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643806200; x=1675342200;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vwX4YMKqr8DYGFkb6cjNG1P+9w8SjTM0cBQYWQi/MtU=;
  b=DGgGv28RCAJ3NfhUL7yu4xDn33Pc1Fzb6EaovZaDpkl3FqLnFQkkt7I6
   Jmku9arTFC8xL2d0+7aBT1A+g3BTh9eZPJYlmlo1ZIZLg+VnyARpFqyOx
   jnnjreppGz9E4o/pYV9Gvmh1Zm8Ai6qLZemJ0w62hm5+2hNZUq1Xn6Piz
   yq825Hyr7Qqqq7stzKUvZECKdWxytTjw5DV6SwfBUQHpbmyV4IzD385Nx
   Fc21Z76tGM6M9oPUeJWbRqgqDyLKgdU8tCCjoQhfYc6Fk9ePsjGJ0EbGD
   6/bXK1tJpjIjfc0QJSNKHSdgN+L9hqLQYnMBi6wZhGzqE7TX+W6ZjPHLP
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10245"; a="311215982"
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="311215982"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Feb 2022 04:49:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,336,1635231600"; 
   d="scan'208";a="627057106"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 02 Feb 2022 04:49:56 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nFF59-000Uaq-QS; Wed, 02 Feb 2022 12:49:55 +0000
Date:   Wed, 2 Feb 2022 20:49:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH 2/4] mm/kasan: Move kasan_pXX_table() and
 kasan_early_shadow_page_entry()
Message-ID: <202202022037.dX0aClQq-lkp@intel.com>
References: <3fe9bf0867b2ffc7cd43fe7040ee18d245641ec1.1643791473.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3fe9bf0867b2ffc7cd43fe7040ee18d245641ec1.1643791473.git.christophe.leroy@csgroup.eu>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/sched/core]
[also build test WARNING on linus/master v5.17-rc2]
[cannot apply to hnaz-mm/master next-20220202]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Christophe-Leroy/mm-kasan-Add-CONFIG_KASAN_SOFTWARE/20220202-164612
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ec2444530612a886b406e2830d7f314d1a07d4bb
config: mips-cu1000-neo_defconfig (https://download.01.org/0day-ci/archive/20220202/202202022037.dX0aClQq-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 6b1e844b69f15bb7dffaf9365cd2b355d2eb7579)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/0day-ci/linux/commit/23eabd57613c3b304c1c54f1133ef5376cf5731d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Christophe-Leroy/mm-kasan-Add-CONFIG_KASAN_SOFTWARE/20220202-164612
        git checkout 23eabd57613c3b304c1c54f1133ef5376cf5731d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/irqchip/irq-ingenic.c:10:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from arch/mips/include/asm/hardirq.h:16:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:21:
   In file included from include/linux/slab.h:136:
   include/linux/kasan.h:102:36: error: unknown type name 'p4d_t'
   static inline bool kasan_pud_table(p4d_t p4d)
                                      ^
   include/linux/kasan.h:113:36: error: unknown type name 'pud_t'
   static inline bool kasan_pmd_table(pud_t pud)
                                      ^
   include/linux/kasan.h:130:36: error: unknown type name 'pmd_t'
   static inline bool kasan_pte_table(pmd_t pmd)
                                      ^
>> drivers/irqchip/irq-ingenic.c:111:22: warning: shift count >= width of type [-Wshift-count-overflow]
                   gc->wake_enabled = IRQ_MSK(32);
                                      ^~~~~~~~~~~
   include/linux/irq.h:1175:41: note: expanded from macro 'IRQ_MSK'
   #define IRQ_MSK(n) (u32)((n) < 32 ? ((1 << (n)) - 1) : UINT_MAX)
                                           ^  ~~~
   drivers/irqchip/irq-ingenic.c:124:22: warning: shift count >= width of type [-Wshift-count-overflow]
                   irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
                                      ^~~~~~~~~~~
   include/linux/irq.h:1175:41: note: expanded from macro 'IRQ_MSK'
   #define IRQ_MSK(n) (u32)((n) < 32 ? ((1 << (n)) - 1) : UINT_MAX)
                                           ^  ~~~
   2 warnings and 3 errors generated.


vim +111 drivers/irqchip/irq-ingenic.c

42b64f388c171a arch/mips/jz4740/irq.c        Thomas Gleixner    2011-03-23   59  
943d69c6c21746 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   60  static int __init ingenic_intc_of_init(struct device_node *node,
943d69c6c21746 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   61  				       unsigned num_chips)
9869848d12601c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2010-07-17   62  {
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   63  	struct ingenic_intc_data *intc;
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24   64  	struct irq_chip_generic *gc;
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24   65  	struct irq_chip_type *ct;
638c885185dc2e arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   66  	struct irq_domain *domain;
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   67  	int parent_irq, err = 0;
943d69c6c21746 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   68  	unsigned i;
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   69  
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   70  	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   71  	if (!intc) {
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   72  		err = -ENOMEM;
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   73  		goto out_err;
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   74  	}
69ce4b2288d22a arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   75  
69ce4b2288d22a arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   76  	parent_irq = irq_of_parse_and_map(node, 0);
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   77  	if (!parent_irq) {
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   78  		err = -EINVAL;
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   79  		goto out_free;
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   80  	}
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   81  
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   82  	err = irq_set_handler_data(parent_irq, intc);
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   83  	if (err)
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   84  		goto out_unmap_irq;
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24   85  
943d69c6c21746 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   86  	intc->num_chips = num_chips;
3aa94590e7bf82 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   87  	intc->base = of_iomap(node, 0);
3aa94590e7bf82 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   88  	if (!intc->base) {
3aa94590e7bf82 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   89  		err = -ENODEV;
3aa94590e7bf82 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   90  		goto out_unmap_irq;
3aa94590e7bf82 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24   91  	}
9869848d12601c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2010-07-17   92  
1fd224e35c1493 drivers/irqchip/irq-ingenic.c Paul Cercueil      2020-01-13   93  	domain = irq_domain_add_linear(node, num_chips * 32,
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02   94  				       &irq_generic_chip_ops, NULL);
52ecc87642f273 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02   95  	if (!domain) {
52ecc87642f273 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02   96  		err = -ENOMEM;
52ecc87642f273 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02   97  		goto out_unmap_base;
52ecc87642f273 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02   98  	}
52ecc87642f273 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02   99  
208caadce5d4d3 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  100  	intc->domain = domain;
208caadce5d4d3 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  101  
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  102  	err = irq_alloc_domain_generic_chips(domain, 32, 1, "INTC",
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  103  					     handle_level_irq, 0,
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  104  					     IRQ_NOPROBE | IRQ_LEVEL, 0);
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  105  	if (err)
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  106  		goto out_domain_remove;
42b64f388c171a arch/mips/jz4740/irq.c        Thomas Gleixner    2011-03-23  107  
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  108  	for (i = 0; i < num_chips; i++) {
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  109  		gc = irq_get_domain_generic_chip(domain, i * 32);
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24  110  
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24 @111  		gc->wake_enabled = IRQ_MSK(32);
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  112  		gc->reg_base = intc->base + (i * CHIP_SIZE);
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24  113  
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24  114  		ct = gc->chip_types;
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24  115  		ct->regs.enable = JZ_REG_INTC_CLEAR_MASK;
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24  116  		ct->regs.disable = JZ_REG_INTC_SET_MASK;
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24  117  		ct->chip.irq_unmask = irq_gc_unmask_enable_reg;
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24  118  		ct->chip.irq_mask = irq_gc_mask_disable_reg;
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24  119  		ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24  120  		ct->chip.irq_set_wake = irq_gc_set_wake;
20b44b4de61f28 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  121  		ct->chip.flags = IRQCHIP_MASK_ON_SUSPEND;
83bc769200802c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2011-09-24  122  
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  123  		/* Mask all irqs */
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  124  		irq_reg_writel(gc, IRQ_MSK(32), JZ_REG_INTC_SET_MASK);
943d69c6c21746 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24  125  	}
9869848d12601c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2010-07-17  126  
821fc9e261f3af drivers/irqchip/irq-ingenic.c Paul Cercueil      2020-08-19  127  	if (request_irq(parent_irq, intc_cascade, IRQF_NO_SUSPEND,
2ef1cb763d92f3 drivers/irqchip/irq-ingenic.c afzal mohammed     2020-03-04  128  			"SoC intc cascade interrupt", NULL))
2ef1cb763d92f3 drivers/irqchip/irq-ingenic.c afzal mohammed     2020-03-04  129  		pr_err("Failed to register SoC intc cascade interrupt\n");
adbdce77ccc345 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24  130  	return 0;
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24  131  
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  132  out_domain_remove:
8bc7464b514021 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  133  	irq_domain_remove(domain);
52ecc87642f273 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  134  out_unmap_base:
52ecc87642f273 drivers/irqchip/irq-ingenic.c Paul Cercueil      2019-10-02  135  	iounmap(intc->base);
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24  136  out_unmap_irq:
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24  137  	irq_dispose_mapping(parent_irq);
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24  138  out_free:
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24  139  	kfree(intc);
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24  140  out_err:
fe778ece8e2522 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24  141  	return err;
9869848d12601c arch/mips/jz4740/irq.c        Lars-Peter Clausen 2010-07-17  142  }
943d69c6c21746 arch/mips/jz4740/irq.c        Paul Burton        2015-05-24  143  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
