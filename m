Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD695385D2
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 18:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235829AbiE3QDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 12:03:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242536AbiE3QCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 12:02:33 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13C3FE4
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 09:02:20 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LBgCZ59BYz9tCN;
        Mon, 30 May 2022 18:02:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MZzUlpQ_gWpX; Mon, 30 May 2022 18:02:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LBgCZ4Ry8z9tC7;
        Mon, 30 May 2022 18:02:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 886A28B77B;
        Mon, 30 May 2022 18:02:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id kLRc4Y5avvcx; Mon, 30 May 2022 18:02:18 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 71DFB8B763;
        Mon, 30 May 2022 18:02:18 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24UG1vpQ277251
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 18:01:57 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24UG1uKf277242;
        Mon, 30 May 2022 18:01:56 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Erhard Furtner <erhard_f@mailbox.org>
Subject: [PATCH] powerpc/Kconfig: Force THREAD_SHIFT to at least 14 with KASAN
Date:   Mon, 30 May 2022 18:01:53 +0200
Message-Id: <cc1190008368a3305d424a98be756fedec6348c1.1653926503.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1653926511; l=902; s=20211009; h=from:subject:message-id; bh=hHlzaUPh+wM7+TTFp/1KkTnNy6JxGBHg3YQiF8dwWqA=; b=Q/jGx/r7SnHS59n8DPabZX53BJxT36Wn4ujwSoEHqqPG336Gu9zyTyg7xxe3IKDDQ92AWNmJ7cOx XthiRjOuBbFT1cyKkumLTDPFyGck6apoIR+nKXNt6m1e3XtOBzpH
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

Allthough 14 is the default THREAD_SHIFT when KASAN is selected,
taking an old config may keep 13 when CONFIG_EXPERT is selected.

Force it to 14 as a minimum when KASAN is selected.

Also default to 15 when KASAN on PPC64.

Reported-by: Erhard Furtner <erhard_f@mailbox.org>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/Kconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 3eaddb8997a9..a4427977fdf8 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -788,8 +788,10 @@ config PPC_PAGE_SHIFT
 
 config THREAD_SHIFT
 	int "Thread shift" if EXPERT
-	range 13 15
+	range 13 15 if !KASAN
+	range 14 15 if KASAN
 	default "15" if PPC_256K_PAGES
+	default "15" if PPC64 && KASAN
 	default "14" if PPC64
 	default "14" if KASAN
 	default "13"
-- 
2.35.3

