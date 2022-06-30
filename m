Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E93256270E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231430AbiF3X2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:28:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232923AbiF3X22 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:28:28 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13C26251;
        Thu, 30 Jun 2022 16:28:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656631697; x=1688167697;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=RM88QkoXYJlc9UBUy307/BtPhtlC+Z2vGnV2YkjHYkI=;
  b=XbNJCVghKX82ZZE6BJYL+thL/5UXrtBQZXwoGiUybuR7O7YVqylBUto+
   7qI09CUVzO5/tB2h2CrSAahq6Ruf7ybjgU6umMHY1m3k3weH6Plr14xXF
   PUZBAc0zWGKqcwPfGt5of2Egjq7YdoxWJC5s2bYD5acZvhVZoMzaAvbMG
   2hl+PjXSTIw4J/PYqotNHTxR+nWT2eNTKYzU7CLO+MtsIS34qFNkK37LK
   AAgGsr0pUnPR40igiud8HnyRnsOv/qpRIjuY6dAlPVux4IVnH8K/X6ua1
   RIK1daCWtTqDMd4Bu8Ci5o1zhWKc6LT/E6Pb/0xh0WWae5Q3O00OtiqUl
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="368811212"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="368811212"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 16:28:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="837807180"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 30 Jun 2022 16:28:15 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o73a2-000DIm-RL;
        Thu, 30 Jun 2022 23:28:14 +0000
Date:   Fri, 1 Jul 2022 07:28:09 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Corentin Chary <corentin.chary@gmail.com>,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86: asus-wireless: Replace open coded
 acpi_match_device()
Message-ID: <202207010744.ugH4lnF8-lkp@intel.com>
References: <20220630193234.3499-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630193234.3499-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.19-rc4 next-20220630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/platform-x86-asus-wireless-Replace-open-coded-acpi_match_device/20220701-033501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1a0e93df1e107dc766fdf86ae88076efd9f376e6
config: x86_64-randconfig-a003 (https://download.01.org/0day-ci/archive/20220701/202207010744.ugH4lnF8-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a774ba7f60d1fef403b5507b1b1a7475d3684d71)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6aca63018deba5520de593749517efd03f7289c7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/platform-x86-asus-wireless-Replace-open-coded-acpi_match_device/20220701-033501
        git checkout 6aca63018deba5520de593749517efd03f7289c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/platform/x86/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/platform/x86/asus-wireless.c:151:25: error: incompatible pointer types passing 'struct acpi_device *' to parameter of type 'const struct acpi_device_id *' [-Werror,-Wincompatible-pointer-types]
           id = acpi_match_device(adev, device_ids);
                                  ^~~~
   include/linux/acpi.h:713:77: note: passing argument to parameter 'ids' here
   const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
                                                                               ^
>> drivers/platform/x86/asus-wireless.c:151:31: error: incompatible pointer types passing 'const struct acpi_device_id[3]' to parameter of type 'const struct device *' [-Werror,-Wincompatible-pointer-types]
           id = acpi_match_device(adev, device_ids);
                                        ^~~~~~~~~~
   include/linux/acpi.h:714:34: note: passing argument to parameter 'dev' here
                                                  const struct device *dev);
                                                                       ^
   2 errors generated.


vim +151 drivers/platform/x86/asus-wireless.c

   125	
   126	static int asus_wireless_add(struct acpi_device *adev)
   127	{
   128		struct asus_wireless_data *data;
   129		const struct acpi_device_id *id;
   130		int err;
   131	
   132		data = devm_kzalloc(&adev->dev, sizeof(*data), GFP_KERNEL);
   133		if (!data)
   134			return -ENOMEM;
   135		adev->driver_data = data;
   136		data->adev = adev;
   137	
   138		data->idev = devm_input_allocate_device(&adev->dev);
   139		if (!data->idev)
   140			return -ENOMEM;
   141		data->idev->name = "Asus Wireless Radio Control";
   142		data->idev->phys = "asus-wireless/input0";
   143		data->idev->id.bustype = BUS_HOST;
   144		data->idev->id.vendor = PCI_VENDOR_ID_ASUSTEK;
   145		set_bit(EV_KEY, data->idev->evbit);
   146		set_bit(KEY_RFKILL, data->idev->keybit);
   147		err = input_register_device(data->idev);
   148		if (err)
   149			return err;
   150	
 > 151		id = acpi_match_device(adev, device_ids);
   152		if (id)
   153			data->hswc_params = (const struct hswc_params *)id->driver_data;
   154		if (!data->hswc_params)
   155			return 0;
   156	
   157		data->wq = create_singlethread_workqueue("asus_wireless_workqueue");
   158		if (!data->wq)
   159			return -ENOMEM;
   160		INIT_WORK(&data->led_work, led_state_update);
   161		data->led.name = "asus-wireless::airplane";
   162		data->led.brightness_set = led_state_set;
   163		data->led.brightness_get = led_state_get;
   164		data->led.flags = LED_CORE_SUSPENDRESUME;
   165		data->led.max_brightness = 1;
   166		data->led.default_trigger = "rfkill-none";
   167		err = devm_led_classdev_register(&adev->dev, &data->led);
   168		if (err)
   169			destroy_workqueue(data->wq);
   170	
   171		return err;
   172	}
   173	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
