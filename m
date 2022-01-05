Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C65F485CBB
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:00:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245659AbiAFAAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:00:04 -0500
Received: from mga01.intel.com ([192.55.52.88]:55051 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239615AbiAFAAD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:00:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641427203; x=1672963203;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=41SQZtieL/dYlOwygcKldJKm/baNQziXhw4kXJeCPcA=;
  b=SXJW6o14uZ5Zu21I/TyvHZ37nT3t6Meitim9ZuRF+4hQkUbhql8fXm37
   BKAPeFK5wDZoMsd8p92NAaI2rVBEVosG4BmtAUVoyCm8QDHZUdEuWEXdK
   +kMwik/JjKgT/LLu2K55XMRaNtAgGV4cU35Pb7O3+yJEytQvZTru6izaD
   xC9b2JRGkPdwfREVxHxBGfBogSCpvMcCn6LRCxamyVThr/Ve0MxPqiKzc
   Q3/HykraPmziq1C/4Hxq12iyk47p68SDg5pQYStkrxC1OCdyn40BaOd0Z
   109EmyUc3uRSC9GdIL7LbaGAzhRaIpQrSSABgDOsF2GdCS7ancjHv/PuN
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="266841819"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="266841819"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 16:00:02 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="513194494"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 05 Jan 2022 16:00:00 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5GCF-000H9U-F1; Wed, 05 Jan 2022 23:59:59 +0000
Date:   Thu, 6 Jan 2022 07:59:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, linmq006@gmail.com,
        Jean-Christophe Trotin <jean-christophe.trotin@foss.st.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org,
        Peter Griffin <peter.griffin@linaro.org>,
        Yannick Fertre <yannick.fertre@st.com>,
        Hans Verkuil <hverkuil@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: st-hva: Fix PM disable depth imbalance in
 hva_hw_probe
Message-ID: <202201060723.hf79WNhw-lkp@intel.com>
References: <20220105113104.7783-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105113104.7783-1-linmq006@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on media-tree/master]
[also build test WARNING on v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miaoqian-Lin/media-st-hva-Fix-PM-disable-depth-imbalance-in-hva_hw_probe/20220105-193232
base:   git://linuxtv.org/media_tree.git master
config: riscv-randconfig-r022-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060723.hf79WNhw-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/0day-ci/linux/commit/47b1ca3ed69ff8b4ac772d1630776ec5366076c1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miaoqian-Lin/media-st-hva-Fix-PM-disable-depth-imbalance-in-hva_hw_probe/20220105-193232
        git checkout 47b1ca3ed69ff8b4ac772d1630776ec5366076c1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/media/platform/sti/hva/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/media/platform/sti/hva/hva-hw.c:411:1: warning: unused label 'disable_pm_runtime' [-Wunused-label]
   disable_pm_runtime:
   ^~~~~~~~~~~~~~~~~~~
   1 warning generated.


vim +/disable_pm_runtime +411 drivers/media/platform/sti/hva/hva-hw.c

   297	
   298	int hva_hw_probe(struct platform_device *pdev, struct hva_dev *hva)
   299	{
   300		struct device *dev = &pdev->dev;
   301		struct resource *esram;
   302		int ret;
   303	
   304		WARN_ON(!hva);
   305	
   306		/* get memory for registers */
   307		hva->regs = devm_platform_ioremap_resource(pdev, 0);
   308		if (IS_ERR(hva->regs)) {
   309			dev_err(dev, "%s     failed to get regs\n", HVA_PREFIX);
   310			return PTR_ERR(hva->regs);
   311		}
   312	
   313		/* get memory for esram */
   314		esram = platform_get_resource(pdev, IORESOURCE_MEM, 1);
   315		if (!esram) {
   316			dev_err(dev, "%s     failed to get esram\n", HVA_PREFIX);
   317			return -ENODEV;
   318		}
   319		hva->esram_addr = esram->start;
   320		hva->esram_size = resource_size(esram);
   321	
   322		dev_info(dev, "%s     esram reserved for address: 0x%x size:%d\n",
   323			 HVA_PREFIX, hva->esram_addr, hva->esram_size);
   324	
   325		/* get clock resource */
   326		hva->clk = devm_clk_get(dev, "clk_hva");
   327		if (IS_ERR(hva->clk)) {
   328			dev_err(dev, "%s     failed to get clock\n", HVA_PREFIX);
   329			return PTR_ERR(hva->clk);
   330		}
   331	
   332		ret = clk_prepare(hva->clk);
   333		if (ret < 0) {
   334			dev_err(dev, "%s     failed to prepare clock\n", HVA_PREFIX);
   335			hva->clk = ERR_PTR(-EINVAL);
   336			return ret;
   337		}
   338	
   339		/* get status interruption resource */
   340		ret  = platform_get_irq(pdev, 0);
   341		if (ret < 0)
   342			goto err_clk;
   343		hva->irq_its = ret;
   344	
   345		ret = devm_request_threaded_irq(dev, hva->irq_its, hva_hw_its_interrupt,
   346						hva_hw_its_irq_thread,
   347						IRQF_ONESHOT,
   348						"hva_its_irq", hva);
   349		if (ret) {
   350			dev_err(dev, "%s     failed to install status IRQ 0x%x\n",
   351				HVA_PREFIX, hva->irq_its);
   352			goto err_clk;
   353		}
   354		disable_irq(hva->irq_its);
   355	
   356		/* get error interruption resource */
   357		ret = platform_get_irq(pdev, 1);
   358		if (ret < 0)
   359			goto err_clk;
   360		hva->irq_err = ret;
   361	
   362		ret = devm_request_threaded_irq(dev, hva->irq_err, hva_hw_err_interrupt,
   363						hva_hw_err_irq_thread,
   364						IRQF_ONESHOT,
   365						"hva_err_irq", hva);
   366		if (ret) {
   367			dev_err(dev, "%s     failed to install error IRQ 0x%x\n",
   368				HVA_PREFIX, hva->irq_err);
   369			goto err_clk;
   370		}
   371		disable_irq(hva->irq_err);
   372	
   373		/* initialise protection mutex */
   374		mutex_init(&hva->protect_mutex);
   375	
   376		/* initialise completion signal */
   377		init_completion(&hva->interrupt);
   378	
   379		/* initialise runtime power management */
   380		pm_runtime_set_autosuspend_delay(dev, AUTOSUSPEND_DELAY_MS);
   381		pm_runtime_use_autosuspend(dev);
   382		pm_runtime_set_suspended(dev);
   383		pm_runtime_enable(dev);
   384	
   385		ret = pm_runtime_resume_and_get(dev);
   386		if (ret < 0) {
   387			dev_err(dev, "%s     failed to set PM\n", HVA_PREFIX);
   388			goto err_disable;
   389		}
   390	
   391		/* check IP hardware version */
   392		hva->ip_version = hva_hw_get_ip_version(hva);
   393	
   394		if (hva->ip_version == HVA_VERSION_UNKNOWN) {
   395			ret = -EINVAL;
   396			goto err_pm;
   397		}
   398	
   399		dev_info(dev, "%s     found hva device (version 0x%lx)\n", HVA_PREFIX,
   400			 hva->ip_version);
   401	
   402		return 0;
   403	
   404	err_pm:
   405		pm_runtime_put(dev);
   406	err_disable:
   407		pm_runtime_disable(dev);
   408	err_clk:
   409		if (hva->clk)
   410			clk_unprepare(hva->clk);
 > 411	disable_pm_runtime:
   412		pm_runtime_disable(dev);
   413		return ret;
   414	}
   415	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
