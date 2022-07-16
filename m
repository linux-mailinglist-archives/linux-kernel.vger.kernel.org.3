Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBBBF577244
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232987AbiGPXSz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbiGPXSC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:18:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9762523BF1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:49 -0700 (PDT)
Message-ID: <20220716230953.977047812@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oPPu+jFTcgeESCfOqjttTTcYWEzNGD5UiaAKckbHmr0=;
        b=pIV9Yx9mr7gx9fADTXXrnpkLGro7vX+pdJsuS/V4ImbfKmT/4IYDH0nMKD8EQsr3cyWByN
        nbGSlcu2S3JV7Z9Z2xq3EV16WiBKO9Tj0qT0hYqqQIgXLbSSqwFEf1JMiCUYBwB+v09Agr
        53N6Kd094/Jw555/M/KAfP3BvkwaZUjq4mz4Q/fn+WrJnco8EMfMvHaNrOdlGMQeSDeXh2
        oeZT4TUSAK9FYJ5093NRAMLHCf3v2toOlpQ54hC+Mp6IJXotQKHpcr4gHXXlS2qHAxoux1
        EquiMkZ6DX8Xty2zX2YUXONfRy2JSatfpKmKpFqN7wduwZzNMrTQWWkTeJ3jmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013465;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=oPPu+jFTcgeESCfOqjttTTcYWEzNGD5UiaAKckbHmr0=;
        b=i/kNQGMQ1jH4nLjWWcOmPYC1HlRpD49P2EDwpgi0S2rlHT5JqmIlI5vVNR90A33ob7uFrq
        gVpEgyyvvchGY+Bw==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Linus Torvalds <torvalds@linux-foundation.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Andrew Cooper <Andrew.Cooper3@citrix.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Johannes Wikner <kwikner@ethz.ch>,
        Alyssa Milburn <alyssa.milburn@linux.intel.com>,
        Jann Horn <jannh@google.com>, "H.J. Lu" <hjl.tools@gmail.com>,
        Joao Moreira <joao.moreira@intel.com>,
        Joseph Nuzman <joseph.nuzman@intel.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: [patch 22/38] x86/paravirt: Make struct paravirt_call_site
 unconditionally available
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:45 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

For the upcoming call thunk patching it's less ifdeffery when the data
structure is unconditionally available. The code can then be trivially
fenced off with IS_ENABLED().

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
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

