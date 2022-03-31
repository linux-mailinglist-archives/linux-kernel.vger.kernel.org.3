Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6614EDE8C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 18:16:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239760AbiCaQSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 12:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239892AbiCaQSJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 12:18:09 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E564C8EB6A
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 09:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1648743381; x=1680279381;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ZfXnGhOcxSqo1ZnmYemNjeBrcUnq/HVWLE0Cz2++JJs=;
  b=d0pRNfr5q51v7J4heTn8dryfJEiVqHOOpj7sGIoFPgZtdHnsYxw9ezgZ
   YLJ2eSOkbalEKqkW3ya1yqPboa57MdIFk1Mnuhh2TSlM5/RpJO3gtO8LC
   XsPluIsWVZ3EKT9D8lmnpHxkq+gj9MGrPo3t/h7gB3uSAOS8m/jz20CSr
   MGw6EBTYqs+EKOOR1HdRMGBgbXw41TVHFKxfMR4UXlJe7MsHSP9ptAZy4
   fduJUKv8CAv1LKRka7aygs8uMn2DerMOMVuy2kBiS5+YLgFYv823GFy06
   dbz8ee8yJtGVUik/1KY6lCmrgfLN1v9Iu+l20Pqz+MEK5vXHUdK0fXWv6
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="323059132"
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="323059132"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 09:14:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,225,1643702400"; 
   d="scan'208";a="654868468"
Received: from lkp-server02.sh.intel.com (HELO 3231c491b0e2) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 31 Mar 2022 09:14:53 -0700
Received: from kbuild by 3231c491b0e2 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nZxRk-0000QW-Db;
        Thu, 31 Mar 2022 16:14:52 +0000
Date:   Fri, 1 Apr 2022 00:14:28 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, vijayb@linux.microsoft.com,
        f.fainelli@gmail.com, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v2 resend 2/3] arm64: mm: Don't defer
 reserve_crashkernel() with dma_force_32bit
Message-ID: <202204010040.RUk6NuNS-lkp@intel.com>
References: <20220331074055.125824-3-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220331074055.125824-3-wangkefeng.wang@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on next-20220330]
[cannot apply to arm64/for-next/core v5.17 v5.17-rc8 v5.17-rc7 v5.17]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/arm64-mm-Do-not-defer-reserve_crashkernel/20220331-152839
base:    a67ba3cf9551f8c92d5ec9d7eae1aadbb9127b57
config: arm64-buildonly-randconfig-r001-20220331 (https://download.01.org/0day-ci/archive/20220401/202204010040.RUk6NuNS-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.2.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/970ec526bd69287a4eb9838600aaf66c46fde350
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kefeng-Wang/arm64-mm-Do-not-defer-reserve_crashkernel/20220331-152839
        git checkout 970ec526bd69287a4eb9838600aaf66c46fde350
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.2.0 make.cross O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/arm64/mm/init.c:108:13: warning: no previous prototype for 'crashkernel_could_early_reserve' [-Wmissing-prototypes]
     108 | bool __init crashkernel_could_early_reserve(void)
         |             ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


vim +/crashkernel_could_early_reserve +108 arch/arm64/mm/init.c

   107	
 > 108	bool __init crashkernel_could_early_reserve(void)
   109	{
   110		if (!IS_ENABLED(CONFIG_ZONE_DMA))
   111			return true;
   112		if (arm64_dma_force_32bit)
   113			return true;
   114		return false;
   115	}
   116	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
