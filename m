Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E18214BC3B2
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 01:49:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240474AbiBSAry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:47:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240469AbiBSArj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:47:39 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E543277908
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:47:21 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id j2so4886126oie.7
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KzmhLvVz31vDzGMMY34u4TS6n0xBB5tfzWyXF9F+lho=;
        b=lXvzgeIW84VjTgJdYCIo+dLzmZaCO3ZzkPgwOEmtn6VOoYrBHo3GnjIJE/IeXP4uJL
         Mw7a2fbyTQ3BmDYQaL8wdMtX427VtK1mEbNnxslkVbeirG6RYxrR+mZx0kqRGfeD06oE
         5csQBlItRhfzxNNLlUxHHLtvr8hUo1mrbA3/r/6Fet8/bvXVyd9ORXx5TsJthNdj5mB7
         oPfM3fvRozywtHc5soKa+F4ncy5ncOPX2ssZXiA6u5nBK2nwvyTBOEaFvE9NjKi/vS1W
         SvbCwGUU1mShVd+gywPr9V874Y2pc01lYedWj6DkSI+iyUh8/ve14o4bcncWlIwIQXZG
         lmtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KzmhLvVz31vDzGMMY34u4TS6n0xBB5tfzWyXF9F+lho=;
        b=QQE3AxBbtDYiy0VaKWBASdmul0H1dplmIL4Y27bxCzf2msocu2pMydmJJCnBKvxhvf
         6LO8I+EN9jGXXL7GTasu/mNEtlwkBBxGy1eyx9FJmPJzjmDc08uGMI2uddmbaZSEKVKO
         rlZPu0Rb9NMon4XNnF6FtphFAFJskU9Bf0mj0TDo3gahz0JaaxAT2pwTqM8utDcU7jT3
         02EZWYZsyO+spxa699fnDjZVwmQ7Mpi4+4MPsrTbmHnzPhhpD2YQzQndLDWSAPg+qkL7
         UVPoYGV9RyohlRZvqnoc968HPsRuRy5Afl4rdH6qL0kEggrZD85HJmEoMejv2YKLULLA
         2J9w==
X-Gm-Message-State: AOAM531i42dxwaQFZzDxizbw0lN16HYCuCHwUqL0CqDswZMKRLNy7sR+
        jZrlYVs9uSHprxwSZpDUfaISK5/8mwk+AgL0
X-Google-Smtp-Source: ABdhPJyDev9Pc4oxIWxXyasAoZdwJfZr5R8goDRj6aWEX0l9J2Hc/U9mVA0sJ3SeJtP1S4bjHUy+/A==
X-Received: by 2002:a05:6808:2029:b0:2d0:8e1a:14f3 with SMTP id q41-20020a056808202900b002d08e1a14f3mr6444328oiw.257.1645231640482;
        Fri, 18 Feb 2022 16:47:20 -0800 (PST)
Received: from rivos-atish.. (adsl-70-228-75-190.dsl.akrnoh.ameritech.net. [70.228.75.190])
        by smtp.gmail.com with ESMTPSA id n11sm11360794oal.1.2022.02.18.16.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 16:47:20 -0800 (PST)
From:   Atish Patra <atishp@rivosinc.com>
To:     linux-kernel@vger.kernel.org
Cc:     Anup Patel <anup@brainfault.org>,
        Atish Patra <atishp@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Atish Patra <atishp@atishpatra.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        devicetree@vger.kernel.org, Jisheng Zhang <jszhang@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        linux-riscv@lists.infradead.org,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Rob Herring <robh+dt@kernel.org>
Subject: [v6 4/9] RISC-V: Add a simple platform driver for RISC-V legacy perf
Date:   Fri, 18 Feb 2022 16:46:55 -0800
Message-Id: <20220219004700.1973682-5-atishp@rivosinc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220219004700.1973682-1-atishp@rivosinc.com>
References: <20220219004700.1973682-1-atishp@rivosinc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Atish Patra <atish.patra@wdc.com>

The old RISC-V perf implementation allowed counting of only
cycle/instruction counters using perf. Restore that feature by implementing
a simple platform driver under a separate config to provide backward
compatibility. Any existing software stack will continue to work as it is.
However, it provides an easy way out in future where we can remove the
legacy driver.

Reviewed-by: Anup Patel <anup@brainfault.org>
Signed-off-by: Atish Patra <atish.patra@wdc.com>
Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 drivers/perf/Kconfig            |  10 +++
 drivers/perf/Makefile           |   1 +
 drivers/perf/riscv_pmu_legacy.c | 142 ++++++++++++++++++++++++++++++++
 include/linux/perf/riscv_pmu.h  |   6 ++
 4 files changed, 159 insertions(+)
 create mode 100644 drivers/perf/riscv_pmu_legacy.c

diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
index dbc0e3f98be9..386162ad858a 100644
--- a/drivers/perf/Kconfig
+++ b/drivers/perf/Kconfig
@@ -66,6 +66,16 @@ config RISCV_PMU
 	  PMU functionalities in a core library so that different PMU drivers
 	  can reuse it.
 
+config RISCV_PMU_LEGACY
+	depends on RISCV_PMU
+	bool "RISC-V legacy PMU implementation"
+	default y
+	help
+	  Say y if you want to use the legacy CPU performance monitor
+	  implementation on RISC-V based systems. This only allows counting
+	  of cycle/instruction counter and doesn't support counter overflow,
+	  or programmable counters. It will be removed in future.
+
 config ARM_PMU_ACPI
 	depends on ARM_PMU && ACPI
 	def_bool y
diff --git a/drivers/perf/Makefile b/drivers/perf/Makefile
index 09082dea154b..c3d3268d495b 100644
--- a/drivers/perf/Makefile
+++ b/drivers/perf/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_HISI_PMU) += hisilicon/
 obj-$(CONFIG_QCOM_L2_PMU)	+= qcom_l2_pmu.o
 obj-$(CONFIG_QCOM_L3_PMU) += qcom_l3_pmu.o
 obj-$(CONFIG_RISCV_PMU) += riscv_pmu.o
+obj-$(CONFIG_RISCV_PMU_LEGACY) += riscv_pmu_legacy.o
 obj-$(CONFIG_THUNDERX2_PMU) += thunderx2_pmu.o
 obj-$(CONFIG_XGENE_PMU) += xgene_pmu.o
 obj-$(CONFIG_ARM_SPE_PMU) += arm_spe_pmu.o
diff --git a/drivers/perf/riscv_pmu_legacy.c b/drivers/perf/riscv_pmu_legacy.c
new file mode 100644
index 000000000000..342778782359
--- /dev/null
+++ b/drivers/perf/riscv_pmu_legacy.c
@@ -0,0 +1,142 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RISC-V performance counter support.
+ *
+ * Copyright (C) 2021 Western Digital Corporation or its affiliates.
+ *
+ * This implementation is based on old RISC-V perf and ARM perf event code
+ * which are in turn based on sparc64 and x86 code.
+ */
+
+#include <linux/mod_devicetable.h>
+#include <linux/perf/riscv_pmu.h>
+#include <linux/platform_device.h>
+
+#define RISCV_PMU_LEGACY_CYCLE		0
+#define RISCV_PMU_LEGACY_INSTRET	1
+#define RISCV_PMU_LEGACY_NUM_CTR	2
+
+static bool pmu_init_done;
+
+static int pmu_legacy_ctr_get_idx(struct perf_event *event)
+{
+	struct perf_event_attr *attr = &event->attr;
+
+	if (event->attr.type != PERF_TYPE_HARDWARE)
+		return -EOPNOTSUPP;
+	if (attr->config == PERF_COUNT_HW_CPU_CYCLES)
+		return RISCV_PMU_LEGACY_CYCLE;
+	else if (attr->config == PERF_COUNT_HW_INSTRUCTIONS)
+		return RISCV_PMU_LEGACY_INSTRET;
+	else
+		return -EOPNOTSUPP;
+}
+
+/* For legacy config & counter index are same */
+static int pmu_legacy_event_map(struct perf_event *event, u64 *config)
+{
+	return pmu_legacy_ctr_get_idx(event);
+}
+
+static u64 pmu_legacy_read_ctr(struct perf_event *event)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	int idx = hwc->idx;
+	u64 val;
+
+	if (idx == RISCV_PMU_LEGACY_CYCLE) {
+		val = riscv_pmu_ctr_read_csr(CSR_CYCLE);
+		if (IS_ENABLED(CONFIG_32BIT))
+			val = (u64)riscv_pmu_ctr_read_csr(CSR_CYCLEH) << 32 | val;
+	} else if (idx == RISCV_PMU_LEGACY_INSTRET) {
+		val = riscv_pmu_ctr_read_csr(CSR_INSTRET);
+		if (IS_ENABLED(CONFIG_32BIT))
+			val = ((u64)riscv_pmu_ctr_read_csr(CSR_INSTRETH)) << 32 | val;
+	} else
+		return 0;
+
+	return val;
+}
+
+static void pmu_legacy_ctr_start(struct perf_event *event, u64 ival)
+{
+	struct hw_perf_event *hwc = &event->hw;
+	u64 initial_val = pmu_legacy_read_ctr(event);
+
+	/**
+	 * The legacy method doesn't really have a start/stop method.
+	 * It also can not update the counter with a initial value.
+	 * But we still need to set the prev_count so that read() can compute
+	 * the delta. Just use the current counter value to set the prev_count.
+	 */
+	local64_set(&hwc->prev_count, initial_val);
+}
+
+/**
+ * This is just a simple implementation to allow legacy implementations
+ * compatible with new RISC-V PMU driver framework.
+ * This driver only allows reading two counters i.e CYCLE & INSTRET.
+ * However, it can not start or stop the counter. Thus, it is not very useful
+ * will be removed in future.
+ */
+static void pmu_legacy_init(struct riscv_pmu *pmu)
+{
+	pr_info("Legacy PMU implementation is available\n");
+
+	pmu->num_counters = RISCV_PMU_LEGACY_NUM_CTR;
+	pmu->ctr_start = pmu_legacy_ctr_start;
+	pmu->ctr_stop = NULL;
+	pmu->event_map = pmu_legacy_event_map;
+	pmu->ctr_get_idx = pmu_legacy_ctr_get_idx;
+	pmu->ctr_get_width = NULL;
+	pmu->ctr_clear_idx = NULL;
+	pmu->ctr_read = pmu_legacy_read_ctr;
+
+	perf_pmu_register(&pmu->pmu, "cpu", PERF_TYPE_RAW);
+}
+
+static int pmu_legacy_device_probe(struct platform_device *pdev)
+{
+	struct riscv_pmu *pmu = NULL;
+
+	pmu = riscv_pmu_alloc();
+	if (!pmu)
+		return -ENOMEM;
+	pmu_legacy_init(pmu);
+
+	return 0;
+}
+
+static struct platform_driver pmu_legacy_driver = {
+	.probe		= pmu_legacy_device_probe,
+	.driver		= {
+		.name	= RISCV_PMU_LEGACY_PDEV_NAME,
+	},
+};
+
+static int __init riscv_pmu_legacy_devinit(void)
+{
+	int ret;
+	struct platform_device *pdev;
+
+	if (likely(pmu_init_done))
+		return 0;
+
+	ret = platform_driver_register(&pmu_legacy_driver);
+	if (ret)
+		return ret;
+
+	pdev = platform_device_register_simple(RISCV_PMU_LEGACY_PDEV_NAME, -1, NULL, 0);
+	if (IS_ERR(pdev)) {
+		platform_driver_unregister(&pmu_legacy_driver);
+		return PTR_ERR(pdev);
+	}
+
+	return ret;
+}
+late_initcall(riscv_pmu_legacy_devinit);
+
+void riscv_pmu_legacy_skip_init(void)
+{
+	pmu_init_done = true;
+}
diff --git a/include/linux/perf/riscv_pmu.h b/include/linux/perf/riscv_pmu.h
index 0d8979765d79..9140c491fc54 100644
--- a/include/linux/perf/riscv_pmu.h
+++ b/include/linux/perf/riscv_pmu.h
@@ -22,6 +22,7 @@
 #define RISCV_MAX_COUNTERS	64
 #define RISCV_OP_UNSUPP		(-EOPNOTSUPP)
 #define RISCV_PMU_PDEV_NAME	"riscv-pmu"
+#define RISCV_PMU_LEGACY_PDEV_NAME	"riscv-pmu-legacy"
 
 #define RISCV_PMU_STOP_FLAG_RESET 1
 
@@ -58,6 +59,11 @@ unsigned long riscv_pmu_ctr_read_csr(unsigned long csr);
 int riscv_pmu_event_set_period(struct perf_event *event);
 uint64_t riscv_pmu_ctr_get_width_mask(struct perf_event *event);
 u64 riscv_pmu_event_update(struct perf_event *event);
+#ifdef CONFIG_RISCV_PMU_LEGACY
+void riscv_pmu_legacy_skip_init(void);
+#else
+static inline void riscv_pmu_legacy_skip_init(void) {};
+#endif
 struct riscv_pmu *riscv_pmu_alloc(void);
 
 #endif /* CONFIG_RISCV_PMU */
-- 
2.30.2

