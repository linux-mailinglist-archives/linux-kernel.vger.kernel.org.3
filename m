Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 796FC5142C7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 09:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354842AbiD2HEZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 03:04:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351983AbiD2HEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 03:04:22 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3EEDB8228;
        Fri, 29 Apr 2022 00:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651215664; x=1682751664;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1d4EA+GAeB2i1quacZYLkgBEH5LKN2qs4OFoh8w4Yl8=;
  b=V1liJDkQZeBVkXi+422R9b+pW7XVZjBV1gUWngmACyhJ5SwNthhU2fw5
   LOGaa/tUYfEWTR+LcURqtSQmuguX+8SJMf1DP2LL+y/EIflBKGL/uLXg2
   0XEKMpWRxm32SC2d9kCN4fktXLKyEez2eUonTiQ/vxmrbH7GaaOtm3jeP
   kkR4fe5xSylmJltu57Gtm0ECofoSBm52ZhKJkOrpjGBa+lOpbwpQE0tGy
   UcARaPOXY8Z3MUsINUjGPOdDZrGJHDOouDPMaD5u7VOUIb13CnAlKTMo7
   kvptzp2yBSCNjWjMJ8Ju4rlZr9Am2xgDGQyV2BSS1SWGzvoTupUSGFtah
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10331"; a="246470813"
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="246470813"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 00:01:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,297,1647327600"; 
   d="scan'208";a="618545672"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 29 Apr 2022 00:00:59 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkKcc-00065f-Pi;
        Fri, 29 Apr 2022 07:00:58 +0000
Date:   Fri, 29 Apr 2022 15:00:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        s.nawrocki@samsung.com, andrzej.hajda@intel.com, mchehab@kernel.org
Cc:     kbuild-all@lists.01.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] media: s5c73m3: replace legacy gpio interface for
 gpiod
Message-ID: <202204291438.sh9ZA6U8-lkp@intel.com>
References: <YmsuDHwjUwxtjiyq@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YmsuDHwjUwxtjiyq@fedora>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Maíra,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on media-tree/master]
[also build test ERROR on v5.18-rc4 next-20220428]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Ma-ra-Canal/media-s5c73m3-replace-legacy-gpio-interface-for-gpiod/20220429-081656
base:   git://linuxtv.org/media_tree.git master
config: i386-randconfig-a003 (https://download.01.org/0day-ci/archive/20220429/202204291438.sh9ZA6U8-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.2.0-20) 11.2.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/427ae1b9cae644d199f9ffc260480dd1c32ec9d6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Ma-ra-Canal/media-s5c73m3-replace-legacy-gpio-interface-for-gpiod/20220429-081656
        git checkout 427ae1b9cae644d199f9ffc260480dd1c32ec9d6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/media/i2c/s5c73m3/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/media/i2c/s5c73m3/s5c73m3-core.c: In function 's5c73m3_gpio_assert':
>> drivers/media/i2c/s5c73m3/s5c73m3-core.c:1359:19: error: too few arguments to function 'gpiod_set_value'
    1359 |         int val = gpiod_set_value(gpio);
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/media/i2c/s5c73m3/s5c73m3-core.c:13:
   include/linux/gpio/consumer.h:119:6: note: declared here
     119 | void gpiod_set_value(struct gpio_desc *desc, int value);
         |      ^~~~~~~~~~~~~~~
   drivers/media/i2c/s5c73m3/s5c73m3-core.c: In function 's5c73m3_gpio_deassert':
   drivers/media/i2c/s5c73m3/s5c73m3-core.c:1366:19: error: too few arguments to function 'gpiod_set_value'
    1366 |         int val = gpiod_set_value(gpio);
         |                   ^~~~~~~~~~~~~~~
   In file included from drivers/media/i2c/s5c73m3/s5c73m3-core.c:13:
   include/linux/gpio/consumer.h:119:6: note: declared here
     119 | void gpiod_set_value(struct gpio_desc *desc, int value);
         |      ^~~~~~~~~~~~~~~


vim +/gpiod_set_value +1359 drivers/media/i2c/s5c73m3/s5c73m3-core.c

  1356	
  1357	static int s5c73m3_gpio_assert(struct gpio_desc *gpio)
  1358	{
> 1359		int val = gpiod_set_value(gpio);
  1360	
  1361		return s5c73m3_gpio_set_value(gpio, val);
  1362	}
  1363	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
