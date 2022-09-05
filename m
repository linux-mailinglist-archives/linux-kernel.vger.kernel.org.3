Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A2E5AD1B6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:43:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238117AbiIELmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:42:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbiIELmW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:42:22 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 618C35A8A9;
        Mon,  5 Sep 2022 04:42:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662378141; x=1693914141;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CK6a+K6xVlEufmYnfhljih8pAOpl8B6zMfeDVzimZHM=;
  b=SfO0vGxtN+T7Zh6tCmxyEaGbRvOSlHl1xMCvVp3ERcFkwB4X1mZSECCj
   Swxiw2KzBWHV1gettJejL9a2oGV+igin1RFJjMVLJ54da+YZW4A6fiWfN
   ubLhsYuswMTDfLeJRt5sa/zJ0Unu3krYCLsWZ62P+kBplRX81yLsz0F7o
   rdYW5vI1nvr5F4HwIrd7I9Y0oiSMlKqLmt7P8QsJHTPMuEkzOhn8/zyEP
   wJwj3YpxgdjLuQfxbhZ0EzniDgk+HC0d11NJbzcXXk+8USXIoeuITUGlj
   1X1vlHJcpf6A9una5Z2HJu0yjK9hIk0vvFEpAmVNp5BPWBZW+S/z6YSn4
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10460"; a="297159210"
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="297159210"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 04:42:21 -0700
X-IronPort-AV: E=Sophos;i="5.93,291,1654585200"; 
   d="scan'208";a="609653245"
Received: from ahunter6-mobl1.ger.corp.intel.com (HELO ahunter-VirtualBox.home\044ger.corp.intel.com) ([10.252.56.151])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2022 04:42:18 -0700
From:   Adrian Hunter <adrian.hunter@intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: [PATCH V2] libperf evlist: Fix per-thread mmaps for multi-threaded targets
Date:   Mon,  5 Sep 2022 14:42:09 +0300
Message-Id: <20220905114209.8389-1-adrian.hunter@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki, Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The offending commit removed mmap_per_thread(), which did not consider
the different set-output rules for per-thread mmaps i.e. in the per-thread
case set-output is used for file descriptors of the same thread not the
same cpu.

This was not immediately noticed because it only happens with
multi-threaded targets and we do not have a test for that yet.

Reinstate mmap_per_thread() expanding it to cover also system-wide per-cpu
events i.e. to continue to allow the mixing of per-thread and per-cpu
mmaps.

Debug messages (with -vv) show the file descriptors that are opened with
sys_perf_event_open. New debug messages are added (needs -vvv) that show
also which file descriptors are mmapped and which are redirected with
set-output.

In the per-cpu case (cpu != -1) file descriptors for the same CPU are
set-output to the first file descriptor for that CPU.

In the per-thread case (cpu == -1) file descriptors for the same thread are
set-output to the first file descriptor for that thread.

Example (process 17489 has 2 threads):

 Before (but with new debug prints):

   $ perf record --no-bpf-event -vvv --per-thread -p 17489
   <SNIP>
   sys_perf_event_open: pid 17489  cpu -1  group_fd -1  flags 0x8 = 5
   sys_perf_event_open: pid 17490  cpu -1  group_fd -1  flags 0x8 = 6
   <SNIP>
   libperf: idx 0: mmapping fd 5
   libperf: idx 0: set output fd 6 -> 5
   failed to mmap with 22 (Invalid argument)

 After:

   $ perf record --no-bpf-event -vvv --per-thread -p 17489
   <SNIP>
   sys_perf_event_open: pid 17489  cpu -1  group_fd -1  flags 0x8 = 5
   sys_perf_event_open: pid 17490  cpu -1  group_fd -1  flags 0x8 = 6
   <SNIP>
   libperf: mmap_per_thread: nr cpu values (may include -1) 1 nr threads 2
   libperf: idx 0: mmapping fd 5
   libperf: idx 1: mmapping fd 6
   <SNIP>
   [ perf record: Woken up 2 times to write data ]
   [ perf record: Captured and wrote 0.018 MB perf.data (15 samples) ]

Per-cpu example (process 20341 has 2 threads, same as above):

   $ perf record --no-bpf-event -vvv -p 20341
   <SNIP>
   sys_perf_event_open: pid 20341  cpu 0  group_fd -1  flags 0x8 = 5
   sys_perf_event_open: pid 20342  cpu 0  group_fd -1  flags 0x8 = 6
   sys_perf_event_open: pid 20341  cpu 1  group_fd -1  flags 0x8 = 7
   sys_perf_event_open: pid 20342  cpu 1  group_fd -1  flags 0x8 = 8
   sys_perf_event_open: pid 20341  cpu 2  group_fd -1  flags 0x8 = 9
   sys_perf_event_open: pid 20342  cpu 2  group_fd -1  flags 0x8 = 10
   sys_perf_event_open: pid 20341  cpu 3  group_fd -1  flags 0x8 = 11
   sys_perf_event_open: pid 20342  cpu 3  group_fd -1  flags 0x8 = 12
   sys_perf_event_open: pid 20341  cpu 4  group_fd -1  flags 0x8 = 13
   sys_perf_event_open: pid 20342  cpu 4  group_fd -1  flags 0x8 = 14
   sys_perf_event_open: pid 20341  cpu 5  group_fd -1  flags 0x8 = 15
   sys_perf_event_open: pid 20342  cpu 5  group_fd -1  flags 0x8 = 16
   sys_perf_event_open: pid 20341  cpu 6  group_fd -1  flags 0x8 = 17
   sys_perf_event_open: pid 20342  cpu 6  group_fd -1  flags 0x8 = 18
   sys_perf_event_open: pid 20341  cpu 7  group_fd -1  flags 0x8 = 19
   sys_perf_event_open: pid 20342  cpu 7  group_fd -1  flags 0x8 = 20
   <SNIP>
   libperf: mmap_per_cpu: nr cpu values 8 nr threads 2
   libperf: idx 0: mmapping fd 5
   libperf: idx 0: set output fd 6 -> 5
   libperf: idx 1: mmapping fd 7
   libperf: idx 1: set output fd 8 -> 7
   libperf: idx 2: mmapping fd 9
   libperf: idx 2: set output fd 10 -> 9
   libperf: idx 3: mmapping fd 11
   libperf: idx 3: set output fd 12 -> 11
   libperf: idx 4: mmapping fd 13
   libperf: idx 4: set output fd 14 -> 13
   libperf: idx 5: mmapping fd 15
   libperf: idx 5: set output fd 16 -> 15
   libperf: idx 6: mmapping fd 17
   libperf: idx 6: set output fd 18 -> 17
   libperf: idx 7: mmapping fd 19
   libperf: idx 7: set output fd 20 -> 19
   <SNIP>
   [ perf record: Woken up 7 times to write data ]
   [ perf record: Captured and wrote 0.020 MB perf.data (17 samples) ]

Fixes: ae4f8ae16a07 ("libperf evlist: Allow mixing per-thread and per-cpu mmaps")
Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
---


Changes in V2:

	Expand commit message.
	White-space fixups.


 tools/lib/perf/evlist.c | 50 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index e6c98a6e3908..6b1bafe267a4 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -486,6 +486,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			if (ops->idx)
 				ops->idx(evlist, evsel, mp, idx);
 
+			pr_debug("idx %d: mmapping fd %d\n", idx, *output);
 			if (ops->mmap(map, mp, *output, evlist_cpu) < 0)
 				return -1;
 
@@ -494,6 +495,7 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 			if (!idx)
 				perf_evlist__set_mmap_first(evlist, map, overwrite);
 		} else {
+			pr_debug("idx %d: set output fd %d -> %d\n", idx, fd, *output);
 			if (ioctl(fd, PERF_EVENT_IOC_SET_OUTPUT, *output) != 0)
 				return -1;
 
@@ -519,6 +521,48 @@ mmap_per_evsel(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	return 0;
 }
 
+static int
+mmap_per_thread(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
+		struct perf_mmap_param *mp)
+{
+	int nr_threads = perf_thread_map__nr(evlist->threads);
+	int nr_cpus    = perf_cpu_map__nr(evlist->all_cpus);
+	int cpu, thread, idx = 0;
+	int nr_mmaps = 0;
+
+	pr_debug("%s: nr cpu values (may include -1) %d nr threads %d\n",
+		 __func__, nr_cpus, nr_threads);
+
+	/* per-thread mmaps */
+	for (thread = 0; thread < nr_threads; thread++, idx++) {
+		int output = -1;
+		int output_overwrite = -1;
+
+		if (mmap_per_evsel(evlist, ops, idx, mp, 0, thread, &output,
+				   &output_overwrite, &nr_mmaps))
+			goto out_unmap;
+	}
+
+	/* system-wide mmaps i.e. per-cpu */
+	for (cpu = 1; cpu < nr_cpus; cpu++, idx++) {
+		int output = -1;
+		int output_overwrite = -1;
+
+		if (mmap_per_evsel(evlist, ops, idx, mp, cpu, 0, &output,
+				   &output_overwrite, &nr_mmaps))
+			goto out_unmap;
+	}
+
+	if (nr_mmaps != evlist->nr_mmaps)
+		pr_err("Miscounted nr_mmaps %d vs %d\n", nr_mmaps, evlist->nr_mmaps);
+
+	return 0;
+
+out_unmap:
+	perf_evlist__munmap(evlist);
+	return -1;
+}
+
 static int
 mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	     struct perf_mmap_param *mp)
@@ -528,6 +572,8 @@ mmap_per_cpu(struct perf_evlist *evlist, struct perf_evlist_mmap_ops *ops,
 	int nr_mmaps = 0;
 	int cpu, thread;
 
+	pr_debug("%s: nr cpu values %d nr threads %d\n", __func__, nr_cpus, nr_threads);
+
 	for (cpu = 0; cpu < nr_cpus; cpu++) {
 		int output = -1;
 		int output_overwrite = -1;
@@ -569,6 +615,7 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 			  struct perf_evlist_mmap_ops *ops,
 			  struct perf_mmap_param *mp)
 {
+	const struct perf_cpu_map *cpus = evlist->all_cpus;
 	struct perf_evsel *evsel;
 
 	if (!ops || !ops->get || !ops->mmap)
@@ -588,6 +635,9 @@ int perf_evlist__mmap_ops(struct perf_evlist *evlist,
 	if (evlist->pollfd.entries == NULL && perf_evlist__alloc_pollfd(evlist) < 0)
 		return -ENOMEM;
 
+	if (perf_cpu_map__empty(cpus))
+		return mmap_per_thread(evlist, ops, mp);
+
 	return mmap_per_cpu(evlist, ops, mp);
 }
 
-- 
2.25.1

