Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 346A34E48FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 23:15:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237605AbiCVWRD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 18:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiCVWQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 18:16:58 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88392532FA
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:28 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e7-20020a258747000000b00633ee0cbca5so6449144ybn.23
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 15:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=F3HjAwFHmUFqibmCjU1kcbKfjPdPDY91fHBE1nAmJAM=;
        b=YJh7SVEbpn8oEZu7jCjxg6EQgGaZz+QnjlbSK4QakRjMXo0B3evobQA6gmx04u2l+N
         57QSMdXwEcNFlkAyJhaGb3Ge7F/gJfXx/oGQerQ3SdMkPjoBNycjV0QbkgPaLoUhi++q
         FRYClxoPIA+zghk4KAx7Tf4HURQ0+b7MRpHAFrqS+2t63QSsUOXL32eJlouxFM2OU/bC
         jwvUO95XNJooPnUlqGOTzQk49GvB3sw3lEtDeGzin37xymcEt1kSbvzFha0sDbmS4MRK
         Ci9xfNGT49V6slQLa9Eh3yxZoa4Zgg66WTSRWKT976P2kTgZuMht14CPWHyP65pb+hIa
         LMgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=F3HjAwFHmUFqibmCjU1kcbKfjPdPDY91fHBE1nAmJAM=;
        b=t0VdTynflY+AZAXgcvR3zI/Rk5+Qnz79pZa0a0+l6zguuRHbUevxIZWq2tPEWSlUbR
         r6u/WwpIG8bnsAbAeX1yVQX8yk/QrmYBe1H0lfG9qTL9FCXIvJ+BvKGA8Qrb5MfMLTaW
         A3U96gtsRhoGwfQMhpmdN9HPQ+qtJiupcyLwN1FFesP/DH6iVktjFcdIsn02vR8jM1us
         AkwTRN8iRXjsoGukiLOs8Rxj9JLGxIX8zbVSVCqhcNG5jbJdwdnunB9+YpwCl8mpalMw
         G0iXtVTNILJLoBkigF4/vkNMo7QfyprIZHDaSaaEszV+OcI8YDNKV3WD1U56iR5Bhls5
         7HBg==
X-Gm-Message-State: AOAM5329QpDddYGWeAkcImLzONEfykKeIDVo4yybXr6ttBryHESdBc2R
        N12RpAYSIGZl7dgC/bsdlBtO+k+17QI/ViNlNC+VBOfzlqtH6LIgv8nphyGxEuzKLc7FTKQVHbJ
        yfecwWfiwrVG0//RZRBsfvVSsZ/TweUnkd86CEwtP43osRC2S9QNcdhN6FYR34oBu91kSTDbe
X-Google-Smtp-Source: ABdhPJzO4ydn2G45VGg8j+cmD4fgAaCMbOgcCbiATHDQT+I6YXG1g30/TWMjkif9Z8Xl/XcMs1WlrgwY3IR5
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:1817:acc9:c45f:d133])
 (user=eranian job=sendgmr) by 2002:a25:bc6:0:b0:633:b8aa:dc48 with SMTP id
 189-20020a250bc6000000b00633b8aadc48mr24211634ybl.587.1647987327716; Tue, 22
 Mar 2022 15:15:27 -0700 (PDT)
Date:   Tue, 22 Mar 2022 15:15:05 -0700
In-Reply-To: <20220322221517.2510440-1-eranian@google.com>
Message-Id: <20220322221517.2510440-2-eranian@google.com>
Mime-Version: 1.0
References: <20220322221517.2510440-1-eranian@google.com>
X-Mailer: git-send-email 2.35.1.894.gb6a874cedc-goog
Subject: [PATCH v7 01/13] perf/core: add perf_clear_branch_entry_bitfields() helper
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, rafael@kernel.org,
        ravi.bangoria@amd.com, sandipan.das@amd.com
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
index fe1742c4ca49..13179f31fe10 100644
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
2.35.1.894.gb6a874cedc-goog

