Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC92578F06
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:14:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiGSAOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiGSAOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:14:41 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1E8CDB
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:14:40 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189679;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ypNhLiBtVU9jJolzs9O2aAagUc+2IhpYDk0p45hBQrA=;
        b=G/1EgNqikg3pnI4aNhL0ARKFC0+h3b15HwNaEnt9tbA66ZZ0v+OWh4mBrCsBZ1xcOCHYlR
        0lANCQr8pOu66DP6jCi3M2lSV1Sm4PJlmbD41OTMKK3PsH3QKruVkVbsqSkNAfoMgDcQCf
        Xj8CCKk8sRh4WRMU56bknG6cZM41aBU=
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
Subject: [PATCH mm v2 24/33] kasan: make kasan_addr_to_page static
Date:   Tue, 19 Jul 2022 02:10:04 +0200
Message-Id: <a09042721e429504d3e989a99f3e90455e19be1b.1658189199.git.andreyknvl@google.com>
In-Reply-To: <cover.1658189199.git.andreyknvl@google.com>
References: <cover.1658189199.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

As kasan_addr_to_page() is only used in report.c, rename it to
addr_to_page() and make it static.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h  | 1 -
 mm/kasan/report.c | 4 ++--
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index cca49ab029f1..4fddfdb08abf 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -291,7 +291,6 @@ bool kasan_report(unsigned long addr, size_t size,
 		bool is_write, unsigned long ip);
 void kasan_report_invalid_free(void *object, unsigned long ip, enum kasan_report_type type);
 
-struct page *kasan_addr_to_page(const void *addr);
 struct slab *kasan_addr_to_slab(const void *addr);
 
 #ifdef CONFIG_KASAN_GENERIC
diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index cd31b3b89ca1..ac526c10ebff 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -206,7 +206,7 @@ static void print_track(struct kasan_track *track, const char *prefix)
 		pr_err("(stack is not available)\n");
 }
 
-struct page *kasan_addr_to_page(const void *addr)
+static inline struct page *addr_to_page(const void *addr)
 {
 	if (virt_addr_valid(addr))
 		return virt_to_head_page(addr);
@@ -289,7 +289,7 @@ static inline bool init_task_stack_addr(const void *addr)
 
 static void print_address_description(void *addr, u8 tag)
 {
-	struct page *page = kasan_addr_to_page(addr);
+	struct page *page = addr_to_page(addr);
 	struct slab *slab = kasan_addr_to_slab(addr);
 
 	dump_stack_lvl(KERN_ERR);
-- 
2.25.1

