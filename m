Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CB07587985
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 11:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbiHBJDU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 05:03:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235865AbiHBJDR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 05:03:17 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DD925FC
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 02:03:15 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LxptS5Zwhz9sj9;
        Tue,  2 Aug 2022 11:03:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XIsHyHlYRTbR; Tue,  2 Aug 2022 11:03:12 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LxptS4s7kz9sT4;
        Tue,  2 Aug 2022 11:03:12 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 95DD18B776;
        Tue,  2 Aug 2022 11:03:12 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id T1EjCIarcU_q; Tue,  2 Aug 2022 11:03:12 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.234.100])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 594EC8B775;
        Tue,  2 Aug 2022 11:03:12 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 27292rOI2260941
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 2 Aug 2022 11:02:53 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 27292rmP2260940;
        Tue, 2 Aug 2022 11:02:53 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/3] powerpc: Make eh value more explicit when using lwarx
Date:   Tue,  2 Aug 2022 11:02:38 +0200
Message-Id: <629befaa2d05e2922346e58a383886510d6af55a.1659430931.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <a1176e19e627dd6a1b8d24c6c457a8ab874b7d12.1659430931.git.christophe.leroy@csgroup.eu>
References: <a1176e19e627dd6a1b8d24c6c457a8ab874b7d12.1659430931.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1659430956; l=1202; s=20211009; h=from:subject:message-id; bh=syaSj3N1vXnt1sIFy5ttLwsX9xKUP3hffNWtE6sINDU=; b=kEfiaaH5U0TGf317v6AjvpZDg0o4i5I7a+P+Z46Ca1CCnnCSaUm/HlBJrGBU8AfPaCWikb2Ewv/9 vkq16HDYCUbtchpMUy2BRmpzDcOtD1gchcmKGz+1pslPYduYEhmH
X-Developer-Key: i=christophe.leroy@csgroup.eu; a=ed25519; pk=HIzTzUj91asvincQGOFx6+ZF5AoUuP9GdOtQChs7Mm0=
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Just like first patch of this series, define a local 'eh'
in order to make the code clearer.

And IS_ENABLED() returns either 1 or 0 so no need to
do IS_ENABLED(CONFIG_PPC64) ? 1 : 0.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/atomic.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
index 853dc86864f4..0204e77613ec 100644
--- a/arch/powerpc/include/asm/atomic.h
+++ b/arch/powerpc/include/asm/atomic.h
@@ -140,6 +140,7 @@ static __always_inline bool
 arch_atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)
 {
 	int r, o = *old;
+	unsigned int eh = IS_ENABLED(CONFIG_PPC64);
 
 	__asm__ __volatile__ (
 "1:	lwarx	%0,0,%2,%5	# atomic_try_cmpxchg_acquire		\n"
@@ -150,7 +151,7 @@ arch_atomic_try_cmpxchg_lock(atomic_t *v, int *old, int new)
 "\t"	PPC_ACQUIRE_BARRIER "						\n"
 "2:									\n"
 	: "=&r" (r), "+m" (v->counter)
-	: "r" (&v->counter), "r" (o), "r" (new), "i" (IS_ENABLED(CONFIG_PPC64) ? 1 : 0)
+	: "r" (&v->counter), "r" (o), "r" (new), "i" (eh)
 	: "cr0", "memory");
 
 	if (unlikely(r != o))
-- 
2.36.1

