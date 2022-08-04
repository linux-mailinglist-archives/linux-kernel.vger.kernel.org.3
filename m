Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5587C58A105
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 21:02:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229660AbiHDTCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 15:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbiHDTCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 15:02:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6357139BB3;
        Thu,  4 Aug 2022 12:02:34 -0700 (PDT)
Date:   Thu, 04 Aug 2022 19:02:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1659639752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAXs2btTEI1qqN1M213Bb2k1VGPdxbUE9Px/51ZXhzk=;
        b=Vz2t9JUHqGR9cbT271qDdvepB8fTybAGiunWE+bwwKuUOqyTCXzv2RWlNEwnPayuRGWVWz
        kN7JvUTYh8F1ApbysYpEuS07Pj2fSnm4Cx8GMIoeuG9cY6ZfWJXWgOtlyfSmqJuen5xx4u
        Gwl82KxhOArkD27bqiADZf9f3C0QVsAWyWXfQH4IJad2RldIP+ya2wzHxUexgoaVQfedbY
        SvvsBOTF30yDMfBUnsI+4WN1VM3Rq1i+MFYdA+rnS0PVIh07gIxt6Dr+r961qM8pg9SAbs
        2WW7jkFbwr6Mmf4EL0axHHQoZVHBHZ0RTApZi4aDUWaUZZQunjBG8sL7YDQlDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1659639752;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WAXs2btTEI1qqN1M213Bb2k1VGPdxbUE9Px/51ZXhzk=;
        b=DOfjDmzvl8mZedRI+QMHJEZ/kDC7IFTSwo03/DjFQ/5T1lqN2Gn3Vupv5AfaQ0N15nyaUu
        3VBELcImJMLqwXAQ==
From:   "tip-bot2 for Andrea Righi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y
Cc:     Andrea Righi <andrea.righi@canonical.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Ke7EWjcX+ZlXO@arighi-desktop>
References: <Ke7EWjcX+ZlXO@arighi-desktop>
MIME-Version: 1.0
Message-ID: <165963975056.15455.12803766346489134957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     de979c83574abf6e78f3fa65b716515c91b2613d
Gitweb:        https://git.kernel.org/tip/de979c83574abf6e78f3fa65b716515c91b2613d
Author:        Andrea Righi <andrea.righi@canonical.com>
AuthorDate:    Thu, 14 Jul 2022 09:49:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 04 Aug 2022 12:23:50 +02:00

x86/entry: Build thunk_$(BITS) only if CONFIG_PREEMPTION=y

With CONFIG_PREEMPTION disabled, arch/x86/entry/thunk_$(BITS).o becomes
an empty object file.

With some old versions of binutils (i.e., 2.35.90.20210113-1ubuntu1) the
GNU assembler doesn't generate a symbol table for empty object files and
objtool fails with the following error when a valid symbol table cannot
be found:

  arch/x86/entry/thunk_64.o: warning: objtool: missing symbol table

To prevent this from happening, build thunk_$(BITS).o only if
CONFIG_PREEMPTION is enabled.

BugLink: https://bugs.launchpad.net/bugs/1911359

Fixes: 320100a5ffe5 ("x86/entry: Remove the TRACE_IRQS cruft")
Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/Ys/Ke7EWjcX+ZlXO@arighi-desktop
---
 arch/x86/entry/Makefile   | 3 ++-
 arch/x86/entry/thunk_32.S | 2 --
 arch/x86/entry/thunk_64.S | 4 ----
 arch/x86/um/Makefile      | 3 ++-
 4 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/Makefile b/arch/x86/entry/Makefile
index eeadbd7..ca2fe18 100644
--- a/arch/x86/entry/Makefile
+++ b/arch/x86/entry/Makefile
@@ -11,12 +11,13 @@ CFLAGS_REMOVE_common.o		= $(CC_FLAGS_FTRACE)
 
 CFLAGS_common.o			+= -fno-stack-protector
 
-obj-y				:= entry.o entry_$(BITS).o thunk_$(BITS).o syscall_$(BITS).o
+obj-y				:= entry.o entry_$(BITS).o syscall_$(BITS).o
 obj-y				+= common.o
 
 obj-y				+= vdso/
 obj-y				+= vsyscall/
 
+obj-$(CONFIG_PREEMPTION)	+= thunk_$(BITS).o
 obj-$(CONFIG_IA32_EMULATION)	+= entry_64_compat.o syscall_32.o
 obj-$(CONFIG_X86_X32_ABI)	+= syscall_x32.o
 
diff --git a/arch/x86/entry/thunk_32.S b/arch/x86/entry/thunk_32.S
index 7591bab..ff6e700 100644
--- a/arch/x86/entry/thunk_32.S
+++ b/arch/x86/entry/thunk_32.S
@@ -29,10 +29,8 @@ SYM_CODE_START_NOALIGN(\name)
 SYM_CODE_END(\name)
 	.endm
 
-#ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-#endif
 
diff --git a/arch/x86/entry/thunk_64.S b/arch/x86/entry/thunk_64.S
index 505b488..f38b07d 100644
--- a/arch/x86/entry/thunk_64.S
+++ b/arch/x86/entry/thunk_64.S
@@ -31,14 +31,11 @@ SYM_FUNC_END(\name)
 	_ASM_NOKPROBE(\name)
 	.endm
 
-#ifdef CONFIG_PREEMPTION
 	THUNK preempt_schedule_thunk, preempt_schedule
 	THUNK preempt_schedule_notrace_thunk, preempt_schedule_notrace
 	EXPORT_SYMBOL(preempt_schedule_thunk)
 	EXPORT_SYMBOL(preempt_schedule_notrace_thunk)
-#endif
 
-#ifdef CONFIG_PREEMPTION
 SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	popq %r11
 	popq %r10
@@ -53,4 +50,3 @@ SYM_CODE_START_LOCAL_NOALIGN(__thunk_restore)
 	RET
 	_ASM_NOKPROBE(__thunk_restore)
 SYM_CODE_END(__thunk_restore)
-#endif
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index ba5789c..a8cde4e 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -28,7 +28,8 @@ else
 
 obj-y += syscalls_64.o vdso/
 
-subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
+subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o
+subarch-$(CONFIG_PREEMPTION) += ../entry/thunk_64.o
 
 endif
 
