Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBF44B3A72
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 10:03:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234666AbiBMJDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 04:03:54 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:42776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231843AbiBMJDx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 04:03:53 -0500
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056775BD38
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 01:03:47 -0800 (PST)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4JxLxZ11qhz9sT4;
        Sun, 13 Feb 2022 10:03:46 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tL7WtdoiyCHL; Sun, 13 Feb 2022 10:03:46 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4JxLxZ066Fz9sST;
        Sun, 13 Feb 2022 10:03:46 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id E3DC78B76C;
        Sun, 13 Feb 2022 10:03:45 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id FASQjzzXMkR8; Sun, 13 Feb 2022 10:03:45 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.6.142])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id AAB2F8B763;
        Sun, 13 Feb 2022 10:03:45 +0100 (CET)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 21D92hhA1968772
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sun, 13 Feb 2022 10:02:43 +0100
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 21D92fbC1968771;
        Sun, 13 Feb 2022 10:02:41 +0100
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] powerpc: Don't allow the use of EMIT_BUG_ENTRY with BUGFLAG_WARNING
Date:   Sun, 13 Feb 2022 10:02:41 +0100
Message-Id: <ddcb422102a37eb45f57694c7ef0ec6187964dff.1644742951.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1644742960; l=1634; s=20211009; h=from:subject:message-id; bh=dpWeaQ6u0n62dBXZwHulXFq1tC0eufiLLZqZRLGc0ek=; b=0Ewv5XROXR4ZaxZLQbY/7KiWVEQS+oqKLj2kGQIK9ZoufQxpcx5v6M//MyHWdzv6Iuuoaan0fQmh C/MKXmmkDU27Z6ziaYcxSgSQUsTYa/Pq6vr+BqTU09lp2oIxiVTc
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

Warnings in assembly must use EMIT_WARN_ENTRY in order to generate
the necessary entry in exception table.

Check in EMIT_BUG_ENTRY that flags don't include BUGFLAG_WARNING.

This change avoids problems like the one fixed by
commit fd1eaaaaa686 ("powerpc/64s: Use EMIT_WARN_ENTRY for SRR debug
warnings").

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/bug.h | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
index 02c08d1492f8..ecbae1832de3 100644
--- a/arch/powerpc/include/asm/bug.h
+++ b/arch/powerpc/include/asm/bug.h
@@ -11,7 +11,7 @@
 #ifdef __ASSEMBLY__
 #include <asm/asm-offsets.h>
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-.macro EMIT_BUG_ENTRY addr,file,line,flags
+.macro __EMIT_BUG_ENTRY addr,file,line,flags
 	 .section __bug_table,"aw"
 5001:	 .4byte \addr - 5001b, 5002f - 5001b
 	 .short \line, \flags
@@ -22,7 +22,7 @@
 	 .previous
 .endm
 #else
-.macro EMIT_BUG_ENTRY addr,file,line,flags
+.macro __EMIT_BUG_ENTRY addr,file,line,flags
 	 .section __bug_table,"aw"
 5001:	 .4byte \addr - 5001b
 	 .short \flags
@@ -33,7 +33,14 @@
 
 .macro EMIT_WARN_ENTRY addr,file,line,flags
 	EX_TABLE(\addr,\addr+4)
-	EMIT_BUG_ENTRY \addr,\file,\line,\flags
+	__EMIT_BUG_ENTRY \addr,\file,\line,\flags
+.endm
+
+.macro EMIT_BUG_ENTRY addr,file,line,flags
+	.if \flags & 1 /* BUGFLAG_WARNING */
+	.err /* Use EMIT_WARN_ENTRY for warnings */
+	.endif
+	__EMIT_BUG_ENTRY \addr,\file,\line,\flags
 .endm
 
 #else /* !__ASSEMBLY__ */
-- 
2.34.1

