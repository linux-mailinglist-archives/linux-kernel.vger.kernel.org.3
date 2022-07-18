Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A0F0578800
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 19:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235393AbiGRRBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 13:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbiGRRBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 13:01:35 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DC3A23174
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 10:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1658163694; x=1689699694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bLYKFp3oUU8vZo014Mj7dHJUSBqY47hJWKYA+okcUBw=;
  b=eggHc1/qXLH1rngcY9wXhjT1+JCHgeZQ402uPwplqfamp/aDn98HyuLl
   OMmPP4ZKnvUZQho1uYim4Q7gRu551zXqUsuN07jelqihehAGHFwMbyo4A
   1hYJqVWnMmQlHfv44rYHwkFmisXirZO+sRFMpfyRjr8efR8r9e0U34U/Q
   mXfBOQI1h4eRZcvrTBIFEQKrmn44NbmnK5wUy2NmoEUEIZwCLVOMs24wz
   mWBPE3PO0KyMfkmedwvfHisbujzkh7b7sDExsHcRVqdOYmht/NAkNSLwh
   yztQbe4oFj8yew4uQY905DJbnZ3ZkFuNC6A4jnCiGMDyXM1HKlXs/NdJ0
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10412"; a="347960349"
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="347960349"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2022 10:01:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,281,1650956400"; 
   d="scan'208";a="547571277"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 18 Jul 2022 10:01:31 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oDU7f-0004aQ-6R;
        Mon, 18 Jul 2022 17:01:31 +0000
Date:   Tue, 19 Jul 2022 01:00:40 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xu Qiang <xuqiang36@huawei.com>, maz@kernel.org, tglx@linutronix.de
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        xuqiang36@huawei.com, rui.xiang@huawei.com
Subject: Re: [PATCH -next 2/2] irqdomain: Replace revmap_direct_max_irq field
 with hwirq_max field
Message-ID: <202207190020.iGdy9c8j-lkp@intel.com>
References: <20220718130759.67777-3-xuqiang36@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220718130759.67777-3-xuqiang36@huawei.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xu,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220718]

url:    https://github.com/intel-lab-lkp/linux/commits/Xu-Qiang/Fix-a-bug-and-commit-a-code-optimization/20220718-211349
base:    036ad6daa8f0fd357af7f50f9da58539eaa6f68c
config: powerpc-allyesconfig (https://download.01.org/0day-ci/archive/20220719/202207190020.iGdy9c8j-lkp@intel.com/config)
compiler: powerpc-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/36d8f25dc578d22517f40deeb705f0a9e1817a42
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xu-Qiang/Fix-a-bug-and-commit-a-code-optimization/20220718-211349
        git checkout 36d8f25dc578d22517f40deeb705f0a9e1817a42
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=powerpc SHELL=/bin/bash kernel/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   In file included from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from include/linux/irqdomain.h:35,
                    from include/linux/acpi.h:13,
                    from kernel/irq/irqdomain.c:5:
   kernel/irq/irqdomain.c: In function 'irq_create_direct_mapping':
>> include/linux/kern_levels.h:5:25: warning: format '%i' expects argument of type 'int', but argument 2 has type 'irq_hw_number_t' {aka 'long unsigned int'} [-Wformat=]
       5 | #define KERN_SOH        "\001"          /* ASCII Start Of Header */
         |                         ^~~~~~
   include/linux/printk.h:436:25: note: in definition of macro 'printk_index_wrap'
     436 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
         |                         ^~~~
   include/linux/printk.h:507:9: note: in expansion of macro 'printk'
     507 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~
   include/linux/kern_levels.h:11:25: note: in expansion of macro 'KERN_SOH'
      11 | #define KERN_ERR        KERN_SOH "3"    /* error conditions */
         |                         ^~~~~~~~
   include/linux/printk.h:507:16: note: in expansion of macro 'KERN_ERR'
     507 |         printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
         |                ^~~~~~~~
   kernel/irq/irqdomain.c:654:17: note: in expansion of macro 'pr_err'
     654 |                 pr_err("ERROR: no free irqs available below %i maximum\n",
         |                 ^~~~~~
   kernel/irq/irqdomain.c: At top level:
   kernel/irq/irqdomain.c:1921:13: warning: no previous prototype for 'irq_domain_debugfs_init' [-Wmissing-prototypes]
    1921 | void __init irq_domain_debugfs_init(struct dentry *root)
         |             ^~~~~~~~~~~~~~~~~~~~~~~


vim +5 include/linux/kern_levels.h

314ba3520e513a Joe Perches 2012-07-30  4  
04d2c8c83d0e3a Joe Perches 2012-07-30 @5  #define KERN_SOH	"\001"		/* ASCII Start Of Header */
04d2c8c83d0e3a Joe Perches 2012-07-30  6  #define KERN_SOH_ASCII	'\001'
04d2c8c83d0e3a Joe Perches 2012-07-30  7  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
