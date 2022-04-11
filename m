Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9431B4FB7E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344614AbiDKJlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237470AbiDKJk7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:40:59 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0E5C403F4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:38:45 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id y8so8954193pfw.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=pRxuPWbMbs8wFhTVrK8n5N1s7DUnR1sc6NHEuW/6L+8=;
        b=g8s7VFcKbOqu/DOejzeFd33BpWvyQsXaqxN/rrPuVMr7ZvNMm7e0a/ZZ7WoUBV673d
         MGPQ+BME/ylqlGu2kCjKm4xjpbbxkClpaoK/mWxTaWpTUFvZbld/T1XsKrziOWFWIKpu
         AS57pZ3PmFGpd2UvCZp3K552m2n/r3CrvI5IMdGKgFyVO0hYgcECzTxq4o8iX23fRh8s
         RXhoPLd/T9oKaShXPO669WHdB+oOG7g/yR8IRTLffmnUcsQeviq+h6R/hZrDnmf+Fq3K
         YJce/odBrH9SwxFB1qSbag7cEHi/1fbB3L1T0wx5rj6LRZPXI6mKIlpnp/aiotiRhYSB
         Zwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRxuPWbMbs8wFhTVrK8n5N1s7DUnR1sc6NHEuW/6L+8=;
        b=r9QBOZuyNL9nwecuBLkdX9b31qMF5UXFEg23i26saZbm504gvWS2Azw63M44O2dDEQ
         SeHQtVcYyPlNgD86Ys2+elYKdWiZYf6kD0K6cHunAC/FmK6bH2X0bzBHQCtP6MEFNH6r
         3JlQk7X/FZIzCD8BNMCUOKA1G+ybkw6RWDq7DFQA4TygJ1V53l4jBzYDXi4NqAiZWPzi
         lMsGJnQAF0WsfnG0PpwITLupL/p7TZxX8ovZ/ujZY+VjqzhUFEX1j+mruxiqFmpDDtk9
         a1YnF1A2gp3Z/Q0X5gND4tH206BOWwiPX6pEEMhUUF+DkZk1uxQvQ+L6iEjshgk08O/+
         zsUQ==
X-Gm-Message-State: AOAM532QgcquAy9qB7rIo5Kfav8Z/ljLfyOKOfBWs22RmOQNzHS1yURk
        DKhaOziW+/Gim2CXzRWxjAFYVw==
X-Google-Smtp-Source: ABdhPJye9XGge34NNFjlN/s6B3+vnbcVaF9KVWw5sHTCfdGHlIZlxSeDf2G7QsgO3cii2n4XzlFqrg==
X-Received: by 2002:a05:6a00:10c2:b0:4fd:a140:d5a9 with SMTP id d2-20020a056a0010c200b004fda140d5a9mr31894021pfu.77.1649669925260;
        Mon, 11 Apr 2022 02:38:45 -0700 (PDT)
Received: from localhost.localdomain ([223.177.215.72])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm36461596pfj.146.2022.04.11.02.38.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 02:38:45 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, mhiramat@kernel.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 2/2] arm64: kgdb: Set PSTATE.SS to 1 to re-enable single-step
Date:   Mon, 11 Apr 2022 15:08:19 +0530
Message-Id: <20220411093819.1012583-3-sumit.garg@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220411093819.1012583-1-sumit.garg@linaro.org>
References: <20220411093819.1012583-1-sumit.garg@linaro.org>
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

After fixing wrongly single-stepping into the irq handler, when we execute
single-step in kdb/kgdb, we can see only the first step can work.

Refer to the ARM Architecture Reference Manual (ARM DDI 0487E.a) D2.12,
i think PSTATE.SS=1 should be set each step for transferring the PE to the
'Active-not-pending' state. The problem here is PSTATE.SS=1 is not set
since the second single-step.

After the first single-step, the PE transferes to the 'Inactive' state,
with PSTATE.SS=0 and MDSCR.SS=1, thus PSTATE.SS won't be set to 1 due to
kernel_active_single_step()=true. Then the PE transferes to the
'Active-pending' state when ERET and returns to the debugger by step
exception.

Before this patch:
==================
Entering kdb (current=0xffff3376039f0000, pid 1) on processor 0 due to Keyboard Entry
[0]kdb>

[0]kdb>
[0]kdb> bp write_sysrq_trigger
Instruction(i) BP #0 at 0xffffa45c13d09290 (write_sysrq_trigger)
    is enabled   addr at ffffa45c13d09290, hardtype=0 installed=0

[0]kdb> go
$ echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to Breakpoint @ 0xffffad651a309290
[1]kdb> ss

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
[1]kdb> ss

Entering kdb (current=0xffff4f7e453f8000, pid 175) on processor 1 due to SS trap @ 0xffffad651a309294
[1]kdb>

After this patch:
=================
Entering kdb (current=0xffff6851c39f0000, pid 1) on processor 0 due to Keyboard Entry
[0]kdb> bp write_sysrq_trigger
Instruction(i) BP #0 at 0xffffc02d2dd09290 (write_sysrq_trigger)
    is enabled   addr at ffffc02d2dd09290, hardtype=0 installed=0

[0]kdb> go
$ echo h > /proc/sysrq-trigger

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to Breakpoint @ 0xffffc02d2dd09290
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09294
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd09298
[1]kdb> ss

Entering kdb (current=0xffff6851c53c1840, pid 174) on processor 1 due to SS trap @ 0xffffc02d2dd0929c
[1]kdb>

Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
Co-developed-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/include/asm/debug-monitors.h | 1 +
 arch/arm64/kernel/debug-monitors.c      | 5 +++++
 arch/arm64/kernel/kgdb.c                | 2 ++
 3 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/debug-monitors.h b/arch/arm64/include/asm/debug-monitors.h
index 00c291067e57..9e1e864d6440 100644
--- a/arch/arm64/include/asm/debug-monitors.h
+++ b/arch/arm64/include/asm/debug-monitors.h
@@ -104,6 +104,7 @@ void user_regs_reset_single_step(struct user_pt_regs *regs,
 void kernel_enable_single_step(struct pt_regs *regs);
 void kernel_disable_single_step(void);
 int kernel_active_single_step(void);
+void kernel_regs_reset_single_step(struct pt_regs *regs);
 
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 int reinstall_suspended_bps(struct pt_regs *regs);
diff --git a/arch/arm64/kernel/debug-monitors.c b/arch/arm64/kernel/debug-monitors.c
index 4f3661eeb7ec..ea3f410aa385 100644
--- a/arch/arm64/kernel/debug-monitors.c
+++ b/arch/arm64/kernel/debug-monitors.c
@@ -438,6 +438,11 @@ int kernel_active_single_step(void)
 }
 NOKPROBE_SYMBOL(kernel_active_single_step);
 
+void kernel_regs_reset_single_step(struct pt_regs *regs)
+{
+	set_regs_spsr_ss(regs);
+}
+
 /* ptrace API */
 void user_enable_single_step(struct task_struct *task)
 {
diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 653ad0d19f2f..783484a3a831 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -252,6 +252,8 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		if (!kernel_active_single_step()) {
 			kgdb_save_local_irqflag(linux_regs);
 			kernel_enable_single_step(linux_regs);
+		} else {
+			kernel_regs_reset_single_step(linux_regs);
 		}
 		err = 0;
 		break;
-- 
2.25.1

