Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F5674C221C
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 04:23:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiBXDWq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 22:22:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbiBXDWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 22:22:41 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32E4131109;
        Wed, 23 Feb 2022 19:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645672932; x=1677208932;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WlMH20BbeUQvje6PHp4Qe/KuOHIfezvWeiEno+JCcOA=;
  b=gHRcnZbEDkAmVBn6alEAMffakOvv9xPuqGY2VEagjX6Um6kItIIBXFNa
   SScMdB5zp1Zh3uKms7mepwxKSRaIPyfvBNBzaNIJUvxix3VkPE4fjJpdF
   mJvsnjUpKdc3k+ndcht9Z+vfvbGzz/q+bfLYs/7N7MNSXU3ys2g08upzr
   keLxhMV/4CtHOLXdMhJqmmsIPPnN1D39EsNE6Qd0Psy2jwAfbqVoQD89t
   jndDSGB7tSihk1Qb+40Bw2By7f4X2iKHDoZPY/G0fB32OmYos//78ytai
   BbawdjcPj0qnear0Vy4gvGGZtxhh81681/7nhwqbejhPrVdHM+O0QhpPs
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="249720354"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="249720354"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 19:22:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="707296351"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 23 Feb 2022 19:22:01 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN4hc-0002Ah-56; Thu, 24 Feb 2022 03:22:00 +0000
Date:   Thu, 24 Feb 2022 11:21:23 +0800
From:   kernel test robot <lkp@intel.com>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, sboyd@kernel.org,
        robh+dt@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        abel.vesa@nxp.com
Cc:     kbuild-all@lists.01.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH V3 4/5] clk: imx: support fracn gppll
Message-ID: <202202241151.VkSKqcfA-lkp@intel.com>
References: <20220223064358.4097307-5-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223064358.4097307-5-peng.fan@oss.nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
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
config: microblaze-randconfig-r003-20220223 (https://download.01.org/0day-ci/archive/20220224/202202241151.VkSKqcfA-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/93f29e11de75409d56c65d32c1bdafb50c9f6f51
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Peng-Fan-OSS/imx-add-i-MX93-clk-bindings-and-driver/20220223-144300
        git checkout 93f29e11de75409d56c65d32c1bdafb50c9f6f51
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=microblaze SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   microblaze-linux-ld: drivers/clk/imx/clk-fracn-gppll.o: in function `clk_fracn_gppll_recalc_rate':
>> (.text+0x420): undefined reference to `__udivdi3'

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
