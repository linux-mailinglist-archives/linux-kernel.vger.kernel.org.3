Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53A6F5ADAC6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiIEVLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237440AbiIEVLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:11:01 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59DB72250C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:10:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vX65IvaMkEV2nE74f0VGWlIcO5REzzEOQVG3jlGiFU0=;
        b=iLcEJBbWrHxEvOCEUW0Nx+EFmd6xHROIvcpb5oFWtuLWNS3j4x85eWyhS/nQCqKvhQFY+9
        DZlhZZ6zIR0Jqhe/YPyXARUvqFh4uR/0eIygdiza2I+gSgeBeN1AdVl6C6TLGQEnT5e8r/
        xpqrVEk1zG6Wg7hVB7ThRMhkc/m8S3w=
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
Subject: [PATCH mm v3 26/34] kasan: introduce complete_report_info
Date:   Mon,  5 Sep 2022 23:05:41 +0200
Message-Id: <8eb1a9bd01f5d31eab4524da54a101b8720b469e.1662411799.git.andreyknvl@google.com>
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

Introduce a complete_report_info() function that fills in the
first_bad_addr field of kasan_report_info instead of doing it in
kasan_report_*().

This function will be extended in the next patch.

Reviewed-by: Marco Elver <elver@google.com>
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

