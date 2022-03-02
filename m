Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B483E4CAA73
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242971AbiCBQhn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:37:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242798AbiCBQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:37:32 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F60CEA01
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:36:49 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/PNbeFwa0AFDpaFm8soBx+srw+6LkE/5medj0Pnuzw0=;
        b=dv6ARQELb9KrBwGlPNLJRXzwHGIL9vGau4uJBJnlfxJAURfUnesxoerB2uQ1mLFWWJpXCY
        eMBLw+rI7xjWi+Uqs6C7OYC65eMQkQblcKlU2uEt4dLkyYDGPGIakZh4NzoflRtxJBQp1E
        A9UTsjjFXAN48UAJzg4uhu0IIVPV10k=
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
Subject: [PATCH mm 03/22] kasan: rearrange stack frame info in reports
Date:   Wed,  2 Mar 2022 17:36:23 +0100
Message-Id: <1ee113a4c111df97d168c820b527cda77a3cac40.1646237226.git.andreyknvl@google.com>
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

- Move printing stack frame info before printing page info.

- Add object_is_on_stack() check to print_address_description()
  and add a corresponding WARNING to kasan_print_address_stack_frame().
  This looks more in line with the rest of the checks in this function
  and also allows to avoid complicating code logic wrt line breaks.

- Clean up comments related to get_address_stack_frame_info().

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c         | 12 +++++++++---
 mm/kasan/report_generic.c | 15 ++++-----------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index ded648c0a0e4..d60ee8b81e2b 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -259,6 +259,15 @@ static void print_address_description(void *addr, u8 tag)
 		pr_err("\n");
 	}
 
+	if (object_is_on_stack(addr)) {
+		/*
+		 * Currently, KASAN supports printing frame information only
+		 * for accesses to the task's own stack.
+		 */
+		kasan_print_address_stack_frame(addr);
+		pr_err("\n");
+	}
+
 	if (is_vmalloc_addr(addr)) {
 		struct vm_struct *va = find_vm_area(addr);
 
@@ -278,9 +287,6 @@ static void print_address_description(void *addr, u8 tag)
 		dump_page(page, "kasan: bad access detected");
 		pr_err("\n");
 	}
-
-	kasan_print_address_stack_frame(addr);
-	pr_err("\n");
 }
 
 static bool meta_row_is_guilty(const void *row, const void *addr)
diff --git a/mm/kasan/report_generic.c b/mm/kasan/report_generic.c
index 139615ef326b..3751391ff11a 100644
--- a/mm/kasan/report_generic.c
+++ b/mm/kasan/report_generic.c
@@ -211,6 +211,7 @@ static void print_decoded_frame_descr(const char *frame_descr)
 	}
 }
 
+/* Returns true only if the address is on the current task's stack. */
 static bool __must_check get_address_stack_frame_info(const void *addr,
 						      unsigned long *offset,
 						      const char **frame_descr,
@@ -224,13 +225,6 @@ static bool __must_check get_address_stack_frame_info(const void *addr,
 
 	BUILD_BUG_ON(IS_ENABLED(CONFIG_STACK_GROWSUP));
 
-	/*
-	 * NOTE: We currently only support printing frame information for
-	 * accesses to the task's own stack.
-	 */
-	if (!object_is_on_stack(addr))
-		return false;
-
 	aligned_addr = round_down((unsigned long)addr, sizeof(long));
 	mem_ptr = round_down(aligned_addr, KASAN_GRANULE_SIZE);
 	shadow_ptr = kasan_mem_to_shadow((void *)aligned_addr);
@@ -269,14 +263,13 @@ void kasan_print_address_stack_frame(const void *addr)
 	const char *frame_descr;
 	const void *frame_pc;
 
+	if (WARN_ON(!object_is_on_stack(addr)))
+		return;
+
 	if (!get_address_stack_frame_info(addr, &offset, &frame_descr,
 					  &frame_pc))
 		return;
 
-	/*
-	 * get_address_stack_frame_info only returns true if the given addr is
-	 * on the current task's stack.
-	 */
 	pr_err("\n");
 	pr_err("addr %px is located in stack of task %s/%d at offset %lu in frame:\n",
 	       addr, current->comm, task_pid_nr(current), offset);
-- 
2.25.1

