Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6101651D78E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 14:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391763AbiEFM3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 08:29:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiEFM3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 08:29:48 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BE725D66F
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 05:26:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1651839965; x=1683375965;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qKZzNAZ7op04yD3yd0lotkKXQcQhZnjBxjAOXiohnpM=;
  b=EoRjVvKwIxIqQUzt3Y5gg6ixOXuZuqGaZXqrcPQ+tgZ3Ezgf2tv6jNDP
   FDreF5QFYXc+I0HtaF/NnKUkaGHpR5CUE50ZF1sLp+fwVr/T3yrUHApyt
   H6MrXI9K8fQ9yNntkctzI0uLPUh4JgN2qBCXhSqmCuKatutcuDYqYy2MK
   u5dMa7Xd7JdMs4dbRvBsjL5+XrkUD7AB6x35UiG/7LQzWgSxxg/1Trrmd
   L+Ix0cJwyOMm7MlckLpRdX8Vn9OuIk3vwdg6Y/YgEqccX7eNzbnRlSic3
   TNapvZH/uzbnIINxbgzMm0Yy9OmmwYlaLV6mV2F5MWJbzr2DXPyb87OXW
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10338"; a="266045725"
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="266045725"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 May 2022 05:26:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,203,1647327600"; 
   d="scan'208";a="709440647"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by fmsmga001.fm.intel.com with ESMTP; 06 May 2022 05:26:02 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH V2 00/23] perf intel-pt: Better support for perf record --cpu
Date:   Fri,  6 May 2022 15:25:38 +0300
Message-Id: <20220506122601.367589-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are V2 patches to support capturing Intel PT sideband events such as
mmap, task, context switch, text poke etc, on every CPU even when tracing
selected user_requested_cpus.  That is, when using the perf record -C or
 --cpu option.

This is needed for:
1. text poke: a text poke on any CPU affects all CPUs
2. tracing user space: a user space process can migrate between CPUs so
mmap events that happen on a different CPU can be needed to decode a
user_requested_cpus CPU.

For example:

	Trace on CPU 1:

	perf record --kcore -C 1 -e intel_pt// &

	Start a task on CPU 0:

	taskset 0x1 testprog &

	Migrate it to CPU 1:

	taskset -p 0x2 <testprog pid>

	Stop tracing:

	kill %1

	Prior to these changes there will be errors decoding testprog
	in userspace because the comm and mmap events for testprog will not
	have been captured.

There is quite a bit of preparation:

The first patch is a small Intel PT test for system-wide side band.  The
test fails before the patches are applied, passed afterwards.

      perf intel-pt: Add a test for system-wide side band [new in V1]

The next 5 patches stop auxtrace mixing up mmap idx between evlist and
evsel.  That is going to matter when
evlist->all_cpus != evlist->user_requested_cpus != evsel->cpus:

      libperf evsel: Factor out perf_evsel__ioctl() [now applied]
      libperf evsel: Add perf_evsel__enable_thread()
      perf evlist: Use libperf functions in evlist__enable_event_idx()
      perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
      perf auxtrace: Do not mix up mmap idx

The next 6 patches stop attempts to auxtrace mmap when it is not an
auxtrace event e.g. when mmapping the CPUs on which only sideband is
captured:

      libperf evlist: Remove ->idx() per_cpu parameter
      libperf evlist: Move ->idx() into mmap_per_evsel()
      libperf evlist: Add evsel as a parameter to ->idx()
      perf auxtrace: Record whether an auxtrace mmap is needed
      perf auxctrace: Add mmap_needed to auxtrace_mmap_params
      perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter

The next 5 patches switch to setting up dummy event maps before adding the
evsel so that the evsel is subject to map propagation, primarily to cause
addition of the evsel's CPUs to all_cpus.

      perf evlist: Factor out evlist__dummy_event()
      perf evlist: Add evlist__add_system_wide_dummy()
      perf record: Use evlist__add_system_wide_dummy() in record__config_text_poke()
      perf intel-pt: Use evlist__add_system_wide_dummy() for switch tracking
      perf intel-pt: Track sideband system-wide when needed

The remaining patches make more significant changes.

First change from using user_requested_cpus to using all_cpus where necessary:

      perf tools: Allow all_cpus to be a superset of user_requested_cpus

Secondly, mmap all per-thread and all per-cpu events:

      libperf evlist: Allow mixing per-thread and per-cpu mmaps
      libperf evlist: Check nr_mmaps is correct [new in V1]

Stop using system_wide flag for uncore because it will not work anymore:

      perf stat: Add requires_cpu flag for uncore
      libperf evsel: Add comments for booleans [new in V1]

Finally change map propagation so that system-wide events retain their cpus and
(dummy) threads:

      perf tools: Allow system-wide events to keep their own CPUs
      perf tools: Allow system-wide events to keep their own threads


Changes in V2:

	Added some Acked-by: Ian Rogers <irogers@google.com>

      libperf evsel: Add perf_evsel__enable_thread()
	Use perf_cpu_map__for_each_cpu()

      perf auxtrace: Add mmap_needed to auxtrace_mmap_params
	Add documentation comment for mmap_needed

      perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
	Fix missing auxtrace_mmap_params__set_idx change

      libperf evlist: Check nr_mmaps is correct
	Remove unused code

      libperf evsel: Add comments for booleans
	Amend comments

      perf evlist: Add evlist__add_dummy_on_all_cpus()
	Rename evlist__add_system_wide -> evlist__add_on_all_cpus
	Changed patch subject accordingly

      perf record: Use evlist__add_dummy_on_all_cpus() in record__config_text_poke()
	Rename evlist__add_system_wide -> evlist__add_on_all_cpus
	Changed patch subject accordingly

      perf intel-pt: Use evlist__add_dummy_on_all_cpus() for switch tracking
	Rename evlist__add_system_wide -> evlist__add_on_all_cpus
	Changed patch subject accordingly

Changes in V1:

      perf intel-pt: Add a test for system-wide side band
	New patch

      libperf evsel: Factor out perf_evsel__ioctl()
	Dropped because it has been applied.

      libperf evsel: Add perf_evsel__enable_thread()
	Rename variable i -> idx

      perf auxtrace: Do not mix up mmap idx
	Rename variable cpu to cpu_map_idx

      perf tools: Allow all_cpus to be a superset of user_requested_cpus
	Add Acked-by: Ian Rogers <irogers@google.com>

      libperf evlist: Allow mixing per-thread and per-cpu mmaps
	Fix perf_evlist__nr_mmaps() calculation

      libperf evlist: Check nr_mmaps is correct
	New patch

      libperf evsel: Add comments for booleans
	New patch

      perf tools: Allow system-wide events to keep their own CPUs
      perf tools: Allow system-wide events to keep their own threads


Adrian Hunter (23):
      perf intel-pt: Add a test for system-wide side band
      libperf evsel: Add perf_evsel__enable_thread()
      perf evlist: Use libperf functions in evlist__enable_event_idx()
      perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
      perf auxtrace: Do not mix up mmap idx
      libperf evlist: Remove ->idx() per_cpu parameter
      libperf evlist: Move ->idx() into mmap_per_evsel()
      libperf evlist: Add evsel as a parameter to ->idx()
      perf auxtrace: Record whether an auxtrace mmap is needed
      perf auxtrace: Add mmap_needed to auxtrace_mmap_params
      perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
      perf evlist: Factor out evlist__dummy_event()
      perf evlist: Add evlist__add_dummy_on_all_cpus()
      perf record: Use evlist__add_dummy_on_all_cpus() in record__config_text_poke()
      perf intel-pt: Use evlist__add_dummy_on_all_cpus() for switch tracking
      perf intel-pt: Track sideband system-wide when needed
      perf tools: Allow all_cpus to be a superset of user_requested_cpus
      libperf evlist: Allow mixing per-thread and per-cpu mmaps
      libperf evlist: Check nr_mmaps is correct
      perf stat: Add requires_cpu flag for uncore
      libperf evsel: Add comments for booleans
      perf tools: Allow system-wide events to keep their own CPUs
      perf tools: Allow system-wide events to keep their own threads

 tools/lib/perf/evlist.c                  |  80 ++++++++++-------------
 tools/lib/perf/evsel.c                   |  15 +++++
 tools/lib/perf/include/internal/evlist.h |   3 +-
 tools/lib/perf/include/internal/evsel.h  |  10 +++
 tools/lib/perf/include/perf/evsel.h      |   1 +
 tools/perf/arch/arm/util/cs-etm.c        |   1 +
 tools/perf/arch/arm64/util/arm-spe.c     |   1 +
 tools/perf/arch/s390/util/auxtrace.c     |   1 +
 tools/perf/arch/x86/util/intel-bts.c     |   1 +
 tools/perf/arch/x86/util/intel-pt.c      |  32 ++++------
 tools/perf/builtin-record.c              |  39 +++++-------
 tools/perf/builtin-stat.c                |   5 +-
 tools/perf/tests/shell/test_intel_pt.sh  |  71 +++++++++++++++++++++
 tools/perf/util/auxtrace.c               |  31 +++++++--
 tools/perf/util/auxtrace.h               |  10 +--
 tools/perf/util/evlist.c                 | 106 +++++++++++++++----------------
 tools/perf/util/evlist.h                 |   7 +-
 tools/perf/util/evsel.c                  |   1 +
 tools/perf/util/evsel.h                  |   1 +
 tools/perf/util/mmap.c                   |   4 +-
 tools/perf/util/parse-events.c           |   2 +-
 21 files changed, 261 insertions(+), 161 deletions(-)
 create mode 100755 tools/perf/tests/shell/test_intel_pt.sh


Regards
Adrian
