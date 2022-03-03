Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 584ED4CBCB2
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232917AbiCCLe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:34:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232772AbiCCLbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:31:17 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4114517CC5F
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:30:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=PdND8HGIsOPdG5e8FfFN8zhUpvOGMjFSGfPPImo+dI8=; b=jjMOir2mX3nnjb5nac+Vrilp4+
        rqq1C0Eg81B456vS9lKXJPx9Siy2CBaQB5ek/06/a2exXU904p50gnV5cc2WNx7Q/xz0tSp3g/6h7
        LwntQSL0joTCtvcIOwkrgaiN5IYOWD2+GceD66srINpm5vrJKrMzaH8EpjS6O8Alf/ASdr0iUe37V
        UJlOVnq+IrroZkWp5gFZNNRN5X9+5L2Ipfb/2hsFfOkMxd2x2R4/JFP90pc6V55bXDpRBVgIfBv+H
        Hz03FqAcg3QBOMnPfyLTU6Cy8hUbBYeWnA2KlIKytMbS53DZVxZcwb/bZefPDzZ2PM2bJl3qJIR81
        NxeODO6Q==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nPjeh-00Etpc-5s; Thu, 03 Mar 2022 11:29:59 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id F04BA30218C;
        Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 5897830031589; Thu,  3 Mar 2022 12:29:56 +0100 (CET)
Message-ID: <20220303112825.984285515@infradead.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 12:23:38 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org, joao@overdrivepizza.com, hjl.tools@gmail.com,
        jpoimboe@redhat.com, andrew.cooper3@citrix.com
Cc:     linux-kernel@vger.kernel.org, peterz@infradead.org,
        ndesaulniers@google.com, keescook@chromium.org,
        samitolvanen@google.com, mark.rutland@arm.com,
        alyssa.milburn@intel.com, mbenes@suse.cz, rostedt@goodmis.org,
        mhiramat@kernel.org, alexei.starovoitov@gmail.com
Subject: [PATCH v3 17/39] x86/livepatch: Validate __fentry__ location
References: <20220303112321.422525803@infradead.org>
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

Currently livepatch assumes __fentry__ lives at func+0, which is most
likely untrue with IBT on. Instead make it use ftrace_location() by
default which both validates and finds the actual ip if there is any
in the same symbol.

Suggested-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/powerpc/include/asm/livepatch.h |   10 ----------
 kernel/livepatch/patch.c             |   19 ++-----------------
 2 files changed, 2 insertions(+), 27 deletions(-)

--- a/arch/powerpc/include/asm/livepatch.h
+++ b/arch/powerpc/include/asm/livepatch.h
@@ -19,16 +19,6 @@ static inline void klp_arch_set_pc(struc
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
--- a/kernel/livepatch/patch.c
+++ b/kernel/livepatch/patch.c
@@ -124,19 +124,6 @@ static void notrace klp_ftrace_handler(u
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
@@ -153,8 +140,7 @@ static void klp_unpatch_func(struct klp_
 	if (list_is_singular(&ops->func_stack)) {
 		unsigned long ftrace_loc;
 
-		ftrace_loc =
-			klp_get_ftrace_location((unsigned long)func->old_func);
+		ftrace_loc = ftrace_location((unsigned long)func->old_func);
 		if (WARN_ON(!ftrace_loc))
 			return;
 
@@ -186,8 +172,7 @@ static int klp_patch_func(struct klp_fun
 	if (!ops) {
 		unsigned long ftrace_loc;
 
-		ftrace_loc =
-			klp_get_ftrace_location((unsigned long)func->old_func);
+		ftrace_loc = ftrace_location((unsigned long)func->old_func);
 		if (!ftrace_loc) {
 			pr_err("failed to find location for function '%s'\n",
 				func->old_name);


