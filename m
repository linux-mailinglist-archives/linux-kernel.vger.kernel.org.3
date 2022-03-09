Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB1514D2A04
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 08:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbiCIH4K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230322AbiCIHzy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:55:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39A4B15F0A2;
        Tue,  8 Mar 2022 23:54:54 -0800 (PST)
Date:   Wed, 09 Mar 2022 07:54:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646812492;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pC85RLZcZ0YSTm6h2JoxuVNFAyU0SiMgU/+B0q6K81c=;
        b=AAG15fhPuHRT/3OaGJRegpxcxLTvGHnBs/xB96noMyh6pJX438l7/gGF1ohQxzlL+JfuYu
        vXx+cWj+0I0vHppaa+P0aPDUOR1u7oaUh1GDdd2tZHN/yBusQNmRlt/nbuGxpUxLAdEbdL
        0UOwX+W5APvrnCkKMhhETqPeD/10oLNhHXXxfxwJGuKXCDVo9vhiRfuwLUPP7d5/bm6L2q
        +4/V4wjLgmM1KKAjweGTYfmnvtd3bC0G9UcTaUKt3Wq52yGTqjOUHx7QcYl2Nb0F0Er8Qf
        3cwHoAVEUWcLgySd1/C5Zvf3GTGsQJfbNVr0GBdrKT62WaL1vx1CG6OOQepMLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646812492;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pC85RLZcZ0YSTm6h2JoxuVNFAyU0SiMgU/+B0q6K81c=;
        b=xtvJCz1dLvS2A5SbxX4QieYCWdj8GWPLPrruHou8FK2WGqFpvUWk9DMSiCHuWmsoXvBR0y
        LEkKz7UI5Zbie9DA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/ibt: Dont generate ENDBR in .discard.text
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220308154319.054842742@infradead.org>
References: <20220308154319.054842742@infradead.org>
MIME-Version: 1.0
Message-ID: <164681249182.16921.10443818068891067444.tip-bot2@tip-bot2>
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

Commit-ID:     c0b5a22ebc8f40ef5df8c0ab9797c2b62d2566dd
Gitweb:        https://git.kernel.org/tip/c0b5a22ebc8f40ef5df8c0ab9797c2b62d2566dd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 08 Mar 2022 16:30:43 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Mar 2022 23:53:35 +01:00

x86/ibt: Dont generate ENDBR in .discard.text

Having ENDBR in discarded sections can easily lead to relocations into
discarded sections which the linkers aren't really fond of. Objtool
also shouldn't generate them, but why tempt fate.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220308154319.054842742@infradead.org
---
 arch/x86/include/asm/setup.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/setup.h b/arch/x86/include/asm/setup.h
index a12458a..896e48d 100644
--- a/arch/x86/include/asm/setup.h
+++ b/arch/x86/include/asm/setup.h
@@ -8,6 +8,7 @@
 
 #include <linux/linkage.h>
 #include <asm/page_types.h>
+#include <asm/ibt.h>
 
 #ifdef __i386__
 
@@ -119,7 +120,7 @@ void *extend_brk(size_t size, size_t align);
  * executable.)
  */
 #define RESERVE_BRK(name,sz)						\
-	static void __section(".discard.text") __used notrace		\
+	static void __section(".discard.text") __noendbr __used notrace	\
 	__brk_reservation_fn_##name##__(void) {				\
 		asm volatile (						\
 			".pushsection .brk_reservation,\"aw\",@nobits;" \
