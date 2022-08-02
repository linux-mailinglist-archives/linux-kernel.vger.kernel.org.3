Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CF5C5884D6
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 01:43:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234862AbiHBXno (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 19:43:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbiHBXnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 19:43:41 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B635D52DF6;
        Tue,  2 Aug 2022 16:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659483820; x=1691019820;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Sg7HLSheCxg/f3LLYGVRsJVhhL8GUdd8KOlWlW8sRuk=;
  b=LuNygWnTOCGMCyKZ1ZU0M8A43x95xkqBEk4sILG/Gzkx2uXDhpVXSDPG
   4MMsRdWhWZdy5MWEEE0gVLHFe0kZt7d7abuCnUOSPnLEj+3syFMktKU3R
   vDhUvXuwn+h6vfOVNGa4FkdDBiWMCXHUqTU0UqhyzIZAONVd3xAjK4HvQ
   4DfVh8NlIrTri1EUbbVUc7AzQQ0FVTtvvSsY79gkqSqP+h9OQgnl5c0By
   lvJDIGM6Lk7YPiJ1c54yagWqVIj5wxBjhQ/SWsDeRhp1qcRfu/b+FQgfO
   wipKxPpVczgA0/4RqCJkb0Gr/66yZ/sUVUEhKq7WZvwTrV7PMkrqVaahT
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="315398234"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="315398234"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 16:43:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="744858228"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 02 Aug 2022 16:43:38 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ1Y2-000GZR-0b;
        Tue, 02 Aug 2022 23:43:38 +0000
Date:   Wed, 3 Aug 2022 07:43:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/1] leds: an30259a: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208030728.77z65TO4-lkp@intel.com>
References: <20220802212554.7216-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220802212554.7216-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Perhaps something to improve:

[auto build test WARNING on pavel-leds/for-next]
[also build test WARNING on linus/master v5.19 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-an30259a-Get-rid-of-custom-led_init_default_state_get/20220803-053038
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: x86_64-randconfig-a005-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030728.77z65TO4-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/757448b8fc5bcbc4303ce9570d5dd555f1e2b22e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/leds-an30259a-Get-rid-of-custom-led_init_default_state_get/20220803-053038
        git checkout 757448b8fc5bcbc4303ce9570d5dd555f1e2b22e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/leds/leds-an30259a.c:227:24: error: call to undeclared function 'led_init_default_state_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   led->default_state = led_init_default_state_get(led->fwnode);
                                        ^
>> drivers/leds/leds-an30259a.c:204:14: warning: unused variable 'str' [-Wunused-variable]
           const char *str;
                       ^
   1 warning and 1 error generated.


vim +/str +204 drivers/leds/leds-an30259a.c

2d00f35c55e74f Simon Shields    2018-09-09  197  
2d00f35c55e74f Simon Shields    2018-09-09  198  static int an30259a_dt_init(struct i2c_client *client,
2d00f35c55e74f Simon Shields    2018-09-09  199  			    struct an30259a *chip)
2d00f35c55e74f Simon Shields    2018-09-09  200  {
8853c95e997e0a Marek Behún      2020-09-18  201  	struct device_node *np = dev_of_node(&client->dev), *child;
2d00f35c55e74f Simon Shields    2018-09-09  202  	int count, ret;
2d00f35c55e74f Simon Shields    2018-09-09  203  	int i = 0;
2d00f35c55e74f Simon Shields    2018-09-09 @204  	const char *str;
2d00f35c55e74f Simon Shields    2018-09-09  205  	struct an30259a_led *led;
2d00f35c55e74f Simon Shields    2018-09-09  206  
99a013c840a050 Marek Behún      2020-09-18  207  	count = of_get_available_child_count(np);
2d00f35c55e74f Simon Shields    2018-09-09  208  	if (!count || count > AN30259A_MAX_LEDS)
2d00f35c55e74f Simon Shields    2018-09-09  209  		return -EINVAL;
2d00f35c55e74f Simon Shields    2018-09-09  210  
2d00f35c55e74f Simon Shields    2018-09-09  211  	for_each_available_child_of_node(np, child) {
2d00f35c55e74f Simon Shields    2018-09-09  212  		u32 source;
2d00f35c55e74f Simon Shields    2018-09-09  213  
2d00f35c55e74f Simon Shields    2018-09-09  214  		ret = of_property_read_u32(child, "reg", &source);
2d00f35c55e74f Simon Shields    2018-09-09  215  		if (ret != 0 || !source || source > AN30259A_MAX_LEDS) {
2d00f35c55e74f Simon Shields    2018-09-09  216  			dev_err(&client->dev, "Couldn't read LED address: %d\n",
2d00f35c55e74f Simon Shields    2018-09-09  217  				ret);
2d00f35c55e74f Simon Shields    2018-09-09  218  			count--;
2d00f35c55e74f Simon Shields    2018-09-09  219  			continue;
2d00f35c55e74f Simon Shields    2018-09-09  220  		}
2d00f35c55e74f Simon Shields    2018-09-09  221  
2d00f35c55e74f Simon Shields    2018-09-09  222  		led = &chip->leds[i];
2d00f35c55e74f Simon Shields    2018-09-09  223  
2d00f35c55e74f Simon Shields    2018-09-09  224  		led->num = source;
2d00f35c55e74f Simon Shields    2018-09-09  225  		led->chip = chip;
1817208e14c6f7 Jacek Anaszewski 2019-06-09  226  		led->fwnode = of_fwnode_handle(child);
757448b8fc5bcb Andy Shevchenko  2022-08-03  227  		led->default_state = led_init_default_state_get(led->fwnode);
2d00f35c55e74f Simon Shields    2018-09-09  228  
2d00f35c55e74f Simon Shields    2018-09-09  229  		i++;
2d00f35c55e74f Simon Shields    2018-09-09  230  	}
2d00f35c55e74f Simon Shields    2018-09-09  231  
2d00f35c55e74f Simon Shields    2018-09-09  232  	if (!count)
2d00f35c55e74f Simon Shields    2018-09-09  233  		return -EINVAL;
2d00f35c55e74f Simon Shields    2018-09-09  234  
2d00f35c55e74f Simon Shields    2018-09-09  235  	chip->num_leds = i;
2d00f35c55e74f Simon Shields    2018-09-09  236  
2d00f35c55e74f Simon Shields    2018-09-09  237  	return 0;
2d00f35c55e74f Simon Shields    2018-09-09  238  }
2d00f35c55e74f Simon Shields    2018-09-09  239  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
