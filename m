Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE71491067
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:36:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242994AbiAQSgD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:36:03 -0500
Received: from mga12.intel.com ([192.55.52.136]:48634 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242696AbiAQSfs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:35:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444547; x=1673980547;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ruM1z206oqtD+FgneKTwLACpX7c/tBRcD7glsFeGSdI=;
  b=UNj7Pf+Yjx7H8EzIxxRXx/Vp4fHld3MSwmJcvK2hdDcDLdmGqkAHqyQJ
   OL/VQCIf4dgdfDgx0Xb1IFGQNB+HUzCYQnQfyDEZCJeoTkZNYBviD8moh
   l8J+l/KcOfYG2hSaix2IcEzwB19gXLGrV0u13S3TSPGuvfAHhLlXLgXus
   0A/qFhqoZjRM6YCksZVjGd2pFSkrOvmuf1OhvfOqd+O+b61kq/u3nLr1E
   ivY4WL9AWWLzPH7JJ3aD9dWfRsUrvyzYriTPsxUYeWDC0jeqU8yI8XnF/
   IyYunSq3xATXMcm9l2/PvSkLNtObPp1iDRKvw260mOT2k/xMZCs/+zwjS
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224656062"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224656062"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:35:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434310"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:35:24 -0800
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
Subject: [PATCH v13 14/16] perf record: Implement compatibility checks
Date:   Mon, 17 Jan 2022 21:34:34 +0300
Message-Id: <fadc1cf74057af4d5766248fcfe5cdde40732aa9.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Implement compatibility checks for other modes and related command line
options: asynchronous (--aio) trace streaming and affinity (--affinity)
modes, pipe mode, AUX area tracing --snapshot and --aux-sample options,
--switch-output, --switch-output-event, --switch-max-files and
--timestamp-filename options. Parallel data streaming is compatible with
Zstd compression (--compression-level) and external control commands
(--control). CPU mask provided via -C option filters --threads
specification masks.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 49 ++++++++++++++++++++++++++++++++++---
 1 file changed, 46 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index e60bf0e3bc25..9b7102262b20 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -805,6 +805,12 @@ static int record__auxtrace_init(struct record *rec)
 {
 	int err;
 
+	if ((rec->opts.auxtrace_snapshot_opts || rec->opts.auxtrace_sample_opts)
+	    && record__threads_enabled(rec)) {
+		pr_err("AUX area tracing options are not available in parallel streaming mode.\n");
+		return -EINVAL;
+	}
+
 	if (!rec->itr) {
 		rec->itr = auxtrace_record__init(rec->evlist, &err);
 		if (err)
@@ -2198,6 +2204,17 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		return PTR_ERR(session);
 	}
 
+	if (record__threads_enabled(rec)) {
+		if (perf_data__is_pipe(&rec->data)) {
+			pr_err("Parallel trace streaming is not available in pipe mode.\n");
+			return -1;
+		}
+		if (rec->opts.full_auxtrace) {
+			pr_err("Parallel trace streaming is not available in AUX area tracing mode.\n");
+			return -1;
+		}
+	}
+
 	fd = perf_data__fd(data);
 	rec->session = session;
 
@@ -2938,12 +2955,22 @@ static int switch_output_setup(struct record *rec)
 	 * --switch-output=signal, as we'll send a SIGUSR2 from the side band
 	 *  thread to its parent.
 	 */
-	if (rec->switch_output_event_set)
+	if (rec->switch_output_event_set) {
+		if (record__threads_enabled(rec)) {
+			pr_warning("WARNING: --switch-output-event option is not available in parallel streaming mode.\n");
+			return 0;
+		}
 		goto do_signal;
+	}
 
 	if (!s->set)
 		return 0;
 
+	if (record__threads_enabled(rec)) {
+		pr_warning("WARNING: --switch-output option is not available in parallel streaming mode.\n");
+		return 0;
+	}
+
 	if (!strcmp(s->str, "signal")) {
 do_signal:
 		s->signal = true;
@@ -3262,8 +3289,8 @@ static struct option __record_options[] = {
 		     "Set affinity mask of trace reading thread to NUMA node cpu mask or cpu of processed mmap buffer",
 		     record__parse_affinity),
 #ifdef HAVE_ZSTD_SUPPORT
-	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default,
-			    "n", "Compressed records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
+	OPT_CALLBACK_OPTARG('z', "compression-level", &record.opts, &comp_level_default, "n",
+			    "Compress records using specified level (default: 1 - fastest compression, 22 - greatest compression)",
 			    record__parse_comp_level),
 #endif
 	OPT_CALLBACK(0, "max-size", &record.output_max_size,
@@ -3758,6 +3785,17 @@ int cmd_record(int argc, const char **argv)
 	if (rec->opts.kcore || record__threads_enabled(rec))
 		rec->data.is_dir = true;
 
+	if (record__threads_enabled(rec)) {
+		if (rec->opts.affinity != PERF_AFFINITY_SYS) {
+			pr_err("--affinity option is mutually exclusive to parallel streaming mode.\n");
+			goto out_opts;
+		}
+		if (record__aio_enabled(rec)) {
+			pr_err("Asynchronous streaming mode (--aio) is mutually exclusive to parallel streaming mode.\n");
+			goto out_opts;
+		}
+	}
+
 	if (rec->opts.comp_level != 0) {
 		pr_debug("Compression enabled, disabling build id collection at the end of the session.\n");
 		rec->no_buildid = true;
@@ -3791,6 +3829,11 @@ int cmd_record(int argc, const char **argv)
 		}
 	}
 
+	if (rec->timestamp_filename && record__threads_enabled(rec)) {
+		rec->timestamp_filename = false;
+		pr_warning("WARNING: --timestamp-filename option is not available in parallel streaming mode.\n");
+	}
+
 	/*
 	 * Allow aliases to facilitate the lookup of symbols for address
 	 * filters. Refer to auxtrace_parse_filters().
-- 
2.19.0

