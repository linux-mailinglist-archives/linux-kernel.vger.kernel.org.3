Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5236543F02
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 00:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbiFHWKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 18:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbiFHWKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 18:10:08 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471D120C6F9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 15:10:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654726207; x=1686262207;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lxuvsZZpcJ9wv5HmV3FfKYAgCpPt2sO8iLjgqKsEU14=;
  b=OBUbCg/rBiilQdFOtyZV7+eka/4XVYYXeEQW1lYATJnd6UL4MojF42SA
   h/+RRyG6fUmTAn3QZ5DFlkVJvb702xEa9/aavtY47NyLB592ka9AliNgO
   RGmdpOICX3SLYHM5Aa/S7NT0I61c7ZYQ9x6PsSGbTx19fTvWM/ZAYEITp
   Te0jF7aX1XBWbzBm9i2yb+1FN/xghVskf+JNbCOZiD4aa1YbSl45pXFqp
   AfO/OQdEbJJCt0y0raNguh/ZtOjmdhyfkxIBxeYvrITZZu7gKdYwIZZGk
   +mnuCUr3d4iIYpeNqe7DjZbUrh5WO71E9+iRht1nwCnmLTVH2qS/BTIBd
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="260203759"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="260203759"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 15:10:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="637089333"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 08 Jun 2022 15:10:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz3sJ-000FAD-Pm;
        Wed, 08 Jun 2022 22:10:03 +0000
Date:   Thu, 9 Jun 2022 06:09:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     kbuild-all@lists.01.org, Vignesh Raghavendra <vigneshr@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] irqchip/ti-sci-intr: Add support for system
 suspend/resume PM
Message-ID: <202206090635.fkrDWqjX-lkp@intel.com>
References: <20220607061912.12222-1-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607061912.12222-1-a-govindraju@ti.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Aswath,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on v5.19-rc1 next-20220608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Aswath-Govindraju/irqchip-ti-sci-intr-Add-support-for-system-suspend-resume-PM/20220607-142656
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git cdb4913293897dde0df522ed5789ba016f3b9157
config: arm64-defconfig (https://download.01.org/0day-ci/archive/20220609/202206090635.fkrDWqjX-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/c41c5fa0992f5a0a3298d6933ed84349f1f48b58
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aswath-Govindraju/irqchip-ti-sci-intr-Add-support-for-system-suspend-resume-PM/20220607-142656
        git checkout c41c5fa0992f5a0a3298d6933ed84349f1f48b58
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/

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
