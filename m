Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53353588BE9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237857AbiHCMWO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:22:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235994AbiHCMWI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:22:08 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADFF512AA6;
        Wed,  3 Aug 2022 05:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659529327; x=1691065327;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=X8fFu9QSmU9cXPCoF4NzSuBKpuk/b4Qx3+SeEQCPSlY=;
  b=CYHPWRKey6ScoDu0srGvqAk8hx5IHEHjJmB2RieiPQc7qNOmFHDV0uqj
   Px4UaNSNhVdDfGSU1iSUjmCQ2mvAHBdfs9E337R2EQwhUA/TlPale///7
   A2M1m9LrC8NUvibBHNIWeyDs8FgmI84CpWS6IGG6n+ejeQeMHUEjbmFq7
   C7wjaoU4IwQ9y3Xa5y/jXGFHWMFp7qrwXEjaw1zLhDOLVVJmNpoIy+N7A
   TKyG+ByeIojeVpU9eEtMd9ifZNlC8Jb/4bdK8VtWXIgijVkZBFlJw40MH
   XRJRwkjPOAfQmaZ6JR6K3fM38NLS9SWM9uw6iRWBLAoR4YslkgkOgl0x9
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290431412"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="290431412"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 05:22:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="635664871"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 03 Aug 2022 05:22:05 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJDO1-000HFd-0Q;
        Wed, 03 Aug 2022 12:22:05 +0000
Date:   Wed, 3 Aug 2022 20:21:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/1] leds: bcm6328: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208032042.E6WmErcY-lkp@intel.com>
References: <20220802212549.7184-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802212549.7184-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on pavel-leds/for-next]
[also build test ERROR on linus/master v5.19 next-20220802]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-bcm6328-Get-rid-of-custom-led_init_default_state_get/20220803-052959
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: openrisc-randconfig-r035-20220801 (https://download.01.org/0day-ci/archive/20220803/202208032042.E6WmErcY-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/514383e5dd28e25f812c88b0454a02d59e4d205c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/leds-bcm6328-Get-rid-of-custom-led_init_default_state_get/20220803-052959
        git checkout 514383e5dd28e25f812c88b0454a02d59e4d205c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/leds/leds-bcm6328.c: In function 'bcm6328_led':
>> drivers/leds/leds-bcm6328.c:353:17: error: implicit declaration of function 'led_init_default_state_get'; did you mean 'led_get_default_pattern'? [-Werror=implicit-function-declaration]
     353 |         state = led_init_default_state_get(init_data.fwnode);
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 led_get_default_pattern
   cc1: some warnings being treated as errors


vim +353 drivers/leds/leds-bcm6328.c

   326	
   327	static int bcm6328_led(struct device *dev, struct device_node *nc, u32 reg,
   328			       void __iomem *mem, spinlock_t *lock,
   329			       unsigned long *blink_leds, unsigned long *blink_delay)
   330	{
   331		struct led_init_data init_data = {};
   332		struct bcm6328_led *led;
   333		enum led_default_state state;
   334		unsigned long val, shift;
   335		void __iomem *mode;
   336		int rc;
   337	
   338		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
   339		if (!led)
   340			return -ENOMEM;
   341	
   342		led->pin = reg;
   343		led->mem = mem;
   344		led->lock = lock;
   345		led->blink_leds = blink_leds;
   346		led->blink_delay = blink_delay;
   347	
   348		if (of_property_read_bool(nc, "active-low"))
   349			led->active_low = true;
   350	
   351		init_data.fwnode = of_fwnode_handle(nc);
   352	
 > 353		state = led_init_default_state_get(init_data.fwnode);
   354		switch (state) {
   355		case LEDS_DEFSTATE_ON:
   356			led->cdev.brightness = LED_FULL;
   357			break;
   358		case LEDS_DEFSTATE_KEEP:
   359			shift = bcm6328_pin2shift(led->pin);
   360			if (shift / 16)
   361				mode = mem + BCM6328_REG_MODE_HI;
   362			else
   363				mode = mem + BCM6328_REG_MODE_LO;
   364	
   365			val = bcm6328_led_read(mode) >> BCM6328_LED_SHIFT(shift % 16);
   366			val &= BCM6328_LED_MODE_MASK;
   367			if ((led->active_low && val == BCM6328_LED_MODE_OFF) ||
   368			    (!led->active_low && val == BCM6328_LED_MODE_ON))
   369				led->cdev.brightness = LED_FULL;
   370			else
   371				led->cdev.brightness = LED_OFF;
   372			break;
   373		default:
   374			led->cdev.brightness = LED_OFF;
   375		}
   376	
   377		bcm6328_led_set(&led->cdev, led->cdev.brightness);
   378	
   379		led->cdev.brightness_set = bcm6328_led_set;
   380		led->cdev.blink_set = bcm6328_blink_set;
   381	
   382		rc = devm_led_classdev_register_ext(dev, &led->cdev, &init_data);
   383		if (rc < 0)
   384			return rc;
   385	
   386		dev_dbg(dev, "registered LED %s\n", led->cdev.name);
   387	
   388		return 0;
   389	}
   390	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
