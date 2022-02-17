Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 066474B9F9C
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 13:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240189AbiBQMCy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 07:02:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240227AbiBQMCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 07:02:50 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD3B2AC906
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 04:02:25 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4Jztjr3ywzz9sSZ;
        Thu, 17 Feb 2022 13:02:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N8HK48oUeKlw; Thu, 17 Feb 2022 13:02:24 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4Jztjr3Bxmz9sRv;
        Thu, 17 Feb 2022 13:02:24 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5F1478B780;
        Thu, 17 Feb 2022 13:02:24 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FQJtncJFfTIv; Thu, 17 Feb 2022 13:02:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.225])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 1604B8B763;
        Thu, 17 Feb 2022 13:02:24 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21HC2ITQ400842
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Thu, 17 Feb 2022 13:02:18 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21HC2In7400841;
        Thu, 17 Feb 2022 13:02:18 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     "Naveen N . Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 3/4] powerpc/ftrace: Regroup PPC64 specific operations in ftrace_mprofile.S
Date:   Thu, 17 Feb 2022 13:01:58 +0100
Message-Id: <619dfb672bf4f1b777a4b3f8b4f14e637fea2716.1645099283.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <ec286d2cc6989668a96f14543275437d2f3f0e3a.1645099283.git.christophe.leroy@csgroup.eu>
References: <ec286d2cc6989668a96f14543275437d2f3f0e3a.1645099283.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1645099315; l=1188; s=20211009; h=from:subject:message-id; bh=XMIYYhQft+jL7/o2oyJXW3QWdZRHg33NfV3DhZbDywQ=; b=t5/JLVBulgsg7g1omxoG3MZAkrTcPSUvsnjYBnC+ZSWqQif8+O0lrHAG0EFcsi+kaN3dZvsRuXJ9 aDFwdjTEATn1MLYkcZLEQt1or9tfe2HXQkQK/uN0L0kQ4g/0zkP2
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

CONFIG_MPROFILE_KERNEL is only for PPC64 and ftrace_mprofile.o
is build on PPC64 only when CONFIG_MPROFILE_KERNEL is defined.

Move saving of r0 inside #ifdef PPC64

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/kernel/trace/ftrace_mprofile.S | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/trace/ftrace_mprofile.S b/arch/powerpc/kernel/trace/ftrace_mprofile.S
index 630b2de9957b..f5d31c458e6b 100644
--- a/arch/powerpc/kernel/trace/ftrace_mprofile.S
+++ b/arch/powerpc/kernel/trace/ftrace_mprofile.S
@@ -33,11 +33,6 @@
  * and then arrange for the ftrace function to be called.
  */
 .macro	ftrace_regs_entry allregs
-	/* Save the original return address in A's stack frame */
-#ifdef CONFIG_MPROFILE_KERNEL
-	PPC_STL	r0,LRSAVE(r1)
-#endif
-
 	/* Create our stack frame + pt_regs */
 	PPC_STLU	r1,-SWITCH_FRAME_SIZE(r1)
 
@@ -46,6 +41,8 @@
 	SAVE_GPRS(3, 10, r1)
 
 #ifdef CONFIG_PPC64
+	/* Save the original return address in A's stack frame */
+	std	r0, LRSAVE+SWITCH_FRAME_SIZE(r1)
 	/* Ok to continue? */
 	lbz	r3, PACA_FTRACE_ENABLED(r13)
 	cmpdi	r3, 0
-- 
2.34.1

