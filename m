Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDA904DA765
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 02:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352955AbiCPBet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 21:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235181AbiCPBer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 21:34:47 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7F9C32ECC;
        Tue, 15 Mar 2022 18:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647394414; x=1678930414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xAHtXDDav9BrhYDuigVnMmC1A+VvTM+jKpTIjJx+T54=;
  b=FuC3LziPKETAcu0IK6Hp96O3mtF6HD+mzhK1VVunudy9ZM6+jJ0RNkyg
   sxCeYsgXGGsLqPoXS5+pmKM4e4gQ40a95esK/ys0k7zB3sPBs02u6jLKL
   j4V6hs+url69lnx7oG0DWyqHIsELOl9RWofhDqjfGdFPSaw5mkREcknay
   la0dIYQZxvPCg2bp7tWYjCgVf2b4st+1Pp7wMcsT8oQA6uetJPyySGa7R
   RIk4RtSAScck2w6+Jc5cVmVsKbwkg1xk9NOtiLSQXLCMiwmjFZ5zeCwGi
   AQ3upHxh5sze3C6/f+mDT0yCYYA2Oz49WIxlfQc5X7ZYabh6M048BpRiH
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="256414460"
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="256414460"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2022 18:33:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,185,1643702400"; 
   d="scan'208";a="646451611"
Received: from lkp-server02.sh.intel.com (HELO 89b41b6ae01c) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 15 Mar 2022 18:33:31 -0700
Received: from kbuild by 89b41b6ae01c with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1nUIXa-000BlM-8n; Wed, 16 Mar 2022 01:33:30 +0000
Date:   Wed, 16 Mar 2022 09:32:41 +0800
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
        Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 2/2] thunderbolt: Use pre-boot DMA protection on AMD
 systems
Message-ID: <202203160904.VB4alCdg-lkp@intel.com>
References: <20220315162455.5190-2-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220315162455.5190-2-mario.limonciello@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
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
[also build test ERROR on arm-perf/for-next/perf linus/master v5.17-rc8 next-20220315]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220316-002821
base:   https://git.kernel.org/pub/scm/linux/kernel/git/joro/iommu.git next
config: x86_64-randconfig-a012 (https://download.01.org/0day-ci/archive/20220316/202203160904.VB4alCdg-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project a6b2f50fb47da3baeee10b1906da6e30ac5d26ec)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/9b0b7079d348c607cba7af4c87eaae1a79e52d91
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Mario-Limonciello/iommu-amd-Add-support-to-indicate-whether-DMA-remap-support-is-enabled/20220316-002821
        git checkout 9b0b7079d348c607cba7af4c87eaae1a79e52d91
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=x86_64 SHELL=/bin/bash drivers/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from drivers/thunderbolt/domain.c:9:
>> include/linux/amd-iommu.h:159:52: error: use of undeclared identifier 'ENODEV'
   static inline int amd_iommu_detect(void) { return -ENODEV; }
                                                      ^
   1 error generated.


vim +/ENODEV +159 include/linux/amd-iommu.h

6a9401a7ac13e6 arch/x86/include/asm/amd_iommu.h Joerg Roedel          2009-11-20  158  
480125ba49ba62 arch/x86/include/asm/amd_iommu.h Konrad Rzeszutek Wilk 2010-08-26 @159  static inline int amd_iommu_detect(void) { return -ENODEV; }
6a9401a7ac13e6 arch/x86/include/asm/amd_iommu.h Joerg Roedel          2009-11-20  160  

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
