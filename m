Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF5C3533A04
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:37:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiEYJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238145AbiEYJhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:37:03 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B884A45D;
        Wed, 25 May 2022 02:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653471413; x=1685007413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=atA+t4suhXgFuNJREMrpllGc91gbbjodM87F/9TfOsE=;
  b=nOXJTFDmkBlzSZO7RMfqfwne1KB8tZoYGZQSGDTUIyfz+o6wnG1aEDpL
   wnEk2vzbC33QJAgqHLO/sziyePyUIHuVByJwvKoBc7Iuy6hstZhKbNVa0
   9EKWub2D2TiGiQQqwi6B4CPaZSfOUPiRKHc6OjIhpBuE7FLmQqGHDHvvA
   aZKJvVMYGvRp0goLsasSbrm/hoYRM67OHPM1bKSgbMzzyE4bpdkB6Xvue
   IQkKQgJLH5ZK4kKmfaSdyrzNlpdk5y+vsgsDTKCt/6qz8at/ieWne2xlu
   2PExfYil5dNA7poNC/7Nqs07hqH7bKR245Z6jqGQh6vV4L17HXaYKEyjF
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="336821050"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="336821050"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 May 2022 02:36:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="609047945"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 25 May 2022 02:36:49 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntnRh-0002vC-7K;
        Wed, 25 May 2022 09:36:49 +0000
Date:   Wed, 25 May 2022 17:36:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Message-ID: <202205251708.q7cwjpF8-lkp@intel.com>
References: <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nobuhiro,

I love your patch! Yet something to improve:

[auto build test ERROR on joro-iommu/next]
[also build test ERROR on arm-perf/for-next/perf soc/for-next linus/master v5.18 next-20220524]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nobuhiro-Iwamatsu/Add-Visconti5-IOMMU-driver/20220525-093326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220525/202205251708.q7cwjpF8-lkp@intel.com/config)
compiler: alpha-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/69bb4f3c2ef0bb1f65922bc72bb31109897a6393
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nobuhiro-Iwamatsu/Add-Visconti5-IOMMU-driver/20220525-093326
        git checkout 69bb4f3c2ef0bb1f65922bc72bb31109897a6393
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

Note: the linux-review/Nobuhiro-Iwamatsu/Add-Visconti5-IOMMU-driver/20220525-093326 HEAD 07739c72b066c0781c371eec7614ed876441e8dd builds fine.
      It only hurts bisectability.

All errors (new ones prefixed by >>):

>> drivers/iommu/visconti-atu.c:47:29: error: field 'iommu' has incomplete type
      47 |         struct iommu_device iommu;
         |                             ^~~~~
>> drivers/iommu/visconti-atu.c:62:29: error: field 'io_domain' has incomplete type
      62 |         struct iommu_domain io_domain;
         |                             ^~~~~~~~~
   In file included from include/linux/bits.h:22,
                    from include/linux/ratelimit_types.h:5,
                    from include/linux/ratelimit.h:5,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/iommu/visconti-atu.c:12:
   drivers/iommu/visconti-atu.c: In function 'to_atu_domain':
   include/linux/compiler_types.h:293:27: error: expression in static assertion is not an integer
     293 | #define __same_type(a, b) __builtin_types_compatible_p(typeof(a), typeof(b))
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/build_bug.h:78:56: note: in definition of macro '__static_assert'
      78 | #define __static_assert(expr, msg, ...) _Static_assert(expr, msg)
         |                                                        ^~~~
   include/linux/container_of.h:19:9: note: in expansion of macro 'static_assert'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |         ^~~~~~~~~~~~~
   include/linux/container_of.h:19:23: note: in expansion of macro '__same_type'
      19 |         static_assert(__same_type(*(ptr), ((type *)0)->member) ||       \
         |                       ^~~~~~~~~~~
   drivers/iommu/visconti-atu.c:70:16: note: in expansion of macro 'container_of'
      70 |         return container_of(domain, struct visconti_atu_domain, io_domain);
         |                ^~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_attach_device':
>> drivers/iommu/visconti-atu.c:121:43: error: implicit declaration of function 'dev_iommu_priv_get' [-Werror=implicit-function-declaration]
     121 |         struct visconti_atu_device *atu = dev_iommu_priv_get(dev);
         |                                           ^~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:121:43: warning: initialization of 'struct visconti_atu_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_detach_device':
   drivers/iommu/visconti-atu.c:150:43: warning: initialization of 'struct visconti_atu_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     150 |         struct visconti_atu_device *atu = dev_iommu_priv_get(dev);
         |                                           ^~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: At top level:
   drivers/iommu/visconti-atu.c:196:41: warning: 'struct iommu_iotlb_gather' declared inside parameter list will not be visible outside of this definition or declaration
     196 |                                  struct iommu_iotlb_gather *iotlb_gather)
         |                                         ^~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_of_xlate':
>> drivers/iommu/visconti-atu.c:262:17: error: implicit declaration of function 'dev_iommu_priv_set' [-Werror=implicit-function-declaration]
     262 |                 dev_iommu_priv_set(dev, platform_get_drvdata(pdev));
         |                 ^~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_domain_alloc':
>> drivers/iommu/visconti-atu.c:273:21: error: 'IOMMU_DOMAIN_UNMANAGED' undeclared (first use in this function)
     273 |         if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
         |                     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:273:21: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/iommu/visconti-atu.c:273:55: error: 'IOMMU_DOMAIN_DMA' undeclared (first use in this function)
     273 |         if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
         |                                                       ^~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_probe_device':
>> drivers/iommu/visconti-atu.c:298:39: error: implicit declaration of function 'dev_iommu_fwspec_get' [-Werror=implicit-function-declaration]
     298 |         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
         |                                       ^~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:298:39: warning: initialization of 'struct iommu_fwspec *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
>> drivers/iommu/visconti-atu.c:301:30: error: invalid use of undefined type 'struct iommu_fwspec'
     301 |         if (!fwspec || fwspec->ops != &visconti_atu_ops)
         |                              ^~
   drivers/iommu/visconti-atu.c:304:13: warning: assignment to 'struct visconti_atu_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     304 |         atu = dev_iommu_priv_get(dev);
         |             ^
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_release_device':
   drivers/iommu/visconti-atu.c:310:43: warning: initialization of 'struct visconti_atu_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     310 |         struct visconti_atu_device *atu = dev_iommu_priv_get(dev);
         |                                           ^~~~~~~~~~~~~~~~~~
>> drivers/iommu/visconti-atu.c:315:9: error: implicit declaration of function 'iommu_fwspec_free' [-Werror=implicit-function-declaration]
     315 |         iommu_fwspec_free(dev);
         |         ^~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: At top level:
>> drivers/iommu/visconti-atu.c:318:21: error: variable 'visconti_atu_ops' has initializer but incomplete type
     318 | static const struct iommu_ops visconti_atu_ops = {
         |                     ^~~~~~~~~
>> drivers/iommu/visconti-atu.c:319:10: error: 'const struct iommu_ops' has no member named 'domain_alloc'
     319 |         .domain_alloc = visconti_atu_domain_alloc,
         |          ^~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:319:25: warning: excess elements in struct initializer
     319 |         .domain_alloc = visconti_atu_domain_alloc,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:319:25: note: (near initialization for 'visconti_atu_ops')
>> drivers/iommu/visconti-atu.c:320:10: error: 'const struct iommu_ops' has no member named 'probe_device'
     320 |         .probe_device = visconti_atu_probe_device,
         |          ^~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:320:25: warning: excess elements in struct initializer
     320 |         .probe_device = visconti_atu_probe_device,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:320:25: note: (near initialization for 'visconti_atu_ops')
>> drivers/iommu/visconti-atu.c:321:10: error: 'const struct iommu_ops' has no member named 'release_device'
     321 |         .release_device = visconti_atu_release_device,
         |          ^~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:321:27: warning: excess elements in struct initializer
     321 |         .release_device = visconti_atu_release_device,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:321:27: note: (near initialization for 'visconti_atu_ops')
>> drivers/iommu/visconti-atu.c:322:10: error: 'const struct iommu_ops' has no member named 'device_group'
     322 |         .device_group = generic_device_group,
         |          ^~~~~~~~~~~~
>> drivers/iommu/visconti-atu.c:322:25: error: 'generic_device_group' undeclared here (not in a function)
     322 |         .device_group = generic_device_group,
         |                         ^~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:322:25: warning: excess elements in struct initializer
   drivers/iommu/visconti-atu.c:322:25: note: (near initialization for 'visconti_atu_ops')
>> drivers/iommu/visconti-atu.c:323:10: error: 'const struct iommu_ops' has no member named 'of_xlate'
     323 |         .of_xlate = visconti_atu_of_xlate,
         |          ^~~~~~~~
   drivers/iommu/visconti-atu.c:323:21: warning: excess elements in struct initializer
     323 |         .of_xlate = visconti_atu_of_xlate,
         |                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:323:21: note: (near initialization for 'visconti_atu_ops')
>> drivers/iommu/visconti-atu.c:324:10: error: 'const struct iommu_ops' has no member named 'pgsize_bitmap'
     324 |         .pgsize_bitmap = ATU_IOMMU_PGSIZE_BITMAP,
         |          ^~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:41:33: warning: excess elements in struct initializer
      41 | #define ATU_IOMMU_PGSIZE_BITMAP 0x7ffff000 /* SZ_1G - SZ_4K */
         |                                 ^~~~~~~~~~
   drivers/iommu/visconti-atu.c:324:26: note: in expansion of macro 'ATU_IOMMU_PGSIZE_BITMAP'
     324 |         .pgsize_bitmap = ATU_IOMMU_PGSIZE_BITMAP,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:41:33: note: (near initialization for 'visconti_atu_ops')
      41 | #define ATU_IOMMU_PGSIZE_BITMAP 0x7ffff000 /* SZ_1G - SZ_4K */
         |                                 ^~~~~~~~~~
   drivers/iommu/visconti-atu.c:324:26: note: in expansion of macro 'ATU_IOMMU_PGSIZE_BITMAP'
     324 |         .pgsize_bitmap = ATU_IOMMU_PGSIZE_BITMAP,
         |                          ^~~~~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/visconti-atu.c:325:10: error: 'const struct iommu_ops' has no member named 'default_domain_ops'
     325 |         .default_domain_ops = &(const struct iommu_domain_ops) {
         |          ^~~~~~~~~~~~~~~~~~
>> drivers/iommu/visconti-atu.c:326:18: error: 'const struct iommu_domain_ops' has no member named 'attach_dev'
     326 |                 .attach_dev = visconti_atu_attach_device,
         |                  ^~~~~~~~~~
   drivers/iommu/visconti-atu.c:326:31: warning: excess elements in struct initializer
     326 |                 .attach_dev = visconti_atu_attach_device,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:326:31: note: (near initialization for '(anonymous)')
>> drivers/iommu/visconti-atu.c:327:18: error: 'const struct iommu_domain_ops' has no member named 'detach_dev'
     327 |                 .detach_dev = visconti_atu_detach_device,
         |                  ^~~~~~~~~~
   drivers/iommu/visconti-atu.c:327:31: warning: excess elements in struct initializer
     327 |                 .detach_dev = visconti_atu_detach_device,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:327:31: note: (near initialization for '(anonymous)')
   drivers/iommu/visconti-atu.c:328:18: error: 'const struct iommu_domain_ops' has no member named 'map'
     328 |                 .map = visconti_atu_map,
         |                  ^~~
   drivers/iommu/visconti-atu.c:328:24: warning: excess elements in struct initializer
     328 |                 .map = visconti_atu_map,
         |                        ^~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:328:24: note: (near initialization for '(anonymous)')
   drivers/iommu/visconti-atu.c:329:18: error: 'const struct iommu_domain_ops' has no member named 'unmap'
     329 |                 .unmap = visconti_atu_unmap,
         |                  ^~~~~
   drivers/iommu/visconti-atu.c:329:26: warning: excess elements in struct initializer
     329 |                 .unmap = visconti_atu_unmap,
         |                          ^~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:329:26: note: (near initialization for '(anonymous)')
   drivers/iommu/visconti-atu.c:330:18: error: 'const struct iommu_domain_ops' has no member named 'iova_to_phys'
     330 |                 .iova_to_phys = visconti_atu_iova_to_phys,
         |                  ^~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:330:33: warning: excess elements in struct initializer
     330 |                 .iova_to_phys = visconti_atu_iova_to_phys,
         |                                 ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:330:33: note: (near initialization for '(anonymous)')
   drivers/iommu/visconti-atu.c:331:18: error: 'const struct iommu_domain_ops' has no member named 'free'
     331 |                 .free = visconti_atu_domain_free,
         |                  ^~~~
   drivers/iommu/visconti-atu.c:331:25: warning: excess elements in struct initializer
     331 |                 .free = visconti_atu_domain_free,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:331:25: note: (near initialization for '(anonymous)')
   drivers/iommu/visconti-atu.c:325:64: error: invalid use of undefined type 'const struct iommu_domain_ops'
     325 |         .default_domain_ops = &(const struct iommu_domain_ops) {
         |                                                                ^
   drivers/iommu/visconti-atu.c:325:31: warning: excess elements in struct initializer
     325 |         .default_domain_ops = &(const struct iommu_domain_ops) {
         |                               ^
   drivers/iommu/visconti-atu.c:325:31: note: (near initialization for 'visconti_atu_ops')
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_probe':
   drivers/iommu/visconti-atu.c:366:22: error: implicit declaration of function 'iommu_group_alloc' [-Werror=implicit-function-declaration]
     366 |         atu->group = iommu_group_alloc();
         |                      ^~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:366:20: warning: assignment to 'struct iommu_group *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     366 |         atu->group = iommu_group_alloc();
         |                    ^
   drivers/iommu/visconti-atu.c:380:15: error: implicit declaration of function 'iommu_device_sysfs_add' [-Werror=implicit-function-declaration]
     380 |         ret = iommu_device_sysfs_add(&atu->iommu, dev, NULL, dev_name(dev));
         |               ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:384:15: error: implicit declaration of function 'iommu_device_register'; did you mean 'of_device_register'? [-Werror=implicit-function-declaration]
     384 |         ret = iommu_device_register(&atu->iommu, &visconti_atu_ops, dev);
         |               ^~~~~~~~~~~~~~~~~~~~~
         |               of_device_register
   drivers/iommu/visconti-atu.c:388:14: error: implicit declaration of function 'iommu_present'; did you mean 'pmd_present'? [-Werror=implicit-function-declaration]
     388 |         if (!iommu_present(&platform_bus_type))
         |              ^~~~~~~~~~~~~
         |              pmd_present
   drivers/iommu/visconti-atu.c:389:17: error: implicit declaration of function 'bus_set_iommu' [-Werror=implicit-function-declaration]
     389 |                 bus_set_iommu(&platform_bus_type, &visconti_atu_ops);
         |                 ^~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:395:9: error: implicit declaration of function 'iommu_device_sysfs_remove' [-Werror=implicit-function-declaration]
     395 |         iommu_device_sysfs_remove(&atu->iommu);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_remove':
   drivers/iommu/visconti-atu.c:405:9: error: implicit declaration of function 'iommu_device_unregister'; did you mean 'of_device_unregister'? [-Werror=implicit-function-declaration]
     405 |         iommu_device_unregister(&atu->iommu);
         |         ^~~~~~~~~~~~~~~~~~~~~~~
         |         of_device_unregister
   drivers/iommu/visconti-atu.c: At top level:
   drivers/iommu/visconti-atu.c:318:31: error: storage size of 'visconti_atu_ops' isn't known
     318 | static const struct iommu_ops visconti_atu_ops = {
         |                               ^~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:318:31: error: storage size of 'visconti_atu_ops' isn't known
   cc1: some warnings being treated as errors


vim +/iommu +47 drivers/iommu/visconti-atu.c

    43	
    44	struct visconti_atu_device {
    45		struct device *dev;
    46		void __iomem *base;
  > 47		struct iommu_device iommu;
    48		struct iommu_group *group;
    49	
    50		unsigned int num_entry;
    51		unsigned int num_map_entry;
    52		unsigned int enable_entry;
    53		unsigned long iova[ATU_MAX_IOMMU_ENTRY];
    54		phys_addr_t paddr[ATU_MAX_IOMMU_ENTRY];
    55		size_t size[ATU_MAX_IOMMU_ENTRY];
    56	
    57		spinlock_t lock;
    58	};
    59	
    60	struct visconti_atu_domain {
    61		struct visconti_atu_device *atu;
  > 62		struct iommu_domain io_domain;
    63		struct mutex mutex;
    64	};
    65	
    66	static const struct iommu_ops visconti_atu_ops;
    67	
    68	static struct visconti_atu_domain *to_atu_domain(struct iommu_domain *domain)
    69	{
    70		return container_of(domain, struct visconti_atu_domain, io_domain);
    71	}
    72	
    73	static inline void visconti_atu_write(struct visconti_atu_device *atu, u32 reg,
    74					      u32 val)
    75	{
    76		writel_relaxed(val, atu->base + reg);
    77	}
    78	
    79	static inline u32 visconti_atu_read(struct visconti_atu_device *atu, u32 reg)
    80	{
    81		return readl_relaxed(atu->base + reg);
    82	}
    83	
    84	static void visconti_atu_enable_entry(struct visconti_atu_device *atu,
    85					      int num)
    86	{
    87		dev_dbg(atu->dev, "enable ATU: %d\n", atu->enable_entry);
    88	
    89		visconti_atu_write(atu, ATU_AT_EN, 0);
    90		if (atu->enable_entry & BIT(num)) {
    91			visconti_atu_write(atu,
    92					   ATU_AT_REG(num, ATU_AT_BLADDR),
    93					   atu->iova[num]);
    94			visconti_atu_write(atu,
    95					   ATU_AT_REG(num, ATU_AT_ELADDR),
    96					   atu->iova[num] + atu->size[num] - 1);
    97			visconti_atu_write(atu,
    98					   ATU_AT_REG(num, ATU_AT_BGADDR0),
    99					   atu->iova[num] & ATU_BGADDR_MASK);
   100			visconti_atu_write(atu,
   101					   ATU_AT_REG(num, ATU_AT_BGADDR1),
   102					   (atu->iova[num] >> 32) & ATU_BGADDR_MASK);
   103		}
   104		visconti_atu_write(atu, ATU_AT_ENTRY_EN, atu->enable_entry);
   105		visconti_atu_write(atu, ATU_AT_EN, 1);
   106	}
   107	
   108	static void visconti_atu_disable_entry(struct visconti_atu_device *atu)
   109	{
   110		dev_dbg(atu->dev, "disable ATU: %d\n", atu->enable_entry);
   111	
   112		visconti_atu_write(atu, ATU_AT_EN, 0);
   113		visconti_atu_write(atu, ATU_AT_ENTRY_EN, atu->enable_entry);
   114		visconti_atu_write(atu, ATU_AT_EN, 1);
   115	}
   116	
   117	static int visconti_atu_attach_device(struct iommu_domain *io_domain,
   118					      struct device *dev)
   119	{
   120		struct visconti_atu_domain *domain = to_atu_domain(io_domain);
 > 121		struct visconti_atu_device *atu = dev_iommu_priv_get(dev);
   122		int ret = 0;
   123	
   124		if (!atu) {
   125			dev_err(dev, "Cannot attach to ATU\n");
   126			return -ENXIO;
   127		}
   128	
   129		mutex_lock(&domain->mutex);
   130	
   131		if (!domain->atu) {
   132			domain->atu = atu;
   133		} else if (domain->atu != atu) {
   134			dev_err(dev, "Can't attach ATU %s to domain on ATU %s\n",
   135				dev_name(atu->dev), dev_name(domain->atu->dev));
   136			ret = -EINVAL;
   137		} else {
   138			dev_warn(dev, "Reusing ATU context\n");
   139		}
   140	
   141		mutex_unlock(&domain->mutex);
   142	
   143		return ret;
   144	}
   145	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
