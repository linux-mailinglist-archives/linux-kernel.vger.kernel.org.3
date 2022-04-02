Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5EC4EFF14
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 07:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239610AbiDBFvg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 01:51:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbiDBFvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 01:51:32 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B738EB68;
        Fri,  1 Apr 2022 22:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648878581; x=1680414581;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TZGP2yFhIfg8kh6ZCxxoGQgrQRnyKJ7mHLD5XwA3Q/M=;
  b=Ak1D2IxYLdvJ4VTDt77Ii5+l4vzUj/sXJDyHWQ2PHK6WvObOWfK1cQ0X
   uqSJDZYdPU2qIVLGkM7mvtQxSpxS3CXCyPGfZov5R7FS4c1lkG3dIiiAu
   +knDutS2Nkv8KB0d1sq+v3xcG/LfcKPh0ffw0ZaRR1uMx+XxCz8Mpjdg+
   LA8a2zPGI0BigeEYm+IB8ZnUEo0Jv3jjgnQlB54Js5K4YrwMGTdTdn2WO
   gXyhSEmAraQFMv2+fGbczXUjj3V1UJj6jEcjBdkqbTV2ng4wa+g2iMPyJ
   0b609j/XJbHUvoOBj/3NPLx5wS8YH2T7n3C1ka+fWW4ow6iHhFx4y0SQg
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10304"; a="346718237"
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="346718237"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 22:49:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,229,1643702400"; 
   d="scan'208";a="696111634"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by fmsmga001.fm.intel.com with ESMTP; 01 Apr 2022 22:49:35 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1naWdj-0001m0-A8;
        Sat, 02 Apr 2022 05:49:35 +0000
Date:   Sat, 2 Apr 2022 13:49:02 +0800
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
        linux-mips@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v14 5/6] drm/loongson: add drm driver for loongson
 display controller
Message-ID: <202204021321.5sYDUPbx-lkp@intel.com>
References: <20220401162251.1665081-6-15330273260@189.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220401162251.1665081-6-15330273260@189.cn>
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

Hi Sui,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on drm/drm-next]
[also build test ERROR on robh/for-next linus/master v5.17 next-20220401]
[cannot apply to mripard/sunxi/for-next]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sui-Jingfeng/drm-loongson-add-drm-driver-for-loongson-display-controller/20220402-003557
base:   git://anongit.freedesktop.org/drm/drm drm-next
config: sparc-randconfig-r012-20220402 (https://download.01.org/0day-ci/archive/20220402/202204021321.5sYDUPbx-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/b52cc469ed1a99a0803faef886f81607b1f7f5c0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sui-Jingfeng/drm-loongson-add-drm-driver-for-loongson-display-controller/20220402-003557
        git checkout b52cc469ed1a99a0803faef886f81607b1f7f5c0
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=sparc SHELL=/bin/bash drivers/gpu/drm/loongson/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/gpu/drm/loongson/lsdc_i2c.c: In function 'ls7a_gpio_i2c_set':
>> drivers/gpu/drm/loongson/lsdc_i2c.c:37:23: error: implicit declaration of function 'readb' [-Werror=implicit-function-declaration]
      37 |                 val = readb(li2c->dir_reg);
         |                       ^~~~~
>> drivers/gpu/drm/loongson/lsdc_i2c.c:39:17: error: implicit declaration of function 'writeb' [-Werror=implicit-function-declaration]
      39 |                 writeb(val, li2c->dir_reg);
         |                 ^~~~~~
   cc1: some warnings being treated as errors


vim +/readb +37 drivers/gpu/drm/loongson/lsdc_i2c.c

    19	
    20	/*
    21	 * ls7a_gpio_i2c_set - set the state of a gpio pin, either high or low.
    22	 * @mask: gpio pin mask indicate which pin to set
    23	 */
    24	static void ls7a_gpio_i2c_set(struct lsdc_i2c * const li2c, int mask, int state)
    25	{
    26		unsigned long flags;
    27		u8 val;
    28	
    29		spin_lock_irqsave(&li2c->reglock, flags);
    30	
    31		if (state) {
    32			/*
    33			 * The high state is achieved by setting the direction as
    34			 * input, because the GPIO is open drained with external
    35			 * pull up resistance.
    36			 */
  > 37			val = readb(li2c->dir_reg);
    38			val |= mask;
  > 39			writeb(val, li2c->dir_reg);
    40		} else {
    41			/* First, set this pin as output */
    42			val = readb(li2c->dir_reg);
    43			val &= ~mask;
    44			writeb(val, li2c->dir_reg);
    45	
    46			/* Then, set the state to it */
    47			val = readb(li2c->dat_reg);
    48			val &= ~mask;
    49			writeb(val, li2c->dat_reg);
    50		}
    51	
    52		spin_unlock_irqrestore(&li2c->reglock, flags);
    53	}
    54	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
