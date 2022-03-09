Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8344D29D4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiCIHzz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:55:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230054AbiCIHzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ABC715E6D7;
        Tue,  8 Mar 2022 23:54:47 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BprdItZ3kmJ5P67amXImIPKk9q58q2OOtLSEsUh47Y=;
        b=fPr4tN7uTh0Z/XAoUnAhcA1kY5dP5LAdCrmaZyvKdfuLSROi9PQsVv8fFelMv0QmSPJXOv
        uMmCu/wRC+ynLed2XRWdhQAyY3oG39pag7ZJFunTh4eiY9oVv/EoelT9Mf8SyxtL+o6AE7
        5MBnQzAPo5UAFy5Y3/d6oBO3YU66RgyhiJmzQgupTHakZMPibmKa/Riq/ut3gqyegDf5XT
        B1dzd2ytGkgrW0AA1F4t3sHxroz3V3v9e3q8sCAT2Ju/aNlMnkWxKD/HmgRVG1n4bgdNIJ
        US25xyPVxdkvAhN6sP6fTEdafAWrp2/P3eayZtOBFYBQcW/YhF6ccQthhu6ftA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2BprdItZ3kmJ5P67amXImIPKk9q58q2OOtLSEsUh47Y=;
        b=k4Q1sFGs6L7kFSTZ5oLgMUVFfhTiiOiqvkj42Eyud7Ry0MD76mm1kas46zIClCEQQulGvx
        nk7OZzJGADhPiWAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86: Annotate call_on_stack()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.468805622@infradead.org>
References: <20220308154319.468805622@infradead.org>
MIME-Version: 1.0
Message-ID: <164681248483.16921.9605178775958046023.tip-bot2@tip-bot2>
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

Commit-ID:     2170221418e44b3c3d0171194915156db31aebc1
Gitweb:        https://git.kernel.org/tip/2170221418e44b3c3d0171194915156db31aebc1
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:37 +01:00

x86: Annotate call_on_stack()

vmlinux.o: warning: objtool: page_fault_oops()+0x13c: unreachable instruction

0000 000000000005b460 <page_fault_oops>:
...
0128    5b588:  49 89 23                mov    %rsp,(%r11)
012b    5b58b:  4c 89 dc                mov    %r11,%rsp
012e    5b58e:  4c 89 f2                mov    %r14,%rdx
0131    5b591:  48 89 ee                mov    %rbp,%rsi
0134    5b594:  4c 89 e7                mov    %r12,%rdi
0137    5b597:  e8 00 00 00 00          call   5b59c <page_fault_oops+0x13c>    5b598: R_X86_64_PLT32   handle_stack_overflow-0x4
013c    5b59c:  5c                      pop    %rsp

vmlinux.o: warning: objtool: sysvec_reboot()+0x6d: unreachable instruction

0000 00000000000033f0 <sysvec_reboot>:
...
005d     344d:  4c 89 dc                mov    %r11,%rsp
0060     3450:  e8 00 00 00 00          call   3455 <sysvec_reboot+0x65>        3451: R_X86_64_PLT32    irq_enter_rcu-0x4
0065     3455:  48 89 ef                mov    %rbp,%rdi
0068     3458:  e8 00 00 00 00          call   345d <sysvec_reboot+0x6d>        3459: R_X86_64_PC32     .text+0x47d0c
006d     345d:  e8 00 00 00 00          call   3462 <sysvec_reboot+0x72>        345e: R_X86_64_PLT32    irq_exit_rcu-0x4
0072     3462:  5c                      pop    %rsp

Both cases are due to a call_on_stack() calling a __noreturn function.
Since that's an inline asm, GCC can't do anything about the
instructions after the CALL. Therefore put in an explicit
ASM_REACHABLE annotation to make sure objtool and gcc are consistently
confused about control flow.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.468805622@infradead.org
---
 arch/x86/include/asm/irq_stack.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/irq_stack.h b/arch/x86/include/asm/irq_stack.h
index ae9d40f..05af249 100644
--- a/arch/x86/include/asm/irq_stack.h
+++ b/arch/x86/include/asm/irq_stack.h
@@ -99,7 +99,8 @@
 }
 
 #define ASM_CALL_ARG0							\
-	"call %P[__func]				\n"
+	"call %P[__func]				\n"		\
+	ASM_REACHABLE
 
 #define ASM_CALL_ARG1							\
 	"movq	%[arg1], %%rdi				\n"		\
