Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BCD55ADAB1
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:09:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237772AbiIEVIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiIEVIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:08:10 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65B91659CE
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:08:09 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412087;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QPTLEFKVNhHBs5rA/ZsHhl+NYzDo7/AO4Izo15rUT6s=;
        b=mUENtsfiNSSZ57/PzgN9pQQG9PbLHTRd+0/S6DL+XfWFSCvSqmP8o6NeEYXJ/7Q/9GOpIH
        /Huz/qHUTNMuzTMP8N3AbEEPfjGjysag9oATl7K2XsheiAQEQn21a/b8AhBpyLJaqBQv9u
        ROz61qRfhohykc9nwwnYFh7ZtMf0puI=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Peter Collingbourne <pcc@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Florian Mayer <fmayer@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm v3 17/34] kasan: only define metadata structs for Generic mode
Date:   Mon,  5 Sep 2022 23:05:32 +0200
Message-Id: <8d2aabff8c227c444a3f62edf87d5630beb77640.1662411799.git.andreyknvl@google.com>
In-Reply-To: <cover.1662411799.git.andreyknvl@google.com>
References: <cover.1662411799.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Hide the definitions of kasan_alloc_meta and kasan_free_meta under
an ifdef CONFIG_KASAN_GENERIC check, as these structures are now only
used when the Generic mode is enabled.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 6da35370ba37..cae60e4d8842 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -193,14 +193,12 @@ struct kasan_track {
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
@@ -219,12 +217,12 @@ struct qlist_node {
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

