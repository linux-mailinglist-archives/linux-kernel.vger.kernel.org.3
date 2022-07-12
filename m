Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25641571464
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:22:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232310AbiGLIWS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbiGLIVp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:21:45 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E073A2EF0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:14 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso10680460pjc.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 01:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LByzoEIhL3E1KDbupc6kRL6RPMawgfjjXQqpSPrGKak=;
        b=n06J6es9DusA/tRgI3FHPicJ7/K3d+DWWrx7RuTB+dMN2cJ1vDGBmV4YT77mypbTG1
         0LK6OgapHJCuJALBHMh8KWjiS9jESICaGKmaZCMeV862wqVvaE3IfkqR1D8zepI2ry4E
         J3+SXRJ78acadkbW2tKB8A3Txmq4UTNZo/pROpom55elGxLW0F3b4saMQghKtPsjH2g/
         MOYM0+Y2gHqlIckkXLocwXPToQy44lwff7jBfeM/aF6f2IMi7l7WVYOiUWJrQAaQCipG
         zj59zxfRQQXbiCEHca0IjiOnOJxB+1hDCoqq4cMzCTxsKjVXxfEQT7ttmTYAy1yqnrk+
         tnGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LByzoEIhL3E1KDbupc6kRL6RPMawgfjjXQqpSPrGKak=;
        b=olRGSQQdbarNIdWDgH5DMTb+VLH8w+9E/5IAH0i8yHDazK9n932biFtb1o65PGj7Sr
         5UUsWjn6fG/VJ2ciRO5GjcZmMwopuAdJFZefeTTq9VQVdJqPeUZHdDQSZhtTzBCoM3SH
         3uqBES3B16nLl4/j0zPcHhxxiBE1rVSLYlv+V2LZJboYv+yEsgMKgy50CqsKdttfyCRk
         RWXSAaVBGrSXxpIDbC56YeeTe9zt27j2CWLWqpz1TzSAxOcy0ZD82n2t8lIzXYRGDLCC
         QyL2P19TJ+GCIM0TSt/bGiOzD4MdatozrC3fpR026Vfe4YWph9lPZZ/Cq4Rs/6C4TZbw
         UBMQ==
X-Gm-Message-State: AJIora+xQucLztYWmDzdh14PxCfUg+/2TL80rHiftQLZRo5AEDOrWSJh
        WM7TgJz1AJCyqWRjMkgZ4L5xBQ==
X-Google-Smtp-Source: AGRyM1vhsGs5PI555Z0BVtI9scEFyLEWSgWkdPNZNwYX2lBvPiZSk4BismTnvRRbm/xndbGRQMvoWQ==
X-Received: by 2002:a17:902:f652:b0:156:701b:9a2a with SMTP id m18-20020a170902f65200b00156701b9a2amr22523901plg.14.1657614073875;
        Tue, 12 Jul 2022 01:21:13 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id s13-20020aa78bcd000000b0050dc762816dsm6114428pfd.71.2022.07.12.01.21.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Jul 2022 01:21:13 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH 1/5] sched/fair: ignore SIS_UTIL when has idle core
Date:   Tue, 12 Jul 2022 16:20:32 +0800
Message-Id: <20220712082036.5130-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220712082036.5130-1-wuyun.abel@bytedance.com>
References: <20220712082036.5130-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When SIS_UTIL is enabled, SIS domain scan will be skipped if
the LLC is overloaded. Since the overloaded status is checked
in the load balancing at LLC level, the interval is llc_size
miliseconds. The duration might be long enough to affect the
overall system throughput if idle cores are out of reach in
SIS domain scan.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 kernel/sched/fair.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a78d2e3b9d49..cd758b3616bd 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6392,16 +6392,19 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 	struct sched_domain *this_sd;
 	u64 time = 0;
 
-	this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
-	if (!this_sd)
-		return -1;
-
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
 
-	if (sched_feat(SIS_PROP) && !has_idle_core) {
+	if (has_idle_core)
+		goto scan;
+
+	if (sched_feat(SIS_PROP)) {
 		u64 avg_cost, avg_idle, span_avg;
 		unsigned long now = jiffies;
 
+		this_sd = rcu_dereference(*this_cpu_ptr(&sd_llc));
+		if (!this_sd)
+			return -1;
+
 		/*
 		 * If we're busy, the assumption that the last idle period
 		 * predicts the future is flawed; age away the remaining
@@ -6436,7 +6439,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
 				return -1;
 		}
 	}
-
+scan:
 	for_each_cpu_wrap(cpu, cpus, target + 1) {
 		if (has_idle_core) {
 			i = select_idle_core(p, cpu, cpus, &idle_cpu);
-- 
2.31.1

