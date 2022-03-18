Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4B784DD3A5
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 04:41:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232236AbiCRDmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 23:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232220AbiCRDmZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 23:42:25 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8957275479
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 20:41:01 -0700 (PDT)
X-UUID: b032444fbdc44c659a7123fe95de19ea-20220318
X-UUID: b032444fbdc44c659a7123fe95de19ea-20220318
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <kuan-ying.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 462894881; Fri, 18 Mar 2022 11:40:57 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 18 Mar 2022 11:40:56 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 18 Mar 2022 11:40:56 +0800
From:   Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <chinwen.chang@mediatek.com>, <nicholas.tang@mediatek.com>,
        <yee.lee@mediatek.com>, Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mm/kmemleak: Reset tag when compare object pointer
Date:   Fri, 18 Mar 2022 11:40:48 +0800
Message-ID: <20220318034051.30687-1-Kuan-Ying.Lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When we use HW-tag based kasan and enable vmalloc support, we hit
the following bug. It is due to comparison between tagged object
and non-tagged pointer.

We need to reset the kasan tag when we need to compare tagged object
and non-tagged pointer.

[    7.690429][T400001] init: kmemleak: [name:kmemleak&]Scan area larger than object 0xffffffe77076f440
[    7.691762][T400001] init: CPU: 4 PID: 1 Comm: init Tainted: G S      W         5.15.25-android13-0-g5cacf919c2bc #1
[    7.693218][T400001] init: Hardware name: MT6983(ENG) (DT)
[    7.693983][T400001] init: Call trace:
[    7.694508][T400001] init:  dump_backtrace.cfi_jt+0x0/0x8
[    7.695272][T400001] init:  dump_stack_lvl+0xac/0x120
[    7.695985][T400001] init:  add_scan_area+0xc4/0x244
[    7.696685][T400001] init:  kmemleak_scan_area+0x40/0x9c
[    7.697428][T400001] init:  layout_and_allocate+0x1e8/0x288
[    7.698211][T400001] init:  load_module+0x2c8/0xf00
[    7.698895][T400001] init:  __se_sys_finit_module+0x190/0x1d0
[    7.699701][T400001] init:  __arm64_sys_finit_module+0x20/0x30
[    7.700517][T400001] init:  invoke_syscall+0x60/0x170
[    7.701225][T400001] init:  el0_svc_common+0xc8/0x114
[    7.701933][T400001] init:  do_el0_svc+0x28/0xa0
[    7.702580][T400001] init:  el0_svc+0x60/0xf8
[    7.703196][T400001] init:  el0t_64_sync_handler+0x88/0xec
[    7.703964][T400001] init:  el0t_64_sync+0x1b4/0x1b8
[    7.704658][T400001] init: kmemleak: [name:kmemleak&]Object 0xf5ffffe77076b000 (size 32768):
[    7.705824][T400001] init: kmemleak: [name:kmemleak&]  comm "init", pid 1, jiffies 4294894197
[    7.707002][T400001] init: kmemleak: [name:kmemleak&]  min_count = 0
[    7.707886][T400001] init: kmemleak: [name:kmemleak&]  count = 0
[    7.708718][T400001] init: kmemleak: [name:kmemleak&]  flags = 0x1
[    7.709574][T400001] init: kmemleak: [name:kmemleak&]  checksum = 0
[    7.710440][T400001] init: kmemleak: [name:kmemleak&]  backtrace:
[    7.711284][T400001] init:      module_alloc+0x9c/0x120
[    7.712015][T400001] init:      move_module+0x34/0x19c
[    7.712735][T400001] init:      layout_and_allocate+0x1c4/0x288
[    7.713561][T400001] init:      load_module+0x2c8/0xf00
[    7.714291][T400001] init:      __se_sys_finit_module+0x190/0x1d0
[    7.715142][T400001] init:      __arm64_sys_finit_module+0x20/0x30
[    7.716004][T400001] init:      invoke_syscall+0x60/0x170
[    7.716758][T400001] init:      el0_svc_common+0xc8/0x114
[    7.717512][T400001] init:      do_el0_svc+0x28/0xa0
[    7.718207][T400001] init:      el0_svc+0x60/0xf8
[    7.718869][T400001] init:      el0t_64_sync_handler+0x88/0xec
[    7.719683][T400001] init:      el0t_64_sync+0x1b4/0x1b8

Signed-off-by: Kuan-Ying Lee <Kuan-Ying.Lee@mediatek.com>
---
 mm/kmemleak.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index 7580baa76af1..acd7cbb82e16 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -796,6 +796,8 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 	unsigned long flags;
 	struct kmemleak_object *object;
 	struct kmemleak_scan_area *area = NULL;
+	unsigned long untagged_ptr;
+	unsigned long untagged_objp;
 
 	object = find_and_get_object(ptr, 1);
 	if (!object) {
@@ -804,6 +806,9 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 		return;
 	}
 
+	untagged_ptr = (unsigned long)kasan_reset_tag((void *)ptr);
+	untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);
+
 	if (scan_area_cache)
 		area = kmem_cache_alloc(scan_area_cache, gfp_kmemleak_mask(gfp));
 
@@ -815,8 +820,8 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 		goto out_unlock;
 	}
 	if (size == SIZE_MAX) {
-		size = object->pointer + object->size - ptr;
-	} else if (ptr + size > object->pointer + object->size) {
+		size = untagged_objp + object->size - untagged_ptr;
+	} else if (untagged_ptr + size > untagged_objp + object->size) {
 		kmemleak_warn("Scan area larger than object 0x%08lx\n", ptr);
 		dump_object_info(object);
 		kmem_cache_free(scan_area_cache, area);
-- 
2.18.0

