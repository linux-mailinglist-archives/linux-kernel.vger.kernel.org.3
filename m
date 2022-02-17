Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E922B4BAA1A
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 20:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245433AbiBQTre (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 14:47:34 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245399AbiBQTrX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 14:47:23 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C0C26548;
        Thu, 17 Feb 2022 11:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645127228; x=1676663228;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=U4npDy91UVHGnXoEf8fnuC7pAS1YpWNELPCKYb0ijkI=;
  b=L4FREd2thzcvsQ3EqwGT1ev3TWYl51F3JxLCpiItJd4u1Sh9DTtUeDeO
   5IEnpwKhIb17MIT47NOqcKAbPaH1VEhy4Mna1K9D/kQqi1pBRCqhscPRI
   TMmM8fPqLo6cyp+s/kZPaDFjRW0od7bH7NgPjViAMwM+rebqEjItFeMX3
   2UrgDhsGLUtI37uapqg6ziSBSv2bgRHwpNVwv6F40L4cKqKiqgzephjxY
   cwbJaCxRsZFigWLpQtkYG5LGtb8U/GM/0RRoUh51AlQdp/HOVmc279NeQ
   xpBADGNMaQCvIrpBeyysnO5AKUwk0lEe5iYrhqIIgZNrMvgxRbR/25gYu
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="238363452"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="238363452"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 11:47:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="626224966"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 17 Feb 2022 11:47:01 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKmk1-0000Tw-2j; Thu, 17 Feb 2022 19:47:01 +0000
Date:   Fri, 18 Feb 2022 03:46:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sui Jingfeng <15330273260@189.cn>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Roland Scheidegger <sroland@vmware.com>,
        Zack Rusin <zackr@vmware.com>,
        Christian Gmeiner <christian.gmeiner@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Dan Carpenter <error27@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Andrey Zhizhikin <andrey.zhizhikin@leica-geosystems.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        "David S . Miller" <davem@davemloft.net>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Ilia Mirkin <imirkin@alum.mit.edu>,
        Qing Zhang <zhangqing@loongson.cn>,
        suijingfeng <suijingfeng@loongson.cn>
Cc:     kbuild-all@lists.01.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 1/4] drm/lsdc: add drm driver for loongson display
 controller
Message-ID: <202202172203.r8yqYAWT-lkp@intel.com>
References: <20220217105523.1525122-2-15330273260@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220217105523.1525122-2-15330273260@189.cn>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sui,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on drm/drm-next]
[also build test WARNING on robh/for-next v5.17-rc4 next-20220217]
[cannot apply to mripard/sunxi/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Sui-Jingfeng/drm-lsdc-add-drm-driver-for-loongson-display-controller/20220217-185718
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: m68k-randconfig-r034-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172203.r8yqYAWT-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/822d08dcd4408130e10897446cfdd640bcd53c8a
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Sui-Jingfeng/drm-lsdc-add-drm-driver-for-loongson-display-controller/20220217-185718
        git checkout 822d08dcd4408130e10897446cfdd640bcd53c8a
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=m68k SHELL=/bin/bash drivers/gpu/drm/lsdc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/device.h:15,
                    from include/linux/pci.h:37,
                    from drivers/gpu/drm/lsdc/lsdc_drv.c:15:
   drivers/gpu/drm/lsdc/lsdc_drv.c: In function 'lsdc_vram_init':
>> include/drm/drm_print.h:425:39: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 3 has type 'resource_size_t' {aka 'unsigned int'} [-Wformat=]
     425 |         dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
         |                                       ^~~~~~~~
   include/linux/dev_printk.h:110:30: note: in definition of macro 'dev_printk_index_wrap'
     110 |                 _p_func(dev, fmt, ##__VA_ARGS__);                       \
         |                              ^~~
   include/linux/dev_printk.h:150:58: note: in expansion of macro 'dev_fmt'
     150 |         dev_printk_index_wrap(_dev_info, KERN_INFO, dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                                                          ^~~~~~~
   include/drm/drm_print.h:425:9: note: in expansion of macro 'dev_info'
     425 |         dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
         |         ^~~~
   include/drm/drm_print.h:429:9: note: in expansion of macro '__drm_printk'
     429 |         __drm_printk((drm), info,, fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~
   drivers/gpu/drm/lsdc/lsdc_drv.c:518:9: note: in expansion of macro 'drm_info'
     518 |         drm_info(ddev, "vram start: 0x%llx, size: %uMB\n", base, (u32)(size >> 20));
         |         ^~~~~~~~
--
   In file included from drivers/gpu/drm/lsdc/lsdc_drv.h:17,
                    from drivers/gpu/drm/lsdc/lsdc_pll.c:14:
   drivers/gpu/drm/lsdc/lsdc_pll.c: In function 'lsdc_pixpll_setup':
>> drivers/gpu/drm/lsdc/lsdc_pll.c:169:62: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
     169 |                 this->index, this->reg_base, this->reg_size, (u64)this->mmio);
         |                                                              ^
   include/drm/drm_print.h:461:70: note: in definition of macro 'drm_dbg'
     461 |         drm_dev_dbg((drm) ? (drm)->dev : NULL, DRM_UT_DRIVER, fmt, ##__VA_ARGS__)
         |                                                                      ^~~~~~~~~~~


vim +425 include/drm/drm_print.h

02c9656b2f0d69 Haneen Mohammed       2017-10-17  385  
02c9656b2f0d69 Haneen Mohammed       2017-10-17  386  /**
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  387   * DRM_DEV_DEBUG() - Debug output for generic drm code
02c9656b2f0d69 Haneen Mohammed       2017-10-17  388   *
306589856399e1 Douglas Anderson      2021-09-21  389   * NOTE: this is deprecated in favor of drm_dbg_core().
306589856399e1 Douglas Anderson      2021-09-21  390   *
091756bbb1a961 Haneen Mohammed       2017-10-17  391   * @dev: device pointer
091756bbb1a961 Haneen Mohammed       2017-10-17  392   * @fmt: printf() like format string.
02c9656b2f0d69 Haneen Mohammed       2017-10-17  393   */
db87086492581c Joe Perches           2018-03-16  394  #define DRM_DEV_DEBUG(dev, fmt, ...)					\
db87086492581c Joe Perches           2018-03-16  395  	drm_dev_dbg(dev, DRM_UT_CORE, fmt, ##__VA_ARGS__)
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  396  /**
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  397   * DRM_DEV_DEBUG_DRIVER() - Debug output for vendor specific part of the driver
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  398   *
306589856399e1 Douglas Anderson      2021-09-21  399   * NOTE: this is deprecated in favor of drm_dbg() or dev_dbg().
306589856399e1 Douglas Anderson      2021-09-21  400   *
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  401   * @dev: device pointer
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  402   * @fmt: printf() like format string.
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  403   */
db87086492581c Joe Perches           2018-03-16  404  #define DRM_DEV_DEBUG_DRIVER(dev, fmt, ...)				\
db87086492581c Joe Perches           2018-03-16  405  	drm_dev_dbg(dev, DRM_UT_DRIVER,	fmt, ##__VA_ARGS__)
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  406  /**
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  407   * DRM_DEV_DEBUG_KMS() - Debug output for modesetting code
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  408   *
306589856399e1 Douglas Anderson      2021-09-21  409   * NOTE: this is deprecated in favor of drm_dbg_kms().
306589856399e1 Douglas Anderson      2021-09-21  410   *
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  411   * @dev: device pointer
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  412   * @fmt: printf() like format string.
b52817e9de06a3 Mauro Carvalho Chehab 2020-10-27  413   */
db87086492581c Joe Perches           2018-03-16  414  #define DRM_DEV_DEBUG_KMS(dev, fmt, ...)				\
db87086492581c Joe Perches           2018-03-16  415  	drm_dev_dbg(dev, DRM_UT_KMS, fmt, ##__VA_ARGS__)
a18b21929453af Lyude Paul            2018-07-16  416  
fb6c7ab8718eb2 Jani Nikula           2019-12-10  417  /*
fb6c7ab8718eb2 Jani Nikula           2019-12-10  418   * struct drm_device based logging
fb6c7ab8718eb2 Jani Nikula           2019-12-10  419   *
fb6c7ab8718eb2 Jani Nikula           2019-12-10  420   * Prefer drm_device based logging over device or prink based logging.
fb6c7ab8718eb2 Jani Nikula           2019-12-10  421   */
fb6c7ab8718eb2 Jani Nikula           2019-12-10  422  
fb6c7ab8718eb2 Jani Nikula           2019-12-10  423  /* Helper for struct drm_device based logging. */
fb6c7ab8718eb2 Jani Nikula           2019-12-10  424  #define __drm_printk(drm, level, type, fmt, ...)			\
fb6c7ab8718eb2 Jani Nikula           2019-12-10 @425  	dev_##level##type((drm)->dev, "[drm] " fmt, ##__VA_ARGS__)
fb6c7ab8718eb2 Jani Nikula           2019-12-10  426  
fb6c7ab8718eb2 Jani Nikula           2019-12-10  427  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
