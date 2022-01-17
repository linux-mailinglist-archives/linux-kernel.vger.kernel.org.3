Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5096549105D
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242754AbiAQSfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:35:11 -0500
Received: from mga12.intel.com ([192.55.52.136]:48625 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242751AbiAQSfD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:35:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444503; x=1673980503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=vsyZWwGBsGFhD3Lx8Tnil6HXjJubaiVUXye0tTrVZ7E=;
  b=K3fCp9eH8qIirRK1OSAyF5KUNTtOZy49pNLwWE7WVc5Qn8Vx4eQxnENg
   o31Y5384tjO7oHvgLAoh7C23S00ahbMduRQoCQsM/T7jfKI4Yyegb9dbG
   kK89EOToZ7nMBwzsqTrG4g8lVlSDT+MA57U0J7IfRqq1EU5xhoo36MHlA
   euvXe+S2hD6HGBHWv3pEm7wv46Z10yGwKUdFFQptd/O7Fv/WiB5YVnXP+
   KnzEIO3+9HBtRDYLqs12R7PLcUCA9kku04/nCaVKZZBXPwxb1avUYnfWh
   kt6fhqBrxJ8eke/SqFoyJ8JenpcNn/3VicbooRZm1d1n1vmZr89+w+oTC
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224656003"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224656003"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:35:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434242"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:35:00 -0800
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
Subject: [PATCH v13 07/16] perf record: Start threads in the beginning of trace streaming
Date:   Mon, 17 Jan 2022 21:34:27 +0300
Message-Id: <95784dd9f7c81ee408eab27b50b4c09ad4cf7be6.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Start thread in detached state because its management is implemented
via messaging to avoid any scaling issues. Block signals prior thread
start so only main tool thread would be notified on external async
signals during data collection. Thread affinity mask is used to assign
eligible CPUs for the thread to run. Wait and sync on thread start using
thread ack pipe.

Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 121 +++++++++++++++++++++++++++++++++++-
 tools/perf/util/record.h    |   1 +
 2 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0e65b80927b7..517520ae1520 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -170,6 +170,11 @@ static inline pid_t gettid(void)
 }
 #endif
 
+static int record__threads_enabled(struct record *rec)
+{
+	return rec->opts.threads_spec;
+}
+
 static bool switch_output_signal(struct record *rec)
 {
 	return rec->switch_output.signal &&
@@ -1473,6 +1478,68 @@ static void record__thread_munmap_filtered(struct fdarray *fda, int fd,
 		perf_mmap__put(map);
 }
 
+static void *record__thread(void *arg)
+{
+	enum thread_msg msg = THREAD_MSG__READY;
+	bool terminate = false;
+	struct fdarray *pollfd;
+	int err, ctlfd_pos;
+
+	thread = arg;
+	thread->tid = gettid();
+
+	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
+	if (err == -1)
+		pr_warning("threads[%d]: failed to notify on start: %s\n",
+			   thread->tid, strerror(errno));
+
+	pr_debug("threads[%d]: started on cpu%d\n", thread->tid, sched_getcpu());
+
+	pollfd = &thread->pollfd;
+	ctlfd_pos = thread->ctlfd_pos;
+
+	for (;;) {
+		unsigned long long hits = thread->samples;
+
+		if (record__mmap_read_all(thread->rec, false) < 0 || terminate)
+			break;
+
+		if (hits == thread->samples) {
+
+			err = fdarray__poll(pollfd, -1);
+			/*
+			 * Propagate error, only if there's any. Ignore positive
+			 * number of returned events and interrupt error.
+			 */
+			if (err > 0 || (err < 0 && errno == EINTR))
+				err = 0;
+			thread->waking++;
+
+			if (fdarray__filter(pollfd, POLLERR | POLLHUP,
+					    record__thread_munmap_filtered, NULL) == 0)
+				break;
+		}
+
+		if (pollfd->entries[ctlfd_pos].revents & POLLHUP) {
+			terminate = true;
+			close(thread->pipes.msg[0]);
+			thread->pipes.msg[0] = -1;
+			pollfd->entries[ctlfd_pos].fd = -1;
+			pollfd->entries[ctlfd_pos].events = 0;
+		}
+
+		pollfd->entries[ctlfd_pos].revents = 0;
+	}
+	record__mmap_read_all(thread->rec, true);
+
+	err = write(thread->pipes.ack[1], &msg, sizeof(msg));
+	if (err == -1)
+		pr_warning("threads[%d]: failed to notify on termination: %s\n",
+			   thread->tid, strerror(errno));
+
+	return NULL;
+}
+
 static void record__init_features(struct record *rec)
 {
 	struct perf_session *session = rec->session;
@@ -1916,13 +1983,65 @@ static int record__terminate_thread(struct record_thread *thread_data)
 
 static int record__start_threads(struct record *rec)
 {
+	int t, tt, err, ret = 0, nr_threads = rec->nr_threads;
 	struct record_thread *thread_data = rec->thread_data;
+	sigset_t full, mask;
+	pthread_t handle;
+	pthread_attr_t attrs;
 
 	thread = &thread_data[0];
 
+	if (!record__threads_enabled(rec))
+		return 0;
+
+	sigfillset(&full);
+	if (sigprocmask(SIG_SETMASK, &full, &mask)) {
+		pr_err("Failed to block signals on threads start: %s\n", strerror(errno));
+		return -1;
+	}
+
+	pthread_attr_init(&attrs);
+	pthread_attr_setdetachstate(&attrs, PTHREAD_CREATE_DETACHED);
+
+	for (t = 1; t < nr_threads; t++) {
+		enum thread_msg msg = THREAD_MSG__UNDEFINED;
+
+#ifdef HAVE_PTHREAD_ATTR_SETAFFINITY_NP
+		pthread_attr_setaffinity_np(&attrs,
+					    MMAP_CPU_MASK_BYTES(&(thread_data[t].mask->affinity)),
+					    (cpu_set_t *)(thread_data[t].mask->affinity.bits));
+#endif
+		if (pthread_create(&handle, &attrs, record__thread, &thread_data[t])) {
+			for (tt = 1; tt < t; tt++)
+				record__terminate_thread(&thread_data[t]);
+			pr_err("Failed to start threads: %s\n", strerror(errno));
+			ret = -1;
+			goto out_err;
+		}
+
+		err = read(thread_data[t].pipes.ack[0], &msg, sizeof(msg));
+		if (err > 0)
+			pr_debug2("threads[%d]: sent %s\n", rec->thread_data[t].tid,
+				  thread_msg_tags[msg]);
+		else
+			pr_warning("threads[%d]: failed to receive start notification from %d\n",
+				   thread->tid, rec->thread_data[t].tid);
+	}
+
+	sched_setaffinity(0, MMAP_CPU_MASK_BYTES(&thread->mask->affinity),
+			(cpu_set_t *)thread->mask->affinity.bits);
+
 	pr_debug("threads[%d]: started on cpu%d\n", thread->tid, sched_getcpu());
 
-	return 0;
+out_err:
+	pthread_attr_destroy(&attrs);
+
+	if (sigprocmask(SIG_SETMASK, &mask, NULL)) {
+		pr_err("Failed to unblock signals on threads start: %s\n", strerror(errno));
+		ret = -1;
+	}
+
+	return ret;
 }
 
 static int record__stop_threads(struct record *rec)
diff --git a/tools/perf/util/record.h b/tools/perf/util/record.h
index ef6c2715fdd9..ad08c092f3dd 100644
--- a/tools/perf/util/record.h
+++ b/tools/perf/util/record.h
@@ -78,6 +78,7 @@ struct record_opts {
 	int	      ctl_fd_ack;
 	bool	      ctl_fd_close;
 	int	      synth;
+	int	      threads_spec;
 };
 
 extern const char * const *record_usage;
-- 
2.19.0

