Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0244AE4B2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 23:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388971AbiBHWdr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 17:33:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386853AbiBHVRI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 16:17:08 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B05C0612B8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 13:17:07 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id a12-20020a056902056c00b0061dc0f2a94aso388597ybt.6
        for <linux-kernel@vger.kernel.org>; Tue, 08 Feb 2022 13:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=l7SK3hpl2tjo8fmJkEKtw/l+MWg699GiBeiSDOMnjGI=;
        b=M7vZM4ZREjaUtmHzubGbUso3C4ozlbjNKZqvghtgVrz9MmcgRU5etkyKJsvmcr8Q3r
         q6lyfZsEdfSK29U50aZ0pOWW0gUYabrBzKqxUHhNHzojj9Zh0kSJIcoz7SPZcV77RwB1
         MrAkKurRMn9nbC/21+6kuVSn21Y3j2RKG8rKMETkOJElB2MVKLSnJVOeL4kou9dxPOP/
         UVFWo0i8QPdL+5pu/INhcuHnJULb1D6hCry/NBXMrFQ4DYhwSzSUWykWM0qIyukeutWg
         GRJPF1MDCd/xxB8xzJyFDfbJqIBLLcc9sFJP+75ZRsid889rfjjEyIkZLMr/HC5/7s7x
         sw/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=l7SK3hpl2tjo8fmJkEKtw/l+MWg699GiBeiSDOMnjGI=;
        b=F1y4S5485ZX340nu+1R0NcHNB/gFOcnMTsnVoQUyrGDMJq0mKHgQIX6m67PyOOwpnx
         nkdeh6v3ShkB5fVEqhcR4sAszORaXJbNUlUx4vLPeBpzNQ43J3c/Fzd4R9Mrlj10P3q3
         gmp+P/IhcdIqMMEaIUCGpAYS5X1r9v1lfyrQdlcsCvXK8bNo07YDUHKja/IMghuWQMJM
         NC50iVENq6Jo8+F930e0yf/mewgWX9/YbBG/q0QL7ZaROLxw5He9WP8JNdlIGhSp4k0q
         L5w271SPHSz3pVz/f4EYng5IlSvQ4uJz3kbh40zUffY9fE8zqox/FOLfoDA3tZ6jdyMA
         YMCQ==
X-Gm-Message-State: AOAM530P7NEBvv2owE8Pcjlb4wBm/x3QaorI+2ok1G1SJDVHJKX9PGIe
        KVKFdLwQtUZnum5Hd0lSzGH8CnG16f66qNb1ITFchtdWZ9K5X+oYOXjxMaXAELUFI/sgaK5CWxI
        F7OrDKNza9lznkQwhD1o5jiy+O6AFkQNYPb/KxQIuwQQial+0bDLSwxBGGPOZVEGdN4igRc1r
X-Google-Smtp-Source: ABdhPJww16HAN32Z6YUGCbf+r3wgG+Y5yNKVjcEJ3h20rpY3mB6H5B3KgHoziz1vex98CAy2Q8lFajjLbHw/
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:6875:3c51:69be:6e2c])
 (user=eranian job=sendgmr) by 2002:a81:af54:: with SMTP id
 x20mr4840845ywj.337.1644355027029; Tue, 08 Feb 2022 13:17:07 -0800 (PST)
Date:   Tue,  8 Feb 2022 13:16:31 -0800
In-Reply-To: <20220208211637.2221872-1-eranian@google.com>
Message-Id: <20220208211637.2221872-7-eranian@google.com>
Mime-Version: 1.0
References: <20220208211637.2221872-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 06/12] perf/x86/amd: add AMD branch sampling period adjustment
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

Add code to adjust the sampling event period when used with the Branch
Sampling feature (BRS). Given the depth of the BRS (16), the period is
reduced by that depth such that in the best case scenario, BRS saturates at
the desired sampling period. In practice, though, the processor may execute
more branches. Given a desired period P and a depth D, the kernel programs
the actual period at P - D. After P occurrences of the sampling event, the
counter overflows. It then may take X branches (skid) before the NMI is
caught and held by the hardware and BRS activates. Then, after D branches,
BRS saturates and the NMI is delivered.  With no skid, the effective period
would be (P - D) + D = P. In practice, however, it will likely be (P - D) +
X + D. There is no way to eliminate X or predict X.

Signed-off-by: Stephane Eranian <eranian@google.com>
---
 arch/x86/events/core.c       |  7 +++++++
 arch/x86/events/perf_event.h | 12 ++++++++++++
 2 files changed, 19 insertions(+)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index c2a890caeb0a..ed285f640efe 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1374,6 +1374,13 @@ int x86_perf_event_set_period(struct perf_event *event)
 	    x86_pmu.set_topdown_event_period)
 		return x86_pmu.set_topdown_event_period(event);
 
+	/*
+	 * decrease period by the depth of the BRS feature to get
+	 * the last N taken branches and approximate the desired period
+	 */
+	if (has_branch_stack(event))
+		period = amd_brs_adjust_period(period);
+
 	/*
 	 * If we are way outside a reasonable range then just skip forward:
 	 */
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 3485a4cf0241..25b037b571e4 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1263,6 +1263,14 @@ static inline bool amd_brs_active(void)
 	return cpuc->brs_active;
 }
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
+	if (period > x86_pmu.lbr_nr)
+		return period - x86_pmu.lbr_nr;
+
+	return period;
+}
+
 #else /* CONFIG_CPU_SUP_AMD */
 
 static inline int amd_pmu_init(void)
@@ -1287,6 +1295,10 @@ static inline void amd_brs_disable_all(void)
 {
 }
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
+	return period;
+}
 #endif /* CONFIG_CPU_SUP_AMD */
 
 static inline int is_pebs_pt(struct perf_event *event)
-- 
2.35.0.263.gb82422642f-goog

