Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C795254E5
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 20:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357695AbiELSc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 14:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348597AbiELSct (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 14:32:49 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593A066AF9;
        Thu, 12 May 2022 11:32:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652380368; x=1683916368;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JBD/BOyBgOSo5G3/QrG5L2dDxQ6PiNBv+zX/DqZxiQE=;
  b=eBpu/6N2dg67TAO+Lr/SmeG37LcJ7vJCTZ2nPZIPMmHoRcEngu0NVvlL
   A8CgUV5B4fqnTdXv3QtnESPYvQ2FEed86Ygzj12XZPlEzwjnTHkc1ZNDF
   ErShYtvm9945DFg+9mfgJr9ACuI3Yz5JqX9KVgDYDN6HhEhaxNbe9+9ny
   ujc9/+LFa1xpFj0QfQdyuMtaZEKl45B2hsHWqUEXi2hufnSP4Uet4yqVb
   QXrxGX9wpYbzJ7HqDA1RQrxPVvLywXSybiFUuUwIIyj7b3ucmjn0bmj+0
   Ix+wituIXG+lG8WuKYxCiz/xykCLlSW9x8wdgw5cPwINh0OxtA4rnaVvT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10345"; a="295359445"
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="295359445"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 May 2022 11:32:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,220,1647327600"; 
   d="scan'208";a="624525355"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 12 May 2022 11:32:45 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npDcC-000Koe-Kw;
        Thu, 12 May 2022 18:32:44 +0000
Date:   Fri, 13 May 2022 02:32:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     kbuild-all@lists.01.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Rob Herring <robh+dt@kernel.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 07/23] ata: libahci_platform: Convert to using devm
 bulk clocks API
Message-ID: <202205130237.a48PdxbJ-lkp@intel.com>
References: <20220511231810.4928-8-Sergey.Semin@baikalelectronics.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220511231810.4928-8-Sergey.Semin@baikalelectronics.ru>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Serge,

I love your patch! Yet something to improve:

[auto build test ERROR on axboe-block/for-next]
[also build test ERROR on robh/for-next linus/master v5.18-rc6 next-20220512]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220512-072125
base:   https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git for-next
config: sh-randconfig-r006-20220512 (https://download.01.org/0day-ci/archive/20220513/202205130237.a48PdxbJ-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/71066bfbd7d3a8cab5b76032068f5bcdc6d99b21
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Serge-Semin/ata-ahci-Add-DWC-Baikal-T1-AHCI-SATA-support/20220512-072125
        git checkout 71066bfbd7d3a8cab5b76032068f5bcdc6d99b21
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   sh4-linux-ld: drivers/ata/libahci_platform.o: in function `ahci_platform_get_resources':
>> drivers/ata/libahci_platform.c:382: undefined reference to `__clk_get_name'


vim +382 drivers/ata/libahci_platform.c

fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  347  
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  348  /**
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  349   * ahci_platform_get_resources - Get platform resources
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  350   * @pdev: platform device to get resources for
16af2d65842d343 Kunihiko Hayashi          2018-08-22  351   * @flags: bitmap representing the resource to get
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  352   *
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  353   * This function allocates an ahci_host_priv struct, and gets the following
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  354   * resources, storing a reference to them inside the returned struct:
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  355   *
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  356   * 1) mmio registers (IORESOURCE_MEM 0, mandatory)
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  357   * 2) regulator for controlling the targets power (optional)
a37da9180f42c95 Corentin Labbe            2018-09-03  358   *    regulator for controlling the AHCI controller (optional)
71066bfbd7d3a8c Serge Semin               2022-05-12  359   * 3) all clocks specified in the devicetree node, or a single
71066bfbd7d3a8c Serge Semin               2022-05-12  360   *    clock for non-OF platforms (optional)
9d2ab9957397083 Kunihiko Hayashi          2018-08-22  361   * 4) resets, if flags has AHCI_PLATFORM_GET_RESETS (optional)
9d2ab9957397083 Kunihiko Hayashi          2018-08-22  362   * 5) phys (optional)
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  363   *
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  364   * RETURNS:
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  365   * The allocated ahci_host_priv on success, otherwise an ERR_PTR value
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  366   */
16af2d65842d343 Kunihiko Hayashi          2018-08-22  367  struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
16af2d65842d343 Kunihiko Hayashi          2018-08-22  368  						   unsigned int flags)
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  369  {
71066bfbd7d3a8c Serge Semin               2022-05-12  370  	int rc, child_nodes, enabled_ports = 0;
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  371  	struct device *dev = &pdev->dev;
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  372  	struct ahci_host_priv *hpriv;
b1a9edbda040a43 Antoine Tenart            2014-07-30  373  	struct device_node *child;
b1a9edbda040a43 Antoine Tenart            2014-07-30  374  	u32 mask_port_map = 0;
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  375  
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  376  	if (!devres_open_group(dev, NULL, GFP_KERNEL))
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  377  		return ERR_PTR(-ENOMEM);
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  378  
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  379  	hpriv = devres_alloc(ahci_platform_put_resources, sizeof(*hpriv),
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  380  			     GFP_KERNEL);
09d29e57ad01111 Serge Semin               2022-05-12  381  	if (!hpriv) {
09d29e57ad01111 Serge Semin               2022-05-12 @382  		rc = -ENOMEM;
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  383  		goto err_out;
09d29e57ad01111 Serge Semin               2022-05-12  384  	}
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  385  
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  386  	devres_add(dev, hpriv);
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  387  
a28445fba62bae3 Serge Semin               2022-05-12  388  	/*
a28445fba62bae3 Serge Semin               2022-05-12  389  	 * If the DT provided an "ahci" named resource, use it. Otherwise,
a28445fba62bae3 Serge Semin               2022-05-12  390  	 * fallback to using the default first resource for the device node.
a28445fba62bae3 Serge Semin               2022-05-12  391  	 */
a28445fba62bae3 Serge Semin               2022-05-12  392  	if (platform_get_resource_byname(pdev, IORESOURCE_MEM, "ahci"))
a28445fba62bae3 Serge Semin               2022-05-12  393  		hpriv->mmio = devm_platform_ioremap_resource_byname(pdev, "ahci");
a28445fba62bae3 Serge Semin               2022-05-12  394  	else
a28445fba62bae3 Serge Semin               2022-05-12  395  		hpriv->mmio = devm_platform_ioremap_resource(pdev, 0);
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  396  	if (IS_ERR(hpriv->mmio)) {
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  397  		rc = PTR_ERR(hpriv->mmio);
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  398  		goto err_out;
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  399  	}
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  400  
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  401  	/*
71066bfbd7d3a8c Serge Semin               2022-05-12  402  	 * Bulk clocks getting procedure can fail to find any clock due to
71066bfbd7d3a8c Serge Semin               2022-05-12  403  	 * running on a non-OF platform or due to the clocks being defined in
71066bfbd7d3a8c Serge Semin               2022-05-12  404  	 * bypass of the DT firmware (like da850, spear13xx). In that case we
71066bfbd7d3a8c Serge Semin               2022-05-12  405  	 * fallback to getting a single clock source right from the dev clocks
71066bfbd7d3a8c Serge Semin               2022-05-12  406  	 * list.
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  407  	 */
71066bfbd7d3a8c Serge Semin               2022-05-12  408  	rc = devm_clk_bulk_get_all(dev, &hpriv->clks);
71066bfbd7d3a8c Serge Semin               2022-05-12  409  	if (rc < 0)
71066bfbd7d3a8c Serge Semin               2022-05-12  410  		goto err_out;
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  411  
71066bfbd7d3a8c Serge Semin               2022-05-12  412  	if (rc > 0) {
71066bfbd7d3a8c Serge Semin               2022-05-12  413  		/* Got clocks in bulk */
71066bfbd7d3a8c Serge Semin               2022-05-12  414  		hpriv->n_clks = rc;
71066bfbd7d3a8c Serge Semin               2022-05-12  415  	} else {
71066bfbd7d3a8c Serge Semin               2022-05-12  416  		/*
71066bfbd7d3a8c Serge Semin               2022-05-12  417  		 * No clock bulk found: fallback to manually getting
71066bfbd7d3a8c Serge Semin               2022-05-12  418  		 * the optional clock.
71066bfbd7d3a8c Serge Semin               2022-05-12  419  		 */
71066bfbd7d3a8c Serge Semin               2022-05-12  420  		hpriv->clks = devm_kzalloc(dev, sizeof(*hpriv->clks), GFP_KERNEL);
71066bfbd7d3a8c Serge Semin               2022-05-12  421  		if (!hpriv->clks) {
71066bfbd7d3a8c Serge Semin               2022-05-12  422  			rc = -ENOMEM;
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  423  			goto err_out;
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  424  		}
71066bfbd7d3a8c Serge Semin               2022-05-12  425  		hpriv->clks->clk = devm_clk_get_optional(dev, NULL);
71066bfbd7d3a8c Serge Semin               2022-05-12  426  		if (IS_ERR(hpriv->clks->clk)) {
71066bfbd7d3a8c Serge Semin               2022-05-12  427  			rc = PTR_ERR(hpriv->clks->clk);
71066bfbd7d3a8c Serge Semin               2022-05-12  428  			goto err_out;
71066bfbd7d3a8c Serge Semin               2022-05-12  429  		} else if (hpriv->clks->clk) {
71066bfbd7d3a8c Serge Semin               2022-05-12  430  			hpriv->clks->id = __clk_get_name(hpriv->clks->clk);
71066bfbd7d3a8c Serge Semin               2022-05-12  431  			hpriv->n_clks = 1;
71066bfbd7d3a8c Serge Semin               2022-05-12  432  		}
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  433  	}
fd990556f0fa254 Bartlomiej Zolnierkiewicz 2014-03-25  434  
962399bb7fbf5ce Mark Brown                2019-10-16  435  	hpriv->ahci_regulator = devm_regulator_get(dev, "ahci");
a37da9180f42c95 Corentin Labbe            2018-09-03  436  	if (IS_ERR(hpriv->ahci_regulator)) {
a37da9180f42c95 Corentin Labbe            2018-09-03  437  		rc = PTR_ERR(hpriv->ahci_regulator);
962399bb7fbf5ce Mark Brown                2019-10-16  438  		if (rc != 0)
a37da9180f42c95 Corentin Labbe            2018-09-03  439  			goto err_out;
a37da9180f42c95 Corentin Labbe            2018-09-03  440  	}
a37da9180f42c95 Corentin Labbe            2018-09-03  441  
962399bb7fbf5ce Mark Brown                2019-10-16  442  	hpriv->phy_regulator = devm_regulator_get(dev, "phy");
f20fb266e77a8af Corentin Labbe            2018-09-03  443  	if (IS_ERR(hpriv->phy_regulator)) {
f20fb266e77a8af Corentin Labbe            2018-09-03  444  		rc = PTR_ERR(hpriv->phy_regulator);
f20fb266e77a8af Corentin Labbe            2018-09-03  445  		goto err_out;
f20fb266e77a8af Corentin Labbe            2018-09-03  446  	}
f20fb266e77a8af Corentin Labbe            2018-09-03  447  
9d2ab9957397083 Kunihiko Hayashi          2018-08-22  448  	if (flags & AHCI_PLATFORM_GET_RESETS) {
9d2ab9957397083 Kunihiko Hayashi          2018-08-22  449  		hpriv->rsts = devm_reset_control_array_get_optional_shared(dev);
9d2ab9957397083 Kunihiko Hayashi          2018-08-22  450  		if (IS_ERR(hpriv->rsts)) {
9d2ab9957397083 Kunihiko Hayashi          2018-08-22  451  			rc = PTR_ERR(hpriv->rsts);
9d2ab9957397083 Kunihiko Hayashi          2018-08-22  452  			goto err_out;
9d2ab9957397083 Kunihiko Hayashi          2018-08-22  453  		}
9d2ab9957397083 Kunihiko Hayashi          2018-08-22  454  	}
9d2ab9957397083 Kunihiko Hayashi          2018-08-22  455  
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  456  	hpriv->nports = child_nodes = of_get_child_count(dev->of_node);
b1a9edbda040a43 Antoine Tenart            2014-07-30  457  
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  458  	/*
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  459  	 * If no sub-node was found, we still need to set nports to
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  460  	 * one in order to be able to use the
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  461  	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  462  	 */
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  463  	if (!child_nodes)
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  464  		hpriv->nports = 1;
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  465  
a4b9f5ed02e2351 Corentin Labbe            2018-07-12  466  	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
b1a9edbda040a43 Antoine Tenart            2014-07-30  467  	if (!hpriv->phys) {
b1a9edbda040a43 Antoine Tenart            2014-07-30  468  		rc = -ENOMEM;
b1a9edbda040a43 Antoine Tenart            2014-07-30  469  		goto err_out;
b1a9edbda040a43 Antoine Tenart            2014-07-30  470  	}
04ba9488199e3ee Corentin Labbe            2018-07-17  471  	/*
04ba9488199e3ee Corentin Labbe            2018-07-17  472  	 * We cannot use devm_ here, since ahci_platform_put_resources() uses
04ba9488199e3ee Corentin Labbe            2018-07-17  473  	 * target_pwrs after devm_ have freed memory
04ba9488199e3ee Corentin Labbe            2018-07-17  474  	 */
04ba9488199e3ee Corentin Labbe            2018-07-17  475  	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  476  	if (!hpriv->target_pwrs) {
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  477  		rc = -ENOMEM;
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  478  		goto err_out;
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  479  	}
b1a9edbda040a43 Antoine Tenart            2014-07-30  480  
c7d7ddee7e24eed Gregory CLEMENT           2015-01-15  481  	if (child_nodes) {
b1a9edbda040a43 Antoine Tenart            2014-07-30  482  		for_each_child_of_node(dev->of_node, child) {
b1a9edbda040a43 Antoine Tenart            2014-07-30  483  			u32 port;
f627cfdeb7d07df Guenter Roeck             2015-01-31  484  			struct platform_device *port_dev __maybe_unused;
b1a9edbda040a43 Antoine Tenart            2014-07-30  485  
b1a9edbda040a43 Antoine Tenart            2014-07-30  486  			if (!of_device_is_available(child))
b1a9edbda040a43 Antoine Tenart            2014-07-30  487  				continue;
b1a9edbda040a43 Antoine Tenart            2014-07-30  488  
b1a9edbda040a43 Antoine Tenart            2014-07-30  489  			if (of_property_read_u32(child, "reg", &port)) {
b1a9edbda040a43 Antoine Tenart            2014-07-30  490  				rc = -EINVAL;
d7f76f36a8b4dc8 Nishka Dasgupta           2019-08-15  491  				of_node_put(child);
b1a9edbda040a43 Antoine Tenart            2014-07-30  492  				goto err_out;
b1a9edbda040a43 Antoine Tenart            2014-07-30  493  			}
b1a9edbda040a43 Antoine Tenart            2014-07-30  494  
b1a9edbda040a43 Antoine Tenart            2014-07-30  495  			if (port >= hpriv->nports) {
b1a9edbda040a43 Antoine Tenart            2014-07-30  496  				dev_warn(dev, "invalid port number %d\n", port);
b1a9edbda040a43 Antoine Tenart            2014-07-30  497  				continue;
b1a9edbda040a43 Antoine Tenart            2014-07-30  498  			}
b1a9edbda040a43 Antoine Tenart            2014-07-30  499  			mask_port_map |= BIT(port);
b1a9edbda040a43 Antoine Tenart            2014-07-30  500  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
