Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C29FE4E65DE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 16:14:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351260AbiCXPQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 11:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351270AbiCXPQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 11:16:00 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4A96EB38
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:14:26 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id o8so4068066pgf.9
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 08:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9SKjNRSyRMak/9hQdUHsRIqkH3nlR2Enu7iMUizer5s=;
        b=dsr6KqFDgqnAHN3Ap+TYILuMtCUtQ7kq0/i78ZiT3ac6bq/bJWAIu19jN5MQ1BC/4+
         /BeFrR8vwC7hkKlaxrCz4KP/W0q0fCCu83YuNMnFRwuXJGU1ud8IqecoIt1b1Tw+lEKs
         tTUTUcfysQxW0WvSsV9XKT1ctLFYzvcU5HdkzAox98KhPqGguqV+txAZ7Jw7SjLu8rFK
         y2rQFDOdpRg+MMBs/NtbJEBluGPGRNkgh1tXc8RhYsKfm0tZPcOtkxXfWQ2ZkTMSJhQx
         uiGy/5iilOpaOmOesHZQDOQL1ZKkL8eX8bpkWnyx98V1AWwbLXpdk09nLoiw49NrYb2q
         TsHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9SKjNRSyRMak/9hQdUHsRIqkH3nlR2Enu7iMUizer5s=;
        b=7LpECJEIaenUiKEbq/00ve98d7OC0LQVmFZSAWTDEuofg6FDOTLENQ0z60pzAQ7acn
         lo7fCfMxfcVCqPjJhKPQ4cn7o5FKZ2JrhK7QXksQNp0hEqbNfvtF1BFkXAbKP5aCr1dw
         v+3zakzZ/N8ApjqpXoRMayfEl6gtbp/l3iFn5hYvGK17YRafSjwZA+QlH2V1/bGjbwXq
         J1iBRw4DuCH5j/RsnYHDnej9mzWl5FS+guiiRfa0bKyoNfu7Ae34ox4qqbROrOsxHK9H
         vXM0AxPvxhZMnqwQRkKoWLnubdQXWKp+xfPJjUOVVVyosLzvo/lchSQ64pSYQ6Wwv2Q8
         KYSg==
X-Gm-Message-State: AOAM533y2ib812wzU2ZjHrYDbjn2Nd7zndk1PRX1OsyQskWBFJZ4MAOJ
        0UKYLjy9/Jjr+t/odSdIXwKqVg==
X-Google-Smtp-Source: ABdhPJzL9WObJDLa5UCnwS2CvgzD2rze8ebiGh+metpc7yCWNxd0/qsIuhomBAQSBAXVl+RawUxvgA==
X-Received: by 2002:a65:524b:0:b0:383:1b87:2d21 with SMTP id q11-20020a65524b000000b003831b872d21mr4392269pgp.482.1648134865983;
        Thu, 24 Mar 2022 08:14:25 -0700 (PDT)
Received: from localhost.localdomain ([122.171.187.87])
        by smtp.gmail.com with ESMTPSA id f16-20020a056a00239000b004fa7103e13csm4166065pfc.41.2022.03.24.08.14.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 08:14:25 -0700 (PDT)
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
Subject: [PATCH v5 5/7] RISC-V: Allow marking IPIs as suitable for remote FENCEs
Date:   Thu, 24 Mar 2022 20:42:56 +0530
Message-Id: <20220324151258.943896-6-apatel@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220324151258.943896-1-apatel@ventanamicro.com>
References: <20220324151258.943896-1-apatel@ventanamicro.com>
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

