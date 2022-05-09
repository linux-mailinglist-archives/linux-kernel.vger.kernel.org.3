Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F7751F6E8
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 10:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiEIINb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:13:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237398AbiEIIAZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:00:25 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3023189E5D
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:56:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652082990; x=1683618990;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ino11uijCuvYEBBiCsBGTBzxkPq0irZ5o3V4YaCc+Eo=;
  b=TfKLJON3eJcykoohg/i0Ymz1itl67qBrCVMLV/Oyuzhhzp2gubqF4E0G
   7sL6ghKFvdGvCe0vpBqFTCc5sjgbdQ/OxrwQ80rrly1XNeUhfw/xBu4iL
   GY4RXeDbAV7Xoat4m4MMLtcBTyc49KjjlDWYJF04fJ614fz3rGE1N66PN
   UqCliFjrfEAWDFH8S6blU77+hYdxPD43PxywV8hPtCHwYCRYCC4jIXTEn
   jjRVw0q9vy28pKDyFiNkrrz6ZpU6V5c9Lq39gmPx2uqfBrSxj5z6KKlRH
   2eOm3z9Pc7COasYKw8om6l4Lqze42odTM3+fKXECJJSVYZ1ic0aZ3DIs6
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10341"; a="248875213"
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="248875213"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 00:53:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="668848352"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 09 May 2022 00:53:31 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nnyCw-000GJq-Jm;
        Mon, 09 May 2022 07:53:30 +0000
Date:   Mon, 9 May 2022 15:52:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Samuel Holland <samuel@sholland.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Samuel Holland <samuel@sholland.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Guo Ren <guoren@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Wei Xu <xuwei5@hisilicon.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 3/5] genirq: Provide an IRQ affinity mask in non-SMP
 configs
Message-ID: <202205091545.QhhCDxVm-lkp@intel.com>
References: <20220509034333.60017-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509034333.60017-4-samuel@sholland.org>
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
[also build test ERROR on soc/for-next linus/master v5.18-rc6 next-20220506]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Samuel-Holland/genirq-irqchip-RISC-V-PLIC-cleanup-and-optimization/20220509-115510
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ce4818957fdc5bca57fc2c92b0dfe109d26bcc47
config: mips-randconfig-r024-20220509 (https://download.01.org/0day-ci/archive/20220509/202205091545.QhhCDxVm-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a385645b470e2d3a1534aae618ea56b31177639f)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install mips cross compiling tool for clang build
        # apt-get install binutils-mips-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/4bca5b436c97eb2ee232dd23f262ebad05fa183c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Samuel-Holland/genirq-irqchip-RISC-V-PLIC-cleanup-and-optimization/20220509-115510
        git checkout 4bca5b436c97eb2ee232dd23f262ebad05fa183c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=mips SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/irq/ipi.c:94:30: error: no member named 'affinity' in 'struct irq_common_data'
                   cpumask_copy(data->common->affinity, dest);
                                ~~~~~~~~~~~~  ^
   1 error generated.


vim +94 kernel/irq/ipi.c

d17bf24e695290 Qais Yousef     2015-12-08   13  
d17bf24e695290 Qais Yousef     2015-12-08   14  /**
d17bf24e695290 Qais Yousef     2015-12-08   15   * irq_reserve_ipi() - Setup an IPI to destination cpumask
d17bf24e695290 Qais Yousef     2015-12-08   16   * @domain:	IPI domain
3b35e7e6daef5a Randy Dunlap    2021-08-10   17   * @dest:	cpumask of CPUs which can receive the IPI
d17bf24e695290 Qais Yousef     2015-12-08   18   *
d17bf24e695290 Qais Yousef     2015-12-08   19   * Allocate a virq that can be used to send IPI to any CPU in dest mask.
d17bf24e695290 Qais Yousef     2015-12-08   20   *
3b35e7e6daef5a Randy Dunlap    2021-08-10   21   * Return: Linux IRQ number on success or error code on failure
d17bf24e695290 Qais Yousef     2015-12-08   22   */
7cec18a3906b52 Matt Redfearn   2016-04-25   23  int irq_reserve_ipi(struct irq_domain *domain,
d17bf24e695290 Qais Yousef     2015-12-08   24  			     const struct cpumask *dest)
d17bf24e695290 Qais Yousef     2015-12-08   25  {
d17bf24e695290 Qais Yousef     2015-12-08   26  	unsigned int nr_irqs, offset;
d17bf24e695290 Qais Yousef     2015-12-08   27  	struct irq_data *data;
d17bf24e695290 Qais Yousef     2015-12-08   28  	int virq, i;
d17bf24e695290 Qais Yousef     2015-12-08   29  
d17bf24e695290 Qais Yousef     2015-12-08   30  	if (!domain ||!irq_domain_is_ipi(domain)) {
d17bf24e695290 Qais Yousef     2015-12-08   31  		pr_warn("Reservation on a non IPI domain\n");
7cec18a3906b52 Matt Redfearn   2016-04-25   32  		return -EINVAL;
d17bf24e695290 Qais Yousef     2015-12-08   33  	}
d17bf24e695290 Qais Yousef     2015-12-08   34  
d17bf24e695290 Qais Yousef     2015-12-08   35  	if (!cpumask_subset(dest, cpu_possible_mask)) {
d17bf24e695290 Qais Yousef     2015-12-08   36  		pr_warn("Reservation is not in possible_cpu_mask\n");
7cec18a3906b52 Matt Redfearn   2016-04-25   37  		return -EINVAL;
d17bf24e695290 Qais Yousef     2015-12-08   38  	}
d17bf24e695290 Qais Yousef     2015-12-08   39  
d17bf24e695290 Qais Yousef     2015-12-08   40  	nr_irqs = cpumask_weight(dest);
d17bf24e695290 Qais Yousef     2015-12-08   41  	if (!nr_irqs) {
d17bf24e695290 Qais Yousef     2015-12-08   42  		pr_warn("Reservation for empty destination mask\n");
7cec18a3906b52 Matt Redfearn   2016-04-25   43  		return -EINVAL;
d17bf24e695290 Qais Yousef     2015-12-08   44  	}
d17bf24e695290 Qais Yousef     2015-12-08   45  
d17bf24e695290 Qais Yousef     2015-12-08   46  	if (irq_domain_is_ipi_single(domain)) {
d17bf24e695290 Qais Yousef     2015-12-08   47  		/*
d17bf24e695290 Qais Yousef     2015-12-08   48  		 * If the underlying implementation uses a single HW irq on
d17bf24e695290 Qais Yousef     2015-12-08   49  		 * all cpus then we only need a single Linux irq number for
d17bf24e695290 Qais Yousef     2015-12-08   50  		 * it. We have no restrictions vs. the destination mask. The
d17bf24e695290 Qais Yousef     2015-12-08   51  		 * underlying implementation can deal with holes nicely.
d17bf24e695290 Qais Yousef     2015-12-08   52  		 */
d17bf24e695290 Qais Yousef     2015-12-08   53  		nr_irqs = 1;
d17bf24e695290 Qais Yousef     2015-12-08   54  		offset = 0;
d17bf24e695290 Qais Yousef     2015-12-08   55  	} else {
d17bf24e695290 Qais Yousef     2015-12-08   56  		unsigned int next;
d17bf24e695290 Qais Yousef     2015-12-08   57  
d17bf24e695290 Qais Yousef     2015-12-08   58  		/*
c5f48c0a7aa1a8 Ingo Molnar     2018-12-03   59  		 * The IPI requires a separate HW irq on each CPU. We require
d17bf24e695290 Qais Yousef     2015-12-08   60  		 * that the destination mask is consecutive. If an
d17bf24e695290 Qais Yousef     2015-12-08   61  		 * implementation needs to support holes, it can reserve
d17bf24e695290 Qais Yousef     2015-12-08   62  		 * several IPI ranges.
d17bf24e695290 Qais Yousef     2015-12-08   63  		 */
d17bf24e695290 Qais Yousef     2015-12-08   64  		offset = cpumask_first(dest);
d17bf24e695290 Qais Yousef     2015-12-08   65  		/*
d17bf24e695290 Qais Yousef     2015-12-08   66  		 * Find a hole and if found look for another set bit after the
d17bf24e695290 Qais Yousef     2015-12-08   67  		 * hole. For now we don't support this scenario.
d17bf24e695290 Qais Yousef     2015-12-08   68  		 */
d17bf24e695290 Qais Yousef     2015-12-08   69  		next = cpumask_next_zero(offset, dest);
d17bf24e695290 Qais Yousef     2015-12-08   70  		if (next < nr_cpu_ids)
d17bf24e695290 Qais Yousef     2015-12-08   71  			next = cpumask_next(next, dest);
d17bf24e695290 Qais Yousef     2015-12-08   72  		if (next < nr_cpu_ids) {
d17bf24e695290 Qais Yousef     2015-12-08   73  			pr_warn("Destination mask has holes\n");
7cec18a3906b52 Matt Redfearn   2016-04-25   74  			return -EINVAL;
d17bf24e695290 Qais Yousef     2015-12-08   75  		}
d17bf24e695290 Qais Yousef     2015-12-08   76  	}
d17bf24e695290 Qais Yousef     2015-12-08   77  
06ee6d571f0e35 Thomas Gleixner 2016-07-04   78  	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE, NULL);
d17bf24e695290 Qais Yousef     2015-12-08   79  	if (virq <= 0) {
d17bf24e695290 Qais Yousef     2015-12-08   80  		pr_warn("Can't reserve IPI, failed to alloc descs\n");
7cec18a3906b52 Matt Redfearn   2016-04-25   81  		return -ENOMEM;
d17bf24e695290 Qais Yousef     2015-12-08   82  	}
d17bf24e695290 Qais Yousef     2015-12-08   83  
d17bf24e695290 Qais Yousef     2015-12-08   84  	virq = __irq_domain_alloc_irqs(domain, virq, nr_irqs, NUMA_NO_NODE,
eb0dc47ab6810c Vincent Stehle  2016-07-18   85  				       (void *) dest, true, NULL);
d17bf24e695290 Qais Yousef     2015-12-08   86  
d17bf24e695290 Qais Yousef     2015-12-08   87  	if (virq <= 0) {
d17bf24e695290 Qais Yousef     2015-12-08   88  		pr_warn("Can't reserve IPI, failed to alloc hw irqs\n");
d17bf24e695290 Qais Yousef     2015-12-08   89  		goto free_descs;
d17bf24e695290 Qais Yousef     2015-12-08   90  	}
d17bf24e695290 Qais Yousef     2015-12-08   91  
d17bf24e695290 Qais Yousef     2015-12-08   92  	for (i = 0; i < nr_irqs; i++) {
d17bf24e695290 Qais Yousef     2015-12-08   93  		data = irq_get_irq_data(virq + i);
d17bf24e695290 Qais Yousef     2015-12-08  @94  		cpumask_copy(data->common->affinity, dest);
d17bf24e695290 Qais Yousef     2015-12-08   95  		data->common->ipi_offset = offset;
4589f450fb285a Matt Redfearn   2016-04-21   96  		irq_set_status_flags(virq + i, IRQ_NO_BALANCING);
d17bf24e695290 Qais Yousef     2015-12-08   97  	}
d17bf24e695290 Qais Yousef     2015-12-08   98  	return virq;
d17bf24e695290 Qais Yousef     2015-12-08   99  
d17bf24e695290 Qais Yousef     2015-12-08  100  free_descs:
d17bf24e695290 Qais Yousef     2015-12-08  101  	irq_free_descs(virq, nr_irqs);
7cec18a3906b52 Matt Redfearn   2016-04-25  102  	return -EBUSY;
d17bf24e695290 Qais Yousef     2015-12-08  103  }
d17bf24e695290 Qais Yousef     2015-12-08  104  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
