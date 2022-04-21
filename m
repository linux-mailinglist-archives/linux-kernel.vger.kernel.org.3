Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFBD509D2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 12:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388147AbiDUKN7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 06:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231376AbiDUKNp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 06:13:45 -0400
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BBE8E31
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:10:56 -0700 (PDT)
Received: by mail-pg1-x52e.google.com with SMTP id t4so4265562pgc.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 03:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tuFN4GoodRCoG0JXqpv/xpJ28l/3+jmqR5oJQdyxXWQ=;
        b=cuPC+hTe+2ouqxhRuHZqyj7MCQ2K4ZZQ9IiNAcXkSMhX8QTBajy8n9iSkZYOGancSM
         HXzxZA0OqUHlkXdBZaU6IK7gAZC7Pj6KBtzLtGiSnxS4n67msptf2TRGSLTNappcT5x6
         fPhZWNqZ/B5LFQNhTJzvfAZyPNnTdO6EN8FUloqSYJIpnDEkWg3u/p5/H8xATbxuEobX
         kLJqrAF5fevSN7tuMNV/p8M+FTzyfEb6DJmUsPDnr+dQJZnjHEx7NEN6LpPDYrEXMMH8
         uB1NMg+A2b6KuoK+5Q6Q7pQzX3mE/cu2NbTyrnLre4h0QjDm5cuyEsBr3U6CKhqz+2cq
         gVQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tuFN4GoodRCoG0JXqpv/xpJ28l/3+jmqR5oJQdyxXWQ=;
        b=K7z1dRygcM0gb05SfPOywONjBCJvTgJMbOpS+7oMSJZ9eKSnjtljt/Imn+yI8uublR
         TfrzW3FB7wtwNUFu/d1VzkswThi+unBsSMvF9skJvZjrrnF6itL5CJT+jb9x7yVH7yHB
         ZD+ycA2qSjWu5ZiZIg4feyIdm7qzLMtZHJQyYSmoPwQ4O/UEGLfmapXFEc7BWm9B2DtK
         SIO3hw0TTBxDfyihUGdULQYeFpOpz9CRK8RgenTkwf32uTr6aHlVcbMHI9hF/DieJKLG
         rIR03/Cn3HXUK7SolTheIbrgH6qOJvNgsCHAo+yuWzXKNVvhl3XbiSIUvh58e0hwCM3N
         a6yw==
X-Gm-Message-State: AOAM532AnpwAvSYBDJ1hL/1+ZGtpO8vkCbjMzyP5NqkedAOitAsYcnNY
        kUDM/iuUjCiaizHVbEpa2LE=
X-Google-Smtp-Source: ABdhPJxErW+PvY3TDLlcay6TKXoRjeJ3IwhowfTYGjmmGZwW5q9Lz1CBtJtxRiFdXuiscjz95btgXg==
X-Received: by 2002:a63:2266:0:b0:39c:f643:ee69 with SMTP id t38-20020a632266000000b0039cf643ee69mr22819993pgm.288.1650535855684;
        Thu, 21 Apr 2022 03:10:55 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:df13:3d47:8c92:6576])
        by smtp.gmail.com with ESMTPSA id w196-20020a6282cd000000b0050ada022940sm2407806pfd.183.2022.04.21.03.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 03:10:54 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v2 01/10] xtensa: clean up function declarations in traps.c
Date:   Thu, 21 Apr 2022 03:10:24 -0700
Message-Id: <20220421101033.216394-2-jcmvbkbc@gmail.com>
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

Drop 'extern' from all function declarations and move those that need to
be visible from traps.c to traps.h. Add 'asmlinkage' to declarations of
fucntions defined in assembly. Add 'static' to declarations and
definitions only used locally. Add argument names in declarations.
Drop unused second argument from do_multihit and do_page_fault.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:

- move declarations to traps.h and add 'asmlinkage' annotations

 arch/xtensa/include/asm/traps.h | 18 +++++++++++--
 arch/xtensa/kernel/traps.c      | 46 ++++++++++++---------------------
 2 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/arch/xtensa/include/asm/traps.h b/arch/xtensa/include/asm/traps.h
index 6fa47cd8e02d..fc63217232a4 100644
--- a/arch/xtensa/include/asm/traps.h
+++ b/arch/xtensa/include/asm/traps.h
@@ -39,8 +39,22 @@ struct exc_table {
  *  void (*)(struct pt_regs *regs, unsigned long exccause);
  */
 extern void * __init trap_set_handler(int cause, void *handler);
-extern void do_unhandled(struct pt_regs *regs, unsigned long exccause);
-void fast_second_level_miss(void);
+
+asmlinkage void fast_illegal_instruction_user(void);
+asmlinkage void fast_syscall_user(void);
+asmlinkage void fast_alloca(void);
+asmlinkage void fast_unaligned(void);
+asmlinkage void fast_second_level_miss(void);
+asmlinkage void fast_store_prohibited(void);
+asmlinkage void fast_coprocessor(void);
+
+asmlinkage void kernel_exception(void);
+asmlinkage void user_exception(void);
+asmlinkage void system_call(struct pt_regs *regs);
+
+void do_IRQ(int hwirq, struct pt_regs *regs);
+void do_page_fault(struct pt_regs *regs);
+void do_unhandled(struct pt_regs *regs, unsigned long exccause);
 
 /* Initialize minimal exc_table structure sufficient for basic paging */
 static inline void __init early_trap_init(void)
diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 515719c7e750..b6bb5911ec7f 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -48,25 +48,16 @@
  * Machine specific interrupt handlers
  */
 
-extern void kernel_exception(void);
-extern void user_exception(void);
-
-extern void fast_illegal_instruction_user(void);
-extern void fast_syscall_user(void);
-extern void fast_alloca(void);
-extern void fast_unaligned(void);
-extern void fast_second_level_miss(void);
-extern void fast_store_prohibited(void);
-extern void fast_coprocessor(void);
-
-extern void do_illegal_instruction (struct pt_regs*);
-extern void do_interrupt (struct pt_regs*);
-extern void do_nmi(struct pt_regs *);
-extern void do_unaligned_user (struct pt_regs*);
-extern void do_multihit (struct pt_regs*, unsigned long);
-extern void do_page_fault (struct pt_regs*, unsigned long);
-extern void do_debug (struct pt_regs*);
-extern void system_call (struct pt_regs*);
+static void do_illegal_instruction(struct pt_regs *regs);
+static void do_interrupt(struct pt_regs *regs);
+#if XTENSA_FAKE_NMI
+static void do_nmi(struct pt_regs *regs);
+#endif
+#if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
+static void do_unaligned_user(struct pt_regs *regs);
+#endif
+static void do_multihit(struct pt_regs *regs);
+static void do_debug(struct pt_regs *regs);
 
 /*
  * The vector table must be preceded by a save area (which
@@ -197,7 +188,7 @@ void do_unhandled(struct pt_regs *regs, unsigned long exccause)
  * Multi-hit exception. This if fatal!
  */
 
-void do_multihit(struct pt_regs *regs, unsigned long exccause)
+static void do_multihit(struct pt_regs *regs)
 {
 	die("Caught multihit exception", regs, SIGKILL);
 }
@@ -206,8 +197,6 @@ void do_multihit(struct pt_regs *regs, unsigned long exccause)
  * IRQ handler.
  */
 
-extern void do_IRQ(int, struct pt_regs *);
-
 #if XTENSA_FAKE_NMI
 
 #define IS_POW2(v) (((v) & ((v) - 1)) == 0)
@@ -240,7 +229,7 @@ irqreturn_t xtensa_pmu_irq_handler(int irq, void *dev_id);
 
 DEFINE_PER_CPU(unsigned long, nmi_count);
 
-void do_nmi(struct pt_regs *regs)
+static void do_nmi(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
@@ -253,7 +242,7 @@ void do_nmi(struct pt_regs *regs)
 }
 #endif
 
-void do_interrupt(struct pt_regs *regs)
+static void do_interrupt(struct pt_regs *regs)
 {
 	static const unsigned int_level_mask[] = {
 		0,
@@ -303,8 +292,7 @@ void do_interrupt(struct pt_regs *regs)
  * Illegal instruction. Fatal if in kernel space.
  */
 
-void
-do_illegal_instruction(struct pt_regs *regs)
+static void do_illegal_instruction(struct pt_regs *regs)
 {
 	__die_if_kernel("Illegal instruction in kernel", regs, SIGKILL);
 
@@ -324,8 +312,7 @@ do_illegal_instruction(struct pt_regs *regs)
  */
 
 #if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
-void
-do_unaligned_user (struct pt_regs *regs)
+static void do_unaligned_user(struct pt_regs *regs)
 {
 	__die_if_kernel("Unhandled unaligned exception in kernel",
 			regs, SIGKILL);
@@ -346,8 +333,7 @@ do_unaligned_user (struct pt_regs *regs)
  * breakpoint structures to debug registers intact, so that
  * DEBUGCAUSE.DBNUM could be used in case of data breakpoint hit.
  */
-void
-do_debug(struct pt_regs *regs)
+static void do_debug(struct pt_regs *regs)
 {
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
 	int ret = check_hw_breakpoint(regs);
-- 
2.30.2

