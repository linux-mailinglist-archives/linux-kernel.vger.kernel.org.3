Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7C154A902
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 07:59:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237697AbiFNF6q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 01:58:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238715AbiFNF6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 01:58:23 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA17131220;
        Mon, 13 Jun 2022 22:58:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655186302; x=1686722302;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ywmOAFbDeYJlfmJGeX0tKQffJo9BReoENhKIXWT7mPc=;
  b=LFp7uQMxwyipr/j5X73dOetV95zY5CkJlbpVhsByl46PVh6l5/sQyTU0
   ALSB4D3qmqe1UDENn7STscG2rXKpOOFOkE6l0e+lJB7WbubkAFI3JrUpr
   e0sIKyN8XVyQxCzjsNrAR5j9a7N0kh+DiU8s4V/pFub4lVJu0ZjSfUEYo
   ofIOHhf+WV8CVxaLy6joHaAr+hlSxLCrGmWXV1jEauQq/dy0W9u5DcKzG
   0ovMbQoRNDNDRSbQwDUci5+Y59x61ajS67H4a6Xyf31+Uq5wOgm/6DcQq
   jJWVYM72YYt9wzwXXC/aZntSZpFvBf4hCOLTyqiNMyRIzX64HXYjssZ1L
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="258347353"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="258347353"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 22:58:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="830209036"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 13 Jun 2022 22:58:16 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0zZ9-000LXv-Jb;
        Tue, 14 Jun 2022 05:58:15 +0000
Date:   Tue, 14 Jun 2022 13:57:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, pmladek@suse.com, acme@kernel.org,
        akpm@linux-foundation.org, alexander.shishkin@linux.intel.com,
        catalin.marinas@arm.com, davem@davemloft.net, jolsa@redhat.com,
        jthierry@redhat.com, keescook@chromium.org, kernelfans@gmail.com,
        lecopzer.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        masahiroy@kernel.org, matthias.bgg@gmail.com, maz@kernel.org,
        mcgrof@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        nixiaoming@huawei.com, peterz@infradead.org,
        sparclinux@vger.kernel.org, sumit.garg@linaro.org,
        wangqing@vivo.com, will@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH v5 4/6] kernel/watchdog: Adapt the watchdog_hld interface
 for async model
Message-ID: <202206141348.e7aqnN0q-lkp@intel.com>
References: <20220613135956.15711-5-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613135956.15711-5-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lecopzer,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm/for-next kvmarm/next soc/for-next linus/master v5.19-rc2 next-20220610]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Lecopzer-Chen/Support-hld-delayed-init-based-on-Pseudo-NMI-for/20220614-021318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: sparc64-randconfig-r026-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141348.e7aqnN0q-lkp@intel.com/config)
compiler: sparc64-linux-gcc (GCC) 11.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7df94eb967160312b005f9d8a29b558beec2d5a7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lecopzer-Chen/Support-hld-delayed-init-based-on-Pseudo-NMI-for/20220614-021318
        git checkout 7df94eb967160312b005f9d8a29b558beec2d5a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-11.3.0 make.cross W=1 O=build_dir ARCH=sparc64 SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   kernel/watchdog.c: In function 'lockup_detector_init':
>> kernel/watchdog.c:915:17: error: 'allow_lockup_detector_init_retry' undeclared (first use in this function); did you mean 'retry_lockup_detector_init'?
     915 |                 allow_lockup_detector_init_retry = true;
         |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
         |                 retry_lockup_detector_init
   kernel/watchdog.c:915:17: note: each undeclared identifier is reported only once for each function it appears in


vim +915 kernel/watchdog.c

   903	
   904	void __init lockup_detector_init(void)
   905	{
   906		if (tick_nohz_full_enabled())
   907			pr_info("Disabling watchdog on nohz_full cores by default\n");
   908	
   909		cpumask_copy(&watchdog_cpumask,
   910			     housekeeping_cpumask(HK_TYPE_TIMER));
   911	
   912		if (!watchdog_nmi_probe())
   913			nmi_watchdog_available = true;
   914		else
 > 915			allow_lockup_detector_init_retry = true;

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp
