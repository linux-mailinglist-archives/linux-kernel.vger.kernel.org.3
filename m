Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0F14D2A2F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 09:00:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbiCIH7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 02:59:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231572AbiCIH6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 02:58:03 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C4F2166E0E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 23:56:33 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KD4Jv4lzXz9sSV;
        Wed,  9 Mar 2022 08:56:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id qLx4faVm02P8; Wed,  9 Mar 2022 08:56:31 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KD4Jv40v5z9sSR;
        Wed,  9 Mar 2022 08:56:31 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 76C848B77D;
        Wed,  9 Mar 2022 08:56:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id WlMku7kl4AUb; Wed,  9 Mar 2022 08:56:31 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.3])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 2A0278B763;
        Wed,  9 Mar 2022 08:56:31 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2297uI323593930
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 9 Mar 2022 08:56:18 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2297uGok3593929;
        Wed, 9 Mar 2022 08:56:16 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Use rol32() instead of opencoding in csum_fold()
Date:   Wed,  9 Mar 2022 08:56:14 +0100
Message-Id: <794337eff7bb803d2c4e67d9eee635390c4c48fe.1646812553.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1646812573; l=1384; s=20211009; h=from:subject:message-id; bh=KDkVF9PqMt4cDBy6twCvMX/grto3ncphU+ZUsJSR6IA=; b=RHvXwbEHlO+1j8HBQrsBzcN7RyHmiKhQDWO+jKCyUQ/MU9Oq0s9c9mzE5EhM8Q2UNfaAumg9TIt1 ZkNP1gIcC713W+IjC+xio7Ol4Twoiz712ZOMJiiCO3/N1T8fa48g
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

rol32(x, 16) will do the rotate using rlwinm.

No need to open code using inline assembly.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/checksum.h | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 8321f6053a67..4b573a3b7e17 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -38,14 +38,15 @@ extern __wsum csum_and_copy_to_user(const void *src, void __user *dst,
  */
 static inline __sum16 csum_fold(__wsum sum)
 {
-	unsigned int tmp;
-
-	/* swap the two 16-bit halves of sum */
-	__asm__("rlwinm %0,%1,16,0,31" : "=r" (tmp) : "r" (sum));
-	/* if there is a carry from adding the two 16-bit halves,
-	   it will carry from the lower half into the upper half,
-	   giving us the correct sum in the upper half. */
-	return (__force __sum16)(~((__force u32)sum + tmp) >> 16);
+	u32 tmp = (__force u32)sum;
+
+	/*
+	 * swap the two 16-bit halves of sum
+	 * if there is a carry from adding the two 16-bit halves,
+	 * it will carry from the lower half into the upper half,
+	 * giving us the correct sum in the upper half.
+	 */
+	return (__force __sum16)(~(tmp + rol32(tmp, 16)) >> 16);
 }
 
 static inline u32 from64to32(u64 x)
-- 
2.34.1

