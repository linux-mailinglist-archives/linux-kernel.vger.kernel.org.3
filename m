Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D636D4E1F25
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 03:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344225AbiCUCzZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 22:55:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344196AbiCUCzV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 22:55:21 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCEB858E64;
        Sun, 20 Mar 2022 19:53:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647831237; x=1679367237;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=d7KQds5beDpM3p/NihgSSHXqAj0QSPvdkhy43Lf5WgE=;
  b=iHGQ6iHcK3UJrw+Dwh63qkjDNWkB3gz3zQNwTq+e09QavipjBPtb5ZHg
   uK20fKcpyKG0y/M1tl5RC/8VjnSdI+sJmSp8u9dzr1Xr/z8mtOVAGVODz
   3NJW/RG5XD10pW6pW/kGi5vQvAtF6C+dEuIc1haamubi62sxG0HZ+w4nq
   W4rhB3Jj6RkueOBHKlvXHxZEEPI4ct6I5O1lp1nXcMZDMhYqfUjR46z4D
   G4gfzKnoIf4IT5nFq14T3W5IbbbKx1hsm2o4E8z4lzNvK3Bm4RCKsyktr
   TqYEYYyUHNzIi5ZbMElQf3qk71pdFE/Sb+fSbRGTixqqZGY7FVD3wPu06
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10292"; a="255020822"
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="255020822"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2022 19:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,197,1643702400"; 
   d="scan'208";a="784852173"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 20 Mar 2022 19:53:54 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nW8B7-000HOp-TC; Mon, 21 Mar 2022 02:53:53 +0000
Date:   Mon, 21 Mar 2022 10:52:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Joerg Roedel <joro@8bytes.org>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     kbuild-all@lists.01.org, Will Deacon <will@kernel.org>,
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
Message-ID: <202203211032.FSaAOkQt-lkp@intel.com>
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
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220321/202203211032.FSaAOkQt-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/105690537e561d997e376617aa6a7d6d7b74a6a6
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220319-063131
        git checkout 105690537e561d997e376617aa6a7d6d7b74a6a6
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   drivers/iommu/amd/iommu.c: In function 'amd_iommu_capable':
>> drivers/iommu/amd/iommu.c:2165:7: error: 'IOMMU_CAP_PRE_BOOT_PROTECTION' undeclared (first use in this function)
    2165 |  case IOMMU_CAP_PRE_BOOT_PROTECTION:
         |       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   drivers/iommu/amd/iommu.c:2165:7: note: each undeclared identifier is reported only once for each function it appears in


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
