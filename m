Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2D2B49105F
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242901AbiAQSfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:35:31 -0500
Received: from mga12.intel.com ([192.55.52.136]:48629 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242770AbiAQSfL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:35:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444511; x=1673980511;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=jXewn2D3TS6sPyNfV5Vn+j8dLBIuSljGeQz6Yl1GSqM=;
  b=iSPywyDb9MpC6zfuyRf3V9Ni0wjYcKOR23ejKrcS4PifocV4YAt5Z0vM
   q1Q/BcIuAPDNnIzNAgVACcj9Gatnal6HS9DjPsi3W9TLEzOwjQ2/q89Ji
   BwpwQrtqv4ZciWXV9cVbxAVGx7RvSFRaE4cLVNS3/NGJO7fU7lhVj1XpP
   zvtNRRR89mHXvrFXq873kbBx5T3pNl8rCmSEx/hFDsYK+GJFhn3mxYuzy
   CZgznMFoC71iK2+mSqANyIRMuQ5BbJy789yWb5pcPvLmprFQRhmDNlJfn
   8IRpLjcupUtwkyQoIv4gifC7pfZNGXFkNiV7K6oBdSYl4wIQabbWHUKBf
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224656021"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224656021"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:35:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434276"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:35:07 -0800
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
Subject: [PATCH v13 09/16] perf record: Introduce bytes written stats
Date:   Mon, 17 Jan 2022 21:34:29 +0300
Message-Id: <3e2c69186641446f8ab003ec209bccc762b3394d.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce a function to calculate the total amount of data written
and use it to support the --max-size option.

Acked-by: Namhyung Kim <namhyung@kernel.org>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 8766a3dc9440..50981bbc98bb 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -110,6 +110,7 @@ struct record_thread {
 	struct record		*rec;
 	unsigned long long	samples;
 	unsigned long		waking;
+	u64			bytes_written;
 };
 
 static __thread struct record_thread *thread;
@@ -194,10 +195,22 @@ static bool switch_output_time(struct record *rec)
 	       trigger_is_ready(&switch_output_trigger);
 }
 
+static u64 record__bytes_written(struct record *rec)
+{
+	int t;
+	u64 bytes_written = rec->bytes_written;
+	struct record_thread *thread_data = rec->thread_data;
+
+	for (t = 0; t < rec->nr_threads; t++)
+		bytes_written += thread_data[t].bytes_written;
+
+	return bytes_written;
+}
+
 static bool record__output_max_size_exceeded(struct record *rec)
 {
 	return rec->output_max_size &&
-	       (rec->bytes_written >= rec->output_max_size);
+	       (record__bytes_written(rec) >= rec->output_max_size);
 }
 
 static int record__write(struct record *rec, struct mmap *map __maybe_unused,
@@ -213,13 +226,15 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 		return -1;
 	}
 
-	if (!(map && map->file))
+	if (map && map->file)
+		thread->bytes_written += size;
+	else
 		rec->bytes_written += size;
 
 	if (record__output_max_size_exceeded(rec) && !done) {
 		fprintf(stderr, "[ perf record: perf size limit reached (%" PRIu64 " KB),"
 				" stopping session ]\n",
-				rec->bytes_written >> 10);
+				record__bytes_written(rec) >> 10);
 		done = 1;
 	}
 
-- 
2.19.0

