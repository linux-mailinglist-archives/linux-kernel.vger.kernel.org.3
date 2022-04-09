Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26DBB4FA9D7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242909AbiDIRVY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 13:21:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242867AbiDIRVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 13:21:09 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0050C24A136
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 10:18:57 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4KbMJv0wwXz9sTZ;
        Sat,  9 Apr 2022 19:18:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id R6neV5WG6pnY; Sat,  9 Apr 2022 19:18:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4KbMJl6F1sz9sTc;
        Sat,  9 Apr 2022 19:18:15 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B8C418B79E;
        Sat,  9 Apr 2022 19:18:15 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id detph0MXO8Wl; Sat,  9 Apr 2022 19:18:15 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.53])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id A2C2E8B7A7;
        Sat,  9 Apr 2022 19:18:14 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 239HI7o4833202
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Sat, 9 Apr 2022 19:18:07 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 239HI6K2833201;
        Sat, 9 Apr 2022 19:18:06 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        akpm@linux-foundation.org
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mm@kvack.org, Alexandre Ghiti <alex@ghiti.fr>
Subject: [PATCH v10 02/13] mm: Allow arch specific arch_randomize_brk() with CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
Date:   Sat,  9 Apr 2022 19:17:26 +0200
Message-Id: <b222f1ca06c850daf1b2f26afdb46c6dd97d21ba.1649523076.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1649523076.git.christophe.leroy@csgroup.eu>
References: <cover.1649523076.git.christophe.leroy@csgroup.eu>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1649524639; l=1149; s=20211009; h=from:subject:message-id; bh=In6hoVVyDKXseeO8Y+/7fZMHadvP9Y9sVPt1sEtc5qI=; b=OJwLbTVHE6myZeBP/aU0gFNnAj0YQv5RJhSJUvhA/YPNOJ89ILeINngwh/Q3KvtxMNC4cL2D4Bs7 NYu2MzZHBI+wBFLG3iRQ0HD2EcmCPv6rfjEOrxLLdzFgv+LYRRL6
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

Commit e7142bf5d231 ("arm64, mm: make randomization selected by
generic topdown mmap layout") introduced a default version of
arch_randomize_brk() provided when
CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT is selected.

powerpc could select CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
but needs to provide its own arch_randomize_brk().

In order to allow that, define generic version of arch_randomize_brk()
as a __weak symbol.

Cc: Alexandre Ghiti <alex@ghiti.fr>
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Acked-by: Andrew Morton <akpm@linux-foundation.org>
---
 mm/util.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/util.c b/mm/util.c
index 54e5e761a9a9..0787fe4af4ac 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -344,7 +344,7 @@ unsigned long randomize_stack_top(unsigned long stack_top)
 }
 
 #ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
-unsigned long arch_randomize_brk(struct mm_struct *mm)
+unsigned long __weak arch_randomize_brk(struct mm_struct *mm)
 {
 	/* Is the current task 32bit ? */
 	if (!IS_ENABLED(CONFIG_64BIT) || is_compat_task())
-- 
2.35.1

