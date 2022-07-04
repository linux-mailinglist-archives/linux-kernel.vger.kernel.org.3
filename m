Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E71564DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 08:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232850AbiGDG0m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 02:26:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230304AbiGDG0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 02:26:41 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A86163C4
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 23:26:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AB1E061351
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 06:26:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBFEC3411E;
        Mon,  4 Jul 2022 06:26:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656915999;
        bh=/dozeZi1LmhMDOAWCcXzX9Z0JD1Osv/58uL7Cc43LR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mOYrmYjOTFK4bzvfiMDzsrGgHgrbXI6vJsLXsNwGXePJy90rsIERo6yutbh05fSOX
         WJfxGdI7M+mjj7/uGl/j0c9QccRx3QjyWAAxnnSAsXSTAXVz5TLrp42klwSLOoxdNG
         aVipXG/rE4S4Z1cuDqTQ/zBv7bCA5XXqZQKoWO0VN+ui2vDaU0rD0QeFs1U51A3Tkw
         uH4u+vFJCYFR6m1YC1zj85wK7tqo1n5N8hY6F5M0JpJkpnExsQE9md61mU+0lOkhnv
         lDSaLPPr2EQoHHmHWwj3gH19+9ACoXNQDwnFGBzHgPD/tGtmQWmfCo6htqWvyp2F60
         n4FGEXQVahffg==
Date:   Mon, 4 Jul 2022 09:26:22 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/14] arm: Rename PMD_ORDER to PMD_BITS
Message-ID: <YsKIDqAjg383vGuk@kernel.org>
References: <20220703141203.147893-1-rppt@kernel.org>
 <20220703211441.3981873-1-willy@infradead.org>
 <YsIHPStHG84Ksu7m@shell.armlinux.org.uk>
 <YsIQKdYiswzq5kTG@casper.infradead.org>
 <YsJtYYsB/SinnNzI@shell.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YsJtYYsB/SinnNzI@shell.armlinux.org.uk>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 04, 2022 at 05:32:33AM +0100, Russell King (Oracle) wrote:
> On Sun, Jul 03, 2022 at 10:54:49PM +0100, Matthew Wilcox wrote:
> > On Sun, Jul 03, 2022 at 10:16:45PM +0100, Russell King (Oracle) wrote:
> > > On Sun, Jul 03, 2022 at 10:14:41PM +0100, Matthew Wilcox (Oracle) wrote:
> > > > This is the number of bits used by a PMD entry, not the order of a PMD.
> > > 
> > > No, it's not the number of bits. A PMD entry doesn't fit in 2 or 3 bits.
> > > This is even more confusing.
> > 
> > Well, what is it then?  The order of something is PAGE_SIZE << n, and
> > that doesn't seem to be what this is.
> 
> Where is it defined that "order" means "PAGE_SIZE << n" ?
> 
> "order" here is "order of magnitude" and in this case, it is 2^n, just
> like order of magnitude in base 10 is 10^n. So strictly, the usage
> here is completely correct, but if you describe "order" as "PAGE_SIZE <<
> n" that is no longer an order of magnitude, because it doesn't increase
> in an order of magnitude (iow, n = 2 isn't PAGE_SIZE * PAGE_SIZE).

I'd go with PMD_ENTRY_ORDER as Russell suggested last year.

From 6389dfb2e5ae5b040ca1c8f07a071d8da2873b13 Mon Sep 17 00:00:00 2001
From: Mike Rapoport <rppt@linux.ibm.com>
Date: Mon, 4 Jul 2022 09:17:40 +0300
Subject: [PATCH] ARM: head.S: rename PMD_ORDER to PMD_ENTRY_ORDER

PMD_ORDER denotes order of magnitude for a PMD entry, i.e PMD entry
size is 2 ^ PMD_ORDER.

Rename PMD_ORDER to PMD_ENTRY_ORDER to allow a generic definition of
PMD_ORDER as order of a PMD allocation: (PMD_SHIFT - PAGE_SHIFT).

Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
---
 arch/arm/kernel/head.S | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/arm/kernel/head.S b/arch/arm/kernel/head.S
index 500612d3da2e..29e2900178a1 100644
--- a/arch/arm/kernel/head.S
+++ b/arch/arm/kernel/head.S
@@ -38,10 +38,10 @@
 #ifdef CONFIG_ARM_LPAE
 	/* LPAE requires an additional page for the PGD */
 #define PG_DIR_SIZE	0x5000
-#define PMD_ORDER	3
+#define PMD_ENTRY_ORDER	3	/* PMD entry size is 2^PMD_ENTRY_ORDER */
 #else
 #define PG_DIR_SIZE	0x4000
-#define PMD_ORDER	2
+#define PMD_ENTRY_ORDER	2
 #endif
 
 	.globl	swapper_pg_dir
@@ -240,7 +240,7 @@ __create_page_tables:
 	mov	r6, r6, lsr #SECTION_SHIFT
 
 1:	orr	r3, r7, r5, lsl #SECTION_SHIFT	@ flags + kernel base
-	str	r3, [r4, r5, lsl #PMD_ORDER]	@ identity mapping
+	str	r3, [r4, r5, lsl #PMD_ENTRY_ORDER]	@ identity mapping
 	cmp	r5, r6
 	addlo	r5, r5, #1			@ next section
 	blo	1b
@@ -250,7 +250,7 @@ __create_page_tables:
 	 * set two variables to indicate the physical start and end of the
 	 * kernel.
 	 */
-	add	r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #KERNEL_OFFSET >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	ldr	r6, =(_end - 1)
 	adr_l	r5, kernel_sec_start		@ _pa(kernel_sec_start)
 #if defined CONFIG_CPU_ENDIAN_BE8 || defined CONFIG_CPU_ENDIAN_BE32
@@ -259,8 +259,8 @@ __create_page_tables:
 	str	r8, [r5]			@ Save physical start of kernel (LE)
 #endif
 	orr	r3, r8, r7			@ Add the MMU flags
-	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
-1:	str	r3, [r0], #1 << PMD_ORDER
+	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ENTRY_ORDER)
+1:	str	r3, [r0], #1 << PMD_ENTRY_ORDER
 	add	r3, r3, #1 << SECTION_SHIFT
 	cmp	r0, r6
 	bls	1b
@@ -280,14 +280,14 @@ __create_page_tables:
 	mov	r3, pc
 	mov	r3, r3, lsr #SECTION_SHIFT
 	orr	r3, r7, r3, lsl #SECTION_SHIFT
-	add	r0, r4,  #(XIP_START & 0xff000000) >> (SECTION_SHIFT - PMD_ORDER)
-	str	r3, [r0, #((XIP_START & 0x00f00000) >> SECTION_SHIFT) << PMD_ORDER]!
+	add	r0, r4,  #(XIP_START & 0xff000000) >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
+	str	r3, [r0, #((XIP_START & 0x00f00000) >> SECTION_SHIFT) << PMD_ENTRY_ORDER]!
 	ldr	r6, =(_edata_loc - 1)
-	add	r0, r0, #1 << PMD_ORDER
-	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ORDER)
+	add	r0, r0, #1 << PMD_ENTRY_ORDER
+	add	r6, r4, r6, lsr #(SECTION_SHIFT - PMD_ENTRY_ORDER)
 1:	cmp	r0, r6
 	add	r3, r3, #1 << SECTION_SHIFT
-	strls	r3, [r0], #1 << PMD_ORDER
+	strls	r3, [r0], #1 << PMD_ENTRY_ORDER
 	bls	1b
 #endif
 
@@ -297,10 +297,10 @@ __create_page_tables:
 	 */
 	mov	r0, r2, lsr #SECTION_SHIFT
 	cmp	r2, #0
-	ldrne	r3, =FDT_FIXED_BASE >> (SECTION_SHIFT - PMD_ORDER)
+	ldrne	r3, =FDT_FIXED_BASE >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	addne	r3, r3, r4
 	orrne	r6, r7, r0, lsl #SECTION_SHIFT
-	strne	r6, [r3], #1 << PMD_ORDER
+	strne	r6, [r3], #1 << PMD_ENTRY_ORDER
 	addne	r6, r6, #1 << SECTION_SHIFT
 	strne	r6, [r3]
 
@@ -319,7 +319,7 @@ __create_page_tables:
 	addruart r7, r3, r0
 
 	mov	r3, r3, lsr #SECTION_SHIFT
-	mov	r3, r3, lsl #PMD_ORDER
+	mov	r3, r3, lsl #PMD_ENTRY_ORDER
 
 	add	r0, r4, r3
 	mov	r3, r7, lsr #SECTION_SHIFT
@@ -349,7 +349,7 @@ __create_page_tables:
 	 * If we're using the NetWinder or CATS, we also need to map
 	 * in the 16550-type serial port for the debug messages
 	 */
-	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0xff000000 >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	orr	r3, r7, #0x7c000000
 	str	r3, [r0]
 #endif
@@ -359,10 +359,10 @@ __create_page_tables:
 	 * Similar reasons here - for debug.  This is
 	 * only for Acorn RiscPC architectures.
 	 */
-	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0x02000000 >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	orr	r3, r7, #0x02000000
 	str	r3, [r0]
-	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_ORDER)
+	add	r0, r4, #0xd8000000 >> (SECTION_SHIFT - PMD_ENTRY_ORDER)
 	str	r3, [r0]
 #endif
 #endif
-- 
2.34.1


-- 
Sincerely yours,
Mike.
