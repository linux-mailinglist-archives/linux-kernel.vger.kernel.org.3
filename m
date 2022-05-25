Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65E4534000
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245121AbiEYPMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244982AbiEYPLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:11:49 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40475B0A64
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:37 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d22so18812292plr.9
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6tBkZ8eaMzyR91aQv2ATlbBDW1d2YgGFucG6FSF+jK0=;
        b=NWtWsJTtUMIEbihjx0Tm9ycrEhpm23m1Zi869pW6ELsoe96Fh2kIwo70W+QWUUrdUw
         hf1uO5j0LyMBWiwEJ3wLi53OV85cMaBFSmUepKNmecPvwh0l5i3btD+tDr8XZjZVGkCC
         PaGOVPBoz7u43EnhXUhwsIBOd6gbeDi8DJaW/3cw0Z0AQ4CikQvDRkiDOUeSAz9WDGUW
         56kXjlPB1tRGn73R7/q1IIUxQzWPPtDWqq/P5ZeUhbJXXhuWvVftD+/a2m19Db7eLiAp
         mmRgIdvY54SRfY9o+b7010GyTw9Oc/1JIuvSzUXhfodznYW46VS7t870wgChGusp8G1U
         AsuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6tBkZ8eaMzyR91aQv2ATlbBDW1d2YgGFucG6FSF+jK0=;
        b=Z4m4yqUBrilqD80+n9vMxYwtK42aMSYW2/wf6XUwl7ccOXsX7/9NqeGdmT1t0gV6MM
         nJAOUTCOtX7jAd5ETDHnparuFxWymReWgvQyVqh4jZjCi2WhLaLLU8K9ogfb0sLAynSq
         b35F63nyjDT9yLLdOKMystTwRjagjXEFTUIiIV8XqUUNINcu8H5my/TJHeMX6bJM+T8f
         eCpb85qVq57hgTLhfIOzOjqHe58IwE5r91GdXpjOfXWVGgE7DOXJJqRXM1h6xuX+NxbW
         TgYmYO8wzhhPs18mrDepKI03KuUISoV3og8SrQFUUc7tKDpnPnMxQjEY1X2XRGTxp3I+
         Q/Sg==
X-Gm-Message-State: AOAM533HIWaAdI824d6Plyj6nEc8ZutujA1rnpazCAl9ieOSgOjvGoOi
        9ezReB4rfxSRcHEIt6lez2FHqA==
X-Google-Smtp-Source: ABdhPJxn6gS6KitiUfbo4DUAK8/GgUYQJeBjldHMXPZADqEkcPZU2AlMI5RRq68SjwJOZpKRxyXiEw==
X-Received: by 2002:a17:902:a517:b0:161:e5f2:9a26 with SMTP id s23-20020a170902a51700b00161e5f29a26mr29782033plq.132.1653491496177;
        Wed, 25 May 2022 08:11:36 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902eb9000b00161b50c3db4sm9383129plg.94.2022.05.25.08.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:11:35 -0700 (PDT)
From:   Sunil V L <sunilvl@ventanamicro.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Atish Patra <atishp@rivosinc.com>,
        Heinrich Schuchardt <heinrich.schuchardt@canonical.com>,
        Anup Patel <apatel@ventanamicro.com>
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-efi@vger.kernel.org, Sunil V L <sunil.vl@gmail.com>,
        Sunil V L <sunilvl@ventanamicro.com>
Subject: [PATCH 4/5] riscv: cpu: Support for 64bit hartid
Date:   Wed, 25 May 2022 20:41:05 +0530
Message-Id: <20220525151106.2176147-5-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds support for 64bit hartid in riscv_of_processor_hartid()
  - Separate return value and status code.
  - Make hartid variable type as unsigned long.
  - Update the callers.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
---
 arch/riscv/include/asm/processor.h |  4 ++--
 arch/riscv/kernel/cpu.c            | 26 +++++++++++++++-----------
 arch/riscv/kernel/cpufeature.c     |  6 ++++--
 arch/riscv/kernel/smpboot.c        |  9 +++++----
 drivers/clocksource/timer-riscv.c  | 15 ++++++++-------
 drivers/irqchip/irq-riscv-intc.c   |  7 ++++---
 drivers/irqchip/irq-sifive-plic.c  |  7 ++++---
 7 files changed, 42 insertions(+), 32 deletions(-)

diff --git a/arch/riscv/include/asm/processor.h b/arch/riscv/include/asm/processor.h
index 0749924d9e55..99fae9398506 100644
--- a/arch/riscv/include/asm/processor.h
+++ b/arch/riscv/include/asm/processor.h
@@ -75,8 +75,8 @@ static inline void wait_for_interrupt(void)
 }
 
 struct device_node;
-int riscv_of_processor_hartid(struct device_node *node);
-int riscv_of_parent_hartid(struct device_node *node);
+int riscv_of_processor_hartid(struct device_node *node, unsigned long *hartid);
+int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid);
 
 extern void riscv_fill_hwcap(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
diff --git a/arch/riscv/kernel/cpu.c b/arch/riscv/kernel/cpu.c
index ccb617791e56..c49ed1eac011 100644
--- a/arch/riscv/kernel/cpu.c
+++ b/arch/riscv/kernel/cpu.c
@@ -14,37 +14,36 @@
  * Returns the hart ID of the given device tree node, or -ENODEV if the node
  * isn't an enabled and valid RISC-V hart node.
  */
-int riscv_of_processor_hartid(struct device_node *node)
+int riscv_of_processor_hartid(struct device_node *node, unsigned long *hart)
 {
 	const char *isa;
-	u32 hart;
 
 	if (!of_device_is_compatible(node, "riscv")) {
 		pr_warn("Found incompatible CPU\n");
 		return -ENODEV;
 	}
 
-	hart = of_get_cpu_hwid(node, 0);
-	if (hart == ~0U) {
+	*hart = (unsigned long) of_get_cpu_hwid(node, 0);
+	if (*hart == ~0U) {
 		pr_warn("Found CPU without hart ID\n");
 		return -ENODEV;
 	}
 
 	if (!of_device_is_available(node)) {
-		pr_info("CPU with hartid=%d is not available\n", hart);
+		pr_info("CPU with hartid=%lu is not available\n", *hart);
 		return -ENODEV;
 	}
 
 	if (of_property_read_string(node, "riscv,isa", &isa)) {
-		pr_warn("CPU with hartid=%d has no \"riscv,isa\" property\n", hart);
+		pr_warn("CPU with hartid=%lu has no \"riscv,isa\" property\n", *hart);
 		return -ENODEV;
 	}
 	if (isa[0] != 'r' || isa[1] != 'v') {
-		pr_warn("CPU with hartid=%d has an invalid ISA of \"%s\"\n", hart, isa);
+		pr_warn("CPU with hartid=%lu has an invalid ISA of \"%s\"\n", *hart, isa);
 		return -ENODEV;
 	}
 
-	return hart;
+	return 0;
 }
 
 /*
@@ -53,11 +52,16 @@ int riscv_of_processor_hartid(struct device_node *node)
  * To achieve this, we walk up the DT tree until we find an active
  * RISC-V core (HART) node and extract the cpuid from it.
  */
-int riscv_of_parent_hartid(struct device_node *node)
+int riscv_of_parent_hartid(struct device_node *node, unsigned long *hartid)
 {
+	int rc;
+
 	for (; node; node = node->parent) {
-		if (of_device_is_compatible(node, "riscv"))
-			return riscv_of_processor_hartid(node);
+		if (of_device_is_compatible(node, "riscv")) {
+			rc = riscv_of_processor_hartid(node, hartid);
+			if (!rc)
+				return 0;
+		}
 	}
 
 	return -1;
diff --git a/arch/riscv/kernel/cpufeature.c b/arch/riscv/kernel/cpufeature.c
index 1b2d42d7f589..49c05bd9352d 100644
--- a/arch/riscv/kernel/cpufeature.c
+++ b/arch/riscv/kernel/cpufeature.c
@@ -67,8 +67,9 @@ void __init riscv_fill_hwcap(void)
 	struct device_node *node;
 	const char *isa;
 	char print_str[NUM_ALPHA_EXTS + 1];
-	int i, j;
+	int i, j, rc;
 	static unsigned long isa2hwcap[256] = {0};
+	unsigned long hartid;
 
 	isa2hwcap['i'] = isa2hwcap['I'] = COMPAT_HWCAP_ISA_I;
 	isa2hwcap['m'] = isa2hwcap['M'] = COMPAT_HWCAP_ISA_M;
@@ -86,7 +87,8 @@ void __init riscv_fill_hwcap(void)
 		DECLARE_BITMAP(this_isa, RISCV_ISA_EXT_MAX);
 		const char *temp;
 
-		if (riscv_of_processor_hartid(node) < 0)
+		rc = riscv_of_processor_hartid(node, &hartid);
+		if (rc < 0)
 			continue;
 
 		if (of_property_read_string(node, "riscv,isa", &isa)) {
diff --git a/arch/riscv/kernel/smpboot.c b/arch/riscv/kernel/smpboot.c
index 622f226454d5..4336610a19ee 100644
--- a/arch/riscv/kernel/smpboot.c
+++ b/arch/riscv/kernel/smpboot.c
@@ -76,15 +76,16 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
 void __init setup_smp(void)
 {
 	struct device_node *dn;
-	int hart;
+	unsigned long hart;
 	bool found_boot_cpu = false;
 	int cpuid = 1;
+	int rc;
 
 	cpu_set_ops(0);
 
 	for_each_of_cpu_node(dn) {
-		hart = riscv_of_processor_hartid(dn);
-		if (hart < 0)
+		rc = riscv_of_processor_hartid(dn, &hart);
+		if (rc < 0)
 			continue;
 
 		if (hart == cpuid_to_hartid_map(0)) {
@@ -94,7 +95,7 @@ void __init setup_smp(void)
 			continue;
 		}
 		if (cpuid >= NR_CPUS) {
-			pr_warn("Invalid cpuid [%d] for hartid [%d]\n",
+			pr_warn("Invalid cpuid [%d] for hartid [%lu]\n",
 				cpuid, hart);
 			continue;
 		}
diff --git a/drivers/clocksource/timer-riscv.c b/drivers/clocksource/timer-riscv.c
index 1767f8bf2013..55142c27f0bc 100644
--- a/drivers/clocksource/timer-riscv.c
+++ b/drivers/clocksource/timer-riscv.c
@@ -101,20 +101,21 @@ static irqreturn_t riscv_timer_interrupt(int irq, void *dev_id)
 
 static int __init riscv_timer_init_dt(struct device_node *n)
 {
-	int cpuid, hartid, error;
+	int cpuid, error;
+	unsigned long hartid;
 	struct device_node *child;
 	struct irq_domain *domain;
 
-	hartid = riscv_of_processor_hartid(n);
-	if (hartid < 0) {
-		pr_warn("Not valid hartid for node [%pOF] error = [%d]\n",
+	error = riscv_of_processor_hartid(n, &hartid);
+	if (error < 0) {
+		pr_warn("Not valid hartid for node [%pOF] error = [%lu]\n",
 			n, hartid);
-		return hartid;
+		return error;
 	}
 
 	cpuid = riscv_hartid_to_cpuid(hartid);
 	if (cpuid < 0) {
-		pr_warn("Invalid cpuid for hartid [%d]\n", hartid);
+		pr_warn("Invalid cpuid for hartid [%lu]\n", hartid);
 		return cpuid;
 	}
 
@@ -140,7 +141,7 @@ static int __init riscv_timer_init_dt(struct device_node *n)
 		return -ENODEV;
 	}
 
-	pr_info("%s: Registering clocksource cpuid [%d] hartid [%d]\n",
+	pr_info("%s: Registering clocksource cpuid [%d] hartid [%lu]\n",
 	       __func__, cpuid, hartid);
 	error = clocksource_register_hz(&riscv_clocksource, riscv_timebase);
 	if (error) {
diff --git a/drivers/irqchip/irq-riscv-intc.c b/drivers/irqchip/irq-riscv-intc.c
index b65bd8878d4f..499e5f81b3fe 100644
--- a/drivers/irqchip/irq-riscv-intc.c
+++ b/drivers/irqchip/irq-riscv-intc.c
@@ -95,10 +95,11 @@ static const struct irq_domain_ops riscv_intc_domain_ops = {
 static int __init riscv_intc_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	int rc, hartid;
+	int rc;
+	unsigned long hartid;
 
-	hartid = riscv_of_parent_hartid(node);
-	if (hartid < 0) {
+	rc = riscv_of_parent_hartid(node, &hartid);
+	if (rc < 0) {
 		pr_warn("unable to find hart id for %pOF\n", node);
 		return 0;
 	}
diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index bb87e4c3b88e..4710d9741f36 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -317,7 +317,8 @@ static int __init plic_init(struct device_node *node,
 	for (i = 0; i < nr_contexts; i++) {
 		struct of_phandle_args parent;
 		irq_hw_number_t hwirq;
-		int cpu, hartid;
+		int cpu;
+		unsigned long hartid;
 
 		if (of_irq_parse_one(node, i, &parent)) {
 			pr_err("failed to parse parent for context %d.\n", i);
@@ -341,8 +342,8 @@ static int __init plic_init(struct device_node *node,
 			continue;
 		}
 
-		hartid = riscv_of_parent_hartid(parent.np);
-		if (hartid < 0) {
+		error = riscv_of_parent_hartid(parent.np, &hartid);
+		if (error < 0) {
 			pr_warn("failed to parse hart ID for context %d.\n", i);
 			continue;
 		}
-- 
2.25.1

