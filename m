Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4881C599B33
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 13:44:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348372AbiHSLf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 07:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348356AbiHSLfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 07:35:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD911EE6AB;
        Fri, 19 Aug 2022 04:35:15 -0700 (PDT)
Date:   Fri, 19 Aug 2022 11:35:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660908913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HlgrzbRgO5QbCh1s2FsAdqcJJf8Kvt1iCRpBZfb4Kh0=;
        b=tb5Tz/uhVosQPqH3PRSifQ5NfQXIjzyYNtHa9ISZ8akzumvo+TwHwOeQucUrHQ9nyBCMq2
        Aoe23GuV7zAbYBxu/es7Xz/G0qJ63adr23xw9qF1JLUMEcv+b0hGSKqlhCL9bFLqR+aMI1
        ZrR5dwCxpb7JnaWGaUWnEnU9wRGa4t3ysx9b/EaQoRSgXhyCYTgX0aq4nUaMjpEVyfb7K5
        OLvPU542N+obqKfRebQ2DI75ebnr3QxC2jYKFPYKlvoPHiQb1uZ11sHHnkrtABZjbTNZRT
        B2gs1Wf7zb8nZAanpdMx2KXsqglfRD5z5WrEbof9cYVxHw/3uMLRam1a3qwFlQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660908913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HlgrzbRgO5QbCh1s2FsAdqcJJf8Kvt1iCRpBZfb4Kh0=;
        b=+uc66jPYLguVKX8rl4JJnH4U8N6sqpMQRGdX4gpk2G4IMx99/ahFA1jlipvNgLPMXmsUDW
        FsSd0LcgprvuSRCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/nospec: Fix i386 RSB stuffing
Cc:     Ben Hutchings <ben@decadent.org.uk>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <Yv9tj9vbQ9nNlXoY@worktop.programming.kicks-ass.net>
References: <Yv9tj9vbQ9nNlXoY@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166090891198.401.13023020009492616640.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     332924973725e8cdcc783c175f68cf7e162cb9e5
Gitweb:        https://git.kernel.org/tip/332924973725e8cdcc783c175f68cf7e162cb9e5
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 19 Aug 2022 13:01:35 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Aug 2022 13:24:33 +02:00

x86/nospec: Fix i386 RSB stuffing

Turns out that i386 doesn't unconditionally have LFENCE, as such the
loop in __FILL_RETURN_BUFFER isn't actually speculation safe on such
chips.

Fixes: ba6e31af2be9 ("x86/speculation: Add LFENCE to RSB fill sequence")
Reported-by: Ben Hutchings <ben@decadent.org.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/Yv9tj9vbQ9nNlXoY@worktop.programming.kicks-ass.net
---
 arch/x86/include/asm/nospec-branch.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index 10731cc..c936ce9 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -50,6 +50,7 @@
  * the optimal version - two calls, each with their own speculation
  * trap should their return address end up getting used, in a loop.
  */
+#ifdef CONFIG_X86_64
 #define __FILL_RETURN_BUFFER(reg, nr)			\
 	mov	$(nr/2), reg;				\
 771:							\
@@ -60,6 +61,17 @@
 	jnz	771b;					\
 	/* barrier for jnz misprediction */		\
 	lfence;
+#else
+/*
+ * i386 doesn't unconditionally have LFENCE, as such it can't
+ * do a loop.
+ */
+#define __FILL_RETURN_BUFFER(reg, nr)			\
+	.rept nr;					\
+	__FILL_RETURN_SLOT;				\
+	.endr;						\
+	add	$(BITS_PER_LONG/8) * nr, %_ASM_SP;
+#endif
 
 /*
  * Stuff a single RSB slot.
