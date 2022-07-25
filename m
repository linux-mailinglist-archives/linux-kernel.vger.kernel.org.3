Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55F4D57F895
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 06:24:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbiGYEYR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 00:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiGYEYQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 00:24:16 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 00AFAE083
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 21:24:13 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6872B1E80D0F;
        Mon, 25 Jul 2022 12:19:14 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YNKpYQq2v0-9; Mon, 25 Jul 2022 12:19:11 +0800 (CST)
Received: from localhost.localdomain (unknown [219.141.250.2])
        (Authenticated sender: kunyu@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id B1E671E80D05;
        Mon, 25 Jul 2022 12:19:11 +0800 (CST)
From:   Li kunyu <kunyu@nfschina.com>
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org, Li kunyu <kunyu@nfschina.com>
Subject: [PATCH] x86/boot/arch/variable: I don't think (void *) Pointers need to be cast
Date:   Mon, 25 Jul 2022 12:23:58 +0800
Message-Id: <20220725042358.3377-1-kunyu@nfschina.com>
X-Mailer: git-send-email 2.18.2
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I first observe (void *) type coercion and non coercion through assembly
language. It seems that there is no difference.
Then I output the assigned information through the print function and
found that the pointer that is not coerced is directly assigned when
executing the print function (opcode a1), while the coerced pointer
needs to execute the assembly instruction xlat (opcode d7), which seems
to be more efficient without coerced conversion.
At present, I just started to try to analyze this part of knowledge
(machine code), please forgive me if the analysis is wrong.

Signed-off-by: Li kunyu <kunyu@nfschina.com>
---
 arch/x86/boot/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/boot/bitops.h b/arch/x86/boot/bitops.h
index 02e1dea11d94..8518ae214c9b 100644
--- a/arch/x86/boot/bitops.h
+++ b/arch/x86/boot/bitops.h
@@ -19,13 +19,13 @@
 
 static inline bool constant_test_bit(int nr, const void *addr)
 {
-	const u32 *p = (const u32 *)addr;
+	const u32 *p = addr;
 	return ((1UL << (nr & 31)) & (p[nr >> 5])) != 0;
 }
 static inline bool variable_test_bit(int nr, const void *addr)
 {
 	bool v;
-	const u32 *p = (const u32 *)addr;
+	const u32 *p = addr;
 
 	asm("btl %2,%1" CC_SET(c) : CC_OUT(c) (v) : "m" (*p), "Ir" (nr));
 	return v;
-- 
2.18.2

