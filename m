Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FEE4D991D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:44:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347294AbiCOKpc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347242AbiCOKpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:04 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C85F631DC3;
        Tue, 15 Mar 2022 03:43:47 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:43:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/uE7zHtGF9SP+uZXK94K1rTk6/h7IpJJiiUrAN80hM=;
        b=P++hSYvKBNuAVxsCUiF5aMVkrDu2uKFKNnkp9GQbbg7BprcrIY3Ez4X5/A7OKoMZ9b6GnU
        7NxRn/siicVxl/ydBS1wwWr5uB+fH80/L+etBlQiv+sGC2dgv2vziDS5XgPoxwliR8W6OW
        UKoNyS+IxadjxVkxzXF70PcxE+TejSknTbKDmKfsyji7CAFyDpseQ4aiNRMZ5EB7O8wQci
        XS3qHxfTFxtXfv9VR++oSobh1WfkQoDWvJtpWEWfbeb8X6+aM1dN7u8OMQlo+hvL4TNRrJ
        xN2HDMDtQ04dMWgifaCb+vjJjyEGMak+bi9N/viIsY28546Ux24av6ek04NfSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341026;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/uE7zHtGF9SP+uZXK94K1rTk6/h7IpJJiiUrAN80hM=;
        b=y1xQ57Sno+w0QhQKhY5eiCti73IRalKkXqTlkdNwleQajNvz7JgHL682/iHP/V4rDypWdF
        HIxsPpnxVa23T5Ag==
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
Message-ID: <164734102547.16921.14808462223133394899.tip-bot2@tip-bot2>
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

Commit-ID:     be0075951fde739f14ee2b659e2fd6e2499c46c0
Gitweb:        https://git.kernel.org/tip/be0075951fde739f14ee2b659e2fd6e2499c46c0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:44 +01:00

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
