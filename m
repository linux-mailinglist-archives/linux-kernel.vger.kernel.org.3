Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D139F4695F2
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 13:47:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243382AbhLFMvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 07:51:01 -0500
Received: from foss.arm.com ([217.140.110.172]:56326 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243358AbhLFMu6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 07:50:58 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7E7911B3;
        Mon,  6 Dec 2021 04:47:29 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id ACE763F73D;
        Mon,  6 Dec 2021 04:47:27 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     ardb@kernel.org, bp@alien8.de, broonie@kernel.org,
        catalin.marinas@arm.com, dave.hansen@linux.intel.com,
        jpoimboe@redhat.com, jslaby@suse.cz,
        linux-arm-kernel@lists.infradead.org, mark.rutland@arm.com,
        maz@kernel.org, mingo@redhat.com, peterz@infradead.org,
        tabba@google.com, tglx@linutronix.de, will@kernel.org
Subject: [RFC PATCH 3/6] arm64: remove __dma_*_area() aliases
Date:   Mon,  6 Dec 2021 12:47:12 +0000
Message-Id: <20211206124715.4101571-4-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211206124715.4101571-1-mark.rutland@arm.com>
References: <20211206124715.4101571-1-mark.rutland@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The __dma_inv_area() and __dma_clean_area() aliases make cache.S harder
to navigate, but don't gain us anything in practice.

For clarity, let's remove them along with their redundant comments. The
only users are __dma_map_area() and __dma_unmap_area(), which need to be
position independent, and can call __pi_dcache_inval_poc() and
__pi_dcache_clean_poc() directly.

There should be no functional change as a result of this patch.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Fuad Tabba <tabba@google.com>
Cc: Marc Zyngier <maz@kernel.org>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/mm/cache.S | 24 +++---------------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/arch/arm64/mm/cache.S b/arch/arm64/mm/cache.S
index 5051b3c1a4f1..7d0563db4201 100644
--- a/arch/arm64/mm/cache.S
+++ b/arch/arm64/mm/cache.S
@@ -140,15 +140,7 @@ SYM_FUNC_END(dcache_clean_pou)
  *	- start   - kernel start address of region
  *	- end     - kernel end address of region
  */
-SYM_FUNC_START_LOCAL(__dma_inv_area)
 SYM_FUNC_START_PI(dcache_inval_poc)
-	/* FALLTHROUGH */
-
-/*
- *	__dma_inv_area(start, end)
- *	- start   - virtual start address of region
- *	- end     - virtual end address of region
- */
 	dcache_line_size x2, x3
 	sub	x3, x2, #1
 	tst	x1, x3				// end cache line aligned?
@@ -167,7 +159,6 @@ SYM_FUNC_START_PI(dcache_inval_poc)
 	dsb	sy
 	ret
 SYM_FUNC_END_PI(dcache_inval_poc)
-SYM_FUNC_END(__dma_inv_area)
 
 /*
  *	dcache_clean_poc(start, end)
@@ -178,19 +169,10 @@ SYM_FUNC_END(__dma_inv_area)
  *	- start   - virtual start address of region
  *	- end     - virtual end address of region
  */
-SYM_FUNC_START_LOCAL(__dma_clean_area)
 SYM_FUNC_START_PI(dcache_clean_poc)
-	/* FALLTHROUGH */
-
-/*
- *	__dma_clean_area(start, end)
- *	- start   - virtual start address of region
- *	- end     - virtual end address of region
- */
 	dcache_by_line_op cvac, sy, x0, x1, x2, x3
 	ret
 SYM_FUNC_END_PI(dcache_clean_poc)
-SYM_FUNC_END(__dma_clean_area)
 
 /*
  *	dcache_clean_pop(start, end)
@@ -232,8 +214,8 @@ SYM_FUNC_END_PI(__dma_flush_area)
 SYM_FUNC_START_PI(__dma_map_area)
 	add	x1, x0, x1
 	cmp	w2, #DMA_FROM_DEVICE
-	b.eq	__dma_inv_area
-	b	__dma_clean_area
+	b.eq	__pi_dcache_inval_poc
+	b	__pi_dcache_clean_poc
 SYM_FUNC_END_PI(__dma_map_area)
 
 /*
@@ -245,6 +227,6 @@ SYM_FUNC_END_PI(__dma_map_area)
 SYM_FUNC_START_PI(__dma_unmap_area)
 	add	x1, x0, x1
 	cmp	w2, #DMA_TO_DEVICE
-	b.ne	__dma_inv_area
+	b.ne	__pi_dcache_inval_poc
 	ret
 SYM_FUNC_END_PI(__dma_unmap_area)
-- 
2.30.2

