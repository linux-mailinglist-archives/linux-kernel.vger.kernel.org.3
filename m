Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7E5E5336AD
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:11:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244101AbiEYGKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240020AbiEYGKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:10:50 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4834D6EB38;
        Tue, 24 May 2022 23:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653459048; x=1684995048;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Hq9N3fTqQlZUi8YbYUVovOeTq8HUqkTJ8TbwzOCPPeY=;
  b=VxlnBxRUXFgQ9J05knkJFMAiqJ2uIF5+Wyshmv9RYWzB3VBbWVaTJ2s5
   FMnCqbzUIYjBEgkGANmFwbWZO4VKaFcf63x+CHc8/vyjDCvtdLFtfT4v5
   BQNbxC+n4lzlovumrG5WpDeWryIrhKH5bHHt8iegbx60upl4keXi+UoF7
   6NY0owf44odkvDp+GxDYmzRyIP0f8bYCIp/llsgDJuzF9ScQVlEbherEi
   hAB/xgTUNfIfiy+6gIw63m8zYL9Q4QAPopza3bbFfQDA7dMGA/f2tBGOM
   tmdUnWo6/oLn7b30x5Mj1rOyYvj59mfqMLEN6JUCtV7o1PqP3K7dzcGxs
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="299058305"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="299058305"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 23:10:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="664277582"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 24 May 2022 23:10:45 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntkEG-0002nW-Lq;
        Wed, 25 May 2022 06:10:44 +0000
Date:   Wed, 25 May 2022 14:09:45 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Message-ID: <202205251452.kFXLqhQx-lkp@intel.com>
References: <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nobuhiro,

I love your patch! Perhaps something to improve:

[auto build test WARNING on joro-iommu/next]
[also build test WARNING on arm-perf/for-next/perf soc/for-next linus/master v5.18 next-20220524]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Nobuhiro-Iwamatsu/Add-Visconti5-IOMMU-driver/20220525-093326
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: alpha-allyesconfig (https://download.01.org/0day-ci/archive/20220525/202205251452.kFXLqhQx-lkp@intel.com/config)
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
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=alpha SHELL=/bin/bash drivers/iommu/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/iommu/visconti-atu.c:47:29: error: field 'iommu' has incomplete type
      47 |         struct iommu_device iommu;
         |                             ^~~~~
   drivers/iommu/visconti-atu.c:62:29: error: field 'io_domain' has incomplete type
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
   drivers/iommu/visconti-atu.c:121:43: error: implicit declaration of function 'dev_iommu_priv_get' [-Werror=implicit-function-declaration]
     121 |         struct visconti_atu_device *atu = dev_iommu_priv_get(dev);
         |                                           ^~~~~~~~~~~~~~~~~~
>> drivers/iommu/visconti-atu.c:121:43: warning: initialization of 'struct visconti_atu_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_detach_device':
   drivers/iommu/visconti-atu.c:150:43: warning: initialization of 'struct visconti_atu_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     150 |         struct visconti_atu_device *atu = dev_iommu_priv_get(dev);
         |                                           ^~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: At top level:
>> drivers/iommu/visconti-atu.c:196:41: warning: 'struct iommu_iotlb_gather' declared inside parameter list will not be visible outside of this definition or declaration
     196 |                                  struct iommu_iotlb_gather *iotlb_gather)
         |                                         ^~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_of_xlate':
   drivers/iommu/visconti-atu.c:262:17: error: implicit declaration of function 'dev_iommu_priv_set' [-Werror=implicit-function-declaration]
     262 |                 dev_iommu_priv_set(dev, platform_get_drvdata(pdev));
         |                 ^~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_domain_alloc':
   drivers/iommu/visconti-atu.c:273:21: error: 'IOMMU_DOMAIN_UNMANAGED' undeclared (first use in this function)
     273 |         if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
         |                     ^~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:273:21: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iommu/visconti-atu.c:273:55: error: 'IOMMU_DOMAIN_DMA' undeclared (first use in this function)
     273 |         if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
         |                                                       ^~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_probe_device':
   drivers/iommu/visconti-atu.c:298:39: error: implicit declaration of function 'dev_iommu_fwspec_get' [-Werror=implicit-function-declaration]
     298 |         struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
         |                                       ^~~~~~~~~~~~~~~~~~~~
>> drivers/iommu/visconti-atu.c:298:39: warning: initialization of 'struct iommu_fwspec *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/iommu/visconti-atu.c:301:30: error: invalid use of undefined type 'struct iommu_fwspec'
     301 |         if (!fwspec || fwspec->ops != &visconti_atu_ops)
         |                              ^~
>> drivers/iommu/visconti-atu.c:304:13: warning: assignment to 'struct visconti_atu_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     304 |         atu = dev_iommu_priv_get(dev);
         |             ^
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_release_device':
   drivers/iommu/visconti-atu.c:310:43: warning: initialization of 'struct visconti_atu_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     310 |         struct visconti_atu_device *atu = dev_iommu_priv_get(dev);
         |                                           ^~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:315:9: error: implicit declaration of function 'iommu_fwspec_free' [-Werror=implicit-function-declaration]
     315 |         iommu_fwspec_free(dev);
         |         ^~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c: At top level:
   drivers/iommu/visconti-atu.c:318:21: error: variable 'visconti_atu_ops' has initializer but incomplete type
     318 | static const struct iommu_ops visconti_atu_ops = {
         |                     ^~~~~~~~~
   drivers/iommu/visconti-atu.c:319:10: error: 'const struct iommu_ops' has no member named 'domain_alloc'
     319 |         .domain_alloc = visconti_atu_domain_alloc,
         |          ^~~~~~~~~~~~
>> drivers/iommu/visconti-atu.c:319:25: warning: excess elements in struct initializer
     319 |         .domain_alloc = visconti_atu_domain_alloc,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:319:25: note: (near initialization for 'visconti_atu_ops')
   drivers/iommu/visconti-atu.c:320:10: error: 'const struct iommu_ops' has no member named 'probe_device'
     320 |         .probe_device = visconti_atu_probe_device,
         |          ^~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:320:25: warning: excess elements in struct initializer
     320 |         .probe_device = visconti_atu_probe_device,
         |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:320:25: note: (near initialization for 'visconti_atu_ops')
   drivers/iommu/visconti-atu.c:321:10: error: 'const struct iommu_ops' has no member named 'release_device'
     321 |         .release_device = visconti_atu_release_device,
         |          ^~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:321:27: warning: excess elements in struct initializer
     321 |         .release_device = visconti_atu_release_device,
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:321:27: note: (near initialization for 'visconti_atu_ops')
   drivers/iommu/visconti-atu.c:322:10: error: 'const struct iommu_ops' has no member named 'device_group'
     322 |         .device_group = generic_device_group,
         |          ^~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:322:25: error: 'generic_device_group' undeclared here (not in a function)
     322 |         .device_group = generic_device_group,
         |                         ^~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:322:25: warning: excess elements in struct initializer
   drivers/iommu/visconti-atu.c:322:25: note: (near initialization for 'visconti_atu_ops')
   drivers/iommu/visconti-atu.c:323:10: error: 'const struct iommu_ops' has no member named 'of_xlate'
     323 |         .of_xlate = visconti_atu_of_xlate,
         |          ^~~~~~~~
   drivers/iommu/visconti-atu.c:323:21: warning: excess elements in struct initializer
     323 |         .of_xlate = visconti_atu_of_xlate,
         |                     ^~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:323:21: note: (near initialization for 'visconti_atu_ops')
   drivers/iommu/visconti-atu.c:324:10: error: 'const struct iommu_ops' has no member named 'pgsize_bitmap'
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
   drivers/iommu/visconti-atu.c:325:10: error: 'const struct iommu_ops' has no member named 'default_domain_ops'
     325 |         .default_domain_ops = &(const struct iommu_domain_ops) {
         |          ^~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:326:18: error: 'const struct iommu_domain_ops' has no member named 'attach_dev'
     326 |                 .attach_dev = visconti_atu_attach_device,
         |                  ^~~~~~~~~~
   drivers/iommu/visconti-atu.c:326:31: warning: excess elements in struct initializer
     326 |                 .attach_dev = visconti_atu_attach_device,
         |                               ^~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/visconti-atu.c:326:31: note: (near initialization for '(anonymous)')
   drivers/iommu/visconti-atu.c:327:18: error: 'const struct iommu_domain_ops' has no member named 'detach_dev'
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
>> drivers/iommu/visconti-atu.c:366:20: warning: assignment to 'struct iommu_group *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
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


vim +121 drivers/iommu/visconti-atu.c

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
   146	static void visconti_atu_detach_device(struct iommu_domain *io_domain,
   147					       struct device *dev)
   148	{
   149		struct visconti_atu_domain *domain = to_atu_domain(io_domain);
   150		struct visconti_atu_device *atu = dev_iommu_priv_get(dev);
   151	
   152		if (domain->atu != atu)
   153			return;
   154	
   155		domain->atu = NULL;
   156	}
   157	
   158	static int visconti_atu_map(struct iommu_domain *io_domain,
   159				    unsigned long iova,
   160				    phys_addr_t paddr,
   161				    size_t size, int prot, gfp_t gfp)
   162	{
   163		struct visconti_atu_domain *domain = to_atu_domain(io_domain);
   164		struct visconti_atu_device *atu = domain->atu;
   165		unsigned long flags;
   166		unsigned int i;
   167	
   168		if (!domain)
   169			return -ENODEV;
   170	
   171		spin_lock_irqsave(&atu->lock, flags);
   172		for (i = 0; i < atu->num_map_entry; i++) {
   173			if (!(atu->enable_entry & BIT(i))) {
   174				atu->enable_entry |= BIT(i);
   175				atu->iova[i] = iova;
   176				atu->paddr[i] = paddr;
   177				atu->size[i] = size;
   178	
   179				visconti_atu_enable_entry(atu, i);
   180				break;
   181			}
   182		}
   183		spin_unlock_irqrestore(&atu->lock, flags);
   184	
   185		if (i == atu->num_map_entry) {
   186			dev_err(atu->dev, "map: not enough entry.\n");
   187			return -ENOMEM;
   188		}
   189	
   190		return 0;
   191	}
   192	
   193	static size_t visconti_atu_unmap(struct iommu_domain *io_domain,
   194					 unsigned long iova,
   195					 size_t size,
 > 196					 struct iommu_iotlb_gather *iotlb_gather)
   197	{
   198		struct visconti_atu_domain *domain = to_atu_domain(io_domain);
   199		struct visconti_atu_device *atu = domain->atu;
   200		size_t tmp_size = size;
   201		unsigned long flags;
   202		unsigned int i;
   203	
   204		spin_lock_irqsave(&atu->lock, flags);
   205	
   206		while (tmp_size != 0) {
   207			for (i = 0; i < atu->num_map_entry; i++) {
   208				if (atu->iova[i] != iova)
   209					continue;
   210	
   211				atu->enable_entry &= ~BIT(i);
   212				iova += atu->size[i];
   213				tmp_size -= atu->size[i];
   214	
   215				visconti_atu_disable_entry(atu);
   216	
   217				break;
   218			}
   219			if (i == atu->num_map_entry) {
   220				dev_err(atu->dev, "unmap: not found entry.\n");
   221				size = 0;
   222				goto out;
   223			}
   224		}
   225	
   226		if (!atu->num_map_entry)
   227			visconti_atu_write(atu, ATU_AT_EN, 0);
   228	out:
   229		spin_unlock_irqrestore(&atu->lock, flags);
   230		return size;
   231	}
   232	
   233	static phys_addr_t visconti_atu_iova_to_phys(struct iommu_domain *io_domain,
   234						     dma_addr_t iova)
   235	{
   236		struct visconti_atu_domain *domain = to_atu_domain(io_domain);
   237		struct visconti_atu_device *atu = domain->atu;
   238		phys_addr_t paddr = 0;
   239		unsigned int i;
   240	
   241		for (i = 0; i < atu->num_map_entry; i++) {
   242			if (!(atu->enable_entry & BIT(i)))
   243				continue;
   244			if (atu->iova[i] <= iova && iova < (atu->iova[i] + atu->size[i])) {
   245				paddr = atu->paddr[i];
   246				paddr += iova & (atu->size[i] - 1);
   247				break;
   248			}
   249		}
   250	
   251		dev_dbg(atu->dev, "iova_to_phys: %llx -> %llx\n", iova, paddr);
   252	
   253		return paddr;
   254	}
   255	
   256	static int visconti_atu_of_xlate(struct device *dev, struct of_phandle_args *args)
   257	{
   258		if (!dev_iommu_priv_get(dev)) {
   259			struct platform_device *pdev;
   260	
   261			pdev = of_find_device_by_node(args->np);
   262			dev_iommu_priv_set(dev, platform_get_drvdata(pdev));
   263			platform_device_put(pdev);
   264		}
   265	
   266		return 0;
   267	}
   268	
   269	static struct iommu_domain *visconti_atu_domain_alloc(unsigned int type)
   270	{
   271		struct visconti_atu_domain *domain;
   272	
   273		if (type != IOMMU_DOMAIN_UNMANAGED && type != IOMMU_DOMAIN_DMA)
   274			return NULL;
   275	
   276		domain = kzalloc(sizeof(*domain), GFP_KERNEL);
   277		if (!domain)
   278			return NULL;
   279	
   280		mutex_init(&domain->mutex);
   281	
   282		domain->io_domain.geometry.aperture_start = 0;
   283		domain->io_domain.geometry.aperture_end = DMA_BIT_MASK(32);
   284		domain->io_domain.geometry.force_aperture = true;
   285	
   286		return &domain->io_domain;
   287	}
   288	
   289	static void visconti_atu_domain_free(struct iommu_domain *io_domain)
   290	{
   291		struct visconti_atu_domain *domain = to_atu_domain(io_domain);
   292	
   293		kfree(domain);
   294	}
   295	
   296	static struct iommu_device *visconti_atu_probe_device(struct device *dev)
   297	{
 > 298		struct iommu_fwspec *fwspec = dev_iommu_fwspec_get(dev);
   299		struct visconti_atu_device *atu;
   300	
   301		if (!fwspec || fwspec->ops != &visconti_atu_ops)
   302			return ERR_PTR(-ENODEV);
   303	
 > 304		atu = dev_iommu_priv_get(dev);
   305		return &atu->iommu;
   306	}
   307	
   308	static void visconti_atu_release_device(struct device *dev)
   309	{
   310		struct visconti_atu_device *atu = dev_iommu_priv_get(dev);
   311	
   312		if (!atu)
   313			return;
   314	
   315		iommu_fwspec_free(dev);
   316	}
   317	
   318	static const struct iommu_ops visconti_atu_ops = {
 > 319		.domain_alloc = visconti_atu_domain_alloc,
   320		.probe_device = visconti_atu_probe_device,
   321		.release_device = visconti_atu_release_device,
   322		.device_group = generic_device_group,
   323		.of_xlate = visconti_atu_of_xlate,
   324		.pgsize_bitmap = ATU_IOMMU_PGSIZE_BITMAP,
   325		.default_domain_ops = &(const struct iommu_domain_ops) {
   326			.attach_dev = visconti_atu_attach_device,
   327			.detach_dev = visconti_atu_detach_device,
   328			.map = visconti_atu_map,
   329			.unmap = visconti_atu_unmap,
   330			.iova_to_phys = visconti_atu_iova_to_phys,
   331			.free = visconti_atu_domain_free,
   332		}
   333	};
   334	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
