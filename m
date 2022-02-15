Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E60FE4B6E69
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 15:09:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238550AbiBOOJG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 09:09:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232295AbiBOOJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 09:09:05 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB4E74635;
        Tue, 15 Feb 2022 06:08:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1644934135; x=1676470135;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=R65To4o9TE9cJawliYC3L2IrA50D6L/J7joHVO9YWBU=;
  b=mdMYtWt9WI6lRPDNz2ouj43JXzlkA5rmikTqjjM4PvZiZnCAGOm2mBp+
   ur4xOp4AJU3YH6JmVSh9683F/Scm/JkIcMPK2Ug1TGcSd4Svhbh6ismSA
   ObxgYaLp4haJJP5iGZClcEzI57MBSNNnPQgzM93n4rNg4Zn2SP4ZDs78p
   0+POyLcixwa11MdYyJByq6Srt+U7TcLjNONXmRdyQ8X6SRFX7LZc7Zv4U
   bMWWPklOf1wIyJ9U5cBoEj7NJe1znxIk4X4jDbHrEUWVvqtid4VfhIAsH
   tUZBS9wDonWGQdv8cok0t17PBv+JwbcFwSglQCSz5cYeMFFbAWUFy182g
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10258"; a="311095043"
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="311095043"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Feb 2022 06:08:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,371,1635231600"; 
   d="scan'208";a="502461353"
Received: from lkp-server01.sh.intel.com (HELO d95dc2dabeb1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 15 Feb 2022 06:08:51 -0800
Received: from kbuild by d95dc2dabeb1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nJyVe-0009jS-Tk; Tue, 15 Feb 2022 14:08:50 +0000
Date:   Tue, 15 Feb 2022 22:07:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com
Cc:     kbuild-all@lists.01.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 3/4] clk: imx: support fracn gppll
Message-ID: <202202152209.JA3vtPGE-lkp@intel.com>
References: <20220215081835.790311-4-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215081835.790311-4-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test ERROR on shawnguo/for-next]
[also build test ERROR on robh/for-next clk/clk-next v5.17-rc4 next-20220215]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Peng-Fan-OSS/imx-add-i-MX93-clk-bindings-and-driver/20220215-162047
base:   https://git.kernel.org/pub/scm/linux/kernel/git/shawnguo/linux.git for-next
config: nds32-randconfig-r001-20220214 (https://download.01.org/0day-ci/archive/20220215/202202152209.JA3vtPGE-lkp@intel.com/config)
compiler: nds32le-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/37b42f1a06ef92797e800461d1f46e849fa63c91
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/imx-add-i-MX93-clk-bindings-and-driver/20220215-162047
        git checkout 37b42f1a06ef92797e800461d1f46e849fa63c91
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=nds32 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   nds32le-linux-ld: drivers/clk/imx/clk-fracn-gppll.o: in function `clk_fracn_gppll_recalc_rate':
   clk-fracn-gppll.c:(.text+0x434): undefined reference to `__udivdi3'
>> nds32le-linux-ld: clk-fracn-gppll.c:(.text+0x438): undefined reference to `__udivdi3'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
