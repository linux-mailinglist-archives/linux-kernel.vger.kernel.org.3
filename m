Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7299A56B2BF
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 08:25:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237297AbiGHGVg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 02:21:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236958AbiGHGVc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 02:21:32 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878F72409B;
        Thu,  7 Jul 2022 23:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657261291; x=1688797291;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2+Q11omODNcL1YvdnrPZrcbEdnlk0V7G8eOhRvnexJo=;
  b=TE9z43hO/StC9J4a3Qgr/hBy4slCQKZVDJl8mhmdlAvmepFEKUK9TrK2
   DiQOl1ds1wqqEUpHy/xcW1QWf2Os6QDHWW/g7IlDiTSH5wnaaZEoco/HN
   Ie1Wh07INmHB+bp6/+QzFpu7by/XyLWgxtD6XI+XDHysw4dQx13LEe26w
   IsGOfrK/YTvlaCjsVaBkBnaJNoshDpQvZqfA37HVSZteuTV9HxcZcFHK6
   2u/RMox6XJOjitAuP4VhprHFniKnKmE7D2iygSHw3wI1tlaaqMlYRh91m
   Bxa9EgxTHeev2KMvsPg7nEvTcWY8x6enbukzuq0Byy0/MwOwhP44tt83g
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10401"; a="284943716"
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="284943716"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jul 2022 23:21:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,254,1650956400"; 
   d="scan'208";a="621092749"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 07 Jul 2022 23:21:28 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o9hMm-000N1K-2x;
        Fri, 08 Jul 2022 06:21:28 +0000
Date:   Fri, 8 Jul 2022 14:21:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Horatiu Vultur <horatiu.vultur@microchip.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linus.walleij@linaro.org,
        kavyasree.kotagiri@microchip.com, alexandre.belloni@bootlin.com,
        colin.foster@in-advantage.com, UNGLinuxDriver@microchip.com,
        maxime.chevallier@bootlin.com,
        Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: Re: [PATCH 2/2] pinctrl: ocelot: Fix pincfg
Message-ID: <202207081432.wshyILwP-lkp@intel.com>
References: <20220707185342.2697569-3-horatiu.vultur@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220707185342.2697569-3-horatiu.vultur@microchip.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Horatiu,

I love your patch! Perhaps something to improve:

[auto build test WARNING on linusw-pinctrl/devel]
[also build test WARNING on linus/master v5.19-rc5 next-20220707]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Horatiu-Vultur/pinctrl-ocelot-Add-fixes-for-ocelot-driver/20220708-025029
base:   https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git devel
config: i386-randconfig-m021 (https://download.01.org/0day-ci/archive/20220708/202207081432.wshyILwP-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

smatch warnings:
drivers/pinctrl/pinctrl-ocelot.c:1954 ocelot_pinctrl_create_pincfg() warn: inconsistent indenting

vim +1954 drivers/pinctrl/pinctrl-ocelot.c

ce8dc0943357a5 Alexandre Belloni 2018-01-06  1949  
076d9e71bcf8a8 Colin Foster      2021-11-19  1950  static struct regmap *ocelot_pinctrl_create_pincfg(struct platform_device *pdev)
076d9e71bcf8a8 Colin Foster      2021-11-19  1951  {
076d9e71bcf8a8 Colin Foster      2021-11-19  1952  	void __iomem *base;
076d9e71bcf8a8 Colin Foster      2021-11-19  1953  
94ef32970d4076 Michael Walle     2022-02-16 @1954  		base = devm_platform_ioremap_resource(pdev, 1);
076d9e71bcf8a8 Colin Foster      2021-11-19  1955  	if (IS_ERR(base)) {
076d9e71bcf8a8 Colin Foster      2021-11-19  1956  		dev_dbg(&pdev->dev, "Failed to ioremap config registers (no extended pinconf)\n");
076d9e71bcf8a8 Colin Foster      2021-11-19  1957  		return NULL;
076d9e71bcf8a8 Colin Foster      2021-11-19  1958  	}
076d9e71bcf8a8 Colin Foster      2021-11-19  1959  
162d70439a9da8 Horatiu Vultur    2022-07-07  1960  	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_pincfg);
076d9e71bcf8a8 Colin Foster      2021-11-19  1961  }
076d9e71bcf8a8 Colin Foster      2021-11-19  1962  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
