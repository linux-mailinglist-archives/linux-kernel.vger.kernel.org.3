Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2366F588534
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235339AbiHCAzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234882AbiHCAzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:55:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A617A62EC;
        Tue,  2 Aug 2022 17:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659488143; x=1691024143;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ZfF/etMJCz1X4rARTMDWBQFVurQgR01wP/BTASJ5OE=;
  b=W3zHSY4gkxq0w8Bhb8rKXJxHy8AEkaplX4QApyeN5QFh85hqvxLbEb1U
   AOggsvz0aYiwV4voGMw8RTl1AHGWI+4wb3Bf9SFmYco1Luc+35XW2gRij
   QFYRFwemYrcV9XfC7YUdyD8KqrDxAdA0036F3nTZqe7LMkKq2wozNjmis
   M8Jbg5URCi65eJoZsmhVbdhHqjAFOm6s2TGnI62tnhFk1nSjhK9BPC/QP
   o7NrfawXhUfOWxoZ5lRosO1cAD441rzE3KP9lCw8G0T/FybLe8rjKWKAc
   bSKIdRsGI1WOBLkFAIM22lVvL0++eFIoy1WYSc/3bI7X1GtPaDvg95CPi
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290767989"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="290767989"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 17:55:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="630937106"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Aug 2022 17:55:41 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ2fk-000GdB-2F;
        Wed, 03 Aug 2022 00:55:40 +0000
Date:   Wed, 3 Aug 2022 08:55:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/1] leds: syscon: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208030858.VhHvPCPM-lkp@intel.com>
References: <20220802212507.6995-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802212507.6995-1-andriy.shevchenko@linux.intel.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-syscon-Get-rid-of-custom-led_init_default_state_get/20220803-052528
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: hexagon-randconfig-r041-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030858.VhHvPCPM-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/485abd71bd954b7a2d1ea89818ca5c925714b1e1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/leds-syscon-Get-rid-of-custom-led_init_default_state_get/20220803-052528
        git checkout 485abd71bd954b7a2d1ea89818ca5c925714b1e1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/leds/leds-syscon.c:92:10: error: call to undeclared function 'led_init_default_state_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
           state = led_init_default_state_get(init_data.fwnode);
                   ^
   1 error generated.


vim +/led_init_default_state_get +92 drivers/leds/leds-syscon.c

    55	
    56	static int syscon_led_probe(struct platform_device *pdev)
    57	{
    58		struct led_init_data init_data = {};
    59		struct device *dev = &pdev->dev;
    60		struct device_node *np = dev_of_node(dev);
    61		struct device *parent;
    62		struct regmap *map;
    63		struct syscon_led *sled;
    64		enum led_default_state state;
    65		u32 value;
    66		int ret;
    67	
    68		parent = dev->parent;
    69		if (!parent) {
    70			dev_err(dev, "no parent for syscon LED\n");
    71			return -ENODEV;
    72		}
    73		map = syscon_node_to_regmap(dev_of_node(parent));
    74		if (IS_ERR(map)) {
    75			dev_err(dev, "no regmap for syscon LED parent\n");
    76			return PTR_ERR(map);
    77		}
    78	
    79		sled = devm_kzalloc(dev, sizeof(*sled), GFP_KERNEL);
    80		if (!sled)
    81			return -ENOMEM;
    82	
    83		sled->map = map;
    84	
    85		if (of_property_read_u32(np, "offset", &sled->offset))
    86			return -EINVAL;
    87		if (of_property_read_u32(np, "mask", &sled->mask))
    88			return -EINVAL;
    89	
    90		init_data.fwnode = of_fwnode_handle(np);
    91	
  > 92		state = led_init_default_state_get(init_data.fwnode);
    93		switch (state) {
    94		case LEDS_DEFSTATE_ON:
    95			ret = regmap_update_bits(map, sled->offset, sled->mask, sled->mask);
    96			if (ret < 0)
    97				return ret;
    98			sled->state = true;
    99			break;
   100		case LEDS_DEFSTATE_KEEP:
   101			ret = regmap_read(map, sled->offset, &value);
   102			if (ret < 0)
   103				return ret;
   104			sled->state = !!(value & sled->mask);
   105			break;
   106		default:
   107			ret = regmap_update_bits(map, sled->offset, sled->mask, 0);
   108			if (ret < 0)
   109				return ret;
   110			sled->state = false;
   111		}
   112		sled->cdev.brightness_set = syscon_led_set;
   113	
   114		ret = devm_led_classdev_register_ext(dev, &sled->cdev, &init_data);
   115		if (ret < 0)
   116			return ret;
   117	
   118		platform_set_drvdata(pdev, sled);
   119		dev_info(dev, "registered LED %s\n", sled->cdev.name);
   120	
   121		return 0;
   122	}
   123	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
