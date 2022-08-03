Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA9E5885DF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 04:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233793AbiHCCkw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 22:40:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiHCCks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:40:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB06A33348;
        Tue,  2 Aug 2022 19:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659494447; x=1691030447;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4+h2x6MTJbiDLT4UD4ZyULbN7mB4aghqMawKynLeEXk=;
  b=VNgy4ShBpxSt42/lEijnrV/VTgMdmP8RpV8/0PQFaqfIUdGMF928EoME
   OrRZRp0MpPze1gkmMdzS3F/T5BSgAgEfQsMiuuV1KcRFLxGO/6RvDTrMe
   igRTvKEp4G+Bt3dF1JOFfa9NzO1SsyG2xDJuWOGvLzttximcUKluX0BfK
   7FwVynlWWCN9iiBG4y7F+DCCeHqfJPskUOBm7q5tij8UBxbJ6nTk9Y8K4
   1fjqjp8EtrHNNBWb3v8FBJx8R1ZAqJG6BZkhkcSYp3tdJ46iiZQnlG9yq
   78R1vcBeHU56G3ZzdDPGJOK8oAMto2H7P9u9bVx7b1rktGMbYicLiqG9Q
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="287127086"
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="287127086"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 19:40:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,212,1654585200"; 
   d="scan'208";a="553153353"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 02 Aug 2022 19:40:44 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJ4JP-000Gi7-1q;
        Wed, 03 Aug 2022 02:40:43 +0000
Date:   Wed, 3 Aug 2022 10:40:31 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Sean Wang <sean.wang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>,
        Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v1 1/1] leds: mt6323: Get rid of custom
 led_init_default_state_get()
Message-ID: <202208031036.PJtAjxAm-lkp@intel.com>
References: <20220802212537.7122-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802212537.7122-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/leds-mt6323-Get-rid-of-custom-led_init_default_state_get/20220803-052811
base:   git://git.kernel.org/pub/scm/linux/kernel/git/pavel/linux-leds.git for-next
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220803/202208031036.PJtAjxAm-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/30cc6458329b3d5a593e0d2173dc63d8dc6446f5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/leds-mt6323-Get-rid-of-custom-led_init_default_state_get/20220803-052811
        git checkout 30cc6458329b3d5a593e0d2173dc63d8dc6446f5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/leds/leds-mt6323.c: In function 'mt6323_led_set_dt_default':
>> drivers/leds/leds-mt6323.c:345:17: error: implicit declaration of function 'led_init_default_state_get'; did you mean 'led_get_default_pattern'? [-Werror=implicit-function-declaration]
     345 |         state = led_init_default_state_get(of_fwnode_handle(np));
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 led_get_default_pattern
   cc1: some warnings being treated as errors


vim +345 drivers/leds/leds-mt6323.c

   337	
   338	static int mt6323_led_set_dt_default(struct led_classdev *cdev,
   339					     struct device_node *np)
   340	{
   341		struct mt6323_led *led = container_of(cdev, struct mt6323_led, cdev);
   342		enum led_default_state state;
   343		int ret = 0;
   344	
 > 345		state = led_init_default_state_get(of_fwnode_handle(np));
   346		switch (state) {
   347		case LEDS_DEFSTATE_ON:
   348			ret = mt6323_led_set_brightness(cdev, cdev->max_brightness);
   349			break;
   350		case LEDS_DEFSTATE_KEEP:
   351			ret = mt6323_get_led_hw_brightness(cdev);
   352			if (ret < 0)
   353				return ret;
   354			led->current_brightness = ret;
   355			ret = 0;
   356			break;
   357		default:
   358			ret = mt6323_led_set_brightness(cdev, LED_OFF);
   359		}
   360	
   361		return ret;
   362	}
   363	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
