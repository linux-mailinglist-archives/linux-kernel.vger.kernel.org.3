Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D8354C228E
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiBXDop (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:44:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiBXDod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:44:33 -0500
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BADCA25A315;
        Wed, 23 Feb 2022 19:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645674244; x=1677210244;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sMfUs3/I8Kqm7yacgV7IQwHgTnaZ9y/L/q5GdicckSI=;
  b=SPcEecwyxx2bWw7R8wTifyxO5gi+aSC6nskHqEpeE6VXxESeFTQXp1NN
   OeH4JEbhgUkYvECSL3IcznTO8tK0/l15r6nukjqZs+KPw9IVpz3Al1ZAa
   yswAu1QpkeubIZv9oq5yid5VAOrDbIx/KCp+2elqUIoNs8p/vUYawzlmU
   fulHqyjViYq5VGisXxbqmWfhFKptR/iFZM5tNsEnoeV4lL9E4lPv8TO0x
   QMrPrLhmG1i8Qsb3wMHCaR5FoNF8v2yss6hisazFOBQw8lTSM0wencXyA
   QeN8S7061ZFhQT0G1bJzTeRe/7zwAxDNk7EHPJIWAnefaO5jhonrklpZT
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="232763750"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="232763750"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:44:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="784617111"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 23 Feb 2022 19:44:01 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN52u-0002CV-M3; Thu, 24 Feb 2022 03:44:00 +0000
Date:   Thu, 24 Feb 2022 11:43:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com
Cc:     kbuild-all@lists.01.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 4/5] clk: imx: support fracn gppll
Message-ID: <202202241105.0bwJWaUv-lkp@intel.com>
References: <20220223064358.4097307-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223064358.4097307-5-peng.fan@oss.nxp.com>
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

Hi "Peng,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on next-20220217]
[also build test ERROR on v5.17-rc5]
[cannot apply to shawnguo/for-next robh/for-next clk/clk-next v5.17-rc5 v5.17-rc4 v5.17-rc3]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Peng-Fan-OSS/imx-add-i-MX93-clk-bindings-and-driver/20220223-144300
base:    3c30cf91b5ecc7272b3d2942ae0505dd8320b81c
config: nds32-randconfig-r026-20220223 (https://download.01.org/0day-ci/archive/20220224/202202241105.0bwJWaUv-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/93f29e11de75409d56c65d32c1bdafb50c9f6f51
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/imx-add-i-MX93-clk-bindings-and-driver/20220223-144300
        git checkout 93f29e11de75409d56c65d32c1bdafb50c9f6f51
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: drivers/clk/imx/clk-fracn-gppll.o: in function `clk_fracn_gppll_recalc_rate':
>> clk-fracn-gppll.c:(.text+0x228): undefined reference to `__udivdi3'
   nds32le-linux-ld: clk-fracn-gppll.c:(.text+0x22c): undefined reference to `__udivdi3'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
