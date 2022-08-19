Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38E9F5993F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245371AbiHSEMY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:12:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345157AbiHSEMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:12:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB7AD4751
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:12:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BEF25614B3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:12:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86439C43470;
        Fri, 19 Aug 2022 04:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660882337;
        bh=OJw5ok0VWpXV3rCiT2RPnbejds8oP9obR0Vq/h7CFMg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kk7a5L2fGYglj/X+iysS0UCkB1aNmS+LAXX5gdRkSk6QWLPtsYWlXgpsLQSX4/2m6
         xSAnTQjm8z1SSGIu8AvMC+WvtHiaUkHJXdotVu+VIGcGwbSuWAa+pd3D9TwA5hO/xV
         SeQY4tvS/87p9KJbLFiypyt5avneNb1U2JMS3OHFQ8Wg6vRfY+VP9ARAPb3z3fFNQe
         huyGcQmXx05+a+1zofD5JiK4ztPPW2Jk7PfQ9e7+JOYJ2Xd9K53aTQjezSdfbXcy+C
         tUZwCybmYrgTbhNUX0ean/n/TqOYsmBrz6//+A5XGGyoJP5834TNnLWwbx8TiIrg1s
         Q0eNNmNBjqIyQ==
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
Subject: [PATCH 1/5] arm64: rename defer_reserve_crashkernel() to have_zone_dma()
Date:   Fri, 19 Aug 2022 07:11:52 +0300
Message-Id: <20220819041156.873873-2-rppt@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220819041156.873873-1-rppt@kernel.org>
References: <20220819041156.873873-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mike Rapoport <rppt@linux.ibm.com>

The new name better describes what the function does and does not
restrict its use to crash kernel reservations.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/include/asm/memory.h | 2 +-
 arch/arm64/mm/init.c            | 4 ++--
 arch/arm64/mm/mmu.c             | 4 ++--
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/include/asm/memory.h b/arch/arm64/include/asm/memory.h
index 9dd08cd339c3..27fce129b97e 100644
--- a/arch/arm64/include/asm/memory.h
+++ b/arch/arm64/include/asm/memory.h
@@ -364,7 +364,7 @@ static inline void *phys_to_virt(phys_addr_t x)
 
 void dump_mem_limit(void);
 
-static inline bool defer_reserve_crashkernel(void)
+static inline bool have_zone_dma(void)
 {
 	return IS_ENABLED(CONFIG_ZONE_DMA) || IS_ENABLED(CONFIG_ZONE_DMA32);
 }
diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index b9af30be813e..a6585d50a76c 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -389,7 +389,7 @@ void __init arm64_memblock_init(void)
 
 	early_init_fdt_scan_reserved_mem();
 
-	if (!defer_reserve_crashkernel())
+	if (!have_zone_dma())
 		reserve_crashkernel();
 
 	high_memory = __va(memblock_end_of_DRAM() - 1) + 1;
@@ -438,7 +438,7 @@ void __init bootmem_init(void)
 	 * request_standard_resources() depends on crashkernel's memory being
 	 * reserved, so do it here.
 	 */
-	if (defer_reserve_crashkernel())
+	if (have_zone_dma())
 		reserve_crashkernel();
 
 	memblock_dump_all();
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index db7c4e6ae57b..bf303f1dea25 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -548,7 +548,7 @@ static void __init map_mem(pgd_t *pgdp)
 
 #ifdef CONFIG_KEXEC_CORE
 	if (crash_mem_map) {
-		if (defer_reserve_crashkernel())
+		if (have_zone_dma())
 			flags |= NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
 		else if (crashk_res.end)
 			memblock_mark_nomap(crashk_res.start,
@@ -589,7 +589,7 @@ static void __init map_mem(pgd_t *pgdp)
 	 * through /sys/kernel/kexec_crash_size interface.
 	 */
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map && !defer_reserve_crashkernel()) {
+	if (crash_mem_map && !have_zone_dma()) {
 		if (crashk_res.end) {
 			__map_memblock(pgdp, crashk_res.start,
 				       crashk_res.end + 1,
-- 
2.35.3

