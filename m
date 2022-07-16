Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C3A8576B21
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 02:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbiGPAi4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 20:38:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiGPAiy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 20:38:54 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3908415713;
        Fri, 15 Jul 2022 17:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1657931933; x=1689467933;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=kA0/QSLOElTCWHwqX1Noco5mDpydNCMPS39Y/xSReS4=;
  b=gWshTn86/Qqq+1UXwuZ93w+YRwJLbvOeYV/u4ipLni2/1dYprWf0Z66l
   Uwdil4yM30eV5IqxFnq82HDCE5m+S2iLhvcGs33L+uHBrqFoVzBGw+7qT
   2riyf/59Y6/AB61NCwjqDyiiB8Z0SfQZCKL6FfDyW/DWz1uLxF4W1kqc4
   xbybiX8Vk4kEeUvyfBNJ6gjzyCudX6O4DSr8II4aF//FqgjjTWExY/eyc
   4SYdU3auDA/q7FK5V5SBhIEtPomX/v+6Ah82Scgt8iqwdPsGIb78ED50H
   GPwc3rafPqM38kCkzQLmMFjOoGOZVVtdHncQtXadiGrw0mMDj/LtQiOOO
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10409"; a="283494084"
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="283494084"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jul 2022 17:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.92,275,1650956400"; 
   d="scan'208";a="923713805"
Received: from lkp-server02.sh.intel.com (HELO ff137eb26ff1) ([10.239.97.151])
  by fmsmga005.fm.intel.com with ESMTP; 15 Jul 2022 17:38:50 -0700
Received: from kbuild by ff137eb26ff1 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1oCVpZ-0000tw-Fv;
        Sat, 16 Jul 2022 00:38:49 +0000
Date:   Sat, 16 Jul 2022 08:38:27 +0800
From:   kernel test robot <lkp@intel.com>
To:     Li Chen <me@linux.beauty>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     kbuild-all@lists.01.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Li Chen <lchen@ambarella.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] of: add struct page support to rmem
Message-ID: <202207160854.nSdKYSY8-lkp@intel.com>
References: <20220711122459.13773-2-me@linux.beauty>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220711122459.13773-2-me@linux.beauty>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Li,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on robh/for-next]
[also build test WARNING on arm64/for-next/core arm-perf/for-next/perf linus/master v5.19-rc6 next-20220715]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Li-Chen/add-struct-page-and-Direct-I-O-support-to-reserved-memory/20220711-202957
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220716/202207160854.nSdKYSY8-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/8b66b4b9614f1c7bb8b2d8fac17d5a2a73acf954
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Li-Chen/add-struct-page-and-Direct-I-O-support-to-reserved-memory/20220711-202957
        git checkout 8b66b4b9614f1c7bb8b2d8fac17d5a2a73acf954
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash drivers/mailbox/ drivers/of/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   drivers/of/of_reserved_mem.c: In function 'reserved_mem_memremap_pages':
   drivers/of/of_reserved_mem.c:633:50: error: invalid application of 'sizeof' to incomplete type 'struct dev_pagemap'
     633 |         pgmap_rmem_dio = devm_kzalloc(dev, sizeof(*pgmap_rmem_dio), GFP_KERNEL);
         |                                                  ^
   drivers/of/of_reserved_mem.c:635:23: error: invalid use of undefined type 'struct dev_pagemap'
     635 |         pgmap_rmem_dio->range.start = rmem->base;
         |                       ^~
   drivers/of/of_reserved_mem.c:636:23: error: invalid use of undefined type 'struct dev_pagemap'
     636 |         pgmap_rmem_dio->range.end = rmem->base + rmem->size - 1;
         |                       ^~
   drivers/of/of_reserved_mem.c:637:23: error: invalid use of undefined type 'struct dev_pagemap'
     637 |         pgmap_rmem_dio->nr_range = 1;
         |                       ^~
   drivers/of/of_reserved_mem.c:638:23: error: invalid use of undefined type 'struct dev_pagemap'
     638 |         pgmap_rmem_dio->type = MEMORY_DEVICE_GENERIC;
         |                       ^~
   drivers/of/of_reserved_mem.c:638:32: error: 'MEMORY_DEVICE_GENERIC' undeclared (first use in this function)
     638 |         pgmap_rmem_dio->type = MEMORY_DEVICE_GENERIC;
         |                                ^~~~~~~~~~~~~~~~~~~~~
   drivers/of/of_reserved_mem.c:638:32: note: each undeclared identifier is reported only once for each function it appears in
   In file included from include/linux/printk.h:584,
                    from include/linux/kernel.h:29,
                    from include/linux/cpumask.h:10,
                    from include/linux/smp.h:13,
                    from include/linux/lockdep.h:14,
                    from include/linux/mutex.h:17,
                    from include/linux/kernfs.h:11,
                    from include/linux/sysfs.h:16,
                    from include/linux/kobject.h:20,
                    from include/linux/of.h:17,
                    from drivers/of/of_reserved_mem.c:15:
   drivers/of/of_reserved_mem.c:641:42: error: invalid use of undefined type 'struct dev_pagemap'
     641 |                  __func__, pgmap_rmem_dio->range.start, pgmap_rmem_dio->range.end);
         |                                          ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:599:9: note: in expansion of macro 'dynamic_pr_debug'
     599 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/of/of_reserved_mem.c:640:9: note: in expansion of macro 'pr_debug'
     640 |         pr_debug("%s, will do devm_memremap_pages, start from %llx, to %llx\n",
         |         ^~~~~~~~
   drivers/of/of_reserved_mem.c:641:71: error: invalid use of undefined type 'struct dev_pagemap'
     641 |                  __func__, pgmap_rmem_dio->range.start, pgmap_rmem_dio->range.end);
         |                                                                       ^~
   include/linux/dynamic_debug.h:134:29: note: in definition of macro '__dynamic_func_call'
     134 |                 func(&id, ##__VA_ARGS__);               \
         |                             ^~~~~~~~~~~
   include/linux/dynamic_debug.h:162:9: note: in expansion of macro '_dynamic_func_call'
     162 |         _dynamic_func_call(fmt, __dynamic_pr_debug,             \
         |         ^~~~~~~~~~~~~~~~~~
   include/linux/printk.h:599:9: note: in expansion of macro 'dynamic_pr_debug'
     599 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
         |         ^~~~~~~~~~~~~~~~
   drivers/of/of_reserved_mem.c:640:9: note: in expansion of macro 'pr_debug'
     640 |         pr_debug("%s, will do devm_memremap_pages, start from %llx, to %llx\n",
         |         ^~~~~~~~
   drivers/of/of_reserved_mem.c:643:17: error: implicit declaration of function 'devm_memremap_pages'; did you mean 'devm_free_pages'? [-Werror=implicit-function-declaration]
     643 |         vaddr = devm_memremap_pages(dev, pgmap_rmem_dio);
         |                 ^~~~~~~~~~~~~~~~~~~
         |                 devm_free_pages
>> drivers/of/of_reserved_mem.c:643:15: warning: assignment to 'void *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
     643 |         vaddr = devm_memremap_pages(dev, pgmap_rmem_dio);
         |               ^
   cc1: some warnings being treated as errors


vim +643 drivers/of/of_reserved_mem.c

   610	
   611	/**
   612	 * reserved_mem_memremap_pages() - build struct pages for reserved mem
   613	 * @dev: device pointer
   614	 * @rmem: reserved memory region from dts, which can be get by
   615	 *        get_reserved_mem_from_dev(dev)
   616	 *
   617	 * Returns: 0 on success or a negative error-code on failure.
   618	 */
   619	void *reserved_mem_memremap_pages(struct device *dev, struct reserved_mem *rmem)
   620	{
   621		struct dev_pagemap *pgmap_rmem_dio;
   622		void *vaddr;
   623		struct page **pages;
   624		int i;
   625		unsigned long offset = 0;
   626		struct page *page;
   627	
   628		rmem->nr_pages = DIV_ROUND_UP(rmem->size, PAGE_SIZE);
   629		pages = kvmalloc_array(rmem->nr_pages, sizeof(*pages), GFP_KERNEL);
   630		if (!pages)
   631			return ERR_PTR(-ENOMEM);
   632	
   633		pgmap_rmem_dio = devm_kzalloc(dev, sizeof(*pgmap_rmem_dio), GFP_KERNEL);
   634	
   635		pgmap_rmem_dio->range.start = rmem->base;
   636		pgmap_rmem_dio->range.end = rmem->base + rmem->size - 1;
   637		pgmap_rmem_dio->nr_range = 1;
   638		pgmap_rmem_dio->type = MEMORY_DEVICE_GENERIC;
   639	
   640		pr_debug("%s, will do devm_memremap_pages, start from %llx, to %llx\n",
   641			 __func__, pgmap_rmem_dio->range.start, pgmap_rmem_dio->range.end);
   642	
 > 643		vaddr = devm_memremap_pages(dev, pgmap_rmem_dio);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
