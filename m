Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A55CD4D2A0D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbiCIH4H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:56:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230240AbiCIHzw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:52 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A501637D4;
        Tue,  8 Mar 2022 23:54:50 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812488;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3kouzIS1B2cG0Gsg/QnXu4VWSWDzIeET/MtYTA5PpU=;
        b=XXblmcsMwM2fbz9buVOpgyu3euONLLxz7Kl4Qw6YULKqA/HS+lbhLF4JXOctamB9SZ3WFk
        cKpgrnYC51jvyFBsS/T4X1MK02Ph352yYjn9RxWDQHmKTn4DLUjl5LG03N4GX8aXNsutXH
        n0XY734ito6TXZeVCoFDVxxmEhnTJRtSKAZNrZkJrqsxtPnvm+HSeNmh7ddj8feiqEghhY
        5bPE9uc2iDWEvqJ7jD9h4k26n/fAMJWLThPPJvl/D8ushKqSq423ep4HaUsEBfGLytUVGB
        /Ep/utUfyJW4P0Cuu5lXW7J1dyLl8hpXlEl3z+tdS3LuphYnblYSeNc+h0+f+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812488;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l3kouzIS1B2cG0Gsg/QnXu4VWSWDzIeET/MtYTA5PpU=;
        b=/2SVsL3s8m/yGJ+JpPu+z0UQPlh9xQjoM6uXIVFGIjskXB/kgyxfBF0hRMZ6QvpcaHjLlJ
        5Y0f+g3S2i6GPxAw==
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
Message-ID: <164681248785.16921.6465886068835843086.tip-bot2@tip-bot2>
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

Commit-ID:     b109f2f6ab58de3cd4db3adeb81bbe56fb8793ea
Gitweb:        https://git.kernel.org/tip/b109f2f6ab58de3cd4db3adeb81bbe56fb8793ea
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:36 +01:00

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
