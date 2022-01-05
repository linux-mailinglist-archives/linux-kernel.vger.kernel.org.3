Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04F2048589C
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 19:41:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243145AbiAESlx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 13:41:53 -0500
Received: from mga17.intel.com ([192.55.52.151]:27796 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243116AbiAESlv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 13:41:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641408111; x=1672944111;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9jWTwzcroPAB6SjOmCs6Db9zm5qd0qwmZSImoWib7kg=;
  b=T9Aa1bwoptpb0XjVXKfCb3BpXL45dFNMDjNR7VMHZoBiWGPYQ5Vg84wK
   U35zJudFeVWRN7ocXzjFoz8FuihBWLWPoeyJIBwClGDKQ86rWS3/6St4u
   zWOtHwdJFNmdbVbcsPm26nTcxbNxSP/OJMtXLr/kYp7AsyMpcMfiosm7g
   tLhVfuO53synGIZ6Z9fOuLMrk9CTsn8l3ViKiUwxJaG/4xh3H0mfpmg9j
   6wCCmX7tAkXk+bInY6eaZ6wr/C656adBTR1pKBcVXV9MW3UPjPUo/vgKY
   KXfCkIXInZTLO8hwTS73Sy0cakKMU5clbtcTSlTzrKUrIF4vrEztdEP5I
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="223195768"
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="223195768"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 10:41:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,264,1635231600"; 
   d="scan'208";a="668198888"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 05 Jan 2022 10:41:49 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5BEK-000Gwl-QQ; Wed, 05 Jan 2022 18:41:48 +0000
Date:   Thu, 6 Jan 2022 02:41:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, linmq006@gmail.com,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] phy: mapphone-mdm6600: Fix PM disable depth imbalance in
 phy_mdm6600_probe
Message-ID: <202201060211.yT7coTKI-lkp@intel.com>
References: <20220105123947.17946-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105123947.17946-1-linmq006@gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miaoqian,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Miaoqian-Lin/phy-mapphone-mdm6600-Fix-PM-disable-depth-imbalance-in-phy_mdm6600_probe/20220105-204113
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git c9e6606c7fe92b50a02ce51dda82586ebdf99b48
config: hexagon-randconfig-r035-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060211.yT7coTKI-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project d5b6e30ed3acad794dd0aec400e617daffc6cc3d)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/62cad5a4dd9feab731b40f99e6e0bf7a2429f1ed
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Miaoqian-Lin/phy-mapphone-mdm6600-Fix-PM-disable-depth-imbalance-in-phy_mdm6600_probe/20220105-204113
        git checkout 62cad5a4dd9feab731b40f99e6e0bf7a2429f1ed
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/phy/motorola/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/phy/motorola/phy-mapphone-mdm6600.c:633:1: warning: unused label 'disable_pm' [-Wunused-label]
   disable_pm:
   ^~~~~~~~~~~
   1 warning generated.


vim +/disable_pm +633 drivers/phy/motorola/phy-mapphone-mdm6600.c

   555	
   556	static int phy_mdm6600_probe(struct platform_device *pdev)
   557	{
   558		struct phy_mdm6600 *ddata;
   559		int error;
   560	
   561		ddata = devm_kzalloc(&pdev->dev, sizeof(*ddata), GFP_KERNEL);
   562		if (!ddata)
   563			return -ENOMEM;
   564	
   565		INIT_DELAYED_WORK(&ddata->bootup_work,
   566				  phy_mdm6600_deferred_power_on);
   567		INIT_DELAYED_WORK(&ddata->status_work, phy_mdm6600_status);
   568		INIT_DELAYED_WORK(&ddata->modem_wake_work, phy_mdm6600_modem_wake);
   569		init_completion(&ddata->ack);
   570	
   571		ddata->dev = &pdev->dev;
   572		platform_set_drvdata(pdev, ddata);
   573	
   574		/* Active state selected in phy_mdm6600_power_on() */
   575		error = pinctrl_pm_select_sleep_state(ddata->dev);
   576		if (error)
   577			dev_warn(ddata->dev, "%s: error with sleep_state: %i\n",
   578				 __func__, error);
   579	
   580		error = phy_mdm6600_init_lines(ddata);
   581		if (error)
   582			return error;
   583	
   584		phy_mdm6600_init_irq(ddata);
   585		schedule_delayed_work(&ddata->bootup_work, 0);
   586	
   587		/*
   588		 * See phy_mdm6600_device_power_on(). We should be able
   589		 * to remove this eventually when ohci-platform can deal
   590		 * with -EPROBE_DEFER.
   591		 */
   592		msleep(PHY_MDM6600_PHY_DELAY_MS + 500);
   593	
   594		/*
   595		 * Enable PM runtime only after PHY has been powered up properly.
   596		 * It is currently only needed after USB suspends mdm6600 and n_gsm
   597		 * needs to access the device. We don't want to do this earlier as
   598		 * gpio mode0 pin doubles as mdm6600 wake-up gpio.
   599		 */
   600		pm_runtime_use_autosuspend(ddata->dev);
   601		pm_runtime_set_autosuspend_delay(ddata->dev,
   602						 MDM6600_MODEM_IDLE_DELAY_MS);
   603		pm_runtime_enable(ddata->dev);
   604		error = pm_runtime_get_sync(ddata->dev);
   605		if (error < 0) {
   606			dev_warn(ddata->dev, "failed to wake modem: %i\n", error);
   607			pm_runtime_put_noidle(ddata->dev);
   608			goto cleanup;
   609		}
   610	
   611		ddata->generic_phy = devm_phy_create(ddata->dev, NULL, &gpio_usb_ops);
   612		if (IS_ERR(ddata->generic_phy)) {
   613			error = PTR_ERR(ddata->generic_phy);
   614			goto idle;
   615		}
   616	
   617		phy_set_drvdata(ddata->generic_phy, ddata);
   618	
   619		ddata->phy_provider =
   620			devm_of_phy_provider_register(ddata->dev,
   621						      of_phy_simple_xlate);
   622		if (IS_ERR(ddata->phy_provider))
   623			error = PTR_ERR(ddata->phy_provider);
   624	
   625	idle:
   626		pm_runtime_mark_last_busy(ddata->dev);
   627		pm_runtime_put_autosuspend(ddata->dev);
   628	
   629	cleanup:
   630		if (error < 0)
   631			phy_mdm6600_device_power_off(ddata);
   632	
 > 633	disable_pm:
   634		pm_runtime_disable(ddata->dev);
   635	
   636		return error;
   637	}
   638	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
