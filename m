Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B568577252
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbiGPXTr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:19:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233269AbiGPXTM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:19:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D319B2497F
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:18:10 -0700 (PDT)
Message-ID: <20220716230954.711882354@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wIsBjcmnUXYyQorogZuJM115Z5C9SKbZzs0zRjSGzDo=;
        b=BLiqNuZBv5FNCiLedEBNSeLn4iH8ifZyowSQ4gror1C3a7dYWVSAS4ut8j/G+cnLrxf7rN
        ntwUhSqfL/AOIf7JD6tUDrW6LyBp4gzOOifdWW2cbX4nwp3r+F3ZyMZ1oUIoQVTStemwOJ
        Gsbb+fJpW4WTCAiRVc/Pm1l6nI6H48F5HU7UToPiD3GGLCTkMHTQuVNdX8kZ+aaN5cQZ/g
        3HZ44VINy7nvrw8PcmgSdUKdeCqbywzJdm6X/iJZSHACuKh05/UCdkyokHCOvlTewgzrra
        G5CMuMBy/JCV58K9u/zkG6yxrNlCNZWBSZJPOTXa90vjerAgYeAmA2nL3VCBGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=wIsBjcmnUXYyQorogZuJM115Z5C9SKbZzs0zRjSGzDo=;
        b=4IMs+4ayq3xlICKiYVfzxXcMIFK033YDvt6E7HCoBYmgeFbDQF9hE0BKYlrQeVqtwyqxDO
        Hf5d/4QBBeGi0MBw==
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
        Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: [patch 34/38] x86/orc: Make it callthunk aware
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:18:05 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

Callthunks addresses on the stack would confuse the ORC unwinder. Handle
them correctly and tell ORC to proceed further down the stack.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>
---
 arch/x86/include/asm/alternative.h |    5 +++++
 arch/x86/kernel/callthunks.c       |    2 +-
 arch/x86/kernel/unwind_orc.c       |   21 ++++++++++++++++++++-
 3 files changed, 26 insertions(+), 2 deletions(-)

--- a/arch/x86/include/asm/alternative.h
+++ b/arch/x86/include/asm/alternative.h
@@ -94,6 +94,7 @@ extern void callthunks_patch_module_call
 					  struct module *mod);
 extern void callthunks_module_free(struct module *mod);
 extern void *callthunks_translate_call_dest(void *dest);
+extern bool is_callthunk(void *addr);
 #else
 static __always_inline void callthunks_patch_builtin_calls(void) {}
 static __always_inline void
@@ -104,6 +105,10 @@ static __always_inline void *callthunks_
 {
 	return dest;
 }
+static __always_inline bool is_callthunk(void *addr)
+{
+	return false;
+}
 #endif
 
 #ifdef CONFIG_SMP
--- a/arch/x86/kernel/callthunks.c
+++ b/arch/x86/kernel/callthunks.c
@@ -565,7 +565,7 @@ static bool is_module_callthunk(void *ad
 	return ret;
 }
 
-static bool is_callthunk(void *addr)
+bool is_callthunk(void *addr)
 {
 	if (builtin_layout.base <= addr &&
 	    addr < builtin_layout.base + builtin_layout.size)
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -131,6 +131,21 @@ static struct orc_entry null_orc_entry =
 	.type = UNWIND_HINT_TYPE_CALL
 };
 
+#ifdef CONFIG_CALL_THUNKS
+static struct orc_entry *orc_callthunk_find(unsigned long ip)
+{
+	if (!is_callthunk((void *)ip))
+		return NULL;
+
+	return &null_orc_entry;
+}
+#else
+static struct orc_entry *orc_callthunk_find(unsigned long ip)
+{
+	return NULL;
+}
+#endif
+
 /* Fake frame pointer entry -- used as a fallback for generated code */
 static struct orc_entry orc_fp_entry = {
 	.type		= UNWIND_HINT_TYPE_CALL,
@@ -184,7 +199,11 @@ static struct orc_entry *orc_find(unsign
 	if (orc)
 		return orc;
 
-	return orc_ftrace_find(ip);
+	orc =  orc_ftrace_find(ip);
+	if (orc)
+		return orc;
+
+	return orc_callthunk_find(ip);
 }
 
 #ifdef CONFIG_MODULES

