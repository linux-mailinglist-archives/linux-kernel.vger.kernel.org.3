Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B41454CAA74
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:37:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243012AbiCBQhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242830AbiCBQhd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:37:33 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A029CEA00
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:36:50 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239007;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ReVQg90bpO6aQ9p1E17mGNBQrTUFi/5PZoBeBo27NeE=;
        b=CkSxgq2C4AQd4Hc/5oIgvZVdzS8i0G/red+aOhMvBK+qP+KWRBe1leENjyQER0Scn8x8s+
        +JQ5jqkF9/rAvHLfhxTpE1MaNTAH3+5lHi+ABoT3biafZUWNz1r9qlaCCnYaOH+mR/AO56
        glUtZxXMxV9DzLCbZno4jG0eTH+Qnxc=
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
Subject: [PATCH mm 02/22] kasan: more line breaks in reports
Date:   Wed,  2 Mar 2022 17:36:22 +0100
Message-Id: <8682c4558e533cd0f99bdb964ce2fe741f2a9212.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Add a line break after each part that describes the buggy address.
Improves readability of reports.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 607a8c2e4674..ded648c0a0e4 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -250,11 +250,13 @@ static void print_address_description(void *addr, u8 tag)
 		void *object = nearest_obj(cache, slab,	addr);
 
 		describe_object(cache, object, addr, tag);
+		pr_err("\n");
 	}
 
 	if (kernel_or_module_addr(addr) && !init_task_stack_addr(addr)) {
 		pr_err("The buggy address belongs to the variable:\n");
 		pr_err(" %pS\n", addr);
+		pr_err("\n");
 	}
 
 	if (is_vmalloc_addr(addr)) {
@@ -265,6 +267,7 @@ static void print_address_description(void *addr, u8 tag)
 			       " [%px, %px) created by:\n"
 			       " %pS\n",
 			       va->addr, va->addr + va->size, va->caller);
+			pr_err("\n");
 
 			page = vmalloc_to_page(page);
 		}
@@ -273,9 +276,11 @@ static void print_address_description(void *addr, u8 tag)
 	if (page) {
 		pr_err("The buggy address belongs to the physical page:\n");
 		dump_page(page, "kasan: bad access detected");
+		pr_err("\n");
 	}
 
 	kasan_print_address_stack_frame(addr);
+	pr_err("\n");
 }
 
 static bool meta_row_is_guilty(const void *row, const void *addr)
@@ -382,7 +387,6 @@ void kasan_report_invalid_free(void *object, unsigned long ip)
 	kasan_print_tags(tag, object);
 	pr_err("\n");
 	print_address_description(object, tag);
-	pr_err("\n");
 	print_memory_metadata(object);
 	end_report(&flags, (unsigned long)object);
 }
@@ -443,7 +447,6 @@ static void __kasan_report(unsigned long addr, size_t size, bool is_write,
 
 	if (addr_has_metadata(untagged_addr)) {
 		print_address_description(untagged_addr, get_tag(tagged_addr));
-		pr_err("\n");
 		print_memory_metadata(info.first_bad_addr);
 	} else {
 		dump_stack_lvl(KERN_ERR);
-- 
2.25.1

