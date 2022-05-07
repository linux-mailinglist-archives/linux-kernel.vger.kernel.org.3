Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BEFE51E4CC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 08:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445838AbiEGGxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 02:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445797AbiEGGwV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 02:52:21 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 353DE66ACE
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 23:48:14 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KwHzj2jbkz9sWM;
        Sat,  7 May 2022 08:47:13 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2qybHAlaFMfU; Sat,  7 May 2022 08:47:13 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KwHzF3VYSz9sWQ;
        Sat,  7 May 2022 08:46:49 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6E6D78B773;
        Sat,  7 May 2022 08:46:49 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id U5I4ztUvGsGE; Sat,  7 May 2022 08:46:49 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.202.101])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6B0BD8B7B5;
        Sat,  7 May 2022 08:46:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2476kf3L1320563
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 7 May 2022 08:46:41 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2476kfXN1320562;
        Sat, 7 May 2022 08:46:41 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 23/25] powerpc/modules: Use PPC_LI macros instead of opencoding
Date:   Sat,  7 May 2022 08:46:25 +0200
Message-Id: <8707ff3d73f14d534c07621d57f04c10d7b4eb45.1651905939.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651905939.git.christophe.leroy@csgroup.eu>
References: <cover.1651905939.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1651905982; l=2088; s=20211009; h=from:subject:message-id; bh=b+9gYi7tejfbtzfkoRBlVUh9NKkvVQ9ywgf6dGMQ4kg=; b=FCYsijztuOveTRvPDvEyu/ciR6ffv6TDzL6ijQ/c+lwkfWXyr9QnydV2Cor9h3qsAgaxJGaT+CmR UWLD8BBvC+PUTqhjnIy6HvoFctc3HnDeY/Y36vUrLD3OXU7V7qM7
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

Use PPC_LI_MASK and PPC_LI() instead of opencoding.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
v2: Utilisation de PPC_LI() et PPC_LI_MASK
---
 arch/powerpc/kernel/module_32.c | 11 ++++-------
 arch/powerpc/kernel/module_64.c |  3 +--
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/kernel/module_32.c b/arch/powerpc/kernel/module_32.c
index 1b129d728e83..77e071acb684 100644
--- a/arch/powerpc/kernel/module_32.c
+++ b/arch/powerpc/kernel/module_32.c
@@ -256,9 +256,8 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 			       value, (uint32_t)location);
 			pr_debug("Location before: %08X.\n",
 			       *(uint32_t *)location);
-			value = (*(uint32_t *)location & ~0x03fffffc)
-				| ((value - (uint32_t)location)
-				   & 0x03fffffc);
+			value = (*(uint32_t *)location & ~PPC_LI_MASK) |
+				PPC_LI(value - (uint32_t)location);
 
 			if (patch_instruction(location, ppc_inst(value)))
 				return -EFAULT;
@@ -266,10 +265,8 @@ int apply_relocate_add(Elf32_Shdr *sechdrs,
 			pr_debug("Location after: %08X.\n",
 			       *(uint32_t *)location);
 			pr_debug("ie. jump to %08X+%08X = %08X\n",
-			       *(uint32_t *)location & 0x03fffffc,
-			       (uint32_t)location,
-			       (*(uint32_t *)location & 0x03fffffc)
-			       + (uint32_t)location);
+				 *(uint32_t *)PPC_LI((uint32_t)location), (uint32_t)location,
+				 (*(uint32_t *)PPC_LI((uint32_t)location)) + (uint32_t)location);
 			break;
 
 		case R_PPC_REL32:
diff --git a/arch/powerpc/kernel/module_64.c b/arch/powerpc/kernel/module_64.c
index c1d87937b962..4c844198185e 100644
--- a/arch/powerpc/kernel/module_64.c
+++ b/arch/powerpc/kernel/module_64.c
@@ -653,8 +653,7 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 			}
 
 			/* Only replace bits 2 through 26 */
-			value = (*(uint32_t *)location & ~0x03fffffc)
-				| (value & 0x03fffffc);
+			value = (*(uint32_t *)location & ~PPC_LI_MASK) | PPC_LI(value);
 
 			if (patch_instruction((u32 *)location, ppc_inst(value)))
 				return -EFAULT;
-- 
2.35.1

