Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB9FE4C2026
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 00:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244982AbiBWXo0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 18:44:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234743AbiBWXoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 18:44:25 -0500
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42E546178;
        Wed, 23 Feb 2022 15:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645659836; x=1677195836;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WbgvSw8pNkgMa5w8BxkuxdJqDj+0ilOkj3tUNUJuZbE=;
  b=FpHv5riwIVdB55ZmG3P+AmilqId7gE7ic5XYod51eAexij5tH5us2YLv
   9ByIV2bSyHdJk2AD2pTFb4ySd9+QVEX/50FH1VM+PUvy9ElkFvAt4VPHV
   YFV5f3xthOHmkYLw29JMds2Af7RUloXnEDETnMGKivBdoVtRqJmy/eJhs
   j1vVIELQkFPEMTmsyCdyORd0jXHW6sKbVXTMs5/vngL9DRvrrKQ0sSK5m
   m8WtOb9Gkw8NcF0V523qUZpkiZbX7y9nIcMP1VL86Zy3T5lXZpwot6IvC
   T5vaRz+e7bMJKU6hPlnEgqkNLdr08fmTkEOB9CLz0LXY0fuOmzX0aJIjb
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10267"; a="251844286"
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="251844286"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 15:43:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,392,1635231600"; 
   d="scan'208";a="591891255"
Received: from lkp-server01.sh.intel.com (HELO 788b1cd46f0d) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Feb 2022 15:43:52 -0800
Received: from kbuild by 788b1cd46f0d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nN1IV-0001xt-S9; Wed, 23 Feb 2022 23:43:51 +0000
Date:   Thu, 24 Feb 2022 07:43:21 +0800
From:   kernel test robot <lkp@intel.com>
To:     Shawn Guo <shawn.guo@linaro.org>, Marc Zyngier <maz@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     kbuild-all@lists.01.org,
        Valentin Schneider <valentin.schneider@arm.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Maulik Shah <quic_mkshah@quicinc.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawn.guo@linaro.org>
Subject: Re: [PATCH v6 3/3] irqchip: Add Qualcomm MPM controller driver
Message-ID: <202202240730.8ES2LbM6-lkp@intel.com>
References: <20220223125536.230224-4-shawn.guo@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220223125536.230224-4-shawn.guo@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Shawn,

I love your patch! Perhaps something to improve:

[auto build test WARNING on tip/irq/core]
[also build test WARNING on robh/for-next linus/master v5.17-rc5 next-20220222]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Shawn-Guo/Add-Qualcomm-MPM-irqchip-driver-support/20220223-210123
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git d2206fcabdfaff3958ab67cc5b8f63257e57b889
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220224/202202240730.8ES2LbM6-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/17f8a23f57bf6d0177f6ef6f78237b37bd853e8d
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Shawn-Guo/Add-Qualcomm-MPM-irqchip-driver-support/20220223-210123
        git checkout 17f8a23f57bf6d0177f6ef6f78237b37bd853e8d
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/irqchip/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/irqchip/qcom-mpm.c:210:21: warning: no previous prototype for 'get_mpm_gic_map' [-Wmissing-prototypes]
     210 | struct mpm_gic_map *get_mpm_gic_map(struct qcom_mpm_priv *priv, int pin)
         |                     ^~~~~~~~~~~~~~~


vim +/get_mpm_gic_map +210 drivers/irqchip/qcom-mpm.c

   209	
 > 210	struct mpm_gic_map *get_mpm_gic_map(struct qcom_mpm_priv *priv, int pin)
   211	{
   212		struct mpm_gic_map *maps = priv->maps;
   213		int i;
   214	
   215		for (i = 0; i < priv->map_cnt; i++) {
   216			if (maps[i].pin == pin)
   217				return &maps[i];
   218		}
   219	
   220		return NULL;
   221	}
   222	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
