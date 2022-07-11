Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05A7570553
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 16:20:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230200AbiGKOT4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 10:19:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiGKOTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 10:19:53 -0400
Received: from pegase2.c-s.fr (pegase2.c-s.fr [93.17.235.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92EDE32BAD
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 07:19:51 -0700 (PDT)
Received: from localhost (mailhub3.si.c-s.fr [172.26.127.67])
        by localhost (Postfix) with ESMTP id 4LhQxw6mVpz9sy3;
        Mon, 11 Jul 2022 16:19:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from pegase2.c-s.fr ([172.26.127.65])
        by localhost (pegase2.c-s.fr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id sEwUWcBuijtK; Mon, 11 Jul 2022 16:19:48 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase2.c-s.fr (Postfix) with ESMTP id 4LhQxw5zZXz9sy2;
        Mon, 11 Jul 2022 16:19:48 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B59F98B767;
        Mon, 11 Jul 2022 16:19:48 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id PDug5ro-mtP4; Mon, 11 Jul 2022 16:19:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (unknown [172.25.230.108])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 9FFDD8B763;
        Mon, 11 Jul 2022 16:19:48 +0200 (CEST)
Received: from PO20335.IDSI0.si.c-s.fr (localhost [127.0.0.1])
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.16.1) with ESMTPS id 26BEJZA41585422
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Mon, 11 Jul 2022 16:19:35 +0200
Received: (from chleroy@localhost)
        by PO20335.IDSI0.si.c-s.fr (8.17.1/8.17.1/Submit) id 26BEJYoC1585421;
        Mon, 11 Jul 2022 16:19:34 +0200
X-Authentication-Warning: PO20335.IDSI0.si.c-s.fr: chleroy set sender to christophe.leroy@csgroup.eu using -f
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v1 1/5] powerpc/32: Do not allow selection of e5500 or e6500 CPUs on PPC32
Date:   Mon, 11 Jul 2022 16:19:29 +0200
Message-Id: <8abab4888da69ff78b73a56f64d9678a7bf684e9.1657549153.git.christophe.leroy@csgroup.eu>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1657549171; l=1188; s=20211009; h=from:subject:message-id; bh=zbDq6NxwXwlkwZBaVuUjU96KJcBMe59aI2CjCuBbbW0=; b=nvquTDXxK4F5f7+tn9OG4myo91gcXQ+gwfwVbURPctKw20MDNI3R2XD51fkpnhqXGWwL6NHsEhcW uL5UdERGA9Szz6uQYRatryZ4Dkw3SaqNlmnGc7qX5+NdV9DWt7Xg
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

Commit 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
enlarged the CPU selection logic to PPC32 by removing depend to
PPC64, and failed to restrict that depend to E5500_CPU and E6500_CPU.
Fortunately that got unnoticed because -mcpu=8540 will override the
-mcpu=e500mc64 or -mpcu=e6500 as they are ealier, but that's
fragile and may no be right in the future.

Add back the depend PPC64 on E5500_CPU and E6500_CPU.

Fixes: 0e00a8c9fd92 ("powerpc: Allow CPU selection also on PPC32")
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/platforms/Kconfig.cputype | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 383ed4fe6013..9805a2c717b9 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -173,11 +173,11 @@ config POWER9_CPU
 
 config E5500_CPU
 	bool "Freescale e5500"
-	depends on E500
+	depends on PPC64 && E500
 
 config E6500_CPU
 	bool "Freescale e6500"
-	depends on E500
+	depends on PPC64 && E500
 
 config 860_CPU
 	bool "8xx family"
-- 
2.36.1

