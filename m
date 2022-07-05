Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A067C5676A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 20:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiGESjB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 14:39:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbiGESi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 14:38:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80F3B1CFCA
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 11:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657046335; x=1688582335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=f5YXzxxxFtDhdqaCfbKXU2l4xFbQoZoTCeioTH5pT2I=;
  b=Ff9krp9aXZdOAFCparo7gezR5qwJ1JSbrHH+h7QFvhB1uf7fa8GOurnC
   09sLHV1nW0XQlp5aGj934r5Vmi9RYBle628RGHG7JXgnHq9Qkdo2JnEsC
   dCL998XJb4r5hGKp/TuJKk1V3R8LkNIJMcmySm5REc+cx28XAJxQh32tG
   cKpDQ2g+k+71GgXFNzciB18lCH8XJrGWd1zWwZv7ECtBwGPMkVm0zZW6S
   1Pek3hmrv7WS/dJptQvnvwQh62oDMBGikFSQgdz3NvQN/cOqOfhTJ0Ikj
   bhwz3XVyjbaFELb31hkb7jDyTozsPSwEjQnLL+VMtaflLrILfM8bMoD59
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10399"; a="266468741"
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="266468741"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 11:38:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,247,1650956400"; 
   d="scan'208";a="919833300"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 05 Jul 2022 11:38:51 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o8nRi-000JTq-M8;
        Tue, 05 Jul 2022 18:38:50 +0000
Date:   Wed, 6 Jul 2022 02:38:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Subject: Re: [PATCH v1 1/1] ASoC: Intel: catpt: remove duplicating driver
 data retrieval
Message-ID: <202207060256.1n5oG24B-lkp@intel.com>
References: <20220702223243.51364-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220702223243.51364-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on broonie-sound/for-next]
[also build test WARNING on tiwai-sound/for-next linus/master v5.19-rc5 next-20220705]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/ASoC-Intel-catpt-remove-duplicating-driver-data-retrieval/20220703-063325
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: i386-randconfig-c001 (https://download.01.org/0day-ci/archive/20220706/202207060256.1n5oG24B-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project f7a80c3d08d4821e621fc88d6a2e435291f82dff)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a83f7416086fbf505f7f585fa3718fed2ee1ac75
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/ASoC-Intel-catpt-remove-duplicating-driver-data-retrieval/20220703-063325
        git checkout a83f7416086fbf505f7f585fa3718fed2ee1ac75
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash sound/soc/intel/catpt/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> sound/soc/intel/catpt/device.c:252:45: warning: variable 'id' is uninitialized when used here [-Wuninitialized]
           ret = snd_intel_acpi_dsp_driver_probe(dev, id->id);
                                                      ^~
   sound/soc/intel/catpt/device.c:244:33: note: initialize the variable 'id' to silence this warning
           const struct acpi_device_id *id;
                                          ^
                                           = NULL
   1 warning generated.


vim +/id +252 sound/soc/intel/catpt/device.c

7a10b66a5df965 Cezary Rojewski      2020-09-29  238  
7a10b66a5df965 Cezary Rojewski      2020-09-29  239  static int catpt_acpi_probe(struct platform_device *pdev)
7a10b66a5df965 Cezary Rojewski      2020-09-29  240  {
7a10b66a5df965 Cezary Rojewski      2020-09-29  241  	const struct catpt_spec *spec;
7a10b66a5df965 Cezary Rojewski      2020-09-29  242  	struct catpt_dev *cdev;
7a10b66a5df965 Cezary Rojewski      2020-09-29  243  	struct device *dev = &pdev->dev;
ec8a15d3a7c7d6 Pierre-Louis Bossart 2020-11-12  244  	const struct acpi_device_id *id;
7a10b66a5df965 Cezary Rojewski      2020-09-29  245  	struct resource *res;
7a10b66a5df965 Cezary Rojewski      2020-09-29  246  	int ret;
7a10b66a5df965 Cezary Rojewski      2020-09-29  247  
a83f7416086fbf Andy Shevchenko      2022-07-03  248  	spec = device_get_match_data(dev);
a83f7416086fbf Andy Shevchenko      2022-07-03  249  	if (!spec)
ec8a15d3a7c7d6 Pierre-Louis Bossart 2020-11-12  250  		return -ENODEV;
ec8a15d3a7c7d6 Pierre-Louis Bossart 2020-11-12  251  
ec8a15d3a7c7d6 Pierre-Louis Bossart 2020-11-12 @252  	ret = snd_intel_acpi_dsp_driver_probe(dev, id->id);
ec8a15d3a7c7d6 Pierre-Louis Bossart 2020-11-12  253  	if (ret != SND_INTEL_DSP_DRIVER_ANY && ret != SND_INTEL_DSP_DRIVER_SST) {
ec8a15d3a7c7d6 Pierre-Louis Bossart 2020-11-12  254  		dev_dbg(dev, "CATPT ACPI driver not selected, aborting probe\n");
ec8a15d3a7c7d6 Pierre-Louis Bossart 2020-11-12  255  		return -ENODEV;
ec8a15d3a7c7d6 Pierre-Louis Bossart 2020-11-12  256  	}
ec8a15d3a7c7d6 Pierre-Louis Bossart 2020-11-12  257  
7a10b66a5df965 Cezary Rojewski      2020-09-29  258  	cdev = devm_kzalloc(dev, sizeof(*cdev), GFP_KERNEL);
7a10b66a5df965 Cezary Rojewski      2020-09-29  259  	if (!cdev)
7a10b66a5df965 Cezary Rojewski      2020-09-29  260  		return -ENOMEM;
7a10b66a5df965 Cezary Rojewski      2020-09-29  261  
7a10b66a5df965 Cezary Rojewski      2020-09-29  262  	catpt_dev_init(cdev, dev, spec);
7a10b66a5df965 Cezary Rojewski      2020-09-29  263  
7a10b66a5df965 Cezary Rojewski      2020-09-29  264  	/* map DSP bar address */
7a10b66a5df965 Cezary Rojewski      2020-09-29  265  	cdev->lpe_ba = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
7a10b66a5df965 Cezary Rojewski      2020-09-29  266  	if (IS_ERR(cdev->lpe_ba))
7a10b66a5df965 Cezary Rojewski      2020-09-29  267  		return PTR_ERR(cdev->lpe_ba);
7a10b66a5df965 Cezary Rojewski      2020-09-29  268  	cdev->lpe_base = res->start;
7a10b66a5df965 Cezary Rojewski      2020-09-29  269  
7a10b66a5df965 Cezary Rojewski      2020-09-29  270  	/* map PCI bar address */
7a10b66a5df965 Cezary Rojewski      2020-09-29  271  	cdev->pci_ba = devm_platform_ioremap_resource(pdev, 1);
7a10b66a5df965 Cezary Rojewski      2020-09-29  272  	if (IS_ERR(cdev->pci_ba))
7a10b66a5df965 Cezary Rojewski      2020-09-29  273  		return PTR_ERR(cdev->pci_ba);
7a10b66a5df965 Cezary Rojewski      2020-09-29  274  
7a10b66a5df965 Cezary Rojewski      2020-09-29  275  	/* alloc buffer for storing DRAM context during dx transitions */
7a10b66a5df965 Cezary Rojewski      2020-09-29  276  	cdev->dxbuf_vaddr = dmam_alloc_coherent(dev, catpt_dram_size(cdev),
7a10b66a5df965 Cezary Rojewski      2020-09-29  277  						&cdev->dxbuf_paddr, GFP_KERNEL);
7a10b66a5df965 Cezary Rojewski      2020-09-29  278  	if (!cdev->dxbuf_vaddr)
7a10b66a5df965 Cezary Rojewski      2020-09-29  279  		return -ENOMEM;
7a10b66a5df965 Cezary Rojewski      2020-09-29  280  
7a10b66a5df965 Cezary Rojewski      2020-09-29  281  	ret = platform_get_irq(pdev, 0);
7a10b66a5df965 Cezary Rojewski      2020-09-29  282  	if (ret < 0)
7a10b66a5df965 Cezary Rojewski      2020-09-29  283  		return ret;
7a10b66a5df965 Cezary Rojewski      2020-09-29  284  	cdev->irq = ret;
7a10b66a5df965 Cezary Rojewski      2020-09-29  285  
7a10b66a5df965 Cezary Rojewski      2020-09-29  286  	platform_set_drvdata(pdev, cdev);
7a10b66a5df965 Cezary Rojewski      2020-09-29  287  
7a10b66a5df965 Cezary Rojewski      2020-09-29  288  	ret = devm_request_threaded_irq(dev, cdev->irq, catpt_dsp_irq_handler,
7a10b66a5df965 Cezary Rojewski      2020-09-29  289  					catpt_dsp_irq_thread,
7a10b66a5df965 Cezary Rojewski      2020-09-29  290  					IRQF_SHARED, "AudioDSP", cdev);
7a10b66a5df965 Cezary Rojewski      2020-09-29  291  	if (ret)
7a10b66a5df965 Cezary Rojewski      2020-09-29  292  		return ret;
7a10b66a5df965 Cezary Rojewski      2020-09-29  293  
7a10b66a5df965 Cezary Rojewski      2020-09-29  294  	return catpt_probe_components(cdev);
7a10b66a5df965 Cezary Rojewski      2020-09-29  295  }
7a10b66a5df965 Cezary Rojewski      2020-09-29  296  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
