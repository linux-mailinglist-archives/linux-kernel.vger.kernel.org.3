Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C3257B991
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241365AbiGTPY4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:24:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241387AbiGTPYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:24:44 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52F7A5F9B1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:24:43 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so2587866pjl.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+gCL8vpkJbMH1zCQTfU568m0Qd8HeqUY1yacjYAcBHY=;
        b=X8TiORhLv6PwQsozH3XMukbzGmm2vwQrlM4EifR2sfp15mScEYgjqTQRppLOH3ZsC6
         QAxDDw/OKkUpPzWjpGDtzVT4tHM8L2Jc0Y4+Uceu0KCcbRQ+1jAyZRJLf12YeGVIeU8i
         G6cl8Dny6jK2xFnoyghm967Mr92Pde2Yad3cN9JIz2ll95lP/PjLMq/6RlCHTA4eSGcH
         jFOqIVhkxwhU0i62Qu6EIAqnJswj7SVbTM+JzcEzi0ZtUEOChWksZ+xe2qDH1fhwKQms
         6/nmSI+6lCxwBnUCIDov36aMiGHpbYro6oJ3EmkI1tSXgOkRhqsHNs/IdhnzeVSRfit+
         iHNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+gCL8vpkJbMH1zCQTfU568m0Qd8HeqUY1yacjYAcBHY=;
        b=HHwfOtJ6AwU4Fhdp+0haavk103K+1lWM+TOYRUXqZx3A43vt3k9KoFwrCvjXKlTaIN
         Iaibt9iPflgJhJ9qxxgOClG557qXKpYba/3vv2WZHdlPi9b5FEfjeQMcI0gxLEXL+Eq8
         ZyF+TPHO3lYP4CloxRyMCJGxQHR++scCjG3QmgFjkrRTSOaqHtKeN5ZO8At38dAlOv4B
         9N6qyb12FjOy6pXM/pk/AHgmXKYCiNi1dMWpf8M4HOYwgh0CMicsKvnvDv1tOJUZK/hj
         /qxzOHgtw1jFjr13C6qWaPZxvq0GfiZf6bVQKOwMBVeqjtrYM9bb4KXTMx8/Yi92qU5m
         3gkw==
X-Gm-Message-State: AJIora+Km76mODHY6hmZrsxz411GaVc2h1zfBn8bFNWVTAthqi5AjsR+
        76JWzCflYZ6v7YZ7TNBoVLc87A==
X-Google-Smtp-Source: AGRyM1vNCIefghATWrh2c+eN2722FUXmTj/HYQM7BJj7GSnaWk7QvPgGc48SocyX0/qvS60iheL9Eg==
X-Received: by 2002:a17:902:b28a:b0:16d:1c68:2e2 with SMTP id u10-20020a170902b28a00b0016d1c6802e2mr5029303plr.26.1658330682703;
        Wed, 20 Jul 2022 08:24:42 -0700 (PDT)
Received: from anup-ubuntu64-vm.. ([122.179.42.230])
        by smtp.gmail.com with ESMTPSA id w15-20020a1709026f0f00b0016cf8f0bdd5sm6013031plk.108.2022.07.20.08.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:24:42 -0700 (PDT)
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
Subject: [PATCH v7 5/7] RISC-V: Allow marking IPIs as suitable for remote FENCEs
Date:   Wed, 20 Jul 2022 20:53:46 +0530
Message-Id: <20220720152348.2889109-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220720152348.2889109-1-apatel@ventanamicro.com>
References: <20220720152348.2889109-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To do remote FENCEs (i.e. remote TLB flushes) using IPI calls on the
RISC-V kernel, we need hardware mechanism to directly inject IPI from
the supervisor mode (i.e. RISC-V kernel) instead of using SBI calls.

The upcoming AIA IMSIC devices allow direct IPI injection from the
supervisor mode (i.e. RISC-V kernel). To support this, we extend the
riscv_ipi_set_virq_range() function so that IPI provider (i.e. irqchip
drivers can mark IPIs as suitable for remote FENCEs.

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
---
 arch/riscv/include/asm/smp.h      | 19 +++++++++++++++++--
 arch/riscv/kernel/sbi-ipi.c       |  2 +-
 arch/riscv/kernel/smp.c           | 12 +++++++++++-
 drivers/clocksource/timer-clint.c |  2 +-
 4 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 7da034e2f231..f69fb9ac1756 100644
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
@@ -46,7 +49,13 @@ void riscv_ipi_disable(void);
 bool riscv_ipi_have_virq_range(void);
 
 /* Set the IPI interrupt numbers for arch (called by irqchip drivers) */
-void riscv_ipi_set_virq_range(int virq, int nr_irqs, bool percpu_enable);
+void riscv_ipi_set_virq_range(int virq, int nr_irqs, bool percpu_enable,
+			      bool use_for_rfence);
+
+/* Check if we can use IPIs for remote FENCEs */
+DECLARE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+#define riscv_use_ipi_for_rfence() \
+	static_branch_unlikely(&riscv_ipi_for_rfence)
 
 /* Secondary hart entry */
 asmlinkage void smp_callin(void);
@@ -94,10 +103,16 @@ static inline bool riscv_ipi_have_virq_range(void)
 }
 
 static inline void riscv_ipi_set_virq_range(int virq, int nr,
-					    bool percpu_enable)
+					    bool percpu_enable,
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
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
index 5be545f6914c..e45a7d9a16c2 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -55,6 +55,6 @@ void __init sbi_ipi_init(void)
 		return;
 	}
 
-	riscv_ipi_set_virq_range(virq, BITS_PER_LONG, false);
+	riscv_ipi_set_virq_range(virq, BITS_PER_LONG, false, false);
 	pr_info("providing IPIs using SBI IPI extension\n");
 }
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index 07f1ff652362..80ab8359ad48 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -150,7 +150,11 @@ bool riscv_ipi_have_virq_range(void)
 	return (ipi_virq_base) ? true : false;
 }
 
-void riscv_ipi_set_virq_range(int virq, int nr, bool percpu_enable)
+DEFINE_STATIC_KEY_FALSE(riscv_ipi_for_rfence);
+EXPORT_SYMBOL_GPL(riscv_ipi_for_rfence);
+
+void riscv_ipi_set_virq_range(int virq, int nr, bool percpu_enable,
+			      bool use_for_rfence)
 {
 	int i, err;
 
@@ -174,6 +178,12 @@ void riscv_ipi_set_virq_range(int virq, int nr, bool percpu_enable)
 
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
index 69f8d2ac1916..3a90b6b3ca48 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -245,7 +245,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_remove_cpuhp;
 	}
 
-	riscv_ipi_set_virq_range(virq, BITS_PER_LONG, false);
+	riscv_ipi_set_virq_range(virq, BITS_PER_LONG, false, true);
 	clint_clear_ipi(clint_ipi_irq);
 
 	return 0;
-- 
2.34.1

