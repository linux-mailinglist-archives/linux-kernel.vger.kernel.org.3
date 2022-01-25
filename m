Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E23A149AD1F
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 08:09:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442415AbiAYHIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 02:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378132AbiAYHEg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 02:04:36 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A01C04188A
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:44:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id z10-20020a17090acb0a00b001b520826011so1147336pjt.5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jan 2022 21:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x9vjMe+XXvltbCaafWpvqji8oCKXy5m+Di+E6HTISoI=;
        b=P6dPykyyfYeOrtId8fPa6HTSfidtoNke8FQXyDkPtmuEscubilP6q56UkbokB7s3+z
         75ZzzykG4a6kmQDV1lGsxbWbLH/BDGt2wdTDogY4SsNfjNixH24SzwaxaeY/qhnr5FwF
         m/V+l2jy2uusFHr+unAd2dGjbFHEPcGNqBoc3Q/5mEBvHOUG0HWG7BsvoufhTY+rpTl2
         S51vL/79raTygq1FV5oUhdm3ZHHrOj3CQJ2o28lSQvWxuShYTsEGnPiTW+ct5sQ93oQ/
         qLVMTJUN1K4RpBMDZyS66CJvo71otbj6r6e8ryh7hKEV926nPUE2aT8wjakhF+r+7M5f
         8XYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x9vjMe+XXvltbCaafWpvqji8oCKXy5m+Di+E6HTISoI=;
        b=n6OwTt+Eg7t/w1oUNSpSA/MWNwswflYY1Pq15syVAL+tlvn2RqWIPuqefQ4UHYtugv
         lGSpIL6aLsRqkcnJL8IKgNV4t3H9Ndmun9dPJjKPTuPqzvaSSDYrBiJo+Oejkp/+lWik
         p7KJDLLf/lajHxOu0GDQyTyK+zAXH4iECkTS4z4BYgh7gyZHGaHJWwARZ4wExKg9WbUh
         mXT0SsTpXigDXg+5ESNjfrVtXVh4vpp7o3oaQADXDKqjNY6cpAN0M9lIVQP8JMw8NDBV
         C6FucJCTD1kUBecbMFmefByjFnRsWt+mo+nzkF62fqZQnnBzvcCPKVZLMFHmqurSTFdh
         +IcA==
X-Gm-Message-State: AOAM531oDEGuiJs9j3GXwVAFIBNLsV3EL9z7XVeqhET+2YnSNDGKQbMy
        0+0i0d4GhJYz8DJ+TscpIVGbQg==
X-Google-Smtp-Source: ABdhPJyTIzq8jxLbrRGN86xChviDm/SR56guVk2P+a/+NALhEYa4eb7WcMRL1jH6u7eojBnC5HWagQ==
X-Received: by 2002:a17:902:704c:b0:14a:fd51:3b5d with SMTP id h12-20020a170902704c00b0014afd513b5dmr16847412plt.172.1643089450831;
        Mon, 24 Jan 2022 21:44:10 -0800 (PST)
Received: from localhost.localdomain ([122.179.14.218])
        by smtp.gmail.com with ESMTPSA id c6sm19524508pfl.200.2022.01.24.21.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jan 2022 21:44:10 -0800 (PST)
From:   Anup Patel <apatel@ventanamicro.com>
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Atish Patra <atishp@atishpatra.org>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        Anup Patel <anup@brainfault.org>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        Anup Patel <apatel@ventanamicro.com>
Subject: [PATCH 4/6] RISC-V: Allow marking IPIs as suitable for remote FENCEs
Date:   Tue, 25 Jan 2022 11:12:15 +0530
Message-Id: <20220125054217.383482-5-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220125054217.383482-1-apatel@ventanamicro.com>
References: <20220125054217.383482-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
index e24bdeded489..bc9b0eb318be 100644
--- a/arch/riscv/kernel/ipi-mux.c
+++ b/arch/riscv/kernel/ipi-mux.c
@@ -145,6 +145,7 @@ static int ipi_mux_starting_cpu(unsigned int cpu)
 }
 
 struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
+			bool use_for_rfence,
 			void (*clear_ipi)(void),
 			void (*send_ipi)(const struct cpumask *mask))
 {
@@ -192,7 +193,7 @@ struct irq_domain *riscv_ipi_mux_create(bool use_soft_irq,
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

