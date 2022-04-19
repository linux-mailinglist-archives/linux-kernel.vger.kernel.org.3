Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460A750719B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 17:24:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353787AbiDSP0z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 11:26:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232322AbiDSP0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 11:26:51 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8BB2A724
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 08:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650381846; x=1681917846;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4hchj7+XS8cIR8ILuo+p/7IgHIWuIRQ5IdE8F7pNmyc=;
  b=EVCUtGS6vjlHc6ZawVjsQA8BAHVCIPqnmbvzkL8H3V5bi0utaP86xTQ6
   1EL9U1HujEQAomuz3+bUl2U6Lzoy8PBPcFNu3drYX7vB/XI7G/3F7L1+V
   MA3mDYfviQo1qDD5N9EiZvr9wtbqrsgoOoisFRgu2U1GcaFRFdnB1e/wv
   CPw7TQbxavlXGmGXXxeBbXJMbMqqKPNgI+Uwk3FB8FZ9J/oIgMNF1d6jp
   MAUSiEq1I8Rr5R6/4LKjnwY1m8JsnX2q7JKwMU019edkaYUwfh/YmadJx
   1jvpb42slmi1N7Rt5KKYxr3vrvzg+5+HPHEO1uX5xXdwI2iR7NW8q2wVe
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10322"; a="288889500"
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="288889500"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 08:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,273,1643702400"; 
   d="scan'208";a="647297832"
Received: from lkp-server01.sh.intel.com (HELO 3abc53900bec) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 19 Apr 2022 08:24:03 -0700
Received: from kbuild by 3abc53900bec with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ngphy-0005u2-Oi;
        Tue, 19 Apr 2022 15:24:02 +0000
Date:   Tue, 19 Apr 2022 23:23:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     Russ Weight <russell.h.weight@intel.com>, mcgrof@kernel.org,
        rafael@kernel.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, trix@redhat.com, lgoncalv@redhat.com,
        yilun.xu@intel.com, hao.wu@intel.com,
        matthew.gerlach@linux.intel.com,
        basheer.ahmed.muddebihal@intel.com, tianfei.zhang@intel.com,
        Russ Weight <russell.h.weight@intel.com>
Subject: Re: [PATCH v3 4/8] firmware_loader: Add firmware-upload support
Message-ID: <202204192359.CTXNmgvX-lkp@intel.com>
References: <20220418223753.639058-5-russell.h.weight@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220418223753.639058-5-russell.h.weight@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

url:    https://github.com/intel-lab-lkp/linux/commits/Russ-Weight/Extend-FW-framework-for-user-FW-uploads/20220419-064126
base:   https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git 3123109284176b1532874591f7c81f3837bbdc17
config: parisc-randconfig-r033-20220419 (https://download.01.org/0day-ci/archive/20220419/202204192359.CTXNmgvX-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/827b02dbc9848fee497e3f3edbe6ff441cae32f6
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Russ-Weight/Extend-FW-framework-for-user-FW-uploads/20220419-064126
        git checkout 827b02dbc9848fee497e3f3edbe6ff441cae32f6
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross W=1 O=build_dir ARCH=parisc SHELL=/bin/bash drivers/base/firmware_loader/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/base/firmware_loader/sysfs.c:9:
   drivers/base/firmware_loader/sysfs.h: In function '__firmware_loading_timeout':
   drivers/base/firmware_loader/sysfs.h:78:34: error: invalid use of undefined type 'struct firmware_fallback_config'
      78 |         return fw_fallback_config.loading_timeout;
         |                                  ^
   drivers/base/firmware_loader/sysfs.h: In function '__fw_fallback_set_timeout':
   drivers/base/firmware_loader/sysfs.h:84:27: error: invalid use of undefined type 'struct firmware_fallback_config'
      84 |         fw_fallback_config.loading_timeout = timeout;
         |                           ^
   drivers/base/firmware_loader/sysfs.c: At top level:
>> drivers/base/firmware_loader/sysfs.c:113:5: error: redefinition of 'register_sysfs_loader'
     113 | int register_sysfs_loader(void)
         |     ^~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/sysfs.c:9:
   drivers/base/firmware_loader/sysfs.h:52:19: note: previous definition of 'register_sysfs_loader' with type 'int(void)'
      52 | static inline int register_sysfs_loader(void)
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
   drivers/base/firmware_loader/sysfs.h:57:20: note: previous definition of 'unregister_sysfs_loader' with type 'void(void)'
      57 | static inline void unregister_sysfs_loader(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/base/firmware_loader/sysfs.c: In function 'unregister_sysfs_loader':
>> drivers/base/firmware_loader/sysfs.c:124:9: error: implicit declaration of function 'unregister_firmware_config_sysctl' [-Werror=implicit-function-declaration]
     124 |         unregister_firmware_config_sysctl();
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/base/firmware_loader/sysfs.c:9:
   drivers/base/firmware_loader/sysfs.h: In function '__firmware_loading_timeout':
   drivers/base/firmware_loader/sysfs.h:79:1: error: control reaches end of non-void function [-Werror=return-type]
      79 | }
         | ^
   cc1: some warnings being treated as errors


vim +/register_sysfs_loader +113 drivers/base/firmware_loader/sysfs.c

7fb618c8a43c63 Russ Weight 2022-04-18  112  
7fb618c8a43c63 Russ Weight 2022-04-18 @113  int register_sysfs_loader(void)
7fb618c8a43c63 Russ Weight 2022-04-18  114  {
7fb618c8a43c63 Russ Weight 2022-04-18  115  	int ret = class_register(&firmware_class);
7fb618c8a43c63 Russ Weight 2022-04-18  116  
7fb618c8a43c63 Russ Weight 2022-04-18  117  	if (ret != 0)
7fb618c8a43c63 Russ Weight 2022-04-18  118  		return ret;
7fb618c8a43c63 Russ Weight 2022-04-18 @119  	return register_firmware_config_sysctl();
7fb618c8a43c63 Russ Weight 2022-04-18  120  }
7fb618c8a43c63 Russ Weight 2022-04-18  121  
7fb618c8a43c63 Russ Weight 2022-04-18 @122  void unregister_sysfs_loader(void)
7fb618c8a43c63 Russ Weight 2022-04-18  123  {
7fb618c8a43c63 Russ Weight 2022-04-18 @124  	unregister_firmware_config_sysctl();
7fb618c8a43c63 Russ Weight 2022-04-18  125  	class_unregister(&firmware_class);
7fb618c8a43c63 Russ Weight 2022-04-18  126  }
7fb618c8a43c63 Russ Weight 2022-04-18  127  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
