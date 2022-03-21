Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 421594E1F21
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344210AbiCUCzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbiCUCzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:55:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B0558E64;
        Sun, 20 Mar 2022 19:53:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647831235; x=1679367235;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=qFCBBl+Sw+dHadJW+S6qeiLknxva1nkER2nqihe0HKQ=;
  b=XFmHvLmAUF1UlxlA5bYSZV2Rse3bFuCnjFS116jMcRVl8fD4DkUmd3dN
   4d/13wjTZ9cW0lPBXrKag0qJ+D4BrIqli8ITeNeXxHLehxKsi/kNAbwqf
   uQpWU/nDX7mxBpD2tTqMIKjNQgNBmFSJicJhsSmrz0ZoqcFbDVcvV4Z9d
   EeGrDrMGfR96vfk64im4gatpSxhTYwQL5uXdSlXZWyj/PHIXUrh6V1jra
   iMryMbva22/mQ9h9YN9df7ZDYDQbwlDukEExP23ewtdHmYR4GP5bWWU2p
   fktD/BnabOWHHeP164VP9IO/rOZhlOw47zLKi9HBLgsyBOWkecPk5dX2y
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="257647520"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="257647520"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 19:53:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="600335412"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 20 Mar 2022 19:53:51 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nW8B4-000HOm-GE; Mon, 21 Mar 2022 02:53:50 +0000
Date:   Mon, 21 Mar 2022 10:52:47 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Will Deacon <will@kernel.org>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        "open list:AMD IOMMU (AMD-VI)" <iommu@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:THUNDERBOLT DRIVER" <linux-usb@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH v2] iommu/amd: Add support to indicate whether DMA remap
 support is enabled
Message-ID: <202203211052.WEPydSQ9-lkp@intel.com>
References: <20220318223104.7049-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220318223104.7049-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on joro-iommu/next]
[also build test ERROR on v5.17 next-20220318]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220319-063131
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-buildonly-randconfig-r004-20220321 (https://download.01.org/0day-ci/archive/20220321/202203211052.WEPydSQ9-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 85e9b2687a13d1908aa86d1b89c5ce398a06cd39)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/105690537e561d997e376617aa6a7d6d7b74a6a6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220319-063131
        git checkout 105690537e561d997e376617aa6a7d6d7b74a6a6
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/iommu/amd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iommu/amd/iommu.c:2165:7: error: use of undeclared identifier 'IOMMU_CAP_PRE_BOOT_PROTECTION'
           case IOMMU_CAP_PRE_BOOT_PROTECTION:
                ^
   1 error generated.


vim +/IOMMU_CAP_PRE_BOOT_PROTECTION +2165 drivers/iommu/amd/iommu.c

  2155	
  2156	static bool amd_iommu_capable(enum iommu_cap cap)
  2157	{
  2158		switch (cap) {
  2159		case IOMMU_CAP_CACHE_COHERENCY:
  2160			return true;
  2161		case IOMMU_CAP_INTR_REMAP:
  2162			return (irq_remapping_enabled == 1);
  2163		case IOMMU_CAP_NOEXEC:
  2164			return false;
> 2165		case IOMMU_CAP_PRE_BOOT_PROTECTION:
  2166			return amdr_ivrs_remap_support;
  2167		default:
  2168			break;
  2169		}
  2170	
  2171		return false;
  2172	}
  2173	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
