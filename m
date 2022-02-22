Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACFED4C056B
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 00:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236287AbiBVXmi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 18:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236281AbiBVXmg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 18:42:36 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 137C412AC7
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 15:42:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645573330; x=1677109330;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=3J2LlEH3gLgudvMI4rgF7YkdvjBcrWqNtzwkrH+ImtA=;
  b=VubKB7TgOkD5dukIY8KNxmaLvo7Q1yPhXU4nHpnVnefY2Ks44QAaVHh/
   BbZL/azB816ohIgJnsEAmA7dH/zIFS2s4CwVg05H5+eQzxuau/bcgy5OG
   i3dypbS5a5cqk0PNZ4ynAbEnd1McJrc/eusgJwuSfYj3kFslPPFbJ7V5z
   2kMuvLbhPkl8QcFELQVsayzKMqYeHtMFUUmYiaytantXBsH6V5RaA3UtJ
   4eybNDJZwyP2+nCP7CpY++KRWuTzIRUsohP1T9fYNBhMJy9joAfRgTiq9
   wwQI2NWChdHLUM4kYs/UY5ppKJXe9xT/NtSS9yJR2te2Eh8kN/bu2W3i4
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="252027573"
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="252027573"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2022 15:42:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,389,1635231600"; 
   d="scan'208";a="779905425"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 22 Feb 2022 15:42:07 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMenH-0000kN-39; Tue, 22 Feb 2022 23:42:07 +0000
Date:   Wed, 23 Feb 2022 07:41:22 +0800
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
Subject: Re: [PATCH 2/4] ARM: at91: pm: move "atmel.pm_modes" parsing into a
 common file
Message-ID: <202202230722.7V2NTBn5-lkp@intel.com>
References: <20220222150846.255307-3-clement.leger@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220222150846.255307-3-clement.leger@bootlin.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Clément,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on soc/for-next]
[also build test WARNING on arm/for-next abelloni/rtc-next linus/master v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Cl-ment-L-ger/ARM-at91-add-support-for-secure-suspend-on-sama5d2/20220222-231305
base:   https://git.kernel.org/pub/scm/linux/kernel/git/soc/soc.git for-next
config: arm-multi_v4t_defconfig (https://download.01.org/0day-ci/archive/20220223/202202230722.7V2NTBn5-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/2f5afeeacfd5e7985d4ef768c9a3f2b430fe3fa3
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Cl-ment-L-ger/ARM-at91-add-support-for-secure-suspend-on-sama5d2/20220222-231305
        git checkout 2f5afeeacfd5e7985d4ef768c9a3f2b430fe3fa3
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> WARNING: modpost: vmlinux.o(.text+0xb79c): Section mismatch in reference from the function at91_pm_common_modes_select() to the (unknown reference) .init.rodata:(unknown)
The function at91_pm_common_modes_select() references
the (unknown reference) __initconst (unknown).
This is often because at91_pm_common_modes_select lacks a __initconst
annotation or the annotation of (unknown) is wrong.

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
