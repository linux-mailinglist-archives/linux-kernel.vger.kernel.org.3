Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EEF84CAAA0
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:40:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243510AbiCBQk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:40:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239761AbiCBQkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:40:49 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC92CF385
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:40:04 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239203;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xoA2paey3z+FS2agG9DA8SjKlQXnu1fJwhGoHYkB4f8=;
        b=eBQyizDuePbrr86tYNcUx/vFZwzzE0ijJKaaqpwjJdXWroQKed3pkHWU/poH1HtMAoNDgZ
        cb82oWToQ1vY0PyoZz0Jrj7+JifUkj6liyEZFlH4Lofk4SwLHmtre/inkPuJwII6Tg4DH8
        yuNwZUCiYKxlOKZ4I+P7bnliTUPkhVc=
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
Subject: [PATCH mm 21/22] kasan: move and hide kasan_save_enable/restore_multi_shot
Date:   Wed,  2 Mar 2022 17:36:41 +0100
Message-Id: <6ba637333b78447f027d775f2d55ab1a40f63c99.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

- Move kasan_save_enable/restore_multi_shot() declarations to
  mm/kasan/kasan.h, as there is no need for them to be visible outside
  of KASAN implementation.

- Only define and export these functions when KASAN tests are enabled.

- Move their definitions closer to other test-related code in report.c.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/kasan.h |  4 ----
 mm/kasan/kasan.h      |  7 +++++++
 mm/kasan/report.c     | 30 +++++++++++++++++-------------
 3 files changed, 24 insertions(+), 17 deletions(-)

diff --git a/include/linux/kasan.h b/include/linux/kasan.h
index fe36215807f7..ceebcb9de7bf 100644
--- a/include/linux/kasan.h
+++ b/include/linux/kasan.h
@@ -267,10 +267,6 @@ static __always_inline bool kasan_check_byte(const void *addr)
 	return true;
 }
 
-
-bool kasan_save_enable_multi_shot(void);
-void kasan_restore_multi_shot(bool enabled);
-
 #else /* CONFIG_KASAN */
 
 static inline slab_flags_t kasan_never_merge(void)
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 9d2e128eb623..d79b83d673b1 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -492,6 +492,13 @@ static inline bool kasan_arch_is_ready(void)	{ return true; }
 #error kasan_arch_is_ready only works in KASAN generic outline mode!
 #endif
 
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST) || IS_ENABLED(CONFIG_KASAN_MODULE_TEST)
+
+bool kasan_save_enable_multi_shot(void);
+void kasan_restore_multi_shot(bool enabled);
+
+#endif
+
 /*
  * Exported functions for interfaces called from assembly or from generated
  * code. Declarations here to avoid warning about missing declarations.
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 7ef3b0455603..c9bfffe931b4 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -64,19 +64,6 @@ static int __init early_kasan_fault(char *arg)
 }
 early_param("kasan.fault", early_kasan_fault);
 
-bool kasan_save_enable_multi_shot(void)
-{
-	return test_and_set_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
-}
-EXPORT_SYMBOL_GPL(kasan_save_enable_multi_shot);
-
-void kasan_restore_multi_shot(bool enabled)
-{
-	if (!enabled)
-		clear_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
-}
-EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
-
 static int __init kasan_set_multi_shot(char *str)
 {
 	set_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
@@ -109,6 +96,23 @@ static bool report_enabled(void)
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
+#if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST) || IS_ENABLED(CONFIG_KASAN_MODULE_TEST)
+
+bool kasan_save_enable_multi_shot(void)
+{
+	return test_and_set_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
+}
+EXPORT_SYMBOL_GPL(kasan_save_enable_multi_shot);
+
+void kasan_restore_multi_shot(bool enabled)
+{
+	if (!enabled)
+		clear_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags);
+}
+EXPORT_SYMBOL_GPL(kasan_restore_multi_shot);
+
+#endif
+
 #if IS_ENABLED(CONFIG_KASAN_KUNIT_TEST)
 static void update_kunit_status(bool sync)
 {
-- 
2.25.1

