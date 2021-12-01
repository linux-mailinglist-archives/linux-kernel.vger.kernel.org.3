Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5E5464460
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 02:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345904AbhLABGI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 20:06:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345962AbhLABF4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 20:05:56 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F1CC061746
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:35 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id m129-20020a632687000000b00324df4ad6c7so9879517pgm.19
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 17:02:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=gMnWpqfxqYn/p2ciIMbYw2HDq+3tjgTmTggu9jYTN8M=;
        b=Y5Rrl5Cmbl91Nrfgvved+lecOSCcNx2/Z5YgyZzJeNR+w77s64Nm6y+uO0dl4vF0oT
         cerqcD3151/kWeQh8ad12C6Hr0hwWHKHb1AUQ0eaM8+SYsDyAQtTvg/gXHi2Yt2FfaG5
         67KrL2lMYkQnVVafhPAxmEh/BFKRGMK14iLAazNNzhh611BDtS3kjWwoHGID7gF1KtNg
         Fu/JYoVLb4jmbXKDAoVBTFOHsW2hpz4WIIv/Mf3ojoNHsgBqdynLL2XKtprtLkOquMO2
         AbJ4alTh3RNfmyZLXwZvcsnFFWyJEUC66Aoo8z8+Vvqup+579au6JvTAbWGcd9roYlEk
         06sA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=gMnWpqfxqYn/p2ciIMbYw2HDq+3tjgTmTggu9jYTN8M=;
        b=2BhDaVJB73d+3j4RR1+S2VASqKdRSw2p1++iv10kwHPBftDeXpx6a0mVTeMbt0S0Xw
         o3ElkcBn1lA2j8G1pgTeTBeTq7g01nAlpS2npfxW7qk20mLnYnpQWGFTkDA2wlNIhYzn
         Z3sFV77jKjA7KlfkptN9FUrP4uR8gHDhLFK+wlSNunc0+bxmGOvaX0h4uFyUskaVNoYl
         X/IsHYBhNJw3CGtO+0SJhru4QdeGP3pQXC+RThJ89mR8CeP5We169fNbXIRl5aPTSEqy
         M5ighVeEYZX2i3kta1FGWEsuE7WeeCclTvsaSeMVRlf6hM1D3UWoQi+5LGxRn1yFzWhX
         fvvw==
X-Gm-Message-State: AOAM533lU/R7Is/Nxg+fiUEFBer6vjL5l8OKQ/sCuxBd5WfGJb0ChSfz
        /BeXTKD/owKqeHid5OyuYhIUGrruHGCMJ5EZ+zvFQuu2x+GbZfBKR1+bcWRWYnXCKgtdqQHvZUg
        cR50LOHe/W1o3TRLd6LWmobDe7LRu0B/0BruJeSRCCXlp8489HKeaRiNCEnk6aqyT8MWJoCWR
X-Google-Smtp-Source: ABdhPJwcRKund0Xi/CKJhDe+6cXMQww7Xtda2W3BhNdmJGYmggZFQN+LhhcQR2dPv1mPt/5jcnwEKAFjx6Mf
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:8776:d8e0:bb50:a95a])
 (user=eranian job=sendgmr) by 2002:a17:90a:49c2:: with SMTP id
 l2mr3261550pjm.23.1638320554648; Tue, 30 Nov 2021 17:02:34 -0800 (PST)
Date:   Tue, 30 Nov 2021 17:02:10 -0800
In-Reply-To: <20211201010217.886919-1-eranian@google.com>
Message-Id: <20211201010217.886919-7-eranian@google.com>
Mime-Version: 1.0
References: <20211201010217.886919-1-eranian@google.com>
X-Mailer: git-send-email 2.34.0.rc2.393.gf8c9666880-goog
Subject: [PATCH v3 06/13] perf/x86/amd: add AMD branch sampling period adjustment
From:   Stephane Eranian <eranian@google.com>
To:     linux-kernel@vger.kernel.org
Cc:     peterz@infradead.org, kim.phillips@amd.com, acme@redhat.com,
        jolsa@redhat.com, songliubraving@fb.com, mpe@ellerman.id.au,
        maddy@linux.ibm.com
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
index e294ff5d176e..22f882bc33c6 100644
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
index e7c904a9515d..74552845d942 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1257,6 +1257,14 @@ static inline bool amd_brs_active(void)
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
@@ -1281,6 +1289,10 @@ static inline void amd_brs_disable_all(void)
 {
 }
 
+static inline s64 amd_brs_adjust_period(s64 period)
+{
+	return period;
+}
 #endif /* CONFIG_CPU_SUP_AMD */
 
 static inline int is_pebs_pt(struct perf_event *event)
-- 
2.34.0.rc2.393.gf8c9666880-goog

