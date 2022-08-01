Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A395865F5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 10:04:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbiHAIEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 04:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiHAIEk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 04:04:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53B912A72E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 01:04:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E357E60F11
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:04:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DC3C4347C;
        Mon,  1 Aug 2022 08:04:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659341078;
        bh=OjCzYsGS4fOFkbuq211CjFLG8Lt6vwd7g0byaHHcDJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OZ8U61ks8p3bY6UnJTlV0sMIHMJR3KU/pSpKF94ESgUOOoyaZo9Lio1IUp8BiH9x8
         aGslZfie20B+ioHRav4LyrO8FhehUSgocWmlqNUkSvSMdHMD9VQcpui75A/uznScRj
         8Ex0MngjTHn8FEFoF3rOHQcp6OwtYt3ia3FTQHxGZu1Ty/fxNISLhrQI/vjOzncJRX
         jK3aLNLeCm8PocPHOaxZ1lcsOdVdUu2Qf/FfTBL4I0zFqcjEkt7dQyKMoqSG/VAmfT
         evBSBD1z0Z2glj2FDjtxYuHoLgEDYYsDWxfV3ykJd9byXFf08g0AIBwp3yEGIbGCaY
         vwG+oSO1H4vqg==
From:   Mike Rapoport <rppt@kernel.org>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Guanghui Feng <guanghuifeng@linux.alibaba.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Mike Rapoport <rppt@kernel.org>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [RFC PATCH 1/4] arm64: introduce have_zone_dma() helper
Date:   Mon,  1 Aug 2022 11:04:15 +0300
Message-Id: <20220801080418.120311-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220801080418.120311-1-rppt@kernel.org>
References: <20220801080418.120311-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

rather than open-code the check whether CONFIG_ZONE_DMA or
CONFIG_ZONE_DMA32 are enabled.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/memory.h | 8 ++++++++
 arch/arm64/mm/init.c            | 4 ++--
 arch/arm64/mm/mmu.c             | 6 ++----
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 0af70d9abede..fa89d3bded8b 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -351,6 +351,14 @@ static inline void *phys_to_virt(phys_addr_t x)
 })
 
 void dump_mem_limit(void);
+
+static inline bool have_zone_dma(void)
+{
+	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
+		return true;
+
+	return false;
+}
 #endif /* !ASSEMBLY */
 
 /*
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 339ee84e5a61..fa2260040c0f 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -389,7 +389,7 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32))
+	if (!have_zone_dma())
 		reserve_crashkernel();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
@@ -438,7 +438,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32))
+	if (have_zone_dma())
 		reserve_crashkernel();
 
 	memblock_dump_all();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 626ec32873c6..d170b7956b01 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -529,8 +529,7 @@ static void __init map_mem(pgd_t *pgdp)
 
 #ifdef CONFIG_KEXEC_CORE
 	if (crash_mem_map) {
-		if (IS_ENABLED(CONFIG_ZONE_DMA) ||
-		    IS_ENABLED(CONFIG_ZONE_DMA32))
+		if (have_zone_dma())
 			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 		else if (crashk_res.end)
 			memblock_mark_nomap(crashk_res.start,
@@ -571,8 +570,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 * through /sys/kernel/kexec_crash_size interface.
 	 */
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map &&
-	    !IS_ENABLED(CONFIG_ZONE_DMA) && !IS_ENABLED(CONFIG_ZONE_DMA32)) {
+	if (crash_mem_map && !have_zone_dma()) {
 		if (crashk_res.end) {
 			__map_memblock(pgdp, crashk_res.start,
 				       crashk_res.end + 1,
-- 
2.35.3

