Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6F54D29F3
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbiCIH5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:57:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230425AbiCIH41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:27 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA314164D21;
        Tue,  8 Mar 2022 23:55:04 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812503;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfrLJvrzYft2T/XZ3bEwCogezzozBssPIQEQBlmGwaA=;
        b=3QrE67++G6uzzcrGVXdBltfvQsmeBtdEq9au49d5lK4Ss4A9rnWWrOFp9eyWGdM1PpoG16
        MFfHdObv3EhfOYYYd7PXpSHizTxrMAwFoUZEDDe2LSKygEFVy41ds4aJq8WxBVfCPCL+Ly
        22yIrdpv3VhyRFFgEwIe8WNxN6M5O+WHVjZNXDWyKaFadNIwKfXFB+5cqRemrX7bPjh0jb
        OOwcrl7FVbocLlRd+Mepf8ZQA8Nu3zzPMfODuKY7p506Au5aEQSskWunxL0l1JbnmmnOnG
        bfPDEi8RrebO3B2GFbf2mIVBEX21lOoAQa6QcoMmGNOUyuQVwhmVNjWyKcN6jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812503;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfrLJvrzYft2T/XZ3bEwCogezzozBssPIQEQBlmGwaA=;
        b=0Eatodh3DbaDIkRvke/VyB1apXTOQSbOnvL/K/OXvx7WNrQTTZq87talhI2tVX95S8AjNu
        GoxzqmfoTUP50LDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/livepatch: Validate __fentry__ location
Cc:     Josh Poimboeuf <jpoimboe@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.285971256@infradead.org>
References: <20220308154318.285971256@infradead.org>
MIME-Version: 1.0
Message-ID: <164681250198.16921.8901861440480788939.tip-bot2@tip-bot2>
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

Commit-ID:     a557abfd1a16072e4d25bdf226e3b761e6f10741
Gitweb:        https://git.kernel.org/tip/a557abfd1a16072e4d25bdf226e3b761e6f10741
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:31 +01:00

x86/livepatch: Validate __fentry__ location

Currently livepatch assumes __fentry__ lives at func+0, which is most
likely untrue with IBT on. Instead make it use ftrace_location() by
default which both validates and finds the actual ip if there is any
in the same symbol.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.285971256@infradead.org
---
 arch/powerpc/include/asm/livepatch.h | 10 ----------
 kernel/livepatch/patch.c             | 19 ++-----------------
 2 files changed, 2 insertions(+), 27 deletions(-)

diff --git a/arch/powerpc/include/asm/livepatch.h b/arch/powerpc/include/asm/livepatch.h
index 4fe018c..7b9dcd5 100644
--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -19,16 +19,6 @@ static inline void klp_arch_set_pc(struct ftrace_regs *fregs, unsigned long ip)
 	regs_set_return_ip(regs, ip);
 }
 
-#define klp_get_ftrace_location klp_get_ftrace_location
-static inline unsigned long klp_get_ftrace_location(unsigned long faddr)
-{
-	/*
-	 * Live patch works only with -mprofile-kernel on PPC. In this case,
-	 * the ftrace location is always within the first 16 bytes.
-	 */
-	return ftrace_location_range(faddr, faddr + 16);
-}
-
 static inline void klp_init_thread_info(struct task_struct *p)
 {
 	/* + 1 to account for STACK_END_MAGIC */
diff --git a/kernel/livepatch/patch.c b/kernel/livepatch/patch.c
index fe316c0..c172bf9 100644
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -124,19 +124,6 @@ unlock:
 	ftrace_test_recursion_unlock(bit);
 }
 
-/*
- * Convert a function address into the appropriate ftrace location.
- *
- * Usually this is just the address of the function, but on some architectures
- * it's more complicated so allow them to provide a custom behaviour.
- */
-#ifndef klp_get_ftrace_location
-static unsigned long klp_get_ftrace_location(unsigned long faddr)
-{
-	return faddr;
-}
-#endif
-
 static void klp_unpatch_func(struct klp_func *func)
 {
 	struct klp_ops *ops;
@@ -153,8 +140,7 @@ static void klp_unpatch_func(struct klp_func *func)
 	if (list_is_singular(&ops->func_stack)) {
 		unsigned long ftrace_loc;
 
-		ftrace_loc =
-			klp_get_ftrace_location((unsigned long)func->old_func);
+		ftrace_loc = ftrace_location((unsigned long)func->old_func);
 		if (WARN_ON(!ftrace_loc))
 			return;
 
@@ -186,8 +172,7 @@ static int klp_patch_func(struct klp_func *func)
 	if (!ops) {
 		unsigned long ftrace_loc;
 
-		ftrace_loc =
-			klp_get_ftrace_location((unsigned long)func->old_func);
+		ftrace_loc = ftrace_location((unsigned long)func->old_func);
 		if (!ftrace_loc) {
 			pr_err("failed to find location for function '%s'\n",
 				func->old_name);
