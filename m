Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54B494645A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 05:03:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346498AbhLAEGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 23:06:25 -0500
Received: from mga03.intel.com ([134.134.136.65]:42445 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241642AbhLAEGY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 23:06:24 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10184"; a="236321034"
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="236321034"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2021 20:03:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,277,1631602800"; 
   d="scan'208";a="459106456"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by orsmga003.jf.intel.com with ESMTP; 30 Nov 2021 20:03:01 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1msGph-000EBl-6x; Wed, 01 Dec 2021 04:03:01 +0000
Date:   Wed, 1 Dec 2021 12:02:56 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Subject: Re: [PATCH v3 03/13] perf/x86/amd: add AMD Fam19h Branch Sampling
 support
Message-ID: <202112011125.Yf5fkhH3-lkp@intel.com>
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
[also build test WARNING on tip/x86/core rafael-pm/linux-next v5.16-rc3 next-20211130]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stephane-Eranian/perf-x86-amd-Add-AMD-Fam19h-Branch-Sampling-support/20211201-090506
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a9f4a6e92b3b319296fb078da2615f618f6cd80c
config: i386-tinyconfig (https://download.01.org/0day-ci/archive/20211201/202112011125.Yf5fkhH3-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce (this is a W=1 build):
        # https://github.com/0day-ci/linux/commit/c6b0817d81501a8bc31ddd7067697dba4408d75f
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stephane-Eranian/perf-x86-amd-Add-AMD-Fam19h-Branch-Sampling-support/20211201-090506
        git checkout c6b0817d81501a8bc31ddd7067697dba4408d75f
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/events/amd/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

   arch/x86/events/amd/core.c: In function 'amd_pmu_enable_all':
>> arch/x86/events/amd/core.c:676:24: warning: variable 'hwc' set but not used [-Wunused-but-set-variable]
     676 |  struct hw_perf_event *hwc;
         |                        ^~~


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
