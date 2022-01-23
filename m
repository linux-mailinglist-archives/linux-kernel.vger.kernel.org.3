Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CE4A497479
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Jan 2022 19:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239734AbiAWSko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 13:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239764AbiAWSkf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 13:40:35 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAFBDC06174E
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:40:23 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i8so13106807pgt.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 10:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=QmvdvRYrU0pccxZjPQvOPFahs5Q0IVqksGfZERujS/w=;
        b=fEMWqJ0non1/1G7N6hoyBkFO73hoqLatan184u4QZ+CXOWfIxa+mKWmDZWQ330NtrL
         79a4csmu1WrP8S5N3nNrCuH8lsqH8E0i37IaLhihnfxVCBlGpZ2fIrpdpj0Sf/sxDVCm
         SD1AIe7Vg0kK9S/RYVeb5lJ1TkJynGTztkTNtNc6fjgN8wXC13OCBbb3Yjz2/2uYMPif
         zlhj6Q8IPowwVu8vMseCCqQVQa4umcM/Hzid4RgLiZfxYjowX4xiAAPFyMkcjLChRCh+
         JugaXNORXRbfPA4WwAdsVX5PX3vxTJsaiYITdOJiuCO+CTZSTYJLrDCdMCbCYWgff9A+
         TYkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QmvdvRYrU0pccxZjPQvOPFahs5Q0IVqksGfZERujS/w=;
        b=2nrsf2sKcCkKcOY0Im7NwEqJDSFT2sOpFLkNEuqaJ571c8fA0qA4p937yZItu8Sb+w
         hSDtIBKzyahzIcawcqro1B8GSj3VA9wPZfGOytdWEsCFbw9Zt4yppyWCnRQCpPvl+Llm
         a2L2BdxG5/IQcRoyA6KqNsQ2QRzouKl2ipRucaKKjmTfOCHCfUtHa/4ycLxEIkB3Ag35
         rfqTN8FDrTXbPtcdZ4VukPymzRCDYa7J9z+7jLAMoAWovE6ocFbnGVRXE0hjUBPYRzUi
         QmP9cP4I2XeO1Oeaxayj0izVKJD8+dybpy5o4KyC/+pYmDYXemalJV65tI/B27aLaN3c
         JUhQ==
X-Gm-Message-State: AOAM533aFoOjJCpKAkdwI2QvNZ0tmG/b/QBk4FLcqc0aG3gdDIxPcAoH
        Cnfub98SLGEExZ1e8KqHBZs=
X-Google-Smtp-Source: ABdhPJxe9Mdrm++g1fWsFijEPfG65qpS18BjZ5G1v3x54Dtr9GF+uWdZkbmUM6P3YG36cjhhM695Fg==
X-Received: by 2002:a63:7543:: with SMTP id f3mr9431653pgn.360.1642963223187;
        Sun, 23 Jan 2022 10:40:23 -0800 (PST)
Received: from localhost (searspoint.nvidia.com. [216.228.112.21])
        by smtp.gmail.com with ESMTPSA id y42sm5575467pfw.157.2022.01.23.10.40.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 10:40:22 -0800 (PST)
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
Subject: [PATCH 11/54] perf: replace bitmap_weight with bitmap_empty where appropriate
Date:   Sun, 23 Jan 2022 10:38:42 -0800
Message-Id: <20220123183925.1052919-12-yury.norov@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220123183925.1052919-1-yury.norov@gmail.com>
References: <20220123183925.1052919-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index 2b6d476bd213..88bd100a9633 100644
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
2.30.2

