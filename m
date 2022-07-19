Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68C3578F0C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:14:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiGSAOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbiGSAOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:14:42 -0400
Received: from out2.migadu.com (out2.migadu.com [188.165.223.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B9A720F
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:14:42 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189680;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zHx81bpzjWOxKC5pKO2LKT22RGKsdl7WhMonqA7gxhs=;
        b=YAVfPvuxRs6wvf02tGViw9mrXesCywMRt5a/mMyG6EVzzUWP4dYPec6nG8dgtAh//2bzev
        S2S3SltYgn5EhlOd0ebcTaES7j8evddGMUOCbG7QF0GuHWTj+RRGc1GjKqjDODT3eZniLe
        TYdLSjvJcHhUUoVU8vuvu/uP+AxPxhw=
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
Subject: [PATCH mm v2 26/33] kasan: introduce complete_report_info
Date:   Tue, 19 Jul 2022 02:10:06 +0200
Message-Id: <5ed013df1b173806eb7aecccd2254aa46d3abe56.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index 4fddfdb08abf..7e07115873d3 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -153,12 +153,15 @@ enum kasan_report_type {
 };
 
 struct kasan_report_info {
+	/* Filled in by kasan_report_*(). */
 	enum kasan_report_type type;
 	void *access_addr;
-	void *first_bad_addr;
 	size_t access_size;
 	bool is_write;
 	unsigned long ip;
+
+	/* Filled in by the common reporting code. */
+	void *first_bad_addr;
 };
 
 /* Do not change the struct layout: compiler ABI. */
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index dc38ada86f85..0c2e7a58095d 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -413,6 +413,17 @@ static void print_report(struct kasan_report_info *info)
 	}
 }
 
+static void complete_report_info(struct kasan_report_info *info)
+{
+	void *addr = kasan_reset_tag(info->access_addr);
+
+	if (info->type == KASAN_REPORT_ACCESS)
+		info->first_bad_addr = kasan_find_first_bad_addr(
+					info->access_addr, info->access_size);
+	else
+		info->first_bad_addr = addr;
+}
+
 void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_type type)
 {
 	unsigned long flags;
@@ -430,11 +441,12 @@ void kasan_report_invalid_free(void *ptr, unsigned long ip, enum kasan_report_ty
 
 	info.type = type;
 	info.access_addr = ptr;
-	info.first_bad_addr = kasan_reset_tag(ptr);
 	info.access_size = 0;
 	info.is_write = false;
 	info.ip = ip;
 
+	complete_report_info(&info);
+
 	print_report(&info);
 
 	end_report(&flags, ptr);
@@ -463,11 +475,12 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 
 	info.type = KASAN_REPORT_ACCESS;
 	info.access_addr = ptr;
-	info.first_bad_addr = kasan_find_first_bad_addr(ptr, size);
 	info.access_size = size;
 	info.is_write = is_write;
 	info.ip = ip;
 
+	complete_report_info(&info);
+
 	print_report(&info);
 
 	end_report(&irq_flags, ptr);
-- 
2.25.1

