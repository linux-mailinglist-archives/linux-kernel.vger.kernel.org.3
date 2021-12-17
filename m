Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCDE1479039
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235352AbhLQPpj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:45:39 -0500
Received: from foss.arm.com ([217.140.110.172]:59280 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235466AbhLQPpi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:45:38 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0947C14BF;
        Fri, 17 Dec 2021 07:45:38 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id CA81F3F774;
        Fri, 17 Dec 2021 07:45:35 -0800 (PST)
From:   German Gomez <german.gomez@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        acme@kernel.org
Cc:     Alexandre Truong <alexandre.truong@arm.com>,
        German Gomez <german.gomez@arm.com>,
        John Garry <john.garry@huawei.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v5 2/6] perf tools: add a mechanism to inject stack frames
Date:   Fri, 17 Dec 2021 15:45:16 +0000
Message-Id: <20211217154521.80603-3-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217154521.80603-1-german.gomez@arm.com>
References: <20211217154521.80603-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Truong <alexandre.truong@arm.com>

Add a mechanism for platforms to inject stack frames for the leaf
frame caller if there is enough information to determine a frame
is missing from dwarf or other post processing mechanisms.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/util/machine.c | 37 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 36 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index fb8496df8432..3eddad009f78 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2710,6 +2710,12 @@ static int find_prev_cpumode(struct ip_callchain *chain, struct thread *thread,
 	return err;
 }
 
+static u64 get_leaf_frame_caller(struct perf_sample *sample __maybe_unused,
+		struct thread *thread __maybe_unused, int usr_idx __maybe_unused)
+{
+	return 0;
+}
+
 static int thread__resolve_callchain_sample(struct thread *thread,
 					    struct callchain_cursor *cursor,
 					    struct evsel *evsel,
@@ -2723,9 +2729,10 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	struct ip_callchain *chain = sample->callchain;
 	int chain_nr = 0;
 	u8 cpumode = PERF_RECORD_MISC_USER;
-	int i, j, err, nr_entries;
+	int i, j, err, nr_entries, usr_idx;
 	int skip_idx = -1;
 	int first_call = 0;
+	u64 leaf_frame_caller;
 
 	if (chain)
 		chain_nr = chain->nr;
@@ -2850,6 +2857,34 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 			continue;
 		}
 
+		/*
+		 * PERF_CONTEXT_USER allows us to locate where the user stack ends.
+		 * Depending on callchain_param.order and the position of PERF_CONTEXT_USER,
+		 * the index will be different in order to add the missing frame
+		 * at the right place.
+		 */
+
+		usr_idx = callchain_param.order == ORDER_CALLEE ? j-2 : j-1;
+
+		if (usr_idx >= 0 && chain->ips[usr_idx] == PERF_CONTEXT_USER) {
+
+			leaf_frame_caller = get_leaf_frame_caller(sample, thread, usr_idx);
+
+			/*
+			 * check if leaf_frame_Caller != ip to not add the same
+			 * value twice.
+			 */
+
+			if (leaf_frame_caller && leaf_frame_caller != ip) {
+
+				err = add_callchain_ip(thread, cursor, parent,
+					       root_al, &cpumode, leaf_frame_caller,
+					       false, NULL, NULL, 0);
+				if (err)
+					return (err < 0) ? err : 0;
+			}
+		}
+
 		err = add_callchain_ip(thread, cursor, parent,
 				       root_al, &cpumode, ip,
 				       false, NULL, NULL, 0);
-- 
2.25.1

