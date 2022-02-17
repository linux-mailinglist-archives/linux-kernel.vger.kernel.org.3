Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D96A4BA2F7
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 15:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241575AbiBQO3b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 09:29:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiBQO32 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 09:29:28 -0500
Received: from mga06.intel.com (mga06.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FE212B167D;
        Thu, 17 Feb 2022 06:29:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645108154; x=1676644154;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=+R1AK/gkRyoYr+8UNtwo0B5YbNI0hu+NA3H6Pu/+d1c=;
  b=loA/krPHMJXzFmSTthy/MKwV7mebxl8rZIibsxOvXARcZQBUswmV8FTA
   9ggiAjMIRB+d4+VVNpc8pbWxywdlQYDqB6q8s39fnk+Zcw7/n1OlPyfif
   VjDfWCaCAjCwpOr+CQJGEglOQVqCw7EZWjWpGGB2ppfqCE77IaIq1Kyeh
   QJcDJMzCm4TAFQviS7nA7g6p42h6f4oqGzjjMVWqWi5+Tmeae9Fdspr+z
   xDZtVO6pfV2saQH1SJJZI9ngYy2QNuNwTwiOWB4f46g0yWaYI4RccELUQ
   xYht6MwbhgRZpygt8qfm1t3IutFk/rym8VuMzmY+GyVOKVzUHYoO0V1vf
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10260"; a="311627099"
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="311627099"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 06:29:14 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,376,1635231600"; 
   d="scan'208";a="488309143"
Received: from lkp-server01.sh.intel.com (HELO 6f05bf9e3301) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 17 Feb 2022 06:28:51 -0800
Received: from kbuild by 6f05bf9e3301 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nKhm6-0000Gj-SC; Thu, 17 Feb 2022 14:28:50 +0000
Date:   Thu, 17 Feb 2022 22:28:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>
Subject: Re: [PATCH v1 3/3] hwmon (xdpe12284): Add regulator support
Message-ID: <202202172254.TL5ZxxMO-lkp@intel.com>
References: <6c8a38efa0b61e3ba8de023f56f59043b99e5947.1645088804.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6c8a38efa0b61e3ba8de023f56f59043b99e5947.1645088804.git.sylv@sylv.io>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marcello,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on groeck-staging/hwmon-next]
[also build test WARNING on robh/for-next linux/master linus/master v5.17-rc4 next-20220217]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Marcello-Sylvester-Bauer/Support-XDPE112/20220217-172831
base:   https://git.kernel.org/pub/scm/linux/kernel/git/groeck/linux-staging.git hwmon-next
config: s390-randconfig-r044-20220217 (https://download.01.org/0day-ci/archive/20220217/202202172254.TL5ZxxMO-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d271fc04d5b97b12e6b797c6067d3c96a8d7470e)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install s390 cross compiling tool for clang build
        # apt-get install binutils-s390x-linux-gnu
        # https://github.com/0day-ci/linux/commit/7d607e48fd68499470da6630cff4d23f43f29aa9
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Marcello-Sylvester-Bauer/Support-XDPE112/20220217-172831
        git checkout 7d607e48fd68499470da6630cff4d23f43f29aa9
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=s390 SHELL=/bin/bash drivers/hwmon/pmbus/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/hwmon/pmbus/xdpe12284.c:125:36: warning: unused variable 'xdpe122_reg_desc' [-Wunused-const-variable]
   static const struct regulator_desc xdpe122_reg_desc[] = {
                                      ^
   1 warning generated.


vim +/xdpe122_reg_desc +125 drivers/hwmon/pmbus/xdpe12284.c

   124	
 > 125	static const struct regulator_desc xdpe122_reg_desc[] = {
   126		PMBUS_REGULATOR("vout", 0),
   127		PMBUS_REGULATOR("vout", 1),
   128	};
   129	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
