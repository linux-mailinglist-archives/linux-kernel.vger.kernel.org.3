Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80C5E491061
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:35:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238362AbiAQSft (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:35:49 -0500
Received: from mga12.intel.com ([192.55.52.136]:48634 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242843AbiAQSfR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444517; x=1673980517;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=IgZjj9XbMC7hMTZDfcpEgux3Es+6Lrg4o7zKivFg6PY=;
  b=PcMiqLVoSu9VN8i4/914pwfQLxc4vLjAbErNIXxOeES0uVXFlXflLI4o
   CKmVqINWUGP+m5beHJ2g1tjhPrAwOYYeBJrCiX/v3mfayqLAQpcB2fGPi
   UNB74SvgiiPFCu+CYkN6uRd+08C3pLAgwFzleVug00BixaYkqtJgcpJzV
   CNACnkTyK27ur/2tQlq+nr+1tb07/Y5ZU5NAhQt4Oqd++xU3JWpMfI9CD
   pcMeU+yBgU2693xz5z2NnlolDXH8weL1BnKQgyLI5kWrpRJoQzBlZO/XR
   097wJRitotblLkiedWdBJJzBUHeTAiozfVtjyGomzam1XtaNI+ZPm5hF+
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224656030"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224656030"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:35:16 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434292"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:35:13 -0800
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
Subject: [PATCH v13 11/16] perf record: Introduce data transferred and compressed stats
Date:   Mon, 17 Jan 2022 21:34:31 +0300
Message-Id: <b5d598034c507dfb7544d2125500280b7d434764.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce bytes_transferred and bytes_compressed stats so they
would capture statistics for the related data buffer transfers.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 7d0338b5a0e3..0f8488d12f44 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -111,6 +111,8 @@ struct record_thread {
 	unsigned long long	samples;
 	unsigned long		waking;
 	u64			bytes_written;
+	u64			bytes_transferred;
+	u64			bytes_compressed;
 };
 
 static __thread struct record_thread *thread;
@@ -1407,8 +1409,13 @@ static size_t zstd_compress(struct perf_session *session, struct mmap *map,
 	compressed = zstd_compress_stream_to_records(zstd_data, dst, dst_size, src, src_size,
 						     max_record_size, process_comp_header);
 
-	session->bytes_transferred += src_size;
-	session->bytes_compressed  += compressed;
+	if (map && map->file) {
+		thread->bytes_transferred += src_size;
+		thread->bytes_compressed  += compressed;
+	} else {
+		session->bytes_transferred += src_size;
+		session->bytes_compressed  += compressed;
+	}
 
 	return compressed;
 }
@@ -2098,8 +2105,20 @@ static int record__stop_threads(struct record *rec)
 	for (t = 1; t < rec->nr_threads; t++)
 		record__terminate_thread(&thread_data[t]);
 
-	for (t = 0; t < rec->nr_threads; t++)
+	for (t = 0; t < rec->nr_threads; t++) {
 		rec->samples += thread_data[t].samples;
+		if (!record__threads_enabled(rec))
+			continue;
+		rec->session->bytes_transferred += thread_data[t].bytes_transferred;
+		rec->session->bytes_compressed += thread_data[t].bytes_compressed;
+		pr_debug("threads[%d]: samples=%lld, wakes=%ld, ", thread_data[t].tid,
+			 thread_data[t].samples, thread_data[t].waking);
+		if (thread_data[t].bytes_transferred && thread_data[t].bytes_compressed)
+			pr_debug("trasferred=%ld, compressed=%ld\n",
+				 thread_data[t].bytes_transferred, thread_data[t].bytes_compressed);
+		else
+			pr_debug("written=%ld\n", thread_data[t].bytes_written);
+	}
 
 	return 0;
 }
-- 
2.19.0

