Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55BAF59B62C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Aug 2022 21:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbiHUTrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 Aug 2022 15:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHUTrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Aug 2022 15:47:06 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15A6F1408C
        for <linux-kernel@vger.kernel.org>; Sun, 21 Aug 2022 12:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661111225; x=1692647225;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Xgq5pV8NmzafHjaVV82jPIGbVdCuhC2gTgsrPRjWnRk=;
  b=e6XN0fWyNtJrl5l1AHDb0YHgxbRrGnauiom5N+9TD31ud/Sz3SV0SOI5
   riKXNoa86qc6io27J3tdUI8fo/pSfgJAcynKgs6n74BlpL7Cj3aDyC0z5
   ZaqyFxNwI94K8uqLVgO44l9mguZBWizFA8ubjGEt2crJJAeHXfvKkQFBd
   wCulTZ4YCPoYVlYUnb/uuJ4muwmKPtObKjrDr9tQwSqLO0XFAOzSpDlR5
   xRrKFMuYMgWwaPYd3eSdGwGmgeMV/xGJEFEIfAJ5W97T835mk1OFYy+5Z
   h7S7DoA1dypJDCScRTONTPxHO3QeGwY3ota76DG8EQvmjG+GpY/5xFMjC
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="292017462"
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="292017462"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2022 12:47:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,253,1654585200"; 
   d="scan'208";a="559496311"
Received: from lkp-server01.sh.intel.com (HELO 44b6dac04a33) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Aug 2022 12:47:01 -0700
Received: from kbuild by 44b6dac04a33 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oPquS-0004QP-2M;
        Sun, 21 Aug 2022 19:47:00 +0000
Date:   Mon, 22 Aug 2022 03:46:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Igor Kononenko <i.kononenko@yadro.com>,
        Corey Minyard <minyard@acm.org>, Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        openbmc@lists.ozlabs.org, Igor Kononenko <i.kononenko@yadro.com>,
        openipmi-developer@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] ipmi:kcs_bmc: Add cleanup regmap(interrupt-regs) on
 a shutdown.
Message-ID: <202208220317.cROZCTcB-lkp@intel.com>
References: <fb81dda34f9db0b9f743b247a2464576dcccd7c9.1661094034.git.i.kononenko@yadro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fb81dda34f9db0b9f743b247a2464576dcccd7c9.1661094034.git.i.kononenko@yadro.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Igor,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on cminyard-ipmi/for-next]
[also build test ERROR on soc/for-next linus/master v6.0-rc1 next-20220819]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Igor-Kononenko/aspeed-lpc-Fix-lpc-snoop-probe-exception/20220822-000836
base:   https://github.com/cminyard/linux-ipmi for-next
config: riscv-randconfig-r042-20220821 (https://download.01.org/0day-ci/archive/20220822/202208220317.cROZCTcB-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 01ffe31cbb54bfd8e38e71b3cf804a1d67ebf9c1)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install riscv cross compiling tool for clang build
        # apt-get install binutils-riscv64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/9c523bc00c11d0e9499bf6e3d3c5cc2fcf3fff8f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Igor-Kononenko/aspeed-lpc-Fix-lpc-snoop-probe-exception/20220822-000836
        git checkout 9c523bc00c11d0e9499bf6e3d3c5cc2fcf3fff8f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=riscv SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/char/ipmi/kcs_bmc_aspeed.c:10:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
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
   In file included from drivers/char/ipmi/kcs_bmc_aspeed.c:10:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
   In file included from include/linux/io.h:13:
   In file included from arch/riscv/include/asm/io.h:136:
   include/asm-generic/io.h:490:61: warning: performing pointer arithmetic on a null pointer has undefined behavior [-Wnull-pointer-arithmetic]
           val = __le32_to_cpu((__le32 __force)__raw_readl(PCI_IOBASE + addr));
                                                           ~~~~~~~~~~ ^
   include/uapi/linux/byteorder/little_endian.h:35:51: note: expanded from macro '__le32_to_cpu'
   #define __le32_to_cpu(x) ((__force __u32)(__le32)(x))
                                                     ^
   In file included from drivers/char/ipmi/kcs_bmc_aspeed.c:10:
   In file included from include/linux/interrupt.h:11:
   In file included from include/linux/hardirq.h:11:
   In file included from ./arch/riscv/include/generated/asm/hardirq.h:1:
   In file included from include/asm-generic/hardirq.h:17:
   In file included from include/linux/irq.h:20:
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
>> drivers/char/ipmi/kcs_bmc_aspeed.c:643:29: error: incompatible pointer types passing 'struct kcs_bmc *' to parameter of type 'struct kcs_bmc_device *' [-Werror,-Wincompatible-pointer-types]
           aspeed_kcs_irq_mask_update(kcs_bmc, (KCS_BMC_EVENT_TYPE_IBF), 0);
                                      ^~~~~~~
   drivers/char/ipmi/kcs_bmc_aspeed.c:399:63: note: passing argument to parameter 'kcs_bmc' here
   static void aspeed_kcs_irq_mask_update(struct kcs_bmc_device *kcs_bmc, u8 mask, u8 state)
                                                                 ^
   7 warnings and 1 error generated.


vim +643 drivers/char/ipmi/kcs_bmc_aspeed.c

   638	
   639	static void aspeed_kcs_shutdown(struct platform_device *pdev)
   640	{
   641		struct kcs_bmc *kcs_bmc = dev_get_drvdata(&pdev->dev);
   642	
 > 643		aspeed_kcs_irq_mask_update(kcs_bmc, (KCS_BMC_EVENT_TYPE_IBF), 0);
   644	}
   645	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
