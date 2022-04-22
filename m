Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BB950BCD7
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383952AbiDVQ13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiDVQ1T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:27:19 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 257985E143
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650644666; x=1682180666;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TKgefd9kZw4nzXH+rdQzqXrAfJ25MnBJjQ2YMph/Rk4=;
  b=Kptznh09lRCdjRCjO0BkaNpEWG1fn6tjFwCZZw1OA3eUTH9uWMtyilO0
   DPlw9W4RytlJPNmWNj8vg4vZTaeXx66TFHxV/AEnOItLVT8hu6M/m/GHJ
   vtSi3jbR19CuKKi4LuR2XUVtLZcG9D7jEKNhfVwXi2UfNtm0lBqSNyICY
   icaXwYQ6EEaCeOEcEENgeMHsvfXuGTCIfvcYFyhEouGR5SiZSY4yhvE+p
   vJhtADpvMp4N17jC9x+zGyngZbmus4QiEHT75VHk29Bphw126fAqSPJTr
   oAX2HKHEVwGdX1mE04cD4hj3aiHqYDLzXaqkr/3glTdIdd9WJ/PL+kcIX
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264885772"
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="264885772"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2022 09:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,282,1643702400"; 
   d="scan'208";a="577978561"
Received: from ahunter-desktop.fi.intel.com ([10.237.72.92])
  by orsmga008.jf.intel.com with ESMTP; 22 Apr 2022 09:24:03 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Ian Rogers <irogers@google.com>,
        Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org
Subject: [PATCH RFC 00/21] perf intel-pt: Better support for perf record --cpu
Date:   Fri, 22 Apr 2022 19:23:41 +0300
Message-Id: <20220422162402.147958-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

Here are patches to support capturing Intel PT sideband events such as
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

The first 5 patches stop auxtrace mixing up mmap idx between evlist and
evsel.  That is going to matter when
evlist->all_cpus != evlist->user_requested_cpus != evsel->cpus:

      libperf evsel: Factor out perf_evsel__ioctl()
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

The remaining 5 patches make more significant changes.

First change from using user_requested_cpus to using all_cpus where necessary:

      perf tools: Allow all_cpus to be a superset of user_requested_cpus

Secondly, mmap all per-thread and all per-cpu events:

      libperf evlist: Allow mixing per-thread and per-cpu mmaps

Stop using system_wide flag for uncore because it will not work anymore:

      perf stat: Add per_cpu_only flag for uncore

Finally change map propagation so that system-wide events retain their cpus and
(dummy) threads:

      perf tools: Allow system-wide events to keep their own CPUs
      perf tools: Allow system-wide events to keep their own threads


Adrian Hunter (21):
      libperf evsel: Factor out perf_evsel__ioctl()
      libperf evsel: Add perf_evsel__enable_thread()
      perf evlist: Use libperf functions in evlist__enable_event_idx()
      perf auxtrace: Move evlist__enable_event_idx() to auxtrace.c
      perf auxtrace: Do not mix up mmap idx
      libperf evlist: Remove ->idx() per_cpu parameter
      libperf evlist: Move ->idx() into mmap_per_evsel()
      libperf evlist: Add evsel as a parameter to ->idx()
      perf auxtrace: Record whether an auxtrace mmap is needed
      perf auxctrace: Add mmap_needed to auxtrace_mmap_params
      perf auxtrace: Remove auxtrace_mmap_params__set_idx() per_cpu parameter
      perf evlist: Factor out evlist__dummy_event()
      perf evlist: Add evlist__add_system_wide_dummy()
      perf record: Use evlist__add_system_wide_dummy() in record__config_text_poke()
      perf intel-pt: Use evlist__add_system_wide_dummy() for switch tracking
      perf intel-pt: Track sideband system-wide when needed
      perf tools: Allow all_cpus to be a superset of user_requested_cpus
      libperf evlist: Allow mixing per-thread and per-cpu mmaps
      perf stat: Add per_cpu_only flag for uncore
      perf tools: Allow system-wide events to keep their own CPUs
      perf tools: Allow system-wide events to keep their own threads

 tools/lib/perf/evlist.c                  |  67 +++++++------------
 tools/lib/perf/evsel.c                   |  29 +++++++--
 tools/lib/perf/include/internal/evlist.h |   3 +-
 tools/lib/perf/include/internal/evsel.h  |   1 +
 tools/lib/perf/include/perf/evsel.h      |   1 +
 tools/perf/arch/arm/util/cs-etm.c        |   1 +
 tools/perf/arch/arm64/util/arm-spe.c     |   1 +
 tools/perf/arch/s390/util/auxtrace.c     |   1 +
 tools/perf/arch/x86/util/intel-bts.c     |   1 +
 tools/perf/arch/x86/util/intel-pt.c      |  32 ++++------
 tools/perf/builtin-record.c              |  39 +++++-------
 tools/perf/builtin-stat.c                |   5 +-
 tools/perf/util/auxtrace.c               |  31 +++++++--
 tools/perf/util/auxtrace.h               |   8 ++-
 tools/perf/util/evlist.c                 | 106 +++++++++++++++----------------
 tools/perf/util/evlist.h                 |   7 +-
 tools/perf/util/evsel.c                  |   1 +
 tools/perf/util/evsel.h                  |   1 +
 tools/perf/util/mmap.c                   |   4 +-
 tools/perf/util/parse-events.c           |   2 +-
 20 files changed, 176 insertions(+), 165 deletions(-)


Regards
Adrian
