Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D4F4CAA90
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiCBQjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:39:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232862AbiCBQjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:39:41 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E02931369
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:38:58 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239137;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JGZE0bvysohYUpkupChxa3EWr4j93F81DU4moq+5lLk=;
        b=pFiF5ZBBKwtr5haHzZ+mlJbBIPwPTTGaaQU/estweYKXFq/g+JBe8ekDyrppDB98msQPnO
        MZPXUBggNulqGy/S/jMmMd7r0Mufkp/3WPqcCmDVpa+EQXPQm/NWEjD/X8xNgK3Chg+g85
        0qMysA0AKdryYWdV+sdDRlnH0dqADD4=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 12/22] kasan: simplify kasan_find_first_bad_addr call sites
Date:   Wed,  2 Mar 2022 17:36:32 +0100
Message-Id: <a49576f7a23283d786ba61579cb0c5057e8f0b9b.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Move the addr_has_metadata() check into kasan_find_first_bad_addr().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c         | 5 +----
 mm/kasan/report_generic.c | 4 ++++
 mm/kasan/report_hw_tags.c | 1 +
 mm/kasan/report_sw_tags.c | 4 ++++
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index bb4c29b439b1..a0d4a9d3f933 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -444,10 +444,7 @@ static void __kasan_report(void *addr, size_t size, bool is_write,
 	start_report(&flags, true);
 
 	info.access_addr = addr;
-	if (addr_has_metadata(addr))
-		info.first_bad_addr = kasan_find_first_bad_addr(addr, size);
-	else
-		info.first_bad_addr = addr;
+	info.first_bad_addr = kasan_find_first_bad_addr(addr, size);
 	info.access_size = size;
 	info.is_write = is_write;
 	info.ip = ip;
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 7e03cca569a7..182239ca184c 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -34,8 +34,12 @@ void *kasan_find_first_bad_addr(void *addr, size_t size)
 {
 	void *p = addr;
 
+	if (!addr_has_metadata(p))
+		return p;
+
 	while (p < addr + size && !(*(u8 *)kasan_mem_to_shadow(p)))
 		p += KASAN_GRANULE_SIZE;
+
 	return p;
 }
 
diff --git a/mm/kasan/report_hw_tags.c b/mm/kasan/report_hw_tags.c
index 5dbbbb930e7a..f3d3be614e4b 100644
--- a/mm/kasan/report_hw_tags.c
+++ b/mm/kasan/report_hw_tags.c
@@ -17,6 +17,7 @@
 
 void *kasan_find_first_bad_addr(void *addr, size_t size)
 {
+	/* Return the same value regardless of whether addr_has_metadata(). */
 	return kasan_reset_tag(addr);
 }
 
diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
index 44577b8d47a7..68724ba3d814 100644
--- a/mm/kasan/report_sw_tags.c
+++ b/mm/kasan/report_sw_tags.c
@@ -35,8 +35,12 @@ void *kasan_find_first_bad_addr(void *addr, size_t size)
 	void *p = kasan_reset_tag(addr);
 	void *end = p + size;
 
+	if (!addr_has_metadata(p))
+		return p;
+
 	while (p < end && tag == *(u8 *)kasan_mem_to_shadow(p))
 		p += KASAN_GRANULE_SIZE;
+
 	return p;
 }
 
-- 
2.25.1

