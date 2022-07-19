Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01B2657A9EF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 00:41:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236222AbiGSWln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 18:41:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbiGSWlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 18:41:42 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B5F5F76
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 15:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658270501; x=1689806501;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7N1iYcEDM/OdyYxj8fxUgd4WfHVXHkgo3W/YAmVkyYI=;
  b=T+EEEa9w/ZBSeXnAAhF8FNtS5de0XwOoHh5uQBwfXs7YEdEtuMXYxAWS
   uCCX+BYtJn8cWazaR++lKyqDRLZAh7ym/DJHzA51PMiJJATuOeLBQZDmF
   Mi0U9FWOQyUJdSiXm5x1dlVg86oF5GYxAHi0TzSDoikhKy4iwUm5ITLKM
   vQ+Gba2kDXmLXU+zFXy7Mrz7pCPCpCFc2zJAUW/CRZqRzSTI90hqsApuQ
   rFUOK60d+vrGy/jCdwCy+7okMoMz5jy48l1rljPgjKyQQzCmtij1FpQq6
   maTGFofE3KOsKxZ3YAgv8GGmpCY+NEerznAWNYDmuTsMnJ8dFRDq9sYBB
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10413"; a="312316818"
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="312316818"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jul 2022 15:41:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,285,1650956400"; 
   d="scan'208";a="740058933"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 19 Jul 2022 15:41:37 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDvuK-0006BO-Hs;
        Tue, 19 Jul 2022 22:41:36 +0000
Date:   Wed, 20 Jul 2022 06:40:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Jianmin Lv <lvjianmin@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        loongarch@lists.linux.dev, Hanjun Guo <guohanjun@huawei.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhuacai@loongson.cn>
Subject: Re: [PATCH V16 14/14] irqchip / ACPI: Introduce ACPI_IRQ_MODEL_LPIC
 for LoongArch
Message-ID: <202207200630.T1WXKo7g-lkp@intel.com>
References: <1658153621-40445-15-git-send-email-lvjianmin@loongson.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1658153621-40445-15-git-send-email-lvjianmin@loongson.cn>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jianmin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on rafael-pm/linux-next]
[also build test ERROR on linus/master v5.19-rc7 next-20220719]
[cannot apply to tip/irq/core]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Jianmin-Lv/irqchip-Add-LoongArch-related-irqchip-drivers/20220718-222340
base:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git linux-next
config: loongarch-randconfig-c003-20220718 (https://download.01.org/0day-ci/archive/20220720/202207200630.T1WXKo7g-lkp@intel.com/config)
compiler: loongarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/f8e9b95288022d4cbe61fbd94cffee6821fbfb7d
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Jianmin-Lv/irqchip-Add-LoongArch-related-irqchip-drivers/20220718-222340
        git checkout f8e9b95288022d4cbe61fbd94cffee6821fbfb7d
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=loongarch SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   loongarch64-linux-ld: drivers/irqchip/irq-loongarch-cpu.o: in function `lpic_get_gsi_domain_id':
>> irq-loongarch-cpu.c:(.text+0x10): undefined reference to `pch_lpc_handle'
>> loongarch64-linux-ld: irq-loongarch-cpu.c:(.text+0x14): undefined reference to `pch_lpc_handle'
>> loongarch64-linux-ld: irq-loongarch-cpu.c:(.text+0x14): undefined reference to `pch_lpc_handle'
>> loongarch64-linux-ld: irq-loongarch-cpu.c:(.text+0x68): undefined reference to `liointc_handle'
   loongarch64-linux-ld: irq-loongarch-cpu.c:(.text+0x6c): undefined reference to `liointc_handle'
   loongarch64-linux-ld: irq-loongarch-cpu.c:(.text+0x6c): undefined reference to `liointc_handle'
   loongarch64-linux-ld: drivers/irqchip/irq-loongarch-cpu.o: in function `eiointc_parse_madt':
   irq-loongarch-cpu.c:(.init.text+0x10): undefined reference to `eiointc_acpi_init'
   loongarch64-linux-ld: drivers/irqchip/irq-loongarch-cpu.o: in function `liointc_parse_madt':
   irq-loongarch-cpu.c:(.init.text+0x24): undefined reference to `liointc_acpi_init'
   loongarch64-linux-ld: drivers/irqchip/irq-loongson-pch-pic.o: in function `lpcintc_parse_madt':
   irq-loongson-pch-pic.c:(.init.text+0x14): undefined reference to `pch_lpc_acpi_init'
   loongarch64-linux-ld: drivers/video/fbdev/efifb.o: in function `depth_show':
   efifb.c:(.text+0x48): undefined reference to `screen_info'
   loongarch64-linux-ld: efifb.c:(.text+0x4c): undefined reference to `screen_info'
   loongarch64-linux-ld: efifb.c:(.text+0x4c): undefined reference to `screen_info'
   loongarch64-linux-ld: drivers/video/fbdev/efifb.o: in function `height_show':
   efifb.c:(.text+0x94): undefined reference to `screen_info'
   loongarch64-linux-ld: efifb.c:(.text+0x98): undefined reference to `screen_info'
   loongarch64-linux-ld: drivers/video/fbdev/efifb.o:efifb.c:(.text+0x98): more undefined references to `screen_info' follow

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
