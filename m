Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61C1C4D29E6
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiCIH5S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:57:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230509AbiCIH42 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:56:28 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FE3164D3A;
        Tue,  8 Mar 2022 23:55:05 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:55:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812504;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hssnMil8EA8/AkoAtXfbVyTfq0CygciXhtiWvAcGihQ=;
        b=CRBAUgkaWxhSFYlpII/QJeSLt667ZJEW8oRI8CzArANZWmkja2LWfAPe4MklrwO4XYXvP/
        JDms4KsgNgANIdbtZUOZEU1eTAnFK92KzSUZvuphlTwN5ti2fnzrYdyA7ly6IMbshgOW0i
        yELjdY6W6jB0cIPUb6tk91++mt3uB8dwb9KCC3UIZlXEp+ihORBjIPfnqpd5GU8tFIhPwe
        76DjrHmSvpcEna2GWzGVVuLKWhPsAEQ0890cIMf4WJMaJnyVOO4yXQE47SZ9fg9HL4/xm9
        4qh7Zi+9vd5ol76UCH2DI9LT75LWWboEpFPkoy4n4TVcgnp/keLS/XVW3mWcSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812504;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hssnMil8EA8/AkoAtXfbVyTfq0CygciXhtiWvAcGihQ=;
        b=U8N50WpoJufi1/A8gFFQHP6c4PH9IBrtKe/EfdA/lBBq/Hj8rUDnUE4bIyKpmBe/ntvACv
        U+Tw2DPONRJZ12Bw==
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
Message-ID: <164681250354.16921.10239828603069597736.tip-bot2@tip-bot2>
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

Commit-ID:     598b53d261c1f9aeedc375a66e5e77ef952bb857
Gitweb:        https://git.kernel.org/tip/598b53d261c1f9aeedc375a66e5e77ef952bb857
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:31 +01:00

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
 
