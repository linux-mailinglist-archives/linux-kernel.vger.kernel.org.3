Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FB594D9929
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347392AbiCOKps (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347250AbiCOKpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:07 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E2334665;
        Tue, 15 Mar 2022 03:43:52 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYjN1ZiIedD+lsGVURVqP+5FYs+KL6n1NAgl6kA3Hbo=;
        b=bMlJA41+z25oLWn74tsgTTVudrk5FCSwzdUueGqto4QBbQ96wQohiNqghtCDluwht79V4z
        /ul7cgEIrvTVkh7/G8KL3KCexnZJbntqRkZmtWp0baEzeOU9yLm0sfItptL+UCIP6H0DRL
        +CQ+n4Klf+tKwoiRMi0IZuXPSzpdUygLeUUIiFRdw8RpQtlAR3ePMrEN7c4T7UUseKdz2K
        f0xyxAezSxUrQc971UuNEjLf7VMC2IvrS9MeZiwyznmFZkUXy8E2ZJ47U5T4EqIQOw9bNr
        aA/GkFv0Ap5WscaoZUCdC0mJjlL4TbwQPDflAL1T+P+ZAijXt8kfJO5u1X7p9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341030;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LYjN1ZiIedD+lsGVURVqP+5FYs+KL6n1NAgl6kA3Hbo=;
        b=EgE++ALGZbSXXj/G+OlnkEhtskkV5TLfiapWH7oZ+gwNKRD4JDwogjI+fMxyo8v8mKebSt
        /pmKhyG9/VyvtZAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Mark stop_this_cpu() __noreturn
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.290905453@infradead.org>
References: <20220308154319.290905453@infradead.org>
MIME-Version: 1.0
Message-ID: <164734102930.16921.8671317442992970666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     f9cdf7ca57cada055f61ef6d0eb4db21c3f200db
Gitweb:        https://git.kernel.org/tip/f9cdf7ca57cada055f61ef6d0eb4db21c3f200db
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:43 +01:00

x86: Mark stop_this_cpu() __noreturn

vmlinux.o: warning: objtool: smp_stop_nmi_callback()+0x2b: unreachable instruction

0000 0000000000047cf0 <smp_stop_nmi_callback>:
...
0026    47d16:  e8 00 00 00 00          call   47d1b <smp_stop_nmi_callback+0x2b>       47d17: R_X86_64_PLT32   stop_this_cpu-0x4
002b    47d1b:  b8 01 00 00 00          mov    $0x1,%eax

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.290905453@infradead.org
---
 arch/x86/include/asm/processor.h | 2 +-
 arch/x86/kernel/process.c        | 2 +-
 tools/objtool/check.c            | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2c5f12a..dd34100 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -835,7 +835,7 @@ bool xen_set_default_idle(void);
 #define xen_set_default_idle 0
 #endif
 
-void stop_this_cpu(void *dummy);
+void __noreturn stop_this_cpu(void *dummy);
 void microcode_check(void);
 
 enum l1tf_mitigations {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 81d8ef0..a057a5c 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -747,7 +747,7 @@ bool xen_set_default_idle(void)
 }
 #endif
 
-void stop_this_cpu(void *dummy)
+void __noreturn stop_this_cpu(void *dummy)
 {
 	local_irq_disable();
 	/*
diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index 0e0e5b5..c3ddcec 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -181,6 +181,7 @@ static bool __dead_end_function(struct objtool_file *file, struct symbol *func,
 		"kunit_try_catch_throw",
 		"xen_start_kernel",
 		"cpu_bringup_and_idle",
+		"stop_this_cpu",
 	};
 
 	if (!func)
