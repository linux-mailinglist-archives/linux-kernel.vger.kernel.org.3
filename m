Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE49B5993F3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 06:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346039AbiHSEMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 00:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346021AbiHSEMg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 00:12:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A49C2D4BEE
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 21:12:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5EB46B825AA
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 04:12:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8142AC43140;
        Fri, 19 Aug 2022 04:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660882353;
        bh=xA88Ovos9H3DHR/HPlEe0AwH/mYo7aEjxL8NAKpwIOI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dZb0HOnlL2Y22Acis6FSAF9KAcZ8A1LfVc5yWntVp0HlvxGO+KFsurLTJob9b+hQh
         PkfQ8LIifmzwzPin/wpr8baDOHLVGMK9hlbneLnyAg4Vhw+WTENfeCYHnsmxUFfadT
         /cx8xnmqRSVv/+OVb+4vOf/9n9Cg+KXY/kiu+eBy4vzbXYQcqBckcpqJYtcv8h1t/w
         qyDkiaBA+aAJjJK7hdkJcNfRp9/x8rfE3dnSkkyV//lEzdUx1c1+C9r06rmuX1dbKN
         T0Bkc9f7cE2HpKpkJ8/WyTDrSRuU4Ib/DgFQIkZHrw8dPEISYIzaKYU0+Y9UlLXG/k
         RCeyHxW12/8Cg==
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
Subject: [PATCH 5/5] arm64/mmu: simplify logic around crash kernel mapping in map_mem()
Date:   Fri, 19 Aug 2022 07:11:56 +0300
Message-Id: <20220819041156.873873-6-rppt@kernel.org>
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

The check for crashkernel command line parameter and presence of
CONFIG_ZONE_DMA[32] in mmu::map_mem() are not necessary because
crashk_res.end would be set by the time map_mem() runs only if
reserve_crashkernel() was called from arm64_memblock_init() and only if
there was proper crashkernel parameter in the command line.

Leave only check that crashk_res.end is non-zero to decide whether
crash kernel memory should be mapped with base pages.

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm64/mm/mmu.c | 44 ++++++++++++--------------------------------
 1 file changed, 12 insertions(+), 32 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 83f2f18f7f34..fa23cfa6b772 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -502,21 +502,6 @@ void __init mark_linear_text_alias_ro(void)
 			    PAGE_KERNEL_RO);
 }
 
-static bool crash_mem_map __initdata;
-
-static int __init enable_crash_mem_map(char *arg)
-{
-	/*
-	 * Proper parameter parsing is done by reserve_crashkernel(). We only
-	 * need to know if the linear map has to avoid block mappings so that
-	 * the crashkernel reservations can be unmapped later.
-	 */
-	crash_mem_map = true;
-
-	return 0;
-}
-early_param("crashkernel", enable_crash_mem_map);
-
 static void __init map_mem(pgd_t *pgdp)
 {
 	static const u64 direct_map_end = _PAGE_END(VA_BITS_MIN);
@@ -547,11 +532,9 @@ static void __init map_mem(pgd_t *pgdp)
 	memblock_mark_nomap(kernel_start, kernel_end - kernel_start);
 
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map && !have_zone_dma()) {
-		if (crashk_res.end)
-			memblock_mark_nomap(crashk_res.start,
-			    resource_size(&crashk_res));
-	}
+	if (crashk_res.end)
+		memblock_mark_nomap(crashk_res.start,
+				    resource_size(&crashk_res));
 #endif
 
 	/* map all the memory banks */
@@ -582,20 +565,17 @@ static void __init map_mem(pgd_t *pgdp)
 	memblock_clear_nomap(kernel_start, kernel_end - kernel_start);
 
 	/*
-	 * Use page-level mappings here so that we can shrink the region
-	 * in page granularity and put back unused memory to buddy system
-	 * through /sys/kernel/kexec_crash_size interface.
+	 * Use page-level mappings here so that we can protect crash kernel
+	 * memory to allow post-mortem analysis when things go awry.
 	 */
 #ifdef CONFIG_KEXEC_CORE
-	if (crash_mem_map && !have_zone_dma()) {
-		if (crashk_res.end) {
-			__map_memblock(pgdp, crashk_res.start,
-				       crashk_res.end + 1,
-				       PAGE_KERNEL,
-				       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
-			memblock_clear_nomap(crashk_res.start,
-					     resource_size(&crashk_res));
-		}
+	if (crashk_res.end) {
+		__map_memblock(pgdp, crashk_res.start,
+			       crashk_res.end + 1,
+			       PAGE_KERNEL,
+			       NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS);
+		memblock_clear_nomap(crashk_res.start,
+				     resource_size(&crashk_res));
 	}
 #endif
 }
-- 
2.35.3

