Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AE714BEF70
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 03:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238736AbiBVB4R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 20:56:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbiBVB4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 20:56:15 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A35325C4E;
        Mon, 21 Feb 2022 17:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645494951; x=1677030951;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=yIlI+25tyG/Vgfdvj/+Z7mkc94N2K7PKODOan4K5Vwg=;
  b=KWa1yI0kHqUHsPCRsjUbU3iCerzVZ01/0VKJrlK29rhM0ZFE1qoKYcem
   pqGw3ucslgZ28JuqboXMx3xB75F2GIa076Zg5edSesJ/1K7Owp1mFNs+c
   gsCzEFIH0NOTj/e5lfKvWzRT+PJbKj2Iov8sat7cf1oqkOCWuR+HVZLHs
   tgNK5Jp6WeI+P1F9YXxUoDb6EzXF6aTkDVRFZkRzmE/vSCfMqobWH1Lbx
   UzRsdZHTxmwqZnqrU0PR2ZN0TMvL58wI75T2/EoN92Kta0Rvn+Tzby7NQ
   jxI852ezSXD9uagJU4t/WECxS1lJPjkeJFNZmHiWjwwfp0PeNgA3HkFSE
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10265"; a="314855488"
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="314855488"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2022 17:55:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,387,1635231600"; 
   d="scan'208";a="490605584"
Received: from lkp-server01.sh.intel.com (HELO da3212ac2f54) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 21 Feb 2022 17:55:48 -0800
Received: from kbuild by da3212ac2f54 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nMKP5-0002DE-Vn; Tue, 22 Feb 2022 01:55:47 +0000
Date:   Tue, 22 Feb 2022 09:54:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH v1 1/8] iio: accel: adxl345: Convert to use
 dev_err_probe()
Message-ID: <202202220906.kb1l5tzA-lkp@intel.com>
References: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220221233235.86893-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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

[auto build test ERROR on jic23-iio/togreg]
[also build test ERROR on v5.17-rc5 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/iio-accel-adxl345-Convert-to-use-dev_err_probe/20220222-073422
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: i386-randconfig-a014-20220221 (https://download.01.org/0day-ci/archive/20220222/202202220906.kb1l5tzA-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/078715303e0289150d8a286c885fd2b493e36a22
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Andy-Shevchenko/iio-accel-adxl345-Convert-to-use-dev_err_probe/20220222-073422
        git checkout 078715303e0289150d8a286c885fd2b493e36a22
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash drivers/iio/accel/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iio/accel/adxl345_i2c.c:32:25: error: use of undeclared identifier 'spi'
                   return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
                                         ^
   1 error generated.


vim +/spi +32 drivers/iio/accel/adxl345_i2c.c

    21	
    22	static int adxl345_i2c_probe(struct i2c_client *client,
    23				     const struct i2c_device_id *id)
    24	{
    25		struct regmap *regmap;
    26	
    27		if (!id)
    28			return -ENODEV;
    29	
    30		regmap = devm_regmap_init_i2c(client, &adxl345_i2c_regmap_config);
    31		if (IS_ERR(regmap))
  > 32			return dev_err_probe(&spi->dev, PTR_ERR(regmap), "Error initializing regmap\n");
    33	
    34		return adxl345_core_probe(&client->dev, regmap, id->driver_data,
    35					  id->name);
    36	}
    37	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
