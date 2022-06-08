Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E733543EED
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 23:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233312AbiFHV7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 17:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236502AbiFHV7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 17:59:09 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A313730F58;
        Wed,  8 Jun 2022 14:59:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654725546; x=1686261546;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9sQzl6uLZ++JKW0s/2tdSFlOCMjYJ8IqYgci9qqlTp8=;
  b=hD7X9pA/kz7xBwqwFx6/woo/qP38I0QOVMscA7l8BVpT85HfxtS83kD9
   rUZp0yINGatLdU8AXBnL1++JA5qZ9i6+GWnmsbxBBuYdE3FFcrfzKZcNU
   YBrGpIKCtdMof14t3le6u8W9JI/H46gseagLTGlS6yDCvISG2PP9LV7+H
   ODef3j4PM0eem988+4X/ESn34TKY4wEZIp4nURyiOxuQUMU8JBvAnKakk
   13tJutC1t/gy3B6Uv0H4Sgjgw9oJJ58/86PqYihGQEDrINsQm28j+J0aw
   JjVdEGn8ERcZxn/n1vl2KYwUHsVQd2q5eEKVpGldMPHHrxyCUibKXel1D
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="260201201"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="260201201"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 14:59:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="907919919"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 08 Jun 2022 14:59:04 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nz3hf-000F9r-KL;
        Wed, 08 Jun 2022 21:59:03 +0000
Date:   Thu, 9 Jun 2022 05:59:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mark Brown <broonie@kernel.org>, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1 1/1] spi: Replace match_true() by device_match_any()
Message-ID: <202206090531.0eWVAe0k-lkp@intel.com>
References: <20220607190601.47363-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220607190601.47363-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on broonie-spi/for-next]
[also build test ERROR on v5.19-rc1 next-20220608]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andy-Shevchenko/spi-Replace-match_true-by-device_match_any/20220608-091910
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/spi.git for-next
config: x86_64-randconfig-a013 (https://download.01.org/0day-ci/archive/20220609/202206090531.0eWVAe0k-lkp@intel.com/config)
compiler: gcc-11 (Debian 11.3.0-3) 11.3.0
reproduce (this is a W=1 build):
        # https://github.com/intel-lab-lkp/linux/commit/bbdbed23cc6f2f8e7c9d8da3bb6c78fe488747f1
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andy-Shevchenko/spi-Replace-match_true-by-device_match_any/20220608-091910
        git checkout bbdbed23cc6f2f8e7c9d8da3bb6c78fe488747f1
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/spi/spi.c: In function 'slave_show':
>> drivers/spi/spi.c:2670:53: error: passing argument 3 of 'device_find_child' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2670 |         child = device_find_child(&ctlr->dev, NULL, device_match_any);
         |                                                     ^~~~~~~~~~~~~~~~
         |                                                     |
         |                                                     int (*)(struct device *, const void *)
   In file included from drivers/spi/spi.c:8:
   include/linux/device.h:905:40: note: expected 'int (*)(struct device *, void *)' but argument is of type 'int (*)(struct device *, const void *)'
     905 |                                  int (*match)(struct device *dev, void *data));
         |                                  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/spi/spi.c: In function 'slave_store':
   drivers/spi/spi.c:2689:53: error: passing argument 3 of 'device_find_child' from incompatible pointer type [-Werror=incompatible-pointer-types]
    2689 |         child = device_find_child(&ctlr->dev, NULL, device_match_any);
         |                                                     ^~~~~~~~~~~~~~~~
         |                                                     |
         |                                                     int (*)(struct device *, const void *)
   In file included from drivers/spi/spi.c:8:
   include/linux/device.h:905:40: note: expected 'int (*)(struct device *, void *)' but argument is of type 'int (*)(struct device *, const void *)'
     905 |                                  int (*match)(struct device *dev, void *data));
         |                                  ~~~~~~^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/device_find_child +2670 drivers/spi/spi.c

  2662	
  2663	static ssize_t slave_show(struct device *dev, struct device_attribute *attr,
  2664				  char *buf)
  2665	{
  2666		struct spi_controller *ctlr = container_of(dev, struct spi_controller,
  2667							   dev);
  2668		struct device *child;
  2669	
> 2670		child = device_find_child(&ctlr->dev, NULL, device_match_any);
  2671		return sprintf(buf, "%s\n",
  2672			       child ? to_spi_device(child)->modalias : NULL);
  2673	}
  2674	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
