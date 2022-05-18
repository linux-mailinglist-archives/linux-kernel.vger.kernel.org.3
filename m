Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A31352C282
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 20:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241574AbiERSpF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 14:45:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241552AbiERSpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 14:45:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD11EEE3D;
        Wed, 18 May 2022 11:45:00 -0700 (PDT)
Date:   Wed, 18 May 2022 18:44:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1652899498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23MV50GdPjU9m2HORd4/zgkwKvmwZmuEql50+DjTl+8=;
        b=Nk/tgl2bLM9++qjna4dk270LJHDUFIfM2V2VYc8gfo+kBkuPAexRLDpL1gmYcvbf6QxR3H
        BCLSE5ZCQmi3Iq5YhE9JDCM06tX2nIkU+HsqBvcVoZIScPVuofINNC372kyqWmPtR5InLq
        EVcOeQpUxDPzEBEoayEQZuk4wQ5EemTiRGrPU4V7jo2iC7RFG1d2MphDF39n1dbEmjTS57
        mARwAEbRQLMi0bIvWLDWeTR6FrOTSRyxZx17yqYt2s+R724HPJXotycOmQblR9RfCDVQiw
        v4QU9nWO3EQsK1gGIHSac8wR9ziQG5L9hc5OT49O79M7ie7te2vlz1QBDEGAIA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1652899498;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=23MV50GdPjU9m2HORd4/zgkwKvmwZmuEql50+DjTl+8=;
        b=FfWEri7H4tT4Zuk/hERpMczxP4ZAUGgsyKTbiwbyCVm8kyXYtUOxC6Tasm6qtFAWblocYY
        Zp4qPpK1ql4dRTCg==
From:   "tip-bot2 for Lai Jiangshan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Annotate stack change in the #VC handler
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>,
        Borislav Petkov <bp@suse.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220316041612.71357-1-jiangshanlai@gmail.com>
References: <20220316041612.71357-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Message-ID: <165289949701.4207.10740205512652914837.tip-bot2@tip-bot2>
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

Commit-ID:     c42b145181aafd59ed31ccd879493389e3ea5a08
Gitweb:        https://git.kernel.org/tip/c42b145181aafd59ed31ccd879493389e3ea5a08
Author:        Lai Jiangshan <jiangshan.ljs@antgroup.com>
AuthorDate:    Wed, 16 Mar 2022 12:16:12 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 18 May 2022 20:36:03 +02:00

x86/sev: Annotate stack change in the #VC handler

In idtentry_vc(), vc_switch_off_ist() determines a safe stack to
switch to, off of the IST stack. Annotate the new stack switch with
ENCODE_FRAME_POINTER in case UNWINDER_FRAME_POINTER is used.

A stack walk before looks like this:

  CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc7+ #2
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Call Trace:
   <TASK>
   dump_stack_lvl
   dump_stack
   kernel_exc_vmm_communication
   asm_exc_vmm_communication
   ? native_read_msr
   ? __x2apic_disable.part.0
   ? x2apic_setup
   ? cpu_init
   ? trap_init
   ? start_kernel
   ? x86_64_start_reservations
   ? x86_64_start_kernel
   ? secondary_startup_64_no_verify
   </TASK>

and with the fix, the stack dump is exact:

  CPU: 0 PID: 0 Comm: swapper Not tainted 5.18.0-rc7+ #3
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 0.0.0 02/06/2015
  Call Trace:
   <TASK>
   dump_stack_lvl
   dump_stack
   kernel_exc_vmm_communication
   asm_exc_vmm_communication
  RIP: 0010:native_read_msr
  Code: ...
  < snipped regs >
   ? __x2apic_disable.part.0
   x2apic_setup
   cpu_init
   trap_init
   start_kernel
   x86_64_start_reservations
   x86_64_start_kernel
   secondary_startup_64_no_verify
   </TASK>

  [ bp: Test in a SEV-ES guest and rewrite the commit message to
    explain what exactly this does. ]

Fixes: a13644f3a53d ("x86/entry/64: Add entry code for #VC handler")
Signed-off-by: Lai Jiangshan <jiangshan.ljs@antgroup.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220316041612.71357-1-jiangshanlai@gmail.com
---
 arch/x86/entry/entry_64.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 4faac48..f7bd800 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -505,6 +505,7 @@ SYM_CODE_START(\asmsym)
 	call	vc_switch_off_ist
 	movq	%rax, %rsp		/* Switch to new stack */
 
+	ENCODE_FRAME_POINTER
 	UNWIND_HINT_REGS
 
 	/* Update pt_regs */
