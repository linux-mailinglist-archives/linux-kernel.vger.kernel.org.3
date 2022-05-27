Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB94F535809
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 05:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbiE0DZ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 23:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235189AbiE0DZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 23:25:58 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D7926157
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 20:25:53 -0700 (PDT)
X-UUID: 7865e24b169f481aac22e70d869603c9-20220527
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:03eda090-8508-4b22-9499-3bc0b48689f6,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:59,FILE:0,RULE:Release_Ham,A
        CTION:release,TS:39
X-CID-INFO: VERSION:1.1.5,REQID:03eda090-8508-4b22-9499-3bc0b48689f6,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:59,FILE:0,RULE:Release_HamU,AC
        TION:release,TS:39
X-CID-META: VersionHash:2a19b09,CLOUDID:68ae6eb8-3c45-407b-8f66-25095432a27a,C
        OID:057e5d723713,Recheck:0,SF:28|100|16|19|48|101,TC:nil,Content:1,EDM:-3,
        IP:nil,URL:0,File:nil,QS:0,BEC:nil
X-UUID: 7865e24b169f481aac22e70d869603c9-20220527
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <yee.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1065751422; Fri, 27 May 2022 11:25:48 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 27 May 2022 11:25:47 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Fri, 27 May 2022 11:25:47 +0800
From:   <yee.lee@mediatek.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <patrick.wang.shcn@gmail.com>, <Kuan-Ying.lee@mediatek.com>,
        <Andrew.Yang@mediatek.com>, <Sunny.Kao@mediatek.com>,
        <chinwen.chang@mediatek.com>, Yee Lee <yee.lee@mediatek.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mm: kmemleak: Skip check in kmemleak_*_phys when pfn bound is not ready
Date:   Fri, 27 May 2022 11:25:02 +0800
Message-ID: <20220527032504.30341-1-yee.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yee Lee <yee.lee@mediatek.com>

In some archs (arm64), memblock allocates memory in boot time when
the pfn boundary (max_pfn/min_pfn) is not ready. The lowmen checks in
kmemleak_*_phys() drop those blocks and cause some false leak alarms
on common kernel objects.

Kmemleak output: (Qemu/arm64)
unreferenced object 0xffff0000c0170a00 (size 128):
  comm "swapper/0", pid 1, jiffies 4294892404 (age 126.208s)
  hex dump (first 32 bytes):
    62 61 73 65 00 00 00 00 00 00 00 00 00 00 00 00  base............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<(____ptrval____)>] __kmalloc_track_caller+0x1b0/0x2e4
    [<(____ptrval____)>] kstrdup_const+0x8c/0xc4
    [<(____ptrval____)>] kvasprintf_const+0xbc/0xec
    [<(____ptrval____)>] kobject_set_name_vargs+0x58/0xe4
    [<(____ptrval____)>] kobject_add+0x84/0x100
    [<(____ptrval____)>] __of_attach_node_sysfs+0x78/0xec
    [<(____ptrval____)>] of_core_init+0x68/0x104
    [<(____ptrval____)>] driver_init+0x28/0x48
    [<(____ptrval____)>] do_basic_setup+0x14/0x28
    [<(____ptrval____)>] kernel_init_freeable+0x110/0x178
    [<(____ptrval____)>] kernel_init+0x20/0x1a0
    [<(____ptrval____)>] ret_from_fork+0x10/0x20

This patch relaxs the boundary checking in kmemleak_*_phys api
if max_low_pfn is uninitialzed.

Fixes: 23c2d4 (mm: kmemleak: take a full lowmem check in kmemleak_*_phy)
Signed-off-by: Yee Lee <yee.lee@mediatek.com>
---
 mm/kmemleak.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index a182f5ddaf68..6b2af544aa0f 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -1132,7 +1132,7 @@ EXPORT_SYMBOL(kmemleak_no_scan);
 void __ref kmemleak_alloc_phys(phys_addr_t phys, size_t size, int min_count,
 			       gfp_t gfp)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
+	if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn))
 		kmemleak_alloc(__va(phys), size, min_count, gfp);
 }
 EXPORT_SYMBOL(kmemleak_alloc_phys);
@@ -1146,7 +1146,7 @@ EXPORT_SYMBOL(kmemleak_alloc_phys);
  */
 void __ref kmemleak_free_part_phys(phys_addr_t phys, size_t size)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
+	if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn))
 		kmemleak_free_part(__va(phys), size);
 }
 EXPORT_SYMBOL(kmemleak_free_part_phys);
@@ -1158,7 +1158,7 @@ EXPORT_SYMBOL(kmemleak_free_part_phys);
  */
 void __ref kmemleak_not_leak_phys(phys_addr_t phys)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
+	if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn))
 		kmemleak_not_leak(__va(phys));
 }
 EXPORT_SYMBOL(kmemleak_not_leak_phys);
@@ -1170,7 +1170,7 @@ EXPORT_SYMBOL(kmemleak_not_leak_phys);
  */
 void __ref kmemleak_ignore_phys(phys_addr_t phys)
 {
-	if (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn)
+	if (!max_low_pfn || (PHYS_PFN(phys) >= min_low_pfn && PHYS_PFN(phys) < max_low_pfn))
 		kmemleak_ignore(__va(phys));
 }
 EXPORT_SYMBOL(kmemleak_ignore_phys);
-- 
2.18.0

