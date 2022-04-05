Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B707B4F5073
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 04:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1841914AbiDFB0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 21:26:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443698AbiDEPkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B703184B58
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E29A461632
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:58:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686A6C385AA;
        Tue,  5 Apr 2022 13:58:04 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 01/10] mm/slab: Decouple ARCH_KMALLOC_MINALIGN from ARCH_DMA_MINALIGN
Date:   Tue,  5 Apr 2022 14:57:49 +0100
Message-Id: <20220405135758.774016-2-catalin.marinas@arm.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220405135758.774016-1-catalin.marinas@arm.com>
References: <20220405135758.774016-1-catalin.marinas@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation for supporting a dynamic kmalloc() minimum alignment,
allow architectures to define ARCH_KMALLOC_MINALIGN independently of
ARCH_DMA_MINALIGN. In addition, always define ARCH_DMA_MINALIGN even if
an architecture does not override it.

After this patch, ARCH_DMA_MINALIGN is expected to be used in static
alignment annotations and defined by an architecture to be the maximum
alignment for all supported configurations/SoCs in a single Image.
ARCH_KMALLOC_MINALIGN, if different, is the minimum alignment guaranteed
by kmalloc().

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/slab.h | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/slab.h b/include/linux/slab.h
index 373b3ef99f4e..d58211bdeceb 100644
--- a/include/linux/slab.h
+++ b/include/linux/slab.h
@@ -187,17 +187,30 @@ bool kmem_valid_obj(void *object);
 void kmem_dump_obj(void *object);
 #endif
 
+/*
+ * slob does not support independent control of ARCH_KMALLOC_MINALIGN and
+ * ARCH_DMA_MINALIGN.
+ */
+#ifdef CONFIG_SLOB
+#undef ARCH_KMALLOC_MINALIGN
+#endif
+
 /*
  * Some archs want to perform DMA into kmalloc caches and need a guaranteed
  * alignment larger than the alignment of a 64-bit integer.
- * Setting ARCH_KMALLOC_MINALIGN in arch headers allows that.
+ * Setting ARCH_DMA_MINALIGN in arch headers allows that.
  */
-#if defined(ARCH_DMA_MINALIGN) && ARCH_DMA_MINALIGN > 8
+#ifndef ARCH_DMA_MINALIGN
+#define ARCH_DMA_MINALIGN __alignof__(unsigned long long)
+#elif ARCH_DMA_MINALIGN > 8 && !defined(ARCH_KMALLOC_MINALIGN)
 #define ARCH_KMALLOC_MINALIGN ARCH_DMA_MINALIGN
-#define KMALLOC_MIN_SIZE ARCH_DMA_MINALIGN
-#define KMALLOC_SHIFT_LOW ilog2(ARCH_DMA_MINALIGN)
-#else
+#endif
+
+#ifndef ARCH_KMALLOC_MINALIGN
 #define ARCH_KMALLOC_MINALIGN __alignof__(unsigned long long)
+#else
+#define KMALLOC_MIN_SIZE ARCH_KMALLOC_MINALIGN
+#define KMALLOC_SHIFT_LOW ilog2(KMALLOC_MIN_SIZE)
 #endif
 
 /*
