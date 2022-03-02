Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C034CAA77
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:37:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243053AbiCBQhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:37:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242840AbiCBQhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:37:35 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2CBCEA01
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:36:52 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239009;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y1tVVcjXP0EERa5LTGRHGhA3byiWB4oonSnJ546jpQY=;
        b=Lt4GrBE4AcuD8i0t9r97+W9VG/37yQMTx3JTaWtBhqz73Ts6O4gHTwfWe/kSPuGcx5X2Mo
        5T5ocOiZw0whxQHDZxGV14Ovfb18EmMLsBiOoSZhPraZ349MCqlDwi5bfAklOErZc2h5/5
        5aV2NFs1OglbiLieI37hZm7xGihH/Vs=
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
Subject: [PATCH mm 05/22] kasan: print basic stack frame info for SW_TAGS
Date:   Wed,  2 Mar 2022 17:36:25 +0100
Message-Id: <029aaa87ceadde0702f3312a34697c9139c9fb53.1646237226.git.andreyknvl@google.com>
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

Software Tag-Based mode tags stack allocations when CONFIG_KASAN_STACK
is enabled. Print task name and id in reports for stack-related bugs.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/kasan.h          |  2 +-
 mm/kasan/report_sw_tags.c | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index d1e111b7d5d8..4447df0d7343 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -274,7 +274,7 @@ void *kasan_find_first_bad_addr(void *addr, size_t size);
 const char *kasan_get_bug_type(struct kasan_access_info *info);
 void kasan_metadata_fetch_row(char *buffer, void *row);
 
-#if defined(CONFIG_KASAN_GENERIC) && defined(CONFIG_KASAN_STACK)
+#if defined(CONFIG_KASAN_STACK)
 void kasan_print_address_stack_frame(const void *addr);
 #else
 static inline void kasan_print_address_stack_frame(const void *addr) { }
diff --git a/mm/kasan/report_sw_tags.c b/mm/kasan/report_sw_tags.c
index d2298c357834..44577b8d47a7 100644
--- a/mm/kasan/report_sw_tags.c
+++ b/mm/kasan/report_sw_tags.c
@@ -51,3 +51,14 @@ void kasan_print_tags(u8 addr_tag, const void *addr)
 
 	pr_err("Pointer tag: [%02x], memory tag: [%02x]\n", addr_tag, *shadow);
 }
+
+#ifdef CONFIG_KASAN_STACK
+void kasan_print_address_stack_frame(const void *addr)
+{
+	if (WARN_ON(!object_is_on_stack(addr)))
+		return;
+
+	pr_err("The buggy address belongs to stack of task %s/%d\n",
+	       current->comm, task_pid_nr(current));
+}
+#endif
-- 
2.25.1

