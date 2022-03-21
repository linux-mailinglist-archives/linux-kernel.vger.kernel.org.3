Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FB184E240D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 11:13:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346079AbiCUKPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 06:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233527AbiCUKPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 06:15:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5B217A8D;
        Mon, 21 Mar 2022 03:13:46 -0700 (PDT)
Date:   Mon, 21 Mar 2022 10:13:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647857623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maEO6qQpAi7u5heqqrjNmtA5uDSrr7pnMEyE5j18Q1I=;
        b=ta4fTHJbGfu2KH3h0VJO5R+E3DfsTDG9amu097FAvS8CLGJlZi/NJG6pbv4F2FphNOVb7T
        w/ILKvsZwBfUacPHva1Tj41caOduIdC54ZitoRo9HJx7Tl9EYlc/F+I7DFmg0RDC6Dmzhn
        z1118pRLWET8kBGG27+QGeKh7ywYiXklSwFb0gdS7BwN+V4C5gzulazqSgkBz+1e7Ejaj7
        KAAxWHv2eQVomhHzueB9jAz3Si06r35y7C4cJw7czqBYnS2nSpOhk8dGP2uPqvWjpxO2L5
        eTgNFH4eSPPBFnfEAN2Lu1o9ta5eH0nVnPadMMfEtMNXyeHA9wSb2aaSN92fkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647857623;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=maEO6qQpAi7u5heqqrjNmtA5uDSrr7pnMEyE5j18Q1I=;
        b=UtRcN/jYOpZiM6xj7U5iEv8s5PYp/A/SBbAuUn7DrK/y+WtSUmewPd7APdILaTY46o4Luh
        vcGSH4KBE3GyPwDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] kvm/emulate: Fix SETcc emulation for ENDBR
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YjMVpfe%2f9ldmWX8W@hirez.programming.kicks-ass.net>
References: <YjMVpfe%2f9ldmWX8W@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164785762246.389.15725885705619137355.tip-bot2@tip-bot2>
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

Commit-ID:     44aba1d9e26641728f33f5834f436dd9ef486b96
Gitweb:        https://git.kernel.org/tip/44aba1d9e26641728f33f5834f436dd9ef486b96
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Mar 2022 10:13:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 21 Mar 2022 10:57:52 +01:00

kvm/emulate: Fix SETcc emulation for ENDBR

Companion patch for commit fe83f5eae432 ("kvm/emulate: Fix SETcc
emulation function offsets with SLS"), now extending it to cover the
additional ENDBR instruction.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/YjMVpfe%2f9ldmWX8W@hirez.programming.kicks-ass.net
---
 arch/x86/kvm/emulate.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index d98fb36..df5e6c0 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -24,6 +24,7 @@
 #include <linux/stringify.h>
 #include <asm/debugreg.h>
 #include <asm/nospec-branch.h>
+#include <asm/ibt.h>
 
 #include "x86.h"
 #include "tss.h"
@@ -434,15 +435,16 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 /*
  * Depending on .config the SETcc functions look like:
  *
+ * ENDBR       [4 bytes; CONFIG_X86_KERNEL_IBT]
  * SETcc %al   [3 bytes]
  * RET         [1 byte]
  * INT3        [1 byte; CONFIG_SLS]
  *
- * Which gives possible sizes 4 or 5.  When rounded up to the
- * next power-of-two alignment they become 4 or 8.
+ * Which gives possible sizes 4, 5, 8 or 9.  When rounded up to the
+ * next power-of-two alignment they become 4, 8 or 16 resp.
  */
-#define SETCC_LENGTH	(4 + IS_ENABLED(CONFIG_SLS))
-#define SETCC_ALIGN	(4 << IS_ENABLED(CONFIG_SLS))
+#define SETCC_LENGTH	(ENDBR_INSN_SIZE + 4 + IS_ENABLED(CONFIG_SLS))
+#define SETCC_ALIGN	(4 << IS_ENABLED(CONFIG_SLS) << HAS_KERNEL_IBT)
 static_assert(SETCC_LENGTH <= SETCC_ALIGN);
 
 #define FOP_SETCC(op) \
