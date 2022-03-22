Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5B54E476A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 21:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233375AbiCVUZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 16:25:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiCVUZd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 16:25:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0B513D03;
        Tue, 22 Mar 2022 13:24:02 -0700 (PDT)
Date:   Tue, 22 Mar 2022 20:23:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647980639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FpHf3J0IndPvb6SXBQNlzJ+ROW8V9+wZlTmcC3yDDs4=;
        b=opHOCMceNZhVJGDsTfLP8xSrg6gxG88cM/NW9jmzVb1pmfEQ1/qMTCSLsJpeKvue0Wgyqw
        R4KehqIV2YIeiDG5oRkzOd4kpqTt00iECzUU9LrEjRddpOCo9w0qxbjRWCdgKBSUzLs8s1
        8vfzL8XHMoS6NkjrvSMzJx5j6mRLgLzz0X+hDVBpiPfVaU/KAcTBqJ/KXaVxHQOVuqaS4L
        b6AyQwUjVsnja0PdcSKzkSDZvj4JsMndEoJHR+3RADUdiPyLW2AEd+4ouiGit3Nm6Ulmee
        rKk2K5J8oM9miMcRrr1NhdUGDyRdpXWluBc/eZyQC9BKd/lZUgkwXyYk0Iq63g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647980639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FpHf3J0IndPvb6SXBQNlzJ+ROW8V9+wZlTmcC3yDDs4=;
        b=4qfXszj1baf3oHysagXadL4NXyMaV9VaZb/xJRl4aXBXMg9F5YYcnAb577GJRR1wwvaUgo
        F4SxYL6bYlkMREDg==
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
Message-ID: <164798063843.389.2521199357883501962.tip-bot2@tip-bot2>
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

Commit-ID:     3986f65d4f408ce9d0a361e3226a3246a5fb701c
Gitweb:        https://git.kernel.org/tip/3986f65d4f408ce9d0a361e3226a3246a5fb701c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 21 Mar 2022 10:13:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Mar 2022 21:12:14 +01:00

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
