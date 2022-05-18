Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E67052C062
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 19:10:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240608AbiERRDI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 13:03:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240611AbiERRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 13:03:05 -0400
Received: from gloria.sntech.de (gloria.sntech.de [185.11.138.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 740641A0766
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 10:03:01 -0700 (PDT)
Received: from ip5b412258.dynamic.kabel-deutschland.de ([91.65.34.88] helo=phil.lan)
        by gloria.sntech.de with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <heiko@sntech.de>)
        id 1nrN4d-0001Pv-Dd; Wed, 18 May 2022 19:02:59 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     palmer@dabbelt.com, paul.walmsley@sifive.com
Cc:     linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
        wefu@redhat.com, guoren@kernel.org, mick@ics.forth.gr,
        samuel@sholland.org, cmuellner@linux.com, philipp.tomsich@vrull.eu,
        hch@lst.de, Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH 3/4] riscv: make patch-function pointer more generic in cpu_manufacturer_info struct
Date:   Wed, 18 May 2022 19:02:53 +0200
Message-Id: <20220518170254.3178923-4-heiko@sntech.de>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220518170254.3178923-1-heiko@sntech.de>
References: <20220518170254.3178923-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_HELO_TEMPERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

During review the naming of the function-pointer was called
confusing as the vendor id is just one of three inputs for
the patching and indeed it serves no real purpose, as with
recent changes the function pointer is not a static
global element anymore, so drop the "vendor_" prefix.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
---
 arch/riscv/kernel/alternative.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/riscv/kernel/alternative.c b/arch/riscv/kernel/alternative.c
index c9d0d3c53223..a7d26a00beea 100644
--- a/arch/riscv/kernel/alternative.c
+++ b/arch/riscv/kernel/alternative.c
@@ -20,7 +20,7 @@ struct cpu_manufacturer_info_t {
 	unsigned long vendor_id;
 	unsigned long arch_id;
 	unsigned long imp_id;
-	void (*vendor_patch_func)(struct alt_entry *begin, struct alt_entry *end,
+	void (*patch_func)(struct alt_entry *begin, struct alt_entry *end,
 				  unsigned long archid, unsigned long impid,
 				  unsigned int stage);
 };
@@ -40,16 +40,16 @@ static void __init_or_module riscv_fill_cpu_mfr_info(struct cpu_manufacturer_inf
 	switch (cpu_mfr_info->vendor_id) {
 #ifdef CONFIG_ERRATA_SIFIVE
 	case SIFIVE_VENDOR_ID:
-		cpu_mfr_info->vendor_patch_func = sifive_errata_patch_func;
+		cpu_mfr_info->patch_func = sifive_errata_patch_func;
 		break;
 #endif
 #ifdef CONFIG_ERRATA_THEAD
 	case THEAD_VENDOR_ID:
-		cpu_mfr_info->vendor_patch_func = thead_errata_patch_func;
+		cpu_mfr_info->patch_func = thead_errata_patch_func;
 		break;
 #endif
 	default:
-		cpu_mfr_info->vendor_patch_func = NULL;
+		cpu_mfr_info->patch_func = NULL;
 	}
 }
 
@@ -68,13 +68,13 @@ static void __init_or_module _apply_alternatives(struct alt_entry *begin,
 
 	riscv_cpufeature_patch_func(begin, end, stage);
 
-	if (!cpu_mfr_info.vendor_patch_func)
+	if (!cpu_mfr_info.patch_func)
 		return;
 
-	cpu_mfr_info.vendor_patch_func(begin, end,
-				   cpu_mfr_info.arch_id,
-				   cpu_mfr_info.imp_id,
-				   stage);
+	cpu_mfr_info.patch_func(begin, end,
+				cpu_mfr_info.arch_id,
+				cpu_mfr_info.imp_id,
+				stage);
 }
 
 void __init apply_boot_alternatives(void)
-- 
2.35.1

