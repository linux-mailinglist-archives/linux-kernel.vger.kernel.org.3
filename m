Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85AEA588510
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 02:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbiHCAOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 20:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231666AbiHCAOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 20:14:43 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DE9F22517;
        Tue,  2 Aug 2022 17:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659485682; x=1691021682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xpxxa/VeBWxsoXeuPULa0bmbGExEbeR3SKlaLFr5VXs=;
  b=TSea9EEsP8gwiCOeQ+BYrJiJQWhtSwMkAE0wlYH1/8ty8Egbg/jf2sgG
   x3wyh7k6wMS7zazunxcqJ2JcY40WrkiSVGfD7tPZxa7XXA/9/hsn6ULE3
   ALb/kFnAlxGwDHFaVF3XS/ffwxWU8gt9Qb7NevO41FtQfeeslBKIWQZFl
   GejANm7XekiaoEmGAZ7Jn7FCn6Y+IbFBo3hYHx5/h6cfWw+BecXQb1Xx+
   6zgIwZJ+qHWfN4xz3bYElEj+JMtvc98GnuwPIYrWIJEklRM7RByGR1HGM
   zb6KzuOKFNMUjCWQJt4fTi2Yhvfhe5NVmTx2jklIJh4iBBgaQe7cTHWcF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="375847850"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="375847850"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 17:14:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="578426894"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2022 17:14:39 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ223-000Gap-0G;
        Wed, 03 Aug 2022 00:14:39 +0000
Date:   Wed, 3 Aug 2022 08:13:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Eddie James <eajames@linux.ibm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] leds: pca955x: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208030828.HPkXzKSf-lkp@intel.com>
References: <20220802212518.7060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802212518.7060-1-andriy.shevchenko@linux.intel.com>
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

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-pca955x-Get-rid-of-custom-led_init_default_state_get/20220803-052712
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: x86_64-randconfig-a002-20220801 (https://download.01.org/0day-ci/archive/20220803/202208030828.HPkXzKSf-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/46936c7c7d9d52d3029e319fc78b727a9e0fc046
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/leds-pca955x-Get-rid-of-custom-led_init_default_state_get/20220803-052712
        git checkout 46936c7c7d9d52d3029e319fc78b727a9e0fc046
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/leds/leds-pca955x.c:457:24: error: call to undeclared function 'led_init_default_state_get'; ISO C99 and later do not support implicit function declarations [-Wimplicit-function-declaration]
                   led->default_state = led_init_default_state_get(child);
                                        ^
>> drivers/leds/leds-pca955x.c:446:15: warning: unused variable 'state' [-Wunused-variable]
                   const char *state;
                               ^
   drivers/leds/leds-pca955x.c:494:15: warning: cast to smaller integer type 'enum pca955x_type' from 'const void *' [-Wvoid-pointer-to-enum-cast]
                   chip_type = (enum pca955x_type)md;
                               ^~~~~~~~~~~~~~~~~~~~~
   2 warnings and 1 error generated.


vim +/led_init_default_state_get +457 drivers/leds/leds-pca955x.c

   422	
   423	static struct pca955x_platform_data *
   424	pca955x_get_pdata(struct i2c_client *client, struct pca955x_chipdef *chip)
   425	{
   426		struct pca955x_platform_data *pdata;
   427		struct pca955x_led *led;
   428		struct fwnode_handle *child;
   429		int count;
   430	
   431		count = device_get_child_node_count(&client->dev);
   432		if (count > chip->bits)
   433			return ERR_PTR(-ENODEV);
   434	
   435		pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
   436		if (!pdata)
   437			return ERR_PTR(-ENOMEM);
   438	
   439		pdata->leds = devm_kcalloc(&client->dev,
   440					   chip->bits, sizeof(struct pca955x_led),
   441					   GFP_KERNEL);
   442		if (!pdata->leds)
   443			return ERR_PTR(-ENOMEM);
   444	
   445		device_for_each_child_node(&client->dev, child) {
 > 446			const char *state;
   447			u32 reg;
   448			int res;
   449	
   450			res = fwnode_property_read_u32(child, "reg", &reg);
   451			if ((res != 0) || (reg >= chip->bits))
   452				continue;
   453	
   454			led = &pdata->leds[reg];
   455			led->type = PCA955X_TYPE_LED;
   456			led->fwnode = child;
 > 457			led->default_state = led_init_default_state_get(child);
   458	
   459			fwnode_property_read_u32(child, "type", &led->type);
   460		}
   461	
   462		pdata->num_leds = chip->bits;
   463	
   464		return pdata;
   465	}
   466	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
