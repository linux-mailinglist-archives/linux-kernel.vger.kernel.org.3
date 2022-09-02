Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7A4A5AB37A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 16:29:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236382AbiIBO3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 10:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236462AbiIBO11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 10:27:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB37313F0A8
        for <linux-kernel@vger.kernel.org>; Fri,  2 Sep 2022 06:54:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=l7GhXBSYIn8Kq/LEBL5LqWkTVx56PKiEeOdm0uGjDBU=; b=DYSB8cS0PAYxsV9meJmvbwfRMI
        sZsFWjenDxeGk6NtFpDE+12Fuxvfm/sgJ5zXTki3CkxEYIVMTYHULRMhYfHdlysn62fyxUhwriIrp
        0+AAUHmM1rwubUq+5G2ibbUtniZBUCmq1BLazjKGRyQaP1hRsanM3F5JV+ZFhXlM8Tb5kcMHTrLbH
        v6SUNo+vKdPjxLexeNSEyezr3TzuYKZD8Zv1iwHcaxVsG9z70dmNSfU30X0IRk7aWaInSG0TV1AHg
        BG+FcCnq0LBs1Rx1N3v+ouxJdy7sWgw7s05GNae34KJCEl3kE1F3zCNcXu7l9x3ViLsYzqkNo9AmG
        fQKGWHjw==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oU77P-0074V0-Mz; Fri, 02 Sep 2022 13:53:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3C950302D57;
        Fri,  2 Sep 2022 15:53:54 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 4D6462B8EFB52; Fri,  2 Sep 2022 15:53:53 +0200 (CEST)
Message-ID: <20220902130950.826439931@infradead.org>
User-Agent: quilt/0.66
Date:   Fri, 02 Sep 2022 15:07:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org, x86@kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Juergen Gross <jgross@suse.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Eric Dumazet <edumazet@google.com>
Subject: [PATCH v2 43/59] x86/paravirt: Make struct paravirt_call_site unconditionally available
References: <20220902130625.217071627@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For the upcoming call thunk patching it's less ifdeffery when the data
structure is unconditionally available. The code can then be trivially
fenced off with IS_ENABLED().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/paravirt.h       |    4 ++--
 arch/x86/include/asm/paravirt_types.h |   20 ++++++++++++--------
 2 files changed, 14 insertions(+), 10 deletions(-)

--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -4,13 +4,13 @@
 /* Various instructions on x86 need to be replaced for
  * para-virtualization: those hooks are defined here. */
 
+#include <asm/paravirt_types.h>
+
 #ifdef CONFIG_PARAVIRT
 #include <asm/pgtable_types.h>
 #include <asm/asm.h>
 #include <asm/nospec-branch.h>
 
-#include <asm/paravirt_types.h>
-
 #ifndef __ASSEMBLY__
 #include <linux/bug.h>
 #include <linux/types.h>
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -2,6 +2,17 @@
 #ifndef _ASM_X86_PARAVIRT_TYPES_H
 #define _ASM_X86_PARAVIRT_TYPES_H
 
+#ifndef __ASSEMBLY__
+/* These all sit in the .parainstructions section to tell us what to patch. */
+struct paravirt_patch_site {
+	u8 *instr;		/* original instructions */
+	u8 type;		/* type of this instruction */
+	u8 len;			/* length of original instruction */
+};
+#endif
+
+#ifdef CONFIG_PARAVIRT
+
 /* Bitmask of what can be clobbered: usually at least eax. */
 #define CLBR_EAX  (1 << 0)
 #define CLBR_ECX  (1 << 1)
@@ -584,16 +595,9 @@ unsigned long paravirt_ret0(void);
 
 #define paravirt_nop	((void *)_paravirt_nop)
 
-/* These all sit in the .parainstructions section to tell us what to patch. */
-struct paravirt_patch_site {
-	u8 *instr;		/* original instructions */
-	u8 type;		/* type of this instruction */
-	u8 len;			/* length of original instruction */
-};
-
 extern struct paravirt_patch_site __parainstructions[],
 	__parainstructions_end[];
 
 #endif	/* __ASSEMBLY__ */
-
+#endif  /* CONFIG_PARAVIRT */
 #endif	/* _ASM_X86_PARAVIRT_TYPES_H */


