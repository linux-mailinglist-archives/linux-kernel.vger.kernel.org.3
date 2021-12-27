Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD15C47FC8C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Dec 2021 13:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236627AbhL0MT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Dec 2021 07:19:26 -0500
Received: from mga07.intel.com ([134.134.136.100]:41447 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236615AbhL0MTX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Dec 2021 07:19:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1640607563; x=1672143563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ua1yW5wIKaV/7/cJgZ22aiptC0ketXaQ8sCqM1TMBq0=;
  b=IlFRS+xcJA0BcMadB6xMFzdv5VJ2dxWOTG2qpUx32LRp7yiAzyHB0J0B
   1FP0gyvp1mckvkNOoC3lQ8PfNIBfG2flDPAteStkwZHuC99cdMvuTv3W+
   Hem+SY+Bc5Jo1nNUfmfbinHhpjeXRR83rSZQiSL/BtXpsg45YVwmnxUeH
   XgxFVlmohDQXzuutfJK+1NVaad1wsksExM7e46jVJImTdHkBE2iBZzvTr
   +0zmRrxup3DPNtiGujOdoRdof0g0egAL0pGrVm2jRoagjYcXxrpp13xcg
   SpB89CakgaqemhWUQJ8sixMh/A23+KBX7qN3zurMFtF9kaBDdv0dXnOho
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10209"; a="304562162"
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="304562162"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Dec 2021 04:19:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,239,1635231600"; 
   d="scan'208";a="686260210"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 27 Dec 2021 04:19:19 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n1oyE-0006GK-Pj; Mon, 27 Dec 2021 12:19:18 +0000
Date:   Mon, 27 Dec 2021 20:18:58 +0800
From:   kernel test robot <lkp@intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>, kernel@pengutronix.de,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        linux-iio@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 13/23] counter: Provide alternative counter
 registration functions
Message-ID: <202112272054.WsrEZBF1-lkp@intel.com>
References: <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211227094526.698714-14-u.kleine-koenig@pengutronix.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi "Uwe,

I love your patch! Perhaps something to improve:

[auto build test WARNING on a7904a538933c525096ca2ccde1e60d0ee62c08e]

url:    https://github.com/0day-ci/linux/commits/Uwe-Kleine-K-nig/counter-cleanups-and-device-lifetime-fixes/20211227-174815
base:   a7904a538933c525096ca2ccde1e60d0ee62c08e
config: i386-randconfig-r006-20211227 (https://download.01.org/0day-ci/archive/20211227/202112272054.WsrEZBF1-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 511726c64d3b6cca66f7c54d457d586aa3129f67)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/250e0e3d91caea9f7c61652a7a9a8c006b2464be
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Uwe-Kleine-K-nig/counter-cleanups-and-device-lifetime-fixes/20211227-174815
        git checkout 250e0e3d91caea9f7c61652a7a9a8c006b2464be
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/counter/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/counter/counter-core.c:175:41: warning: variable 'id' is uninitialized when used here [-Wuninitialized]
           dev->devt = MKDEV(MAJOR(counter_devt), id);
                                                  ^~
   include/linux/kdev_t.h:12:46: note: expanded from macro 'MKDEV'
   #define MKDEV(ma,mi)    (((ma) << MINORBITS) | (mi))
                                                   ^~
   drivers/counter/counter-core.c:149:8: note: initialize the variable 'id' to silence this warning
           int id, err;
                 ^
                  = 0
   1 warning generated.


vim +/id +175 drivers/counter/counter-core.c

   134	
   135	/**
   136	 * counter_alloc - allocate a counter_device
   137	 * @sizeof_priv: size of the driver private data
   138	 *
   139	 * This is part one of counter registration. The structure is allocated
   140	 * dynamically to ensure the right lifetime for the embedded struct device.
   141	 *
   142	 * If this succeeds, call counter_put() to get rid of the counter_device again.
   143	 */
   144	struct counter_device *counter_alloc(size_t sizeof_priv)
   145	{
   146		struct counter_device_allochelper *ch;
   147		struct counter_device *counter;
   148		struct device *dev;
   149		int id, err;
   150	
   151		ch = kzalloc(sizeof(*ch) + sizeof_priv, GFP_KERNEL);
   152		if (!ch) {
   153			err = -ENOMEM;
   154			goto err_alloc_ch;
   155		}
   156	
   157		counter = &ch->counter;
   158		dev = &counter->dev;
   159	
   160		/* Acquire unique ID */
   161		err = ida_alloc(&counter_ida, GFP_KERNEL);
   162		if (err < 0) {
   163			goto err_ida_alloc;
   164		}
   165		dev->id = err;
   166	
   167		err = counter_chrdev_add(counter);
   168		if (err < 0)
   169			goto err_chrdev_add;
   170	
   171		device_initialize(dev);
   172		/* Configure device structure for Counter */
   173		dev->type = &counter_device_type;
   174		dev->bus = &counter_bus_type;
 > 175		dev->devt = MKDEV(MAJOR(counter_devt), id);
   176	
   177		mutex_init(&counter->ops_exist_lock);
   178	
   179		return counter;
   180	
   181	err_chrdev_add:
   182	
   183		ida_free(&counter_ida, dev->id);
   184	err_ida_alloc:
   185	
   186		kfree(ch);
   187	err_alloc_ch:
   188	
   189		return ERR_PTR(err);
   190	}
   191	EXPORT_SYMBOL_GPL(counter_alloc);
   192	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
