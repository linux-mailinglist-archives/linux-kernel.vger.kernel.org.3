Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0521649105C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 19:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbiAQSfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 13:35:07 -0500
Received: from mga12.intel.com ([192.55.52.136]:48606 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242714AbiAQSfB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 13:35:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1642444501; x=1673980501;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0aHYD73piCArIhy7L3X52iWfwqLV+CmuHF+Tctl2QoI=;
  b=QUaQ9daO8cJsEgvUfNHYCVRrB/9zwgNLD8B16sgkkYsPf2psVTPBhl4n
   1H0rdojQk6q4GAAVXneBYfZWyELqal4ZgvwoyBBGxKBtEXksHhq1QF6Ys
   QpsKq3GNyH1PIAJiNGHUTkPd0pbSWcjBqWLjAc61J0VYdB2oTxK+N6xWq
   S9Ry+UVjS3ZUGT29QGu5bBZ6Am59a2LM5pEohkBWKCg/lO/T3nuePnddC
   E7u522wRsmX2ZJKPdHifEAaaP9jR51f7rxa0/UNHUXvBVL+Cwajm6C6LI
   qp+TCH3bFPTzqF1S4lF3t+U9b73uveL5t+OqcdmJdFwxSbahnymGDKJQe
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10229"; a="224656000"
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="224656000"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jan 2022 10:35:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,296,1635231600"; 
   d="scan'208";a="492434227"
Received: from nntpat99-84.inn.intel.com ([10.125.99.84])
  by orsmga002.jf.intel.com with ESMTP; 17 Jan 2022 10:34:57 -0800
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
Subject: [PATCH v13 06/16] perf record: Stop threads in the end of trace streaming
Date:   Mon, 17 Jan 2022 21:34:26 +0300
Message-Id: <55ef8cc5ec3a96360660d9dc1763573225325f8c.1642440724.git.alexey.v.bayduraev@linux.intel.com>
X-Mailer: git-send-email 2.19.0
In-Reply-To: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
References: <cover.1642440724.git.alexey.v.bayduraev@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signal thread to terminate by closing write fd of msg pipe.
Receive THREAD_MSG__READY message as the confirmation of the
thread's termination. Stop threads created for parallel trace
streaming prior their stats processing.

Acked-by: Andi Kleen <ak@linux.intel.com>
Acked-by: Namhyung Kim <namhyung@gmail.com>
Reviewed-by: Riccardo Mancini <rickyman7@gmail.com>
Tested-by: Riccardo Mancini <rickyman7@gmail.com>
Signed-off-by: Alexey Bayduraev <alexey.v.bayduraev@linux.intel.com>
---
 tools/perf/builtin-record.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 163d261dd293..0e65b80927b7 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -114,6 +114,16 @@ struct record_thread {
 
 static __thread struct record_thread *thread;
 
+enum thread_msg {
+	THREAD_MSG__UNDEFINED = 0,
+	THREAD_MSG__READY,
+	THREAD_MSG__MAX,
+};
+
+static const char *thread_msg_tags[THREAD_MSG__MAX] = {
+	"UNDEFINED", "READY"
+};
+
 struct record {
 	struct perf_tool	tool;
 	struct record_opts	opts;
@@ -1886,6 +1896,24 @@ static void record__uniquify_name(struct record *rec)
 	}
 }
 
+static int record__terminate_thread(struct record_thread *thread_data)
+{
+	int err;
+	enum thread_msg ack = THREAD_MSG__UNDEFINED;
+	pid_t tid = thread_data->tid;
+
+	close(thread_data->pipes.msg[1]);
+	thread_data->pipes.msg[1] = -1;
+	err = read(thread_data->pipes.ack[0], &ack, sizeof(ack));
+	if (err > 0)
+		pr_debug2("threads[%d]: sent %s\n", tid, thread_msg_tags[ack]);
+	else
+		pr_warning("threads[%d]: failed to receive termination notification from %d\n",
+			   thread->tid, tid);
+
+	return 0;
+}
+
 static int record__start_threads(struct record *rec)
 {
 	struct record_thread *thread_data = rec->thread_data;
@@ -1902,6 +1930,9 @@ static int record__stop_threads(struct record *rec)
 	int t;
 	struct record_thread *thread_data = rec->thread_data;
 
+	for (t = 1; t < rec->nr_threads; t++)
+		record__terminate_thread(&thread_data[t]);
+
 	for (t = 0; t < rec->nr_threads; t++)
 		rec->samples += thread_data[t].samples;
 
-- 
2.19.0

