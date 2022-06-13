Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FC7E54A083
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351359AbiFMU4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352083AbiFMUyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:54:10 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BBEF29CA9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 13:19:46 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1655151585;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgGIoP7jXmxJI/MRAshv+0ZSBU3qLuiELKkrVE3erv8=;
        b=Tx3ufgGib+OSKMRv+3CRINt/7OLqN5cTferSwJ6ogYbMF4V+m/d6x2YflQZxIH1DxTkbs+
        djLDhQRR9ITw8i3XavtHbQZ4Xi93tpCSo+pVwH6pNEdeNdh3NKk7rEyn4uB+qK7BZVTgjf
        ongP+RFoY9TadvbK5JxiwaupvUxSI3c=
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
Subject: [PATCH 27/32] kasan: introduce complete_report_info
Date:   Mon, 13 Jun 2022 22:14:18 +0200
Message-Id: <dcc8dd2856119f660f7402977de9da2b2419b175.1655150842.git.andreyknvl@google.com>
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

Introduce a complete_report_info() function that fills in the
first_bad_addr field of kasan_report_info instead of doing it in
kasan_report_*().

This function will be extended in the next patch.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h  |  5 ++++-
 mm/kasan/report.c | 17 +++++++++++++++--
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index e3f100833154..0261d1530055 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -147,12 +147,15 @@ static inline bool kasan_requires_meta(void)
 #define META_ROWS_AROUND_ADDR 2
 
 struct kasan_report_info {
+	/* Filled in by kasan_report_*(). */
 	void *access_addr;
-	void *first_bad_addr;
 	size_t access_size;
 	bool is_free;
 	bool is_write;
 	unsigned long ip;
+
+	/* Filled in by the common reporting code. */
+	void *first_bad_addr;
 };
 
 /* Do not change the struct layout: compiler ABI. */
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index cc35c8c1a367..214ba7cb654c 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -407,6 +407,17 @@ static void print_report(struct kasan_report_info *info)
 	}
 }
 
+static void complete_report_info(struct kasan_report_info *info)
+{
+	void *addr = kasan_reset_tag(info->access_addr);
+
+	if (info->is_free)
+		info->first_bad_addr = addr;
+	else
+		info->first_bad_addr = kasan_find_first_bad_addr(
+					info->access_addr, info->access_size);
+}
+
 void kasan_report_invalid_free(void *ptr, unsigned long ip)
 {
 	unsigned long flags;
@@ -423,12 +434,13 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip)
 	start_report(&flags, true);
 
 	info.access_addr = ptr;
-	info.first_bad_addr = kasan_reset_tag(ptr);
 	info.access_size = 0;
 	info.is_write = false;
 	info.is_free = true;
 	info.ip = ip;
 
+	complete_report_info(&info);
+
 	print_report(&info);
 
 	end_report(&flags, ptr);
@@ -456,12 +468,13 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	start_report(&irq_flags, true);
 
 	info.access_addr = ptr;
-	info.first_bad_addr = kasan_find_first_bad_addr(ptr, size);
 	info.access_size = size;
 	info.is_write = is_write;
 	info.is_free = false;
 	info.ip = ip;
 
+	complete_report_info(&info);
+
 	print_report(&info);
 
 	end_report(&irq_flags, ptr);
-- 
2.25.1

