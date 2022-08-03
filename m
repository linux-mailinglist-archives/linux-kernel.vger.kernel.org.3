Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAF435885F0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 05:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233264AbiHCDBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 23:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiHCDBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 23:01:48 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39BD9275FF;
        Tue,  2 Aug 2022 20:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659495707; x=1691031707;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=vzrNQj92FL+1MtBy1f0VxABmKltiKHuH7QjYX2vhEVQ=;
  b=ApQeEqDC6J9MmvyPXgIFc6iKGs9uzaLBWCpd1qn8sf0Pw7XMQyoO9kq/
   JyGCxwm6K6TfHKwJsbRlMKpDY9lKTLsSBORXwMA/gKx3Aa500h803urAJ
   Ve/Q7yVdBPhLKutVAaYQIM5jCZp9If/dLhYCjB8EAdmp3UD6fHosaRWGe
   LQHpSPwsUhz7fxxdDF8/I+lT4xEY/TV/otTdNPVVHEfuKCOF0viEuB7HU
   11p4hEy8yip3ny8wu1v7ZaoS8OYgi/EbjMvqELT7/VYnRXX9lZEZ38d7f
   ZkQSm5NhrN2YdHww0vH2i1F6jwlrkl25mo6AU+YqeLt1mAc+iib8FhXQm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="351282435"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="351282435"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 20:01:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="553157952"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2022 20:01:44 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ4dj-000Git-39;
        Wed, 03 Aug 2022 03:01:43 +0000
Date:   Wed, 3 Aug 2022 11:00:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
        Eddie James <eajames@linux.ibm.com>,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] leds: pca955x: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208031021.KATz865M-lkp@intel.com>
References: <20220802212518.7060-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
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

I love your patch! Perhaps something to improve:

[auto build test WARNING on pavel-leds/for-next]
[also build test WARNING on linus/master v5.19 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-pca955x-Get-rid-of-custom-led_init_default_state_get/20220803-052712
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220803/202208031021.KATz865M-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/46936c7c7d9d52d3029e319fc78b727a9e0fc046
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/leds-pca955x-Get-rid-of-custom-led_init_default_state_get/20220803-052712
        git checkout 46936c7c7d9d52d3029e319fc78b727a9e0fc046
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/leds/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/leds/leds-pca955x.c: In function 'pca955x_get_pdata':
   drivers/leds/leds-pca955x.c:457:38: error: implicit declaration of function 'led_init_default_state_get'; did you mean 'led_get_default_pattern'? [-Werror=implicit-function-declaration]
     457 |                 led->default_state = led_init_default_state_get(child);
         |                                      ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                                      led_get_default_pattern
>> drivers/leds/leds-pca955x.c:446:29: warning: unused variable 'state' [-Wunused-variable]
     446 |                 const char *state;
         |                             ^~~~~
   cc1: some warnings being treated as errors


vim +/state +446 drivers/leds/leds-pca955x.c

561099a1a2e992 Cédric Le Goater 2017-08-08  422  
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  423  static struct pca955x_platform_data *
967f69de81478c Andy Shevchenko  2019-03-25  424  pca955x_get_pdata(struct i2c_client *client, struct pca955x_chipdef *chip)
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  425  {
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  426  	struct pca955x_platform_data *pdata;
2420ae02ce0a92 Eddie James      2021-07-16  427  	struct pca955x_led *led;
967f69de81478c Andy Shevchenko  2019-03-25  428  	struct fwnode_handle *child;
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  429  	int count;
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  430  
967f69de81478c Andy Shevchenko  2019-03-25  431  	count = device_get_child_node_count(&client->dev);
e26557a0aa68ac Andrew Jeffery   2021-09-21  432  	if (count > chip->bits)
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  433  		return ERR_PTR(-ENODEV);
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  434  
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  435  	pdata = devm_kzalloc(&client->dev, sizeof(*pdata), GFP_KERNEL);
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  436  	if (!pdata)
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  437  		return ERR_PTR(-ENOMEM);
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  438  
a86854d0c599b3 Kees Cook        2018-06-12  439  	pdata->leds = devm_kcalloc(&client->dev,
a86854d0c599b3 Kees Cook        2018-06-12  440  				   chip->bits, sizeof(struct pca955x_led),
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  441  				   GFP_KERNEL);
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  442  	if (!pdata->leds)
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  443  		return ERR_PTR(-ENOMEM);
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  444  
967f69de81478c Andy Shevchenko  2019-03-25  445  	device_for_each_child_node(&client->dev, child) {
e46cb6d0c760a5 Eddie James      2021-07-16 @446  		const char *state;
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  447  		u32 reg;
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  448  		int res;
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  449  
967f69de81478c Andy Shevchenko  2019-03-25  450  		res = fwnode_property_read_u32(child, "reg", &reg);
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  451  		if ((res != 0) || (reg >= chip->bits))
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  452  			continue;
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  453  
2420ae02ce0a92 Eddie James      2021-07-16  454  		led = &pdata->leds[reg];
2420ae02ce0a92 Eddie James      2021-07-16  455  		led->type = PCA955X_TYPE_LED;
7c4815929276b2 Eddie James      2021-07-16  456  		led->fwnode = child;
46936c7c7d9d52 Andy Shevchenko  2022-08-03  457  		led->default_state = led_init_default_state_get(child);
e46cb6d0c760a5 Eddie James      2021-07-16  458  
46936c7c7d9d52 Andy Shevchenko  2022-08-03  459  		fwnode_property_read_u32(child, "type", &led->type);
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  460  	}
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  461  
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  462  	pdata->num_leds = chip->bits;
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  463  
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  464  	return pdata;
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  465  }
ed1f4b9676a8eb Cédric Le Goater 2017-08-08  466  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
