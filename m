Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677075884D7
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbiHBXnp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:43:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232900AbiHBXnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:43:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1838752E42;
        Tue,  2 Aug 2022 16:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659483821; x=1691019821;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=/LJASFRzIeInreQ73D8eRDuT2RqFrVAf9oHkIaKOgWU=;
  b=fYoUpboNAHBAa3exOEQnD8fYr6cdlvtVHjb09Ia466v2ChD3jHQIbBm9
   CakKgMJYSTeNOhX6c0zVEXctejJ/A3Q9Au41ehsjbJAi2MdrBc8jw7hoh
   35jUodYmAZ1wZ/3y8/OIH0T85d2Z1O3RI5+NFgk9V4y9ulPqQ/I2Jritp
   qL42v3cuhPEGlr6pF0GlwBWQadlxcDXtk42rGw0/jyhqur5CmovumOirF
   8V/klUAVELpIg/53e2R9za95crkPjjgWHE+VSjgQ21kwvCySLNrdqxRXp
   EHQ8IIG3cKgToiK8rwdOT05Qi0uZHM539ciDU48SR96LCR1pnc/vHGUzY
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="375843685"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="375843685"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 16:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="930169030"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 02 Aug 2022 16:43:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ1Y2-000GZP-0X;
        Tue, 02 Aug 2022 23:43:38 +0000
Date:   Wed, 3 Aug 2022 07:43:06 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Gene Chen <gene_chen@richtek.com>, linux-leds@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 1/1] leds: mt6360: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208030728.Yo6CynF9-lkp@intel.com>
References: <20220802212532.7091-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802212532.7091-1-andriy.shevchenko@linux.intel.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-mt6360-Get-rid-of-custom-led_init_default_state_get/20220803-052854
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: arc-randconfig-r043-20220802 (https://download.01.org/0day-ci/archive/20220803/202208030728.Yo6CynF9-lkp@intel.com/config)
compiler: arceb-elf-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/260d7c20cbd2b5da92dfa5ffa7c73499661c838f
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/leds-mt6360-Get-rid-of-custom-led_init_default_state_get/20220803-052854
        git checkout 260d7c20cbd2b5da92dfa5ffa7c73499661c838f
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arc SHELL=/bin/bash drivers/leds/flash/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/leds/flash/leds-mt6360.c: In function 'mt6360_led_probe':
>> drivers/leds/flash/leds-mt6360.c:832:38: error: implicit declaration of function 'led_init_default_state_get'; did you mean 'led_get_default_pattern'? [-Werror=implicit-function-declaration]
     832 |                 led->default_state = led_init_default_state_get(child);
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      led_get_default_pattern
   cc1: some warnings being treated as errors


vim +832 drivers/leds/flash/leds-mt6360.c

   770	
   771	static int mt6360_led_probe(struct platform_device *pdev)
   772	{
   773		struct mt6360_priv *priv;
   774		struct fwnode_handle *child;
   775		size_t count;
   776		int i = 0, ret;
   777	
   778		count = device_get_child_node_count(&pdev->dev);
   779		if (!count || count > MT6360_MAX_LEDS) {
   780			dev_err(&pdev->dev,
   781				"No child node or node count over max led number %zu\n",
   782				count);
   783			return -EINVAL;
   784		}
   785	
   786		priv = devm_kzalloc(&pdev->dev,
   787				    struct_size(priv, leds, count), GFP_KERNEL);
   788		if (!priv)
   789			return -ENOMEM;
   790	
   791		priv->leds_count = count;
   792		priv->dev = &pdev->dev;
   793		mutex_init(&priv->lock);
   794	
   795		priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
   796		if (!priv->regmap) {
   797			dev_err(&pdev->dev, "Failed to get parent regmap\n");
   798			return -ENODEV;
   799		}
   800	
   801		device_for_each_child_node(&pdev->dev, child) {
   802			struct mt6360_led *led = priv->leds + i;
   803			struct led_init_data init_data = { .fwnode = child, };
   804			u32 reg, led_color;
   805	
   806			ret = fwnode_property_read_u32(child, "color", &led_color);
   807			if (ret)
   808				goto out_flash_release;
   809	
   810			if (led_color == LED_COLOR_ID_RGB ||
   811			    led_color == LED_COLOR_ID_MULTI)
   812				reg = MT6360_VIRTUAL_MULTICOLOR;
   813			else {
   814				ret = fwnode_property_read_u32(child, "reg", &reg);
   815				if (ret)
   816					goto out_flash_release;
   817	
   818				if (reg >= MT6360_MAX_LEDS) {
   819					ret = -EINVAL;
   820					goto out_flash_release;
   821				}
   822			}
   823	
   824			if (priv->leds_active & BIT(reg)) {
   825				ret = -EINVAL;
   826				goto out_flash_release;
   827			}
   828			priv->leds_active |= BIT(reg);
   829	
   830			led->led_no = reg;
   831			led->priv = priv;
 > 832			led->default_state = led_init_default_state_get(child);
   833	
   834			if (reg == MT6360_VIRTUAL_MULTICOLOR ||
   835			    reg <= MT6360_LED_ISNKML)
   836				ret = mt6360_init_isnk_properties(led, &init_data);
   837			else
   838				ret = mt6360_init_flash_properties(led, &init_data);
   839	
   840			if (ret)
   841				goto out_flash_release;
   842	
   843			ret = mt6360_led_register(&pdev->dev, led, &init_data);
   844			if (ret)
   845				goto out_flash_release;
   846	
   847			i++;
   848		}
   849	
   850		platform_set_drvdata(pdev, priv);
   851		return 0;
   852	
   853	out_flash_release:
   854		mt6360_v4l2_flash_release(priv);
   855		return ret;
   856	}
   857	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
