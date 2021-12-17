Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6C9D47903C
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235528AbhLQPpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:45:47 -0500
Received: from foss.arm.com ([217.140.110.172]:59314 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235522AbhLQPpp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:45:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 40E671042;
        Fri, 17 Dec 2021 07:45:45 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 0F7073F774;
        Fri, 17 Dec 2021 07:45:42 -0800 (PST)
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
Subject: [PATCH v5 4/6] perf tools: enable dwarf_callchain_users on arm64
Date:   Fri, 17 Dec 2021 15:45:18 +0000
Message-Id: <20211217154521.80603-5-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217154521.80603-1-german.gomez@arm.com>
References: <20211217154521.80603-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Truong <alexandre.truong@arm.com>

On arm64, enable dwarf_callchain_users which will be needed
to do a dwarf unwind in order to get the caller of the leaf frame.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/builtin-report.c |  4 ++--
 tools/perf/builtin-script.c |  4 ++--
 tools/perf/util/callchain.c | 14 +++++++++++++-
 tools/perf/util/callchain.h |  2 +-
 4 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 8167ebfe776a..a31ad60ba66e 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -410,7 +410,7 @@ static int report__setup_sample_type(struct report *rep)
 		}
 	}
 
-	callchain_param_setup(sample_type);
+	callchain_param_setup(sample_type, perf_env__arch(&rep->session->header.env));
 
 	if (rep->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		ui__warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
@@ -1124,7 +1124,7 @@ static int process_attr(struct perf_tool *tool __maybe_unused,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(*pevlist);
-	callchain_param_setup(sample_type);
+	callchain_param_setup(sample_type, perf_env__arch((*pevlist)->env));
 	return 0;
 }
 
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index ab7d575f97f2..d308adfd1176 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -2318,7 +2318,7 @@ static int process_attr(struct perf_tool *tool, union perf_event *event,
 	 * on events sample_type.
 	 */
 	sample_type = evlist__combined_sample_type(evlist);
-	callchain_param_setup(sample_type);
+	callchain_param_setup(sample_type, perf_env__arch((*pevlist)->env));
 
 	/* Enable fields for callchain entries */
 	if (symbol_conf.use_callchain &&
@@ -3468,7 +3468,7 @@ static void script__setup_sample_type(struct perf_script *script)
 	struct perf_session *session = script->session;
 	u64 sample_type = evlist__combined_sample_type(session->evlist);
 
-	callchain_param_setup(sample_type);
+	callchain_param_setup(sample_type, perf_env__arch(session->machines.host.env));
 
 	if (script->stitch_lbr && (callchain_param.record_mode != CALLCHAIN_LBR)) {
 		pr_warning("Can't find LBR callchain. Switch off --stitch-lbr.\n"
diff --git a/tools/perf/util/callchain.c b/tools/perf/util/callchain.c
index 8e2777133bd9..131207b91d15 100644
--- a/tools/perf/util/callchain.c
+++ b/tools/perf/util/callchain.c
@@ -1600,7 +1600,7 @@ void callchain_cursor_reset(struct callchain_cursor *cursor)
 		map__zput(node->ms.map);
 }
 
-void callchain_param_setup(u64 sample_type)
+void callchain_param_setup(u64 sample_type, const char *arch)
 {
 	if (symbol_conf.use_callchain || symbol_conf.cumulate_callchain) {
 		if ((sample_type & PERF_SAMPLE_REGS_USER) &&
@@ -1612,6 +1612,18 @@ void callchain_param_setup(u64 sample_type)
 		else
 			callchain_param.record_mode = CALLCHAIN_FP;
 	}
+
+	/*
+	 * It's necessary to use libunwind to reliably determine the caller of
+	 * a leaf function on aarch64, as otherwise we cannot know whether to
+	 * start from the LR or FP.
+	 *
+	 * Always starting from the LR can result in duplicate or entirely
+	 * erroneous entries. Always skipping the LR and starting from the FP
+	 * can result in missing entries.
+	 */
+	if (callchain_param.record_mode == CALLCHAIN_FP && !strcmp(arch, "arm64"))
+		dwarf_callchain_users = true;
 }
 
 static bool chain_match(struct callchain_list *base_chain,
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 77fba053c677..d95615daed73 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -300,7 +300,7 @@ int callchain_branch_counts(struct callchain_root *root,
 			    u64 *branch_count, u64 *predicted_count,
 			    u64 *abort_count, u64 *cycles_count);
 
-void callchain_param_setup(u64 sample_type);
+void callchain_param_setup(u64 sample_type, const char *arch);
 
 bool callchain_cnode_matched(struct callchain_node *base_cnode,
 			     struct callchain_node *pair_cnode);
-- 
2.25.1

