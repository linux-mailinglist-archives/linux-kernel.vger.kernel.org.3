Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEF5551E4CF
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445891AbiEGGvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445814AbiEGGvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:51:21 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924E55DA46
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:47:30 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KwHzS0RYWz9sW7;
        Sat,  7 May 2022 08:47:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6fEQzL3IZRkc; Sat,  7 May 2022 08:46:59 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KwHzF2GjBz9sWC;
        Sat,  7 May 2022 08:46:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 3D7228B76D;
        Sat,  7 May 2022 08:46:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id xnxPP2enzmLH; Sat,  7 May 2022 08:46:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 4861D8B7AE;
        Sat,  7 May 2022 08:46:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2476kdRv1320494
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 7 May 2022 08:46:39 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2476kddQ1320493;
        Sat, 7 May 2022 08:46:39 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 06/25] powerpc/ftrace: Inline ftrace_modify_code()
Date:   Sat,  7 May 2022 08:46:08 +0200
Message-Id: <1597a06d57cfc80e6853838c4066e799bf6c7977.1651905939.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651905939.git.christophe.leroy@csgroup.eu>
References: <cover.1651905939.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1651905980; l=1024; s=20211009; h=from:subject:message-id; bh=gUl26aWBapldceuYTq45qkCOSgpcMCNP7bN7cPhPsTs=; b=WT6snymGq9DyKbyK+M44HFBa0+wwDA9RXG6szH7aca86NJzk1TjqlmNq/3BY7/eNPtqv82n/InJa S1FBAaSICxSKp7NahflKfkBmO9xvFchzpY+t1imDWPbo3d7zwvL4
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

Inlining ftrace_modify_code(), it increases a bit the
size of ftrace code but brings 5% improvment on ftrace
activation.

Usually in C files we let gcc decide what to do but here
it really help to 'help' gcc to decide to inline, thought
we don't want to force it with an __always_inline that
would be too much for CONFIG_CC_OPTIMIZE_FOR_SIZE.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: More explanation in commit message
---
 arch/powerpc/kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/trace/ftrace.c b/arch/powerpc/kernel/trace/ftrace.c
index 41c45b9c7f39..98e82fa4980f 100644
--- a/arch/powerpc/kernel/trace/ftrace.c
+++ b/arch/powerpc/kernel/trace/ftrace.c
@@ -53,7 +53,7 @@ ftrace_call_replace(unsigned long ip, unsigned long addr, int link)
 	return op;
 }
 
-static int
+static inline int
 ftrace_modify_code(unsigned long ip, ppc_inst_t old, ppc_inst_t new)
 {
 	ppc_inst_t replaced;
-- 
2.35.1

