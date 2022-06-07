Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E54E8534D09
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 12:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346982AbiEZKMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 06:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346988AbiEZKL4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 06:11:56 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD1051113
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:11:51 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id n8so1079787plh.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 03:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3wURJ7f8wK/rYX1AWremJ6WWxVIvdF4W4fcHK+urU4Y=;
        b=lGJPvC3W+KdDytFN09EumhPJrVSmrwGdIlDlX0GeN/DoMzCv8kpUJVZJ3ZwxjFOOW3
         bc3zhkW3fIOhwGJRYktfEaa6VNws2H+5LeTtokOCeN7bGS0nVMAdKnCv/A1bWKN7GVQg
         7l9zc2sLOaEwGo/OCT8s09I3+rVZEiuGWAX6JEr/moa/ahGPNGvoq2coD9OCgH0p2ybK
         8um1khDECGbpWGLs20DbAfVxDv4gd4sfJt1KiyrK9oeHpJtqHsj7m3s4qUAA3EYTiml1
         RcZeE0Hm7CulTjv7sdEW5sdjPx+nXybfeWjLOZxocdhADUQdz6Ry1qcD3twvtA/wV+mt
         n8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3wURJ7f8wK/rYX1AWremJ6WWxVIvdF4W4fcHK+urU4Y=;
        b=8LaKR+uHpG0pw/4jMQHWc5dAWbh/Q/ju3jWw3g8DFL/TKcO1U1ymYBsepX3wZ6HENq
         cC0bEtLTU/3IjRLR2ecyIiBsN6Kr1E3XoSfICjBG40qfpXxVL1JzczB2LwK6N8GwiWsU
         Lq+lADPDtF+3bjqM9K1b2BjC7MET9KO9LnZM2ImjRmIvyCDegLJyE1VchojXz7RUp4tk
         XUxgRVnfKmsjCqvj1wcWgKGeNRxZ+9t2HDgAzP8psqGztUIsgV5LKNn0yHwiXUQZV5Xn
         m3GuHUBi3rE2HygWzBp5tPYOBIsbTqZ4nibiB5GQeaOhhD5t8BIWhhPOyiAApE5B1udq
         qSGQ==
X-Gm-Message-State: AOAM530YV6toQ4hgV/GX2JAPLubTnwLSklWHeGSm1s4NhqQ5/kx3jA5d
        RVjE7AkJtLyzB7+lh3mvFHXXMA==
X-Google-Smtp-Source: ABdhPJyHqPUWM6TLaBadwtJgoFX8sqXAz9turIY6bW9WSl9x0ZGa0cM73mxFnfgICJ1iaqcFQ+3yLw==
X-Received: by 2002:a17:902:e14c:b0:163:86e0:2137 with SMTP id d12-20020a170902e14c00b0016386e02137mr122325pla.89.1653559911140;
        Thu, 26 May 2022 03:11:51 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id z17-20020a170902d55100b0015f309f14d0sm1114861plf.56.2022.05.26.03.11.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 03:11:50 -0700 (PDT)
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
Subject: [PATCH V2 3/5] riscv: smp: Support for 64bit hartid
Date:   Thu, 26 May 2022 15:41:29 +0530
Message-Id: <20220526101131.2340729-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526101131.2340729-1-sunilvl@ventanamicro.com>
References: <20220526101131.2340729-1-sunilvl@ventanamicro.com>
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

The hartid can be a 64bit value on RV64 platforms. This patch
modifies the hartid parameter in riscv_hartid_to_cpuid() as
unsigned long so that it can hold 64bit value on RV64 platforms.

Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
Reviewed-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
---
 arch/riscv/include/asm/smp.h | 4 ++--
 arch/riscv/kernel/smp.c      | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/riscv/include/asm/smp.h b/arch/riscv/include/asm/smp.h
index 23170c933d73..d3443be7eedc 100644
--- a/arch/riscv/include/asm/smp.h
+++ b/arch/riscv/include/asm/smp.h
@@ -42,7 +42,7 @@ void arch_send_call_function_ipi_mask(struct cpumask *mask);
 /* Hook for the generic smp_call_function_single() routine. */
 void arch_send_call_function_single_ipi(int cpu);
 
-int riscv_hartid_to_cpuid(int hartid);
+int riscv_hartid_to_cpuid(unsigned long hartid);
 
 /* Set custom IPI operations */
 void riscv_set_ipi_ops(const struct riscv_ipi_ops *ops);
@@ -70,7 +70,7 @@ static inline void show_ipi_stats(struct seq_file *p, int prec)
 {
 }
 
-static inline int riscv_hartid_to_cpuid(int hartid)
+static inline int riscv_hartid_to_cpuid(unsigned long hartid)
 {
 	if (hartid == boot_cpu_hartid)
 		return 0;
diff --git a/arch/riscv/kernel/smp.c b/arch/riscv/kernel/smp.c
index b5d30ea92292..018e7dc45df6 100644
--- a/arch/riscv/kernel/smp.c
+++ b/arch/riscv/kernel/smp.c
@@ -47,7 +47,7 @@ static struct {
 	unsigned long bits ____cacheline_aligned;
 } ipi_data[NR_CPUS] __cacheline_aligned;
 
-int riscv_hartid_to_cpuid(int hartid)
+int riscv_hartid_to_cpuid(unsigned long hartid)
 {
 	int i;
 
@@ -55,7 +55,7 @@ int riscv_hartid_to_cpuid(int hartid)
 		if (cpuid_to_hartid_map(i) == hartid)
 			return i;
 
-	pr_err("Couldn't find cpu id for hartid [%d]\n", hartid);
+	pr_err("Couldn't find cpu id for hartid [%lu]\n", hartid);
 	return -ENOENT;
 }
 
-- 
2.25.1

