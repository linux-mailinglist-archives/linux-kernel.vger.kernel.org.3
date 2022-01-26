Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1B1A49D630
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:35:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233654AbiAZXfT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233637AbiAZXfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:17 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07949C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:17 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a4-20020a5b0ec4000000b00615dc8c1623so2403982ybs.17
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=cl/TZdY40/pws0twfq148T3oVCl6pd4IFhrlCHTA5xU=;
        b=FAaCU2Oss7ebYS6551P+5D4+zL7j0tdLfe4FUcGPTiIcBv/JDNbllz/1HPQpKBAY8p
         HLeve8Ysvxd0IjfjxWSj08CWMscAGQkhS9OhE8EtLlRkTojlKytxrQ59cH/XRfKSzSlG
         yQf1pQVyjAtiwtzvalfomcpYIk5gCW1z1M5hLm1MRA48USGaKbubT1bZxogK0EgovXt3
         cHDrAcnW7WSfTSrAu+CkvDvBPlG8pgbBGP/W7Xpd+/o4hdrb7lLN6XXl49D5VvyxhOrM
         DSq/qdcEejge3N17QBDfYNQyTYNVpjHmoHZDEhgzs6Z4mhN8juQWeDp2iBPvfcb6XKgo
         HUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=cl/TZdY40/pws0twfq148T3oVCl6pd4IFhrlCHTA5xU=;
        b=WcgaQhQyDYzbPTs1Osh1HF/Ypg8mgNK/kk6rGzGBPvnNvk0/9eS4zBRhfTePvAzWEh
         +N3D4TSXczwh+9RTSojzk44abUduXdR3FQtP3mA2CwIaxuqAZBocaXg+47T9EIuK1qCY
         JKtRenE0rFjH6HuciZWwbTtgm2OJODPzxR+LnbKSTPTCbYDt5NjIx6oqVTjtAaRfstXw
         p3BeXOftuFaGB8PShSUZQ7/d6/gMAneOmyHyCx0pJzwFo4OZvygGIFmavRiH9n0YiY3f
         d2yBYpip/xbHK6IVthw1v9YcJjtS+yKlfwh+hSVUhOh+0ZfZVJkA1HBlOl+WoLCDIaae
         i1fw==
X-Gm-Message-State: AOAM5318jTNMqP+V+u90rEShqJKfCY7X2sUxA2ITIEqJNWv6DbE8JX7p
        MKeTT67uyupl8zLYZgqTdgIOMP5CLljpk11u6nKQ8qPnzwnHNXzWMp4KMtJWI0C7EsfxRqhfef6
        4eAiUBVkIewO/PR/7w9nfJjraRtU8m1s9Jg4l1rQOcWqzT1h4dntqx4xcvk7964jGARGN7rqi
X-Google-Smtp-Source: ABdhPJwEGiEwIA9iFqZS50PRKzQ1JHl52/fvzmhkImUvzGR1i9o0gH2gxGi+ccgldSVteFeHc9bSFXt2LbAz
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a81:5a43:: with SMTP id
 o64mr1ywb.185.1643240115589; Wed, 26 Jan 2022 15:35:15 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:42 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-2-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 01/13] perf/core: add perf_clear_branch_entry_bitfields() helper
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
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
2.35.0.rc0.227.g00780c9af4-goog

