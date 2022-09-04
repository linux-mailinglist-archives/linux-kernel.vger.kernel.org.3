Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E6C35AC812
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 00:59:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235337AbiIDW7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 18:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbiIDW64 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 18:58:56 -0400
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEAE2A72E;
        Sun,  4 Sep 2022 15:58:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662332335; x=1693868335;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6lRrC028A9Us0DoTusO+pndhBJWhk8nDRSwaWIEpGho=;
  b=So6hOxruTsqFaVcXFP1UNOOApEDIig/gzZhEWUVkcTZeoGwm7EmY9mHs
   emrOWn+6VRkr+MzUULkdbNHh0aQll3bgeIWtiqmrYp69CfFvmMDoRc+wJ
   kXIusyWlOqk7p9zxLSoQFmj6O4MHdqgV5YtQfxeWDA4fL2vFIe78QAUW0
   U04M9z6Eko3tZ8gcpK69PZ0+1/ooKxSAzAyOgIdKMPo7s3OnvkPcK3b0d
   wZ1sZNxpqLUXleMMVHncs9f6vBGIQd7SCW2cHB9jYJUossUmAH20xwlB1
   CnVgNWfs2u2ux+afrHaQEZZRXGBHV8DnlJl//OmGulBGvoOCRPuzKIib0
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="279289639"
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="279289639"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2022 15:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,290,1654585200"; 
   d="scan'208";a="702697580"
Received: from lkp-server02.sh.intel.com (HELO 95dfd251caa2) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Sep 2022 15:58:49 -0700
Received: from kbuild by 95dfd251caa2 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1oUyZk-0003TJ-2O;
        Sun, 04 Sep 2022 22:58:48 +0000
Date:   Mon, 5 Sep 2022 06:57:55 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        will@kernel.org
Cc:     kbuild-all@lists.01.org, lecopzer.chen@mediatek.com,
        acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        davem@davemloft.net, jolsa@redhat.com, jthierry@redhat.com,
        keescook@chromium.org, kernelfans@gmail.com, masahiroy@kernel.org,
        matthias.bgg@gmail.com, maz@kernel.org, mcgrof@kernel.org,
        mingo@redhat.com, namhyung@kernel.org, nixiaoming@huawei.com,
        peterz@infradead.org, pmladek@suse.com, sparclinux@vger.kernel.org,
        sumit.garg@linaro.org, wangqing@vivo.com, yj.chiang@mediatek.com
Subject: Re: [PATCH v7 6/6] arm64: Enable perf events based hard lockup
 detector
Message-ID: <202209050639.jDaWd49E-lkp@intel.com>
References: <20220903093415.15850-7-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220903093415.15850-7-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lecopzer,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm/for-next soc/for-next linus/master v6.0-rc4 next-20220901]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch#_base_tree_information]

url:    https://github.com/intel-lab-lkp/linux/commits/Lecopzer-Chen/Support-hld-delayed-init-based-on-Pseudo-NMI-for/20220903-173641
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: arm64-randconfig-c033-20220904 (https://download.01.org/0day-ci/archive/20220905/202209050639.jDaWd49E-lkp@intel.com/config)
compiler: aarch64-linux-gcc (GCC) 12.1.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/de75eba8785b631eb168737fbff6dc31418cb852
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lecopzer-Chen/Support-hld-delayed-init-based-on-Pseudo-NMI-for/20220903-173641
        git checkout de75eba8785b631eb168737fbff6dc31418cb852
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-12.1.0 make.cross W=1 O=build_dir ARCH=arm64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   aarch64-linux-ld: Unexpected GOT/PLT entries detected!
   aarch64-linux-ld: Unexpected run-time procedure linkages detected!
   aarch64-linux-ld: arch/arm64/kernel/perf_event.o: in function `armv8_pmu_driver_init':
>> arch/arm64/kernel/perf_event.c:1402: undefined reference to `retry_lockup_detector_init'


vim +1402 arch/arm64/kernel/perf_event.c

  1391	
  1392	static int __init armv8_pmu_driver_init(void)
  1393	{
  1394		int ret;
  1395	
  1396		if (acpi_disabled)
  1397			ret = platform_driver_register(&armv8_pmu_driver);
  1398		else
  1399			ret = arm_pmu_acpi_probe(armv8_pmuv3_pmu_init);
  1400	
  1401		if (!ret)
> 1402			retry_lockup_detector_init();
  1403	
  1404		return ret;
  1405	}
  1406	device_initcall(armv8_pmu_driver_init)
  1407	

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
