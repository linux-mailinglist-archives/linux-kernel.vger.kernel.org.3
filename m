Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D2835453F7
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345335AbiFISS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233182AbiFISSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:18:55 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF143AE822
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:18:52 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654798731;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fO4jbpVApVQcfTPwx9gBa9O1ee1UTzsQG3M5HGLfNnA=;
        b=Xa3doeBqLfHwMDbSeTb4ZiFXvBmIjIofPaa33n/qvrG/uWiPfuEdLm4uM0UENmXHeStFzI
        05B2JyJIU0BKhPX6l1OEPU9ljfiSO4uJc8a8Ta+g8lK5davYDlg+I/F1PNsr9pOnGgg1I3
        Or3TzC6G5wLjJyGaTo+AhgrnmvED5fw=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 2/3] mm: introduce clear_highpage_kasan_tagged
Date:   Thu,  9 Jun 2022 20:18:46 +0200
Message-Id: <4471979b46b2c487787ddcd08b9dc5fedd1b6ffd.1654798516.git.andreyknvl@google.com>
In-Reply-To: <1ecaffc0a9c1404d4d7cf52efe0b2dc8a0c681d8.1654798516.git.andreyknvl@google.com>
References: <1ecaffc0a9c1404d4d7cf52efe0b2dc8a0c681d8.1654798516.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add a clear_highpage_kasan_tagged() helper that does clear_highpage()
on a page potentially tagged by KASAN.

This helper is used by the following patch.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

---

Changes v1->v2:
- Renamed clear_highpage_tagged() to clear_highpage_kasan_tagged().
- Removed extra empty line in clear_highpage_kasan_tagged().
---
 include/linux/highmem.h | 10 ++++++++++
 mm/page_alloc.c         |  8 ++------
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 3af34de54330..70b496bbd2d9 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -243,6 +243,16 @@ static inline void clear_highpage(struct page *page)
 	kunmap_local(kaddr);
 }
 
+static inline void clear_highpage_kasan_tagged(struct page *page)
+{
+	u8 tag;
+
+	tag = page_kasan_tag(page);
+	page_kasan_tag_reset(page);
+	clear_highpage(page);
+	page_kasan_tag_set(page, tag);
+}
+
 #ifndef __HAVE_ARCH_TAG_CLEAR_HIGHPAGE
 
 static inline void tag_clear_highpage(struct page *page)
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 66ef8c310dce..76a02255f57c 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1302,12 +1302,8 @@ static void kernel_init_pages(struct page *page, int numpages)
 
 	/* s390's use of memset() could override KASAN redzones. */
 	kasan_disable_current();
-	for (i = 0; i < numpages; i++) {
-		u8 tag = page_kasan_tag(page + i);
-		page_kasan_tag_reset(page + i);
-		clear_highpage(page + i);
-		page_kasan_tag_set(page + i, tag);
-	}
+	for (i = 0; i < numpages; i++)
+		clear_highpage_kasan_tagged(page + i);
 	kasan_enable_current();
 }
 
-- 
2.25.1

