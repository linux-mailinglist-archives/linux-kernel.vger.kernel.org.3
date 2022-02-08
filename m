Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E92B4AE4B9
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1387238AbiBHWfz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:35:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386835AbiBHVQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:16:55 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4BFC0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:16:53 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so368437ybg.8
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cGNJBKF6PsQgduFsVJ5Gh/suqswt2MaW3a4I4Gi0t+E=;
        b=Hm7/TufQO9AsHm4IIkCqa7Qhk1A5LQyxNQZSg1lgGy5u6TZA+6FoNJPutQGdwVsQrn
         CbAXBX2lpvyf47VHBbUAFYYl4O7pBrzflI0Lp5HdaSR697hin6dUk8jPdyvsnJYoVYLo
         4GkACrLCH4OWVMPoQErPa7HmmRspR4XvsCoCzEJFR7jBR4Lr+ZhjjhDwj2S9rjC6SVsx
         7ljOwCgE862AHqUyL4ATikJ2K/zN4Ftk435/nd/Oqd5shZEw6IKjV6lNU5ZMunhs2fGr
         f5KBugqWdLtFN8abbg5JzblrH6dgDQNG+QhBfhvkPNqkYQA90BukuPBoS/G7Hu7d9BZ3
         1CWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cGNJBKF6PsQgduFsVJ5Gh/suqswt2MaW3a4I4Gi0t+E=;
        b=3tL0+f7Ti94XOSRfKKxBEJ3lEutQhR/vtRCWZVDMRYopMTVjeUAb9E1I3Bm6+tdlKX
         kaMaivyHtjqaGn79/2lKCTYOMifdDzB19B7OMRK/O3ThcuBAyk2qGJBeYZpy5seq7iJJ
         QynbPoKv+EBKl+LACYUrU/ptEQkBZ7rfMm99x58RTW8UM5d/z1zAM9o7jP49WP+wZEb/
         uXf7FR2kuTuugnubM1kP9Wy2KV9rrB/CucduYUn/6dg+zz8xlRwXWGNQE1JjiMO4flWr
         TsVitapuwTYLWaTKzQOHIcsUDRUiCub1Xgs16owFV8HyZ49mlWebj6Dq5ROP19jmSOiy
         /B+Q==
X-Gm-Message-State: AOAM5323UEwN6muG1hexQQPXCh1lVL+VDEyuS9LCXJdj3CyU7/cDnnsZ
        6n6mYrLQWPxm4eRFycWybr6AWqXuWkPfbNw4eB0Ad5QlfB6HOVyXHODzDDBkzO+87Wc8CsGw8bu
        KT6JG7V44F7Y8pCLWF4Tbv0YxOMBlHcMG6IKafcPyDx+nTZMro8VYBakc9jVT12B7/BqYgLJw
X-Google-Smtp-Source: ABdhPJyBwnf/TcqlVb9aM+QBBfi+sfUmTWUzarAY36/5Ju7kQX8q4LTcWN6yrsR8hBEZiRL1mcwLx89q5PXy
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a25:9a49:: with SMTP id
 r9mr6800491ybo.90.1644355013096; Tue, 08 Feb 2022 13:16:53 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:26 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-2-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 01/12] perf/core: add perf_clear_branch_entry_bitfields() helper
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Make it simpler to reset all the info fields on the
perf_branch_entry by adding a helper inline function.

The goal is to centralize the initialization to avoid missing
a field in case more are added.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/lbr.c | 36 +++++++++++++++++-------------------
 include/linux/perf_event.h  | 16 ++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 669c2be14784..6a903113d3a6 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -769,6 +769,7 @@ void intel_pmu_lbr_disable_all(void)
 void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 {
 	unsigned long mask = x86_pmu.lbr_nr - 1;
+	struct perf_branch_entry *br = cpuc->lbr_entries;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 
@@ -784,15 +785,11 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
 		rdmsrl(x86_pmu.lbr_from + lbr_idx, msr_lastbranch.lbr);
 
-		cpuc->lbr_entries[i].from	= msr_lastbranch.from;
-		cpuc->lbr_entries[i].to		= msr_lastbranch.to;
-		cpuc->lbr_entries[i].mispred	= 0;
-		cpuc->lbr_entries[i].predicted	= 0;
-		cpuc->lbr_entries[i].in_tx	= 0;
-		cpuc->lbr_entries[i].abort	= 0;
-		cpuc->lbr_entries[i].cycles	= 0;
-		cpuc->lbr_entries[i].type	= 0;
-		cpuc->lbr_entries[i].reserved	= 0;
+		perf_clear_branch_entry_bitfields(br);
+
+		br->from	= msr_lastbranch.from;
+		br->to		= msr_lastbranch.to;
+		br++;
 	}
 	cpuc->lbr_stack.nr = i;
 	cpuc->lbr_stack.hw_idx = tos;
@@ -807,6 +804,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
+	struct perf_branch_entry *br = cpuc->lbr_entries;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 	int out = 0;
@@ -878,15 +876,14 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (abort && x86_pmu.lbr_double_abort && out > 0)
 			out--;
 
-		cpuc->lbr_entries[out].from	 = from;
-		cpuc->lbr_entries[out].to	 = to;
-		cpuc->lbr_entries[out].mispred	 = mis;
-		cpuc->lbr_entries[out].predicted = pred;
-		cpuc->lbr_entries[out].in_tx	 = in_tx;
-		cpuc->lbr_entries[out].abort	 = abort;
-		cpuc->lbr_entries[out].cycles	 = cycles;
-		cpuc->lbr_entries[out].type	 = 0;
-		cpuc->lbr_entries[out].reserved	 = 0;
+		perf_clear_branch_entry_bitfields(br+out);
+		br[out].from	 = from;
+		br[out].to	 = to;
+		br[out].mispred	 = mis;
+		br[out].predicted = pred;
+		br[out].in_tx	 = in_tx;
+		br[out].abort	 = abort;
+		br[out].cycles	 = cycles;
 		out++;
 	}
 	cpuc->lbr_stack.nr = out;
@@ -951,6 +948,8 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		to = rdlbr_to(i, lbr);
 		info = rdlbr_info(i, lbr);
 
+		perf_clear_branch_entry_bitfields(e);
+
 		e->from		= from;
 		e->to		= to;
 		e->mispred	= get_lbr_mispred(info);
@@ -959,7 +958,6 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
 		e->type		= get_lbr_br_type(info);
-		e->reserved	= 0;
 	}
 
 	cpuc->lbr_stack.nr = i;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 733649184b27..496eb6aa6e54 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1063,6 +1063,22 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->txn = 0;
 }
 
+/*
+ * Clear all bitfields in the perf_branch_entry.
+ * The to and from fields are not cleared because they are
+ * systematically modified by caller.
+ */
+static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *br)
+{
+	br->mispred = 0;
+	br->predicted = 0;
+	br->in_tx = 0;
+	br->abort = 0;
+	br->cycles = 0;
+	br->type = 0;
+	br->reserved = 0;
+}
+
 extern void perf_output_sample(struct perf_output_handle *handle,
 			       struct perf_event_header *header,
 			       struct perf_sample_data *data,
-- 
2.35.0.263.gb82422642f-goog

