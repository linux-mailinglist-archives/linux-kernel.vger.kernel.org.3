Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C66D8533641
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 06:45:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239548AbiEYEpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 00:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230473AbiEYEpq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 00:45:46 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3C3A6CAB2;
        Tue, 24 May 2022 21:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653453944; x=1684989944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=rmrfTWyOBpKZ8kLMwjs6qb5smk3ww7YOqwg7KXC8BZc=;
  b=SXWsbzunS68a1r8Ze7zcLnjnDDVjkJw/AsZfBkD5mbhrLF4VraNxFjcL
   KgR8xOvdI2Xr+z+3+VAY93Z+RX9KQ7VvU299Nw296UdTlAkl0nF21IFCP
   h/sBxX5bLRLjsvvSRNS8jO2Gi4LHj2isihVcEJwCIn/ChVdJmDOdJYY6Q
   PZV+suWveYOzeKeEVRxbHb73FxFNsSaoCeDroQo72am+4ctOUeMFSDxYu
   CrqEWcd0Eca7PxC5rMUhUJXU7cnr+UdQGbcMqEvsyFiDTBtjAe48wn7YZ
   eEUuD4ekN5nNXqwJL0pxNJK6sMMxyt0TMUXXGMQPrJeyGTLfWDmb3bC3T
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10357"; a="261325692"
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="261325692"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 21:45:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,250,1647327600"; 
   d="scan'208";a="578182693"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 24 May 2022 21:45:41 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntitw-0002j4-Ot;
        Wed, 25 May 2022 04:45:40 +0000
Date:   Wed, 25 May 2022 12:45:34 +0800
From:   kernel test robot <lkp@intel.com>
To:     Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Joerg Roedel <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     kbuild-all@lists.01.org, yuji2.ishikawa@toshiba.co.jp,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>
Subject: Re: [PATCH 1/3] iommu: Add Visconti5 IOMMU driver
Message-ID: <202205251205.PHq3cWj3-lkp@intel.com>
References: <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525013147.2215355-2-nobuhiro1.iwamatsu@toshiba.co.jp>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
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
config: nios2-allyesconfig (https://download.01.org/0day-ci/archive/20220525/202205251205.PHq3cWj3-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/69bb4f3c2ef0bb1f65922bc72bb31109897a6393
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Nobuhiro-Iwamatsu/Add-Visconti5-IOMMU-driver/20220525-093326
        git checkout 69bb4f3c2ef0bb1f65922bc72bb31109897a6393
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=nios2 SHELL=/bin/bash drivers/iommu/

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
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_enable_entry':
>> drivers/iommu/visconti-atu.c:102:52: warning: right shift count >= width of type [-Wshift-count-overflow]
     102 |                                    (atu->iova[num] >> 32) & ATU_BGADDR_MASK);
         |                                                    ^~
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_attach_device':
   drivers/iommu/visconti-atu.c:121:43: error: implicit declaration of function 'dev_iommu_priv_get' [-Werror=implicit-function-declaration]
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
   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from ./arch/nios2/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/nios2/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/iommu/visconti-atu.c:12:
   drivers/iommu/visconti-atu.c: In function 'visconti_atu_iova_to_phys':
>> drivers/iommu/visconti-atu.c:251:27: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'dma_addr_t' {aka 'unsigned int'} [-Wformat=]
     251 |         dev_dbg(atu->dev, "iova_to_phys: %llx -> %llx\n", iova, paddr);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/iommu/visconti-atu.c:251:9: note: in expansion of macro 'dev_dbg'
     251 |         dev_dbg(atu->dev, "iova_to_phys: %llx -> %llx\n", iova, paddr);
         |         ^~~~~~~
   drivers/iommu/visconti-atu.c:251:45: note: format string is defined here
     251 |         dev_dbg(atu->dev, "iova_to_phys: %llx -> %llx\n", iova, paddr);
         |                                          ~~~^
         |                                             |
         |                                             long long unsigned int
         |                                          %x
   In file included from include/linux/printk.h:555,
                    from include/asm-generic/bug.h:22,
                    from ./arch/nios2/include/generated/asm/bug.h:1,
                    from include/linux/bug.h:5,
                    from include/linux/thread_info.h:13,
                    from include/asm-generic/current.h:5,
                    from ./arch/nios2/include/generated/asm/current.h:1,
                    from include/linux/sched.h:12,
                    from include/linux/ratelimit.h:6,
                    from include/linux/dev_printk.h:16,
                    from include/linux/device.h:15,
                    from include/linux/dma-mapping.h:7,
                    from drivers/iommu/visconti-atu.c:12:
>> drivers/iommu/visconti-atu.c:251:27: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 5 has type 'phys_addr_t' {aka 'unsigned int'} [-Wformat=]
     251 |         dev_dbg(atu->dev, "iova_to_phys: %llx -> %llx\n", iova, paddr);
         |                           ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:166:9: note: in expansion of macro '_dynamic_func_call'
     166 |         _dynamic_func_call(fmt,__dynamic_dev_dbg,               \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:9: note: in expansion of macro 'dynamic_dev_dbg'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~
   include/linux/dev_printk.h:155:30: note: in expansion of macro 'dev_fmt'
     155 |         dynamic_dev_dbg(dev, dev_fmt(fmt), ##__VA_ARGS__)
         |                              ^~~~~~~
   drivers/iommu/visconti-atu.c:251:9: note: in expansion of macro 'dev_dbg'
     251 |         dev_dbg(atu->dev, "iova_to_phys: %llx -> %llx\n", iova, paddr);
         |         ^~~~~~~
   drivers/iommu/visconti-atu.c:251:53: note: format string is defined here
     251 |         dev_dbg(atu->dev, "iova_to_phys: %llx -> %llx\n", iova, paddr);
         |                                                  ~~~^
         |                                                     |
         |                                                     long long unsigned int
         |                                                  %x
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
   drivers/iommu/visconti-atu.c:298:39: warning: initialization of 'struct iommu_fwspec *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
   drivers/iommu/visconti-atu.c:301:30: error: invalid use of undefined type 'struct iommu_fwspec'
     301 |         if (!fwspec || fwspec->ops != &visconti_atu_ops)
         |                              ^~
   drivers/iommu/visconti-atu.c:304:13: warning: assignment to 'struct visconti_atu_device *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
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
   drivers/iommu/visconti-atu.c:319:25: warning: excess elements in struct initializer
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


vim +102 drivers/iommu/visconti-atu.c

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
 > 102					   (atu->iova[num] >> 32) & ATU_BGADDR_MASK);
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
   121		struct visconti_atu_device *atu = dev_iommu_priv_get(dev);
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
   196					 struct iommu_iotlb_gather *iotlb_gather)
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
 > 251		dev_dbg(atu->dev, "iova_to_phys: %llx -> %llx\n", iova, paddr);
   252	
   253		return paddr;
   254	}
   255	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
