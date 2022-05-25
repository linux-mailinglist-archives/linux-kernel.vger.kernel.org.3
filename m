Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B27C533FFF
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 17:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245041AbiEYPL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 11:11:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245047AbiEYPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 11:11:45 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52502B0A52
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:33 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id g184so19145620pgc.1
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 08:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u3hj7ydFHDyTF3uUIDzuU/DKrZho4pwFZBNazS2zRYc=;
        b=KjBynz0SRbfVN3qpMXC7kjtpgmOMzEDF8I0kN4EzFYmcp/sm5REo7Nlfa21pZ5OLVe
         Hh0YxZ78ieeuqraEzEy22mseLwehS/ARrNVnyRZUhpey1Xk+YrVBk536tFwnYRfxE7kD
         FgbAxpiogw7wRP6IEajjgeX2s2podEV2yFbUJPQktj9kfTXJKsGWahWkRrjgvWRQetMy
         8ydMLRvo69FdYjIR2/08s78ADO30emLwYV3bYUVNLnTSKVyrxgNwc60jhLBhvJCpg6OX
         733n3UOS7X/9+la7j0WBxnMSILir1P4SgmEYn5BNzLWNm6Pv13eMyM1d/wMrAy0aa9Z+
         h3YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u3hj7ydFHDyTF3uUIDzuU/DKrZho4pwFZBNazS2zRYc=;
        b=4m/icx+4x7477TSmfGly9VIUxXTeWQXb3GKYsExUnr9xM2LzCul/chWDYIrtxRA+z0
         OhFyZ0/O1aTXFK8BNG4nmsd9gMby5dZXJS9vWGrSzfbhloRxZIbCI7CJ3WF5U8RZ1RLm
         gAPxrTNL5A9E5Qydeb2+S5ZItyj/dZcoUlvB8VMqnjJQEmT8wSsvS36pwOtRGHbA4NZR
         Gj8ZZ06rdM1EJhsihpqByWd0JHaYbiu6/BwBekRv9F7c0gcg6Z/7yAceTuIXAJHCdaWj
         rauuzqe5yxM70aPZg+qOJu/35124EIreZ8ONtTxyxGZVO+K7Zxgcf9bkPscEJcW5AfM0
         s+AQ==
X-Gm-Message-State: AOAM532KxBMqgoSyzGESd9sYVtmymzJAimArWPqPBIGzr8NzPT+lBDbv
        VBj1fegyUuWthvaAMmytB0nQwQ==
X-Google-Smtp-Source: ABdhPJyR9tP9G0ssvONjCOVSdg70Xwqd7QhKiD+f4DqfrnhmEii7E7/6476AvAs2018HColuzqkvdQ==
X-Received: by 2002:a63:a06:0:b0:3c2:3345:bf99 with SMTP id 6-20020a630a06000000b003c23345bf99mr29126038pgk.477.1653491491632;
        Wed, 25 May 2022 08:11:31 -0700 (PDT)
Received: from kerodipc.Dlink ([49.206.9.238])
        by smtp.gmail.com with ESMTPSA id q16-20020a170902eb9000b00161b50c3db4sm9383129plg.94.2022.05.25.08.11.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 08:11:31 -0700 (PDT)
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
Subject: [PATCH 3/5] riscv: smp: Support for 64bit hartid
Date:   Wed, 25 May 2022 20:41:04 +0530
Message-Id: <20220525151106.2176147-4-sunilvl@ventanamicro.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
References: <20220525151106.2176147-1-sunilvl@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
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

