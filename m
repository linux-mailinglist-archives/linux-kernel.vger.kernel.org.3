Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FD6E5AC171
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 23:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiICVdO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 17:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiICVdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 17:33:12 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA1949B60
        for <linux-kernel@vger.kernel.org>; Sat,  3 Sep 2022 14:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662240791; x=1693776791;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=DdROJJyFoDFybdcKUUDVwpQAp9WdLWvtGivqf21JP8M=;
  b=ZMU71xoMgoZHPebH5v49e30CeI8R1lQsugStjsWFCFgBZCrBSTiKyaUn
   rEWcf9rcdbFS5pyXv51prqyi6RQM2LQDbfsq186LqSayJpGpaR7gSneQs
   llvIpObbeZabXN2F1NoyJ0MdVXfxqYzmbajIBkmlT1sSSSmS2TNHYJrk8
   JJ50/k2BDBs6MRjRbbXLBnqC3Ee9WiG9wlrNLhTkhAj74O5m7Mh/kr0sX
   eyH9PGSI8RVNQ74cN5nSyN2c9iYkDmeUJDiO1c9cVD070CWF5Zf3WS8m+
   JQ2PnaEonFE/RHtiaE1HQRiLQ0q7AKtG9sjQzu3ZF7Esw/EpOybw37SFm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10459"; a="279206101"
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="279206101"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Sep 2022 14:33:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,287,1654585200"; 
   d="scan'208";a="646482092"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga001.jf.intel.com with ESMTP; 03 Sep 2022 14:33:09 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUalJ-0002Dx-0j;
        Sat, 03 Sep 2022 21:33:09 +0000
Date:   Sun, 4 Sep 2022 05:32:10 +0800
From:   kernel test robot <lkp@intel.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: xillybus_of.c:undefined reference to `devm_platform_ioremap_resource'
Message-ID: <202209040504.IypzxQ0u-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Herbert,

FYI, the error/warning was bisected to this commit, please ignore it if it's irrelevant.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   42cf58c272ee1dae902e8cc1166c246589abd1d8
commit: a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a hwrng: ks-sa - Add dependency on IOMEM and OF
date:   1 year, 9 months ago
config: s390-randconfig-r015-20220902 (https://download.01.org/0day-ci/archive/20220904/202209040504.IypzxQ0u-lkp@intel.com/config)
compiler: s390-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a
        git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
        git fetch --no-tags linus master
        git checkout a1315dcb7b6a7d3a78df848eed5b331a4b3ec28a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   s390-linux-ld: kernel/dma/coherent.o: in function `dma_init_coherent_memory':
   coherent.c:(.text+0x374): undefined reference to `memremap'
   s390-linux-ld: coherent.c:(.text+0x436): undefined reference to `memunmap'
   s390-linux-ld: kernel/dma/coherent.o: in function `dma_declare_coherent_memory':
   coherent.c:(.text+0x576): undefined reference to `memunmap'
   s390-linux-ld: drivers/irqchip/irq-al-fic.o: in function `al_fic_init_dt':
   irq-al-fic.c:(.init.text+0x4e): undefined reference to `of_iomap'
   s390-linux-ld: irq-al-fic.c:(.init.text+0xaa): undefined reference to `iounmap'
   s390-linux-ld: drivers/irqchip/irq-imx-intmux.o: in function `imx_intmux_probe':
   irq-imx-intmux.c:(.text+0x442): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/phy/marvell/phy-mvebu-a3700-utmi.o: in function `mvebu_a3700_utmi_phy_probe':
   phy-mvebu-a3700-utmi.c:(.text+0xfe): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_close':
   dpaa2-console.c:(.text+0x6a): undefined reference to `iounmap'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_console_probe':
   dpaa2-console.c:(.text+0x122): undefined reference to `of_address_to_resource'
   s390-linux-ld: drivers/soc/fsl/dpaa2-console.o: in function `dpaa2_generic_console_open.constprop.0':
   dpaa2-console.c:(.text+0x214): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x266): undefined reference to `iounmap'
   s390-linux-ld: dpaa2-console.c:(.text+0x29a): undefined reference to `ioremap'
   s390-linux-ld: dpaa2-console.c:(.text+0x328): undefined reference to `iounmap'
   s390-linux-ld: drivers/char/hw_random/exynos-trng.o: in function `exynos_trng_probe':
   exynos-trng.c:(.text+0x15e): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/meson-rng.o: in function `meson_rng_probe':
   meson-rng.c:(.text+0x70): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/mtk-rng.o: in function `mtk_rng_probe':
   mtk-rng.c:(.text+0x228): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/hw_random/npcm-rng.o: in function `npcm_rng_probe':
   npcm-rng.c:(.text+0x1ba): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/char/xillybus/xillybus_of.o: in function `xilly_drv_probe':
>> xillybus_of.c:(.text+0x13e): undefined reference to `devm_platform_ioremap_resource'
   s390-linux-ld: drivers/mfd/sun6i-prcm.o: in function `sun6i_prcm_probe':
   sun6i-prcm.c:(.text+0xa0): undefined reference to `mfd_add_devices'
   s390-linux-ld: drivers/crypto/ccree/cc_driver.o: in function `init_cc_resources':
   cc_driver.c:(.text+0x674): undefined reference to `devm_ioremap_resource'
   s390-linux-ld: drivers/crypto/ccree/cc_debugfs.o: in function `cc_debugfs_init':
   cc_debugfs.c:(.text+0x9e): undefined reference to `debugfs_create_regset32'
   s390-linux-ld: cc_debugfs.c:(.text+0x132): undefined reference to `debugfs_create_regset32'

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for MFD_SUN6I_PRCM
   Depends on [n]: HAS_IOMEM [=n] && (ARCH_SUNXI || COMPILE_TEST [=y])
   Selected by [y]:
   - CLK_SUNXI_PRCM_SUN6I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]
   - CLK_SUNXI_PRCM_SUN8I [=y] && COMMON_CLK [=y] && CLK_SUNXI [=y]

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
