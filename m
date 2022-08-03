Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E198588565
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 03:26:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234762AbiHCB0r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 21:26:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231809AbiHCB0p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 21:26:45 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6906C205DC;
        Tue,  2 Aug 2022 18:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659490004; x=1691026004;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BH8xdsbiuKShIsJ1RG8m6Kh4+8oFpaixloeAq3Mozfg=;
  b=oH0/9sKHK8QRWdj/kjnAEnQARh+KOxDF3OwPRkjzVNwcEDrkiekWz6pj
   Bn0h3fLrGC4omdlhm2ChAkivZue3hn2FVlSEGfC45iQb3tDxt43I66t3k
   26m2sxAswnZSL0/EeXJegLfTVKvxKDx000GMA/TCZ5oyCHGm7RAhte26Q
   WtoMmqsYMtN+k8o8bTBmFP9iuFO9ppWwypgD0aaTrumppAE6vBmVX1nI/
   LP4fK69skNFJ8DLb4jyY23tu+Cy0tgJhwH4ThfqLeWFRBstgSbDhmprtt
   9fv5OCjad14v/+HTLopXStktL/njM58leIPEFnF7mzuPB1PTyXBf8u0FE
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="290771949"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="290771949"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 18:26:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="670667902"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 02 Aug 2022 18:26:42 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ39l-000GeR-1Q;
        Wed, 03 Aug 2022 01:26:41 +0000
Date:   Wed, 3 Aug 2022 09:26:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v1 1/1] leds: an30259a: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208030939.UxKQfaZY-lkp@intel.com>
References: <20220802212554.7216-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802212554.7216-1-andriy.shevchenko@linux.intel.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-an30259a-Get-rid-of-custom-led_init_default_state_get/20220803-053038
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: x86_64-randconfig-a005-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030939.UxKQfaZY-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/leds/leds-an30259a.c:227:24: error: call to undeclared function 'led_init_default_state_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   led->default_state = led_init_default_state_get(led->fwnode);
                                        ^
   drivers/leds/leds-an30259a.c:204:14: warning: unused variable 'str' [-Wunused-variable]
           const char *str;
                       ^
   1 warning and 1 error generated.


vim +/led_init_default_state_get +227 drivers/leds/leds-an30259a.c

   197	
   198	static int an30259a_dt_init(struct i2c_client *client,
   199				    struct an30259a *chip)
   200	{
   201		struct device_node *np = dev_of_node(&client->dev), *child;
   202		int count, ret;
   203		int i = 0;
   204		const char *str;
   205		struct an30259a_led *led;
   206	
   207		count = of_get_available_child_count(np);
   208		if (!count || count > AN30259A_MAX_LEDS)
   209			return -EINVAL;
   210	
   211		for_each_available_child_of_node(np, child) {
   212			u32 source;
   213	
   214			ret = of_property_read_u32(child, "reg", &source);
   215			if (ret != 0 || !source || source > AN30259A_MAX_LEDS) {
   216				dev_err(&client->dev, "Couldn't read LED address: %d\n",
   217					ret);
   218				count--;
   219				continue;
   220			}
   221	
   222			led = &chip->leds[i];
   223	
   224			led->num = source;
   225			led->chip = chip;
   226			led->fwnode = of_fwnode_handle(child);
 > 227			led->default_state = led_init_default_state_get(led->fwnode);
   228	
   229			i++;
   230		}
   231	
   232		if (!count)
   233			return -EINVAL;
   234	
   235		chip->num_leds = i;
   236	
   237		return 0;
   238	}
   239	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
