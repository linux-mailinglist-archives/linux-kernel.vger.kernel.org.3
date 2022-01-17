Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99A0F49105E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242802AbiAQSfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:35:13 -0500
Received: from mga12.intel.com ([192.55.52.136]:48629 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242747AbiAQSfH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:35:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444507; x=1673980507;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AL4EKZNnBI2MBBIv8OMH0sp//vTHeZd9Kg5ZpCYp7Zw=;
  b=E0/ZKe0BTDH5zk248GcauGY0E/KMPOib2pVJ1QNcicMJtJGaBcUZklLI
   z+uuXnhWlpioW46NImeuED7tRgwraYqwsEZ4PGaD/mcuNEbAYSOo7VwLF
   sgy81oINupQ+P/mf+Af7zdoVQrlUH4SC2ezhPXSQw/Zre+6DwQ1LlRnyH
   TVsW5yUc9v5HzUu2y9Q2BU9kZpTlXfGf2YV3JkM+DzIQYDKWYjQPJ5xz9
   X+QBiqNh/uN8GLy9NBSsv1tNQVh6lI3zOmYqF164KRk5ogJaHmkVT4X0W
   yNnycN+G7O5Q7XRDwom5OT2dtJpQ5UOTYGK9J5PA8DCcTtH5cuPc8SZaX
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224656016"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224656016"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:35:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434267"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:35:03 -0800
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
Subject: [PATCH v13 08/16] perf record: Introduce data file at mmap buffer object
Date:   Mon, 17 Jan 2022 21:34:28 +0300
Message-Id: <177077f7734b63e5c999ccd75ac6dc3c694f0d0d.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce data file objects into mmap object so it could be used to
process and store data stream from the corresponding kernel data buffer.
Initialize data files located at mmap buffer objects so trace data
can be written into several data file located at data directory.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 37 ++++++++++++++++++++++++++++++++-----
 tools/perf/util/mmap.h      |  1 +
 2 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 517520ae1520..8766a3dc9440 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -205,12 +205,16 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 {
 	struct perf_data_file *file = &rec->session->data->file;
 
+	if (map && map->file)
+		file = map->file;
+
 	if (perf_data_file__write(file, bf, size) < 0) {
 		pr_err("failed to write perf data, error: %m\n");
 		return -1;
 	}
 
-	rec->bytes_written += size;
+	if (!(map && map->file))
+		rec->bytes_written += size;
 
 	if (record__output_max_size_exceeded(rec) && !done) {
 		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
@@ -1103,7 +1107,7 @@ static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
-	int ret;
+	int i, ret;
 	struct record_opts *opts = &rec->opts;
 	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
 				  opts->auxtrace_sample_mode;
@@ -1142,6 +1146,18 @@ static int record__mmap_evlist(struct record *rec,
 	if (ret)
 		return ret;
 
+	if (record__threads_enabled(rec)) {
+		ret = perf_data__create_dir(&rec->data, evlist->core.nr_mmaps);
+		if (ret)
+			return ret;
+		for (i = 0; i < evlist->core.nr_mmaps; i++) {
+			if (evlist->mmap)
+				evlist->mmap[i].file = &rec->data.dir.files[i];
+			if (evlist->overwrite_mmap)
+				evlist->overwrite_mmap[i].file = &rec->data.dir.files[i];
+		}
+	}
+
 	return 0;
 }
 
@@ -1448,8 +1464,12 @@ static int record__mmap_read_evlist(struct record *rec, struct evlist *evlist,
 	/*
 	 * Mark the round finished in case we wrote
 	 * at least one event.
+	 *
+	 * No need for round events in directory mode,
+	 * because per-cpu maps and files have data
+	 * sorted by kernel.
 	 */
-	if (bytes_written != rec->bytes_written)
+	if (!record__threads_enabled(rec) && bytes_written != rec->bytes_written)
 		rc = record__write(rec, NULL, &finished_round_event, sizeof(finished_round_event));
 
 	if (overwrite)
@@ -1566,7 +1586,9 @@ static void record__init_features(struct record *rec)
 	if (!rec->opts.use_clockid)
 		perf_header__clear_feat(&session->header, HEADER_CLOCK_DATA);
 
-	perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+	if (!record__threads_enabled(rec))
+		perf_header__clear_feat(&session->header, HEADER_DIR_FORMAT);
+
 	if (!record__comp_enabled(rec))
 		perf_header__clear_feat(&session->header, HEADER_COMPRESSED);
 
@@ -1576,6 +1598,7 @@ static void record__init_features(struct record *rec)
 static void
 record__finish_output(struct record *rec)
 {
+	int i;
 	struct perf_data *data = &rec->data;
 	int fd = perf_data__fd(data);
 
@@ -1584,6 +1607,10 @@ record__finish_output(struct record *rec)
 
 	rec->session->header.data_size += rec->bytes_written;
 	data->file.size = lseek(perf_data__fd(data), 0, SEEK_CUR);
+	if (record__threads_enabled(rec)) {
+		for (i = 0; i < data->dir.nr; i++)
+			data->dir.files[i].size = lseek(data->dir.files[i].fd, 0, SEEK_CUR);
+	}
 
 	if (!rec->no_buildid) {
 		process_buildids(rec);
@@ -3330,7 +3357,7 @@ int cmd_record(int argc, const char **argv)
 		goto out_opts;
 	}
 
-	if (rec->opts.kcore)
+	if (rec->opts.kcore || record__threads_enabled(rec))
 		rec->data.is_dir = true;
 
 	if (rec->opts.comp_level != 0) {
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 83f6bd4d4082..62f38d7977bb 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -45,6 +45,7 @@ struct mmap {
 	struct mmap_cpu_mask	affinity_mask;
 	void		*data;
 	int		comp_level;
+	struct perf_data_file *file;
 };
 
 struct mmap_params {
-- 
2.19.0

