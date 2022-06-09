Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA332544FFB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 16:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbiFIO5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 10:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240663AbiFIO46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 10:56:58 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF873A15DF
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 07:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654786617; x=1686322617;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AhOKgRD6dzPhGcbP+FED4Ce5jeuzBr0fCvK3sx/IZr4=;
  b=TlkEx04dF6Q/9JBrBbOcsHiJUC0e5JmWWbFZJc8XO+bnIl0m9zVOHL4k
   JueEfxYodU9OpkQxY+AWCKungj1E3L/M20dtjVJXyAJViXjp4jv2RPry5
   WKe7Y5ckAQ4M0nhx5y4t+fNaFrs/Iox1ciT1XO8Qrq+6E2GrD2XhJrC0C
   /fQuH8KTyFciTOhqYz4wIyyC2Fe23PNhYBNR/UqzW3bKbZeHvzbusUl+W
   uWNr8sKiub67WQGb89aVeq0Cuhj8sn7NivG1urAxeFIFQLSzWjL2I3hFR
   RxVx7Hrb+iG+AfPwcXFs2Qq4tksdwl7KdOYptx8AOCx8pFIwlmHfAs7X+
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10373"; a="341381836"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="341381836"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2022 07:56:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="610286885"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Jun 2022 07:56:36 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nzJaO-000G55-3C;
        Thu, 09 Jun 2022 14:56:36 +0000
Date:   Thu, 9 Jun 2022 22:56:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/ti-sci-intr: Add support for system
 suspend/resume PM
Message-ID: <202206092226.YcJ2jTZb-lkp@intel.com>
References: <20220607061912.12222-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607061912.12222-1-a-govindraju@ti.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on v5.19-rc1]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Aswath-Govindraju/irqchip-ti-sci-intr-Add-support-for-system-suspend-resume-PM/20220607-142656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git cdb4913293897dde0df522ed5789ba016f3b9157
config: arm64-randconfig-r020-20220607 (https://download.01.org/0day-ci/archive/20220609/202206092226.YcJ2jTZb-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project b92436efcb7813fc481b30f2593a4907568d917a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/c41c5fa0992f5a0a3298d6933ed84349f1f48b58
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aswath-Govindraju/irqchip-ti-sci-intr-Add-support-for-system-suspend-resume-PM/20220607-142656
        git checkout c41c5fa0992f5a0a3298d6933ed84349f1f48b58
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/irq-ti-sci-intr.c:270: warning: expecting prototype for ti_sci_intr_initialize_mappingg(). Prototype was for ti_sci_intr_initialize_mapping() instead


vim +270 drivers/irqchip/irq-ti-sci-intr.c

   264	
   265	/**
   266	 * ti_sci_intr_initialize_mappingg - Initialize the out_irq <-> hwirq mapping table
   267	 * @intr:	IRQ domain corresponding to Interrupt Router
   268	 */
   269	static int ti_sci_intr_initialize_mapping(struct ti_sci_intr_irq_domain *intr)
 > 270	{
   271		int i;
   272		int mapping_len = intr->out_irqs->desc->num + intr->out_irqs->desc->num_sec;
   273	
   274		intr->mapping = devm_kzalloc(intr->dev, mapping_len * sizeof(u32), GFP_KERNEL);
   275		if (!intr->mapping)
   276			return -ENOMEM;
   277	
   278		/* Set all the elements in the array to max value of u32 */
   279		for (i = 0; i < mapping_len; i++)
   280			intr->mapping[i] = 0xFFFFFFFF;
   281	
   282		return 0;
   283	}
   284	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
