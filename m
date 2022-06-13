Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5081E54A077
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:56:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350606AbiFMU4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:56:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351519AbiFMUxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:53:39 -0400
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 694BD186E0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:17:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vo/QgRsJex180B/MZOFV4gS3W10znq++oNOGcslvwl0=;
        b=Dl9JaXiPgE3KB2W9PytyX2Ydb8CErjoRbyqdS1Z4vTV2EHG4vJto9UgmTzKVC+tzN4k6r4
        KDwziMj6rUu7nd8whB1jFF7vvWI6sRETVADmv38Uoj7/ZNOexQsxpkRPRqeeSDyuwqGEvH
        BwEOie7GxwDdyuGfRMy3sQ8YZis7ANg=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH 17/32] kasan: only define metadata structs for Generic mode
Date:   Mon, 13 Jun 2022 22:14:08 +0200
Message-Id: <f3c8fd1efaf7f1e9a486d4acfd4f154cc546333c.1655150842.git.andreyknvl@google.com>
In-Reply-To: <cover.1655150842.git.andreyknvl@google.com>
References: <cover.1655150842.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Hide the definitions of kasan_alloc_meta and kasan_free_meta under
an ifdef CONFIG_KASAN_GENERIC check, as these structures are now only
used when the Generic mode is enabled.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index ab2cd3ff10f3..30ec9ebf52c3 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -192,14 +192,12 @@ struct kasan_track {
 	depot_stack_handle_t stack;
 };
 
+#ifdef CONFIG_KASAN_GENERIC
+
 struct kasan_alloc_meta {
 	struct kasan_track alloc_track;
-	/* Generic mode stores free track in kasan_free_meta. */
-#ifdef CONFIG_KASAN_GENERIC
+	/* Free track is stored in kasan_free_meta. */
 	depot_stack_handle_t aux_stack[2];
-#else
-	struct kasan_track free_track;
-#endif
 };
 
 struct qlist_node {
@@ -218,12 +216,12 @@ struct qlist_node {
  * After that, slab allocator stores the freelist pointer in the object.
  */
 struct kasan_free_meta {
-#ifdef CONFIG_KASAN_GENERIC
 	struct qlist_node quarantine_link;
 	struct kasan_track free_track;
-#endif
 };
 
+#endif /* CONFIG_KASAN_GENERIC */
+
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 /* Used in KUnit-compatible KASAN tests. */
 struct kunit_kasan_status {
-- 
2.25.1

