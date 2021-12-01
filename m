Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4F07464948
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 09:08:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347367AbhLAILh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 03:11:37 -0500
Received: from mga09.intel.com ([134.134.136.24]:41387 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345609AbhLAILg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 03:11:36 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236230719"
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="236230719"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Dec 2021 00:08:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,278,1631602800"; 
   d="scan'208";a="477454963"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 01 Dec 2021 00:08:13 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msKey-000EZU-Dy; Wed, 01 Dec 2021 08:08:12 +0000
Date:   Wed, 1 Dec 2021 16:08:00 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        kim.phillips@amd.com, acme@redhat.com, jolsa@redhat.com,
        songliubraving@fb.com, mpe@ellerman.id.au, maddy@linux.ibm.com
Subject: Re: [PATCH v3 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling
 support
Message-ID: <202112011510.OtPtAkKQ-lkp@intel.com>
References: <20211201010217.886919-4-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201010217.886919-4-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on tip/x86/core rafael-pm/linux-next v5.16-rc3 next-20211201]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stephane-Eranian/perf-x86-amd-Add-AMD-Fam19h-Branch-Sampling-support/20211201-090506
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a9f4a6e92b3b319296fb078da2615f618f6cd80c
config: i386-randconfig-a012-20211129 (https://download.01.org/0day-ci/archive/20211201/202112011510.OtPtAkKQ-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 25eb7fa01d7ebbe67648ea03841cda55b4239ab2)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/c6b0817d81501a8bc31ddd7067697dba4408d75f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stephane-Eranian/perf-x86-amd-Add-AMD-Fam19h-Branch-Sampling-support/20211201-090506
        git checkout c6b0817d81501a8bc31ddd7067697dba4408d75f
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/events/amd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> arch/x86/events/amd/core.c:676:24: warning: variable 'hwc' set but not used [-Wunused-but-set-variable]
           struct hw_perf_event *hwc;
                                 ^
   1 warning generated.


vim +/hwc +676 arch/x86/events/amd/core.c

   672	
   673	static void amd_pmu_enable_all(int added)
   674	{
   675		struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 > 676		struct hw_perf_event *hwc;
   677		int idx;
   678	
   679		amd_brs_enable_all();
   680	
   681		for (idx = 0; idx < x86_pmu.num_counters; idx++) {
   682			hwc = &cpuc->events[idx]->hw;
   683	
   684			/* only activate events which are marked as active */
   685			if (!test_bit(idx, cpuc->active_mask))
   686				continue;
   687	
   688			amd_pmu_enable_event(cpuc->events[idx]);
   689		}
   690	}
   691	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
