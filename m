Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BFDB4FDA71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 12:50:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377172AbiDLJco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 05:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387608AbiDLJI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 05:08:26 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E98A4237E7
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 01:17:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1649751471; x=1681287471;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KttORuuzKa1gAej3+50sABpd4LK7JoBRCSwgJ4ZP7EM=;
  b=Ju0R3tzzXOd51XPgcij40c8y74WHvHxAZe/NnBOAckqaSwzMmBDDOmo4
   0vLB5Q8G9AfdyTpLn6S9BCzPlYk34JiCY813Ze96RVo7Dq1I5v6goBH/x
   oWr0YbePUATd4LdHqhz+hikN7EmMYXsixCdqydphCOcWYtbZRfhqa277f
   4YQEPDGJUROPLOqwVkOcC92pBF8nSyWbn1xTdxC96t94u2wz6NY4N2xZa
   w7r3qHo14BEvWJz8aeg9QcuMkYaUYyYTKK75TXWUqWrUm0YibOR/A3a2J
   ZdMuY8PlYpQYjVy2B53OBpZ9dfDS4uVFnVemGWFTG4CsEpVDqMklHUqbz
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10314"; a="242254361"
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="242254361"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Apr 2022 01:17:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,253,1643702400"; 
   d="scan'208";a="572653613"
Received: from lkp-server02.sh.intel.com (HELO d3fc50ef50de) ([10.239.97.151])
  by orsmga008.jf.intel.com with ESMTP; 12 Apr 2022 01:17:48 -0700
Received: from kbuild by d3fc50ef50de with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1neBid-0002f5-KO;
        Tue, 12 Apr 2022 08:17:47 +0000
Date:   Tue, 12 Apr 2022 16:17:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Chen-Yu Tsai <wens@kernel.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        YueHaibing <yuehaibing@huawei.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        dri-devel@lists.freedesktop.org, Mark Brown <broonie@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 5/5] drm/solomon: Add SSD130x OLED displays SPI support
Message-ID: <202204121654.38UTab7Q-lkp@intel.com>
References: <20220411211243.11121-6-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220411211243.11121-6-javierm@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

I love your patch! Perhaps something to improve:

[auto build test WARNING on drm-tip/drm-tip]
[also build test WARNING on next-20220412]
[cannot apply to drm/drm-next drm-exynos/exynos-drm-next drm-intel/for-linux-next tegra-drm/drm/tegra/for-next linus/master linux/master airlied/drm-next v5.18-rc2]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Javier-Martinez-Canillas/drm-solomon-Add-SSD130x-OLED-displays-SPI-support/20220412-051518
base:   git://anongit.freedesktop.org/drm/drm-tip drm-tip
config: hexagon-allyesconfig (https://download.01.org/0day-ci/archive/20220412/202204121654.38UTab7Q-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project fe2478d44e4f7f191c43fef629ac7a23d0251e72)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/46bbef7fc1afeb9bc8241fe7636e77b5096e3d22
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Javier-Martinez-Canillas/drm-solomon-Add-SSD130x-OLED-displays-SPI-support/20220412-051518
        git checkout 46bbef7fc1afeb9bc8241fe7636e77b5096e3d22
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/gpu/drm/solomon/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/solomon/ssd130x-spi.c:161:35: warning: unused variable 'ssd130x_spi_table' [-Wunused-const-variable]
   static const struct spi_device_id ssd130x_spi_table[] = {
                                     ^
   1 warning generated.


vim +/ssd130x_spi_table +161 drivers/gpu/drm/solomon/ssd130x-spi.c

   152	
   153	/*
   154	 * The SPI core always reports a MODALIAS uevent of the form "spi:<dev>", even
   155	 * if the device was registered via OF. This means that the module will not be
   156	 * auto loaded, unless it contains an alias that matches the MODALIAS reported.
   157	 *
   158	 * To workaround this issue, add a SPI device ID table. Even when this should
   159	 * not be needed for this driver to match the registered SPI devices.
   160	 */
 > 161	static const struct spi_device_id ssd130x_spi_table[] = {
   162		{ "sh1106",  SH1106_ID },
   163		{ "ssd1305", SSD1305_ID },
   164		{ "ssd1306", SSD1306_ID },
   165		{ "ssd1307", SSD1307_ID },
   166		{ "ssd1309", SSD1309_ID },
   167		{ /* sentinel */ }
   168	};
   169	MODULE_DEVICE_TABLE(spi, ssd130x_spi_table);
   170	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
