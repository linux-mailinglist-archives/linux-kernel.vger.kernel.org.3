Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D121B5097B7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 08:37:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384928AbiDUGgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 02:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351139AbiDUGft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 02:35:49 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D87413F4F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 23:32:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650522772; x=1682058772;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9BN+5/gRilYRA5GXVcxvfMJkC3SPAaCFfzoFOtk+W7w=;
  b=IwVt78Na2jmf5Xa51cabiR7r31M+pLH6dscnXanRAIneYyDdO6ju2yTJ
   PQO9ztenpDW1pgfBZvImA92D5TJwIUJcawe2QGOb12qTRMY/0Mg5Bww33
   S0pPxY+epp05gsgwjI47nAa5NIJiO9LI37xmpct7+uXrm9ZHWeI7MGU2V
   7KvqJIGtMd0/H+dUbkXMNn7Vp1sweuJMvedvI+0sjSqQ8dLowrYHlKJ9h
   Q4/U9mYpnJIM1e33wPf3PHiWtDqinfIjYBEDggwVRv1hTSD+RSvtWMHSR
   Mxu0Q7wlUA5cfvB0Xpmgg1z15eXC/F2GTauzWaTR2b3d03o/tIx8sXkFb
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="264020402"
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="264020402"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Apr 2022 23:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,277,1643702400"; 
   d="scan'208";a="532784354"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 20 Apr 2022 23:32:48 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nhQMy-0007wL-7s;
        Thu, 21 Apr 2022 06:32:48 +0000
Date:   Thu, 21 Apr 2022 14:32:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>, mcgrof@kernel.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v4 4/8] firmware_loader: Add firmware-upload support
Message-ID: <202204201956.1mdJkUkr-lkp@intel.com>
References: <20220419231658.664388-5-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220419231658.664388-5-russell.h.weight@intel.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Russ,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on driver-core/driver-core-testing]
[also build test ERROR on shuah-kselftest/next mcgrof/sysctl-next linus/master v5.18-rc3 next-20220419]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Russ-Weight/Extend-FW-framework-for-user-FW-uploads/20220420-071906
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 3123109284176b1532874591f7c81f3837bbdc17
config: parisc-buildonly-randconfig-r006-20220420 (https://download.01.org/0day-ci/archive/20220420/202204201956.1mdJkUkr-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/9280379c623309746315a540c66b7bbcc980b32e
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Russ-Weight/Extend-FW-framework-for-user-FW-uploads/20220420-071906
        git checkout 9280379c623309746315a540c66b7bbcc980b32e
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/base/ drivers/scsi/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/base/firmware_loader/sysfs.c:113:5: error: redefinition of 'register_sysfs_loader'
     113 | int register_sysfs_loader(void)
         |     ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/sysfs.c:9:
   drivers/base/firmware_loader/sysfs.h:64:19: note: previous definition of 'register_sysfs_loader' with type 'int(void)'
      64 | static inline int register_sysfs_loader(void)
         |                   ^~~~~~~~~~~~~~~~~~~~~
   drivers/base/firmware_loader/sysfs.c: In function 'register_sysfs_loader':
>> drivers/base/firmware_loader/sysfs.c:119:16: error: implicit declaration of function 'register_firmware_config_sysctl' [-Werror=implicit-function-declaration]
     119 |         return register_firmware_config_sysctl();
         |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/firmware_loader/sysfs.c: At top level:
>> drivers/base/firmware_loader/sysfs.c:122:6: error: redefinition of 'unregister_sysfs_loader'
     122 | void unregister_sysfs_loader(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/sysfs.c:9:
   drivers/base/firmware_loader/sysfs.h:69:20: note: previous definition of 'unregister_sysfs_loader' with type 'void(void)'
      69 | static inline void unregister_sysfs_loader(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/firmware_loader/sysfs.c: In function 'unregister_sysfs_loader':
>> drivers/base/firmware_loader/sysfs.c:124:9: error: implicit declaration of function 'unregister_firmware_config_sysctl' [-Werror=implicit-function-declaration]
     124 |         unregister_firmware_config_sysctl();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors


vim +/register_sysfs_loader +113 drivers/base/firmware_loader/sysfs.c

cafe6fbc6b8a99 Russ Weight 2022-04-19  112  
cafe6fbc6b8a99 Russ Weight 2022-04-19 @113  int register_sysfs_loader(void)
cafe6fbc6b8a99 Russ Weight 2022-04-19  114  {
cafe6fbc6b8a99 Russ Weight 2022-04-19  115  	int ret = class_register(&firmware_class);
cafe6fbc6b8a99 Russ Weight 2022-04-19  116  
cafe6fbc6b8a99 Russ Weight 2022-04-19  117  	if (ret != 0)
cafe6fbc6b8a99 Russ Weight 2022-04-19  118  		return ret;
cafe6fbc6b8a99 Russ Weight 2022-04-19 @119  	return register_firmware_config_sysctl();
cafe6fbc6b8a99 Russ Weight 2022-04-19  120  }
cafe6fbc6b8a99 Russ Weight 2022-04-19  121  
cafe6fbc6b8a99 Russ Weight 2022-04-19 @122  void unregister_sysfs_loader(void)
cafe6fbc6b8a99 Russ Weight 2022-04-19  123  {
cafe6fbc6b8a99 Russ Weight 2022-04-19 @124  	unregister_firmware_config_sysctl();
cafe6fbc6b8a99 Russ Weight 2022-04-19  125  	class_unregister(&firmware_class);
cafe6fbc6b8a99 Russ Weight 2022-04-19  126  }
cafe6fbc6b8a99 Russ Weight 2022-04-19  127  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
