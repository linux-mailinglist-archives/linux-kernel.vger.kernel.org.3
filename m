Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 474C0531E74
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 00:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiEWWSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 18:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiEWWSI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 18:18:08 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A977980A
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 15:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1653344287; x=1684880287;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=op0Iwek8NGbwkxNZpnj8NsKU2hi/WA+IMvCT2cWJKuU=;
  b=ff2x3bwsSogAuGu1P1K2Bb+Mwchu0Qyqp09NWjzmYANu5yZtQcb8sbdv
   HMPs1kHd5BU06E4WuGvQ/+HTBZGfTrJhaYc5lMCJI12JuaD5fl+ysIUWJ
   LyAqtPUIRL+SL9DIrwvYU6Pns7dvO4XL6NDN7uYMXrwex5JT80selD87r
   mf5frSxd4Fu/g+bz7+qUrIOu32+4EWFofiY2FevE9g4aImEtY6RBkUjhk
   HzAjcHPqysphccrEbKMlL51BEjNxXfUhaVYDI01en0Li7T2FiphRvdlkG
   8bpYlgKYwCELct4f5xbYGrSbxanh+kfpOccYgUe1NOPCVsfQPfq1NNme4
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10356"; a="359769660"
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="359769660"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 15:18:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,247,1647327600"; 
   d="scan'208";a="716917439"
Received: from lkp-server01.sh.intel.com (HELO db63a1be7222) ([10.239.97.150])
  by fmsmga001.fm.intel.com with ESMTP; 23 May 2022 15:18:04 -0700
Received: from kbuild by db63a1be7222 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1ntGNH-0001U8-OY;
        Mon, 23 May 2022 22:18:03 +0000
Date:   Tue, 24 May 2022 06:17:17 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org, hch@infradead.org,
        arnd@arndb.de, anshuman.khandual@arm.com,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
Message-ID: <202205240657.BXxrhbgp-lkp@intel.com>
References: <20220519082552.117736-5-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220519082552.117736-5-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on arm64/for-next/core]
[also build test WARNING on arnd-asm-generic/master akpm-mm/mm-everything linus/master v5.18 next-20220523]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/arm64-Cleanup-ioremap-and-support-ioremap_prot/20220519-161853
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: csky-randconfig-s032-20220522 (https://download.01.org/0day-ci/archive/20220524/202205240657.BXxrhbgp-lkp@intel.com/config)
compiler: csky-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/intel-lab-lkp/linux/commit/eb83d30756d3b279ca58791d343dc821291818d0
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kefeng-Wang/arm64-Cleanup-ioremap-and-support-ioremap_prot/20220519-161853
        git checkout eb83d30756d3b279ca58791d343dc821291818d0
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=csky SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> mm/ioremap.c:59:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *addr @@     got void [noderef] __iomem *vaddr @@
   mm/ioremap.c:59:16: sparse:     expected void const *addr
   mm/ioremap.c:59:16: sparse:     got void [noderef] __iomem *vaddr

vim +59 mm/ioremap.c

    51	
    52	void iounmap(volatile void __iomem *addr)
    53	{
    54		void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);
    55	
    56		if (arch_iounmap(vaddr))
    57			return;
    58	
  > 59		vunmap(vaddr);

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
