Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B767A538C5A
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 09:57:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244694AbiEaH5P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 03:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244670AbiEaH5H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 03:57:07 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A415F20183;
        Tue, 31 May 2022 00:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653983825; x=1685519825;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2qo+vdNeMZC+dPSZPwxzeS8DLwk8VHCFX0R27WGhj4U=;
  b=acx/ZqFC9ykVRx6wnvcaOKWtX0fyPhYcZt+hlz2xE+7cOSGD01/k0I4E
   OnxCFgQQ3c/29aN71kdDHh3a51oo5I7bpm5jXLYS9qYAoQUH4OfBC/A/P
   9hA6ppqO5zUkKOpEEVI4E1t2sDey2Z5r5SZVZY3Yirp1GLyXcCSV+Ehew
   b2zH1XWvwblvkmIPG+PVf5+mwYul9f61C03zQIiaFSfnukNNi5S6piKaU
   gfY8qupLwtLjZpKBpVaVPRmPPRrXG4u4zUX3spqrVMTerPWddpiOwdM1j
   vb/HoVpgE04Soy/8jPhZSRpjs5OxbC4jcJxf17TGMUhml2vzsJ3YYeOMA
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10363"; a="274900605"
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="274900605"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 00:57:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,264,1647327600"; 
   d="scan'208";a="903864894"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2022 00:57:02 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nvwkQ-0002Uk-9z;
        Tue, 31 May 2022 07:57:02 +0000
Date:   Tue, 31 May 2022 15:56:59 +0800
From:   kernel test robot <lkp@intel.com>
To:     Cosmin Tanislav <demonsingur@gmail.com>
Cc:     kbuild-all@lists.01.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Cosmin Tanislav <cosmin.tanislav@analog.com>
Subject: Re: [PATCH 4/4] serial: max310x: implement I2C support
Message-ID: <202205311555.lv5uAjEN-lkp@intel.com>
References: <20220530221429.1248083-4-demonsingur@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220530221429.1248083-4-demonsingur@gmail.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cosmin,

I love your patch! Yet something to improve:

[auto build test ERROR on tty/tty-testing]
[also build test ERROR on usb/usb-testing v5.18 next-20220531]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Cosmin-Tanislav/serial-max310x-use-regmap-methods-for-SPI-batch-operations/20220531-061619
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/tty.git tty-testing
config: openrisc-randconfig-c023-20220531 (https://download.01.org/0day-ci/archive/20220531/202205311555.lv5uAjEN-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/6c293b95fc5654df5353ba273a9bbd08f1cd3f3a
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Cosmin-Tanislav/serial-max310x-use-regmap-methods-for-SPI-batch-operations/20220531-061619
        git checkout 6c293b95fc5654df5353ba273a9bbd08f1cd3f3a
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=openrisc SHELL=/bin/bash drivers/tty/serial/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

   drivers/tty/serial/max310x.c: In function 'max310x_i2c_probe':
>> drivers/tty/serial/max310x.c:1603:31: error: implicit declaration of function 'devm_i2c_new_dummy_device' [-Werror=implicit-function-declaration]
    1603 |                 port_client = devm_i2c_new_dummy_device(&client->dev,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/tty/serial/max310x.c:1603:29: warning: assignment to 'struct i2c_client *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
    1603 |                 port_client = devm_i2c_new_dummy_device(&client->dev,
         |                             ^
   drivers/tty/serial/max310x.c: In function 'max310x_uart_init':
   drivers/tty/serial/max310x.c:1658:1: warning: label 'err_i2c_register' defined but not used [-Wunused-label]
    1658 | err_i2c_register:
         | ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/devm_i2c_new_dummy_device +1603 drivers/tty/serial/max310x.c

  1582	
  1583	static int max310x_i2c_probe(struct i2c_client *client)
  1584	{
  1585		const struct max310x_devtype *devtype =
  1586				device_get_match_data(&client->dev);
  1587		struct i2c_client *port_client;
  1588		struct regmap *regmaps[4];
  1589		unsigned int i;
  1590		u8 port_addr;
  1591	
  1592		if (client->addr < devtype->slave_addr.min ||
  1593			client->addr > devtype->slave_addr.max)
  1594			return dev_err_probe(&client->dev, -EINVAL,
  1595					     "Slave addr 0x%x outside of range [0x%x, 0x%x]\n",
  1596					     client->addr, devtype->slave_addr.min,
  1597					     devtype->slave_addr.max);
  1598	
  1599		regmaps[0] = devm_regmap_init_i2c(client, &regcfg_i2c);
  1600	
  1601		for (i = 1; i < devtype->nr; i++) {
  1602			port_addr = max310x_i2c_slave_addr(client->addr, i);
> 1603			port_client = devm_i2c_new_dummy_device(&client->dev,
  1604								client->adapter,
  1605								port_addr);
  1606	
  1607			regmaps[i] = devm_regmap_init_i2c(port_client, &regcfg_i2c);
  1608		}
  1609	
  1610		return max310x_probe(&client->dev, devtype, &max310x_i2c_if_cfg,
  1611				     regmaps, client->irq);
  1612	}
  1613	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
