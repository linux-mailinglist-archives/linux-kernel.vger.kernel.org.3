Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F00FD491053
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:34:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242594AbiAQSep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:34:45 -0500
Received: from mga12.intel.com ([192.55.52.136]:48606 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242193AbiAQSen (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444483; x=1673980483;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=AAQ1YHDRhw2jiixtPVTsB9v7oMgUunFg3Ew8CBPPBW0=;
  b=SmWHNwjAJchCLp5do3sDAcx/FV/nuxlua3TSQSOByNyTt25V6Beft1+2
   znW77fA8GRAKyp72CiEhSDTaAux9IvXqOLBuR3u+iH0MYd8fCi4tHfZcj
   WlOofnvO+6ydGc1xnSw7TQevoXBVq0CdmBd2wbIVLGcQXhUXaOHXX9VcG
   daISxk5fVUk9BFvDLgyBM6OwXgkbpnQfb8fGmUktv7PwcwYmDYIcjqW8p
   3GiWGX763DOkCSIoWks0e1htD0P7vHLjwxVO1wiAJT4VGGmTqsLFO2K1o
   ORqdqpY9CNaTMhZGzibTYruG/MKGFEh95ti5/oJYODky3rq5e7ZlNhBoM
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224655967"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224655967"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:34:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434180"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:34:40 -0800
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
Subject: [PATCH v13 01/16] perf record: Introduce thread affinity and mmap masks
Date:   Mon, 17 Jan 2022 21:34:21 +0300
Message-Id: <9042bf7daf988e17e17e6acbf5d29590bde869cd.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce affinity and mmap thread masks. Thread affinity mask
defines CPUs that a thread is allowed to run on. Thread maps
mask defines mmap data buffers the thread serves to stream
profiling data from.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 123 ++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index bb716c953d02..41998f2140cd 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -87,6 +87,11 @@ struct switch_output {
 	int		 cur_file;
 };
 
+struct thread_mask {
+	struct mmap_cpu_mask	maps;
+	struct mmap_cpu_mask	affinity;
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -112,6 +117,8 @@ struct record {
 	struct mmap_cpu_mask	affinity_mask;
 	unsigned long		output_max_size;	/* = 0: unlimited */
 	struct perf_debuginfod	debuginfod;
+	int			nr_threads;
+	struct thread_mask	*thread_masks;
 };
 
 static volatile int done;
@@ -2204,6 +2211,47 @@ static int record__parse_affinity(const struct option *opt, const char *str, int
 	return 0;
 }
 
+static int record__mmap_cpu_mask_alloc(struct mmap_cpu_mask *mask, int nr_bits)
+{
+	mask->nbits = nr_bits;
+	mask->bits = bitmap_zalloc(mask->nbits);
+	if (!mask->bits)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static void record__mmap_cpu_mask_free(struct mmap_cpu_mask *mask)
+{
+	bitmap_free(mask->bits);
+	mask->nbits = 0;
+}
+
+static int record__thread_mask_alloc(struct thread_mask *mask, int nr_bits)
+{
+	int ret;
+
+	ret = record__mmap_cpu_mask_alloc(&mask->maps, nr_bits);
+	if (ret) {
+		mask->affinity.bits = NULL;
+		return ret;
+	}
+
+	ret = record__mmap_cpu_mask_alloc(&mask->affinity, nr_bits);
+	if (ret) {
+		record__mmap_cpu_mask_free(&mask->maps);
+		mask->maps.bits = NULL;
+	}
+
+	return ret;
+}
+
+static void record__thread_mask_free(struct thread_mask *mask)
+{
+	record__mmap_cpu_mask_free(&mask->maps);
+	record__mmap_cpu_mask_free(&mask->affinity);
+}
+
 static int parse_output_max_size(const struct option *opt,
 				 const char *str, int unset)
 {
@@ -2683,6 +2731,73 @@ static struct option __record_options[] = {
 
 struct option *record_options = __record_options;
 
+static void record__mmap_cpu_mask_init(struct mmap_cpu_mask *mask, struct perf_cpu_map *cpus)
+{
+	int c;
+
+	for (c = 0; c < cpus->nr; c++)
+		set_bit(cpus->map[c].cpu, mask->bits);
+}
+
+static void record__free_thread_masks(struct record *rec, int nr_threads)
+{
+	int t;
+
+	if (rec->thread_masks)
+		for (t = 0; t < nr_threads; t++)
+			record__thread_mask_free(&rec->thread_masks[t]);
+
+	zfree(&rec->thread_masks);
+}
+
+static int record__alloc_thread_masks(struct record *rec, int nr_threads, int nr_bits)
+{
+	int t, ret;
+
+	rec->thread_masks = zalloc(nr_threads * sizeof(*(rec->thread_masks)));
+	if (!rec->thread_masks) {
+		pr_err("Failed to allocate thread masks\n");
+		return -ENOMEM;
+	}
+
+	for (t = 0; t < nr_threads; t++) {
+		ret = record__thread_mask_alloc(&rec->thread_masks[t], nr_bits);
+		if (ret) {
+			pr_err("Failed to allocate thread masks[%d]\n", t);
+			goto out_free;
+		}
+	}
+
+	return 0;
+
+out_free:
+	record__free_thread_masks(rec, nr_threads);
+
+	return ret;
+}
+
+static int record__init_thread_default_masks(struct record *rec, struct perf_cpu_map *cpus)
+{
+	int ret;
+
+	ret = record__alloc_thread_masks(rec, 1, cpu__max_cpu().cpu);
+	if (ret)
+		return ret;
+
+	record__mmap_cpu_mask_init(&rec->thread_masks->maps, cpus);
+
+	rec->nr_threads = 1;
+
+	return 0;
+}
+
+static int record__init_thread_masks(struct record *rec)
+{
+	struct perf_cpu_map *cpus = rec->evlist->core.cpus;
+
+	return record__init_thread_default_masks(rec, cpus);
+}
+
 int cmd_record(int argc, const char **argv)
 {
 	int err;
@@ -2948,6 +3063,12 @@ int cmd_record(int argc, const char **argv)
 		goto out;
 	}
 
+	err = record__init_thread_masks(rec);
+	if (err) {
+		pr_err("Failed to initialize parallel data streaming masks\n");
+		goto out;
+	}
+
 	if (rec->opts.nr_cblocks > nr_cblocks_max)
 		rec->opts.nr_cblocks = nr_cblocks_max;
 	pr_debug("nr_cblocks: %d\n", rec->opts.nr_cblocks);
@@ -2966,6 +3087,8 @@ int cmd_record(int argc, const char **argv)
 	symbol__exit();
 	auxtrace_record__free(rec->itr);
 out_opts:
+	record__free_thread_masks(rec, rec->nr_threads);
+	rec->nr_threads = 0;
 	evlist__close_control(rec->opts.ctl_fd, rec->opts.ctl_fd_ack, &rec->opts.ctl_fd_close);
 	return err;
 }
-- 
2.19.0

