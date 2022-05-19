Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40BC752CA86
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 05:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233309AbiESDoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 23:44:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233194AbiESDoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 23:44:07 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D3CB6E8D6;
        Wed, 18 May 2022 20:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652931846; x=1684467846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=8pLVpzfs0e+MBF6xzMZ7VLx5/sxEzJ16X0u1zarTxzE=;
  b=hGTtHUL9wa1A/uoV0Y8jevcMGOlME24+46A+lbWWzyvgRGNGtqzRx/cw
   zjNY5cLVvspzbznNFFwBhMiOpM7Ap9GUEjjAFlCQCGZZQt9zi4PrVFuPn
   FHQOuPD35oSgDwLXufNKAXBheA4hA8Ct+wC4xfLBSBqhFlDlWdIYECjCO
   m6JQf17wGTl+WDN9XmWq6aC4NW1VrGoKcx+MZRcNN97PVmoMb4gNU/d1V
   B13tlDS/x6nuMkp6T84Q3LhU4ljaNxJTP9cfI/5uzTBHKR4FVsFZytQgp
   EShbHQ/n8MelpVhS3W7uZbkd1zq6ZgcAhG4azjISDimvmR+SIvYVGawIX
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10351"; a="251897263"
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="251897263"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 May 2022 20:44:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,236,1647327600"; 
   d="scan'208";a="627384004"
Received: from lkp-server02.sh.intel.com (HELO 242b25809ac7) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 18 May 2022 20:44:03 -0700
Received: from kbuild by 242b25809ac7 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nrX51-000325-4c;
        Thu, 19 May 2022 03:44:03 +0000
Date:   Thu, 19 May 2022 11:43:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     Tao Wang <quic_wat@quicinc.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, quic_wat@quicinc.com
Subject: Re: [PATCH] usb: xhci: save hcd_priv memory of shared_hcd
Message-ID: <202205191134.S40uS4gM-lkp@intel.com>
References: <1652926622-85047-1-git-send-email-quic_wat@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1652926622-85047-1-git-send-email-quic_wat@quicinc.com>
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on v5.18-rc7]
[cannot apply to usb/usb-testing next-20220518]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Tao-Wang/usb-xhci-save-hcd_priv-memory-of-shared_hcd/20220519-102117
base:    42226c989789d8da4af1de0c31070c96726d990c
config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20220519/202205191134.S40uS4gM-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/77abc5fc1213b15d0bac6d67196a6af85e264d2a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Tao-Wang/usb-xhci-save-hcd_priv-memory-of-shared_hcd/20220519-102117
        git checkout 77abc5fc1213b15d0bac6d67196a6af85e264d2a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash drivers/usb/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/usb/host/xhci-plat.c: In function 'xhci_plat_probe':
>> drivers/usb/host/xhci-plat.c:290:31: error: assignment of member 'hcd_priv_size' in read-only object
     290 |         driver->hcd_priv_size = 0;
         |                               ^


vim +/hcd_priv_size +290 drivers/usb/host/xhci-plat.c

   175	
   176	static int xhci_plat_probe(struct platform_device *pdev)
   177	{
   178		const struct xhci_plat_priv *priv_match;
   179		const struct hc_driver	*driver;
   180		struct device		*sysdev, *tmpdev;
   181		struct xhci_hcd		*xhci;
   182		struct resource         *res;
   183		struct usb_hcd		*hcd;
   184		int			ret;
   185		int			irq;
   186		struct xhci_plat_priv	*priv = NULL;
   187	
   188	
   189		if (usb_disabled())
   190			return -ENODEV;
   191	
   192		driver = &xhci_plat_hc_driver;
   193	
   194		irq = platform_get_irq(pdev, 0);
   195		if (irq < 0)
   196			return irq;
   197	
   198		/*
   199		 * sysdev must point to a device that is known to the system firmware
   200		 * or PCI hardware. We handle these three cases here:
   201		 * 1. xhci_plat comes from firmware
   202		 * 2. xhci_plat is child of a device from firmware (dwc3-plat)
   203		 * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
   204		 */
   205		for (sysdev = &pdev->dev; sysdev; sysdev = sysdev->parent) {
   206			if (is_of_node(sysdev->fwnode) ||
   207				is_acpi_device_node(sysdev->fwnode))
   208				break;
   209	#ifdef CONFIG_PCI
   210			else if (sysdev->bus == &pci_bus_type)
   211				break;
   212	#endif
   213		}
   214	
   215		if (!sysdev)
   216			sysdev = &pdev->dev;
   217	
   218		if (WARN_ON(!sysdev->dma_mask))
   219			/* Platform did not initialize dma_mask */
   220			ret = dma_coerce_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
   221		else
   222			ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
   223		if (ret)
   224			return ret;
   225	
   226		pm_runtime_set_active(&pdev->dev);
   227		pm_runtime_enable(&pdev->dev);
   228		pm_runtime_get_noresume(&pdev->dev);
   229	
   230		hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
   231				       dev_name(&pdev->dev), NULL);
   232		if (!hcd) {
   233			ret = -ENOMEM;
   234			goto disable_runtime;
   235		}
   236	
   237		hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
   238		if (IS_ERR(hcd->regs)) {
   239			ret = PTR_ERR(hcd->regs);
   240			goto put_hcd;
   241		}
   242	
   243		hcd->rsrc_start = res->start;
   244		hcd->rsrc_len = resource_size(res);
   245	
   246		xhci = hcd_to_xhci(hcd);
   247	
   248		/*
   249		 * Not all platforms have clks so it is not an error if the
   250		 * clock do not exist.
   251		 */
   252		xhci->reg_clk = devm_clk_get_optional(&pdev->dev, "reg");
   253		if (IS_ERR(xhci->reg_clk)) {
   254			ret = PTR_ERR(xhci->reg_clk);
   255			goto put_hcd;
   256		}
   257	
   258		ret = clk_prepare_enable(xhci->reg_clk);
   259		if (ret)
   260			goto put_hcd;
   261	
   262		xhci->clk = devm_clk_get_optional(&pdev->dev, NULL);
   263		if (IS_ERR(xhci->clk)) {
   264			ret = PTR_ERR(xhci->clk);
   265			goto disable_reg_clk;
   266		}
   267	
   268		ret = clk_prepare_enable(xhci->clk);
   269		if (ret)
   270			goto disable_reg_clk;
   271	
   272		if (pdev->dev.of_node)
   273			priv_match = of_device_get_match_data(&pdev->dev);
   274		else
   275			priv_match = dev_get_platdata(&pdev->dev);
   276	
   277		if (priv_match) {
   278			priv = hcd_to_xhci_priv(hcd);
   279			/* Just copy data for now */
   280			*priv = *priv_match;
   281		}
   282	
   283		device_set_wakeup_capable(&pdev->dev, true);
   284	
   285		xhci->main_hcd = hcd;
   286		/*
   287		 * The shared_hcd->hcd_priv is not used in xhci,
   288		 * so not need to malloc hcd priv memory for shared_hcd.
   289		 */
 > 290		driver->hcd_priv_size = 0;
   291		xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
   292				dev_name(&pdev->dev), hcd);
   293		if (!xhci->shared_hcd) {
   294			ret = -ENOMEM;
   295			goto disable_clk;
   296		}
   297	
   298		/* imod_interval is the interrupt moderation value in nanoseconds. */
   299		xhci->imod_interval = 40000;
   300	
   301		/* Iterate over all parent nodes for finding quirks */
   302		for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {
   303	
   304			if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
   305				xhci->quirks |= XHCI_HW_LPM_DISABLE;
   306	
   307			if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
   308				xhci->quirks |= XHCI_LPM_SUPPORT;
   309	
   310			if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
   311				xhci->quirks |= XHCI_BROKEN_PORT_PED;
   312	
   313			device_property_read_u32(tmpdev, "imod-interval-ns",
   314						 &xhci->imod_interval);
   315		}
   316	
   317		hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
   318		if (IS_ERR(hcd->usb_phy)) {
   319			ret = PTR_ERR(hcd->usb_phy);
   320			if (ret == -EPROBE_DEFER)
   321				goto put_usb3_hcd;
   322			hcd->usb_phy = NULL;
   323		} else {
   324			ret = usb_phy_init(hcd->usb_phy);
   325			if (ret)
   326				goto put_usb3_hcd;
   327		}
   328	
   329		hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
   330		xhci->shared_hcd->tpl_support = hcd->tpl_support;
   331		if (priv && (priv->quirks & XHCI_SKIP_PHY_INIT))
   332			hcd->skip_phy_initialization = 1;
   333	
   334		if (priv && (priv->quirks & XHCI_SG_TRB_CACHE_SIZE_QUIRK))
   335			xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
   336	
   337		ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
   338		if (ret)
   339			goto disable_usb_phy;
   340	
   341		if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
   342			xhci->shared_hcd->can_do_streams = 1;
   343	
   344		ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
   345		if (ret)
   346			goto dealloc_usb2_hcd;
   347	
   348		device_enable_async_suspend(&pdev->dev);
   349		pm_runtime_put_noidle(&pdev->dev);
   350	
   351		/*
   352		 * Prevent runtime pm from being on as default, users should enable
   353		 * runtime pm using power/control in sysfs.
   354		 */
   355		pm_runtime_forbid(&pdev->dev);
   356	
   357		return 0;
   358	
   359	
   360	dealloc_usb2_hcd:
   361		usb_remove_hcd(hcd);
   362	
   363	disable_usb_phy:
   364		usb_phy_shutdown(hcd->usb_phy);
   365	
   366	put_usb3_hcd:
   367		usb_put_hcd(xhci->shared_hcd);
   368	
   369	disable_clk:
   370		clk_disable_unprepare(xhci->clk);
   371	
   372	disable_reg_clk:
   373		clk_disable_unprepare(xhci->reg_clk);
   374	
   375	put_hcd:
   376		usb_put_hcd(hcd);
   377	
   378	disable_runtime:
   379		pm_runtime_put_noidle(&pdev->dev);
   380		pm_runtime_disable(&pdev->dev);
   381	
   382		return ret;
   383	}
   384	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
