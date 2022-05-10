Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C00520E2A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237373AbiEJG4x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:56:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235052AbiEJG4t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:56:49 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C77F1A80B;
        Mon,  9 May 2022 23:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652165572; x=1683701572;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QSQrQETYh/pxV8qAHgktpIdb0RFfKPYxj6UqNQftZ3k=;
  b=ZTeJxjpSvZB8BNzu7kwQP+9KQVcJkeQrkdSybwEqVZsMEFv4Ho2VXSvt
   7vsYvFZsr+k2QQPXE+wDEWW7rdDbHTaeK/dmFMjwZwvQr1UZPvZrXUvDU
   +GSLk5cMWASvOT15YkYsIMzF19h2hR5rV8Gt42CvgvRzxW61F4PQ7ICmv
   NO92GqyOJ4NH50rsGo3IV5CkCS9Iew+WR+prm37AN7g4Zm8aliCr+H5ey
   jy47aV7UQ5gSSy7ni8UgkqvuZRH/XTMWPg/qtgMeAYt+ozkMPl61HzV6O
   LNrF7M7PSYno67KPcXCZ0l2AmCMK9gFST1sP2O5nVg2IOFU6HOali5sEB
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10342"; a="256821506"
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="256821506"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 May 2022 23:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,213,1647327600"; 
   d="scan'208";a="552658004"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 09 May 2022 23:52:48 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1noJjk-000HQo-6Z;
        Tue, 10 May 2022 06:52:48 +0000
Date:   Tue, 10 May 2022 14:51:57 +0800
From:   kernel test robot <lkp@intel.com>
To:     Sebastian Ene <sebastianene@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, maz@kernel.org, will@kernel.org,
        qperret@google.com, Guenter Roeck <linux@roeck-us.net>,
        Sebastian Ene <sebastianene@google.com>
Subject: Re: [PATCH v5 2/2] misc: Add a mechanism to detect stalls on guest
 vCPUs
Message-ID: <202205101453.rxj6blmH-lkp@intel.com>
References: <20220509091103.2220604-3-sebastianene@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220509091103.2220604-3-sebastianene@google.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on robh/for-next]
[also build test ERROR on char-misc/char-misc-testing soc/for-next v5.18-rc6 next-20220509]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Sebastian-Ene/Detect-stalls-on-guest-vCPUS/20220509-174959
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: sh-allmodconfig (https://download.01.org/0day-ci/archive/20220510/202205101453.rxj6blmH-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/d3152372fdd19448b32806c0bffd78d8729d02e4
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Sebastian-Ene/Detect-stalls-on-guest-vCPUS/20220509-174959
        git checkout d3152372fdd19448b32806c0bffd78d8729d02e4
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sh SHELL=/bin/bash drivers/misc/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/device/driver.h:21,
                    from include/linux/device.h:32,
                    from include/linux/node.h:18,
                    from include/linux/cpu.h:17,
                    from drivers/misc/vcpu_stall_detector.c:6:
>> drivers/misc/vcpu_stall_detector.c:203:25: error: 'vcpu_stall_detector_of_match' undeclared here (not in a function); did you mean 'vcpu_stall_detect_of_match'?
     203 | MODULE_DEVICE_TABLE(of, vcpu_stall_detector_of_match);
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/module.h:244:15: note: in definition of macro 'MODULE_DEVICE_TABLE'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |               ^~~~
>> include/linux/module.h:244:21: error: '__mod_of__vcpu_stall_detector_of_match_device_table' aliased to undefined symbol 'vcpu_stall_detector_of_match'
     244 | extern typeof(name) __mod_##type##__##name##_device_table               \
         |                     ^~~~~~
   drivers/misc/vcpu_stall_detector.c:203:1: note: in expansion of macro 'MODULE_DEVICE_TABLE'
     203 | MODULE_DEVICE_TABLE(of, vcpu_stall_detector_of_match);
         | ^~~~~~~~~~~~~~~~~~~


vim +203 drivers/misc/vcpu_stall_detector.c

   202	
 > 203	MODULE_DEVICE_TABLE(of, vcpu_stall_detector_of_match);
   204	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
