Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551135855CF
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 21:56:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239007AbiG2T40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 15:56:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238989AbiG2T4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 15:56:24 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A754B87C20;
        Fri, 29 Jul 2022 12:56:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659124583; x=1690660583;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=icmzx4g7Va0EWQGiMBuf7Cg0LU8Z1mCtK02FJnlNI/8=;
  b=R+SiDLDqvrnH+Z9rK98gj7U1yYvKcQD6GpTBdHNdhdWHpPSRA/LJ9c/D
   3n5Udx1mUiOBeK5g8XX3YUl8EHdEbf6k9jPtA+j2UuCtxs7Q7fwIBLOmQ
   phBySzpZw2ifx9w3v9gG4izHlreZSyfrgyzDkCXXAVs+v9hvOVFAx9IzL
   risS0an/rtGOybzujc9sVX/RhslRj0kvF8OLekoZBztbqwS/5xAtxx3MJ
   DL3Zes/uY/bxWEzs+xAIH3lkSE9VfNP/TYrNqS4WUbEdWByt8E9iDU2cw
   uTGvpha4Mv/+1UzEXCFBEBG7T2yRRnyomVgewPITVqayDa0vejKfCUUyL
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10423"; a="286394159"
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="286394159"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2022 12:56:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,201,1654585200"; 
   d="scan'208";a="690834908"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 29 Jul 2022 12:56:20 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHW5s-000C2s-05;
        Fri, 29 Jul 2022 19:56:20 +0000
Date:   Sat, 30 Jul 2022 03:56:03 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>, Hannes Reinecke <hare@suse.de>
Cc:     kbuild-all@lists.01.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH RESEND v6 07/23] ata: libahci_platform: Convert to using
 devm bulk clocks API
Message-ID: <202207300343.gBqrivXn-lkp@intel.com>
References: <20220728111905.12427-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220728111905.12427-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on axboe-block/for-next linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220728-192315
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: m68k-randconfig-s052-20220729 (https://download.01.org/0day-ci/archive/20220730/202207300343.gBqrivXn-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 12.1.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-39-gce1a6720-dirty
        # https://github.com/intel-lab-lkp/linux/commit/a84e837dd293db69f2510f3036f2c83ce8b0167c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220728-192315
        git checkout a84e837dd293db69f2510f3036f2c83ce8b0167c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/ata/libahci_platform.o: in function `ahci_platform_get_resources':
>> drivers/ata/libahci_platform.c:428: undefined reference to `__clk_get_name'


vim +428 drivers/ata/libahci_platform.c

   347	
   348	/**
   349	 * ahci_platform_get_resources - Get platform resources
   350	 * @pdev: platform device to get resources for
   351	 * @flags: bitmap representing the resource to get
   352	 *
   353	 * This function allocates an ahci_host_priv struct, and gets the following
   354	 * resources, storing a reference to them inside the returned struct:
   355	 *
   356	 * 1) mmio registers (IORESOURCE_MEM 0, mandatory)
   357	 * 2) regulator for controlling the targets power (optional)
   358	 *    regulator for controlling the AHCI controller (optional)
   359	 * 3) all clocks specified in the devicetree node, or a single
   360	 *    clock for non-OF platforms (optional)
   361	 * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
   362	 * 5) phys (optional)
   363	 *
   364	 * RETURNS:
   365	 * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
   366	 */
   367	struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
   368							   unsigned int flags)
   369	{
   370		int child_nodes, rc = -ENOMEM, enabled_ports = 0;
   371		struct device *dev = &pdev->dev;
   372		struct ahci_host_priv *hpriv;
   373		struct device_node *child;
   374		u32 mask_port_map = 0;
   375	
   376		if (!devres_open_group(dev, NULL, GFP_KERNEL))
   377			return ERR_PTR(-ENOMEM);
   378	
   379		hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
   380				     GFP_KERNEL);
   381		if (!hpriv)
   382			goto err_out;
   383	
   384		devres_add(dev, hpriv);
   385	
   386		/*
   387		 * If the DT provided an "ahci" named resource, use it. Otherwise,
   388		 * fallback to using the default first resource for the device node.
   389		 */
   390		if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci"))
   391			hpriv->mmio = devm_platform_ioremap_resource_byname(pdev, "ahci");
   392		else
   393			hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
   394		if (IS_ERR(hpriv->mmio)) {
   395			rc = PTR_ERR(hpriv->mmio);
   396			goto err_out;
   397		}
   398	
   399		/*
   400		 * Bulk clocks getting procedure can fail to find any clock due to
   401		 * running on a non-OF platform or due to the clocks being defined in
   402		 * bypass of the DT firmware (like da850, spear13xx). In that case we
   403		 * fallback to getting a single clock source right from the dev clocks
   404		 * list.
   405		 */
   406		rc = devm_clk_bulk_get_all(dev, &hpriv->clks);
   407		if (rc < 0)
   408			goto err_out;
   409	
   410		if (rc > 0) {
   411			/* Got clocks in bulk */
   412			hpriv->n_clks = rc;
   413		} else {
   414			/*
   415			 * No clock bulk found: fallback to manually getting
   416			 * the optional clock.
   417			 */
   418			hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
   419			if (!hpriv->clks) {
   420				rc = -ENOMEM;
   421				goto err_out;
   422			}
   423			hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
   424			if (IS_ERR(hpriv->clks->clk)) {
   425				rc = PTR_ERR(hpriv->clks->clk);
   426				goto err_out;
   427			} else if (hpriv->clks->clk) {
 > 428				hpriv->clks->id = __clk_get_name(hpriv->clks->clk);
   429				hpriv->n_clks = 1;
   430			}
   431		}
   432	
   433		hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
   434		if (IS_ERR(hpriv->ahci_regulator)) {
   435			rc = PTR_ERR(hpriv->ahci_regulator);
   436			if (rc != 0)
   437				goto err_out;
   438		}
   439	
   440		hpriv->phy_regulator = devm_regulator_get(dev, "phy");
   441		if (IS_ERR(hpriv->phy_regulator)) {
   442			rc = PTR_ERR(hpriv->phy_regulator);
   443			goto err_out;
   444		}
   445	
   446		if (flags & AHCI_PLATFORM_GET_RESETS) {
   447			hpriv->rsts = devm_reset_control_array_get_optional_shared(dev);
   448			if (IS_ERR(hpriv->rsts)) {
   449				rc = PTR_ERR(hpriv->rsts);
   450				goto err_out;
   451			}
   452		}
   453	
   454		hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
   455	
   456		/*
   457		 * If no sub-node was found, we still need to set nports to
   458		 * one in order to be able to use the
   459		 * ahci_platform_[en|dis]able_[phys|regulators] functions.
   460		 */
   461		if (!child_nodes)
   462			hpriv->nports = 1;
   463	
   464		hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
   465		if (!hpriv->phys) {
   466			rc = -ENOMEM;
   467			goto err_out;
   468		}
   469		/*
   470		 * We cannot use devm_ here, since ahci_platform_put_resources() uses
   471		 * target_pwrs after devm_ have freed memory
   472		 */
   473		hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
   474		if (!hpriv->target_pwrs) {
   475			rc = -ENOMEM;
   476			goto err_out;
   477		}
   478	
   479		if (child_nodes) {
   480			for_each_child_of_node(dev->of_node, child) {
   481				u32 port;
   482				struct platform_device *port_dev __maybe_unused;
   483	
   484				if (!of_device_is_available(child))
   485					continue;
   486	
   487				if (of_property_read_u32(child, "reg", &port)) {
   488					rc = -EINVAL;
   489					of_node_put(child);
   490					goto err_out;
   491				}
   492	
   493				if (port >= hpriv->nports) {
   494					dev_warn(dev, "invalid port number %d\n", port);
   495					continue;
   496				}
   497				mask_port_map |= BIT(port);
   498	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
