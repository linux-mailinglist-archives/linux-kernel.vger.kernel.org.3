Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 331DB4A576C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 08:01:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234491AbiBAHB0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 02:01:26 -0500
Received: from mga12.intel.com ([192.55.52.136]:2400 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231231AbiBAHBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 02:01:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643698885; x=1675234885;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=jRNs7ogHWPGoLBMk4Bb5fE9HNjneVYvi8uKyHW569M4=;
  b=ANgMdD/gU86wi43fnxBLG8sURjLkxWiQJ0movArCnbRt8MUetiijw/86
   bNSplOp3qrvmTrsdGaYYInoHPdeAvnURXN75ty18rgkaw3QzS+t04g+E7
   EFk5zAjOuOpRVX/+S/HNpxe0kj+SGcddqvnfh6TeOur5vteR3I2fr+HFX
   i/DvZL75/ticxW7+1Eow+SUTrwZvBu4PHwJktS6Zfzheqk6k5ElDuMcdu
   NRR/sR6CGlhq2k4lks/uFmWQIPlgWCDfs0XWD4ItAFOGzcjnQxmQeInH5
   LNz+8usJeB3Q/NEAQA87T6kManGE10h+3ocHxYDEhVhzxPCjVVO5GCuXg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10244"; a="227605196"
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="227605196"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2022 23:01:25 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,333,1635231600"; 
   d="scan'208";a="768845209"
Received: from lkp-server01.sh.intel.com (HELO 276f1b88eecb) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jan 2022 23:01:23 -0800
Received: from kbuild by 276f1b88eecb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nEnAI-000SvW-VH; Tue, 01 Feb 2022 07:01:22 +0000
Date:   Tue, 1 Feb 2022 15:01:19 +0800
From:   kernel test robot <lkp@intel.com>
To:     Joerg Roedel <joro@8bytes.org>, iommu@lists.linux-foundation.org
Cc:     kbuild-all@lists.01.org, Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        Maxim Levitsky <mlevitsk@redhat.com>
Subject: Re: [PATCH] iommu/amd: Fix loop timeout issue in
 iommu_ga_log_enable()
Message-ID: <202202011448.2UFIiZHD-lkp@intel.com>
References: <20220131161749.4021-1-joro@8bytes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131161749.4021-1-joro@8bytes.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Joerg,

I love your patch! Yet something to improve:

[auto build test ERROR on joro-iommu/next]
[also build test ERROR on v5.17-rc2 next-20220131]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Joerg-Roedel/iommu-amd-Fix-loop-timeout-issue-in-iommu_ga_log_enable/20220201-002214
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-allyesconfig (https://download.01.org/0day-ci/archive/20220201/202202011448.2UFIiZHD-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/5b5785526da0e2a6e793d2107d09afc9f310f17f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Joerg-Roedel/iommu-amd-Fix-loop-timeout-issue-in-iommu_ga_log_enable/20220201-002214
        git checkout 5b5785526da0e2a6e793d2107d09afc9f310f17f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/amd/init.c: In function 'iommu_ga_log_enable':
>> drivers/iommu/amd/init.c:837:3: error: implicit declaration of function 'udelay' [-Werror=implicit-function-declaration]
     837 |   udelay(1);
         |   ^~~~~~
   cc1: some warnings being treated as errors


vim +/udelay +837 drivers/iommu/amd/init.c

   804	
   805	static int iommu_ga_log_enable(struct amd_iommu *iommu)
   806	{
   807	#ifdef CONFIG_IRQ_REMAP
   808		u32 status, i;
   809		u64 entry;
   810	
   811		if (!iommu->ga_log)
   812			return -EINVAL;
   813	
   814		/* Check if already running */
   815		status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
   816		if (WARN_ON(status & (MMIO_STATUS_GALOG_RUN_MASK)))
   817			return 0;
   818	
   819		entry = iommu_virt_to_phys(iommu->ga_log) | GA_LOG_SIZE_512;
   820		memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_BASE_OFFSET,
   821			    &entry, sizeof(entry));
   822		entry = (iommu_virt_to_phys(iommu->ga_log_tail) &
   823			 (BIT_ULL(52)-1)) & ~7ULL;
   824		memcpy_toio(iommu->mmio_base + MMIO_GA_LOG_TAIL_OFFSET,
   825			    &entry, sizeof(entry));
   826		writel(0x00, iommu->mmio_base + MMIO_GA_HEAD_OFFSET);
   827		writel(0x00, iommu->mmio_base + MMIO_GA_TAIL_OFFSET);
   828	
   829	
   830		iommu_feature_enable(iommu, CONTROL_GAINT_EN);
   831		iommu_feature_enable(iommu, CONTROL_GALOG_EN);
   832	
   833		for (i = 0; i < LOOP_TIMEOUT; ++i) {
   834			status = readl(iommu->mmio_base + MMIO_STATUS_OFFSET);
   835			if (status & (MMIO_STATUS_GALOG_RUN_MASK))
   836				break;
 > 837			udelay(1);
   838		}
   839	
   840		if (WARN_ON(i >= LOOP_TIMEOUT))
   841			return -EINVAL;
   842	#endif /* CONFIG_IRQ_REMAP */
   843		return 0;
   844	}
   845	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
