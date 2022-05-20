Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857B752EA6A
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 13:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348307AbiETLAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 07:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235945AbiETLAv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 07:00:51 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D34DDB7CA;
        Fri, 20 May 2022 04:00:49 -0700 (PDT)
Date:   Fri, 20 May 2022 11:00:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1653044448;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfHvb3fruLU2Rg+3l/c/ckZU21HNHw7WDZW9HPhwKk0=;
        b=Dg3al9neC57Puv7RlGzOlDLp6OBN9jS/QlsLJSmyYVhYnCDYAwJWAaEzVLvM1tkTFUFXOt
        ZzzzW0YI9YrG2l+SUtvw+WfiaZhdWZQ1DWzG0fOqUQw673EqTNv0cVVzHLt1vwFWxlFsCr
        fl1FqYwGxM7KxSxmSm9BPmIZ+K7QLoLeW+uBd5kQb1J+6BOeExD37eSV3GBNlxD0CqeYNf
        kLTUIA3VHbJ37Me4nUKMJDqLxFh0/n2bXh6apnQsMtmU18+lVinu45y3mnKqEvVzU6IZfI
        yXrow1YpEFbJwkSVmDOo4BptUfjqelpQJRoLCN21BqGyfPlSl3vHEHhbVxpokQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1653044448;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OfHvb3fruLU2Rg+3l/c/ckZU21HNHw7WDZW9HPhwKk0=;
        b=YAxvw4U6dlfDaGOaoYObAEL0yq8lLnf72uhg5gz7rkN5qlTzbsqSvXL1CA6e68UCIrzXXp
        m06UmvTiQzB5SzCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Fix RETs in TDX asm
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220520083839.GR2578@worktop.programming.kicks-ass.net>
References: <20220520083839.GR2578@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <165304444691.4207.14334435844427241995.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     c796f02162e428b595ff70196dca161ee46b163b
Gitweb:        https://git.kernel.org/tip/c796f02162e428b595ff70196dca161ee46b163b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 20 May 2022 10:38:39 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 20 May 2022 12:53:22 +02:00

x86/tdx: Fix RETs in TDX asm

Because build-testing is over-rated, fix a few trivial objtool complaints:

  vmlinux.o: warning: objtool: __tdx_module_call+0x3e: missing int3 after ret
  vmlinux.o: warning: objtool: __tdx_hypercall+0x6e: missing int3 after ret

Fixes: eb94f1b6a70a ("x86/tdx: Add __tdx_module_call() and __tdx_hypercall() helper functions")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lore.kernel.org/r/20220520083839.GR2578@worktop.programming.kicks-ass.net
---
 arch/x86/coco/tdx/tdcall.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/coco/tdx/tdcall.S b/arch/x86/coco/tdx/tdcall.S
index eeb4511..f9eb113 100644
--- a/arch/x86/coco/tdx/tdcall.S
+++ b/arch/x86/coco/tdx/tdcall.S
@@ -73,7 +73,7 @@ SYM_FUNC_START(__tdx_module_call)
 	FRAME_BEGIN
 	TDX_MODULE_CALL host=0
 	FRAME_END
-	ret
+	RET
 SYM_FUNC_END(__tdx_module_call)
 
 /*
@@ -196,7 +196,7 @@ SYM_FUNC_START(__tdx_hypercall)
 
 	FRAME_END
 
-	retq
+	RET
 .Lpanic:
 	call __tdx_hypercall_failed
 	/* __tdx_hypercall_failed never returns */
