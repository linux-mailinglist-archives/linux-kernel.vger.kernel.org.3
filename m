Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 310974BFF14
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 17:42:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234266AbiBVQnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 11:43:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234249AbiBVQnN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 11:43:13 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 198E1C7D6E
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 08:42:47 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1645548166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ZEtbE1Y1jeIgzgzA2TFDElC+yLbMe5ouicxIZ65PMO0=;
        b=L0rb8ZSbl/SnmXwb18UCF+iWR3hLMGloKfnfY++ehSwVZXNKDdgA7ogght5RzDBkphCIJ0
        B4a9VWn0H9cvrJA+gEaWnDIA5Cxt8TnFTdLp+nW0UNiAT90aXcSsbQ0DJgj0LT7sgE04lc
        i0bGj+oH0iQrA5yhpdAbxfBDqbspqMo=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm] kasan: print virtual mapping info in reports
Date:   Tue, 22 Feb 2022 17:42:44 +0100
Message-Id: <6ebb11210ae21253198e264d4bb0752c1fad67d7.1645548053.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Print virtual mapping range and its creator in reports affecting virtual
mappings.

Also get physical page pointer for such mappings, so page information
gets printed as well.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Note: no need to merge this patch into any of the KASAN vmalloc patches
that are already in mm, better to keep it separate.

Changes v1->v2:
- Add find_vm_area() return value NULL check as suggested by Mark Rutland.
---
 mm/kasan/report.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 137c2c0b09db..f64352008bb8 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -260,8 +260,21 @@ static void print_address_description(void *addr, u8 tag)
 		pr_err(" %pS\n", addr);
 	}
 
+	if (is_vmalloc_addr(addr)) {
+		struct vm_struct *va = find_vm_area(addr);
+
+		if (va) {
+			pr_err("The buggy address belongs to the virtual mapping at\n"
+			       " [%px, %px) created by:\n"
+			       " %pS\n",
+			       va->addr, va->addr + va->size, va->caller);
+
+			page = vmalloc_to_page(page);
+		}
+	}
+
 	if (page) {
-		pr_err("The buggy address belongs to the page:\n");
+		pr_err("The buggy address belongs to the physical page:\n");
 		dump_page(page, "kasan: bad access detected");
 	}
 
-- 
2.25.1

