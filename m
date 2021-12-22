Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D262B47CEE0
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 10:11:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243740AbhLVJKh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 04:10:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243700AbhLVJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 04:10:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47FFAC06173F;
        Wed, 22 Dec 2021 01:10:35 -0800 (PST)
Date:   Wed, 22 Dec 2021 09:10:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1640164232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIS67eOsyZbs7fLM7ezeiuDsHR8D8TOaFfw3jAdCzB0=;
        b=0WrubRhBtKWrcrT4t2Q9Jd9yIysK2CF+qbiR2EUXqflAj6IszCQMuWN8r/sMs9xjxiu5de
        xy3IjbH21JASRynLRIXdLZugnBv2QjQSvfQaFSL/r5dSx6DQmnPCoX3/RuHCIF0pqHqY00
        zDhyffbXINLabJ33ScQdv8yBS15+ozIyuwx/2kB/KRrw3XhOiG4zrnNFD7jg9EgAJyK1s4
        bKDPIEOKMyb2h21xrvrOboZejbR4SkliUBsIXeWd+3wjW+6B4goYVmMyu3QoAcIhxxAc5p
        L4ineQVfqQxuf6q47orGrOVKeWN9XTJXA7D6z6m82I1al5qBfdmz6MNfuoKAzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1640164232;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CIS67eOsyZbs7fLM7ezeiuDsHR8D8TOaFfw3jAdCzB0=;
        b=LOi7MG5xKvyoYuQ5yEmAhdroRzJZiooz7OScRXsJDlt0RauEjZ2JIaXXAnjBViQ5hkK/7H
        kYXUegN4WvyIscCw==
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] compiler.h: Fix annotation macro misplacement
 with Clang
Cc:     kernel test robot <lkp@intel.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Miroslav Benes <mbenes@suse.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <0417e96909b97a406323409210de7bf13df0b170.1636410380.git.jpoimboe@redhat.com>
References: <0417e96909b97a406323409210de7bf13df0b170.1636410380.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <164016423099.16921.16996655982787145621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     dcce50e6cc4d86a63dc0a9a6ee7d4f948ccd53a1
Gitweb:        https://git.kernel.org/tip/dcce50e6cc4d86a63dc0a9a6ee7d4f948ccd53a1
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Mon, 08 Nov 2021 14:35:59 -08:00
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Tue, 21 Dec 2021 15:09:46 -08:00

compiler.h: Fix annotation macro misplacement with Clang

When building with Clang and CONFIG_TRACE_BRANCH_PROFILING, there are a
lot of unreachable warnings, like:

  arch/x86/kernel/traps.o: warning: objtool: handle_xfd_event()+0x134: unreachable instruction

Without an input to the inline asm, 'volatile' is ignored for some
reason and Clang feels free to move the reachable() annotation away from
its intended location.

Fix that by re-adding the counter value to the inputs.

Fixes: f1069a8756b9 ("compiler.h: Avoid using inline asm operand modifiers")
Fixes: c199f64ff93c ("instrumentation.h: Avoid using inline asm operand modifiers")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/0417e96909b97a406323409210de7bf13df0b170.1636410380.git.jpoimboe@redhat.com
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: x86@kernel.org
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Miroslav Benes <mbenes@suse.cz>
---
 include/linux/compiler.h        | 4 ++--
 include/linux/instrumentation.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/linux/compiler.h b/include/linux/compiler.h
index 3d5af56..429dceb 100644
--- a/include/linux/compiler.h
+++ b/include/linux/compiler.h
@@ -121,7 +121,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.reachable\n\t"		\
 		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define annotate_reachable() __annotate_reachable(__COUNTER__)
 
@@ -129,7 +129,7 @@ void ftrace_likely_update(struct ftrace_likely_data *f, int val,
 	asm volatile(__stringify_label(c) ":\n\t"			\
 		     ".pushsection .discard.unreachable\n\t"		\
 		     ".long " __stringify_label(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define annotate_unreachable() __annotate_unreachable(__COUNTER__)
 
diff --git a/include/linux/instrumentation.h b/include/linux/instrumentation.h
index fa2cd8c..24359b4 100644
--- a/include/linux/instrumentation.h
+++ b/include/linux/instrumentation.h
@@ -11,7 +11,7 @@
 	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_begin\n\t"		\
 		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define instrumentation_begin() __instrumentation_begin(__COUNTER__)
 
@@ -50,7 +50,7 @@
 	asm volatile(__stringify(c) ": nop\n\t"				\
 		     ".pushsection .discard.instr_end\n\t"		\
 		     ".long " __stringify(c) "b - .\n\t"		\
-		     ".popsection\n\t");				\
+		     ".popsection\n\t" : : "i" (c));			\
 })
 #define instrumentation_end() __instrumentation_end(__COUNTER__)
 #else
