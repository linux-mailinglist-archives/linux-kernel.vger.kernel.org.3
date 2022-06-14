Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BCA54A94F
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 08:19:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245730AbiFNGT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 02:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiFNGTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 02:19:24 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B579637A15;
        Mon, 13 Jun 2022 23:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1655187563; x=1686723563;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G7Y9H6pjfhFNNFt9HzcJbUr6NMbLnNfbUFKiekG8WDg=;
  b=YhRawurmtmbB0iXr6kylUdarI6HH0udr2jPNiVazbDhrH0dEjOKSdmJZ
   +eBSzFS3PaRt3mtVgVQFAYuiDXjsdAD9DsK9iu03EtE5Y78hc3DFvCDXM
   WH0PygdzXLyoIZbzs7s1ICo/I1xlNRVMWKw+A01H+vcv7JGeDkWxjFVgU
   gpkwGTHQVi90dxeZCIi+HvkNXjpajygWmdPvhpJAgz1YjgZkbNYNekzQT
   +gBnD8JOzXx87X6Gdte2G9jlzg5BebQ51VvSIRCnw/otTEsXGom35boeo
   iuvhAD5umL1bVK/Jg35QMFBUk8ZpwoixdU/qggM6/smT53qa/skGcddT1
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10377"; a="364854844"
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="364854844"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jun 2022 23:19:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,299,1647327600"; 
   d="scan'208";a="588249606"
Received: from lkp-server01.sh.intel.com (HELO 60dabacc1df6) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 13 Jun 2022 23:19:17 -0700
Received: from kbuild by 60dabacc1df6 with local (Exim 4.95)
        (envelope-from <lkp@intel.com>)
        id 1o0ztU-000LYn-QI;
        Tue, 14 Jun 2022 06:19:16 +0000
Date:   Tue, 14 Jun 2022 14:18:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Lecopzer Chen <lecopzer.chen@mediatek.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org, pmladek@suse.com,
        acme@kernel.org, akpm@linux-foundation.org,
        alexander.shishkin@linux.intel.com, catalin.marinas@arm.com,
        davem@davemloft.net, jolsa@redhat.com, jthierry@redhat.com,
        keescook@chromium.org, kernelfans@gmail.com,
        lecopzer.chen@mediatek.com, linux-mediatek@lists.infradead.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        masahiroy@kernel.org, matthias.bgg@gmail.com, maz@kernel.org,
        mcgrof@kernel.org, mingo@redhat.com, namhyung@kernel.org,
        nixiaoming@huawei.com, peterz@infradead.org,
        sparclinux@vger.kernel.org, sumit.garg@linaro.org,
        wangqing@vivo.com, will@kernel.org, yj.chiang@mediatek.com
Subject: Re: [PATCH v5 4/6] kernel/watchdog: Adapt the watchdog_hld interface
 for async model
Message-ID: <202206141412.PeVDy6qk-lkp@intel.com>
References: <20220613135956.15711-5-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220613135956.15711-5-lecopzer.chen@mediatek.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lecopzer,

Thank you for the patch! Yet something to improve:

[auto build test ERROR on arm64/for-next/core]
[also build test ERROR on arm/for-next kvmarm/next soc/for-next]
[cannot apply to xilinx-xlnx/master]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/intel-lab-lkp/linux/commits/Lecopzer-Chen/Support-hld-delayed-init-based-on-Pseudo-NMI-for/20220614-021318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
config: hexagon-randconfig-r024-20220613 (https://download.01.org/0day-ci/archive/20220614/202206141412.PeVDy6qk-lkp@intel.com/config)
compiler: clang version 15.0.0 (https://github.com/llvm/llvm-project d378268ead93c85803c270277f0243737b536ae7)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/intel-lab-lkp/linux/commit/7df94eb967160312b005f9d8a29b558beec2d5a7
        git remote add linux-review https://github.com/intel-lab-lkp/linux
        git fetch --no-tags linux-review Lecopzer-Chen/Support-hld-delayed-init-based-on-Pseudo-NMI-for/20220614-021318
        git checkout 7df94eb967160312b005f9d8a29b558beec2d5a7
        # save the config file
        mkdir build_dir && cp config build_dir/.config
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash

If you fix the issue, kindly add following tag where applicable
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/watchdog.c:915:3: error: use of undeclared identifier 'allow_lockup_detector_init_retry'
                   allow_lockup_detector_init_retry = true;
                   ^
   1 error generated.


vim +/allow_lockup_detector_init_retry +915 kernel/watchdog.c

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
