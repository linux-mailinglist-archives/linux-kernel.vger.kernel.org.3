Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E248491066
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242803AbiAQSf5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:35:57 -0500
Received: from mga12.intel.com ([192.55.52.136]:48633 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242784AbiAQSfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:35:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444535; x=1673980535;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=r20iCj4310PzijzGGoig5msS5MWyzTL+7iY5DnpEZuM=;
  b=fFIg+Dtsxl/fB7Yym+QDSx7sXg5eMJeG//XEB+3Mifo9Hvz5/zgEqXKq
   or0hm5Nsa8ySk89pAo8ZPjZdPlo0Lj0sTWu3VM33uHrRV2kmQOimKQwct
   sVTIK0Kn1x3PzgXA5SffO0X1bGHJ1DciPNezwMhnNFCYvu4I0J24QhRD1
   9b+mq4Y4XRk/K1PkaRYCqdpk4DwLOl1nn/xb8dbMQsyUnZ0wtzj+SNJXx
   AS/oXSop+A22qf2XsSFu/EF/5HXK2mwYB/jHq/u//8w0kXsCsUgkUZtIc
   AiMBKJR2eLOPcxJ0qRSIX71qr5L7hFryfWlLxWdk6+fJjqergY5cVjVU+
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224656057"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224656057"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:35:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434307"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:35:20 -0800
From:   Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
Cc:     Jiri Olsa <jolsa@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Antonov <alexander.antonov@linux.intel.com>,
        Alexei Budankov <abudankov@huawei.com>,
        Riccardo Mancini <rickyman7@gmail.com>
Subject: [PATCH v13 13/16] perf record: Extend --threads command line option
Date:   Mon, 17 Jan 2022 21:34:33 +0300
Message-Id: <079e2619be70c465317cf7c9fdaf5fa069728c32.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend --threads option in perf record command line interface.
The option can have a value in the form of masks that specify
CPUs to be monitored with data streaming threads and its layout
in system topology. The masks can be filtered using CPU mask
provided via -C option.

The specification value can be user defined list of masks. Masks
separated by colon define CPUs to be monitored by one thread and
affinity mask of that thread is separated by slash. For example:
<cpus mask 1>/<affinity mask 1>:<cpu mask 2>/<affinity mask 2>
specifies parallel threads layout that consists of two threads
with corresponding assigned CPUs to be monitored.

The specification value can be a string e.g. "cpu", "core" or
"package" meaning creation of data streaming thread for every
CPU or core or package to monitor distinct CPUs or CPUs grouped
by core or package.

The option provided with no or empty value defaults to per-cpu
parallel threads layout creating data streaming thread for every
CPU being monitored.

Document --threads option syntax and parallel data streaming modes
in Documentation/perf-record.txt.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Suggested-by: Namhyung Kim <namhyung@kernel.org>
Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  34 ++-
 tools/perf/builtin-record.c              | 318 ++++++++++++++++++++++-
 tools/perf/util/record.h                 |   1 +
 3 files changed, 349 insertions(+), 4 deletions(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index b9c6b112bf46..465be4e62a17 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -713,9 +713,39 @@ measurements:
  wait -n ${perf_pid}
  exit $?
 
---threads::
+--threads=<spec>::
 Write collected trace data into several data files using parallel threads.
-The option creates a data streaming thread for each CPU in the system.
+<spec> value can be user defined list of masks. Masks separated by colon
+define CPUs to be monitored by a thread and affinity mask of that thread
+is separated by slash:
+
+    <cpus mask 1>/<affinity mask 1>:<cpus mask 2>/<affinity mask 2>:...
+
+CPUs or affinity masks must not overlap with other corresponding masks.
+Invalid CPUs are ignored, but masks containing only invalid CPUs are not
+allowed.
+
+For example user specification like the following:
+
+    0,2-4/2-4:1,5-7/5-7
+
+specifies parallel threads layout that consists of two threads,
+the first thread monitors CPUs 0 and 2-4 with the affinity mask 2-4,
+the second monitors CPUs 1 and 5-7 with the affinity mask 5-7.
+
+<spec> value can also be a string meaning predefined parallel threads
+layout:
+
+    cpu    - create new data streaming thread for every monitored cpu
+    core   - create new thread to monitor CPUs grouped by a core
+    package - create new thread to monitor CPUs grouped by a package
+    numa   - create new threed to monitor CPUs grouped by a NUMA domain
+
+Predefined layouts can be used on systems with large number of CPUs in
+order not to spawn multiple per-cpu streaming threads but still avoid LOST
+events in data directory files. Option specified with no or empty value
+defaults to CPU layout. Masks defined or provided by the option value are
+filtered through the mask provided by -C option.
 
 include::intel-hybrid.txt[]
 
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index ba1622a192a9..e60bf0e3bc25 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -51,6 +51,7 @@
 #include "util/evlist-hybrid.h"
 #include "asm/bug.h"
 #include "perf.h"
+#include "cputopo.h"
 
 #include <errno.h>
 #include <inttypes.h>
@@ -130,6 +131,15 @@ static const char *thread_msg_tags[THREAD_MSG__MAX] = {
 enum thread_spec {
 	THREAD_SPEC__UNDEFINED = 0,
 	THREAD_SPEC__CPU,
+	THREAD_SPEC__CORE,
+	THREAD_SPEC__PACKAGE,
+	THREAD_SPEC__NUMA,
+	THREAD_SPEC__USER,
+	THREAD_SPEC__MAX,
+};
+
+static const char *thread_spec_tags[THREAD_SPEC__MAX] = {
+	"undefined", "cpu", "core", "package", "numa", "user"
 };
 
 struct record {
@@ -2775,10 +2785,31 @@ static void record__thread_mask_free(struct thread_mask *mask)
 
 static int record__parse_threads(const struct option *opt, const char *str, int unset)
 {
+	int s;
 	struct record_opts *opts = opt->value;
 
-	if (unset || !str || !strlen(str))
+	if (unset || !str || !strlen(str)) {
 		opts->threads_spec = THREAD_SPEC__CPU;
+	} else {
+		for (s = 1; s < THREAD_SPEC__MAX; s++) {
+			if (s == THREAD_SPEC__USER) {
+				opts->threads_user_spec = strdup(str);
+				if (!opts->threads_user_spec)
+					return -ENOMEM;
+				opts->threads_spec = THREAD_SPEC__USER;
+				break;
+			}
+			if (!strncasecmp(str, thread_spec_tags[s], strlen(thread_spec_tags[s]))) {
+				opts->threads_spec = s;
+				break;
+			}
+		}
+	}
+
+	if (opts->threads_spec == THREAD_SPEC__USER)
+		pr_debug("threads_spec: %s\n", opts->threads_user_spec);
+	else
+		pr_debug("threads_spec: %s\n", thread_spec_tags[opts->threads_spec]);
 
 	return 0;
 }
@@ -3273,6 +3304,21 @@ static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_c
 		set_bit(cpus->map[c].cpu, mask->bits);
 }
 
+static int record__mmap_cpu_mask_init_spec(struct mmap_cpu_mask *mask, const char *mask_spec)
+{
+	struct perf_cpu_map *cpus;
+
+	cpus = perf_cpu_map__new(mask_spec);
+	if (!cpus)
+		return -ENOMEM;
+
+	bitmap_zero(mask->bits, mask->nbits);
+	record__mmap_cpu_mask_init(mask, cpus);
+	perf_cpu_map__put(cpus);
+
+	return 0;
+}
+
 static void record__free_thread_masks(struct record *rec, int nr_threads)
 {
 	int t;
@@ -3335,6 +3381,253 @@ static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map
 	return 0;
 }
 
+static int record__init_thread_masks_spec(struct record *rec, struct perf_cpu_map *cpus,
+					  const char **maps_spec, const char **affinity_spec,
+					  u32 nr_spec)
+{
+	u32 s;
+	int ret = 0, t = 0;
+	struct mmap_cpu_mask cpus_mask;
+	struct thread_mask thread_mask, full_mask, *thread_masks;
+
+	ret = record__mmap_cpu_mask_alloc(&cpus_mask, cpu__max_cpu().cpu);
+	if (ret) {
+		pr_err("Failed to allocate CPUs mask\n");
+		return ret;
+	}
+	record__mmap_cpu_mask_init(&cpus_mask, cpus);
+
+	ret = record__thread_mask_alloc(&full_mask, cpu__max_cpu().cpu);
+	if (ret) {
+		pr_err("Failed to allocate full mask\n");
+		goto out_free_cpu_mask;
+	}
+
+	ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu().cpu);
+	if (ret) {
+		pr_err("Failed to allocate thread mask\n");
+		goto out_free_full_and_cpu_masks;
+	}
+
+	for (s = 0; s < nr_spec; s++) {
+		ret = record__mmap_cpu_mask_init_spec(&thread_mask.maps, maps_spec[s]);
+		if (ret) {
+			pr_err("Failed to initialize maps thread mask\n");
+			goto out_free;
+		}
+		ret = record__mmap_cpu_mask_init_spec(&thread_mask.affinity, affinity_spec[s]);
+		if (ret) {
+			pr_err("Failed to initialize affinity thread mask\n");
+			goto out_free;
+		}
+
+		/* ignore invalid CPUs but do not allow empty masks */
+		if (!bitmap_and(thread_mask.maps.bits, thread_mask.maps.bits,
+				cpus_mask.bits, thread_mask.maps.nbits)) {
+			pr_err("Empty maps mask: %s\n", maps_spec[s]);
+			ret = -EINVAL;
+			goto out_free;
+		}
+		if (!bitmap_and(thread_mask.affinity.bits, thread_mask.affinity.bits,
+				cpus_mask.bits, thread_mask.affinity.nbits)) {
+			pr_err("Empty affinity mask: %s\n", affinity_spec[s]);
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		/* do not allow intersection with other masks (full_mask) */
+		if (bitmap_intersects(thread_mask.maps.bits, full_mask.maps.bits,
+				      thread_mask.maps.nbits)) {
+			pr_err("Intersecting maps mask: %s\n", maps_spec[s]);
+			ret = -EINVAL;
+			goto out_free;
+		}
+		if (bitmap_intersects(thread_mask.affinity.bits, full_mask.affinity.bits,
+				      thread_mask.affinity.nbits)) {
+			pr_err("Intersecting affinity mask: %s\n", affinity_spec[s]);
+			ret = -EINVAL;
+			goto out_free;
+		}
+
+		bitmap_or(full_mask.maps.bits, full_mask.maps.bits,
+			  thread_mask.maps.bits, full_mask.maps.nbits);
+		bitmap_or(full_mask.affinity.bits, full_mask.affinity.bits,
+			  thread_mask.affinity.bits, full_mask.maps.nbits);
+
+		thread_masks = realloc(rec->thread_masks, (t + 1) * sizeof(struct thread_mask));
+		if (!thread_masks) {
+			pr_err("Failed to reallocate thread masks\n");
+			ret = -ENOMEM;
+			goto out_free;
+		}
+		rec->thread_masks = thread_masks;
+		rec->thread_masks[t] = thread_mask;
+		if (verbose) {
+			pr_debug("thread_masks[%d]: ", t);
+			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
+			pr_debug("thread_masks[%d]: ", t);
+			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].affinity, "affinity");
+		}
+		t++;
+		ret = record__thread_mask_alloc(&thread_mask, cpu__max_cpu().cpu);
+		if (ret) {
+			pr_err("Failed to allocate thread mask\n");
+			goto out_free_full_and_cpu_masks;
+		}
+	}
+	rec->nr_threads = t;
+	pr_debug("nr_threads: %d\n", rec->nr_threads);
+	if (!rec->nr_threads)
+		ret = -EINVAL;
+
+out_free:
+	record__thread_mask_free(&thread_mask);
+out_free_full_and_cpu_masks:
+	record__thread_mask_free(&full_mask);
+out_free_cpu_mask:
+	record__mmap_cpu_mask_free(&cpus_mask);
+
+	return ret;
+}
+
+static int record__init_thread_core_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int ret;
+	struct cpu_topology *topo;
+
+	topo = cpu_topology__new();
+	if (!topo) {
+		pr_err("Failed to allocate CPU topology\n");
+		return -ENOMEM;
+	}
+
+	ret = record__init_thread_masks_spec(rec, cpus, topo->core_cpus_list,
+					     topo->core_cpus_list, topo->core_cpus_lists);
+	cpu_topology__delete(topo);
+
+	return ret;
+}
+
+static int record__init_thread_package_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int ret;
+	struct cpu_topology *topo;
+
+	topo = cpu_topology__new();
+	if (!topo) {
+		pr_err("Failed to allocate CPU topology\n");
+		return -ENOMEM;
+	}
+
+	ret = record__init_thread_masks_spec(rec, cpus, topo->package_cpus_list,
+					     topo->package_cpus_list, topo->package_cpus_lists);
+	cpu_topology__delete(topo);
+
+	return ret;
+}
+
+static int record__init_thread_numa_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	u32 s;
+	int ret;
+	const char **spec;
+	struct numa_topology *topo;
+
+	topo = numa_topology__new();
+	if (!topo) {
+		pr_err("Failed to allocate NUMA topology\n");
+		return -ENOMEM;
+	}
+
+	spec = zalloc(topo->nr * sizeof(char *));
+	if (!spec) {
+		pr_err("Failed to allocate NUMA spec\n");
+		ret = -ENOMEM;
+		goto out_delete_topo;
+	}
+	for (s = 0; s < topo->nr; s++)
+		spec[s] = topo->nodes[s].cpus;
+
+	ret = record__init_thread_masks_spec(rec, cpus, spec, spec, topo->nr);
+
+	zfree(&spec);
+
+out_delete_topo:
+	numa_topology__delete(topo);
+
+	return ret;
+}
+
+static int record__init_thread_user_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int t, ret;
+	u32 s, nr_spec = 0;
+	char **maps_spec = NULL, **affinity_spec = NULL, **tmp_spec;
+	char *user_spec, *spec, *spec_ptr, *mask, *mask_ptr, *dup_mask = NULL;
+
+	for (t = 0, user_spec = (char *)rec->opts.threads_user_spec; ; t++, user_spec = NULL) {
+		spec = strtok_r(user_spec, ":", &spec_ptr);
+		if (spec == NULL)
+			break;
+		pr_debug2("threads_spec[%d]: %s\n", t, spec);
+		mask = strtok_r(spec, "/", &mask_ptr);
+		if (mask == NULL)
+			break;
+		pr_debug2("  maps mask: %s\n", mask);
+		tmp_spec = realloc(maps_spec, (nr_spec + 1) * sizeof(char *));
+		if (!tmp_spec) {
+			pr_err("Failed to reallocate maps spec\n");
+			ret = -ENOMEM;
+			goto out_free;
+		}
+		maps_spec = tmp_spec;
+		maps_spec[nr_spec] = dup_mask = strdup(mask);
+		if (!maps_spec[nr_spec]) {
+			pr_err("Failed to allocate maps spec[%d]\n", nr_spec);
+			ret = -ENOMEM;
+			goto out_free;
+		}
+		mask = strtok_r(NULL, "/", &mask_ptr);
+		if (mask == NULL) {
+			pr_err("Invalid thread maps or affinity specs\n");
+			ret = -EINVAL;
+			goto out_free;
+		}
+		pr_debug2("  affinity mask: %s\n", mask);
+		tmp_spec = realloc(affinity_spec, (nr_spec + 1) * sizeof(char *));
+		if (!tmp_spec) {
+			pr_err("Failed to reallocate affinity spec\n");
+			ret = -ENOMEM;
+			goto out_free;
+		}
+		affinity_spec = tmp_spec;
+		affinity_spec[nr_spec] = strdup(mask);
+		if (!affinity_spec[nr_spec]) {
+			pr_err("Failed to allocate affinity spec[%d]\n", nr_spec);
+			ret = -ENOMEM;
+			goto out_free;
+		}
+		dup_mask = NULL;
+		nr_spec++;
+	}
+
+	ret = record__init_thread_masks_spec(rec, cpus, (const char **)maps_spec,
+					     (const char **)affinity_spec, nr_spec);
+
+out_free:
+	free(dup_mask);
+	for (s = 0; s < nr_spec; s++) {
+		if (maps_spec)
+			free(maps_spec[s]);
+		if (affinity_spec)
+			free(affinity_spec[s]);
+	}
+	free(affinity_spec);
+	free(maps_spec);
+
+	return ret;
+}
+
 static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
 {
 	int ret;
@@ -3352,12 +3645,33 @@ static int record__init_thread_default_masks(struct record *rec, struct perf_cpu
 
 static int record__init_thread_masks(struct record *rec)
 {
+	int ret = 0;
 	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
 
 	if (!record__threads_enabled(rec))
 		return record__init_thread_default_masks(rec, cpus);
 
-	return record__init_thread_cpu_masks(rec, cpus);
+	switch (rec->opts.threads_spec) {
+	case THREAD_SPEC__CPU:
+		ret = record__init_thread_cpu_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__CORE:
+		ret = record__init_thread_core_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__PACKAGE:
+		ret = record__init_thread_package_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__NUMA:
+		ret = record__init_thread_numa_masks(rec, cpus);
+		break;
+	case THREAD_SPEC__USER:
+		ret = record__init_thread_user_masks(rec, cpus);
+		break;
+	default:
+		break;
+	}
+
+	return ret;
 }
 
 int cmd_record(int argc, const char **argv)
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index ad08c092f3dd..be9a957501f4 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -79,6 +79,7 @@ struct record_opts {
 	bool	      ctl_fd_close;
 	int	      synth;
 	int	      threads_spec;
+	const char    *threads_user_spec;
 };
 
 extern const char * const *record_usage;
-- 
2.19.0

