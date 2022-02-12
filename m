Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3901F4B339B
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 08:36:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbiBLHgf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 02:36:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231893AbiBLHge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 02:36:34 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADC4526AD6
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 23:36:31 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jwj3L05r6z9sSl;
        Sat, 12 Feb 2022 08:36:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id YH9d5bLukDHE; Sat, 12 Feb 2022 08:36:29 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jwj3K69Qlz9sSf;
        Sat, 12 Feb 2022 08:36:29 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BBADA8B766;
        Sat, 12 Feb 2022 08:36:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5Wjtjkt5FelZ; Sat, 12 Feb 2022 08:36:29 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.139])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8DB268B763;
        Sat, 12 Feb 2022 08:36:29 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21C7aJMJ1582946
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 12 Feb 2022 08:36:20 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21C7aHCA1582945;
        Sat, 12 Feb 2022 08:36:17 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Reduce csum_add() complexity for PPC64
Date:   Sat, 12 Feb 2022 08:36:17 +0100
Message-Id: <a4ca63dd4c4b09e1906d08fb814af5a41d0f3fcb.1644651363.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644651376; l=1197; s=20211009; h=from:subject:message-id; bh=U5EmRa7z4Ma/DFv0qhSDVvJA4tBg+isoQi09WUvKg+8=; b=KJrT27Qc+2p02+9Sde8X9nsa3+2JOSXSvKurff5AknJt2FnwWPSgmPCM19veBsggrnd9GslHzzE+ 6AjZY8AfDa+UjYwLIYA38FtPm+KNUcDSIjYQMP+LrONI1J3dwBMU
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

PPC64 does everything in C, gcc is able to skip calculation
when one of the operands in zero.

Move the constant folding in PPC32 part.

This helps GCC and reduces ppc64_defconfig by 170 bytes.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/checksum.h | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/checksum.h b/arch/powerpc/include/asm/checksum.h
index 3288a1bf5e8d..e4e25b46ac49 100644
--- a/arch/powerpc/include/asm/checksum.h
+++ b/arch/powerpc/include/asm/checksum.h
@@ -95,16 +95,15 @@ static __always_inline __wsum csum_add(__wsum csum, __wsum addend)
 {
 #ifdef __powerpc64__
 	u64 res = (__force u64)csum;
-#endif
+
+	res += (__force u64)addend;
+	return (__force __wsum)((u32)res + (res >> 32));
+#else
 	if (__builtin_constant_p(csum) && csum == 0)
 		return addend;
 	if (__builtin_constant_p(addend) && addend == 0)
 		return csum;
 
-#ifdef __powerpc64__
-	res += (__force u64)addend;
-	return (__force __wsum)((u32)res + (res >> 32));
-#else
 	asm("addc %0,%0,%1;"
 	    "addze %0,%0;"
 	    : "+r" (csum) : "r" (addend) : "xer");
-- 
2.34.1

