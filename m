Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991E54BCC38
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Feb 2022 06:10:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiBTFKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 00:10:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbiBTFKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 00:10:34 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6783B51E46
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:10:13 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id gf13-20020a17090ac7cd00b001bbfb9d760eso2286060pjb.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 21:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kq1GecPvvHHYiTo+a1VD34ISckL9lL5R+wkUykUsBYs=;
        b=ILLVLdm5mDr5L3R2lCPOyklnyboP1+NYbCs97ijrIlRwfb9xtODA915qMQpH5sVhld
         2ja4WxPCNsPdiZkDdcQhYpLOujMv+y62OhvlW/CnxNjkylf5Ec/ssEmvGntYOeqaSspc
         QpJPfkyJsthuCklgUCzXvBIR4BGHogNM7Tt7ibMCQ+SpshV3VuK/RCwo3thQtjZtoKf4
         kP8dOYl9laA+Y4d8E5FMe0yy2BYOjs3DqCRxo8HZ1r12ogMRAG919HHLVDORLDYVndxL
         mSQNUnQ+Zpl5GiG42OCmj5+DgdwD3cAmVz9J0a0hRIoA5AnKX8EQ+UbmCwpvgBliXzkx
         +dWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kq1GecPvvHHYiTo+a1VD34ISckL9lL5R+wkUykUsBYs=;
        b=huXbJwdXoCESRS7kOsfAQvrjjFLK+ORVUWcxqddHzYikJI2/ayJWq5G0FotmeqsTbM
         XPOiJ0cqx+jWee6BRfP4dW22SRI890dXY3RPPsYc49jfibm8n/mRCOGXr1ncO8yT4+fA
         X9Gf0Ewg3pZTxT73LuZybB1Tpvbz3Rka4syGNQK1mSNH4UVi//wSmIj+HGsliyrpYGJS
         HT/bz2Y0NlbVd0eOolc7mEqAID3N713v9k0JfQyOTB2vxrce4XYrdv0zpMg1nk3A9syo
         L3Z05jB3PGky7GmWdYY9HwNgLvIJjIIhTdsJ0bU7f7g5eci//5gqBdT+ecx2UK1AMLlR
         ZXZA==
X-Gm-Message-State: AOAM533LoDGpNhljyLB278a7O9w43HX8ZfQ/wDGjoq5gyYtQXtsJFE4b
        j4nrW6Trj1v1P5FwxUKvrp3Npw==
X-Google-Smtp-Source: ABdhPJyZEgyeiIBog+nZvfXsy+MKFhYfDCXuTo/yIMPtvH3hboXy2T7+AYuPdek62bU4y8SzV2VAoA==
X-Received: by 2002:a17:902:834a:b0:14f:3337:35de with SMTP id z10-20020a170902834a00b0014f333735demr14471866pln.8.1645333812882;
        Sat, 19 Feb 2022 21:10:12 -0800 (PST)
Received: from localhost.localdomain ([122.162.118.38])
        by smtp.gmail.com with ESMTPSA id 84sm7602730pfx.181.2022.02.19.21.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 21:10:12 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH v3 4/6] RISC-V: Allow marking IPIs as suitable for remote FENCEs
Date:   Sun, 20 Feb 2022 10:38:52 +0530
Message-Id: <20220220050854.743420-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220220050854.743420-1-apatel@ventanamicro.com>
References: <20220220050854.743420-1-apatel@ventanamicro.com>
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

To do remote FENCEs (i.e. remote TLB flushes) using IPI calls on
the RISC-V kernel, we need hardware mechanism to directly inject
IPI from the RISC-V kernel instead of using SBI calls.

The upcoming ACLINT [M|S]SWI devices and AIA IMSIC devices allow
direct IPI injection from the RISC-V kernel. To support this, we
extend the riscv_ipi_set_virq_range() function so that irqchip
drivers can mark IPIs as suitable for remote FENCEs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/ipi-mux.h  |  2 ++
 arch/riscv/include/asm/smp.h      | 18 ++++++++++++++++--
 arch/riscv/kernel/ipi-mux.c       |  3 ++-
 arch/riscv/kernel/sbi.c           |  3 ++-
 arch/riscv/kernel/smp.c           | 11 ++++++++++-
 drivers/clocksource/timer-clint.c |  2 +-
 6 files changed, 33 insertions(+), 6 deletions(-)

diff --git a/arch/riscv/include/asm/ipi-mux.h b/arch/riscv/include/asm/ipi-mux.h
index 988e2bba372a..3a5acbf51806 100644
--- a/arch/riscv/include/asm/ipi-mux.h
+++ b/arch/riscv/include/asm/ipi-mux.h
@@ -15,6 +15,7 @@ void riscv_ipi_mux_handle_irq(void);
 
 /* Create irq_domain for muxed IPIs */
 struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
+			bool use_for_rfence,
 			void (*clear_ipi)(void),
 			void (*send_ipi)(const struct cpumask *mask));
 
@@ -28,6 +29,7 @@ static inline void riscv_ipi_mux_handle_irq(void)
 }
 
 static inline struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
+			bool use_for_rfence,
 			void (*clear_ipi)(void),
 			void (*send_ipi)(const struct cpumask *mask))
 {
diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 178fe4ada592..ddd3be1c77b6 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -16,6 +16,9 @@ struct seq_file;
 extern unsigned long boot_cpu_hartid;
 
 #ifdef CONFIG_SMP
+
+#include <linux/jump_label.h>
+
 /*
  * Mapping between linux logical cpu index and hartid.
  */
@@ -46,7 +49,12 @@ void riscv_ipi_disable(void);
 bool riscv_ipi_have_virq_range(void);
 
 /* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
-void riscv_ipi_set_virq_range(int virq, int nr_irqs);
+void riscv_ipi_set_virq_range(int virq, int nr_irqs, bool use_for_rfence);
+
+/* Check if we can use IPIs for remote FENCEs */
+DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+#define riscv_use_ipi_for_rfence() \
+	static_branch_unlikely(&riscv_ipi_for_rfence)
 
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
@@ -93,10 +101,16 @@ static inline bool riscv_ipi_have_virq_range(void)
 	return false;
 }
 
-static inline void riscv_ipi_set_virq_range(int virq, int nr)
+static inline void riscv_ipi_set_virq_range(int virq, int nr,
+					    bool use_for_rfence)
 {
 }
 
+static inline bool riscv_use_ipi_for_rfence(void)
+{
+	return false;
+}
+
 #endif /* CONFIG_SMP */
 
 #if defined(CONFIG_HOTPLUG_CPU) && (CONFIG_SMP)
diff --git a/arch/riscv/kernel/ipi-mux.c b/arch/riscv/kernel/ipi-mux.c
index 3a0405f0e0de..544074ea3ead 100644
--- a/arch/riscv/kernel/ipi-mux.c
+++ b/arch/riscv/kernel/ipi-mux.c
@@ -144,6 +144,7 @@ static int ipi_mux_starting_cpu(unsigned int cpu)
 }
 
 struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
+			bool use_for_rfence,
 			void (*clear_ipi)(void),
 			void (*send_ipi)(const struct cpumask *mask))
 {
@@ -198,7 +199,7 @@ struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
 			  "irqchip/riscv/ipi-mux:starting",
 			  ipi_mux_starting_cpu, ipi_mux_dying_cpu);
 
-	riscv_ipi_set_virq_range(virq, BITS_PER_LONG);
+	riscv_ipi_set_virq_range(virq, BITS_PER_LONG, use_for_rfence);
 
 	return ipi_mux_priv.domain;
 
diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
index fa3d92fce9f8..210d23524771 100644
--- a/arch/riscv/kernel/sbi.c
+++ b/arch/riscv/kernel/sbi.c
@@ -630,7 +630,8 @@ static void sbi_ipi_clear(void)
 
 void __init sbi_ipi_init(void)
 {
-	if (riscv_ipi_mux_create(true, sbi_ipi_clear, sbi_send_cpumask_ipi))
+	if (riscv_ipi_mux_create(true, false,
+				 sbi_ipi_clear, sbi_send_cpumask_ipi))
 		pr_info("providing IPIs using SBI IPI extension\n");
 }
 
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index a9f1aca38358..b98d9c319f6f 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -149,7 +149,10 @@ bool riscv_ipi_have_virq_range(void)
 	return (ipi_virq_base) ? true : false;
 }
 
-void riscv_ipi_set_virq_range(int virq, int nr)
+DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
+
+void riscv_ipi_set_virq_range(int virq, int nr, bool use_for_rfence)
 {
 	int i, err;
 
@@ -172,6 +175,12 @@ void riscv_ipi_set_virq_range(int virq, int nr)
 
 	/* Enabled IPIs for boot CPU immediately */
 	riscv_ipi_enable();
+
+	/* Update RFENCE static key */
+	if (use_for_rfence)
+		static_branch_enable(&riscv_ipi_for_rfence);
+	else
+		static_branch_disable(&riscv_ipi_for_rfence);
 }
 EXPORT_SYMBOL_GPL(riscv_ipi_set_virq_range);
 
diff --git a/drivers/clocksource/timer-clint.c b/drivers/clocksource/timer-clint.c
index b05a9e946633..607d47dab896 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -224,7 +224,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_free_irq;
 	}
 
-	riscv_ipi_mux_create(true, clint_clear_ipi, clint_send_ipi);
+	riscv_ipi_mux_create(true, true, clint_clear_ipi, clint_send_ipi);
 	clint_clear_ipi();
 
 	return 0;
-- 
2.25.1

