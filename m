Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3653351068D
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 20:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351467AbiDZST3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 14:19:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350866AbiDZSTX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 14:19:23 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F0E39137B
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 11:16:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650996975; x=1682532975;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JW9g477eFo5T/YbxZ6fEAgD7lLOuo7kBu55PzoCbgHs=;
  b=flZjjGfVqf/CNGu9/WF30IlVTpds0c+zeOkgw1+lCSVwcmix+6pDPsFu
   50oi0EQCwE3DdSXB+oOeP1ADOr1E/edD+2Pagp3FFPXRn4F3txGyC2bny
   gkkjR/lGcpLoDjimpnn+moZp+pmJBzAz3OEOvzMnNvA+m1sBmOFQ4mTVP
   lJoMu72y4+0msaQug4LAGChki6TPR1IAS05L4NkhtFqkDPLh1fAUQx6ur
   iCrh/aBtey7Xs5e9sW90mRkaHRVN7VMfRfy4AOuAzuUGBzpiFqrh743eY
   /u5gOMAfTR2hrPU9laO41nbAopL8lIbj8pwS8EtTThE7Bjdroiwsio4n8
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10329"; a="265484311"
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="265484311"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Apr 2022 11:16:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,291,1643702400"; 
   d="scan'208";a="617124827"
Received: from lkp-server01.sh.intel.com (HELO 5056e131ad90) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 26 Apr 2022 11:16:11 -0700
Received: from kbuild by 5056e131ad90 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1njPjP-0003so-Aj;
        Tue, 26 Apr 2022 18:16:11 +0000
Date:   Wed, 27 Apr 2022 02:15:30 +0800
From:   kernel test robot <lkp@intel.com>
To:     Qing Wang <wangqing@vivo.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        Wang Qing <wangqing@vivo.com>
Subject: Re: [PATCH V2 2/2] arm64: Add complex scheduler level for arm64
Message-ID: <202204270201.FkymxKhn-lkp@intel.com>
References: <1650628289-67716-3-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1650628289-67716-3-git-send-email-wangqing@vivo.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qing,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on driver-core/driver-core-testing linus/master arm-perf/for-next/perf v5.18-rc4 next-20220422]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Qing-Wang/Add-complex-scheduler-level-for-arm64/20220422-201107
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-allyesconfig (https://download.01.org/0day-ci/archive/20220427/202204270201.FkymxKhn-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project 1cddcfdc3c683b393df1a5c9063252eb60e52818)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # install arm64 cross compiling tool for clang build
        # apt-get install binutils-aarch64-linux-gnu
        # https://github.com/intel-lab-lkp/linux/commit/3b18155ccd99fb790e719fa432366dfdb97ab57c
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Qing-Wang/Add-complex-scheduler-level-for-arm64/20220422-201107
        git checkout 3b18155ccd99fb790e719fa432366dfdb97ab57c
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> arch/arm64/kernel/smp.c:752:4: error: use of undeclared identifier 'arm64_complex_mask'
           { arm64_complex_mask, arm64_complex_flags, SD_INIT_NAME(CPL) },
             ^
>> arch/arm64/kernel/smp.c:752:24: error: use of undeclared identifier 'arm64_complex_flags'
           { arm64_complex_mask, arm64_complex_flags, SD_INIT_NAME(CPL) },
                                 ^
   2 errors generated.


vim +/arm64_complex_mask +752 arch/arm64/kernel/smp.c

   746	
   747	static struct sched_domain_topology_level arm64_topology[] = {
   748	#ifdef CONFIG_SCHED_SMT
   749		{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
   750	#endif
   751	#ifdef CONFIG_SCHED_COMPLEX
 > 752		{ arm64_complex_mask, arm64_complex_flags, SD_INIT_NAME(CPL) },
   753	#endif
   754	#ifdef CONFIG_SCHED_CLUSTER
   755		{ cpu_clustergroup_mask, cpu_cluster_flags, SD_INIT_NAME(CLS) },
   756	#endif
   757	#ifdef CONFIG_SCHED_MC
   758		{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
   759	#endif
   760		{ cpu_cpu_mask, SD_INIT_NAME(DIE) },
   761		{ NULL, },
   762	};
   763	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
