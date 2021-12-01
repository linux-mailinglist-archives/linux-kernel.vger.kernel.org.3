Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBDF346445B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:02:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241029AbhLABFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236512AbhLABFp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:05:45 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148FCC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:25 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id l28-20020a25b31c000000b005c27dd4987bso32752488ybj.18
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tOh/A5ObFvWBGOmI5FJHSF3n8Yla8NHcpBu5qUyp50U=;
        b=R6r86mnfVNjJoWZYAEhqDGBURHA3X1N2mBVD7kBSvYr0upVmmLh+HXKD9XVSismxl/
         EhYUb6Az89I/MpSq/IYEw3RCk3tcTsan0TAgHd1Dfk3ZFfJCcWEmO096VywkfH6f5oSb
         j6TtEx/XQ2ihuQjTpUjyWU8myLYxJ4OSqoIcRqu06tfNV0AGDn0QQEM1bcpjfUrPgUtD
         Wbn314JFv+j6FdKSnSdoYSl4QxmE2VOvNOqhSsXftSuvGg4s6E0bu84cDTnVubXwUU2p
         WQTQ9GiOF7ABvqrCUiu4kMlfIC+L8SXiecfGRmU8xdEMK+ooKIV9x6NeCCqSOGcOg/YR
         5BbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tOh/A5ObFvWBGOmI5FJHSF3n8Yla8NHcpBu5qUyp50U=;
        b=7TCmJupQgfC7lEZw787jQIHOVofBL/47JudsRWUwSWfRo3DzC0ui0grJVc+X9lbG85
         7nHBjFGvWjBtz+LbXeX81ZpzVRyMRmLP6RexvqZlmJWUM6Wp14wvxhWXsaIKRWaytY6o
         d8PYdE3gNFWPU9uvoBryWgj55Zpe4MUE9ajSZ1w/b0hCi4jAGdae3hc5rgm5H8aFbjj3
         zHeJLWkzJzNrFjaRUel8DhC2MIpjoGA6NF2BvC8ZX0zO1mYCInr+NeHIf6JYJhVhEUrc
         +TAMg0IjSk9V4iFfUMWw3sZezShaMXGZdvrhx9e9A5wcoOX6do2zrxdgjIO38PQWRZNe
         OlYw==
X-Gm-Message-State: AOAM531+wYYM2sW2qAq8hj15X8Bn4I+EriYF7Rb5oYYaNIXwgWkyGbfo
        gWMjcAr4lZ61zaLqOoTJB8InAvsq/tOPRc+nKHR7k1l/59LGHgKHxLdXk0GEvtrnw/GG54WXxZ/
        pMUAU3/WZxCJ0yGeBLrnkP+T7aOYxLtn5vrF6jhmTsFpwTNM+JKKJDlhJPraHS3SkxwL1cAcI
X-Google-Smtp-Source: ABdhPJytcpCcBCd/spbjmlCaAEfBfIJEm4nDZC3Qco+SeaMkq304H32ESR4SLy/IW0u94iNS6UZehk6YY8WL
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a25:d4d5:: with SMTP id
 m204mr3436449ybf.418.1638320544274; Tue, 30 Nov 2021 17:02:24 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:05 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-2-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 01/13] perf/core: add perf_clear_branch_entry_bitfields() helper
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
2.34.0.rc2.393.gf8c9666880-goog

