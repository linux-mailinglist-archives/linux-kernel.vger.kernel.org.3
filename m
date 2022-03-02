Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A73C64CAA93
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:39:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242177AbiCBQj6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:39:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239208AbiCBQjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:39:45 -0500
Received: from out1.migadu.com (out1.migadu.com [91.121.223.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CBE963BCB
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:39:01 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239139;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9LoFBOx+41NuRW+TN1sbV0xBqJ4TCv0zuyZEci6w9hM=;
        b=akh6ZCXAq6FQiLjzz0h/T1o90vGgV7kP6AJdUAegzuJcUmFmx91g40h8iMe6ExZqRMVg8R
        8vORXjnqmTNanqHasHPqrgDKVLA2b5UP/6An2XkkoipMm/2RQn3mf4ibXNC/PyVtnaQaIe
        NfFWVZDuiLbt7SARW7bRtOptFFXS3RE=
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
Subject: [PATCH mm 16/22] kasan: move and simplify kasan_report_async
Date:   Wed,  2 Mar 2022 17:36:36 +0100
Message-Id: <52d942ef3ffd29bdfa225bbe8e327bc5bda7ab09.1646237226.git.andreyknvl@google.com>
In-Reply-To: <cover.1646237226.git.andreyknvl@google.com>
References: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Place kasan_report_async() next to the other main reporting routines.
Also simplify printed information.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/mm/kasan/report.c b/mm/kasan/report.c
index 73348f83b813..162fd2d6209e 100644
--- a/mm/kasan/report.c
+++ b/mm/kasan/report.c
@@ -392,20 +392,6 @@ static bool report_enabled(void)
 	return !test_and_set_bit(KASAN_BIT_REPORTED, &kasan_flags);
 }
 
-#ifdef CONFIG_KASAN_HW_TAGS
-void kasan_report_async(void)
-{
-	unsigned long flags;
-
-	start_report(&flags, false);
-	pr_err("BUG: KASAN: invalid-access\n");
-	pr_err("Asynchronous mode enabled: no access details available\n");
-	pr_err("\n");
-	dump_stack_lvl(KERN_ERR);
-	end_report(&flags, NULL);
-}
-#endif /* CONFIG_KASAN_HW_TAGS */
-
 static void print_report(struct kasan_access_info *info)
 {
 	void *tagged_addr = info->access_addr;
@@ -477,6 +463,20 @@ bool kasan_report(unsigned long addr, size_t size, bool is_write,
 	return ret;
 }
 
+#ifdef CONFIG_KASAN_HW_TAGS
+void kasan_report_async(void)
+{
+	unsigned long flags;
+
+	start_report(&flags, false);
+	pr_err("BUG: KASAN: invalid-access\n");
+	pr_err("Asynchronous fault: no details available\n");
+	pr_err("\n");
+	dump_stack_lvl(KERN_ERR);
+	end_report(&flags, NULL);
+}
+#endif /* CONFIG_KASAN_HW_TAGS */
+
 #ifdef CONFIG_KASAN_INLINE
 /*
  * With CONFIG_KASAN_INLINE, accesses to bogus pointers (outside the high
-- 
2.25.1

