Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D900485D03
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 01:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343629AbiAFAUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 19:20:08 -0500
Received: from mga14.intel.com ([192.55.52.115]:10921 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239471AbiAFAUF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 19:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641428405; x=1672964405;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=5HtyGvnlTWteMFNvZ2xjw6OkxTEWxiuN5vBSFIaHvTs=;
  b=ENlKxVZQYkdXM3eJVZTPw46rZxA0HM+RP9UpqeKFk2ZOWzcXhsuJF76y
   vbpQURXmittqKkSLnK2Z23y+PfTmc8JroGHFXwA/9/xj0+jiz8FO1OJTg
   5TbwSiVAZFf0uR4pw3sAbOYHy9o9whzIt5YF6AOBYy+/s/JbZ8RM3lf2M
   THjsPD5OleHKi+HJBRWkaXJ6+j6jvcwpZx15jmpUMCxv6luabYh8kGYKs
   kMe/gYJia6q8SLtBxHzOyd5iQ0/NnsVc2TwG6JjdStoAZGIxrS60yLci6
   YQm/mQ2zmBmBx61SLyXK9TeXw2vTf1qIrDEnD7vi65G8FVNpq1CeQoH/z
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="242767667"
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="242767667"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jan 2022 16:20:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,265,1635231600"; 
   d="scan'208";a="689202755"
Received: from lkp-server01.sh.intel.com (HELO e357b3ef1427) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 05 Jan 2022 16:20:01 -0800
Received: from kbuild by e357b3ef1427 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1n5GVc-000HB9-Bk; Thu, 06 Jan 2022 00:20:00 +0000
Date:   Thu, 6 Jan 2022 08:19:54 +0800
From:   kernel test robot <lkp@intel.com>
To:     Stephane Eranian <eranian@google.com>, linux-kernel@vger.kernel.org
Cc:     kbuild-all@lists.01.org, peterz@infradead.org,
        kim.phillips@amd.com, jolsa@redhat.com, namhyung.kim@kernel.org,
        irogers@google.com
Subject: Re: [PATCH] perf/x86/rapl: fix AMD event handling
Message-ID: <202201060859.rVh6PW5V-lkp@intel.com>
References: <20220105185659.643355-1-eranian@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220105185659.643355-1-eranian@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephane,

Thank you for the patch! Perhaps something to improve:

[auto build test WARNING on tip/perf/core]
[also build test WARNING on tip/master linux/master linus/master v5.16-rc8 next-20220105]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Stephane-Eranian/perf-x86-rapl-fix-AMD-event-handling/20220106-025808
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a9f4a6e92b3b319296fb078da2615f618f6cd80c
config: i386-randconfig-s002-20220105 (https://download.01.org/0day-ci/archive/20220106/202201060859.rVh6PW5V-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.4-dirty
        # https://github.com/0day-ci/linux/commit/3c196dc3aa384eb70492fdb07371de164e98e238
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Stephane-Eranian/perf-x86-rapl-fix-AMD-event-handling/20220106-025808
        git checkout 3c196dc3aa384eb70492fdb07371de164e98e238
        # save the config file to linux build tree
        mkdir build_dir
        make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' O=build_dir ARCH=i386 SHELL=/bin/bash arch/x86/events/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)
>> arch/x86/events/rapl.c:540:59: sparse: sparse: Using plain integer as NULL pointer
   arch/x86/events/rapl.c:542:59: sparse: sparse: Using plain integer as NULL pointer
   arch/x86/events/rapl.c:543:59: sparse: sparse: Using plain integer as NULL pointer
   arch/x86/events/rapl.c:544:59: sparse: sparse: Using plain integer as NULL pointer

vim +540 arch/x86/events/rapl.c

   533	
   534	/*
   535	 * Force to PERF_RAPL_MAX size due to:
   536	 * - perf_msr_probe(PERF_RAPL_MAX)
   537	 * - want to use same event codes across both architectures
   538	 */
   539	static struct perf_msr amd_rapl_msrs[] = {
 > 540		[PERF_RAPL_PP0]  = { 0, &rapl_events_cores_group, 0, false, 0 },
   541		[PERF_RAPL_PKG]  = { MSR_AMD_PKG_ENERGY_STATUS,  &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
   542		[PERF_RAPL_RAM]  = { 0, &rapl_events_ram_group,   0, false, 0 },
   543		[PERF_RAPL_PP1]  = { 0, &rapl_events_gpu_group,   0, false, 0 },
   544		[PERF_RAPL_PSYS] = { 0, &rapl_events_psys_group,  0, false, 0 },
   545	};
   546	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
