Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 450BC588554
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:17:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235277AbiHCBQ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbiHCBQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:16:45 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303DE54647;
        Tue,  2 Aug 2022 18:16:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659489404; x=1691025404;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=z30jiwqxYungx4RUyICnlg/pLFR417/GCMVuPX0HlwI=;
  b=E3nxrkVvZx83Z7YlqXfFUJI8ZHy9tTxCDnm0siJKppnW1jg320VuWy4s
   8xh33EthREnl0McC5O+3K0OAQRukrVq9MX1IVtH8ClZVAfH/VZoXoGP+V
   NJkAZtAm2WThtj/bCvgnoQRAEqmIePTCFGUGURfJKF6ey8nAhPhxvxwah
   V1VRCtrdfzL+XnFK7cwrVX0+WvwGraALnWQ3o29RpPxS911MbXbas2YnF
   PngJNE8822BL9ncCjqN/JREFo4ryaqtcioNGkeTBgWtF/V20iywbC1rOX
   yBIvuBuaMIgSNCNBpfLMPG8Hw5UKIz1j7aLSs4doqoxy3f9YBJC+vg+Cm
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="353559020"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="353559020"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 18:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="692058813"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 02 Aug 2022 18:16:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ305-000Ge3-0x;
        Wed, 03 Aug 2022 01:16:41 +0000
Date:   Wed, 3 Aug 2022 09:16:14 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/1] leds: pm8058: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208030942.Sh3TajDz-lkp@intel.com>
References: <20220802212513.7029-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802212513.7029-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-pm8058-Get-rid-of-custom-led_init_default_state_get/20220803-052610
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: arm-buildonly-randconfig-r002-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030942.Sh3TajDz-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/58bf03fa835e906a28c49e4aef6060d140239d7f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/leds-pm8058-Get-rid-of-custom-led_init_default_state_get/20220803-052610
        git checkout 58bf03fa835e906a28c49e4aef6060d140239d7f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/leds/leds-pm8058.c:130:10: error: call to undeclared function 'led_init_default_state_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           state = led_init_default_state_get(init_data.fwnode);
                   ^
   1 error generated.


vim +/led_init_default_state_get +130 drivers/leds/leds-pm8058.c

    87	
    88	static int pm8058_led_probe(struct platform_device *pdev)
    89	{
    90		struct led_init_data init_data = {};
    91		struct device *dev = &pdev->dev;
    92		struct pm8058_led *led;
    93		struct device_node *np;
    94		int ret;
    95		struct regmap *map;
    96		enum led_brightness maxbright;
    97		enum led_default_state state;
    98	
    99		led = devm_kzalloc(dev, sizeof(*led), GFP_KERNEL);
   100		if (!led)
   101			return -ENOMEM;
   102	
   103		led->ledtype = (u32)(unsigned long)of_device_get_match_data(dev);
   104	
   105		map = dev_get_regmap(dev->parent, NULL);
   106		if (!map) {
   107			dev_err(dev, "Parent regmap unavailable.\n");
   108			return -ENXIO;
   109		}
   110		led->map = map;
   111	
   112		np = dev_of_node(dev);
   113	
   114		ret = of_property_read_u32(np, "reg", &led->reg);
   115		if (ret) {
   116			dev_err(dev, "no register offset specified\n");
   117			return -EINVAL;
   118		}
   119	
   120		led->cdev.brightness_set = pm8058_led_set;
   121		led->cdev.brightness_get = pm8058_led_get;
   122		if (led->ledtype == PM8058_LED_TYPE_COMMON)
   123			maxbright = 31; /* 5 bits */
   124		else
   125			maxbright = 15; /* 4 bits */
   126		led->cdev.max_brightness = maxbright;
   127	
   128		init_data.fwnode = of_fwnode_handle(np);
   129	
 > 130		state = led_init_default_state_get(init_data.fwnode);
   131		switch (state) {
   132		case LEDS_DEFSTATE_ON:
   133			led->cdev.brightness = maxbright;
   134			pm8058_led_set(&led->cdev, maxbright);
   135			break;
   136		case LEDS_DEFSTATE_KEEP:
   137			led->cdev.brightness = pm8058_led_get(&led->cdev);
   138			break;
   139		default:
   140			led->cdev.brightness = LED_OFF;
   141			pm8058_led_set(&led->cdev, LED_OFF);
   142		}
   143	
   144		if (led->ledtype == PM8058_LED_TYPE_KEYPAD ||
   145		    led->ledtype == PM8058_LED_TYPE_FLASH)
   146			led->cdev.flags	= LED_CORE_SUSPENDRESUME;
   147	
   148		ret = devm_led_classdev_register_ext(dev, &led->cdev, &init_data);
   149		if (ret)
   150			dev_err(dev, "Failed to register LED for %pOF\n", np);
   151	
   152		return ret;
   153	}
   154	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
