Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C75550F6B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 06:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237222AbiFTE1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 00:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbiFTE07 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 00:26:59 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD995B7C2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 21:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655699217; x=1687235217;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MxhpL8JxAbz1tuojRqRwAj4NJsgjrFiz7SH1zPfeAAw=;
  b=Esdd9C8FIuGWoXBRjo83BHWNC01rAJF58Jg18YzJYC+cwSerWqFjR2zX
   EVwQV/Fz4fv46mfv/xc5zSl7ksPKnoRPuiz4+bv4N6fO6AG8UjbCtZzt+
   nvxyLrzyulE3DzvlYNoduiJq8aV8LofNMtKH35Q6J4rilsgHlBng5lpmX
   QqVNL3VUEm6ErJOd4ZOjcGpikwkUekPLJv9NFsVN7uA8Rtpeb7R6T0QRE
   hHUKTFIYAmfmhCeSS+td4ID88lAApG3ZuMSavbCZlFfEmAE4agXw37Ash
   yJKr3hpot1SOS55t7vIjEAiypGe4y4LT6CC54Oi4sHsC5ruYiBXGPp/Gg
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10380"; a="259619386"
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="259619386"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jun 2022 21:26:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="590992754"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2022 21:26:53 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o3901-000Rzr-73;
        Mon, 20 Jun 2022 04:26:53 +0000
Date:   Mon, 20 Jun 2022 12:26:24 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Samuel Holland <samuel@sholland.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Guo Ren <guoren@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH v2 2/6] genirq: GENERIC_IRQ_IPI depends on SMP
Message-ID: <202206201217.WYwGH37h-lkp@intel.com>
References: <20220616064028.57933-3-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220616064028.57933-3-samuel@sholland.org>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Samuel,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/irq/core]
[also build test ERROR on soc/for-next linus/master v5.19-rc2 next-20220617]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/genirq-irqchip-RISC-V-PLIC-cleanup-and-optimization/20220616-144300
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ac165aab469895de059a4a191a2e04ddb5421d0e
config: mips-allnoconfig (https://download.01.org/0day-ci/archive/20220620/202206201217.WYwGH37h-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project af6d2a0b6825e71965f3e2701a63c239fa0ad70f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/f8ac62a249f067a05a64eec484ac235137f2c36e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Samuel-Holland/genirq-irqchip-RISC-V-PLIC-cleanup-and-optimization/20220616-144300
        git checkout f8ac62a249f067a05a64eec484ac235137f2c36e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-mips-gic.c:479:9: error: call to undeclared function 'irq_domain_set_hwirq_and_chip'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
                         ^
   drivers/irqchip/irq-mips-gic.c:510:9: error: call to undeclared function 'irq_domain_set_hwirq_and_chip'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
                         ^
   drivers/irqchip/irq-mips-gic.c:558:6: warning: no previous prototype for function 'gic_irq_domain_free' [-Wmissing-prototypes]
   void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
        ^
   drivers/irqchip/irq-mips-gic.c:558:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
   ^
   static 
>> drivers/irqchip/irq-mips-gic.c:565:3: error: field designator 'alloc' does not refer to any field in type 'const struct irq_domain_ops'
           .alloc = gic_irq_domain_alloc,
            ^
>> drivers/irqchip/irq-mips-gic.c:566:3: error: field designator 'free' does not refer to any field in type 'const struct irq_domain_ops'
           .free = gic_irq_domain_free,
            ^
   drivers/irqchip/irq-mips-gic.c:608:9: error: call to undeclared function 'irq_domain_set_hwirq_and_chip'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   ret = irq_domain_set_hwirq_and_chip(d, virq + i, hwirq,
                         ^
>> drivers/irqchip/irq-mips-gic.c:614:42: error: no member named 'parent' in 'struct irq_domain'
                   ret = irq_domain_set_hwirq_and_chip(d->parent, virq + i, hwirq,
                                                       ~  ^
   drivers/irqchip/irq-mips-gic.c:668:3: error: field designator 'alloc' does not refer to any field in type 'const struct irq_domain_ops'
           .alloc = gic_ipi_domain_alloc,
            ^
   drivers/irqchip/irq-mips-gic.c:669:3: error: field designator 'free' does not refer to any field in type 'const struct irq_domain_ops'
           .free = gic_ipi_domain_free,
            ^
>> drivers/irqchip/irq-mips-gic.c:783:19: error: call to undeclared function 'irq_domain_add_hierarchy'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
                            ^
   drivers/irqchip/irq-mips-gic.c:783:19: note: did you mean 'irq_domain_is_hierarchy'?
   include/linux/irqdomain.h:591:20: note: 'irq_domain_is_hierarchy' declared here
   static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
                      ^
>> drivers/irqchip/irq-mips-gic.c:783:17: warning: incompatible integer to pointer conversion assigning to 'struct irq_domain *' from 'int' [-Wint-conversion]
           gic_ipi_domain = irq_domain_add_hierarchy(gic_irq_domain,
                          ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   2 warnings and 9 errors generated.


vim +/irq_domain_set_hwirq_and_chip +479 drivers/irqchip/irq-mips-gic.c

b87281e7f205ed Paul Burton         2017-04-20  464  
8ada00a650ec7e Matt Redfearn       2017-04-20  465  static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
8ada00a650ec7e Matt Redfearn       2017-04-20  466  			      irq_hw_number_t hwirq)
b87281e7f205ed Paul Burton         2017-04-20  467  {
da61fcf9d62a05 Paul Burton         2017-10-31  468  	struct gic_all_vpes_chip_data *cd;
63b746b19fa660 Paul Burton         2017-10-31  469  	unsigned long flags;
63b746b19fa660 Paul Burton         2017-10-31  470  	unsigned int intr;
da61fcf9d62a05 Paul Burton         2017-10-31  471  	int err, cpu;
63b746b19fa660 Paul Burton         2017-10-31  472  	u32 map;
6a33fa2b87513f Paul Burton         2016-08-19  473  
8ada00a650ec7e Matt Redfearn       2017-04-20  474  	if (hwirq >= GIC_SHARED_HWIRQ_BASE) {
b87281e7f205ed Paul Burton         2017-04-20  475  		/* verify that shared irqs don't conflict with an IPI irq */
b87281e7f205ed Paul Burton         2017-04-20  476  		if (test_bit(GIC_HWIRQ_TO_SHARED(hwirq), ipi_resrv))
b87281e7f205ed Paul Burton         2017-04-20  477  			return -EBUSY;
b87281e7f205ed Paul Burton         2017-04-20  478  
e875bd66dfb68f Paul Burton         2016-09-13 @479  		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
e875bd66dfb68f Paul Burton         2016-09-13  480  						    &gic_level_irq_controller,
e875bd66dfb68f Paul Burton         2016-09-13  481  						    NULL);
b87281e7f205ed Paul Burton         2017-04-20  482  		if (err)
b87281e7f205ed Paul Burton         2017-04-20  483  			return err;
b87281e7f205ed Paul Burton         2017-04-20  484  
18416e45b76189 Marc Zyngier        2017-08-18  485  		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(virq)));
b87281e7f205ed Paul Burton         2017-04-20  486  		return gic_shared_irq_domain_map(d, virq, hwirq, 0);
b87281e7f205ed Paul Burton         2017-04-20  487  	}
b87281e7f205ed Paul Burton         2017-04-20  488  
63b746b19fa660 Paul Burton         2017-10-31  489  	intr = GIC_HWIRQ_TO_LOCAL(hwirq);
63b746b19fa660 Paul Burton         2017-10-31  490  	map = GIC_MAP_PIN_MAP_TO_PIN | gic_cpu_pin;
63b746b19fa660 Paul Burton         2017-10-31  491  
dd098a0e031928 Marc Zyngier        2021-10-21  492  	/*
dd098a0e031928 Marc Zyngier        2021-10-21  493  	 * If adding support for more per-cpu interrupts, keep the the
dd098a0e031928 Marc Zyngier        2021-10-21  494  	 * array in gic_all_vpes_irq_cpu_online() in sync.
dd098a0e031928 Marc Zyngier        2021-10-21  495  	 */
63b746b19fa660 Paul Burton         2017-10-31  496  	switch (intr) {
e875bd66dfb68f Paul Burton         2016-09-13  497  	case GIC_LOCAL_INT_TIMER:
63b746b19fa660 Paul Burton         2017-10-31  498  		/* CONFIG_MIPS_CMP workaround (see __gic_init) */
63b746b19fa660 Paul Burton         2017-10-31  499  		map = GIC_MAP_PIN_MAP_TO_PIN | timer_cpu_pin;
df561f6688fef7 Gustavo A. R. Silva 2020-08-23  500  		fallthrough;
e875bd66dfb68f Paul Burton         2016-09-13  501  	case GIC_LOCAL_INT_PERFCTR:
e875bd66dfb68f Paul Burton         2016-09-13  502  	case GIC_LOCAL_INT_FDC:
e875bd66dfb68f Paul Burton         2016-09-13  503  		/*
e875bd66dfb68f Paul Burton         2016-09-13  504  		 * HACK: These are all really percpu interrupts, but
e875bd66dfb68f Paul Burton         2016-09-13  505  		 * the rest of the MIPS kernel code does not use the
e875bd66dfb68f Paul Burton         2016-09-13  506  		 * percpu IRQ API for them.
e875bd66dfb68f Paul Burton         2016-09-13  507  		 */
da61fcf9d62a05 Paul Burton         2017-10-31  508  		cd = &gic_all_vpes_chip_data[intr];
da61fcf9d62a05 Paul Burton         2017-10-31  509  		cd->map = map;
b87281e7f205ed Paul Burton         2017-04-20  510  		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
b87281e7f205ed Paul Burton         2017-04-20  511  						    &gic_all_vpes_local_irq_controller,
da61fcf9d62a05 Paul Burton         2017-10-31  512  						    cd);
b87281e7f205ed Paul Burton         2017-04-20  513  		if (err)
b87281e7f205ed Paul Burton         2017-04-20  514  			return err;
b87281e7f205ed Paul Burton         2017-04-20  515  
e875bd66dfb68f Paul Burton         2016-09-13  516  		irq_set_handler(virq, handle_percpu_irq);
e875bd66dfb68f Paul Burton         2016-09-13  517  		break;
e875bd66dfb68f Paul Burton         2016-09-13  518  
e875bd66dfb68f Paul Burton         2016-09-13  519  	default:
b87281e7f205ed Paul Burton         2017-04-20  520  		err = irq_domain_set_hwirq_and_chip(d, virq, hwirq,
b87281e7f205ed Paul Burton         2017-04-20  521  						    &gic_local_irq_controller,
b87281e7f205ed Paul Burton         2017-04-20  522  						    NULL);
b87281e7f205ed Paul Burton         2017-04-20  523  		if (err)
b87281e7f205ed Paul Burton         2017-04-20  524  			return err;
b87281e7f205ed Paul Burton         2017-04-20  525  
e875bd66dfb68f Paul Burton         2016-09-13  526  		irq_set_handler(virq, handle_percpu_devid_irq);
e875bd66dfb68f Paul Burton         2016-09-13  527  		irq_set_percpu_devid(virq);
e875bd66dfb68f Paul Burton         2016-09-13  528  		break;
e875bd66dfb68f Paul Burton         2016-09-13  529  	}
e875bd66dfb68f Paul Burton         2016-09-13  530  
63b746b19fa660 Paul Burton         2017-10-31  531  	if (!gic_local_irq_is_routable(intr))
63b746b19fa660 Paul Burton         2017-10-31  532  		return -EPERM;
63b746b19fa660 Paul Burton         2017-10-31  533  
63b746b19fa660 Paul Burton         2017-10-31  534  	spin_lock_irqsave(&gic_lock, flags);
da61fcf9d62a05 Paul Burton         2017-10-31  535  	for_each_online_cpu(cpu) {
da61fcf9d62a05 Paul Burton         2017-10-31  536  		write_gic_vl_other(mips_cm_vp_id(cpu));
6d4d367d0e9ffa Paul Burton         2019-06-05  537  		write_gic_vo_map(mips_gic_vx_map_reg(intr), map);
63b746b19fa660 Paul Burton         2017-10-31  538  	}
63b746b19fa660 Paul Burton         2017-10-31  539  	spin_unlock_irqrestore(&gic_lock, flags);
63b746b19fa660 Paul Burton         2017-10-31  540  
63b746b19fa660 Paul Burton         2017-10-31  541  	return 0;
e875bd66dfb68f Paul Burton         2016-09-13  542  }
6a33fa2b87513f Paul Burton         2016-08-19  543  
8ada00a650ec7e Matt Redfearn       2017-04-20  544  static int gic_irq_domain_alloc(struct irq_domain *d, unsigned int virq,
8ada00a650ec7e Matt Redfearn       2017-04-20  545  				unsigned int nr_irqs, void *arg)
8ada00a650ec7e Matt Redfearn       2017-04-20  546  {
8ada00a650ec7e Matt Redfearn       2017-04-20  547  	struct irq_fwspec *fwspec = arg;
8ada00a650ec7e Matt Redfearn       2017-04-20  548  	irq_hw_number_t hwirq;
8ada00a650ec7e Matt Redfearn       2017-04-20  549  
8ada00a650ec7e Matt Redfearn       2017-04-20  550  	if (fwspec->param[0] == GIC_SHARED)
8ada00a650ec7e Matt Redfearn       2017-04-20  551  		hwirq = GIC_SHARED_TO_HWIRQ(fwspec->param[1]);
8ada00a650ec7e Matt Redfearn       2017-04-20  552  	else
8ada00a650ec7e Matt Redfearn       2017-04-20  553  		hwirq = GIC_LOCAL_TO_HWIRQ(fwspec->param[1]);
8ada00a650ec7e Matt Redfearn       2017-04-20  554  
8ada00a650ec7e Matt Redfearn       2017-04-20  555  	return gic_irq_domain_map(d, virq, hwirq);
8ada00a650ec7e Matt Redfearn       2017-04-20  556  }
8ada00a650ec7e Matt Redfearn       2017-04-20  557  
b87281e7f205ed Paul Burton         2017-04-20  558  void gic_irq_domain_free(struct irq_domain *d, unsigned int virq,
b87281e7f205ed Paul Burton         2017-04-20  559  			 unsigned int nr_irqs)
b87281e7f205ed Paul Burton         2017-04-20  560  {
e9de688dac6534 Andrew Bresticker   2014-09-18  561  }
e9de688dac6534 Andrew Bresticker   2014-09-18  562  
b87281e7f205ed Paul Burton         2017-04-20  563  static const struct irq_domain_ops gic_irq_domain_ops = {
b87281e7f205ed Paul Burton         2017-04-20  564  	.xlate = gic_irq_domain_xlate,
b87281e7f205ed Paul Burton         2017-04-20 @565  	.alloc = gic_irq_domain_alloc,
b87281e7f205ed Paul Burton         2017-04-20 @566  	.free = gic_irq_domain_free,
8ada00a650ec7e Matt Redfearn       2017-04-20  567  	.map = gic_irq_domain_map,
b87281e7f205ed Paul Burton         2017-04-20  568  };
b87281e7f205ed Paul Burton         2017-04-20  569  
b87281e7f205ed Paul Burton         2017-04-20  570  static int gic_ipi_domain_xlate(struct irq_domain *d, struct device_node *ctrlr,
b87281e7f205ed Paul Burton         2017-04-20  571  				const u32 *intspec, unsigned int intsize,
b87281e7f205ed Paul Burton         2017-04-20  572  				irq_hw_number_t *out_hwirq,
b87281e7f205ed Paul Burton         2017-04-20  573  				unsigned int *out_type)
b87281e7f205ed Paul Burton         2017-04-20  574  {
b87281e7f205ed Paul Burton         2017-04-20  575  	/*
b87281e7f205ed Paul Burton         2017-04-20  576  	 * There's nothing to translate here. hwirq is dynamically allocated and
b87281e7f205ed Paul Burton         2017-04-20  577  	 * the irq type is always edge triggered.
b87281e7f205ed Paul Burton         2017-04-20  578  	 * */
b87281e7f205ed Paul Burton         2017-04-20  579  	*out_hwirq = 0;
b87281e7f205ed Paul Burton         2017-04-20  580  	*out_type = IRQ_TYPE_EDGE_RISING;
b87281e7f205ed Paul Burton         2017-04-20  581  
b87281e7f205ed Paul Burton         2017-04-20  582  	return 0;
b87281e7f205ed Paul Burton         2017-04-20  583  }
b87281e7f205ed Paul Burton         2017-04-20  584  
b87281e7f205ed Paul Burton         2017-04-20  585  static int gic_ipi_domain_alloc(struct irq_domain *d, unsigned int virq,
2af70a962070fd Qais Yousef         2015-12-08  586  				unsigned int nr_irqs, void *arg)
2af70a962070fd Qais Yousef         2015-12-08  587  {
b87281e7f205ed Paul Burton         2017-04-20  588  	struct cpumask *ipimask = arg;
2af70a962070fd Qais Yousef         2015-12-08  589  	irq_hw_number_t hwirq, base_hwirq;
2af70a962070fd Qais Yousef         2015-12-08  590  	int cpu, ret, i;
2af70a962070fd Qais Yousef         2015-12-08  591  
f8dcd9e81797ae Paul Burton         2017-04-20  592  	base_hwirq = find_first_bit(ipi_available, gic_shared_intrs);
b87281e7f205ed Paul Burton         2017-04-20  593  	if (base_hwirq == gic_shared_intrs)
2af70a962070fd Qais Yousef         2015-12-08  594  		return -ENOMEM;
2af70a962070fd Qais Yousef         2015-12-08  595  
2af70a962070fd Qais Yousef         2015-12-08  596  	/* check that we have enough space */
2af70a962070fd Qais Yousef         2015-12-08  597  	for (i = base_hwirq; i < nr_irqs; i++) {
f8dcd9e81797ae Paul Burton         2017-04-20  598  		if (!test_bit(i, ipi_available))
2af70a962070fd Qais Yousef         2015-12-08  599  			return -EBUSY;
2af70a962070fd Qais Yousef         2015-12-08  600  	}
f8dcd9e81797ae Paul Burton         2017-04-20  601  	bitmap_clear(ipi_available, base_hwirq, nr_irqs);
2af70a962070fd Qais Yousef         2015-12-08  602  
2af70a962070fd Qais Yousef         2015-12-08  603  	/* map the hwirq for each cpu consecutively */
2af70a962070fd Qais Yousef         2015-12-08  604  	i = 0;
b87281e7f205ed Paul Burton         2017-04-20  605  	for_each_cpu(cpu, ipimask) {
2af70a962070fd Qais Yousef         2015-12-08  606  		hwirq = GIC_SHARED_TO_HWIRQ(base_hwirq + i);
2af70a962070fd Qais Yousef         2015-12-08  607  
2af70a962070fd Qais Yousef         2015-12-08  608  		ret = irq_domain_set_hwirq_and_chip(d, virq + i, hwirq,
b87281e7f205ed Paul Burton         2017-04-20  609  						    &gic_edge_irq_controller,
b87281e7f205ed Paul Burton         2017-04-20  610  						    NULL);
b87281e7f205ed Paul Burton         2017-04-20  611  		if (ret)
b87281e7f205ed Paul Burton         2017-04-20  612  			goto error;
b87281e7f205ed Paul Burton         2017-04-20  613  
b87281e7f205ed Paul Burton         2017-04-20 @614  		ret = irq_domain_set_hwirq_and_chip(d->parent, virq + i, hwirq,
b87281e7f205ed Paul Burton         2017-04-20  615  						    &gic_edge_irq_controller,
2af70a962070fd Qais Yousef         2015-12-08  616  						    NULL);
2af70a962070fd Qais Yousef         2015-12-08  617  		if (ret)
2af70a962070fd Qais Yousef         2015-12-08  618  			goto error;
2af70a962070fd Qais Yousef         2015-12-08  619  
b87281e7f205ed Paul Burton         2017-04-20  620  		ret = irq_set_irq_type(virq + i, IRQ_TYPE_EDGE_RISING);
b87281e7f205ed Paul Burton         2017-04-20  621  		if (ret)
b87281e7f205ed Paul Burton         2017-04-20  622  			goto error;
6a33fa2b87513f Paul Burton         2016-08-19  623  
2af70a962070fd Qais Yousef         2015-12-08  624  		ret = gic_shared_irq_domain_map(d, virq + i, hwirq, cpu);
2af70a962070fd Qais Yousef         2015-12-08  625  		if (ret)
2af70a962070fd Qais Yousef         2015-12-08  626  			goto error;
2af70a962070fd Qais Yousef         2015-12-08  627  
2af70a962070fd Qais Yousef         2015-12-08  628  		i++;
2af70a962070fd Qais Yousef         2015-12-08  629  	}
2af70a962070fd Qais Yousef         2015-12-08  630  
2af70a962070fd Qais Yousef         2015-12-08  631  	return 0;
2af70a962070fd Qais Yousef         2015-12-08  632  error:
f8dcd9e81797ae Paul Burton         2017-04-20  633  	bitmap_set(ipi_available, base_hwirq, nr_irqs);
2af70a962070fd Qais Yousef         2015-12-08  634  	return ret;
2af70a962070fd Qais Yousef         2015-12-08  635  }
2af70a962070fd Qais Yousef         2015-12-08  636  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
