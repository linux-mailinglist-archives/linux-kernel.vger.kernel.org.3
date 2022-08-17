Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F4DE596D63
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:15:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239009AbiHQLOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230122AbiHQLOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:14:06 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 479A24F676
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:14:04 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <heiko@sntech.de>)
        id 1oOGzk-0001wU-Nn; Wed, 17 Aug 2022 13:13:56 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        philipp.tomsich@vrull.eu, cmuellner@linux.com,
        Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH] drivers/perf: riscv_pmu_sbi: add support for PMU variant on T-Head C9xx cores
Date:   Wed, 17 Aug 2022 13:13:48 +0200
Message-Id: <20220817111348.745527-1-heiko@sntech.de>
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

With the T-HEAD C9XX cores being designed before or during the ratification
to the SSCOFPMF extension, they implement functionality very similar but
not equal to it. So add some adaptions to allow the C9XX to still handle
its PMU through the regular SBI PMU interface instead of defining new
interfaces or drivers.

To work properly, this requires a matching change in SBI, though the actual
interface between kernel and SBI does not change.

The main differences are a the overflow CSR and irq number.

Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 drivers/perf/riscv_pmu_sbi.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/perf/riscv_pmu_sbi.c b/drivers/perf/riscv_pmu_sbi.c
index 6f6681bbfd36..4589166e0de4 100644
--- a/drivers/perf/riscv_pmu_sbi.c
+++ b/drivers/perf/riscv_pmu_sbi.c
@@ -41,12 +41,17 @@ static const struct attribute_group *riscv_pmu_attr_groups[] = {
 	NULL,
 };
 
+#define THEAD_C9XX_RV_IRQ_PMU			17
+#define THEAD_C9XX_CSR_SCOUNTEROF		0x5c5
+
 /*
  * RISC-V doesn't have hetergenous harts yet. This need to be part of
  * per_cpu in case of harts with different pmu counters
  */
 static union sbi_pmu_ctr_info *pmu_ctr_list;
+static unsigned int riscv_pmu_irq_num;
 static unsigned int riscv_pmu_irq;
+static bool is_thead_c9xx;
 
 struct sbi_pmu_event_data {
 	union {
@@ -575,7 +580,7 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	fidx = find_first_bit(cpu_hw_evt->used_hw_ctrs, RISCV_MAX_COUNTERS);
 	event = cpu_hw_evt->events[fidx];
 	if (!event) {
-		csr_clear(CSR_SIP, SIP_LCOFIP);
+		csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
 		return IRQ_NONE;
 	}
 
@@ -583,13 +588,14 @@ static irqreturn_t pmu_sbi_ovf_handler(int irq, void *dev)
 	pmu_sbi_stop_hw_ctrs(pmu);
 
 	/* Overflow status register should only be read after counter are stopped */
-	overflow = csr_read(CSR_SSCOUNTOVF);
+	overflow = !is_thead_c9xx ? csr_read(CSR_SSCOUNTOVF)
+				  : csr_read(THEAD_C9XX_CSR_SCOUNTEROF);
 
 	/*
 	 * Overflow interrupt pending bit should only be cleared after stopping
 	 * all the counters to avoid any race condition.
 	 */
-	csr_clear(CSR_SIP, SIP_LCOFIP);
+	csr_clear(CSR_SIP, BIT(riscv_pmu_irq_num));
 
 	/* No overflow bit is set */
 	if (!overflow)
@@ -653,8 +659,8 @@ static int pmu_sbi_starting_cpu(unsigned int cpu, struct hlist_node *node)
 
 	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
 		cpu_hw_evt->irq = riscv_pmu_irq;
-		csr_clear(CSR_IP, BIT(RV_IRQ_PMU));
-		csr_set(CSR_IE, BIT(RV_IRQ_PMU));
+		csr_clear(CSR_IP, BIT(riscv_pmu_irq_num));
+		csr_set(CSR_IE, BIT(riscv_pmu_irq_num));
 		enable_percpu_irq(riscv_pmu_irq, IRQ_TYPE_NONE);
 	}
 
@@ -665,7 +671,7 @@ static int pmu_sbi_dying_cpu(unsigned int cpu, struct hlist_node *node)
 {
 	if (riscv_isa_extension_available(NULL, SSCOFPMF)) {
 		disable_percpu_irq(riscv_pmu_irq);
-		csr_clear(CSR_IE, BIT(RV_IRQ_PMU));
+		csr_clear(CSR_IE, BIT(riscv_pmu_irq_num));
 	}
 
 	/* Disable all counters access for user mode now */
@@ -681,7 +687,11 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 	struct device_node *cpu, *child;
 	struct irq_domain *domain = NULL;
 
-	if (!riscv_isa_extension_available(NULL, SSCOFPMF))
+	is_thead_c9xx = (sbi_get_mvendorid() == THEAD_VENDOR_ID &&
+			 sbi_get_marchid() == 0 &&
+			 sbi_get_mimpid() == 0);
+
+	if (!riscv_isa_extension_available(NULL, SSCOFPMF) && !is_thead_c9xx)
 		return -EOPNOTSUPP;
 
 	for_each_of_cpu_node(cpu) {
@@ -703,7 +713,8 @@ static int pmu_sbi_setup_irqs(struct riscv_pmu *pmu, struct platform_device *pde
 		return -ENODEV;
 	}
 
-	riscv_pmu_irq = irq_create_mapping(domain, RV_IRQ_PMU);
+	riscv_pmu_irq_num = !is_thead_c9xx ? RV_IRQ_PMU : THEAD_C9XX_RV_IRQ_PMU;
+	riscv_pmu_irq = irq_create_mapping(domain, riscv_pmu_irq_num);
 	if (!riscv_pmu_irq) {
 		pr_err("Failed to map PMU interrupt for node\n");
 		return -ENODEV;
-- 
2.35.1

