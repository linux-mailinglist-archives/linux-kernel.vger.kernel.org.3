Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81E3E51F422
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:02:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233928AbiEIFtv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 01:49:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235230AbiEIFrV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 01:47:21 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14F415F6CA
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 22:43:25 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KxVKm2hZPz9sWN;
        Mon,  9 May 2022 07:37:00 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 8w_a-rU7xpHi; Mon,  9 May 2022 07:37:00 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KxVKH4c2Xz9sWH;
        Mon,  9 May 2022 07:36:35 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 8680B8B774;
        Mon,  9 May 2022 07:36:35 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 5wkjJiXhOqxp; Mon,  9 May 2022 07:36:35 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 5CA0B8B770;
        Mon,  9 May 2022 07:36:35 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 2495aVK41591299
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 9 May 2022 07:36:31 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 2495aVYH1591298;
        Mon, 9 May 2022 07:36:31 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        naveen.n.rao@linux.vnet.ibm.com
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v3 23/25] powerpc/modules: Use PPC_LI macros instead of opencoding
Date:   Mon,  9 May 2022 07:36:21 +0200
Message-Id: <3d56d7bc3200403773d54e62659d0e01292a055d.1652074503.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1652074503.git.christophe.leroy@csgroup.eu>
References: <cover.1652074503.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1652074582; l=2088; s=20211009; h=from:subject:message-id; bh=DNHkQ3AqPMTm8F5d5vYdHRf8knPDG7LqAC1tvoZK/mA=; b=RVKopUceGs1tSYS7Qz685ln/9CCoKZ4RzRcmTe3BnkTx1VgvES9CS49/JITDxlHLMDpqKf0W9Qaw 2q7LOpg2C8SWd7UaMCd23V5+wNOF2xxecQMbjW8mfTXe4bRPXzT3
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
index 715a42f383d0..3d47e9853f3e 100644
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

