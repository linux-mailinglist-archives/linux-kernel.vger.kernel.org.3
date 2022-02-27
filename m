Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 592F44C5B64
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 14:48:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiB0Nsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 08:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbiB0Nsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 08:48:50 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BA2BC4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 05:48:09 -0800 (PST)
X-UUID: 5c7c15667dcb4ffea42594f429c214af-20220227
X-UUID: 5c7c15667dcb4ffea42594f429c214af-20220227
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <lecopzer.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1639986030; Sun, 27 Feb 2022 21:48:04 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sun, 27 Feb 2022 21:48:03 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sun, 27 Feb 2022 21:48:03 +0800
From:   Lecopzer Chen <lecopzer.chen@mediatek.com>
To:     <linus.walleij@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <andreyknvl@gmail.com>, <anshuman.khandual@arm.com>,
        <ardb@kernel.org>, <arnd@arndb.de>, <dvyukov@google.com>,
        <geert+renesas@glider.be>, <glider@google.com>,
        <kasan-dev@googlegroups.com>, <lecopzer.chen@mediatek.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux@armlinux.org.uk>,
        <lukas.bulwahn@gmail.com>, <mark.rutland@arm.com>,
        <masahiroy@kernel.org>, <matthias.bgg@gmail.com>,
        <rmk+kernel@armlinux.org.uk>, <ryabinin.a.a@gmail.com>,
        <yj.chiang@mediatek.com>
Subject: [PATCH v3 1/2] arm: kasan: support CONFIG_KASAN_VMALLOC
Date:   Sun, 27 Feb 2022 21:47:25 +0800
Message-ID: <20220227134726.27584-2-lecopzer.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220227134726.27584-1-lecopzer.chen@mediatek.com>
References: <20220227134726.27584-1-lecopzer.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simply make shadow of vmalloc area mapped on demand.

Since the virtual address of vmalloc for Arm is also between
MODULE_VADDR and 0x100000000 (ZONE_HIGHMEM), which means the shadow
address has already included between KASAN_SHADOW_START and
KASAN_SHADOW_END.
Thus we need to change nothing for memory map of Arm.

This can fix ARM_MODULE_PLTS with KASan, support KASan for higmem
and provide the first step to support CONFIG_VMAP_STACK with Arm.

Signed-off-by: Lecopzer Chen <lecopzer.chen@mediatek.com>
---
 arch/arm/Kconfig                 |  1 +
 arch/arm/include/asm/kasan_def.h | 11 ++++++++++-
 arch/arm/mm/kasan_init.c         |  6 +++++-
 3 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 4c97cb40eebb..78250e246cc6 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -72,6 +72,7 @@ config ARM
 	select HAVE_ARCH_KFENCE if MMU && !XIP_KERNEL
 	select HAVE_ARCH_KGDB if !CPU_ENDIAN_BE32 && MMU
 	select HAVE_ARCH_KASAN if MMU && !XIP_KERNEL
+	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
 	select HAVE_ARCH_MMAP_RND_BITS if MMU
 	select HAVE_ARCH_PFN_VALID
 	select HAVE_ARCH_SECCOMP
diff --git a/arch/arm/include/asm/kasan_def.h b/arch/arm/include/asm/kasan_def.h
index 5739605aa7cf..96fd1d3b5a0c 100644
--- a/arch/arm/include/asm/kasan_def.h
+++ b/arch/arm/include/asm/kasan_def.h
@@ -19,7 +19,16 @@
  * space to use as shadow memory for KASan as follows:
  *
  * +----+ 0xffffffff
- * |    |							\
+ * |    |\
+ * |    | |-> ZONE_HIGHMEM for vmalloc virtual address space.
+ * |    | |   Such as vmalloc(), GFP_HIGHUSER (__GFP__HIGHMEM),
+ * |    | |   module address using ARM_MODULE_PLTS, etc.
+ * |    | |
+ * |    | |   If CONFIG_KASAN_VMALLOC=y, this area would populate
+ * |    | |   shadow address on demand.
+ * |    |/
+ * +----+ VMALLOC_START
+ * |    |\
  * |    | |-> Static kernel image (vmlinux) BSS and page table
  * |    |/
  * +----+ PAGE_OFFSET
diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 5ad0d6c56d56..29caee9c79ce 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -236,7 +236,11 @@ void __init kasan_init(void)
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
-	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
+	if (!IS_ENABLED(CONFIG_KASAN_VMALLOC))
+		kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
+					    kasan_mem_to_shadow((void *)VMALLOC_END));
+
+	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_END),
 				    kasan_mem_to_shadow((void *)-1UL) + 1);
 
 	for_each_mem_range(i, &pa_start, &pa_end) {
-- 
2.25.1

