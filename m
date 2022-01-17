Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 25D4F491068
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:36:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233483AbiAQSgJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:36:09 -0500
Received: from mga12.intel.com ([192.55.52.136]:48629 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242850AbiAQSft (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:35:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444549; x=1673980549;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y+JhqMy1BWptnZIHTMr/PSfF8lE/ShFYAaYTrmke+Tc=;
  b=dDNj2z40JYTsA2yCh34AnDslSiZxHtGA5f3CzcIw2ZeDgPi28iANSXJ7
   xrkyPj/wyEsTSvZr0vbcsXV9ISOoJM9KeHSmHQz6/50EBgpBS8MI2sLXJ
   YoMUsYu+Uf1/Wy+cF81V9BgzluHq1VruXuqeqSB40u3dgSy13/WN/+WCC
   dL9TjxnV9kvVoExOeLmhUG3pV9wR3mN3hhC2H2W4TioHxEAxlHLy2z2m/
   9kBv+VqYGaY9a2m79KZWNQQaykMtaAJRgQs72UuIbmZs/bWeqKEdB+yvZ
   j4P2n1q56GbpqWBkipaoWZmY/UFGOBUOchWWIhJ7s6pjdjMcsPsyrCi3p
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224656068"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224656068"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:35:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434326"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:35:27 -0800
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
Subject: [PATCH v13 15/16] perf session: Load data directory files for analysis
Date:   Mon, 17 Jan 2022 21:34:35 +0300
Message-Id: <3f10c13a226c0ceb53e88a082f847b91c1ae2c25.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Load data directory files and provide basic raw dump and aggregated
analysis support of data directories in report mode, still with no
memory consumption optimizations.

READER_MAX_SIZE is chosen based on the results of measurements on
different machines on perf.data directory sizes >1GB. On machines
with big core count (192 cores) the difference between 1MB and 2MB
is about 4%. Other sizes (>2MB) are quite equal to 2MB.
On machines with small core count (4-24) there is no differences
between 1-16 MB sizes. So this constant is 2MB.

Suggested-by: Jiri Olsa <jolsa@kernel.org>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/util/session.c | 133 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index f19348dddd55..c6605eab61c1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -2185,6 +2185,8 @@ struct reader {
 	u64		 file_pos;
 	u64		 file_offset;
 	u64		 head;
+	u64		 size;
+	bool		 done;
 	struct zstd_data   zstd_data;
 	struct decomp_data decomp_data;
 };
@@ -2302,6 +2304,7 @@ reader__read_event(struct reader *rd, struct perf_session *session,
 	if (skip)
 		size += skip;
 
+	rd->size += size;
 	rd->head += size;
 	rd->file_pos += size;
 
@@ -2410,6 +2413,133 @@ static int __perf_session__process_events(struct perf_session *session)
 	return err;
 }
 
+/*
+ * Processing 2 MB of data from each reader in sequence,
+ * because that's the way the ordered events sorting works
+ * most efficiently.
+ */
+#define READER_MAX_SIZE (2 * 1024 * 1024)
+
+/*
+ * This function reads, merge and process directory data.
+ * It assumens the version 1 of directory data, where each
+ * data file holds per-cpu data, already sorted by kernel.
+ */
+static int __perf_session__process_dir_events(struct perf_session *session)
+{
+	struct perf_data *data = session->data;
+	struct perf_tool *tool = session->tool;
+	int i, ret, readers, nr_readers;
+	struct ui_progress prog;
+	u64 total_size = perf_data__size(session->data);
+	struct reader *rd;
+
+	perf_tool__fill_defaults(tool);
+
+	ui_progress__init_size(&prog, total_size, "Sorting events...");
+
+	nr_readers = 1;
+	for (i = 0; i < data->dir.nr; i++) {
+		if (data->dir.files[i].size)
+			nr_readers++;
+	}
+
+	rd = zalloc(nr_readers * sizeof(struct reader));
+	if (!rd)
+		return -ENOMEM;
+
+	rd[0] = (struct reader) {
+		.fd		 = perf_data__fd(session->data),
+		.data_size	 = session->header.data_size,
+		.data_offset	 = session->header.data_offset,
+		.process	 = process_simple,
+		.in_place_update = session->data->in_place_update,
+	};
+	ret = reader__init(&rd[0], NULL);
+	if (ret)
+		goto out_err;
+	ret = reader__mmap(&rd[0], session);
+	if (ret)
+		goto out_err;
+	readers = 1;
+
+	for (i = 0; i < data->dir.nr; i++) {
+		if (!data->dir.files[i].size)
+			continue;
+		rd[readers] = (struct reader) {
+			.fd		 = data->dir.files[i].fd,
+			.data_size	 = data->dir.files[i].size,
+			.data_offset	 = 0,
+			.process	 = process_simple,
+			.in_place_update = session->data->in_place_update,
+		};
+		ret = reader__init(&rd[readers], NULL);
+		if (ret)
+			goto out_err;
+		ret = reader__mmap(&rd[readers], session);
+		if (ret)
+			goto out_err;
+		readers++;
+	}
+
+	i = 0;
+	while (readers) {
+		if (session_done())
+			break;
+
+		if (rd[i].done) {
+			i = (i + 1) % nr_readers;
+			continue;
+		}
+		if (reader__eof(&rd[i])) {
+			rd[i].done = true;
+			readers--;
+			continue;
+		}
+
+		session->active_decomp = &rd[i].decomp_data;
+		ret = reader__read_event(&rd[i], session, &prog);
+		if (ret < 0) {
+			goto out_err;
+		} else if (ret == READER_NODATA) {
+			ret = reader__mmap(&rd[i], session);
+			if (ret)
+				goto out_err;
+		}
+
+		if (rd[i].size >= READER_MAX_SIZE) {
+			rd[i].size = 0;
+			i = (i + 1) % nr_readers;
+		}
+	}
+
+	ret = ordered_events__flush(&session->ordered_events, OE_FLUSH__FINAL);
+	if (ret)
+		goto out_err;
+
+	ret = perf_session__flush_thread_stacks(session);
+out_err:
+	ui_progress__finish();
+
+	if (!tool->no_warn)
+		perf_session__warn_about_errors(session);
+
+	/*
+	 * We may switching perf.data output, make ordered_events
+	 * reusable.
+	 */
+	ordered_events__reinit(&session->ordered_events);
+
+	session->one_mmap = false;
+
+	session->active_decomp = &session->decomp_data;
+	for (i = 0; i < nr_readers; i++)
+		reader__release_decomp(&rd[i]);
+	zfree(&rd);
+
+	return ret;
+}
+
 int perf_session__process_events(struct perf_session *session)
 {
 	if (perf_session__register_idle_thread(session) < 0)
@@ -2418,6 +2548,9 @@ int perf_session__process_events(struct perf_session *session)
 	if (perf_data__is_pipe(session->data))
 		return __perf_session__process_pipe_events(session);
 
+	if (perf_data__is_dir(session->data))
+		return __perf_session__process_dir_events(session);
+
 	return __perf_session__process_events(session);
 }
 
-- 
2.19.0

