Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327F9532292
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 07:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234538AbiEXFm3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 01:42:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233496AbiEXFm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 01:42:26 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3870A87A23
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 22:42:25 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4L6jl363bLz9tBD;
        Tue, 24 May 2022 07:42:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Dt9v-DV4p2Gg; Tue, 24 May 2022 07:42:23 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4L6jl34xzbz9sYL;
        Tue, 24 May 2022 07:42:23 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9AE2A8B76E;
        Tue, 24 May 2022 07:42:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 6Kppic0o54zn; Tue, 24 May 2022 07:42:23 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [192.168.203.153])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 6306D8B764;
        Tue, 24 May 2022 07:42:23 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 24O5gDxt3809821
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Tue, 24 May 2022 07:42:13 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 24O5gCYH3809820;
        Tue, 24 May 2022 07:42:12 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Laurent Dufour <ldufour@linux.ibm.com>
Subject: [PATCH] powerpc/64s: Only set HAVE_ARCH_UNMAPPED_AREA when CONFIG_PPC_64S_HASH_MMU is set
Date:   Tue, 24 May 2022 07:42:05 +0200
Message-Id: <e438c6cc09f94085e56733ed2d6e84333c35292a.1653370913.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1653370924; l=1141; s=20211009; h=from:subject:message-id; bh=+MvKH4EEEQKd0h26LxT5/EnF+K33KN5AdwHuo6j+kHY=; b=/rFjdJ01tdWFB5KnlTWLqc4/WCQti8sBjBesltOc1soKnCVLSSnK52l3SnqUKnl9ECWgxM4iHLKG 9qv+pl5xDxsD300sDIPnKy7VwyT/noZIVbk14LUNQDK+lS21I3/y
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

When CONFIG_PPC_64S_HASH_MMU is not set, slice.c is not built and
arch_get_unmapped_area() and arch_get_unmapped_area_topdown() are
not provided because RADIX uses the generic ones.

Therefore, neither set HAVE_ARCH_UNMAPPED_AREA nor
HAVE_ARCH_UNMAPPED_AREA_TOPDOWN.

Reported-by: Laurent Dufour <ldufour@linux.ibm.com>
Fixes: ab57bd7570d4 ("powerpc/mm: Move get_unmapped_area functions to slice.c")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/include/asm/book3s/64/slice.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/slice.h b/arch/powerpc/include/asm/book3s/64/slice.h
index b8eb4ad271b9..5fbe18544cbd 100644
--- a/arch/powerpc/include/asm/book3s/64/slice.h
+++ b/arch/powerpc/include/asm/book3s/64/slice.h
@@ -4,11 +4,13 @@
 
 #ifndef __ASSEMBLY__
 
+#ifdef CONFIG_PPC_64S_HASH_MMU
 #ifdef CONFIG_HUGETLB_PAGE
 #define HAVE_ARCH_HUGETLB_UNMAPPED_AREA
 #endif
 #define HAVE_ARCH_UNMAPPED_AREA
 #define HAVE_ARCH_UNMAPPED_AREA_TOPDOWN
+#endif
 
 #define SLICE_LOW_SHIFT		28
 #define SLICE_LOW_TOP		(0x100000000ul)
-- 
2.35.3

