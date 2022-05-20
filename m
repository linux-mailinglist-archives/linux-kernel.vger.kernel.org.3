Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247F852E9FC
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 12:34:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348170AbiETKeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 06:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348177AbiETKeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 06:34:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B98B491546;
        Fri, 20 May 2022 03:33:59 -0700 (PDT)
Date:   Fri, 20 May 2022 10:33:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653042838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FE+BOQ6uzu8Gi5c2fn3WY83cdv+67m6yfyPb/3eWIfc=;
        b=BfRkbNSNL/MGN8ldZzmNq0V9TIoS7Eevfk26KCfZL5L7SvkvAWZ+yQWY3DZqS3bvn1mfER
        oAGkvHmppc21YMBeo11VJMPmzBpTJ16nlRZ5U1k0GHZc1lA9AcRHvWGf26PXKUGoTpmTfW
        uAxtE89VuZVKElpoJij6FE+Ho34DrzYoIRRoBsGEJdurOGf4t0fhU+91Jq7OocecQDCSmt
        Eu7rRs54KrQFO0beK/4fI8W59shsW7X2b+121a3hPB0xddvxvfG0V8RzbRczOxS27g/dev
        xaCTF5E2UiexQmlQ8ywt5HA7AmtYfq3wXMf1P6cQbyqGPPmx6bzctzokt2tLKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653042838;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FE+BOQ6uzu8Gi5c2fn3WY83cdv+67m6yfyPb/3eWIfc=;
        b=nvzRew2Wd0+BuwIHch+MrjxeMF0FyIvI+r+PFL2hbPNB2Vh+ACvAUm5rwNt/SIgp6Ha2Kr
        OiuilLzxALFOxRBQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/entry: Fixup objtool/ibt validation
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220520082604.GQ2578@worktop.programming.kicks-ass.net>
References: <20220520082604.GQ2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165304283709.4207.13042308475336063166.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     ce6565282b3b16fd850c6a676f78c6bc76d0c235
Gitweb:        https://git.kernel.org/tip/ce6565282b3b16fd850c6a676f78c6bc76d0c235
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 May 2022 10:26:04 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 20 May 2022 12:04:56 +02:00

x86/entry: Fixup objtool/ibt validation

Commit

  47f33de4aafb ("x86/sev: Mark the code returning to user space as syscall gap")

added a bunch of text references without annotating them, resulting in a
spree of objtool complaints:

  vmlinux.o: warning: objtool: vc_switch_off_ist+0x77: relocation to !ENDBR: entry_SYSCALL_64+0x15c
  vmlinux.o: warning: objtool: vc_switch_off_ist+0x8f: relocation to !ENDBR: entry_SYSCALL_compat+0xa5
  vmlinux.o: warning: objtool: vc_switch_off_ist+0x97: relocation to !ENDBR: .entry.text+0x21ea
  vmlinux.o: warning: objtool: vc_switch_off_ist+0xef: relocation to !ENDBR: .entry.text+0x162
  vmlinux.o: warning: objtool: __sev_es_ist_enter+0x60: relocation to !ENDBR: entry_SYSCALL_64+0x15c
  vmlinux.o: warning: objtool: __sev_es_ist_enter+0x6c: relocation to !ENDBR: .entry.text+0x162
  vmlinux.o: warning: objtool: __sev_es_ist_enter+0x8a: relocation to !ENDBR: entry_SYSCALL_compat+0xa5
  vmlinux.o: warning: objtool: __sev_es_ist_enter+0xc1: relocation to !ENDBR: .entry.text+0x21ea

Since these text references are used to compare against IP, and are not
an indirect call target, they don't need ENDBR so annotate them away.

Fixes: 47f33de4aafb ("x86/sev: Mark the code returning to user space as syscall gap")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220520082604.GQ2578@worktop.programming.kicks-ass.net
---
 arch/x86/entry/entry_64.S        | 3 +++
 arch/x86/entry/entry_64_compat.S | 3 +++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 2fd8a5c..58a2d76 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -216,9 +216,12 @@ syscall_return_via_sysret:
 	popq	%rdi
 	popq	%rsp
 SYM_INNER_LABEL(entry_SYSRETQ_unsafe_stack, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 	swapgs
 	sysretq
 SYM_INNER_LABEL(entry_SYSRETQ_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
+	int3
 SYM_CODE_END(entry_SYSCALL_64)
 
 /*
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index 3c0e149..8011021 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -298,6 +298,7 @@ sysret32_from_system_call:
          */
 	movq	RSP-ORIG_RAX(%rsp), %rsp
 SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
 
 	/*
 	 * The original userspace %rsp (RSP-ORIG_RAX(%rsp)) is stored
@@ -316,6 +317,8 @@ SYM_INNER_LABEL(entry_SYSRETL_compat_unsafe_stack, SYM_L_GLOBAL)
 	swapgs
 	sysretl
 SYM_INNER_LABEL(entry_SYSRETL_compat_end, SYM_L_GLOBAL)
+	ANNOTATE_NOENDBR
+	int3
 SYM_CODE_END(entry_SYSCALL_compat)
 
 /*
