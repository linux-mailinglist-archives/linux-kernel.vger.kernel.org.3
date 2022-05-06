Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E79FE51DB98
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 17:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442719AbiEFPM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 11:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384705AbiEFPMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 11:12:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F18296D18A;
        Fri,  6 May 2022 08:09:02 -0700 (PDT)
Date:   Fri, 06 May 2022 15:09:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651849741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+sm8uFM7FbDhHcUsqKlMjO2L9gyZokheSMjZgtSp+U=;
        b=wRDIGubs7mI17xtYSS0mLs6KbAY4NBlRX16QMExtxFuMtxX5tqPN6d/gr23dmn7cpZsDM9
        p8oWgBOdibD9FQ3DXKiFDm/slsglbmyXTdoEh9oU2PXla2jA5KaRdoBWOggNivTGLUx+xI
        K6QyQnjpBrTQvq0C+gs6ucAOrdXcQEE2kxmzNX/pf0nmGw6D5qONtDlPYC5aP49ua2nZ0R
        WkB89YctWQkJUlP3gRj9C8F5UIlwhUCfNSlS0PiIUD8GpmYEXcdpqagxQGsNVcMDrhcGhi
        08o+tH8UQOg90Iqx0ujyeVlO49MlxRetPV8xlpJ4+8kYcsOi+axVvpknuH/G0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651849741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=U+sm8uFM7FbDhHcUsqKlMjO2L9gyZokheSMjZgtSp+U=;
        b=MmYkwjCGJ9cT+OwLFXVCugTA+GwUgYytuVR4CV54sXbBve/aZK/PVrFLiwiu/KgmPG92AU
        yeZcEOV2l0XaCmAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/asm] x86/entry: Remove skip_r11rcx
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220506121631.365070674@infradead.org>
References: <20220506121631.365070674@infradead.org>
MIME-Version: 1.0
Message-ID: <165184974055.4207.14612212537129433465.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/asm branch of tip:

Commit-ID:     1b331eeea7b8676fc5dbdf80d0a07e41be226177
Gitweb:        https://git.kernel.org/tip/1b331eeea7b8676fc5dbdf80d0a07e41be226177
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 06 May 2022 14:14:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 06 May 2022 15:58:19 +02:00

x86/entry: Remove skip_r11rcx

Yes, r11 and rcx have been restored previously, but since they're being
popped anyway (into rsi) might as well pop them into their own regs --
setting them to the value they already are.

Less magical code.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220506121631.365070674@infradead.org
---
 arch/x86/entry/calling.h  | 10 +---------
 arch/x86/entry/entry_64.S |  3 +--
 2 files changed, 2 insertions(+), 11 deletions(-)

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index debbe94..a97cc78 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -120,27 +120,19 @@ For 32-bit we have the following conventions - kernel is built with
 	CLEAR_REGS
 .endm
 
-.macro POP_REGS pop_rdi=1 skip_r11rcx=0
+.macro POP_REGS pop_rdi=1
 	popq %r15
 	popq %r14
 	popq %r13
 	popq %r12
 	popq %rbp
 	popq %rbx
-	.if \skip_r11rcx
-	popq %rsi
-	.else
 	popq %r11
-	.endif
 	popq %r10
 	popq %r9
 	popq %r8
 	popq %rax
-	.if \skip_r11rcx
-	popq %rsi
-	.else
 	popq %rcx
-	.endif
 	popq %rdx
 	popq %rsi
 	.if \pop_rdi
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 3121866..3a1e3f2 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -191,8 +191,7 @@ SYM_INNER_LABEL(entry_SYSCALL_64_after_hwframe, SYM_L_GLOBAL)
 	 * perf profiles. Nothing jumps here.
 	 */
 syscall_return_via_sysret:
-	/* rcx and r11 are already restored (see code above) */
-	POP_REGS pop_rdi=0 skip_r11rcx=1
+	POP_REGS pop_rdi=0
 
 	/*
 	 * Now all regs are restored except RSP and RDI.
