Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD8753ED1D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229941AbiFFRmg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 13:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229887AbiFFRma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 13:42:30 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7BEA515B3
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 10:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654537348; x=1686073348;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=1JJNR8/oQ5jmHfP9vYMlYc7K16smz9PpCKSG7Hi97W8=;
  b=GF0/KVbYyP+UCiTOkZyVYSrOrPtCEh29WaAGYXQCLuJoIFgooMQR6/aX
   kPg5Wx7y/FNQaAag+LgB9HCtv6uDmye0HzJnKylo+w8N1ZflfFaIUuMHj
   oB0aH/POGAMQGFHIo94bYzhzz8IZb9VohbdTDzCv2zArsKiH8euttFG6F
   3FqlJ42DWgxAp3PAO0PWcfh255INcGoGg40vE53aaYBTj0Lbwijj0zS7P
   kQtVXsvql3St9GaDaJ4zyiDsOsvNyQkcB+cYgU/f9b5OpH/hiVdYNzakv
   yiU8uGXPuwcBzPuvNDkfWHOgPnunP62J579AvRsgAg0a9DyfHCedNQfwI
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10370"; a="274212691"
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="274212691"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jun 2022 10:42:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,280,1647327600"; 
   d="scan'208";a="565015877"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Jun 2022 10:42:25 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1nyGkC-000CwT-G6;
        Mon, 06 Jun 2022 17:42:24 +0000
Date:   Tue, 7 Jun 2022 01:41:35 +0800
From:   kernel test robot <lkp@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>, catalin.marinas@arm.com,
        will@kernel.org, akpm@linux-foundation.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, linux-mm@kvack.org, hch@infradead.org,
        arnd@arndb.de, anshuman.khandual@arm.com,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 5/6] arm64: mm: Convert to GENERIC_IOREMAP
Message-ID: <202206070159.mnbdPS9W-lkp@intel.com>
References: <20220606074815.139265-6-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220606074815.139265-6-wangkefeng.wang@huawei.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kefeng,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on linus/master]
[also build test WARNING on v5.19-rc1 next-20220606]
[cannot apply to arm64/for-next/core arnd-asm-generic/master akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Kefeng-Wang/arm64-Cleanup-ioremap-and-support-ioremap_prot/20220606-154131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git f2906aa863381afb0015a9eb7fefad885d4e5a56
config: arm64-randconfig-s032-20220605 (https://download.01.org/0day-ci/archive/20220607/202206070159.mnbdPS9W-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 11.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.4-18-g56afb504-dirty
        # https://github.com/intel-lab-lkp/linux/commit/3fd9e961045f81f0ee188501228f8425c3d868a8
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Kefeng-Wang/arm64-Cleanup-ioremap-and-support-ioremap_prot/20220606-154131
        git checkout 3fd9e961045f81f0ee188501228f8425c3d868a8
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=arm64 SHELL=/bin/bash arch/arm64/mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/arm64/mm/ioremap.c:28:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *x @@     got void [noderef] __iomem *addr @@
   arch/arm64/mm/ioremap.c:28:32: sparse:     expected void const *x
   arch/arm64/mm/ioremap.c:28:32: sparse:     got void [noderef] __iomem *addr

vim +28 arch/arm64/mm/ioremap.c

    21	
    22	int iounmap_allowed(void __iomem *addr)
    23	{
    24		/*
    25		 * We could get an address outside vmalloc range in case
    26		 * of ioremap_cache() reusing a RAM mapping.
    27		 */
  > 28		return is_vmalloc_addr(addr) ? 0 : -EINVAL;
    29	}
    30	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
