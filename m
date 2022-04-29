Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CFA95158E4
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 01:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381728AbiD2XT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 19:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355216AbiD2XTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 19:19:49 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021B9ABF64
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651274188; x=1682810188;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=sHpYr19nxBH5UfvW1LQhyFMHjbMcdeIKQbNSYUgapl8=;
  b=BKOWt8kT7IxEr/As66vbrNeH5CN4cW4nut0B42igFq3cpLwzfLJgQdux
   0IMqYdoH9J09odPIzf38cngGAeBjwicikTom3EDto+cnJ7zcwfQnlk4I8
   DP6tIyL3l723P/TX3tGbUb2qYKYJ2FF6GAWmBikC/O98WyHha98426wGg
   hhIqoWCmxhkm5Cj9RhRYud/8iewmkNJC9NAZYAzSCBdlBYrEFT9un+PPV
   BRRplX2lD90tJBSBHJrYGsoZaBBKAYYZxgyZlTyUI9LYhD9LE1kXq/aR4
   zUAR1ulKWd5rBUP5uC1BxHajl8g92qIIzTOC2YlqCMeNWx3lxwH6dCawF
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10332"; a="327296849"
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="327296849"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Apr 2022 16:16:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,186,1647327600"; 
   d="scan'208";a="630275595"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 29 Apr 2022 16:16:26 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nkZqb-0006g5-Hi;
        Fri, 29 Apr 2022 23:16:25 +0000
Date:   Sat, 30 Apr 2022 07:15:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org, hch@infradead.org,
        arnd@arndb.de, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 4/5] arm64: mm: Convert to GENERIC_IOREMAP
Message-ID: <202204300706.lSqtHOzz-lkp@intel.com>
References: <20220429103225.75121-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220429103225.75121-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on hnaz-mm/master arnd-asm-generic/master v5.18-rc4 next-20220429]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/arm64-Cleanup-ioremap-and-support-ioremap_prot/20220429-182215
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-randconfig-s032-20220429 (https://download.01.org/0day-ci/archive/20220430/202204300706.lSqtHOzz-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/77442d1fe8ed26b996b2b7d4464443a63097c434
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kefeng-Wang/arm64-Cleanup-ioremap-and-support-ioremap_prot/20220429-182215
        git checkout 77442d1fe8ed26b996b2b7d4464443a63097c434
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm64/mm/ioremap.c:14:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/arm64/mm/ioremap.c:14:31: sparse:     expected void [noderef] __iomem *
   arch/arm64/mm/ioremap.c:14:31: sparse:     got void *
   arch/arm64/mm/ioremap.c:18:31: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   arch/arm64/mm/ioremap.c:18:31: sparse:     expected void [noderef] __iomem *
   arch/arm64/mm/ioremap.c:18:31: sparse:     got void *
   arch/arm64/mm/ioremap.c:29:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *x @@     got void [noderef] __iomem *addr @@
   arch/arm64/mm/ioremap.c:29:32: sparse:     expected void const *x
   arch/arm64/mm/ioremap.c:29:32: sparse:     got void [noderef] __iomem *addr

vim +14 arch/arm64/mm/ioremap.c

     6	
     7	void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot)
     8	{
     9		unsigned long last_addr = phys_addr + size - 1;
    10		int ret = -EINVAL;
    11	
    12		/* Don't allow outside PHYS_MASK */
    13		if (last_addr & ~PHYS_MASK)
  > 14			return ERR_PTR(ret);
    15	
    16		/* Don't allow RAM to be mapped. */
    17		if (WARN_ON(pfn_is_map_memory(__phys_to_pfn(phys_addr))))
    18			return ERR_PTR(ret);
    19	
    20		return NULL;
    21	}
    22	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
