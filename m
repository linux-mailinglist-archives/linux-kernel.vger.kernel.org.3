Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAADA522C12
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 08:05:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbiEKGFs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 02:05:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232391AbiEKGFo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 02:05:44 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F39DFF8
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:05:39 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso1181368pjg.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 23:05:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7JjRO1XM2cc2RjeI4NcGH570FtT+tUMSzeJQeq2jaPI=;
        b=yETpf4plo6YLw66FN6+wSBXLofvajIy9gUVHSXi+dv5goV/UrJ1dwI49WYNhzOGajt
         EVTzsjSNtN50WnD5TeW09SZUATAJDgk0zKq8cATDKNZOaDd4D5Thb1TX6yrrNtcrobvn
         dDzS1LopmkWRg8qS2xtvjXnJc4z8hKZD20hmT34VtbvJmbNFziB6Vw++pmClyvfVLev/
         N2rNO30fdy0tH4I/TkbddwS4uGAt36n4+GZt3+fg/DJzoFzjwsDxpYOLLDsRKEBmZ1UW
         LG0TPwXTmC0blSdU4XoAmDl1nXR3SMe6rOF5Sf7hOQWAmKkguslyL0Ff4BodqqG3pW7i
         sihA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7JjRO1XM2cc2RjeI4NcGH570FtT+tUMSzeJQeq2jaPI=;
        b=rev0zOx/UYfhlXvkdRRg5gnwLqjaE717tzze9FGb82N0psj+aoRlOuka9Xt3jcw4PO
         H9cneDQBNknekbhYHESEdHmh14or+sknMzGcayrxi4bVzz4LZfOaqdgsFICLHIFM8M5t
         n1yFhfPVE5cBfZtrfu2v2T2Y7E/eFKPXgUhyWIi86s3Yl+uxUpiGXrZpsYa9f71Okvw5
         tBvCnV6Q6zC/UQVrv1rCBNbZmkxmTJH71ZW4XcrCN+SpHn0p/iXi7XEksLZrxeovkb7s
         jkMnFztt5Cb68KYLYV141ElHTNfGXoLkB33Xnvm3QAm0O/if+9OXeuUtqRVR7706p9qU
         fx4Q==
X-Gm-Message-State: AOAM533oUJPyiFsoE9cKLlyR/AfG49vBikZOX7ZwbbrcMFiJJHuJ7/pK
        632nMhexoOoNf/SaYdIbVapGKA==
X-Google-Smtp-Source: ABdhPJztP5LRu1TkIBC/svV1IQ8xsbq97wImFDfTWtHZBWJTDMYn8f0hRAX/l/o6YVJdhCdfQ/slqA==
X-Received: by 2002:a17:90b:4a03:b0:1dc:756a:2463 with SMTP id kk3-20020a17090b4a0300b001dc756a2463mr3689571pjb.68.1652249139169;
        Tue, 10 May 2022 23:05:39 -0700 (PDT)
Received: from localhost.localdomain ([106.213.2.134])
        by smtp.gmail.com with ESMTPSA id j7-20020a17090a31c700b001d960eaed66sm800216pjf.42.2022.05.10.23.05.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 23:05:38 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     daniel.thompson@linaro.org, dianders@chromium.org, will@kernel.org,
        liwei391@huawei.com
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, mhiramat@kernel.org,
        jason.wessel@windriver.com, maz@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH v3 1/2] arm64: entry: Skip single stepping into interrupt handlers
Date:   Wed, 11 May 2022 11:35:20 +0530
Message-Id: <20220511060521.465744-2-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220511060521.465744-1-sumit.garg@linaro.org>
References: <20220511060521.465744-1-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently on systems where the timer interrupt (or any other
fast-at-human-scale periodic interrupt) is active then it is impossible
to step any code with interrupts unlocked because we will always end up
stepping into the timer interrupt instead of stepping the user code.

The common user's goal while single stepping is that when they step then
the system will stop at PC+4 or PC+I for a branch that gets taken
relative to the instruction they are stepping. So, fix broken single step
implementation via skipping single stepping into interrupt handlers.

The methodology is when we receive an interrupt from EL1, check if we
are single stepping (pstate.SS). If yes then we save MDSCR_EL1.SS and
clear the register bit if it was set. Then unmask only D and leave I set.
On return from the interrupt, set D and restore MDSCR_EL1.SS. Along with
this skip reschedule if we were stepping.

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

