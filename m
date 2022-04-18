Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0107F505B1D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 17:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241323AbiDRPev (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 11:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242780AbiDRPe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 11:34:28 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A77143FD87;
        Mon, 18 Apr 2022 07:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650293374; x=1681829374;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=O8jCNttKfcTOfPhW6/iydPjwJI9EDwBsW/ipQu39Hh0=;
  b=B3Ao3sc6+PxBjMfoK3jUdgpb7fM2h+csTYk87o/RJVwdsKk7xgdCf5cf
   hGB/eewh7RjIh2MtIihtzkuwcKgUsKSJ9sKfdb0KQhGooTJ7732vkeUoi
   nURGQFWPguFNJ6shpWU1Xb0G7HacLX3aglOKHQGsQ+D/tJY9mLOEDtrbl
   vYXfYxGSkKYBT8FQUSzUbMaZAdmJVsRXZQiy/zR5nfm2IfgRCZDyxZrVc
   IToP47/RfdqEvF5gZrdDbLg9xghCCYSOtRtJW4mnezaBkCgOWSmF0yRhT
   KxkvdWtf3nvT3ghSp5+M5pXc4LV2U+YkjLpMRvPfn+TpizDthyefWAU6U
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10321"; a="245421912"
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="245421912"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2022 07:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,270,1643702400"; 
   d="scan'208";a="726666030"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 18 Apr 2022 07:49:31 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngSh0-0004iB-J8;
        Mon, 18 Apr 2022 14:49:30 +0000
Date:   Mon, 18 Apr 2022 22:49:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Aswath Govindraju <a-govindraju@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] drivers: mmc: sdhci_am654: Add the quirk to set
 TESTCD bit
Message-ID: <202204182202.yPPV6YZI-lkp@intel.com>
References: <20220418102040.4993-3-a-govindraju@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418102040.4993-3-a-govindraju@ti.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test WARNING on robh/for-next]
[also build test WARNING on linus/master ulf-hansson-mmc-mirror/next v5.18-rc3 next-20220414]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Aswath-Govindraju/MMC-Add-quirk-to-set-the-TESTCD-bit/20220418-182325
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: riscv-randconfig-r016-20220418 (https://download.01.org/0day-ci/archive/20220418/202204182202.yPPV6YZI-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 429cbac0390654f90bba18a41799464adf31a5ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/a7d917691f55e240b1ab0abf36b0b39d1194a323
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Aswath-Govindraju/MMC-Add-quirk-to-set-the-TESTCD-bit/20220418-182325
        git checkout a7d917691f55e240b1ab0abf36b0b39d1194a323
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash drivers/mmc/host/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from drivers/mmc/host/sdhci_am654.c:9:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:464:31: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __raw_readb(PCI_IOBASE + addr);
                             ~~~~~~~~~~ ^
   include/asm-generic/io.h:477:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le16_to_cpu((__le16 __force)__raw_readw(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:37:51: note: expanded from macro '__le16_to_cpu'
   #define __le16_to_cpu(x) ((__force __u16)(__le16)(x))
                                                     ^
   In file included from drivers/mmc/host/sdhci_am654.c:9:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/mmc/host/sdhci_am654.c:9:
   In file included from include/linux/iopoll.h:14:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:501:33: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writeb(value, PCI_IOBASE + addr);
                               ~~~~~~~~~~ ^
   include/asm-generic/io.h:511:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writew((u16 __force)cpu_to_le16(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:521:59: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           __raw_writel((u32 __force)cpu_to_le32(value), PCI_IOBASE + addr);
                                                         ~~~~~~~~~~ ^
   include/asm-generic/io.h:1024:55: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           return (port > MMIO_UPPER_LIMIT) ? NULL : PCI_IOBASE + port;
                                                     ~~~~~~~~~~ ^
>> drivers/mmc/host/sdhci_am654.c:375:6: warning: no previous prototype for function 'sdhci_am654_reset' [-Wmissing-prototypes]
   void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
        ^
   drivers/mmc/host/sdhci_am654.c:375:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
   void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
   ^
   static 
   8 warnings generated.


vim +/sdhci_am654_reset +375 drivers/mmc/host/sdhci_am654.c

   374	
 > 375	void sdhci_am654_reset(struct sdhci_host *host, u8 mask)
   376	{
   377		u8 ctrl;
   378		struct sdhci_pltfm_host *pltfm_host = sdhci_priv(host);
   379		struct sdhci_am654_data *sdhci_am654 = sdhci_pltfm_priv(pltfm_host);
   380	
   381		sdhci_reset(host, mask);
   382	
   383		if (sdhci_am654->quirks & SDHCI_AM654_QUIRK_FORCE_CDTEST) {
   384			ctrl = sdhci_readb(host, SDHCI_HOST_CONTROL);
   385			ctrl |= SDHCI_CTRL_CDTEST_INS | SDHCI_CTRL_CDTEST_EN;
   386			sdhci_writeb(host, ctrl, SDHCI_HOST_CONTROL);
   387		}
   388	}
   389	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
