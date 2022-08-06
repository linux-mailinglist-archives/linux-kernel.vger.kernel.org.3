Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84D2458B644
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 17:01:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230443AbiHFPBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 11:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbiHFPBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 11:01:02 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93E1610544;
        Sat,  6 Aug 2022 08:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659798061; x=1691334061;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N2n+7pfk025Ahr8LJDCTmAQFqmwhe72MJrkRgL4kXiA=;
  b=cW7PQaYtLuTS3uBUEaO7RZ7yzjjcs+ITEHrTDwo4Acslkql1xBBVJKxn
   sQraZRLvvBDuLnQyX1DX5R+PhCnmGVAOSW0DqkW904jWaJUmeOumYpafv
   2E2O+e6OJtvJA3kU1ZRBR2UQMkaP6p3PZAJ7ovma0ln8AGMu0nNSFExdP
   wXEY4qLcxDOSo+S8ukwBE6G7svSm+nvHPKA65f/Hv5wDYhr2YDLgOhnnW
   VjWE5I0Ci3NbvOeFG6UJ15lHsTqgShvpMKXAd/VumirVdOi/EwkYuYduc
   ZM5wocmaNQ7Gl7vBDHqe0u5Nl5iOBfa1WH+tMh73e6seDay5tVtqbt/PZ
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10431"; a="352097014"
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="352097014"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2022 08:01:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,217,1654585200"; 
   d="scan'208";a="600649427"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 06 Aug 2022 08:00:59 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oKLIQ-000KSl-2q;
        Sat, 06 Aug 2022 15:00:58 +0000
Date:   Sat, 6 Aug 2022 23:00:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/1] leds: bcm6358: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208062208.6mgNYMMy-lkp@intel.com>
References: <20220802212542.7153-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802212542.7153-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on pavel-leds/for-next]
[also build test ERROR on linus/master v5.19 next-20220805]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-bcm6358-Get-rid-of-custom-led_init_default_state_get/20220803-053220
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: parisc-randconfig-r014-20220801 (https://download.01.org/0day-ci/archive/20220806/202208062208.6mgNYMMy-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/ad3083d8ac0e2beb10b75a7d87085911b4f6139a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/leds-bcm6358-Get-rid-of-custom-led_init_default_state_get/20220803-053220
        git checkout ad3083d8ac0e2beb10b75a7d87085911b4f6139a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/leds/leds-bcm6358.c: In function 'bcm6358_led':
>> drivers/leds/leds-bcm6358.c:116:17: error: implicit declaration of function 'led_init_default_state_get'; did you mean 'led_get_default_pattern'? [-Werror=implicit-function-declaration]
     116 |         state = led_init_default_state_get(init_data.fwnode);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 led_get_default_pattern
   cc1: some warnings being treated as errors


vim +116 drivers/leds/leds-bcm6358.c

    93	
    94	static int bcm6358_led(struct device *dev, struct device_node *nc, u32 reg,
    95			       void __iomem *mem, spinlock_t *lock)
    96	{
    97		struct led_init_data init_data = {};
    98		struct bcm6358_led *led;
    99		enum led_default_state state;
   100		unsigned long val;
   101		int rc;
   102	
   103		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
   104		if (!led)
   105			return -ENOMEM;
   106	
   107		led->pin = reg;
   108		led->mem = mem;
   109		led->lock = lock;
   110	
   111		if (of_property_read_bool(nc, "active-low"))
   112			led->active_low = true;
   113	
   114		init_data.fwnode = of_fwnode_handle(nc);
   115	
 > 116		state = led_init_default_state_get(init_data.fwnode);
   117		switch (state) {
   118		case LEDS_DEFSTATE_ON:
   119			led->cdev.brightness = LED_FULL;
   120			break;
   121		case LEDS_DEFSTATE_KEEP:
   122			val = bcm6358_led_read(led->mem + BCM6358_REG_MODE);
   123			val &= BIT(led->pin);
   124			if ((led->active_low && !val) || (!led->active_low && val))
   125				led->cdev.brightness = LED_FULL;
   126			else
   127				led->cdev.brightness = LED_OFF;
   128			break;
   129		default:
   130			led->cdev.brightness = LED_OFF;
   131		}
   132	
   133		bcm6358_led_set(&led->cdev, led->cdev.brightness);
   134	
   135		led->cdev.brightness_set = bcm6358_led_set;
   136	
   137		rc = devm_led_classdev_register_ext(dev, &led->cdev, &init_data);
   138		if (rc < 0)
   139			return rc;
   140	
   141		dev_dbg(dev, "registered LED %s\n", led->cdev.name);
   142	
   143		return 0;
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
