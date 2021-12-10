Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14ED3470C29
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:02:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344301AbhLJVG0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:06:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243297AbhLJVGZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:25 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0BA3C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:02:49 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id s128-20020a255e86000000b005f89a35e57eso3148681ybb.19
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=p12qmLP9ijWQbcJrito67lmxzHpaqnnq8uXhqpQsMUs=;
        b=qAjHLRHhsy2jimphwLaekEe2Krt0SKICSnF3thdE9Cqz0APL/FsdlRf71ui/4rhdV6
         NxBwff3Svm0HozPKOVML4xQSqKDXJbvaYPy6906Rtp79rWEWPeSvziY4e6z+1HeiT3Gp
         Meo8egPjmOYR9hhsEnXRT5SJHvP8UWKSkWc88AGt1btHIup8l2db2v3aNSDlgusbiMuR
         RxHISn20xZAkW4Q5YBJIz356XFaw4tPjt0nSlWJwkIqPWN8vwKViMxIOaAbNxyom/Vux
         oIvoiZhCsWUAYaNelcDqivBBNyduoUPbx1PXWDrkjW+XhuHykPbvvajuwumfPuy7PURm
         P/fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=p12qmLP9ijWQbcJrito67lmxzHpaqnnq8uXhqpQsMUs=;
        b=cvS/Bz5Wq06VDwJwjRyBjxFozP4GcqRPz5WjVpGgdYFktQZ5kwfniJYgqW3Ld1xM5A
         q/4FpDQR0OqjDqqZ0JSg6yqol1wH+upbW6AvXl3Fno1VHrtlmXUr5vLcTWVNTtMb7VXN
         JP4KaE6LhpAVLNwMkdgsU00bNnr+Bbdx/RdHFxDfvISL95g1KoYaSfXuaMmTDlBWj0W7
         pe4bTsWhdNkn5kUo4diKvEQ1NJ1AuJQU1e4zXwKocYj/QtO4EKFK7u/dnZRxjTahiiYQ
         hu8eTZAy7G5nJTrl1hucs+bOaa9fZdPKy52u/yChq6t48iSumVPsaDFzpUKrBuw1Z3BH
         nqsQ==
X-Gm-Message-State: AOAM530wp/G4fjqSUknxqtme1PamvQczwxn3RFGS/e5HhxjCOBut16Mj
        RDSf7C/cXKiK6cT5GYSXiCAmjvqoGhumgkHigxx/m3YrTcTD49s4NRkv5Rl3vxAbZRZpGk4bdJx
        qkAjDKnI2OgluKmkVjpg/ko0eBNnFaxYUPmdf9oGvCE3gFPXWW75iOtGDqbG7mcBlm71lvkdM
X-Google-Smtp-Source: ABdhPJxbArD29EDmAfzkHY/By0VnCqlIHcGG3U75aWr6Q/Z7350E1CYPtQjbSbb9qQUQxK2YvjI6mnU9QVFO
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a25:d743:: with SMTP id
 o64mr16241279ybg.81.1639170168821; Fri, 10 Dec 2021 13:02:48 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:16 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-2-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 01/14] perf/core: add perf_clear_branch_entry_bitfields() helper
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To make it simpler to reset all the info fields on the
perf_branch_entry, this patch adds a helper inline function.
The goal is to centralize the initialization to avoid missing
a field in case more are added.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/intel/lbr.c | 36 +++++++++++++++++-------------------
 include/linux/perf_event.h  | 16 ++++++++++++++++
 2 files changed, 33 insertions(+), 19 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8043213b75a5..96f1b10a855f 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -778,6 +778,7 @@ void intel_pmu_lbr_disable_all(void)
 void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 {
 	unsigned long mask = x86_pmu.lbr_nr - 1;
+	struct perf_branch_entry *br = cpuc->lbr_entries;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 
@@ -793,15 +794,11 @@ void intel_pmu_lbr_read_32(struct cpu_hw_events *cpuc)
 
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
@@ -816,6 +813,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
+	struct perf_branch_entry *br = cpuc->lbr_entries;
 	int lbr_format = x86_pmu.intel_cap.lbr_format;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
@@ -888,15 +886,14 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
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
@@ -958,6 +955,8 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		to = rdlbr_to(i, lbr);
 		info = rdlbr_info(i, lbr);
 
+		perf_clear_branch_entry_bitfields(e);
+
 		e->from		= from;
 		e->to		= to;
 		e->mispred	= get_lbr_mispred(info);
@@ -966,7 +965,6 @@ static void intel_pmu_store_lbr(struct cpu_hw_events *cpuc,
 		e->abort	= !!(info & LBR_INFO_ABORT);
 		e->cycles	= get_lbr_cycles(info);
 		e->type		= get_lbr_br_type(info);
-		e->reserved	= 0;
 	}
 
 	cpuc->lbr_stack.nr = i;
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 7b7525e9155f..bbe02c80244b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1061,6 +1061,22 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
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
2.34.1.173.g76aa8bc2d0-goog

