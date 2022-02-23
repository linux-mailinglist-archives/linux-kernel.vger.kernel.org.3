Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0132F4C199A
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243094AbiBWRMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:12:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbiBWRMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:12:23 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDB1DB1B
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:11:53 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4K3jJ82V2cz9sSr;
        Wed, 23 Feb 2022 18:11:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8EZQBKC6w4kf; Wed, 23 Feb 2022 18:11:52 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4K3jJ81kQNz9sSq;
        Wed, 23 Feb 2022 18:11:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 29DCC8B77D;
        Wed, 23 Feb 2022 18:11:52 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id Udo70bziFge6; Wed, 23 Feb 2022 18:11:52 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.7.201])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E5C148B763;
        Wed, 23 Feb 2022 18:11:51 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21NHBgNk1288157
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 23 Feb 2022 18:11:42 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21NHBe1U1288156;
        Wed, 23 Feb 2022 18:11:40 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Kees Cook <keescook@chromium.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc/32: Clear volatile regs on syscall exit
Date:   Wed, 23 Feb 2022 18:11:36 +0100
Message-Id: <28b040bd2357a1879df0ca1b74094323f778a472.1645636285.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645636293; l=1655; s=20211009; h=from:subject:message-id; bh=FU6ZDLii/hs+oIBJTJCGeSNlC+UHQYVa3McA06lA/PA=; b=d1ZK9xjD4USupx+sxl6EchCL93TggibESCjcFLUnAi9KgjgXsSoU/tkXexySR8NKB5y3o9ecIMxt QfPnDVgFC3pC5D/C8xIYR4TCCTR5Njs8hd1pI97NbMyrcWdtCnVD
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

Commit a82adfd5c7cb ("hardening: Introduce CONFIG_ZERO_CALL_USED_REGS")
added zeroing of used registers at function exit.

At the time being, PPC64 clears volatile registers on syscall exit but
PPC32 doesn't do it for performance reason.

Add that clearing in PPC32 syscall exit as well, but only when
CONFIG_ZERO_CALL_USED_REGS is selected.

On an 8xx, the null_syscall selftest gives:
- Without CONFIG_ZERO_CALL_USED_REGS		: 288 cycles
- With CONFIG_ZERO_CALL_USED_REGS		: 305 cycles
- With CONFIG_ZERO_CALL_USED_REGS + this patch	: 319 cycles

Note that (independent of this patch), with pmac32_defconfig,
vmlinux size is as follows with/without CONFIG_ZERO_CALL_USED_REGS:

   text	   	data	    bss	    dec	    hex		filename
9578869		2525210	 194400	12298479	bba8ef	vmlinux.without
10318045	2525210  194400	13037655	c6f057	vmlinux.with

That is a 7.7% increase on text size, 6.0% on overall size.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/entry_32.S | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 7748c278d13c..199f23092c02 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -151,6 +151,21 @@ syscall_exit_finish:
 	bne	3f
 	mtcr	r5
 
+#ifdef CONFIG_ZERO_CALL_USED_REGS
+	/* Zero volatile regs that may contain sensitive kernel data */
+	li	r0,0
+	li	r4,0
+	li	r5,0
+	li	r6,0
+	li	r7,0
+	li	r8,0
+	li	r9,0
+	li	r10,0
+	li	r11,0
+	li	r12,0
+	mtctr	r0
+	mtxer	r0
+#endif
 1:	lwz	r2,GPR2(r1)
 	lwz	r1,GPR1(r1)
 	rfi
-- 
2.34.1

