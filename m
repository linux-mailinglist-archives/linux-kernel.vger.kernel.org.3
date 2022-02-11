Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C025E4B27A3
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:17:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238695AbiBKORK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:17:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbiBKORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:17:09 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCABA21F
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 06:17:06 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JwG011dw5z9sRw;
        Fri, 11 Feb 2022 15:17:05 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HZT9oE91O7UG; Fri, 11 Feb 2022 15:17:05 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JwG006MCNz9sSB;
        Fri, 11 Feb 2022 15:17:04 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id BF5198B77D;
        Fri, 11 Feb 2022 15:17:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id bHkdPldf_hbx; Fri, 11 Feb 2022 15:17:04 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.91])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 834FB8B764;
        Fri, 11 Feb 2022 15:17:04 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21BEGsgZ1222519
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Fri, 11 Feb 2022 15:16:54 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21BEGqk71222518;
        Fri, 11 Feb 2022 15:16:52 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/64: Force inlining of prevent_user_access() and set_kuap()
Date:   Fri, 11 Feb 2022 15:16:51 +0100
Message-Id: <eff9b2b211957fa2e8707e46f31674097fd563a3.1644588972.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644589010; l=4649; s=20211009; h=from:subject:message-id; bh=XrCDeAP4/Azx/7fNFKAhTR51cLiMLmTo9ZiA/wTB8ek=; b=/SDkwx2AgbWZDY0kFyXfMFNomKERjDG1jekOQl0RP7IWfyHQn5G0CjxuDem8kAJrlXgjmwXIArFI jakEEfTsAiRiJWDtcNoKl7AiYFOtlWED8wIESa9PnTjqjtRjiKgY
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

A ppc64_defconfig build exhibits about 10 copied of
prevent_user_access(). It also have one copy of set_kuap().

	c000000000017340 <.prevent_user_access.constprop.0>:
	c00000000001a038:	4b ff d3 09 	bl      c000000000017340 <.prevent_user_access.constprop.0>
	c00000000001aabc:	4b ff c8 85 	bl      c000000000017340 <.prevent_user_access.constprop.0>
	c00000000001ab38:	4b ff c8 09 	bl      c000000000017340 <.prevent_user_access.constprop.0>
	c00000000001ade0:	4b ff c5 61 	bl      c000000000017340 <.prevent_user_access.constprop.0>
	c000000000039b90 <.prevent_user_access.constprop.0>:
	c00000000003ac08:	4b ff ef 89 	bl      c000000000039b90 <.prevent_user_access.constprop.0>
	c00000000003b9d0:	4b ff e1 c1 	bl      c000000000039b90 <.prevent_user_access.constprop.0>
	c00000000003ba54:	4b ff e1 3d 	bl      c000000000039b90 <.prevent_user_access.constprop.0>
	c00000000003bbfc:	4b ff df 95 	bl      c000000000039b90 <.prevent_user_access.constprop.0>
	c00000000015dde0 <.prevent_user_access.constprop.0>:
	c0000000001612c0:	4b ff cb 21 	bl      c00000000015dde0 <.prevent_user_access.constprop.0>
	c000000000161b54:	4b ff c2 8d 	bl      c00000000015dde0 <.prevent_user_access.constprop.0>
	c000000000188cf0 <.prevent_user_access.constprop.0>:
	c00000000018d658:	4b ff b6 99 	bl      c000000000188cf0 <.prevent_user_access.constprop.0>
	c00000000030fe20 <.prevent_user_access.constprop.0>:
	c0000000003123d4:	4b ff da 4d 	bl      c00000000030fe20 <.prevent_user_access.constprop.0>
	c000000000313970:	4b ff c4 b1 	bl      c00000000030fe20 <.prevent_user_access.constprop.0>
	c0000000005e6bd0 <.prevent_user_access.constprop.0>:
	c0000000005e7d8c:	4b ff ee 45 	bl      c0000000005e6bd0 <.prevent_user_access.constprop.0>
	c0000000007bcae0 <.prevent_user_access.constprop.0>:
	c0000000007bda10:	4b ff f0 d1 	bl      c0000000007bcae0 <.prevent_user_access.constprop.0>
	c0000000007bda54:	4b ff f0 8d 	bl      c0000000007bcae0 <.prevent_user_access.constprop.0>
	c0000000007bdd28:	4b ff ed b9 	bl      c0000000007bcae0 <.prevent_user_access.constprop.0>
	c0000000007c0390:	4b ff c7 51 	bl      c0000000007bcae0 <.prevent_user_access.constprop.0>
	c00000000094e4f0 <.prevent_user_access.constprop.0>:
	c000000000950e40:	4b ff d6 b1 	bl      c00000000094e4f0 <.prevent_user_access.constprop.0>
	c00000000097d2d0 <.prevent_user_access.constprop.0>:
	c0000000009813fc:	4b ff be d5 	bl      c00000000097d2d0 <.prevent_user_access.constprop.0>
	c000000000acd540 <.prevent_user_access.constprop.0>:
	c000000000ad1d60:	4b ff b7 e1 	bl      c000000000acd540 <.prevent_user_access.constprop.0>
	c000000000e5d680 <.prevent_user_access.constprop.0>:
	c000000000e64b60:	4b ff 8b 21 	bl      c000000000e5d680 <.prevent_user_access.constprop.0>
	c000000000e64b6c:	4b ff 8b 15 	bl      c000000000e5d680 <.prevent_user_access.constprop.0>
	c000000000e64c38:	4b ff 8a 49 	bl      c000000000e5d680 <.prevent_user_access.constprop.0>

When building signal_64.c with -Winline the following messages appear:

	./arch/powerpc/include/asm/book3s/64/kup.h:331:20: error: inlining failed in call to 'set_kuap': call is unlikely and code size would grow [-Werror=inline]
	./arch/powerpc/include/asm/book3s/64/kup.h:401:20: error: inlining failed in call to 'prevent_user_access.constprop': call is unlikely and code size would grow [-Werror=inline]

Those functions are used on hot pathes and have been
expected to be inlined at all time.

Force them inline.

This patch reduces the kernel text size by 700 bytes, confirming
that not inlining those functions is not worth it.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/64/kup.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/kup.h b/arch/powerpc/include/asm/book3s/64/kup.h
index 69fcf63eec94..54cf46808157 100644
--- a/arch/powerpc/include/asm/book3s/64/kup.h
+++ b/arch/powerpc/include/asm/book3s/64/kup.h
@@ -328,7 +328,7 @@ static inline unsigned long get_kuap(void)
 	return mfspr(SPRN_AMR);
 }
 
-static inline void set_kuap(unsigned long value)
+static __always_inline void set_kuap(unsigned long value)
 {
 	if (!mmu_has_feature(MMU_FTR_BOOK3S_KUAP))
 		return;
@@ -398,7 +398,7 @@ static __always_inline void allow_user_access(void __user *to, const void __user
 
 #endif /* !CONFIG_PPC_KUAP */
 
-static inline void prevent_user_access(unsigned long dir)
+static __always_inline void prevent_user_access(unsigned long dir)
 {
 	set_kuap(AMR_KUAP_BLOCKED);
 	if (static_branch_unlikely(&uaccess_flush_key))
-- 
2.34.1

