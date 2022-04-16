Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F265033D8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Apr 2022 07:48:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbiDPE2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 00:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiDPE2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 00:28:49 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 711ACFDE15
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:19 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id ll10so8955296pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 21:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/4psa0PrdKvlWjB2+JZ/eA8z6XCUnC2kvgJwCGBUqzs=;
        b=LQZL+AMRhCLnQI3Mq2wA12Ltli9F4052F+wjLUHlmkMXG3MWCEkDm1KMzruYoCf1kh
         NMSaG+yJMLDHXtr6K8Ntfv/fOJB9Cm1IO0YiOicPYIBCIqJYu4vL0KaDODrnXEULHgBL
         OGxNbneLU/hLZE5QKDvoNCLFE1MCDragVQFM6+xR+o6YeTOxnjALWNV3Q6iGZJtDfERE
         wO9s6xMICFznffXBVflMNekqLcPh7xpkuYYnejnYHkdJPiPDgSftXqIh8nswwaGJ3/T2
         ZOvyNC0dX9RQA/x/QZUhkWthAFilDuycVC5Wq2iMJ7CQ6RLJ5SoBe1PS7ii/UjwKCmNY
         FMSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/4psa0PrdKvlWjB2+JZ/eA8z6XCUnC2kvgJwCGBUqzs=;
        b=05IvjTndU+CX2ZhA64fIQ7y/3SCUWYUBnB8DUQsKLnSHGw2h8Uy73k2sZxxaXobCcs
         FgEb6Br2QJk8udhWDdjELdHMGr7kXRe4PVmoTtcmFbkFnfrb/qqREYUcFLrhUc12zM2W
         ft2195Nl5J2I5JX0P1r1fRxbdu5r5SgENuyxn1+6e7OXgfwHD/pHOfZOlFRMFd088Ddb
         uu571EgMAVERXbHBuRkbDUPJcaPOM5DBGafjx7KD6aA2g4aaD97+hHETJ67xkYH29lwr
         qkDQbucgB5FXWKGfE3Dsx68FbynstXpf5D5eFyYrCdVoOK8e2zcFKpECz4EGSzQ27O2z
         2bNw==
X-Gm-Message-State: AOAM530gHz+P4Rvj9fp8tvPAMJCJ2scazrPwIYG8XhJiRTUls33KOKSr
        G6go1YOlPfhgHYulRWn14OU=
X-Google-Smtp-Source: ABdhPJxLK+WuDeDgUgCMsbTAgcFQ8m2Ij8hpPzKxFxayPUgJXgRD2B7p0XzNZR5ukhvoaOXP9TTQTg==
X-Received: by 2002:a17:90b:1809:b0:1d2:6345:b000 with SMTP id lw9-20020a17090b180900b001d26345b000mr303686pjb.98.1650083178925;
        Fri, 15 Apr 2022 21:26:18 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:9b6:6aad:72f6:6e16])
        by smtp.gmail.com with ESMTPSA id d8-20020aa78688000000b00505793566f7sm4258513pfo.211.2022.04.15.21.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 21:26:18 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/6] xtensa: clean up function declarations in traps.c
Date:   Fri, 15 Apr 2022 21:25:54 -0700
Message-Id: <20220416042559.2035015-2-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
References: <20220416042559.2035015-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Drop 'extern' from all function declarations. Add 'static' to
declarations and definitions only used locally. Add argument names in
declarations. Drop unused and not passed second argument from do_multihit
and do_page_fault.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/kernel/traps.c | 61 +++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/xtensa/kernel/traps.c b/arch/xtensa/kernel/traps.c
index 515719c7e750..a85992d60c11 100644
--- a/arch/xtensa/kernel/traps.c
+++ b/arch/xtensa/kernel/traps.c
@@ -48,25 +48,31 @@
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
+void kernel_exception(void);
+void user_exception(void);
+
+void fast_illegal_instruction_user(void);
+void fast_syscall_user(void);
+void fast_alloca(void);
+void fast_unaligned(void);
+void fast_second_level_miss(void);
+void fast_store_prohibited(void);
+void fast_coprocessor(void);
+
+void do_IRQ(int hwirq, struct pt_regs *regs);
+void do_page_fault(struct pt_regs *regs);
+void system_call(struct pt_regs *regs);
+
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
@@ -197,7 +203,7 @@ void do_unhandled(struct pt_regs *regs, unsigned long exccause)
  * Multi-hit exception. This if fatal!
  */
 
-void do_multihit(struct pt_regs *regs, unsigned long exccause)
+static void do_multihit(struct pt_regs *regs)
 {
 	die("Caught multihit exception", regs, SIGKILL);
 }
@@ -206,8 +212,6 @@ void do_multihit(struct pt_regs *regs, unsigned long exccause)
  * IRQ handler.
  */
 
-extern void do_IRQ(int, struct pt_regs *);
-
 #if XTENSA_FAKE_NMI
 
 #define IS_POW2(v) (((v) & ((v) - 1)) == 0)
@@ -240,7 +244,7 @@ irqreturn_t xtensa_pmu_irq_handler(int irq, void *dev_id);
 
 DEFINE_PER_CPU(unsigned long, nmi_count);
 
-void do_nmi(struct pt_regs *regs)
+static void do_nmi(struct pt_regs *regs)
 {
 	struct pt_regs *old_regs = set_irq_regs(regs);
 
@@ -253,7 +257,7 @@ void do_nmi(struct pt_regs *regs)
 }
 #endif
 
-void do_interrupt(struct pt_regs *regs)
+static void do_interrupt(struct pt_regs *regs)
 {
 	static const unsigned int_level_mask[] = {
 		0,
@@ -303,8 +307,7 @@ void do_interrupt(struct pt_regs *regs)
  * Illegal instruction. Fatal if in kernel space.
  */
 
-void
-do_illegal_instruction(struct pt_regs *regs)
+static void do_illegal_instruction(struct pt_regs *regs)
 {
 	__die_if_kernel("Illegal instruction in kernel", regs, SIGKILL);
 
@@ -324,8 +327,7 @@ do_illegal_instruction(struct pt_regs *regs)
  */
 
 #if XCHAL_UNALIGNED_LOAD_EXCEPTION || XCHAL_UNALIGNED_STORE_EXCEPTION
-void
-do_unaligned_user (struct pt_regs *regs)
+static void do_unaligned_user(struct pt_regs *regs)
 {
 	__die_if_kernel("Unhandled unaligned exception in kernel",
 			regs, SIGKILL);
@@ -346,8 +348,7 @@ do_unaligned_user (struct pt_regs *regs)
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

