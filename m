Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83FBC4B1951
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 00:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345568AbiBJXSX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 18:18:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345151AbiBJXSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 18:18:22 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B2225F4E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:18:22 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id s18so9364978ioa.12
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 15:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=TZjvXmQL+ezx3++i6ywjCYX2+WSMiXHIFAoZu2xGMQA=;
        b=dh1iu5XVFR9JgGmMSioQ2P16YMuiIHmUjr61dP4GMbiQ/DBV+xy86sSdWmO7JGy9if
         SiLJjyrhAkltJyEffBig8nn7rsqFuMeuHJldrAgRTAtSTjv8EpjOdC6vIIDTuX1vQG8X
         tyHGhTZ88Kz+/3L0/sgBvY4LT8htAeWWCbvSN6jtFh9goqGhVxab8f4MrhWEbhotDg6L
         D4rDahldztLcHt5JGGWa7cSD6YDdH1+OScMRhdxHt5HBLYDySnNVxkvB/+UwZ4lyLXil
         hJs2m820KUfV0pMU7wth5QjgU8v0NZ4f1LIii2okFvCOfDuYH3BHp1hpFfvaosO6XBbb
         ncUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TZjvXmQL+ezx3++i6ywjCYX2+WSMiXHIFAoZu2xGMQA=;
        b=RXBY0e9SZqhaGPhmOXPDDLMnnBG9M2q5sFG3WxbPh0F1RbBlEi0z+x4P1IgQMQA23a
         AsfU0+1QfOQXYA02JBuBOwO2Fsej8GuyxCde5vSkh2a/sN6m8b0RcOL+PpFMNJuHUJkG
         eH+hlioj2G0lfP+/ChvKGZZOR5FIkN+83QxzHl5UiyDjqs4rqwOOpA6Snn0fY1wX+ftm
         rVqvsDKFNE+4CQ3dVQZNzBYyp875g855vQQ4LJruF3Ut5r3PhTzOExM49KTXahkX18kC
         b3GtjHlaFnA8wfRYOa/4SgBIW+eKiLpeICLzKf6JS42eODV52LpjR+ljS1mfCktgDuhc
         FgmQ==
X-Gm-Message-State: AOAM532OAke8JNP3A14NoEn7xdVmCsYTLiH17VVSAQpszoSExCh3akXI
        cHfmuqzV0EfOo8nywD0cHrU=
X-Google-Smtp-Source: ABdhPJzpdxrXi7jABYsEM7idoWZV3Dcam0pULppAeFkiKjAPVbRQOvUhQvFaYJB7D2HMiS0CGqRkmw==
X-Received: by 2002:a05:6602:2b10:: with SMTP id p16mr5163745iov.44.1644535101887;
        Thu, 10 Feb 2022 15:18:21 -0800 (PST)
Received: from localhost ([12.28.44.171])
        by smtp.gmail.com with ESMTPSA id p16sm8877673ilm.85.2022.02.10.15.18.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Feb 2022 15:18:21 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        David Laight <David.Laight@aculab.com>,
        Joe Perches <joe@perches.com>, Dennis Zhou <dennis@kernel.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Nicholas Piggin <npiggin@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Qi Liu <liuqi115@huawei.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH 12/49] perf: replace bitmap_weight with bitmap_empty where appropriate
Date:   Thu, 10 Feb 2022 14:48:56 -0800
Message-Id: <20220210224933.379149-13-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220210224933.379149-1-yury.norov@gmail.com>
References: <20220210224933.379149-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some places, drivers/perf code calls bitmap_weight() to check if any
bit of a given bitmap is set. It's better to use bitmap_empty() in that
case because bitmap_empty() stops traversing the bitmap as soon as it
finds first set bit, while bitmap_weight() counts all bits unconditionally.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/perf/arm-cci.c                   | 2 +-
 drivers/perf/arm_pmu.c                   | 4 ++--
 drivers/perf/hisilicon/hisi_uncore_pmu.c | 2 +-
 drivers/perf/xgene_pmu.c                 | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/perf/arm-cci.c b/drivers/perf/arm-cci.c
index 54aca3a62814..96e09fa40909 100644
--- a/drivers/perf/arm-cci.c
+++ b/drivers/perf/arm-cci.c
@@ -1096,7 +1096,7 @@ static void cci_pmu_enable(struct pmu *pmu)
 {
 	struct cci_pmu *cci_pmu = to_cci_pmu(pmu);
 	struct cci_pmu_hw_events *hw_events = &cci_pmu->hw_events;
-	int enabled = bitmap_weight(hw_events->used_mask, cci_pmu->num_cntrs);
+	bool enabled = !bitmap_empty(hw_events->used_mask, cci_pmu->num_cntrs);
 	unsigned long flags;
 
 	if (!enabled)
diff --git a/drivers/perf/arm_pmu.c b/drivers/perf/arm_pmu.c
index 295cc7952d0e..a31b302b0ade 100644
--- a/drivers/perf/arm_pmu.c
+++ b/drivers/perf/arm_pmu.c
@@ -524,7 +524,7 @@ static void armpmu_enable(struct pmu *pmu)
 {
 	struct arm_pmu *armpmu = to_arm_pmu(pmu);
 	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
-	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
+	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
 
 	/* For task-bound events we may be called on other CPUs */
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
@@ -785,7 +785,7 @@ static int cpu_pm_pmu_notify(struct notifier_block *b, unsigned long cmd,
 {
 	struct arm_pmu *armpmu = container_of(b, struct arm_pmu, cpu_pm_nb);
 	struct pmu_hw_events *hw_events = this_cpu_ptr(armpmu->hw_events);
-	int enabled = bitmap_weight(hw_events->used_mask, armpmu->num_events);
+	bool enabled = !bitmap_empty(hw_events->used_mask, armpmu->num_events);
 
 	if (!cpumask_test_cpu(smp_processor_id(), &armpmu->supported_cpus))
 		return NOTIFY_DONE;
diff --git a/drivers/perf/hisilicon/hisi_uncore_pmu.c b/drivers/perf/hisilicon/hisi_uncore_pmu.c
index a738aeab5c04..358e4e284a62 100644
--- a/drivers/perf/hisilicon/hisi_uncore_pmu.c
+++ b/drivers/perf/hisilicon/hisi_uncore_pmu.c
@@ -393,7 +393,7 @@ EXPORT_SYMBOL_GPL(hisi_uncore_pmu_read);
 void hisi_uncore_pmu_enable(struct pmu *pmu)
 {
 	struct hisi_pmu *hisi_pmu = to_hisi_pmu(pmu);
-	int enabled = bitmap_weight(hisi_pmu->pmu_events.used_mask,
+	bool enabled = !bitmap_empty(hisi_pmu->pmu_events.used_mask,
 				    hisi_pmu->num_counters);
 
 	if (!enabled)
diff --git a/drivers/perf/xgene_pmu.c b/drivers/perf/xgene_pmu.c
index 5283608dc055..0c32dffc7ede 100644
--- a/drivers/perf/xgene_pmu.c
+++ b/drivers/perf/xgene_pmu.c
@@ -867,7 +867,7 @@ static void xgene_perf_pmu_enable(struct pmu *pmu)
 {
 	struct xgene_pmu_dev *pmu_dev = to_pmu_dev(pmu);
 	struct xgene_pmu *xgene_pmu = pmu_dev->parent;
-	int enabled = bitmap_weight(pmu_dev->cntr_assign_mask,
+	bool enabled = !bitmap_empty(pmu_dev->cntr_assign_mask,
 			pmu_dev->max_counters);
 
 	if (!enabled)
-- 
2.32.0

