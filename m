Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CCE4DA71C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:51:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352866AbiCPAwq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:52:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241438AbiCPAwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:52:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8603E5C868;
        Tue, 15 Mar 2022 17:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647391891; x=1678927891;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=YXFKpERtBJQFxnnvLc21al+Vghk+4iLs8WPaY6XgGEQ=;
  b=BX6RLkzGGEOoBdprexYXFclhxv9HjUEa7JHHy+XVdUHQyyhA5Y1m9Zew
   1EsFROjUvCfk0mU/hWCYbp1FrqQu41XRPdfpP21ov/Mlp9BZlO4EkZtWn
   37vSrGE+wka1tXuNkaEtjqYtELq4oWgMrJIjBWxO8tRA+Oaj+kbVo2n6p
   Iuzj9bIVxsabuLLarwGjl7dEFkQI8ge0F0brA7T6WMrT58zhvr/hXej45
   t9qajl2C31A1TC8yZocs4JthvTnf4QMjxBFTJFGgX4rROxO9gleBNtxR8
   vgSzw0if3ArvFZ4s9b46/EiBpWMzRqWcV1ZR1zPlfY5q1zYcx51ODxNqn
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256181133"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256181133"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 17:51:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="714391253"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 15 Mar 2022 17:51:28 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUHst-000Bj2-F4; Wed, 16 Mar 2022 00:51:27 +0000
Date:   Wed, 16 Mar 2022 08:51:16 +0800
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
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 1/2] iommu/amd: Add support to indicate whether DMA remap
 support is enabled
Message-ID: <202203160844.lKviWR1Q-lkp@intel.com>
References: <20220315162455.5190-1-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315162455.5190-1-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mario,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on joro-iommu/next]
[also build test ERROR on arm-perf/for-next/perf linus/master v5.17-rc8 next-20220315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220316-002821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-defconfig (https://download.01.org/0day-ci/archive/20220316/202203160844.lKviWR1Q-lkp@intel.com/config)
compiler: gcc-9 (Ubuntu 9.4.0-1ubuntu1~20.04) 9.4.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/fa63035401902e438c5ef3213112901a1054c621
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220316-002821
        git checkout fa63035401902e438c5ef3213112901a1054c621
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> drivers/iommu/amd/init.c:3294:6: error: redefinition of 'amd_ivrs_remap_support'
    3294 | bool amd_ivrs_remap_support(void)
         |      ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/iommu/amd/init.c:20:
   include/linux/amd-iommu.h:198:20: note: previous definition of 'amd_ivrs_remap_support' was here
     198 | static inline bool amd_ivrs_remap_support(void)
         |                    ^~~~~~~~~~~~~~~~~~~~~~


vim +/amd_ivrs_remap_support +3294 drivers/iommu/amd/init.c

  3284	
  3285	/*
  3286	 * ivrs_remap_support - Is %IOMMU_IVINFO_DMA_REMAP set in IVRS table
  3287	 *
  3288	 * Returns true if the platform has %IOMMU_IVINFO_DMA_REMAP% set in the IOMMU
  3289	 * IVRS IVInfo field.
  3290	 * Presence of this flag indicates to the OS/HV that the IOMMU is used for
  3291	 * Preboot DMA protection and device accessed memory should be remapped after
  3292	 * the OS has loaded.
  3293	 */
> 3294	bool amd_ivrs_remap_support(void)
  3295	{
  3296		return amdr_ivrs_remap_support;
  3297	}
  3298	EXPORT_SYMBOL_GPL(amd_ivrs_remap_support);
  3299	

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
