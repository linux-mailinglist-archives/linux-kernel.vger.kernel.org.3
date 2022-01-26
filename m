Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F52549D634
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 00:35:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233637AbiAZXfg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 18:35:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233713AbiAZXfd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 18:35:33 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E3BFC06175D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:29 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e130-20020a255088000000b006126feb051eso2388176ybb.18
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 15:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=JTemGEzzHeUsU3GNF14twsiAxCFkERS3leLClaSD/3M=;
        b=FKwi4G+a6JhcoxXLGmqmlP1NiJd0lem/ZHdehBZWPzmtTyW5Bb4e/4J2J4dcjX3vnM
         L1o8jxyn8YdrmSgPNEAEt9C/DWXYuPsAmuGcBr51mV9R5e7W9NTI+m2yvzsLUa5hyWFe
         qznxTgi0t94ZOrecgTuPA54xcohb9p3ipS8nSa4nVDbwUC3ZNOle0uqXSkKS453IUGuF
         fPWAG9cxP3xcseaMbP4bHWA6PqKGnQwi+ilgv+IIF7W5J0ScStGCC/zOzTxggpdBOadO
         URYb2eci7QWK08GJJyHZ405f0Ua6ZhwAOLbC8l0yz6SEoz7LPaJn1zeTNjOQ7vchWWEk
         BGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=JTemGEzzHeUsU3GNF14twsiAxCFkERS3leLClaSD/3M=;
        b=RzEjSXRd8QWgIsLgyf2J/xbQlbRbQLDJNjPSEcUFNgwqhizMDtZnut2GNRlSflrGO5
         F/Uo+131tikiFdBR+4tQAykwx84+2H6gOlEijQAlbjrvBbf2bACt5uRY6zdoKWr/NeOa
         c3HUvPUMG0eO5NDF2nL3SPXmQkZTBthZ2j/kKF7YNu0Ag0a8qKkn8JEgtinpWTIdeHTV
         LvuLg4WtthiRQuxn+VO5Veb1T3NDdKaLgvFji/kFMac/xKGDyFcsSnp4eXMXY5exinYg
         6tc7c4/Llwgjdk9ddm0V7C3L6TgZ1zytGgd9TAENMt8jN5HVTTGPFVJREGMiPR9EheWJ
         Lalw==
X-Gm-Message-State: AOAM5301cnxkjwhuwe6qournbnOcvN0z9zcMIV5VmlF9O0yIp83yp+Ab
        z0Qkmbz6t0H64QHlfshuSvfDxGLSVDqjgAJFIrvYhI60+qtXwrDum/1XlQRtkwYk3McksQTZCRY
        lkZ3mDUKvgL0S+8PTJcbFyvvBaYMJNnMlaHhYtByCj5t3B6QoVPF3xZ25P69Rzfv7klr9xRLO
X-Google-Smtp-Source: ABdhPJyb0j3IHAhz49l/0F/CVgr5Q8KAdimQcPIWoM0qNpRx1rd/1qr2JZdBO8znlzkCUF/mqL7erB0Cpi4/
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:9ce0:6f20:c145:eac])
 (user=eranian job=sendgmr) by 2002:a81:84d1:: with SMTP id
 u200mr0ywf.291.1643240128192; Wed, 26 Jan 2022 15:35:28 -0800 (PST)
Date:   Wed, 26 Jan 2022 15:34:47 -0800
In-Reply-To: <20220126233454.3362047-1-eranian@google.com>
Message-Id: <20220126233454.3362047-7-eranian@google.com>
Mime-Version: 1.0
References: <20220126233454.3362047-1-eranian@google.com>
X-Mailer: git-send-email 2.35.0.rc0.227.g00780c9af4-goog
Subject: [PATCH v5 06/13] perf/x86/amd: add AMD branch sampling period adjustment
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This supplemental patch adds the code to adjust the sampling event period
when used with the Branch Sampling feature (BRS). Given the depth of the BRS
(16), the period is reduced by that depth such that in the best case
scenario, BRS saturates at the desired sampling period.  In practice, though,
the processor may execute more branches. Given a desired period P and a depth
D, the kernel programs the actual period at P - D. After P occurrences of the
sampling event, the counter overflows. It then may take X branches (skid)
before the NMI is caught and held by the hardware and BRS activates. Then,
after D branches, BRS saturates and the NMI is delivered.  With no skid, the
effective period would be (P - D) + D = P. In practice, however, it will
likely be (P - D) + X + D. There is no way to eliminate X or predict X.

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
2.35.0.rc0.227.g00780c9af4-goog

