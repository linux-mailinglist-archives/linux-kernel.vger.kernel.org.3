Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23002588545
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232820AbiHCBFu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:05:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiHCBFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:05:45 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4314911476;
        Tue,  2 Aug 2022 18:05:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659488743; x=1691024743;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fG0SfUv60QUrMeLSFbWDuntgIs0PdphLkGOfDYE6X84=;
  b=Tc/UIbXHMrk6IAKp7jHHFZ5svXOs1p305QZ/b/CRMzzSS8KaKmRMTJXA
   oPOX5xkYAvv2lDlCRcKaiXeBmIR3JXKpRftHK3r/UaGc+vHoNQlmv+6vh
   f/ykU4Px/Y4kPuuyVBFT89XsJ2rcphLXEhGsqpoOBG11r59kD/h7QGDa5
   U03/PmotFhJn2vY2iiIGnZ/GJSklDHA0pSB8I7kGJmd7M1YJ5VTOiPyfp
   WnE7TZQXLoem7PefczyU5fRyOwXWX+Sem31S3GwHWCPQR+bhEjJ8WxA0O
   3/lcU05/MQ2VyQWE8kh/REKZKcojit5lnX9Y5Gk38RxDi2+aR5DTXtZo/
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="269325497"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="269325497"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 18:05:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="930189178"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2022 18:05:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ2pQ-000GdT-2k;
        Wed, 03 Aug 2022 01:05:40 +0000
Date:   Wed, 3 Aug 2022 09:05:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/1] leds: bcm6328: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208030838.PJKVWL10-lkp@intel.com>
References: <20220802212549.7184-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802212549.7184-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on pavel-leds/for-next]
[also build test ERROR on linus/master v5.19 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-bcm6328-Get-rid-of-custom-led_init_default_state_get/20220803-052959
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: hexagon-randconfig-r045-20220802 (https://download.01.org/0day-ci/archive/20220803/202208030838.PJKVWL10-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/514383e5dd28e25f812c88b0454a02d59e4d205c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/leds-bcm6328-Get-rid-of-custom-led_init_default_state_get/20220803-052959
        git checkout 514383e5dd28e25f812c88b0454a02d59e4d205c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/leds/leds-bcm6328.c:353:10: error: call to undeclared function 'led_init_default_state_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           state = led_init_default_state_get(init_data.fwnode);
                   ^
   1 error generated.


vim +/led_init_default_state_get +353 drivers/leds/leds-bcm6328.c

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
