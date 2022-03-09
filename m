Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C20C4D29FC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiCIH4Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbiCIHzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 593C7163D4A;
        Tue,  8 Mar 2022 23:54:53 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfTwuO7ECRsd3YBf6kg42KEAoua9Im/BCMnJrIbPZmA=;
        b=SNvGZpGJj3oNZXuFPLCY0nlrAORwfa+fgSJZQAZKCgBOSUlSPjtlob2+C78E9cRdhHTYjE
        Wr49A4f9PdjQi4mOwLONu6sCXsR0h0uZBr/QIhEyvcSMc90kPQEa6vwwegs43yLT70Dh2J
        6NEgTgyVZE4IXOhX4Uy0laquMdT3Zkzcc9f2CJb+HFx/qKQ7c7Tve2HeCppq7VX7FXKinb
        Aqz7xnyBC079CpHKjNfMQsxvLudYJaGtGJiSfIf189t/GGQQGHvgTTBGMTPJAsg9xOfY2h
        05Scvep6/Wa+bWP0faDib2g87mJarX2mLOQzjxTJuGt/ehOfjP7OLwkbJlvfYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812491;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QfTwuO7ECRsd3YBf6kg42KEAoua9Im/BCMnJrIbPZmA=;
        b=6O2Ga5cGJeRflDbiqIeXOodLjLT3T0MvCYitej54gV827E5vfhKY0p0EMTqOuz70Q+m6lx
        /u8V98ux6G3S0uDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Ensure module init/exit points have references
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.113767246@infradead.org>
References: <20220308154319.113767246@infradead.org>
MIME-Version: 1.0
Message-ID: <164681249077.16921.5647676019273356420.tip-bot2@tip-bot2>
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

Commit-ID:     43d8f5801147a9d3998261d491e2d9a3de6e05eb
Gitweb:        https://git.kernel.org/tip/43d8f5801147a9d3998261d491e2d9a3de6e05eb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:44 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:35 +01:00

x86/ibt: Ensure module init/exit points have references

Since the references to the module init/exit points only have external
references, a module LTO run will consider them 'unused' and seal
them, leading to an immediate fail on module load.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.113767246@infradead.org
---
 include/linux/cfi.h | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/cfi.h b/include/linux/cfi.h
index 879744a..c6dfc1e 100644
--- a/include/linux/cfi.h
+++ b/include/linux/cfi.h
@@ -34,8 +34,17 @@ static inline void cfi_module_remove(struct module *mod, unsigned long base_addr
 
 #else /* !CONFIG_CFI_CLANG */
 
-#define __CFI_ADDRESSABLE(fn, __attr)
+#ifdef CONFIG_X86_KERNEL_IBT
+
+#define __CFI_ADDRESSABLE(fn, __attr) \
+	const void *__cfi_jt_ ## fn __visible __attr = (void *)&fn
+
+#endif /* CONFIG_X86_KERNEL_IBT */
 
 #endif /* CONFIG_CFI_CLANG */
 
+#ifndef __CFI_ADDRESSABLE
+#define __CFI_ADDRESSABLE(fn, __attr)
+#endif
+
 #endif /* _LINUX_CFI_H */
