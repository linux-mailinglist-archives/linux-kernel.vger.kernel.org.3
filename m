Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E07EC491065
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:36:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233326AbiAQSfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:35:55 -0500
Received: from mga12.intel.com ([192.55.52.136]:48629 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242885AbiAQSfY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:35:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444524; x=1673980524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nrckZ+4w+t9xcn0jGApSjWwJZOqejG13YfVPSf21LRY=;
  b=XfybOAGdF0G0N54HWJB0DgyhtQKxIiuw2mRE2aCD8Hjmpgn48F9Igb2G
   eswKUe3VoZ2GPGCPFXJZD58Xl1yPhFiAJurhWQFJJqRkKkRCFttphxGg4
   4/xmY3Ez+9e5ZQC2E9/HO0PYkcXjYuB/HpDOsTifIvbjSPHDYokYlwry8
   t+piYhHcKB3dEJ48sr0AEDFNhkIQCtQMqJJSKRaHkR4kT4uTSDQbH9mzx
   thQen5QCRuSmD7GZ5eJc1u+LcZTr0BoM0N8dlj9/xKze0DxwAnUMrPxMk
   14XQlBnnoGjRr/yS87xgmM7qm3HH7STmWg+z35yz+WEcA2OawYEeX5i0b
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224656040"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224656040"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434298"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:35:17 -0800
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
Subject: [PATCH v13 12/16] perf record: Introduce --threads command line option
Date:   Mon, 17 Jan 2022 21:34:32 +0300
Message-Id: <01aeae43b047f428596c4ef9f9342ab94865cedd.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide --threads option in perf record command line interface.
The option creates a data streaming thread for each CPU in the system.
Document --threads option in Documentation/perf-record.txt.

Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/Documentation/perf-record.txt |  4 ++
 tools/perf/builtin-record.c              | 48 +++++++++++++++++++++++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/tools/perf/Documentation/perf-record.txt b/tools/perf/Documentation/perf-record.txt
index 9ccc75935bc5..b9c6b112bf46 100644
--- a/tools/perf/Documentation/perf-record.txt
+++ b/tools/perf/Documentation/perf-record.txt
@@ -713,6 +713,10 @@ measurements:
  wait -n ${perf_pid}
  exit $?
 
+--threads::
+Write collected trace data into several data files using parallel threads.
+The option creates a data streaming thread for each CPU in the system.
+
 include::intel-hybrid.txt[]
 
 --debuginfod[=URLs]::
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0f8488d12f44..ba1622a192a9 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -127,6 +127,11 @@ static const char *thread_msg_tags[THREAD_MSG__MAX] = {
 	"UNDEFINED", "READY"
 };
 
+enum thread_spec {
+	THREAD_SPEC__UNDEFINED = 0,
+	THREAD_SPEC__CPU,
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -2768,6 +2773,16 @@ static void record__thread_mask_free(struct thread_mask *mask)
 	record__mmap_cpu_mask_free(&mask->affinity);
 }
 
+static int record__parse_threads(const struct option *opt, const char *str, int unset)
+{
+	struct record_opts *opts = opt->value;
+
+	if (unset || !str || !strlen(str))
+		opts->threads_spec = THREAD_SPEC__CPU;
+
+	return 0;
+}
+
 static int parse_output_max_size(const struct option *opt,
 				 const char *str, int unset)
 {
@@ -3242,6 +3257,9 @@ static struct option __record_options[] = {
 			  &record.debuginfod.set, "debuginfod urls",
 			  "Enable debuginfod data retrieval from DEBUGINFOD_URLS or specified urls",
 			  "system"),
+	OPT_CALLBACK_OPTARG(0, "threads", &record.opts, NULL, "spec",
+			    "write collected trace data into several data files using parallel threads",
+			    record__parse_threads),
 	OPT_END()
 };
 
@@ -3292,6 +3310,31 @@ static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr
 	return ret;
 }
 
+static int record__init_thread_cpu_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int t, ret, nr_cpus = perf_cpu_map__nr(cpus);
+
+	ret = record__alloc_thread_masks(rec, nr_cpus, cpu__max_cpu().cpu);
+	if (ret)
+		return ret;
+
+	rec->nr_threads = nr_cpus;
+	pr_debug("nr_threads: %d\n", rec->nr_threads);
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		set_bit(cpus->map[t].cpu, rec->thread_masks[t].maps.bits);
+		set_bit(cpus->map[t].cpu, rec->thread_masks[t].affinity.bits);
+		if (verbose) {
+			pr_debug("thread_masks[%d]: ", t);
+			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].maps, "maps");
+			pr_debug("thread_masks[%d]: ", t);
+			mmap_cpu_mask__scnprintf(&rec->thread_masks[t].affinity, "affinity");
+		}
+	}
+
+	return 0;
+}
+
 static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
 {
 	int ret;
@@ -3311,7 +3354,10 @@ static int record__init_thread_masks(struct record *rec)
 {
 	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
 
-	return record__init_thread_default_masks(rec, cpus);
+	if (!record__threads_enabled(rec))
+		return record__init_thread_default_masks(rec, cpus);
+
+	return record__init_thread_cpu_masks(rec, cpus);
 }
 
 int cmd_record(int argc, const char **argv)
-- 
2.19.0

