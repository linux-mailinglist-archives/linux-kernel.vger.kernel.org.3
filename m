Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDA54FB7DF
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344416AbiDKJlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229895AbiDKJkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:40:55 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B66E3403DB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:38:41 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id h23-20020a17090a051700b001c9c1dd3acbso16225147pjh.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=D81f+bPtPMlxnVjBN4tpMYR04ACl9RkF3fcOQCuWauY=;
        b=fqEDwhsixdy86x/SmP+7NM6MCA1flbTTyQsOVkWS1VjiU69v7mE9DKHLS0tLtmO7e0
         rC+7wwVgUzV5eieAo9ygj0D2eB+CukRKLUGgO2yky/FKwrMeP7C3p8MYaSZpaPpgIIwJ
         Bgp0KCfaY4Xjlzo62K2wMTnmLr6Dnwuf5uyC2J1giwC9P7lahH1Ff8cpnQamxg5LWEXr
         aIpJhLBhzB+kQKUUls/h9G2vwvl1Jbzlv4stwpq+uJwZsjsCNwKxq8T+hTjNtnIpgbif
         ePOO4Ws0HCaotvty3uwiS771v7xEOZdxd9R/jcQ8g3yU13FxKScHdL+acYMvkt3HO++1
         S6yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=D81f+bPtPMlxnVjBN4tpMYR04ACl9RkF3fcOQCuWauY=;
        b=fSvU7JbH4y0TqtIjd/YpZj2ARwTGFrj+WsnYqWxaimCqlK1IzSdjuBUM1PUqWCACRR
         CU33Yrf6FbccjVQOSsyqBRfDUkMGKDtkmOZaJJBJMTPqmQRt82UoMpo4Tugc0v05opan
         rrwT4DQVWjy3lh4GuMppQpnWyK2SMjQJjXsOkQc1TxU46QZl7TYOeGanHJ1b1N0SDPJA
         NYtxKEckQDu7pmRFn79hkQTWQ8KxqYMoQ0Wk4x1Q6ZlpENSM2EaG8+93rJBkngiet5aq
         9K0AsjlzK1uwHs3iM0wvK310a3GkGBGlnMqxnSVYHnrOXAUfZMhQ706+Tg0iF+jgtv1p
         Z7rA==
X-Gm-Message-State: AOAM532yy8KqYX9P1RUXsHic4bSusQwFIHaAjotod3bBobf82tw9YlrE
        WfXFgwKYza0n61nyPPrwjaXMGg==
X-Google-Smtp-Source: ABdhPJwdcwxx2nrrbryx7J1x7Yjni6FEfyJrVoRlOd/dwN5lKnx3IK1TtEAf2IZEd4bbA/+KtyuSSg==
X-Received: by 2002:a17:90a:558a:b0:1ca:a819:d2d1 with SMTP id c10-20020a17090a558a00b001caa819d2d1mr35891842pji.126.1649669921195;
        Mon, 11 Apr 2022 02:38:41 -0700 (PDT)
Received: from localhost.localdomain ([223.177.215.72])
        by smtp.gmail.com with ESMTPSA id d6-20020a056a00244600b004f701135460sm36461596pfj.146.2022.04.11.02.38.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Apr 2022 02:38:40 -0700 (PDT)
From:   Sumit Garg <sumit.garg@linaro.org>
To:     linux-arm-kernel@lists.infradead.org, dianders@chromium.org,
        will@kernel.org, liwei391@huawei.com
Cc:     catalin.marinas@arm.com, mark.rutland@arm.com, mhiramat@kernel.org,
        daniel.thompson@linaro.org, jason.wessel@windriver.com,
        linux-kernel@vger.kernel.org, Sumit Garg <sumit.garg@linaro.org>
Subject: [PATCH 1/2] arm64: kgdb: Fix incorrect single stepping into the irq handler
Date:   Mon, 11 Apr 2022 15:08:18 +0530
Message-Id: <20220411093819.1012583-2-sumit.garg@linaro.org>
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

PSTATE.I and PSTATE.D are very important for single step working.

Without disabling interrupt on local CPU, there is a chance of
interrupt occurrence in the period of exception return and start of
kgdb/kdb single-step, that result in wrongly single stepping into the
interrupt handler. And if D bit is set then, it results into undefined
exception and when it's handler enables dbg then single step exception
is generated, not as expected.

Currently when we execute single step in kdb/kgdb, we may see it jumps
to the irq_handler (where PSTATE.D is cleared) instead of the next
instruction. And a resume after single stepping into interrupt handler
sometimes leads to unbalanced locking:

[  300.328300] WARNING: bad unlock balance detected!
[  300.328608] 5.18.0-rc1-00016-g3e732ebf7316-dirty #6 Not tainted
[  300.329058] -------------------------------------
[  300.329298] sh/173 is trying to release lock (dbg_slave_lock) at:
[  300.329718] [<ffffd57c951c016c>] kgdb_cpu_enter+0x7ac/0x820
[  300.330029] but there are no more locks to release!
[  300.330265]
[  300.330265] other info that might help us debug this:
[  300.330668] 4 locks held by sh/173:
[  300.330891]  #0: ffff4f5e454d8438 (sb_writers#3){.+.+}-{0:0}, at: vfs_write+0x98/0x204
[  300.331735]  #1: ffffd57c973bc2f0 (dbg_slave_lock){+.+.}-{2:2}, at: kgdb_cpu_enter+0x5b4/0x820
[  300.332259]  #2: ffffd57c973a9460 (rcu_read_lock){....}-{1:2}, at: kgdb_cpu_enter+0xe0/0x820
[  300.332717]  #3: ffffd57c973bc2a8 (dbg_master_lock){....}-{2:2}, at: kgdb_cpu_enter+0x1ec/0x820

Add the save and restore work for single-step while enabling and
disabling single stepping to maintain the PSTATE.I and PSTATE.D carefully.

Fixes: 44679a4f142b ("arm64: KGDB: Add step debugging support")
Co-developed-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Wei Li <liwei391@huawei.com>
Signed-off-by: Sumit Garg <sumit.garg@linaro.org>
---
 arch/arm64/kernel/kgdb.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/kgdb.c b/arch/arm64/kernel/kgdb.c
index 2aede780fb80..653ad0d19f2f 100644
--- a/arch/arm64/kernel/kgdb.c
+++ b/arch/arm64/kernel/kgdb.c
@@ -15,6 +15,7 @@
 #include <linux/kprobes.h>
 #include <linux/sched/task_stack.h>
 
+#include <asm/daifflags.h>
 #include <asm/debug-monitors.h>
 #include <asm/insn.h>
 #include <asm/patching.h>
@@ -171,6 +172,30 @@ static void kgdb_arch_update_addr(struct pt_regs *regs,
 	compiled_break = 0;
 }
 
+/*
+ * Interrupts need to be disabled before single-step mode is set, and not
+ * re-enabled until after single-step mode ends. Without disabling interrupt
+ * on local CPU, there is a chance of interrupt occurrence in the period of
+ * exception return and start of kgdb/kdb single-step, that result in wrongly
+ * single stepping into the interrupt handler. Also, resume from single
+ * stepping the interrupt handler is risky as it sometimes leads to unbalanced
+ * locking.
+ */
+static DEFINE_PER_CPU(unsigned long, kgdb_ss_flags);
+
+static void kgdb_save_local_irqflag(struct pt_regs *regs)
+{
+	__this_cpu_write(kgdb_ss_flags, (regs->pstate & DAIF_MASK));
+	regs->pstate |= PSR_I_BIT;
+	regs->pstate &= ~PSR_D_BIT;
+}
+
+static void kgdb_restore_local_irqflag(struct pt_regs *regs)
+{
+	regs->pstate &= ~DAIF_MASK;
+	regs->pstate |= __this_cpu_read(kgdb_ss_flags);
+}
+
 int kgdb_arch_handle_exception(int exception_vector, int signo,
 			       int err_code, char *remcom_in_buffer,
 			       char *remcom_out_buffer,
@@ -201,8 +226,10 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		/*
 		 * Received continue command, disable single step
 		 */
-		if (kernel_active_single_step())
+		if (kernel_active_single_step()) {
+			kgdb_restore_local_irqflag(linux_regs);
 			kernel_disable_single_step();
+		}
 
 		err = 0;
 		break;
@@ -222,8 +249,10 @@ int kgdb_arch_handle_exception(int exception_vector, int signo,
 		/*
 		 * Enable single step handling
 		 */
-		if (!kernel_active_single_step())
+		if (!kernel_active_single_step()) {
+			kgdb_save_local_irqflag(linux_regs);
 			kernel_enable_single_step(linux_regs);
+		}
 		err = 0;
 		break;
 	default:
-- 
2.25.1

