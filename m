Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCC47585B7F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 20:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235489AbiG3SH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 14:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiG3SHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 14:07:22 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BD01572B;
        Sat, 30 Jul 2022 11:07:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659204441; x=1690740441;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GfUPPhycW67KQMvN9iRt1mPvqrm/d/0T+G/wECkqerA=;
  b=UaMqhtHsRmTfceraarqP8LkwWqBRpH0bK6AuAKJZ6Dlv6EDtlQWSCqJq
   RspOITB1nNIC5EOfrErxmEjeok8HPIra9b1xT3JTIQ6S9DOunkygUtvqY
   XyEbP0VUIxtbrHp6w12gZ+GrfgFYYFkc/0zmZyYl9FdHAKO0y9KX1lRxC
   zpVGf5zcV2MN6jsHh1DZPKPi1VgtTQwIEv3FtZIilOIRhV5oI+HHlh9In
   Hby+kJPxJY6OIieKXbOfWzxhgWgzfTTpD7b8Hd4b5drR1WPn0NRSLeOnw
   LHbj4+SYjZgJy26i16agy84xToQ5F7e/Lk44Q3DUQicP/6fZ/JufKNtRm
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10424"; a="269318653"
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="269318653"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 11:07:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,204,1654585200"; 
   d="scan'208";a="552071485"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 30 Jul 2022 11:07:17 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oHqrs-000D3H-2h;
        Sat, 30 Jul 2022 18:07:16 +0000
Date:   Sun, 31 Jul 2022 02:06:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-media@vger.kernel.org, Yong Zhi <yong.zhi@intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>,
        Dan Scally <djrscally@gmail.com>,
        Tianshu Qiu <tian.shu.qiu@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] media: ipu3-cio2: Don't dereference fwnode handle
Message-ID: <202207310216.JtYAKodB-lkp@intel.com>
References: <20220730154844.89556-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220730154844.89556-1-andriy.shevchenko@linux.intel.com>
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

[auto build test ERROR on media-tree/master]
[also build test ERROR on linus/master v5.19-rc8 next-20220728]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/media-ipu3-cio2-Don-t-dereference-fwnode-handle/20220730-235023
base:   git://linuxtv.org/media_tree.git master
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220731/202207310216.JtYAKodB-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 52cd00cabf479aa7eb6dbb063b7ba41ea57bce9e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/a78ba0da9d77a8fa412604492f931b188e1114d5
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/media-ipu3-cio2-Don-t-dereference-fwnode-handle/20220730-235023
        git checkout a78ba0da9d77a8fa412604492f931b188e1114d5
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/media/pci/intel/ipu3/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/media/pci/intel/ipu3/cio2-bridge.c:266:33: error: a function declaration without a prototype is deprecated in all versions of C [-Werror,-Wstrict-prototypes]
           struct fwnode_handle *fwnode, *current;
                                          ^
   arch/x86/include/asm/current.h:18:28: note: expanded from macro 'current'
   #define current get_current()
                              ^
>> drivers/media/pci/intel/ipu3/cio2-bridge.c:266:33: error: conflicting types for 'get_current'
   arch/x86/include/asm/current.h:18:17: note: expanded from macro 'current'
   #define current get_current()
                   ^
   arch/x86/include/asm/current.h:13:44: note: previous definition is here
   static __always_inline struct task_struct *get_current(void)
                                              ^
   2 errors generated.


vim +266 drivers/media/pci/intel/ipu3/cio2-bridge.c

   261	
   262	static int cio2_bridge_connect_sensor(const struct cio2_sensor_config *cfg,
   263					      struct cio2_bridge *bridge,
   264					      struct pci_dev *cio2)
   265	{
 > 266		struct fwnode_handle *fwnode, *current;
   267		struct cio2_sensor *sensor;
   268		struct acpi_device *adev;
   269		acpi_status status;
   270		int ret;
   271	
   272		for_each_acpi_dev_match(adev, cfg->hid, NULL, -1) {
   273			if (!adev->status.enabled)
   274				continue;
   275	
   276			if (bridge->n_sensors >= CIO2_NUM_PORTS) {
   277				acpi_dev_put(adev);
   278				dev_err(&cio2->dev, "Exceeded available CIO2 ports\n");
   279				return -EINVAL;
   280			}
   281	
   282			sensor = &bridge->sensors[bridge->n_sensors];
   283			strscpy(sensor->name, cfg->hid, sizeof(sensor->name));
   284	
   285			ret = cio2_bridge_read_acpi_buffer(adev, "SSDB",
   286							   &sensor->ssdb,
   287							   sizeof(sensor->ssdb));
   288			if (ret)
   289				goto err_put_adev;
   290	
   291			if (sensor->ssdb.vcmtype > ARRAY_SIZE(cio2_vcm_types)) {
   292				dev_warn(&adev->dev, "Unknown VCM type %d\n",
   293					 sensor->ssdb.vcmtype);
   294				sensor->ssdb.vcmtype = 0;
   295			}
   296	
   297			status = acpi_get_physical_device_location(adev->handle, &sensor->pld);
   298			if (ACPI_FAILURE(status)) {
   299				ret = -ENODEV;
   300				goto err_put_adev;
   301			}
   302	
   303			if (sensor->ssdb.lanes > CIO2_MAX_LANES) {
   304				dev_err(&adev->dev,
   305					"Number of lanes in SSDB is invalid\n");
   306				ret = -EINVAL;
   307				goto err_free_pld;
   308			}
   309	
   310			cio2_bridge_create_fwnode_properties(sensor, bridge, cfg);
   311			cio2_bridge_create_connection_swnodes(bridge, sensor);
   312	
   313			ret = software_node_register_nodes(sensor->swnodes);
   314			if (ret)
   315				goto err_free_pld;
   316	
   317			fwnode = software_node_fwnode(&sensor->swnodes[
   318							      SWNODE_SENSOR_HID]);
   319			if (!fwnode) {
   320				ret = -ENODEV;
   321				goto err_free_swnodes;
   322			}
   323	
   324			sensor->adev = acpi_dev_get(adev);
   325	
   326			current = acpi_fwnode_handle(adev);
   327			current->secondary = fwnode;
   328	
   329			cio2_bridge_instantiate_vcm_i2c_client(sensor);
   330	
   331			dev_info(&cio2->dev, "Found supported sensor %s\n",
   332				 acpi_dev_name(adev));
   333	
   334			bridge->n_sensors++;
   335		}
   336	
   337		return 0;
   338	
   339	err_free_swnodes:
   340		software_node_unregister_nodes(sensor->swnodes);
   341	err_free_pld:
   342		ACPI_FREE(sensor->pld);
   343	err_put_adev:
   344		acpi_dev_put(adev);
   345		return ret;
   346	}
   347	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
