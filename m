Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9D71511A82
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237861AbiD0O3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 10:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237809AbiD0O3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 10:29:10 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF38D29F;
        Wed, 27 Apr 2022 07:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651069559; x=1682605559;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gFU2R6wlf2Alrac6+LofoISZC2O4Ez0lIBWYeC9XB9g=;
  b=WVcSJKpfLInMzj+J2mpYZp1GKmQd64GUvUiegaUHOvDGVQhTlU4sB922
   EulcWciIRTOfCVNI8urtp+UOjILGdJ9turE5zuGYwDvxTQGLmoYPboULm
   w0TKhtV3NpWVJyxXIwJYatTqD22cIGPcmGo6cGKLxz3jjNgUC2QhTjsHs
   S0qkYiIt9hys0QLfnotFjQ9II5Yzl/oMbSOWfNPK/GgoWbjmK2t/Uju3z
   kxNqSZpqF/JHUsGpwua5R7/FPpqMXQuxzx1/VRUY/sGGGBbGLCIiY9QgV
   yGRY/teIR9DjMf+DUvvINdHkRDkEiDgifeIOkTUZ17osego3QtuHLBWo1
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="326435323"
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="326435323"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2022 07:25:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,293,1643702400"; 
   d="scan'208";a="650724525"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Apr 2022 07:25:29 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njibh-0004i6-7n;
        Wed, 27 Apr 2022 14:25:29 +0000
Date:   Wed, 27 Apr 2022 22:24:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrea Merello <andrea.merello@gmail.com>, jic23@kernel.org,
        mchehab+huawei@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc:     kbuild-all@lists.01.org, lars@metafoo.de, robh+dt@kernel.org,
        andy.shevchenko@gmail.com, matt.ranostay@konsulko.com,
        ardeleanalex@gmail.com, jacopo@jmondi.org,
        Andrea Merello <andrea.merello@iit.it>
Subject: Re: [v5 12/14] iio: imu: add BNO055 serdev driver
Message-ID: <202204272204.zqCIf1KV-lkp@intel.com>
References: <20220426131102.23966-13-andrea.merello@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220426131102.23966-13-andrea.merello@gmail.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrea,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on jic23-iio/togreg]
[also build test WARNING on linus/master linux/master v5.18-rc4 next-20220427]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220426-212132
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git togreg
config: alpha-randconfig-r036-20220427 (https://download.01.org/0day-ci/archive/20220427/202204272204.zqCIf1KV-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/675ca9cd13af45cc5943dd15caad5e866fd7c971
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Andrea-Merello/Add-support-for-Bosch-BNO055-IMU/20220426-212132
        git checkout 675ca9cd13af45cc5943dd15caad5e866fd7c971
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/iio/imu/bno055/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/iio/imu/bno055/bno055.c:1317:5: warning: no previous prototype for 'bno055_debugfs_reg_access' [-Wmissing-prototypes]
    1317 | int bno055_debugfs_reg_access(struct iio_dev *iio_dev, unsigned int reg,
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~


vim +/bno055_debugfs_reg_access +1317 drivers/iio/imu/bno055/bno055.c

2f40e22369ed70 Andrea Merello 2022-04-26  1316  
2f40e22369ed70 Andrea Merello 2022-04-26 @1317  int bno055_debugfs_reg_access(struct iio_dev *iio_dev, unsigned int reg,
2f40e22369ed70 Andrea Merello 2022-04-26  1318  			      unsigned int writeval, unsigned int *readval)
2f40e22369ed70 Andrea Merello 2022-04-26  1319  {
2f40e22369ed70 Andrea Merello 2022-04-26  1320  	return 0;
2f40e22369ed70 Andrea Merello 2022-04-26  1321  }
2f40e22369ed70 Andrea Merello 2022-04-26  1322  #endif
2f40e22369ed70 Andrea Merello 2022-04-26  1323  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
