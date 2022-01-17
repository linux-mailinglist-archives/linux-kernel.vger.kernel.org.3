Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 500C3491054
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:35:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242633AbiAQSew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:34:52 -0500
Received: from mga12.intel.com ([192.55.52.136]:48606 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242623AbiAQSeu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:34:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444490; x=1673980490;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=nt4t4Xuqp1GYKchGNKkhe1lICgaJ+eeqMu+6O4L6II4=;
  b=Qyu6/q0tT8qF3zZpZNIIcrDQ9IJbB9fQQtrge+aijSjbWhqx4Cee/edx
   INbUmG88gKTDVricSS4TbBal73k22hTSzVuAtaZh51HR21E4gGNMvLyLD
   QSIBHi4Q7+cADyXT59vK3/6n6aMWkoY/m4iSPl2VmaE2T0FPGnNvfz9gM
   NPCtco4uGv1dKMpiFoEki5f6RKDcADIbyUQPu6HmKP1ZR+Iv2htlezFIq
   sEQp2+XCEYshVpMCYaJpUzNoO7dFsW1namh865isnTZPWurR+9XtuKcjw
   zaBWRnxycYJshPFlRYhWqInpVUoIbfuqyd1mRUmo+xALwKWYOoNdowJFM
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224655981"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224655981"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:34:50 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434191"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:34:47 -0800
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
Subject: [PATCH v13 03/16] perf record: Introduce thread specific data array
Date:   Mon, 17 Jan 2022 21:34:23 +0300
Message-Id: <fc9f74af6f822d9c0fa0e145c3564a760dbe3d4b.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce thread specific data object and array of such objects
to store and manage thread local data. Implement functions to
allocate, initialize, finalize and release thread specific data.

Thread local maps and overwrite_maps arrays keep pointers to
mmap buffer objects to serve according to maps thread mask.
Thread local pollfd array keeps event fds connected to mmaps
buffers according to maps thread mask.

Thread control commands are delivered via thread local comm pipes
and ctlfd_pos fd. External control commands (--control option)
are delivered via evlist ctlfd_pos fd and handled by the main
tool thread.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 247 +++++++++++++++++++++++++++++++++++-
 1 file changed, 244 insertions(+), 3 deletions(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 41998f2140cd..0d4a34c66274 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -58,6 +58,9 @@
 #include <poll.h>
 #include <pthread.h>
 #include <unistd.h>
+#ifndef HAVE_GETTID
+#include <syscall.h>
+#endif
 #include <sched.h>
 #include <signal.h>
 #ifdef HAVE_EVENTFD_SUPPORT
@@ -92,6 +95,21 @@ struct thread_mask {
 	struct mmap_cpu_mask	affinity;
 };
 
+struct record_thread {
+	pid_t			tid;
+	struct thread_mask	*mask;
+	struct {
+		int		msg[2];
+		int		ack[2];
+	} pipes;
+	struct fdarray		pollfd;
+	int			ctlfd_pos;
+	int			nr_mmaps;
+	struct mmap		**maps;
+	struct mmap		**overwrite_maps;
+	struct record		*rec;
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -119,6 +137,7 @@ struct record {
 	struct perf_debuginfod	debuginfod;
 	int			nr_threads;
 	struct thread_mask	*thread_masks;
+	struct record_thread	*thread_data;
 };
 
 static volatile int done;
@@ -131,6 +150,13 @@ static const char *affinity_tags[PERF_AFFINITY_MAX] = {
 	"SYS", "NODE", "CPU"
 };
 
+#ifndef HAVE_GETTID
+static inline pid_t gettid(void)
+{
+	return (pid_t)syscall(__NR_gettid);
+}
+#endif
+
 static bool switch_output_signal(struct record *rec)
 {
 	return rec->switch_output.signal &&
@@ -848,9 +874,218 @@ static int record__kcore_copy(struct machine *machine, struct perf_data *data)
 	return kcore_copy(from_dir, kcore_dir);
 }
 
+static void record__thread_data_init_pipes(struct record_thread *thread_data)
+{
+	thread_data->pipes.msg[0] = -1;
+	thread_data->pipes.msg[1] = -1;
+	thread_data->pipes.ack[0] = -1;
+	thread_data->pipes.ack[1] = -1;
+}
+
+static int record__thread_data_open_pipes(struct record_thread *thread_data)
+{
+	if (pipe(thread_data->pipes.msg))
+		return -EINVAL;
+
+	if (pipe(thread_data->pipes.ack)) {
+		close(thread_data->pipes.msg[0]);
+		thread_data->pipes.msg[0] = -1;
+		close(thread_data->pipes.msg[1]);
+		thread_data->pipes.msg[1] = -1;
+		return -EINVAL;
+	}
+
+	pr_debug2("thread_data[%p]: msg=[%d,%d], ack=[%d,%d]\n", thread_data,
+		 thread_data->pipes.msg[0], thread_data->pipes.msg[1],
+		 thread_data->pipes.ack[0], thread_data->pipes.ack[1]);
+
+	return 0;
+}
+
+static void record__thread_data_close_pipes(struct record_thread *thread_data)
+{
+	if (thread_data->pipes.msg[0] != -1) {
+		close(thread_data->pipes.msg[0]);
+		thread_data->pipes.msg[0] = -1;
+	}
+	if (thread_data->pipes.msg[1] != -1) {
+		close(thread_data->pipes.msg[1]);
+		thread_data->pipes.msg[1] = -1;
+	}
+	if (thread_data->pipes.ack[0] != -1) {
+		close(thread_data->pipes.ack[0]);
+		thread_data->pipes.ack[0] = -1;
+	}
+	if (thread_data->pipes.ack[1] != -1) {
+		close(thread_data->pipes.ack[1]);
+		thread_data->pipes.ack[1] = -1;
+	}
+}
+
+static int record__thread_data_init_maps(struct record_thread *thread_data, struct evlist *evlist)
+{
+	int m, tm, nr_mmaps = evlist->core.nr_mmaps;
+	struct mmap *mmap = evlist->mmap;
+	struct mmap *overwrite_mmap = evlist->overwrite_mmap;
+	struct perf_cpu_map *cpus = evlist->core.cpus;
+
+	thread_data->nr_mmaps = bitmap_weight(thread_data->mask->maps.bits,
+					      thread_data->mask->maps.nbits);
+	if (mmap) {
+		thread_data->maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
+		if (!thread_data->maps)
+			return -ENOMEM;
+	}
+	if (overwrite_mmap) {
+		thread_data->overwrite_maps = zalloc(thread_data->nr_mmaps * sizeof(struct mmap *));
+		if (!thread_data->overwrite_maps) {
+			zfree(&thread_data->maps);
+			return -ENOMEM;
+		}
+	}
+	pr_debug2("thread_data[%p]: nr_mmaps=%d, maps=%p, ow_maps=%p\n", thread_data,
+		 thread_data->nr_mmaps, thread_data->maps, thread_data->overwrite_maps);
+
+	for (m = 0, tm = 0; m < nr_mmaps && tm < thread_data->nr_mmaps; m++) {
+		if (test_bit(cpus->map[m].cpu, thread_data->mask->maps.bits)) {
+			if (thread_data->maps) {
+				thread_data->maps[tm] = &mmap[m];
+				pr_debug2("thread_data[%p]: cpu%d: maps[%d] -> mmap[%d]\n",
+					  thread_data, cpus->map[m].cpu, tm, m);
+			}
+			if (thread_data->overwrite_maps) {
+				thread_data->overwrite_maps[tm] = &overwrite_mmap[m];
+				pr_debug2("thread_data[%p]: cpu%d: ow_maps[%d] -> ow_mmap[%d]\n",
+					  thread_data, cpus->map[m].cpu, tm, m);
+			}
+			tm++;
+		}
+	}
+
+	return 0;
+}
+
+static int record__thread_data_init_pollfd(struct record_thread *thread_data, struct evlist *evlist)
+{
+	int f, tm, pos;
+	struct mmap *map, *overwrite_map;
+
+	fdarray__init(&thread_data->pollfd, 64);
+
+	for (tm = 0; tm < thread_data->nr_mmaps; tm++) {
+		map = thread_data->maps ? thread_data->maps[tm] : NULL;
+		overwrite_map = thread_data->overwrite_maps ?
+				thread_data->overwrite_maps[tm] : NULL;
+
+		for (f = 0; f < evlist->core.pollfd.nr; f++) {
+			void *ptr = evlist->core.pollfd.priv[f].ptr;
+
+			if ((map && ptr == map) || (overwrite_map && ptr == overwrite_map)) {
+				pos = fdarray__dup_entry_from(&thread_data->pollfd, f,
+							      &evlist->core.pollfd);
+				if (pos < 0)
+					return pos;
+				pr_debug2("thread_data[%p]: pollfd[%d] <- event_fd=%d\n",
+					 thread_data, pos, evlist->core.pollfd.entries[f].fd);
+			}
+		}
+	}
+
+	return 0;
+}
+
+static void record__free_thread_data(struct record *rec)
+{
+	int t;
+	struct record_thread *thread_data = rec->thread_data;
+
+	if (thread_data == NULL)
+		return;
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		record__thread_data_close_pipes(&thread_data[t]);
+		zfree(&thread_data[t].maps);
+		zfree(&thread_data[t].overwrite_maps);
+		fdarray__exit(&thread_data[t].pollfd);
+	}
+
+	zfree(&rec->thread_data);
+}
+
+static int record__alloc_thread_data(struct record *rec, struct evlist *evlist)
+{
+	int t, ret;
+	struct record_thread *thread_data;
+
+	rec->thread_data = zalloc(rec->nr_threads * sizeof(*(rec->thread_data)));
+	if (!rec->thread_data) {
+		pr_err("Failed to allocate thread data\n");
+		return -ENOMEM;
+	}
+	thread_data = rec->thread_data;
+
+	for (t = 0; t < rec->nr_threads; t++)
+		record__thread_data_init_pipes(&thread_data[t]);
+
+	for (t = 0; t < rec->nr_threads; t++) {
+		thread_data[t].rec = rec;
+		thread_data[t].mask = &rec->thread_masks[t];
+		ret = record__thread_data_init_maps(&thread_data[t], evlist);
+		if (ret) {
+			pr_err("Failed to initialize thread[%d] maps\n", t);
+			goto out_free;
+		}
+		ret = record__thread_data_init_pollfd(&thread_data[t], evlist);
+		if (ret) {
+			pr_err("Failed to initialize thread[%d] pollfd\n", t);
+			goto out_free;
+		}
+		if (t) {
+			thread_data[t].tid = -1;
+			ret = record__thread_data_open_pipes(&thread_data[t]);
+			if (ret) {
+				pr_err("Failed to open thread[%d] communication pipes\n", t);
+				goto out_free;
+			}
+			ret = fdarray__add(&thread_data[t].pollfd, thread_data[t].pipes.msg[0],
+					   POLLIN | POLLERR | POLLHUP, fdarray_flag__nonfilterable);
+			if (ret < 0) {
+				pr_err("Failed to add descriptor to thread[%d] pollfd\n", t);
+				goto out_free;
+			}
+			thread_data[t].ctlfd_pos = ret;
+			pr_debug2("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
+				 thread_data, thread_data[t].ctlfd_pos,
+				 thread_data[t].pipes.msg[0]);
+		} else {
+			thread_data[t].tid = gettid();
+			if (evlist->ctl_fd.pos == -1)
+				continue;
+			ret = fdarray__dup_entry_from(&thread_data[t].pollfd, evlist->ctl_fd.pos,
+						      &evlist->core.pollfd);
+			if (ret < 0) {
+				pr_err("Failed to duplicate descriptor in main thread pollfd\n");
+				goto out_free;
+			}
+			thread_data[t].ctlfd_pos = ret;
+			pr_debug2("thread_data[%p]: pollfd[%d] <- ctl_fd=%d\n",
+				 thread_data, thread_data[t].ctlfd_pos,
+				 evlist->core.pollfd.entries[evlist->ctl_fd.pos].fd);
+		}
+	}
+
+	return 0;
+
+out_free:
+	record__free_thread_data(rec);
+
+	return ret;
+}
+
 static int record__mmap_evlist(struct record *rec,
 			       struct evlist *evlist)
 {
+	int ret;
 	struct record_opts *opts = &rec->opts;
 	bool auxtrace_overwrite = opts->auxtrace_snapshot_mode ||
 				  opts->auxtrace_sample_mode;
@@ -881,6 +1116,14 @@ static int record__mmap_evlist(struct record *rec,
 				return -EINVAL;
 		}
 	}
+
+	if (evlist__initialize_ctlfd(evlist, opts->ctl_fd, opts->ctl_fd_ack))
+		return -1;
+
+	ret = record__alloc_thread_data(rec, evlist);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -1862,9 +2105,6 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 		evlist__start_workload(rec->evlist);
 	}
 
-	if (evlist__initialize_ctlfd(rec->evlist, opts->ctl_fd, opts->ctl_fd_ack))
-		goto out_child;
-
 	if (opts->initial_delay) {
 		pr_info(EVLIST_DISABLED_MSG);
 		if (opts->initial_delay > 0) {
@@ -2022,6 +2262,7 @@ static int __cmd_record(struct record *rec, int argc, const char **argv)
 out_child:
 	evlist__finalize_ctlfd(rec->evlist);
 	record__mmap_read_all(rec, true);
+	record__free_thread_data(rec);
 	record__aio_mmap_read_sync(rec);
 
 	if (rec->session->bytes_transferred && rec->session->bytes_compressed) {
-- 
2.19.0

