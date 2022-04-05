Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBCD34F4E8C
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:50:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1835483AbiDFAbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 20:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443722AbiDEPkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 11:40:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 658FE185017
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 06:58:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F00AC6190C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 13:58:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7941AC385A6;
        Tue,  5 Apr 2022 13:58:26 +0000 (UTC)
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/10] arm64: Enable dynamic kmalloc() minimum alignment
Date:   Tue,  5 Apr 2022 14:57:58 +0100
Message-Id: <20220405135758.774016-11-catalin.marinas@arm.com>
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

Define ARCH_KMALLOC_MINALIGN as 64 since this would be the minimum
requirement across most arm64 SoCs. Define arch_kmalloc_minalign()
returning cache_line_size() to set the minimum run-time kmalloc()
alignment for those SoCs with bigger cache lines.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>
---
 arch/arm64/include/asm/cache.h | 1 +
 arch/arm64/kernel/cacheinfo.c  | 7 +++++++
 2 files changed, 8 insertions(+)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index a074459f8f2f..0bec986c9d51 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -48,6 +48,7 @@
  * the CPU.
  */
 #define ARCH_DMA_MINALIGN	(128)
+#define ARCH_KMALLOC_MINALIGN	(64)
 
 #ifdef CONFIG_KASAN_SW_TAGS
 #define ARCH_SLAB_MINALIGN	(1ULL << KASAN_SHADOW_SCALE_SHIFT)
diff --git a/arch/arm64/kernel/cacheinfo.c b/arch/arm64/kernel/cacheinfo.c
index 587543c6c51c..61211cd597f7 100644
--- a/arch/arm64/kernel/cacheinfo.c
+++ b/arch/arm64/kernel/cacheinfo.c
@@ -97,3 +97,10 @@ int populate_cache_leaves(unsigned int cpu)
 	}
 	return 0;
 }
+
+#ifndef CONFIG_SLOB
+unsigned int arch_kmalloc_minalign(void)
+{
+	return cache_line_size();
+}
+#endif
