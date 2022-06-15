Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8A854C1BB
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 08:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346141AbiFOGW3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 02:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231691AbiFOGW2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 02:22:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF9C6BFD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 23:22:26 -0700 (PDT)
X-UUID: cd9724fa7c8e4e0eb7d75559d32416f4-20220615
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.6,REQID:c68bc38a-e216-406a-a0eb-2bfcbb8ac190,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:100
X-CID-INFO: VERSION:1.1.6,REQID:c68bc38a-e216-406a-a0eb-2bfcbb8ac190,OB:0,LOB:
        0,IP:0,URL:0,TC:0,Content:0,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D,AC
        TION:quarantine,TS:100
X-CID-META: VersionHash:b14ad71,CLOUDID:7e5848f6-e099-41ba-a32c-13b8bfe63214,C
        OID:f3505d2ee169,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:nil,BEC:nil,COL:0
X-UUID: cd9724fa7c8e4e0eb7d75559d32416f4-20220615
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1039634672; Wed, 15 Jun 2022 14:22:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 15 Jun 2022 14:22:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Wed, 15 Jun 2022 14:22:21 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <chinwen.chang@mediatek.com>, <yee.lee@mediatek.com>,
        <casper.li@mediatek.com>, <andrew.yang@mediatek.com>,
        Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <kasan-dev@googlegroups.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] kasan: separate double free case from invalid free
Date:   Wed, 15 Jun 2022 14:22:18 +0800
Message-ID: <20220615062219.22618-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, KASAN describes all invalid-free/double-free bugs as
"double-free or invalid-free". This is ambiguous.

KASAN should report "double-free" when a double-free is a more
likely cause (the address points to the start of an object) and
report "invalid-free" otherwise [1].

[1] https://bugzilla.kernel.org/show_bug.cgi?id=212193

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 mm/kasan/common.c |  8 ++++----
 mm/kasan/kasan.h  |  3 ++-
 mm/kasan/report.c | 12 ++++++++----
 3 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index c40c0e7b3b5f..707c3a527fcb 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -343,7 +343,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 
 	if (unlikely(nearest_obj(cache, virt_to_slab(object), object) !=
 	    object)) {
-		kasan_report_invalid_free(tagged_object, ip);
+		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_INVALID_FREE);
 		return true;
 	}
 
@@ -352,7 +352,7 @@ static inline bool ____kasan_slab_free(struct kmem_cache *cache, void *object,
 		return false;
 
 	if (!kasan_byte_accessible(tagged_object)) {
-		kasan_report_invalid_free(tagged_object, ip);
+		kasan_report_invalid_free(tagged_object, ip, KASAN_REPORT_DOUBLE_FREE);
 		return true;
 	}
 
@@ -377,12 +377,12 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 static inline bool ____kasan_kfree_large(void *ptr, unsigned long ip)
 {
 	if (ptr != page_address(virt_to_head_page(ptr))) {
-		kasan_report_invalid_free(ptr, ip);
+		kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
 		return true;
 	}
 
 	if (!kasan_byte_accessible(ptr)) {
-		kasan_report_invalid_free(ptr, ip);
+		kasan_report_invalid_free(ptr, ip, KASAN_REPORT_DOUBLE_FREE);
 		return true;
 	}
 
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 610d60d6e5b8..01c03e45acd4 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -125,6 +125,7 @@ static inline bool kasan_sync_fault_possible(void)
 enum kasan_report_type {
 	KASAN_REPORT_ACCESS,
 	KASAN_REPORT_INVALID_FREE,
+	KASAN_REPORT_DOUBLE_FREE,
 };
 
 struct kasan_report_info {
@@ -277,7 +278,7 @@ static inline void kasan_print_address_stack_frame(const void *addr) { }
 
 bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
-void kasan_report_invalid_free(void *object, unsigned long ip);
+void kasan_report_invalid_free(void *object, unsigned long ip, enum kasan_report_type type);
 
 struct page *kasan_addr_to_page(const void *addr);
 struct slab *kasan_addr_to_slab(const void *addr);
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index b341a191651d..fe3f606b3a98 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -176,8 +176,12 @@ static void end_report(unsigned long *flags, void *addr)
 static void print_error_description(struct kasan_report_info *info)
 {
 	if (info->type == KASAN_REPORT_INVALID_FREE) {
-		pr_err("BUG: KASAN: double-free or invalid-free in %pS\n",
-		       (void *)info->ip);
+		pr_err("BUG: KASAN: invalid-free in %pS\n", (void *)info->ip);
+		return;
+	}
+
+	if (info->type == KASAN_REPORT_DOUBLE_FREE) {
+		pr_err("BUG: KASAN: double-free in %pS\n", (void *)info->ip);
 		return;
 	}
 
@@ -433,7 +437,7 @@ static void print_report(struct kasan_report_info *info)
 	}
 }
 
-void kasan_report_invalid_free(void *ptr, unsigned long ip)
+void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_type type)
 {
 	unsigned long flags;
 	struct kasan_report_info info;
@@ -448,7 +452,7 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip)
 
 	start_report(&flags, true);
 
-	info.type = KASAN_REPORT_INVALID_FREE;
+	info.type = type;
 	info.access_addr = ptr;
 	info.first_bad_addr = kasan_reset_tag(ptr);
 	info.access_size = 0;
-- 
2.18.0

