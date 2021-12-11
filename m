Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 036DB471113
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 04:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244232AbhLKDLI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 22:11:08 -0500
Received: from mga01.intel.com ([192.55.52.88]:30026 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229886AbhLKDLG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 22:11:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639192050; x=1670728050;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=krqBOWpoFtXQHy+HYA4bI1jmOc5SN40WXu3YXX3xZoY=;
  b=J2A/esDZf8UxdsUfOoUzj2Eg3f2pQjXuFsGcvwAt5iADjVz86NCSsyBz
   ZK9HYem4OrMAEByvX8cPnkxLcbsO/WwQdXcFQH8ZJ7m21ObsJFJKWh3Ru
   6pS8GcuxCaYqeefQZjpq4JSr6QCEDJ2t4ziJLA1HiArvtHKsGrx7AYsk/
   aLyRMAVD4ZA8lweoy/0uxbTA1WKqeKMG+E4tdys2LWPm0LrQyWUukM5kI
   uxse2L4c3PIYAJOzb7JUCQnpxNCrsf+TxODkujK8vVHbUBKkL+Hki91n/
   G2giJSKus6v/nvNKpd2SmlpLTHLeis8UQE+nuXiISpuwzdXAld/qBDrtH
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10194"; a="262615590"
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="262615590"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2021 19:07:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,197,1635231600"; 
   d="scan'208";a="517495087"
Received: from lkp-server02.sh.intel.com (HELO 9e1e9f9b3bcb) ([10.239.97.151])
  by fmsmga007.fm.intel.com with ESMTP; 10 Dec 2021 19:07:27 -0800
Received: from kbuild by 9e1e9f9b3bcb with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1mvsjO-000416-AH; Sat, 11 Dec 2021 03:07:26 +0000
Date:   Sat, 11 Dec 2021 11:06:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     llvm@lists.linux.dev, kbuild-all@lists.01.org,
        Ingo Molnar <mingo@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>
Subject: Re: [PATCH] perf/core: Fix cgroup event list management
Message-ID: <202112111047.pgCIWSVK-lkp@intel.com>
References: <20211211000652.1836690-1-namhyung@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211211000652.1836690-1-namhyung@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Namhyung,

I love your patch! Yet something to improve:

[auto build test ERROR on tip/perf/core]
[also build test ERROR on tip/master linux/master linus/master v5.16-rc4]
[If your patch is applied to the wrong git tree, kindly drop us a note.
And when submitting patch, we suggest to use '--base' as documented in
https://git-scm.com/docs/git-format-patch]

url:    https://github.com/0day-ci/linux/commits/Namhyung-Kim/perf-core-Fix-cgroup-event-list-management/20211211-080810
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git a9f4a6e92b3b319296fb078da2615f618f6cd80c
config: hexagon-randconfig-r045-20211210 (https://download.01.org/0day-ci/archive/20211211/202112111047.pgCIWSVK-lkp@intel.com/config)
compiler: clang version 14.0.0 (https://github.com/llvm/llvm-project 097a1cb1d5ebb3a0ec4bcaed8ba3ff6a8e33c00a)
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # https://github.com/0day-ci/linux/commit/226bdbf0501464bc088d582c02d0495a61a68b7c
        git remote add linux-review https://github.com/0day-ci/linux
        git fetch --no-tags linux-review Namhyung-Kim/perf-core-Fix-cgroup-event-list-management/20211211-080810
        git checkout 226bdbf0501464bc088d582c02d0495a61a68b7c
        # save the config file to linux build tree
        mkdir build_dir
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross W=1 O=build_dir ARCH=hexagon SHELL=/bin/bash kernel/events/

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

>> kernel/events/core.c:2391:58: error: no member named 'nr_cgroups' in 'struct perf_event_context'
           if (!ctx->is_active && (!is_cgroup_event(event) || ctx->nr_cgroups > 1)) {
                                                              ~~~  ^
   kernel/events/core.c:2867:30: error: no member named 'nr_cgroups' in 'struct perf_event_context'
               ctx->nr_events && (ctx->nr_cgroups || !is_cgroup_event(event))) {
                                  ~~~  ^
   2 errors generated.


vim +2391 kernel/events/core.c

  2368	
  2369	/*
  2370	 * Remove the event from a task's (or a CPU's) list of events.
  2371	 *
  2372	 * If event->ctx is a cloned context, callers must make sure that
  2373	 * every task struct that event->ctx->task could possibly point to
  2374	 * remains valid.  This is OK when called from perf_release since
  2375	 * that only calls us on the top-level context, which can't be a clone.
  2376	 * When called from perf_event_exit_task, it's OK because the
  2377	 * context has been detached from its task.
  2378	 */
  2379	static void perf_remove_from_context(struct perf_event *event, unsigned long flags)
  2380	{
  2381		struct perf_event_context *ctx = event->ctx;
  2382	
  2383		lockdep_assert_held(&ctx->mutex);
  2384	
  2385		/*
  2386		 * Because of perf_event_exit_task(), perf_remove_from_context() ought
  2387		 * to work in the face of TASK_TOMBSTONE, unlike every other
  2388		 * event_function_call() user.
  2389		 */
  2390		raw_spin_lock_irq(&ctx->lock);
> 2391		if (!ctx->is_active && (!is_cgroup_event(event) || ctx->nr_cgroups > 1)) {
  2392			__perf_remove_from_context(event, __get_cpu_context(ctx),
  2393						   ctx, (void *)flags);
  2394			raw_spin_unlock_irq(&ctx->lock);
  2395			return;
  2396		}
  2397		raw_spin_unlock_irq(&ctx->lock);
  2398	
  2399		event_function_call(event, __perf_remove_from_context, (void *)flags);
  2400	}
  2401	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
