Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1A0F504F19
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 12:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236079AbiDRK5A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 06:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236562AbiDRK4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 06:56:45 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19AC619C22
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:54:07 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id i24-20020a17090adc1800b001cd5529465aso12250327pjv.0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 03:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SKjNRSyRMak/9hQdUHsRIqkH3nlR2Enu7iMUizer5s=;
        b=jbSDUWADN1sgR8LEVmbW/w48kLzUGe7kDFaqwX8vtQxxhlfaFsqJ7ZitgG07vEzwJl
         KZMg38cwGmT5dOoL4kW0VZXpBoKIqbg9A269EZ5R8tvOLyDx5dIQluofOsLs5jaZyf0V
         XV0MczsP1RSn3Xj5snyjiPyCAmp3hjG83LV895wnYJm3qOJNvbArPmfRMDJNnXqbSjvB
         IoAeKj5PjSx8p7MjHIahlGAiGRAIqnIVXg0Dd/Lj3IWZneZjJAdYsEiGVw0obDSDMiD8
         cwRF8DaM9clWjHcEHhRgbM9j1WmCPzoCtVmRPBvNaHkYCMy1ste8ZKmRks9hKGYe6DUR
         8alA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SKjNRSyRMak/9hQdUHsRIqkH3nlR2Enu7iMUizer5s=;
        b=JiYLUmgGg4ECsfT+anpwNE6IzOaBKsSBFbKOehzaJVWq9kyri5UFKTUIkcne0fAfUX
         I2q9ygdUKZIEHtou7SEfK8KmrS8y7gviQi2cV+2g+K/pBrye9DCAE31i96ZIrPUZc0tY
         n5RwU0j7W280wuWkf8Rw8urCg3oqprvoWRtDZnqHajdNKdvjKDDXKlW86/989LM0uTWb
         vP+cPK4xcEnxeXwjmE7X5L1UXY2C5awIxhhGmcoUYEQeXsw8PuqBmewsOpVVtQxDUw9d
         3kGnkNZgWHM8OGViZcwpoFEuId4STHSqcZR7qga3NGB4D154oEYHrkTHwOnZk7SQEb3n
         N1HA==
X-Gm-Message-State: AOAM532ng+fizcqcwdW7vQNfmqfrGGlY3QAXvoTbVB7LG6nZLheueprI
        kXRJhpZop5j7pQCSiVts+oT06A==
X-Google-Smtp-Source: ABdhPJyrJqEwjzsKZurDySfOcGZkxUYGAdWOMe01BOorRgS1V8ONDJ/MM4Wp48bZ0o9WV5aXnaIPOw==
X-Received: by 2002:a17:902:ab8b:b0:156:16c0:dc6d with SMTP id f11-20020a170902ab8b00b0015616c0dc6dmr10184498plr.147.1650279246557;
        Mon, 18 Apr 2022 03:54:06 -0700 (PDT)
Received: from localhost.localdomain ([122.172.241.223])
        by smtp.gmail.com with ESMTPSA id j13-20020a056a00130d00b004f1025a4361sm12986278pfu.202.2022.04.18.03.54.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 03:54:06 -0700 (PDT)
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
Subject: [PATCH v6 5/7] RISC-V: Allow marking IPIs as suitable for remote FENCEs
Date:   Mon, 18 Apr 2022 16:23:03 +0530
Message-Id: <20220418105305.1196665-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220418105305.1196665-1-apatel@ventanamicro.com>
References: <20220418105305.1196665-1-apatel@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
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
 arch/riscv/include/asm/smp.h      | 18 ++++++++++++++++--
 arch/riscv/kernel/sbi-ipi.c       |  2 +-
 arch/riscv/kernel/smp.c           | 11 ++++++++++-
 drivers/clocksource/timer-clint.c |  2 +-
 4 files changed, 28 insertions(+), 5 deletions(-)

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
diff --git a/arch/riscv/kernel/sbi-ipi.c b/arch/riscv/kernel/sbi-ipi.c
index 67f213ec2b04..ce26d62146de 100644
--- a/arch/riscv/kernel/sbi-ipi.c
+++ b/arch/riscv/kernel/sbi-ipi.c
@@ -55,6 +55,6 @@ void __init sbi_ipi_init(void)
 		return;
 	}
 
-	riscv_ipi_set_virq_range(virq, IPI_MUX_NR_IRQS);
+	riscv_ipi_set_virq_range(virq, IPI_MUX_NR_IRQS, false);
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
index 1861db1bfcbf..eb80bf79dc93 100644
--- a/drivers/clocksource/timer-clint.c
+++ b/drivers/clocksource/timer-clint.c
@@ -245,7 +245,7 @@ static int __init clint_timer_init_dt(struct device_node *np)
 		goto fail_remove_cpuhp;
 	}
 
-	riscv_ipi_set_virq_range(virq, IPI_MUX_NR_IRQS);
+	riscv_ipi_set_virq_range(virq, IPI_MUX_NR_IRQS, true);
 	clint_clear_ipi(clint_ipi_irq);
 
 	return 0;
-- 
2.25.1

