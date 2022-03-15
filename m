Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCEEA4D9959
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 11:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347543AbiCOKrX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 06:47:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347355AbiCOKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 06:45:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A7FE38DB5;
        Tue, 15 Mar 2022 03:44:06 -0700 (PDT)
Date:   Tue, 15 Mar 2022 10:44:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647341045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDxnoEwSJdUBAuCl6pKANTu+4UNlhmz5gOJnEwqgL78=;
        b=awKSd/OpWb4Ou2hYPKPCS1/4zig6aOPCodEgSF7gvnW6jxx+k1yctPXJgpD5Ja3ZrHd3nA
        xrI1N7Ndi+zTojzz3MP1TUqekUkDg/uMZHiW4oyuUz7vDJAeqqSxy4bmiirSPaiiq0yfPy
        Osv+avZhwaVSrrWk3ykfO7xLqxlGAIjeW+iMVzBeqCytjAB/LZCJOpUySfaewtMjI1lfCi
        vsNCStG6vJQBCB1k6o5Y9x/HyxOzolCo9QWmWXSUZWbE0LpRHp81HntsJkjM8aOBb5/9WL
        6LhnDeQv+YuxMcHeQWwA0WbL8E6FwVVtjbiBY46vjrUYcI8rXATWdJXRjEK/Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647341045;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cDxnoEwSJdUBAuCl6pKANTu+4UNlhmz5gOJnEwqgL78=;
        b=y01MUrG4U4PMfR2GFnL7o6ewlOyfP1wVrFfvEr/x8tLnzx1HwmlxJOS7h1jqkcP9Iaqfe+
        k79gsTt2vEnmwPBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt,kvm: Add ENDBR to fastops
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154318.168850084@infradead.org>
References: <20220308154318.168850084@infradead.org>
MIME-Version: 1.0
Message-ID: <164734104415.16921.14212352071856390001.tip-bot2@tip-bot2>
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

Commit-ID:     6649fa876da4c505548b8e8945a6fc48e62e427c
Gitweb:        https://git.kernel.org/tip/6649fa876da4c505548b8e8945a6fc48e62e427c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 15 Mar 2022 10:32:37 +01:00

x86/ibt,kvm: Add ENDBR to fastops

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154318.168850084@infradead.org
---
 arch/x86/kvm/emulate.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/emulate.c b/arch/x86/kvm/emulate.c
index 5719d8c..08c4e9c 100644
--- a/arch/x86/kvm/emulate.c
+++ b/arch/x86/kvm/emulate.c
@@ -189,7 +189,7 @@
 #define X16(x...) X8(x), X8(x)
 
 #define NR_FASTOP (ilog2(sizeof(ulong)) + 1)
-#define FASTOP_SIZE 8
+#define FASTOP_SIZE (8 * (1 + HAS_KERNEL_IBT))
 
 struct opcode {
 	u64 flags;
@@ -311,7 +311,8 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 #define __FOP_FUNC(name) \
 	".align " __stringify(FASTOP_SIZE) " \n\t" \
 	".type " name ", @function \n\t" \
-	name ":\n\t"
+	name ":\n\t" \
+	ASM_ENDBR
 
 #define FOP_FUNC(name) \
 	__FOP_FUNC(#name)
@@ -433,6 +434,7 @@ static int fastop(struct x86_emulate_ctxt *ctxt, fastop_t fop);
 	".align 4 \n\t" \
 	".type " #op ", @function \n\t" \
 	#op ": \n\t" \
+	ASM_ENDBR \
 	#op " %al \n\t" \
 	__FOP_RET(#op)
 
