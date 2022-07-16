Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB9F557725E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Jul 2022 01:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbiGPXSD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 19:18:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbiGPXRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 19:17:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D6423174
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 16:17:32 -0700 (PDT)
Message-ID: <20220716230953.385846695@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1658013449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HpmwuGNovGo47P809SY+5iM/RPE9nY5KEl2jrra4VzI=;
        b=skFOje2PrLR0pdzlqKwbqANdn8WzvZLOy8Phznr0Jo/t1Bocx31+VVWh9hN5dFsEpuXdff
        BCapJFj4JPfdDoKHCGo7zOrSX3qnMQLA1r+6B9M3+747uP1Q6e5cOVQDura2n1qjQSL8WP
        1L9QwUyy2E0Q6hG+r9FAprnCBPyzSSkQ/E+LulTvNYhjBPwCEcA89Coh7DnKaUrcug6K3f
        0i85XosdVhbFsSm0jAaV/DaQXER+fJJP3XqXfUTRN10eoBQvH96Dxoscm/CIlEA9YSX68/
        5dMqn6cgcmHOxGA5x2KvOhEsX4AntonvlOTfx3hYt0J4gtINm3xGXBq0wENGzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1658013449;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=HpmwuGNovGo47P809SY+5iM/RPE9nY5KEl2jrra4VzI=;
        b=Y6ouY3ChRBWW4VLRhuyDj7T4uHASNMiMDjeRWDOZ05p/XoU+ZQBP6Z08vCEW75PuhBQ1mD
        rTjeAuMs85bj3TCg==
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
Subject: [patch 12/38] x86/entry: Make sync_regs() invocation a tail call
References: <20220716230344.239749011@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sun, 17 Jul 2022 01:17:29 +0200 (CEST)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Zijlstra <peterz@infradead.org>

No point in having a call there. Spare the call/ret overhead.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/x86/entry/entry_64.S |    7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -1060,11 +1060,8 @@ SYM_CODE_START_LOCAL(error_entry)
 	UNTRAIN_RET
 
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
-.Lerror_entry_from_usermode_after_swapgs:
-
 	/* Put us onto the real thread stack. */
-	call	sync_regs
-	RET
+	jmp	sync_regs
 
 	/*
 	 * There are two places in the kernel that can potentially fault with
@@ -1122,7 +1119,7 @@ SYM_CODE_START_LOCAL(error_entry)
 	leaq	8(%rsp), %rdi			/* arg0 = pt_regs pointer */
 	call	fixup_bad_iret
 	mov	%rax, %rdi
-	jmp	.Lerror_entry_from_usermode_after_swapgs
+	jmp	sync_regs
 SYM_CODE_END(error_entry)
 
 SYM_CODE_START_LOCAL(error_return)

