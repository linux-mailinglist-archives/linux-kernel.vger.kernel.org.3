Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1A953045C
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235953AbiEVQEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 12:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiEVQEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 12:04:33 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2E9167EA;
        Sun, 22 May 2022 09:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653235471; x=1684771471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sM/fEM1Cz4Fu5jERVYNMoQaN0mOPoZxzUJZYlTqChOc=;
  b=Bzn3zo8cq89Y7WaVkBpMPrRxHFKuMBWE4eN30wg16Cfq0mIMl8YAjWli
   4HayimuEsueQRolejo0+zj45R/1TgyvT133rVHuLUge8rPxooqwsdFt2Q
   6hqQVrHdFiL67OQY7bAH555PzIHTZmxZsN3aAT5EBBNRz0IrxDwqIjSC5
   lPe/v3RyHNDPikoXflUNfBtqr1+pvjkcQn1MCx5xurO1F8FTv096A5Ldm
   mdqxoMf0Uv19lcuyjpwNNIL0fRhQIkxQtL7+g6WRO0eSgYRHaFuoUR9F1
   RRCWmESoQE2BH2v8JxFh/6EINVUT9ETCgV49c6ndGTu73si4cmg5ufSJQ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10355"; a="359412477"
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="359412477"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 May 2022 09:04:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,244,1647327600"; 
   d="scan'208";a="558265341"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 May 2022 09:04:26 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nso49-0000Ru-WA;
        Sun, 22 May 2022 16:04:25 +0000
Date:   Mon, 23 May 2022 00:03:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Chen <lchen.firstlove@zohomail.com>,
        Mark Brown <broonie@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-gpio <linux-gpio@vger.kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        linux-sunxi <linux-sunxi@lists.linux.dev>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     kbuild-all@lists.01.org
Subject: Re: [PATCH 4/4] pinctrl: st: Switch to use regmap_field_test_bits
Message-ID: <202205222359.yQ35dVuB-lkp@intel.com>
References: <180e705f8de.1012cdc8c45890.1645144071309904245@zohomail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <180e705f8de.1012cdc8c45890.1645144071309904245@zohomail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on broonie-regmap/for-next]
[also build test ERROR on linusw-pinctrl/devel broonie-sound/for-next v5.18-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Chen/Add-regmap_field-helpers-for-simple-bit-operations/20220521-224352
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regmap.git for-next
config: arm-allmodconfig (https://download.01.org/0day-ci/archive/20220522/202205222359.yQ35dVuB-lkp@intel.com/config)
compiler: arm-linux-gnueabi-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/73189e14ed111777ac60a95ae3008337c69589da
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Chen/Add-regmap_field-helpers-for-simple-bit-operations/20220521-224352
        git checkout 73189e14ed111777ac60a95ae3008337c69589da
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/pinctrl/pinctrl-st.c: In function 'st_pinconf_get_direction':
>> drivers/pinctrl/pinctrl-st.c:587:53: error: 'od_value' undeclared (first use in this function); did you mean 'si_value'?
     587 |                 if (regmap_field_test_bits(pc->od, &od_value, BIT(pin)))
         |                                                     ^~~~~~~~
         |                                                     si_value
   drivers/pinctrl/pinctrl-st.c:587:53: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/pinctrl/pinctrl-st.c:587:21: error: too many arguments to function 'regmap_field_test_bits'
     587 |                 if (regmap_field_test_bits(pc->od, &od_value, BIT(pin)))
         |                     ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/pinctrl/pinctrl-st.c:18:
   include/linux/regmap.h:1353:5: note: declared here
    1353 | int regmap_field_test_bits(struct regmap_field *field, unsigned int bits);
         |     ^~~~~~~~~~~~~~~~~~~~~~


vim +587 drivers/pinctrl/pinctrl-st.c

   572	
   573	static void st_pinconf_get_direction(struct st_pio_control *pc,
   574		int pin, unsigned long *config)
   575	{
   576		if (pc->oe) {
   577			if (regmap_field_test_bits(pc->oe, BIT(pin)))
   578				ST_PINCONF_PACK_OE(*config);
   579		}
   580	
   581		if (pc->pu) {
   582			if (regmap_field_test_bits(pc->pu, BIT(pin)))
   583				ST_PINCONF_PACK_PU(*config);
   584		}
   585	
   586		if (pc->od) {
 > 587			if (regmap_field_test_bits(pc->od, &od_value, BIT(pin)))
   588				ST_PINCONF_PACK_OD(*config);
   589		}
   590	}
   591	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
