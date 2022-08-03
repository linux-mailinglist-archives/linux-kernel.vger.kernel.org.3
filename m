Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D986588BEA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 14:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237743AbiHCMWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 08:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236097AbiHCMWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 08:22:10 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B33D13D5B;
        Wed,  3 Aug 2022 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659529329; x=1691065329;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5vBF8Ok5lBg7xULP4o1v53TnQYulqo1ZFvofkSMmRTc=;
  b=nnrcFwt7L/ki9Xf9CAQEpVl0vsHdAGWIRCGu7F1GcbUMRPLsMuwNHwLO
   yoxgtyR54ga04dLUo86/WQH0uya+qiqJa1/zeERmJOJEeV93sD9TAYlXZ
   qArm7nR0thDseZ1ccEty5chNhk+fZotpFvHawrFUOxkFhNSS5Olxs9ciR
   lelkF50xV+vGYFFSwGEPOdf59rsMmedMkMhzmZwZ8v6NXKhRVTZFFXDaa
   zmH/0uQOehUr61atC+bJG05/pDQtmW5qZwQfEI1gKUWvHMRYLDgVQxc/M
   Jq9y6nPfpCmz8GB9X0CGAdzVA47oo5DhvHw0Zj7hzYIFZtV84hQZMN17O
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="276571622"
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="276571622"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 05:22:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,214,1654585200"; 
   d="scan'208";a="553301867"
Received: from lkp-server01.sh.intel.com (HELO e0eace57cfef) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 03 Aug 2022 05:22:05 -0700
Received: from kbuild by e0eace57cfef with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oJDO1-000HFb-0I;
        Wed, 03 Aug 2022 12:22:05 +0000
Date:   Wed, 3 Aug 2022 20:21:42 +0800
From:   kernel test robot <lkp@intel.com>
To:     Eddie James <eajames@linux.ibm.com>, joel@jms.id.au
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, linux@roeck-us.net,
        jdelvare@suse.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-kernel@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-fsi@lists.ozlabs.org,
        devicetree@vger.kernel.org, Eddie James <eajames@linux.ibm.com>
Subject: Re: [PATCH 3/3] hwmon: (occ) Check for device property for setting
 OCC active during probe
Message-ID: <202208032055.PEvfcqsc-lkp@intel.com>
References: <20220802194656.240564-4-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220802194656.240564-4-eajames@linux.ibm.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Eddie,

I love your patch! Yet something to improve:

[auto build test ERROR on next-20220728]
[also build test ERROR on v5.19]
[cannot apply to groeck-staging/hwmon-next linus/master v5.19 v5.19-rc8 v5.19-rc7]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Eddie-James/occ-Restore-default-behavior-of-polling-OCC-during-init/20220803-034854
base:    7c5e07b73ff3011c9b82d4a3286a3362b951ad2b
config: arm-randconfig-r021-20220803 (https://download.01.org/0day-ci/archive/20220803/202208032055.PEvfcqsc-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project 495519e5f8232d144ed26e9c18dbcbac6a5f25eb)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm cross compiling tool for clang build
        # apt-get install binutils-arm-linux-gnueabi
        # https://github.com/intel-lab-lkp/linux/commit/31dc5bad51ddf22f4e097c0c5862d14341708188
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Eddie-James/occ-Restore-default-behavior-of-polling-OCC-during-init/20220803-034854
        git checkout 31dc5bad51ddf22f4e097c0c5862d14341708188
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm SHELL=/bin/bash drivers/hwmon/occ/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/hwmon/occ/p9_sbe.c:188:25: error: use of undeclared identifier 'p8_i2c_occ_of_match'; did you mean 'p9_sbe_occ_of_match'?
   MODULE_DEVICE_TABLE(of, p8_i2c_occ_of_match);
                           ^~~~~~~~~~~~~~~~~~~
                           p9_sbe_occ_of_match
   include/linux/module.h:244:15: note: expanded from macro 'MODULE_DEVICE_TABLE'
   extern typeof(name) __mod_##type##__##name##_device_table               \
                 ^
   drivers/hwmon/occ/p9_sbe.c:183:34: note: 'p9_sbe_occ_of_match' declared here
   static const struct of_device_id p9_sbe_occ_of_match[] = {
                                    ^
   1 error generated.


vim +188 drivers/hwmon/occ/p9_sbe.c

   182	
   183	static const struct of_device_id p9_sbe_occ_of_match[] = {
   184		{ .compatible = "ibm,p9-occ-hwmon" },
   185		{ .compatible = "ibm,p10-occ-hwmon" },
   186		{}
   187	};
 > 188	MODULE_DEVICE_TABLE(of, p8_i2c_occ_of_match);
   189	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
