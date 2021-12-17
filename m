Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 37000479038
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 16:45:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbhLQPpf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 10:45:35 -0500
Received: from foss.arm.com ([217.140.110.172]:59256 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235339AbhLQPpe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 10:45:34 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6620E1476;
        Fri, 17 Dec 2021 07:45:34 -0800 (PST)
Received: from ip-10-252-15-108.eu-west-1.compute.internal (unknown [10.252.15.108])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 35BB33F774;
        Fri, 17 Dec 2021 07:45:32 -0800 (PST)
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
Subject: [PATCH v5 1/6] perf tools: record ARM64 LR register automatically
Date:   Fri, 17 Dec 2021 15:45:15 +0000
Message-Id: <20211217154521.80603-2-german.gomez@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217154521.80603-1-german.gomez@arm.com>
References: <20211217154521.80603-1-german.gomez@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Truong <alexandre.truong@arm.com>

On ARM64, automatically record the link register if the frame pointer
mode is on. It will be used to do a dwarf unwind to find the caller
of the leaf frame if the frame pointer was omitted.

Signed-off-by: Alexandre Truong <alexandre.truong@arm.com>
Signed-off-by: German Gomez <german.gomez@arm.com>
---
 tools/perf/arch/arm64/util/machine.c | 7 +++++++
 tools/perf/builtin-record.c          | 8 ++++++++
 tools/perf/util/callchain.h          | 2 ++
 3 files changed, 17 insertions(+)

diff --git a/tools/perf/arch/arm64/util/machine.c b/tools/perf/arch/arm64/util/machine.c
index 7e7714290a87..d2ce31e28cd7 100644
--- a/tools/perf/arch/arm64/util/machine.c
+++ b/tools/perf/arch/arm64/util/machine.c
@@ -5,6 +5,8 @@
 #include <string.h>
 #include "debug.h"
 #include "symbol.h"
+#include "callchain.h"
+#include "record.h"
 
 /* On arm64, kernel text segment starts at high memory address,
  * for example 0xffff 0000 8xxx xxxx. Modules start at a low memory
@@ -26,3 +28,8 @@ void arch__symbols__fixup_end(struct symbol *p, struct symbol *c)
 		p->end = c->start;
 	pr_debug4("%s sym:%s end:%#" PRIx64 "\n", __func__, p->name, p->end);
 }
+
+void arch__add_leaf_frame_record_opts(struct record_opts *opts)
+{
+	opts->sample_user_regs |= sample_reg_masks[PERF_REG_ARM64_LR].mask;
+}
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index 0338b813585a..6ac2160913ea 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -2267,6 +2267,10 @@ static int record__parse_mmap_pages(const struct option *opt,
 	return ret;
 }
 
+void __weak arch__add_leaf_frame_record_opts(struct record_opts *opts __maybe_unused)
+{
+}
+
 static int parse_control_option(const struct option *opt,
 				const char *str,
 				int unset __maybe_unused)
@@ -2898,6 +2902,10 @@ int cmd_record(int argc, const char **argv)
 	}
 
 	rec->opts.target.hybrid = perf_pmu__has_hybrid();
+
+	if (callchain_param.enabled && callchain_param.record_mode == CALLCHAIN_FP)
+		arch__add_leaf_frame_record_opts(&rec->opts);
+
 	err = -ENOMEM;
 	if (evlist__create_maps(rec->evlist, &rec->opts.target) < 0)
 		usage_with_options(record_usage, record_options);
diff --git a/tools/perf/util/callchain.h b/tools/perf/util/callchain.h
index 5824134f983b..77fba053c677 100644
--- a/tools/perf/util/callchain.h
+++ b/tools/perf/util/callchain.h
@@ -280,6 +280,8 @@ static inline int arch_skip_callchain_idx(struct thread *thread __maybe_unused,
 }
 #endif
 
+void arch__add_leaf_frame_record_opts(struct record_opts *opts);
+
 char *callchain_list__sym_name(struct callchain_list *cl,
 			       char *bf, size_t bfsize, bool show_dso);
 char *callchain_node__scnprintf_value(struct callchain_node *node,
-- 
2.25.1

