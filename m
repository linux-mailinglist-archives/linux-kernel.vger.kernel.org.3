Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 258F5562730
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 01:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbiF3Xjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 19:39:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbiF3Xjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 19:39:35 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF7C44A3D;
        Thu, 30 Jun 2022 16:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1656632371; x=1688168371;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=H8bgZ+uEdAR13rHlQ7GEu31r9VcarJF71rZdrWzV2Fg=;
  b=b7+2wmS827+9TLkpPQZRbdqh/3a7/z3h0Sq7OLgLssNxy28nnfUsclgl
   +dQha2e9jKD/K7OKN8f6eQpBUUuwa214o80fzM8H7D3CEFjlhHpl62zMH
   a1HsR5tqIzw2DnlKuKJ6OHovpfo5pROR1Zn5of1hHdEN5rPA0HqXyndK5
   0y0e/ndNoQPB815K2yFy4434YeFj/YmulfG1KsZUaYP+tOTc6ETiHM1LS
   +acgEo1MDcnH8tljs5npy5jQyV00lLBz7nJ3lpn5QESZNzQXoeRUMviJ2
   fncbmizryQ4XOzJNkbu6ALIGb62WIZMykNAebpwElschaQv83aNNJy7qW
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10394"; a="346487033"
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="346487033"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 16:39:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,235,1650956400"; 
   d="scan'208";a="918251538"
Received: from lkp-server01.sh.intel.com (HELO 68b931ab7ac1) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 30 Jun 2022 16:39:15 -0700
Received: from kbuild by 68b931ab7ac1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o73kh-000DJO-6z;
        Thu, 30 Jun 2022 23:39:15 +0000
Date:   Fri, 1 Jul 2022 07:38:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>
Subject: Re: [PATCH v1 1/1] platform/x86: xo15-ebook: Replace open coded
 acpi_match_device()
Message-ID: <202207010755.roKVlMYX-lkp@intel.com>
References: <20220630194335.3730-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220630194335.3730-1-andriy.shevchenko@linux.intel.com>
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
[also build test ERROR on platform-drivers-x86/for-next v5.19-rc4 next-20220630]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/platform-x86-xo15-ebook-Replace-open-coded-acpi_match_device/20220701-034437
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 1a0e93df1e107dc766fdf86ae88076efd9f376e6
config: i386-allyesconfig (https://download.01.org/0day-ci/archive/20220701/202207010755.roKVlMYX-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/5b5e8dde0af27d441c9249e4b6a2710c125d0b65
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/platform-x86-xo15-ebook-Replace-open-coded-acpi_match_device/20220701-034437
        git checkout 5b5e8dde0af27d441c9249e4b6a2710c125d0b65
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/platform/x86/xo15-ebook.c: In function 'ebook_switch_add':
>> drivers/platform/x86/xo15-ebook.c:105:32: error: passing argument 1 of 'acpi_match_device' from incompatible pointer type [-Werror=incompatible-pointer-types]
     105 |         id = acpi_match_device(device, ebook_device_ids);
         |                                ^~~~~~
         |                                |
         |                                struct acpi_device *
   In file included from drivers/platform/x86/xo15-ebook.c:17:
   include/linux/acpi.h:713:77: note: expected 'const struct acpi_device_id *' but argument is of type 'struct acpi_device *'
     713 | const struct acpi_device_id *acpi_match_device(const struct acpi_device_id *ids,
         |                                                ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
   drivers/platform/x86/xo15-ebook.c:105:40: error: passing argument 2 of 'acpi_match_device' from incompatible pointer type [-Werror=incompatible-pointer-types]
     105 |         id = acpi_match_device(device, ebook_device_ids);
         |                                        ^~~~~~~~~~~~~~~~
         |                                        |
         |                                        const struct acpi_device_id *
   In file included from drivers/platform/x86/xo15-ebook.c:17:
   include/linux/acpi.h:714:69: note: expected 'const struct device *' but argument is of type 'const struct acpi_device_id *'
     714 |                                                const struct device *dev);
         |                                                ~~~~~~~~~~~~~~~~~~~~~^~~
   cc1: some warnings being treated as errors


vim +/acpi_match_device +105 drivers/platform/x86/xo15-ebook.c

    81	
    82	static int ebook_switch_add(struct acpi_device *device)
    83	{
    84		const struct acpi_device_id *id;
    85		struct ebook_switch *button;
    86		struct input_dev *input;
    87		char *name, *class;
    88		int error;
    89	
    90		button = kzalloc(sizeof(struct ebook_switch), GFP_KERNEL);
    91		if (!button)
    92			return -ENOMEM;
    93	
    94		device->driver_data = button;
    95	
    96		button->input = input = input_allocate_device();
    97		if (!input) {
    98			error = -ENOMEM;
    99			goto err_free_button;
   100		}
   101	
   102		name = acpi_device_name(device);
   103		class = acpi_device_class(device);
   104	
 > 105		id = acpi_match_device(device, ebook_device_ids);
   106		if (!id) {
   107			dev_err(&device->dev, "Unsupported hid\n");
   108			error = -ENODEV;
   109			goto err_free_input;
   110		}
   111	
   112		strcpy(name, XO15_EBOOK_DEVICE_NAME);
   113		sprintf(class, "%s/%s", XO15_EBOOK_CLASS, XO15_EBOOK_SUBCLASS);
   114	
   115		snprintf(button->phys, sizeof(button->phys), "%s/button/input0", id->id);
   116	
   117		input->name = name;
   118		input->phys = button->phys;
   119		input->id.bustype = BUS_HOST;
   120		input->dev.parent = &device->dev;
   121	
   122		input->evbit[0] = BIT_MASK(EV_SW);
   123		set_bit(SW_TABLET_MODE, input->swbit);
   124	
   125		error = input_register_device(input);
   126		if (error)
   127			goto err_free_input;
   128	
   129		ebook_send_state(device);
   130	
   131		if (device->wakeup.flags.valid) {
   132			/* Button's GPE is run-wake GPE */
   133			acpi_enable_gpe(device->wakeup.gpe_device,
   134					device->wakeup.gpe_number);
   135			device_set_wakeup_enable(&device->dev, true);
   136		}
   137	
   138		return 0;
   139	
   140	 err_free_input:
   141		input_free_device(input);
   142	 err_free_button:
   143		kfree(button);
   144		return error;
   145	}
   146	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
