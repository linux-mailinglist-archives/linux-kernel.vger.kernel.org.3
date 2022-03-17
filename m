Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3CE04DC97B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 16:02:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235599AbiCQPD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 11:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbiCQPD0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:03:26 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E0F4203A58;
        Thu, 17 Mar 2022 08:02:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647529330; x=1679065330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=igAx1K+VLoM7S36/is1LCPa675eznCJ8RDhWohRr6r4=;
  b=PJC37VU3CDdCIgwbEsP6JOBzyrW5AWAuawqJeRZFEP5SfJHwqKJegEhI
   fKJGY4Z7DzBgTtu3z5w6IruKk6w8PIGPRTioS+36PTTI/T8VWdrqUFYxF
   E5gQZTVzyprgyUpPJJ5qqMlNw1c/k7R17lnu7VEqSRoe4Vxae9Ghx+u/S
   l6RfC2Gr2tgUT7zxOxQbTukULkRu5sxB5SQ5TWOhgNml5VXUVyHqJujtk
   bMChMt6zlRXklBz7Vri1WBjhKoiKW6degK+ns7XFjEAHLmU0MsfIzfEtj
   Rnt8hqqQy+Is9WQfkqLbuUTTArZWq1HDjV7rNOI8DpsqWi2zB4/m2/szd
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10289"; a="257070424"
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="257070424"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2022 08:01:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,188,1643702400"; 
   d="scan'208";a="635386809"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Mar 2022 08:01:25 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUrcz-000DmU-8s; Thu, 17 Mar 2022 15:01:25 +0000
Date:   Thu, 17 Mar 2022 23:00:51 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krishna Yarlagadda <kyarlagadda@nvidia.com>, broonie@kernel.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-spi@vger.kernel.org, linux-tegra@vger.kernel.org,
        ashishsingha@nvidia.com
Cc:     kbuild-all@lists.01.org, skomatineni@nvidia.com,
        ldewangan@nvidia.com, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Yarlagadda <kyarlagadda@nvidia.com>
Subject: Re: [PATCH 1/3] spi: tegra210-quad: Multi-cs support
Message-ID: <202203172241.iGAq0qeH-lkp@intel.com>
References: <20220317012006.15080-2-kyarlagadda@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220317012006.15080-2-kyarlagadda@nvidia.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krishna,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on next-20220316]
[cannot apply to v5.17-rc8]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Krishna-Yarlagadda/spi-tegra-quad-Add-Tegra-Grace-features/20220317-092247
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: ia64-allmodconfig (https://download.01.org/0day-ci/archive/20220317/202203172241.iGAq0qeH-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/38ff812651f89adc738066112000ec32eb73d106
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Krishna-Yarlagadda/spi-tegra-quad-Add-Tegra-Grace-features/20220317-092247
        git checkout 38ff812651f89adc738066112000ec32eb73d106
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=ia64 SHELL=/bin/bash drivers/spi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/spi/spi-tegra210-quad.c:1497:49: error: 'th500_qspi_soc_data' undeclared here (not in a function); did you mean 'tegra_qspi_soc_data'?
    1497 |                 .driver_data = (kernel_ulong_t)&th500_qspi_soc_data,
         |                                                 ^~~~~~~~~~~~~~~~~~~
         |                                                 tegra_qspi_soc_data


vim +1497 drivers/spi/spi-tegra210-quad.c

  1483	
  1484	#ifdef CONFIG_ACPI
  1485	static const struct acpi_device_id tegra_qspi_acpi_match[] = {
  1486		{
  1487			.id = "NVDA1213",
  1488			.driver_data = (kernel_ulong_t)&tegra210_qspi_soc_data,
  1489		}, {
  1490			.id = "NVDA1313",
  1491			.driver_data = (kernel_ulong_t)&tegra186_qspi_soc_data,
  1492		}, {
  1493			.id = "NVDA1413",
  1494			.driver_data = (kernel_ulong_t)&tegra234_qspi_soc_data,
  1495		}, {
  1496			.id = "NVDA1513",
> 1497			.driver_data = (kernel_ulong_t)&th500_qspi_soc_data,
  1498		},
  1499		{}
  1500	};
  1501	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
