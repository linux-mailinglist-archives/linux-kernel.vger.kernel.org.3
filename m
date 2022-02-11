Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 241124B209A
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:52:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348211AbiBKIvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:51:53 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiBKIvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:51:51 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0CF2E88
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 00:51:50 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jw6mj34t3z9sSS;
        Fri, 11 Feb 2022 09:51:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id IOcZ2-sSz1EK; Fri, 11 Feb 2022 09:51:49 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jw6mj2HNFz9sSQ;
        Fri, 11 Feb 2022 09:51:49 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3CD078B77D;
        Fri, 11 Feb 2022 09:51:49 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id j-f1FxCK2_RO; Fri, 11 Feb 2022 09:51:49 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.91])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 0724A8B764;
        Fri, 11 Feb 2022 09:51:48 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21B8peER936906
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 09:51:40 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21B8pdwR936905;
        Fri, 11 Feb 2022 09:51:39 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/bitops: Force inlining of fls()
Date:   Fri, 11 Feb 2022 09:51:32 +0100
Message-Id: <adc9c9d6378f6b5008246ca717993d7870188efb.1644569473.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644569488; l=1865; s=20211009; h=from:subject:message-id; bh=M/5xahDUgG0mQf2oI1XcOb4Sgn+k9YQrjuKrDZuQ4W4=; b=jKko6cLnkRwrZ2Sa2GEyicM3hSwPMV05extt276vgQtPZcvhlXQgURBJV55Meg1JOdACitoZtRkF zi8KiYFsDAUydLMeW5amIg+LVokcpphXKMDi7AjtezD5EvilvI6h
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

Building a kernel with CONFIG_CC_OPTIMISE_FOR_SIZE leads to
the following functions being copied several times in vmlinux:

	31 times __ilog2_u32()
	34 times fls()

Disassembly follows:

	c00f476c <fls>:
	c00f476c:	7c 63 00 34 	cntlzw  r3,r3
	c00f4770:	20 63 00 20 	subfic  r3,r3,32
	c00f4774:	4e 80 00 20 	blr

	c00f4778 <__ilog2_u32>:
	c00f4778:	94 21 ff f0 	stwu    r1,-16(r1)
	c00f477c:	7c 08 02 a6 	mflr    r0
	c00f4780:	90 01 00 14 	stw     r0,20(r1)
	c00f4784:	4b ff ff e9 	bl      c00f476c <fls>
	c00f4788:	80 01 00 14 	lwz     r0,20(r1)
	c00f478c:	38 63 ff ff 	addi    r3,r3,-1
	c00f4790:	7c 08 03 a6 	mtlr    r0
	c00f4794:	38 21 00 10 	addi    r1,r1,16
	c00f4798:	4e 80 00 20 	blr

When forcing inlining of fls(), we get

	c0008b80 <__ilog2_u32>:
	c0008b80:	7c 63 00 34 	cntlzw  r3,r3
	c0008b84:	20 63 00 1f 	subfic  r3,r3,31
	c0008b88:	4e 80 00 20 	blr

vmlinux size gets reduced by 1 kbyte with that change.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/bitops.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/bitops.h b/arch/powerpc/include/asm/bitops.h
index f18b1eac6b54..7df7fee774e5 100644
--- a/arch/powerpc/include/asm/bitops.h
+++ b/arch/powerpc/include/asm/bitops.h
@@ -288,7 +288,7 @@ static __always_inline void arch___clear_bit_unlock(int nr, volatile unsigned lo
  * fls: find last (most-significant) bit set.
  * Note fls(0) = 0, fls(1) = 1, fls(0x80000000) = 32.
  */
-static inline int fls(unsigned int x)
+static __always_inline int fls(unsigned int x)
 {
 	int lz;
 
@@ -306,7 +306,7 @@ static inline int fls(unsigned int x)
  * 32-bit fls calls.
  */
 #ifdef CONFIG_PPC64
-static inline int fls64(__u64 x)
+static __always_inline int fls64(__u64 x)
 {
 	int lz;
 
-- 
2.34.1

