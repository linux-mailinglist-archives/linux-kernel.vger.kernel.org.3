Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8C3509D30
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388162AbiDUKOH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:14:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387973AbiDUKNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7407F0B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:10:57 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id g3so3621421pgg.3
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKmvG5lJapAQ9lDEo7MY00QMdh+x4EBTY4Sy6sMzD7o=;
        b=X8uknKHZcBU6r3jnBw07u1EPP3qYMedxnlZDHplc9a4JmCO2RfDOD7i+Hx89/DqEan
         Fp0lbIXo8IE3TM/hphytWfEjlrDXcrFiw3OGSf9J9pg4WrvDsnhphvzm1r/82zaHSP4A
         phHU7zzWttbb79IapD9rgEVMkdikEbnp2SRpYuQi1FkQGeoCBVbpZIG4hUS2ayLXcX9H
         zNk+fgkdbbiziZOaNBcUjqk5Kv7G5Slo4IgtzOIUlyIQkaKC3UL2FTBsMYGOzOkfUTXY
         cqNzGaITm2iuqjfEUlO7A2aazPKy2+ipwBxdzxql2erl7TuLuaM8UCP+2cSGBuU+07xU
         inAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKmvG5lJapAQ9lDEo7MY00QMdh+x4EBTY4Sy6sMzD7o=;
        b=slR59CFK+qmckZ5X1iEobpA59f+btisYQieRp5tzYdaArkwCZFmY/hReo7CdYvG17z
         y5QhOlT/WtPT44hk0X5uvmsAOqb7vf5yblUt9mcZuhP+IBuJg7zhd7xOxbe/txMC5fwf
         zmUbQQjXevDSD7K9owhTpyKEe95Drlu/NWAW0xS1cd0ajzfoFQqTBy6JNQ+gdcavwgUU
         OX1zvQgAV/E/Ne1qmjwSILx39oLBY2x903PWm4qB1m712elnCrRT/UgvsmV2D0Ujn20Q
         WYTtghPM5Q5QFoAGnpJ3E+2ZDRm1VqX3o902rnLa0tCGIMAsukA3ac0lRpbn2xamjjPF
         56gw==
X-Gm-Message-State: AOAM530d5L7dtIkW0Xv5t3glaoc/PoRJZL4dP16Hk/5/CKTIEOIvJYtH
        Wqgz+IiXk98IheMui1LndGA=
X-Google-Smtp-Source: ABdhPJxr/FUChNNj8WRhFaSf+GSMSw9wBZrDtia42yQBMMdt3wUzWSmUEkLZpey8ysp1Ud4CoW/9eA==
X-Received: by 2002:a05:6a00:cd2:b0:50a:7685:8055 with SMTP id b18-20020a056a000cd200b0050a76858055mr20559622pfv.37.1650535857204;
        Thu, 21 Apr 2022 03:10:57 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.10.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:10:56 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 02/10] xtensa: clean up exception handler prototypes
Date:   Thu, 21 Apr 2022 03:10:25 -0700
Message-Id: <20220421101033.216394-3-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220421101033.216394-1-jcmvbkbc@gmail.com>
References: <20220421101033.216394-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exception handlers are currently passed as void pointers because they
may have one or two parameters. Only two handlers uses the second
parameter and it is available in the struct pt_regs anyway. Make all
handlers have only one parameter, introduce xtensa_exception_handler
type for handlers and use it in trap_set_handler.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:

- new patch

 arch/xtensa/include/asm/traps.h      | 14 ++++++--------
 arch/xtensa/kernel/s32c1i_selftest.c |  7 +++----
 arch/xtensa/kernel/traps.c           |  7 ++++---
 3 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/arch/xtensa/include/asm/traps.h b/arch/xtensa/include/asm/traps.h
index fc63217232a4..bfdb0af61b07 100644
--- a/arch/xtensa/include/asm/traps.h
+++ b/arch/xtensa/include/asm/traps.h
@@ -12,6 +12,8 @@
 
 #include <asm/ptrace.h>
 
+typedef void xtensa_exception_handler(struct pt_regs *regs);
+
 /*
  * Per-CPU exception handling data structure.
  * EXCSAVE1 points to it.
@@ -30,15 +32,11 @@ struct exc_table {
 	/* Fast kernel exception handlers */
 	void *fast_kernel_handler[EXCCAUSE_N];
 	/* Default C-Handlers */
-	void *default_handler[EXCCAUSE_N];
+	xtensa_exception_handler *default_handler[EXCCAUSE_N];
 };
 
-/*
- * handler must be either of the following:
- *  void (*)(struct pt_regs *regs);
- *  void (*)(struct pt_regs *regs, unsigned long exccause);
- */
-extern void * __init trap_set_handler(int cause, void *handler);
+xtensa_exception_handler *
+__init trap_set_handler(int cause, xtensa_exception_handler *handler);
 
 asmlinkage void fast_illegal_instruction_user(void);
 asmlinkage void fast_syscall_user(void);
@@ -54,7 +52,7 @@ asmlinkage void system_call(struct pt_regs *regs);
 
 void do_IRQ(int hwirq, struct pt_regs *regs);
 void do_page_fault(struct pt_regs *regs);
-void do_unhandled(struct pt_regs *regs, unsigned long exccause);
+void do_unhandled(struct pt_regs *regs);
 
 /* Initialize minimal exc_table structure sufficient for basic paging */
 static inline void __init early_trap_init(void)
diff --git a/arch/xtensa/kernel/s32c1i_selftest.c b/arch/xtensa/kernel/s32c1i_selftest.c
index 07e56e3a9a8b..8362388c8719 100644
--- a/arch/xtensa/kernel/s32c1i_selftest.c
+++ b/arch/xtensa/kernel/s32c1i_selftest.c
@@ -40,14 +40,13 @@ static inline int probed_compare_swap(int *v, int cmp, int set)
 
 /* Handle probed exception */
 
-static void __init do_probed_exception(struct pt_regs *regs,
-				       unsigned long exccause)
+static void __init do_probed_exception(struct pt_regs *regs)
 {
 	if (regs->pc == rcw_probe_pc) {	/* exception on s32c1i ? */
 		regs->pc += 3;		/* skip the s32c1i instruction */
-		rcw_exc = exccause;
+		rcw_exc = regs->exccause;
 	} else {
-		do_unhandled(regs, exccause);
+		do_unhandled(regs);
 	}
 }
 
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index b6bb5911ec7f..d6b1a0c3e319 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -170,7 +170,7 @@ __die_if_kernel(const char *str, struct pt_regs *regs, long err)
  * Unhandled Exceptions. Kill user task or panic if in kernel space.
  */
 
-void do_unhandled(struct pt_regs *regs, unsigned long exccause)
+void do_unhandled(struct pt_regs *regs)
 {
 	__die_if_kernel("Caught unhandled exception - should not happen",
 			regs, SIGKILL);
@@ -180,7 +180,7 @@ void do_unhandled(struct pt_regs *regs, unsigned long exccause)
 			    "(pid = %d, pc = %#010lx) - should not happen\n"
 			    "\tEXCCAUSE is %ld\n",
 			    current->comm, task_pid_nr(current), regs->pc,
-			    exccause);
+			    regs->exccause);
 	force_sig(SIGILL);
 }
 
@@ -360,7 +360,8 @@ static void do_debug(struct pt_regs *regs)
 
 /* Set exception C handler - for temporary use when probing exceptions */
 
-void * __init trap_set_handler(int cause, void *handler)
+xtensa_exception_handler *
+__init trap_set_handler(int cause, xtensa_exception_handler *handler)
 {
 	void *previous = per_cpu(exc_table, 0).default_handler[cause];
 
-- 
2.30.2

