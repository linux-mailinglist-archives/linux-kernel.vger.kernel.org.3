Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB964C0EF7
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 10:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239238AbiBWJQ6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 04:16:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235732AbiBWJQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 04:16:56 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFCB683010
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 01:16:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645607786; x=1677143786;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=6sTo4gXFz5bm9XNXNCHZncq9os9vZ2vETv0KtfsJTCA=;
  b=ONIi9IWVicJ9Wbvi6cXFY9eDhw7ikgAUHq3llTWI5MCa/YlDivW3y5do
   zvFaYsQCM2kwLI4HqWKWdbrPQkjN+raEteCDaSaj4iXNuTmlY2ydsPJR6
   fOETGEKojwn0Y1XxE/28XsSKg6sLMAd5XvwFc8lKS1xqPmIs4RSNH7ClC
   RvKrnhVDe/Dx1szhzqksZ/7htZWZWggO3Lc35KhdHkVkn50PcyoYIhuAB
   An24LapJPBAyT+FCfyIEgyTX3e9SZAF5f61ANSsl19pGiCrw0iIBNnvoP
   I9MNsL9uqCVZPPCU/M4qvRQx7vfgUTMYjkVP6WbTg8V+qIg6Vfx9TNxHc
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="315148960"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="315148960"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 01:16:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="573749179"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Feb 2022 01:16:24 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMnl1-0001D3-ES; Wed, 23 Feb 2022 09:16:23 +0000
Date:   Wed, 23 Feb 2022 17:15:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>,
        Russell King <linux@armlinux.org.uk>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Ludovic Desroches <ludovic.desroches@microchip.com>
Cc:     kbuild-all@lists.01.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        =?iso-8859-1?Q?Cl=E9ment_L=E9ger?= <clement.leger@bootlin.com>
Subject: Re: [PATCH 3/4] ARM: at91: pm: add support for sama5d2 secure suspend
Message-ID: <202202231708.CAFCHZIn-lkp@intel.com>
References: <20220222150846.255307-4-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222150846.255307-4-clement.leger@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Clément,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on soc/for-next]
[also build test ERROR on abelloni/rtc-next linus/master v5.17-rc5 next-20220222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cl-ment-L-ger/ARM-at91-add-support-for-secure-suspend-on-sama5d2/20220222-231305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220223/202202231708.CAFCHZIn-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/e7f524a6f3693c0e84b0258766c98a24046c9ba1
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cl-ment-L-ger/ARM-at91-add-support-for-secure-suspend-on-sama5d2/20220222-231305
        git checkout e7f524a6f3693c0e84b0258766c98a24046c9ba1
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arch/arm/mach-at91/pm_secure.o: in function `sama5_pm_init':
>> (.init.text+0x10c): multiple definition of `sama5_pm_init'; arch/arm/mach-at91/pm.o:(.init.text+0x1b58): first defined here
   arm-linux-gnueabi-ld: arch/arm/mach-at91/pm_secure.o: in function `sama5d2_pm_init':
>> (.init.text+0x160): multiple definition of `sama5d2_pm_init'; arch/arm/mach-at91/pm.o:(.init.text+0x1c0c): first defined here
   arm-linux-gnueabi-ld: arch/arm/mach-at91/pm_secure.o: in function `at91_suspend_entering_slow_clock':
>> (.text+0x0): multiple definition of `at91_suspend_entering_slow_clock'; arch/arm/mach-at91/pm.o:(.text+0x80): first defined here

Kconfig warnings: (for reference only)
   WARNING: unmet direct dependencies detected for ATMEL_PM
   Depends on ARCH_AT91 && !ATMEL_SECURE_PM
   Selected by
   - SOC_SAMA7 && ARCH_AT91 && PM

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
