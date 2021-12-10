Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6589F470C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 22:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344364AbhLJVGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 16:06:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344319AbhLJVGi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 16:06:38 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A68C061D72
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:02 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id d9-20020a251d09000000b005c208092922so18398504ybd.20
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 13:03:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=oTICtxdOP8xRFpSevwcQ2GiqRMh1R5TnWnQIIDkDTSE=;
        b=O8AXkDRS1SU45pfSN0lGuFJJ9JpnDiti+HRcRiiCwaZ4oeACqy9UO7Ppf8n5qe+h6r
         icjVUhY5veMBqpQcvyTSB7czVjLVo6CnbjDzNGdqh9bftdFGvr2CFIEnV9f1uAdU2f3v
         2TwLESwhr7FsJ64u2fg2RKf3LhYfCmc7OIcU4ez9KffqovMaQ56ESQWmr+7XMjgpwIOK
         8I4+xL4mFB8KhMzU/wXq1n7JiOVnkeg/nnsxHrwnIazT0/t1/u2z+mHB3A+gSQE4xVWB
         OiwF6lqJqQ8FszePoTMMs2yLlz8hdcWeml9nyaT2yhEcP5B23N9MU4ZxsuJoXrpbY3vq
         FUAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=oTICtxdOP8xRFpSevwcQ2GiqRMh1R5TnWnQIIDkDTSE=;
        b=yR3TFDqFdX25x+xzvDh00wEA0n13wVdi4yOg/hWh4w/ggg5e2BdQT3rd2HzXPSqwFq
         KgmqcWgkx4u7/NSd7OfZWSMFr7ybWU5V25DZCZTudZFr3NPWyeNKGtyD9yBj6/ftRc6c
         Xwi9DInGoiTAs858r9XewCjCrXGMpYFO5fyA/brunyzOKAERVDrkRF9dT9WY5PUJ0X3X
         jWNv2PrfHv2ppEtHM5LCeWCaQNOC3JefR9RmS9eMa2X0+fr59oMub22eKcGVzRe8B3tC
         YcnVavf8SG0dmomUOqFsjNu8GQ/WcvAHsPUYO6hwIdwUxXm9P5p0Hnr9lpW0xy7QOst/
         oHNg==
X-Gm-Message-State: AOAM530BpzA/iXp/Kd2gNZ+2dCXP+qKDdYyPeXZPj3kLc6xPpJFiRcYM
        HfWHqybisTZPcpzPqVPYJUIGU0RWDP899flWhIxsY+WBQ3lczulAfDwFROrHx9O2zymoY0rhJRR
        xYNRfP2N4huyjxdepBx1y/lAAdMAEXc2ws42rLc4GhURRm95CbwIzW90OXXC+7f3FiavZohgk
X-Google-Smtp-Source: ABdhPJxvCJmGngZw+IM2E85+GTMu7wOVsGMx+Yl/2wa1WqZVQEP5SE2kSn61G6kHQMLtI58lphEkwkBGw58+
X-Received: from uluru3.svl.corp.google.com ([2620:15c:2cd:202:7416:17a6:6678:d4d5])
 (user=eranian job=sendgmr) by 2002:a25:74c1:: with SMTP id
 p184mr17808362ybc.499.1639170181382; Fri, 10 Dec 2021 13:03:01 -0800 (PST)
Date:   Fri, 10 Dec 2021 13:02:21 -0800
In-Reply-To: <20211210210229.2991238-1-eranian@google.com>
Message-Id: <20211210210229.2991238-7-eranian@google.com>
Mime-Version: 1.0
References: <20211210210229.2991238-1-eranian@google.com>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
Subject: [PATCH v4 06/14] perf/x86/amd: add AMD branch sampling period adjustment
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
2.34.1.173.g76aa8bc2d0-goog

