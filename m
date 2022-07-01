Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C801A56293B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 04:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233173AbiGACl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 22:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGAClY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 22:41:24 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20CC161D74;
        Thu, 30 Jun 2022 19:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656643284; x=1688179284;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cuXtyuc6n20ZOjsoEeqH1Vdkgg49coTwCulu5IRtGGA=;
  b=VwiveSV2xMYelsd4AfFhCM72RuR25MUvRpJX0FpRvnEI9rLGYnEIK+8F
   8XA4TCX0AmicZPxLN7l1ybiuodHb/UB9xMzb0HdstG6AMkxDpUPF1u1R9
   JSA6vi7PHX8uRu85+PSd3n3RxQsiDpfvA02dCv1+sTggjSolrsEDXWNWv
   RiXKU6lqY8azkDAHdNQwCF8+JyHks4wF3BfyQ96bZu/nWhsqwLs+fFWeG
   O1+w1fgvvQOwT1mKYkYlqVWTQ77UjZyKB9LTnJznNJetab4tghkwTUEtf
   Clqo57mNjJ7XlcKBpxDL9OoOmkPV1TNICTe3q6LP//JSMeQCFfI6a4f0s
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="271305292"
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="271305292"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 19:41:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,236,1650956400"; 
   d="scan'208";a="541571656"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Jun 2022 19:41:21 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o76au-000DRs-TN;
        Fri, 01 Jul 2022 02:41:20 +0000
Date:   Fri, 1 Jul 2022 10:40:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        acpi4asus-user@lists.sourceforge.net,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Corentin Chary <corentin.chary@gmail.com>,
        =?iso-8859-1?Q?Jo=E3o?= Paulo Rechi Vita <jprvita@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86: asus-wireless: Replace open coded
 acpi_match_device()
Message-ID: <202207011023.rVF5wXVl-lkp@intel.com>
References: <20220630193234.3499-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630193234.3499-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on platform-drivers-x86/for-next v5.19-rc4 next-20220630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/platform-x86-asus-wireless-Replace-open-coded-acpi_match_device/20220701-033501
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1a0e93df1e107dc766fdf86ae88076efd9f376e6
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220701/202207011023.rVF5wXVl-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/6aca63018deba5520de593749517efd03f7289c7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/platform-x86-asus-wireless-Replace-open-coded-acpi_match_device/20220701-033501
        git checkout 6aca63018deba5520de593749517efd03f7289c7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/platform/x86/asus-wireless.c: In function 'asus_wireless_add':
>> drivers/platform/x86/asus-wireless.c:151:32: error: passing argument 1 of 'acpi_match_device' from incompatible pointer type [-Werror=incompatible-pointer-types]
     151 |         id = acpi_match_device(adev, device_ids);
         |                                ^~~~
         |                                |
         |                                struct acpi_device *
   In file included from drivers/platform/x86/asus-wireless.c:12:
   include/linux/acpi.h:713:77: note: expected 'const struct acpi_device_id *' but argument is of type 'struct acpi_device *'
     713 | const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
         |                                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/platform/x86/asus-wireless.c:151:38: error: passing argument 2 of 'acpi_match_device' from incompatible pointer type [-Werror=incompatible-pointer-types]
     151 |         id = acpi_match_device(adev, device_ids);
         |                                      ^~~~~~~~~~
         |                                      |
         |                                      const struct acpi_device_id *
   In file included from drivers/platform/x86/asus-wireless.c:12:
   include/linux/acpi.h:714:69: note: expected 'const struct device *' but argument is of type 'const struct acpi_device_id *'
     714 |                                                const struct device *dev);
         |                                                ~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/acpi_match_device +151 drivers/platform/x86/asus-wireless.c

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
