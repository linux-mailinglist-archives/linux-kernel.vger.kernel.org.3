Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 112F4526E9F
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 09:14:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230493AbiENC5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 22:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiENC4r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 22:56:47 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1803532279F
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 18:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652493156; x=1684029156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RcLuLGGwbVePLOb+KFTMTX4VKymqOx1Gc+kdRlxjhqc=;
  b=ibr4KcLPUuv82AVGOvb0vnR8LFD4ds4bU2SwAc77DCcMfniND4ayhbqI
   a9w0J6qDy8wYenJiYbn4xNM6JZ/8v+3OC6T98a2jie2aWDQHJcmmnQNJO
   /BN5Z7Rf+mTd20sRmONla2eMSPYTROVTAFz86Um9/GJQEj0IPKKT8Cb9M
   lFNVqdGhQgW2agRIOld7qe+i67s6mm7Q+8yHb4bKinToSnlDstDHKlTjf
   7Kzk+4bf9nNxx12wa8qA0rK9YRpSzjDOoZSREjYaZoTZ86gzIRQbvgDhx
   td4kUCj8iy0kqSkqCq1/Ivt8xEAtK3ebLiMOcZ/tYva53UX/bc+UoicTb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10346"; a="250977865"
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="250977865"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2022 18:52:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,223,1647327600"; 
   d="scan'208";a="712631468"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 13 May 2022 18:52:30 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1npgxJ-000MIi-SJ;
        Sat, 14 May 2022 01:52:29 +0000
Date:   Sat, 14 May 2022 09:51:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-mtd@lists.infradead.org
Cc:     kbuild-all@lists.01.org, Liang Yang <liang.yang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/4] mtd: rawnand: meson: fix the clock
Message-ID: <202205140935.9YRSlRhB-lkp@intel.com>
References: <20220513123404.48513-3-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513123404.48513-3-liang.yang@amlogic.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liang,

I love your patch! Yet something to improve:

[auto build test ERROR on mtd/mtd/next]
[also build test ERROR on mtd/mtd/fixes mtd/nand/next v5.18-rc6 next-20220513]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Liang-Yang/fix-the-meson-NFC-clock/20220513-203700
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
config: m68k-buildonly-randconfig-r001-20220512 (https://download.01.org/0day-ci/archive/20220514/202205140935.9YRSlRhB-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/2a8371d672486fa71241af04615efeff5efed94b
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Liang-Yang/fix-the-meson-NFC-clock/20220513-203700
        git checkout 2a8371d672486fa71241af04615efeff5efed94b
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=m68k SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   m68k-linux-ld: drivers/mtd/nand/raw/meson_nand.o: in function `meson_nfc_probe':
>> meson_nand.c:(.text+0xcf8): undefined reference to `clk_divider_ops'
>> m68k-linux-ld: meson_nand.c:(.text+0xd38): undefined reference to `devm_clk_register'

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
