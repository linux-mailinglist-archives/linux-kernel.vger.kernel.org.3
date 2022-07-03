Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A95A5649E3
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 23:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231911AbiGCVPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 17:15:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbiGCVPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 17:15:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDF512DF6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 14:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4/CIB1EcERoj8QxWO7+iDjq5fYneBarUFOPcszgNWtc=; b=su10001VmY7UBzKCk2Jho0TFYJ
        IyphsV5Yf/2eOz3VEeLdch4w+D1K6zCk4M1pVvt/iXZhutbWWnm0z4hteOnI2v9HvBTVdTVwmI2mz
        A6DidYzqr+oCZHp9ndTDSGo48esSYCZqx3dmo4FPEaMpmhvYKQdaIzk7aUkdft01aLf7rpkqf/0L5
        x8YTk/RCgtAfVVhqEsVomV8PBznZXEr7oFT+4uIZ3u0PbIIUpb6MNbSNmzC4+uDY6DbLmbH2FKgn4
        5IlPT1Dqx/h8PxsfaT/RGdBi5Mz4MABfGiZcAUatTCLQSABPiEtFPROFCi/a47F1QjRB4X7z4FlA7
        eDAmrJxg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o86vZ-00Ght3-Jo; Sun, 03 Jul 2022 21:14:49 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, Mike Rapoport <rppt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Date:   Sun,  3 Jul 2022 22:14:41 +0100
Message-Id: <20220703211441.3981873-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220703141203.147893-1-rppt@kernel.org>
References: <20220703141203.147893-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is the number of bits used by a PMD entry, not the order of a PMD.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/arm/kernel/head.S | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 500612d3da2e..d16159ced58f 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -38,10 +38,10 @@
 #ifdef CONFIG_ARM_LPAE
 	/* LPAE requires an additional page for the PGD */
 #define PG_DIR_SIZE	0x5000
-#define PMD_ORDER	3
+#define PMD_BITS	3
 #else
 #define PG_DIR_SIZE	0x4000
-#define PMD_ORDER	2
+#define PMD_BITS	2
 #endif
 
 	.globl	swapper_pg_dir
@@ -240,7 +240,7 @@ __create_page_tables:
 	mov	r6, r6, lsr #SECTION_SHIFT
 
 1:	orr	r3, r7, r5, lsl #SECTION_SHIFT	@ flags + kernel base
-	str	r3, [r4, r5, lsl #PMD_ORDER]	@ identity mapping
+	str	r3, [r4, r5, lsl #PMD_BITS]	@ identity mapping
 	cmp	r5, r6
 	addlo	r5, r5, #1			@ next section
 	blo	1b
@@ -250,7 +250,7 @@ __create_page_tables:
 	 * set two variables to indicate the physical start and end of the
 	 * kernel.
 	 */
-	add	r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_BITS)
 	ldr	r6, =(_end - 1)
 	adr_l	r5, kernel_sec_start		@ _pa(kernel_sec_start)
 #if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDIAN_BE32
@@ -259,8 +259,8 @@ __create_page_tables:
 	str	r8, [r5]			@ Save physical start of kernel (LE)
 #endif
 	orr	r3, r8, r7			@ Add the MMU flags
-	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
-1:	str	r3, [r0], #1 << PMD_ORDER
+	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_BITS)
+1:	str	r3, [r0], #1 << PMD_BITS
 	add	r3, r3, #1 << SECTION_SHIFT
 	cmp	r0, r6
 	bls	1b
@@ -280,14 +280,14 @@ __create_page_tables:
 	mov	r3, pc
 	mov	r3, r3, lsr #SECTION_SHIFT
 	orr	r3, r7, r3, lsl #SECTION_SHIFT
-	add	r0, r4,  #(XIP_START & 0xff000000) >> (SECTION_SHIFT - PMD_ORDER)
-	str	r3, [r0, #((XIP_START & 0x00f00000) >> SECTION_SHIFT) << PMD_ORDER]!
+	add	r0, r4,  #(XIP_START & 0xff000000) >> (SECTION_SHIFT - PMD_BITS)
+	str	r3, [r0, #((XIP_START & 0x00f00000) >> SECTION_SHIFT) << PMD_BITS]!
 	ldr	r6, =(_edata_loc - 1)
-	add	r0, r0, #1 << PMD_ORDER
-	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
+	add	r0, r0, #1 << PMD_BITS
+	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_BITS)
 1:	cmp	r0, r6
 	add	r3, r3, #1 << SECTION_SHIFT
-	strls	r3, [r0], #1 << PMD_ORDER
+	strls	r3, [r0], #1 << PMD_BITS
 	bls	1b
 #endif
 
@@ -297,10 +297,10 @@ __create_page_tables:
 	 */
 	mov	r0, r2, lsr #SECTION_SHIFT
 	cmp	r2, #0
-	ldrne	r3, =FDT_FIXED_BASE >> (SECTION_SHIFT - PMD_ORDER)
+	ldrne	r3, =FDT_FIXED_BASE >> (SECTION_SHIFT - PMD_BITS)
 	addne	r3, r3, r4
 	orrne	r6, r7, r0, lsl #SECTION_SHIFT
-	strne	r6, [r3], #1 << PMD_ORDER
+	strne	r6, [r3], #1 << PMD_BITS
 	addne	r6, r6, #1 << SECTION_SHIFT
 	strne	r6, [r3]
 
@@ -319,7 +319,7 @@ __create_page_tables:
 	addruart r7, r3, r0
 
 	mov	r3, r3, lsr #SECTION_SHIFT
-	mov	r3, r3, lsl #PMD_ORDER
+	mov	r3, r3, lsl #PMD_BITS
 
 	add	r0, r4, r3
 	mov	r3, r7, lsr #SECTION_SHIFT
@@ -349,7 +349,7 @@ __create_page_tables:
 	 * If we're using the NetWinder or CATS, we also need to map
 	 * in the 16550-type serial port for the debug messages
 	 */
-	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_BITS)
 	orr	r3, r7, #0x7c000000
 	str	r3, [r0]
 #endif
@@ -359,10 +359,10 @@ __create_page_tables:
 	 * Similar reasons here - for debug.  This is
 	 * only for Acorn RiscPC architectures.
 	 */
-	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_BITS)
 	orr	r3, r7, #0x02000000
 	str	r3, [r0]
-	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_BITS)
 	str	r3, [r0]
 #endif
 #endif
-- 
2.35.1

