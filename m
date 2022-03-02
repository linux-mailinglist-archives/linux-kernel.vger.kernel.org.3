Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E82734CAA9F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243501AbiCBQkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:40:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240114AbiCBQks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:40:48 -0500
Received: from out0.migadu.com (out0.migadu.com [IPv6:2001:41d0:2:267::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAD9CEA33
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:40:03 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=87o7sANrY5Obyuk6ZGRgPFc8t4HBbQ7LJJT+IQadP5M=;
        b=d1ASAWaCPabwRxpdrH/NY/MM1LnLKYv4/mm2/x3zmCQ0TPJe6nYt74oEJOUX6GzlRxJ1tX
        TMMHjPq1X51ecK0RfQA/Qgnn3XG4U8oSuGMKorU5yQucdp5EYczhmMIfFyRl1BKwohpHYn
        vzDLH7gVTyuSLZIWDIsy97pABMKQdpg=
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
Subject: [PATCH mm 19/22] kasan: respect KASAN_BIT_REPORTED in all reporting routines
Date:   Wed,  2 Mar 2022 17:36:39 +0100
Message-Id: <715e346b10b398e29ba1b425299dcd79e29d58ce.1646237226.git.andreyknvl@google.com>
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

Currently, only kasan_report() checks the KASAN_BIT_REPORTED and
KASAN_BIT_MULTI_SHOT flags.

Make other reporting routines check these flags as well.

Also add explanatory comments.

Note that the current->kasan_depth check is split out into
report_suppressed() and only called for kasan_report().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 35 ++++++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 08631d873204..ef649f5cee29 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -381,12 +381,26 @@ static void print_memory_metadata(const void *addr)
 	}
 }
 
-static bool report_enabled(void)
+/*
+ * Used to suppress reports within kasan_disable/enable_current() critical
+ * sections, which are used for marking accesses to slab metadata.
+ */
+static bool report_suppressed(void)
 {
 #if defined(CONFIG_KASAN_GENERIC) || defined(CONFIG_KASAN_SW_TAGS)
 	if (current->kasan_depth)
-		return false;
+		return true;
 #endif
+	return false;
+}
+
+/*
+ * Used to avoid reporting more than one KASAN bug unless kasan_multi_shot
+ * is enabled. Note that KASAN tests effectively enable kasan_multi_shot
+ * for their duration.
+ */
+static bool report_enabled(void)
+{
 	if (test_bit(KASAN_BIT_MULTI_SHOT, &kasan_flags))
 		return true;
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
@@ -416,6 +430,14 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip)
 	unsigned long flags;
 	struct kasan_report_info info;
 
+	/*
+	 * Do not check report_suppressed(), as an invalid-free cannot be
+	 * caused by accessing slab metadata and thus should not be
+	 * suppressed by kasan_disable/enable_current() critical sections.
+	 */
+	if (unlikely(!report_enabled()))
+		return;
+
 	start_report(&flags, true);
 
 	info.type = KASAN_REPORT_INVALID_FREE;
@@ -444,7 +466,7 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	unsigned long irq_flags;
 	struct kasan_report_info info;
 
-	if (unlikely(!report_enabled())) {
+	if (unlikely(report_suppressed()) || unlikely(!report_enabled())) {
 		ret = false;
 		goto out;
 	}
@@ -473,6 +495,13 @@ void kasan_report_async(void)
 {
 	unsigned long flags;
 
+	/*
+	 * Do not check report_suppressed(), as kasan_disable/enable_current()
+	 * critical sections do not affect Hardware Tag-Based KASAN.
+	 */
+	if (unlikely(!report_enabled()))
+		return;
+
 	start_report(&flags, false);
 	pr_err("BUG: KASAN: invalid-access\n");
 	pr_err("Asynchronous fault: no details available\n");
-- 
2.25.1

