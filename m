Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA432545AD8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 05:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346305AbiFJDvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 23:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346282AbiFJDvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 23:51:50 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DC9E338AC93;
        Thu,  9 Jun 2022 20:51:48 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C28A01682;
        Thu,  9 Jun 2022 20:51:48 -0700 (PDT)
Received: from a077893.blr.arm.com (unknown [10.162.42.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 7ED333F766;
        Thu,  9 Jun 2022 20:51:43 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
To:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        peterz@infradead.org, alexander.shishkin@linux.intel.com,
        jolsa@redhat.com, acme@kernel.org
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        James Clark <james.clark@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH V6 6/8] perf/tools: Extend branch type classification
Date:   Fri, 10 Jun 2022 09:20:59 +0530
Message-Id: <20220610035101.424112-7-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220610035101.424112-1-anshuman.khandual@arm.com>
References: <20220610035101.424112-1-anshuman.khandual@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This updates the perf tool with generic branch type classification with new
ABI extender place holder i.e PERF_BR_EXTEND_ABI, the new 4 bit branch type
field i.e perf_branch_entry.new_type, new generic page fault related branch
types and some arch specific branch types as added earlier in the kernel.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Will Deacon <will@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-perf-users@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 tools/include/uapi/linux/perf_event.h | 16 ++++++++-
 tools/perf/builtin-script.c           |  2 +-
 tools/perf/util/branch.c              | 52 ++++++++++++++++++++++++++-
 tools/perf/util/branch.h              |  6 +++-
 tools/perf/util/session.c             |  2 +-
 5 files changed, 73 insertions(+), 5 deletions(-)

diff --git a/tools/include/uapi/linux/perf_event.h b/tools/include/uapi/linux/perf_event.h
index 26d8f0b5ac0d..d29280adc3c4 100644
--- a/tools/include/uapi/linux/perf_event.h
+++ b/tools/include/uapi/linux/perf_event.h
@@ -255,9 +255,22 @@ enum {
 	PERF_BR_IRQ		= 12,	/* irq */
 	PERF_BR_SERROR		= 13,	/* system error */
 	PERF_BR_NO_TX		= 14,	/* not in transaction */
+	PERF_BR_EXTEND_ABI	= 15,	/* extend ABI */
 	PERF_BR_MAX,
 };
 
+enum {
+	PERF_BR_NEW_FAULT_ALGN		= 0,    /* Alignment fault */
+	PERF_BR_NEW_FAULT_DATA		= 1,    /* Data fault */
+	PERF_BR_NEW_FAULT_INST		= 2,    /* Inst fault */
+	PERF_BR_NEW_ARCH_1		= 3,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_2		= 4,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_3		= 5,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_4		= 6,    /* Architecture specific */
+	PERF_BR_NEW_ARCH_5		= 7,    /* Architecture specific */
+	PERF_BR_NEW_MAX,
+};
+
 #define PERF_SAMPLE_BRANCH_PLM_ALL \
 	(PERF_SAMPLE_BRANCH_USER|\
 	 PERF_SAMPLE_BRANCH_KERNEL|\
@@ -1372,7 +1385,8 @@ struct perf_branch_entry {
 		abort:1,    /* transaction abort */
 		cycles:16,  /* cycle count to last branch */
 		type:4,     /* branch type */
-		reserved:40;
+		new_type:4, /* additional branch type */
+		reserved:36;
 };
 
 union perf_sample_weight {
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index c689054002cc..d4d581230f23 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -866,7 +866,7 @@ static int print_bstack_flags(FILE *fp, struct branch_entry *br)
 		       br->flags.in_tx ? 'X' : '-',
 		       br->flags.abort ? 'A' : '-',
 		       br->flags.cycles,
-		       br->flags.type ? branch_type_name(br->flags.type) : "-");
+		       get_branch_type(br));
 }
 
 static int perf_sample__fprintf_brstack(struct perf_sample *sample,
diff --git a/tools/perf/util/branch.c b/tools/perf/util/branch.c
index abc673347bee..6d962b0a4532 100644
--- a/tools/perf/util/branch.c
+++ b/tools/perf/util/branch.c
@@ -21,7 +21,10 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
 	if (flags->type == PERF_BR_UNKNOWN || from == 0)
 		return;
 
-	st->counts[flags->type]++;
+	if (flags->type == PERF_BR_EXTEND_ABI)
+		st->new_counts[flags->new_type]++;
+	else
+		st->counts[flags->type]++;
 
 	if (flags->type == PERF_BR_COND) {
 		if (to > from)
@@ -36,6 +39,25 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
 		st->cross_4k++;
 }
 
+const char *branch_new_type_name(int new_type)
+{
+	const char *branch_new_names[PERF_BR_NEW_MAX] = {
+		"FAULT_ALGN",
+		"FAULT_DATA",
+		"FAULT_INST",
+		"ARCH_1",
+		"ARCH_2",
+		"ARCH_3",
+		"ARCH_4",
+		"ARCH_5"
+	};
+
+	if (new_type >= 0 && new_type < PERF_BR_NEW_MAX)
+		return branch_new_names[new_type];
+
+	return NULL;
+}
+
 const char *branch_type_name(int type)
 {
 	const char *branch_names[PERF_BR_MAX] = {
@@ -62,6 +84,17 @@ const char *branch_type_name(int type)
 	return NULL;
 }
 
+const char *get_branch_type(struct branch_entry *e)
+{
+	if (e->flags.type == PERF_BR_UNKNOWN)
+		return "";
+
+	if (e->flags.type == PERF_BR_EXTEND_ABI)
+		return branch_new_type_name(e->flags.new_type);
+
+	return branch_type_name(e->flags.type);
+}
+
 void branch_type_stat_display(FILE *fp, struct branch_type_stat *st)
 {
 	u64 total = 0;
@@ -108,6 +141,15 @@ void branch_type_stat_display(FILE *fp, struct branch_type_stat *st)
 				100.0 *
 				(double)st->counts[i] / (double)total);
 	}
+
+	for (i = 0; i < PERF_BR_NEW_MAX; i++) {
+		if (st->new_counts[i] > 0)
+			fprintf(fp, "\n%8s: %5.1f%%",
+				branch_new_type_name(i),
+				100.0 *
+				(double)st->new_counts[i] / (double)total);
+	}
+
 }
 
 static int count_str_scnprintf(int idx, const char *str, char *bf, int size)
@@ -123,6 +165,9 @@ int branch_type_str(struct branch_type_stat *st, char *bf, int size)
 	for (i = 0; i < PERF_BR_MAX; i++)
 		total += st->counts[i];
 
+	for (i = 0; i < PERF_BR_NEW_MAX; i++)
+		total += st->new_counts[i];
+
 	if (total == 0)
 		return 0;
 
@@ -140,6 +185,11 @@ int branch_type_str(struct branch_type_stat *st, char *bf, int size)
 			printed += count_str_scnprintf(j++, branch_type_name(i), bf + printed, size - printed);
 	}
 
+	for (i = 0; i < PERF_BR_NEW_MAX; i++) {
+		if (st->new_counts[i] > 0)
+			printed += count_str_scnprintf(j++, branch_new_type_name(i), bf + printed, size - printed);
+	}
+
 	if (st->cross_4k > 0)
 		printed += count_str_scnprintf(j++, "CROSS_4K", bf + printed, size - printed);
 
diff --git a/tools/perf/util/branch.h b/tools/perf/util/branch.h
index 17b2ccc61094..8d251b35428a 100644
--- a/tools/perf/util/branch.h
+++ b/tools/perf/util/branch.h
@@ -24,7 +24,8 @@ struct branch_flags {
 			u64 abort:1;
 			u64 cycles:16;
 			u64 type:4;
-			u64 reserved:40;
+			u64 new_type:4;
+			u64 reserved:36;
 		};
 	};
 };
@@ -72,6 +73,7 @@ static inline struct branch_entry *perf_sample__branch_entries(struct perf_sampl
 struct branch_type_stat {
 	bool	branch_to;
 	u64	counts[PERF_BR_MAX];
+	u64	new_counts[PERF_BR_NEW_MAX];
 	u64	cond_fwd;
 	u64	cond_bwd;
 	u64	cross_4k;
@@ -82,6 +84,8 @@ void branch_type_count(struct branch_type_stat *st, struct branch_flags *flags,
 		       u64 from, u64 to);
 
 const char *branch_type_name(int type);
+const char *branch_new_type_name(int new_type);
+const char *get_branch_type(struct branch_entry *e);
 void branch_type_stat_display(FILE *fp, struct branch_type_stat *st);
 int branch_type_str(struct branch_type_stat *st, char *bf, int bfsize);
 
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 0aa818977d2b..136fa03364ab 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1178,7 +1178,7 @@ static void branch_stack__printf(struct perf_sample *sample, bool callstack)
 				e->flags.abort ? "A" : " ",
 				e->flags.in_tx ? "T" : " ",
 				(unsigned)e->flags.reserved,
-				e->flags.type ? branch_type_name(e->flags.type) : "");
+				get_branch_type(e));
 		} else {
 			if (i == 0) {
 				printf("..... %2"PRIu64": %016" PRIx64 "\n"
-- 
2.25.1

