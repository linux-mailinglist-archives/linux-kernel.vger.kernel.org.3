Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711B751BFEF
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 14:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378050AbiEEMz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 08:55:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378323AbiEEMzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 08:55:19 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437145623C
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 05:51:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KvD912Bcwz4x7V;
        Thu,  5 May 2022 22:51:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1651755093;
        bh=sji0xzBiYEtjDzYHRPtYyc+hLhCR46cOmSmiDGv7lNA=;
        h=From:To:Cc:Subject:Date:From;
        b=MNMW6XqvCFNs4TRfjW4X0WwbwfDrtbS/NICBT5GlE9X5MotXCMNYXziabKSu32cOg
         zdt0+9BItayFwBfbVP4EbBc+acXLV7fz1KLYh+B1VQt9gUXN76efezyFoBnvaiAtX9
         RELATlO/ufjSA7CweABYWuUYyOdpqdXaDDBZAIdK8ldFJcNr9OpO6/fRnKYbijwKRW
         oyHL3Ehv0tj4VQbZr7aYn06o8/uZwoG647lEKinH99YeyQDEel5yRb/w7qHVARHpHF
         qdLcF1CYRc9f6BK5YyPRlAiZ2ig/t3x8pcq0xOnmPctLX2FsDu9D3s5Uaad71UOH8w
         awFq0wetKugzg==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] powerpc: Add generic PAGE_SIZE config symbols
Date:   Thu,  5 May 2022 22:51:22 +1000
Message-Id: <20220505125123.2088143-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Other arches (sh, mips, hexagon) use standard names for PAGE_SIZE
related config symbols.

Add matching symbols for powerpc, which are enabled by default but
depend on our architecture specific PAGE_SIZE symbols.

This allows generic/driver code to express dependencies on the PAGE_SIZE
without needing to refer to architecture specific config symbols.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/Kconfig | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 145af02df3dc..02994361cc7a 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -759,6 +759,22 @@ config PPC_256K_PAGES
 
 endchoice
 
+config PAGE_SIZE_4KB
+	def_bool y
+	depends on PPC_4K_PAGES
+
+config PAGE_SIZE_16KB
+	def_bool y
+	depends on PPC_16K_PAGES
+
+config PAGE_SIZE_64KB
+	def_bool y
+	depends on PPC_64K_PAGES
+
+config PAGE_SIZE_256KB
+	def_bool y
+	depends on PPC_256K_PAGES
+
 config PPC_PAGE_SHIFT
 	int
 	default 18 if PPC_256K_PAGES
-- 
2.35.1

