Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1C0E5A2B08
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 17:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343724AbiHZPWs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 11:22:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344194AbiHZPWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 11:22:24 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80C7E8310;
        Fri, 26 Aug 2022 08:16:16 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oRb44-0000j9-GB; Fri, 26 Aug 2022 17:16:08 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com
Cc:     palmer@dabbelt.com, aou@eecs.berkeley.edu,
        paul.walmsley@sifive.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        cmuellner@linux.com, philipp.tomsich@vrull.eu,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] drivers/perf: riscv_pmu_sbi: add perf_user_access sysctl
Date:   Fri, 26 Aug 2022 17:15:56 +0200
Message-Id: <20220826151556.1708879-1-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a sysctl similar to the one on arm64 to enable/disable
access to counter CSRs from u-mode on RISC-V.

The default is of course set to disabled keeping the current
state of access - to only the TIME CSR.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 Documentation/admin-guide/sysctl/kernel.rst |  6 +--
 drivers/perf/riscv_pmu_sbi.c                | 43 ++++++++++++++++++++-
 2 files changed, 44 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/sysctl/kernel.rst b/Documentation/admin-guide/sysctl/kernel.rst
index ee6572b1edad..efd4bc385e7a 100644
--- a/Documentation/admin-guide/sysctl/kernel.rst
+++ b/Documentation/admin-guide/sysctl/kernel.rst
@@ -894,15 +894,15 @@ enabled, otherwise writing to this file will return ``-EBUSY``.
 The default value is 8.
 
 
-perf_user_access (arm64 only)
-=================================
+perf_user_access (arm64 and riscv only)
+=======================================
 
 Controls user space access for reading perf event counters. When set to 1,
 user space can read performance monitor counter registers directly.
 
 The default value is 0 (access disabled).
 
-See Documentation/arm64/perf.rst for more information.
+See Documentation/arm64/perf.rst for more information on arm64
 
 
 pid_max
diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 6f6681bbfd36..7aab8d673357 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -41,6 +41,8 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
 	NULL,
 };
 
+static int sysctl_perf_user_access __read_mostly;
+
 /*
  * RISC-V doesn't have hetergenous harts yet. This need to be part of
  * per_cpu in case of harts with different pmu counters
@@ -640,13 +642,22 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	return IRQ_HANDLED;
 }
 
+/*
+ * Depending on the perf_user_access setting, enable the access
+ * from usermode either for all counters or for TIME csr only.
+ */
+static void riscv_pmu_update_user_access(void *info)
+{
+	csr_write(CSR_SCOUNTEREN, sysctl_perf_user_access ? GENMASK(31, 0) :
+							    0x2);
+}
+
 static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	struct riscv_pmu *pmu = hlist_entry_safe(node, struct riscv_pmu, node);
 	struct cpu_hw_events *cpu_hw_evt = this_cpu_ptr(pmu->hw_events);
 
-	/* Enable the access for TIME csr only from the user mode now */
-	csr_write(CSR_SCOUNTEREN, 0x2);
+	riscv_pmu_update_user_access(NULL);
 
 	/* Stop all the counters so that they can be enabled from perf */
 	pmu_sbi_stop_all(pmu);
@@ -785,6 +796,32 @@ static void riscv_pmu_destroy(struct riscv_pmu *pmu)
 	cpuhp_state_remove_instance(CPUHP_AP_PERF_RISCV_STARTING, &pmu->node);
 }
 
+static int riscv_pmu_proc_user_access_handler(struct ctl_table *table,
+			int write, void *buffer, size_t *lenp, loff_t *ppos)
+{
+	int ret = proc_dointvec_minmax(table, write, buffer, lenp, ppos);
+
+	if (ret || !write)
+		return ret;
+
+	on_each_cpu(riscv_pmu_update_user_access, NULL, 1);
+
+	return 0;
+}
+
+static struct ctl_table sbi_pmu_sysctl_table[] = {
+	{
+		.procname       = "perf_user_access",
+		.data		= &sysctl_perf_user_access,
+		.maxlen		= sizeof(unsigned int),
+		.mode           = 0644,
+		.proc_handler	= riscv_pmu_proc_user_access_handler,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{ }
+};
+
 static int pmu_sbi_device_probe(struct platform_device *pdev)
 {
 	struct riscv_pmu *pmu = NULL;
@@ -834,6 +871,8 @@ static int pmu_sbi_device_probe(struct platform_device *pdev)
 	if (ret)
 		goto out_unregister;
 
+	register_sysctl("kernel", sbi_pmu_sysctl_table);
+
 	return 0;
 
 out_unregister:
-- 
2.35.1

