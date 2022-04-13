Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54DEF4FF038
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 08:56:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233185AbiDMG6A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 02:58:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233200AbiDMG5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 02:57:38 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0AA92DD72
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:55:18 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so1157840pjk.4
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 23:55:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EgTL4VNIKYlvmdQhFawLMMFW9frxcSpLBWlCsK4+EuA=;
        b=lpC2u8VBw8yiA8bju+WTgVAQeQ744QXVIWPCGFjCUzzcOz28RCZWHmAwzHlFqIJMK8
         Ri03+jB1jNbHP719pH63Q/KRDMzokqkdMVZQ6mgkPBGdwZD+nL6rEHTLslPWIOOBZdpJ
         RM7N3nADJnZ1U+PNc4XdxpGOU5uFE34w4aFgx6Gn0dJeMPQL/AJAgzhsaG1buqJSp1YR
         taEqks+wbqS+pLwurwG1liXYsSPna5gmTmMMzFy1nWhu979ZpiEkZ6+RqGPaPbWyRUD3
         o10ETRrHulw6Hpirni26g+5nYgltoC3CtNVFKAZNUWeq0OM4agJXexl/5rzA78gNq5I4
         1ACA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EgTL4VNIKYlvmdQhFawLMMFW9frxcSpLBWlCsK4+EuA=;
        b=EOf5/Ae+tQng+SK1+dWKxTv7qezbJjBL+AcVAnRhbo1/A2ojh5m5+J6BzglRA+ZftI
         u5Jc4ne4uqFbztDJ5zrcM4K8TRo1OpAWO8EPU8+pQuUscUsR89WyPxHQKCs0ZlR9/zdB
         UpqAUXe12YFFteICpNvF1r5WbCq7XbTXbDGNIJr5k3sr67ilJIK2Ft1parDGuWYQQA3g
         E6KjK2sa4MyXA/QI6WEpJEXhVjpDoGTuwa2hElX46rKK3OxNGfkXccQfg8JuRupi2q9J
         rxNuOsLPCT9WPwzRisLmOLwY5+Q4ko+dT05IAg5kyLcpdAo29pIR5y+vHhX9JaeQvK78
         1M4w==
X-Gm-Message-State: AOAM5323/d5yUCWg3ATXXrAPVcnzsreOoxxk+LIUQC17fTDuEfjuq2XU
        XawPi7KGBpv2ovJPJkhLipqS9w==
X-Google-Smtp-Source: ABdhPJzD4jFXtu6nu5Ka7mSx2egDcsFHYNX1QDkBM9R0i9t3C+ZiLSgo171wvIYs+yCawebSCZX1vg==
X-Received: by 2002:a17:903:11d1:b0:151:9fb2:9858 with SMTP id q17-20020a17090311d100b001519fb29858mr40419078plh.136.1649832918149;
        Tue, 12 Apr 2022 23:55:18 -0700 (PDT)
Received: from localhost.localdomain ([223.177.215.72])
        by smtp.gmail.com with ESMTPSA id m15-20020a638c0f000000b003827bfe1f5csm4926908pgd.7.2022.04.12.23.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Apr 2022 23:55:17 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, mhiramat@kernel.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        maz@kernel.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v2 1/2] arm64: entry: Skip single stepping interrupt handlers
Date:   Wed, 13 Apr 2022 12:24:57 +0530
Message-Id: <20220413065458.88541-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220413065458.88541-1-sumit.garg@linaro.org>
References: <20220413065458.88541-1-sumit.garg@linaro.org>
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

Current implementation allows single stepping into interrupt handlers
for interrupts that were received during single stepping. But interrupt
handlers aren't something that the user expect to debug. Moreover single
stepping interrupt handlers is risky as it may sometimes leads to
unbalanced locking when we resume from single-step debug.

Fix broken single-step implementation via skipping single-step over
interrupt handlers. The methodology is when we receive an interrupt from
EL1, check if we are single stepping (pstate.SS). If yes then we save
MDSCR_EL1.SS and clear the register bit if it was set. Then unmask only
D and leave I set. On return from the interrupt, set D and restore
MDSCR_EL1.SS. Along with this skip reschedule if we were stepping.

Suggested-by: Will Deacon <will@kernel.org>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/kernel/entry-common.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index 878c65aa7206..dd2d3af615de 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -458,19 +458,35 @@ static __always_inline void __el1_irq(struct pt_regs *regs,
 	do_interrupt_handler(regs, handler);
 	irq_exit_rcu();
 
-	arm64_preempt_schedule_irq();
+	/* Don't reschedule in case we are single stepping */
+	if (!(regs->pstate & DBG_SPSR_SS))
+		arm64_preempt_schedule_irq();
 
 	exit_to_kernel_mode(regs);
 }
+
 static void noinstr el1_interrupt(struct pt_regs *regs,
 				  void (*handler)(struct pt_regs *))
 {
+	unsigned long reg;
+
+	/* Disable single stepping within interrupt handler */
+	if (regs->pstate & DBG_SPSR_SS) {
+		reg = read_sysreg(mdscr_el1);
+		write_sysreg(reg & ~DBG_MDSCR_SS, mdscr_el1);
+	}
+
 	write_sysreg(DAIF_PROCCTX_NOIRQ, daif);
 
 	if (IS_ENABLED(CONFIG_ARM64_PSEUDO_NMI) && !interrupts_enabled(regs))
 		__el1_pnmi(regs, handler);
 	else
 		__el1_irq(regs, handler);
+
+	if (regs->pstate & DBG_SPSR_SS) {
+		write_sysreg(DAIF_PROCCTX_NOIRQ | PSR_D_BIT, daif);
+		write_sysreg(reg, mdscr_el1);
+	}
 }
 
 asmlinkage void noinstr el1h_64_irq_handler(struct pt_regs *regs)
-- 
2.25.1

