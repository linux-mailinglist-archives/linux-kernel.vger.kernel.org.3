Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B4C3577272
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbiGPXRY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232637AbiGPXRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:18 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C4C81AF3D
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:17 -0700 (PDT)
Message-ID: <20220716230952.845576840@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aIQ/Ky4BkhWj1e8pSb5b8EYVCLX1295GSYYZn2MYdwA=;
        b=QuSWrgtgRwGZys91cSn4NGs8TkUNFwNue/6Hjr5kYy5OM9Rg7kxZ8e4V3WKG9K7iLAX4pE
        k2vjjoaM7zG0A7+fm7S/iQPMa7xMSVkklXcl58e0z+2fQG0wdA49DO3Z+5zXdNRKcI0A6m
        sd9eVa26Ne1Lbjj3XGcRpofQNEIeKmij1cTcCMrOgkvyFBlYADe36xounUc8Z1+G6iQjwh
        wWNSFokPU6PWEH3Lobox+Sh+hCtCl5fgsGg93DNYpESy7V0kKoysIU5E7igJwHxoYLA3NN
        ayt+EnbRjVS3G06uifxkAspfooH5unadYyREb3PTtTlqkrLf+J3t6CAkJpTVlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013435;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=aIQ/Ky4BkhWj1e8pSb5b8EYVCLX1295GSYYZn2MYdwA=;
        b=Up8R0aCMnjmqjTKLM5LijbQByYHJVUFiU1yDjTDDBiUqprrZUsKN1Jdlxxh+yp1cn8hsCO
        ldYoZdnSsKL4rYCw==
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
Subject: [patch 03/38] x86/modules: Set VM_FLUSH_RESET_PERMS in module_alloc()
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:14 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of resetting permissions all over the place when freeing module
memory tell the vmalloc code to do so. Avoids the exercise for the next
upcoming user.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/kernel/ftrace.c       |    2 --
 arch/x86/kernel/kprobes/core.c |    1 -
 arch/x86/kernel/module.c       |    9 +++++----
 3 files changed, 5 insertions(+), 7 deletions(-)

--- a/arch/x86/kernel/ftrace.c
+++ b/arch/x86/kernel/ftrace.c
@@ -412,8 +412,6 @@ create_trampoline(struct ftrace_ops *ops
 	/* ALLOC_TRAMP flags lets us know we created it */
 	ops->flags |= FTRACE_OPS_FL_ALLOC_TRAMP;
 
-	set_vm_flush_reset_perms(trampoline);
-
 	if (likely(system_state != SYSTEM_BOOTING))
 		set_memory_ro((unsigned long)trampoline, npages);
 	set_memory_x((unsigned long)trampoline, npages);
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -416,7 +416,6 @@ void *alloc_insn_page(void)
 	if (!page)
 		return NULL;
 
-	set_vm_flush_reset_perms(page);
 	/*
 	 * First make the page read-only, and only then make it executable to
 	 * prevent it from being W+X in between.
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -74,10 +74,11 @@ void *module_alloc(unsigned long size)
 		return NULL;
 
 	p = __vmalloc_node_range(size, MODULE_ALIGN,
-				    MODULES_VADDR + get_module_load_offset(),
-				    MODULES_END, gfp_mask,
-				    PAGE_KERNEL, VM_DEFER_KMEMLEAK, NUMA_NO_NODE,
-				    __builtin_return_address(0));
+				 MODULES_VADDR + get_module_load_offset(),
+				 MODULES_END, gfp_mask, PAGE_KERNEL,
+				 VM_FLUSH_RESET_PERMS | VM_DEFER_KMEMLEAK,
+				 NUMA_NO_NODE, __builtin_return_address(0));
+
 	if (p && (kasan_alloc_module_shadow(p, size, gfp_mask) < 0)) {
 		vfree(p);
 		return NULL;

