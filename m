Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 904D45B0FA8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 00:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229988AbiIGWHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 18:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiIGWHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 18:07:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4439D666
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 15:07:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662588455; x=1694124455;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=opm+udo9hcC/Jimt9TvXEIDH8cXQbqxDr/iB2g4r7Hc=;
  b=geNZ3ofqQXELrtchw9i+fe+6vL1vZO9OBf1QE2Rg8/yoWrfwcUzvPHec
   4PlxNTfbKeufxaCUQpvTYgmfHpXAhoS3dEIdJdf78TymdHbg7Woabdv/E
   t+Mv5f+r6F4AZVHzHMG8YLUPkNvRKIkmz5uHgmBDWhc3aWzc9IKfcLe4W
   c49XL7U3SyrWBPo1PvgeZN0itJTdHJ9MWk8dTjeC1zZe69D1JmvmdyRKb
   aTk4CVWcPP4F1cpuyPT1cPcucJlHEt3je7pdbBcusfJOwekosCQT/jwYk
   Ig60qQWI3d8RXvOVFGTn+5kCLcSk2sBm0mtUbwbJw05YxMcXKnG92UzbY
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297815677"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="297815677"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 15:07:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="565695255"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 07 Sep 2022 15:07:33 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oW3Cm-00070J-24;
        Wed, 07 Sep 2022 22:07:32 +0000
Date:   Thu, 8 Sep 2022 06:07:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Xin Hao <xhao@linux.alibaba.com>, sj@kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        akpm@linux-foundation.org, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        xhao@linux.alibaba.com
Subject: Re: [PATCH] mm/damon: Remove duplicate get_monitoring_region()
 definitions
Message-ID: <202209080600.L5N3msAB-lkp@intel.com>
References: <20220907112924.65546-1-xhao@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220907112924.65546-1-xhao@linux.alibaba.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Xin,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v6.0-rc4 next-20220907]
[cannot apply to akpm-mm/mm-everything]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Xin-Hao/mm-damon-Remove-duplicate-get_monitoring_region-definitions/20220907-193059
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git 0066f1b0e27556381402db3ff31f85d2a2265858
config: hexagon-randconfig-r041-20220907 (https://download.01.org/0day-ci/archive/20220908/202209080600.L5N3msAB-lkp@intel.com/config)
compiler: clang version 16.0.0 (https://github.com/llvm/llvm-project c55b41d5199d2394dd6cdb8f52180d8b81d809d4)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/28cd0cc7549075eccc95a2c48fbe3bc58f17caee
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Xin-Hao/mm-damon-Remove-duplicate-get_monitoring_region-definitions/20220907-193059
        git checkout 28cd0cc7549075eccc95a2c48fbe3bc58f17caee
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash mm/

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from mm/damon/reclaim.c:16:
>> mm/damon/ops-common.h:13:23: error: unknown type name 'pmd_t'
   void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
                         ^
   1 error generated.


vim +/pmd_t +13 mm/damon/ops-common.h

46c3a0accdc48c mm/damon/prmtv-common.h SeongJae Park 2021-11-05  11  
46c3a0accdc48c mm/damon/prmtv-common.h SeongJae Park 2021-11-05  12  void damon_ptep_mkold(pte_t *pte, struct mm_struct *mm, unsigned long addr);
46c3a0accdc48c mm/damon/prmtv-common.h SeongJae Park 2021-11-05 @13  void damon_pmdp_mkold(pmd_t *pmd, struct mm_struct *mm, unsigned long addr);
198f0f4c58b9f4 mm/damon/prmtv-common.h SeongJae Park 2021-11-05  14  

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
