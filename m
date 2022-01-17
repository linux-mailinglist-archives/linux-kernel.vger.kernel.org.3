Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46FB8491060
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbiAQSfm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:35:42 -0500
Received: from mga12.intel.com ([192.55.52.136]:48633 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242803AbiAQSfO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:35:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444514; x=1673980514;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=mTvjI7jqZE7zzXv2aMcu/5dmwpgIxeFqPYg6k1BSd9M=;
  b=JPPDRTEqRZ23e32e1CtYE5pnUl2alUSHOxP2W5xkxZKKwsq4/C00GOov
   lJJQr4LV4qVCErTqLtbo8AtLlOzXwAD/Ajs39x599pIjjBudX3bPbqwj1
   IL7dtLL02VM/J1ugpwIo4+ixbEUJ/7XysimW7DAPXIKkJ3LizU7eQDh42
   oAg7TUkDYhGMRfAxrhoBGMW5aHXS1CKcNSXe1haSH8b0RuCpN0ohsieLu
   Dn5AqMll9+LJXTrfr/emq82JA2+7A81H10pCNzVZi3CB1F2oUpf4+pUeC
   P1oFh72USttbKHILm2dNo9zB1upg+Ax9p79J0fLHtJ+SqwOk0kXscWFMh
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224656027"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224656027"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434288"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:35:10 -0800
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
Subject: [PATCH v13 10/16] perf record: Introduce compressor at mmap buffer object
Date:   Mon, 17 Jan 2022 21:34:30 +0300
Message-Id: <80edc286cf6543139a7d5a91217605123aa0b50d.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce compressor object into mmap object so it could be used to
pack the data stream from the corresponding kernel data buffer.
Initialize and make use of the introduced per mmap compressor.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 18 +++++++++++-------
 tools/perf/util/mmap.c      | 10 ++++++++++
 tools/perf/util/mmap.h      |  2 ++
 3 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 50981bbc98bb..7d0338b5a0e3 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -246,8 +246,8 @@ static int record__write(struct record *rec, struct mmap *map __maybe_unused,
 
 static int record__aio_enabled(struct record *rec);
 static int record__comp_enabled(struct record *rec);
-static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
-			    void *src, size_t src_size);
+static size_t zstd_compress(struct perf_session *session, struct mmap *map,
+			    void *dst, size_t dst_size, void *src, size_t src_size);
 
 #ifdef HAVE_AIO_SUPPORT
 static int record__aio_write(struct aiocb *cblock, int trace_fd,
@@ -381,7 +381,7 @@ static int record__aio_pushfn(struct mmap *map, void *to, void *buf, size_t size
 	 */
 
 	if (record__comp_enabled(aio->rec)) {
-		size = zstd_compress(aio->rec->session, aio->data + aio->size,
+		size = zstd_compress(aio->rec->session, NULL, aio->data + aio->size,
 				     mmap__mmap_len(map) - aio->size,
 				     buf, size);
 	} else {
@@ -608,7 +608,7 @@ static int record__pushfn(struct mmap *map, void *to, void *bf, size_t size)
 	struct record *rec = to;
 
 	if (record__comp_enabled(rec)) {
-		size = zstd_compress(rec->session, map->data, mmap__mmap_len(map), bf, size);
+		size = zstd_compress(rec->session, map, map->data, mmap__mmap_len(map), bf, size);
 		bf   = map->data;
 	}
 
@@ -1394,13 +1394,17 @@ static size_t process_comp_header(void *record, size_t increment)
 	return size;
 }
 
-static size_t zstd_compress(struct perf_session *session, void *dst, size_t dst_size,
-			    void *src, size_t src_size)
+static size_t zstd_compress(struct perf_session *session, struct mmap *map,
+			    void *dst, size_t dst_size, void *src, size_t src_size)
 {
 	size_t compressed;
 	size_t max_record_size = PERF_SAMPLE_MAX_SIZE - sizeof(struct perf_record_compressed) - 1;
+	struct zstd_data *zstd_data = &session->zstd_data;
 
-	compressed = zstd_compress_stream_to_records(&session->zstd_data, dst, dst_size, src, src_size,
+	if (map && map->file)
+		zstd_data = &map->zstd_data;
+
+	compressed = zstd_compress_stream_to_records(zstd_data, dst, dst_size, src, src_size,
 						     max_record_size, process_comp_header);
 
 	session->bytes_transferred += src_size;
diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 12261ed8c15b..8bf97d9b8424 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -230,6 +230,10 @@ void mmap__munmap(struct mmap *map)
 {
 	bitmap_free(map->affinity_mask.bits);
 
+#ifndef PYTHON_PERF
+	zstd_fini(&map->zstd_data);
+#endif
+
 	perf_mmap__aio_munmap(map);
 	if (map->data != NULL) {
 		munmap(map->data, mmap__mmap_len(map));
@@ -292,6 +296,12 @@ int mmap__mmap(struct mmap *map, struct mmap_params *mp, int fd, struct perf_cpu
 	map->core.flush = mp->flush;
 
 	map->comp_level = mp->comp_level;
+#ifndef PYTHON_PERF
+	if (zstd_init(&map->zstd_data, map->comp_level)) {
+		pr_debug2("failed to init mmap commpressor, error %d\n", errno);
+		return -1;
+	}
+#endif
 
 	if (map->comp_level && !perf_mmap__aio_enabled(map)) {
 		map->data = mmap(NULL, mmap__mmap_len(map), PROT_READ|PROT_WRITE,
diff --git a/tools/perf/util/mmap.h b/tools/perf/util/mmap.h
index 62f38d7977bb..cd8b0777473b 100644
--- a/tools/perf/util/mmap.h
+++ b/tools/perf/util/mmap.h
@@ -15,6 +15,7 @@
 #endif
 #include "auxtrace.h"
 #include "event.h"
+#include "util/compress.h"
 
 struct aiocb;
 
@@ -46,6 +47,7 @@ struct mmap {
 	void		*data;
 	int		comp_level;
 	struct perf_data_file *file;
+	struct zstd_data      zstd_data;
 };
 
 struct mmap_params {
-- 
2.19.0

