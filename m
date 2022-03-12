Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38AE14D6B42
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 01:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiCLAGJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 19:06:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbiCLAGF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 19:06:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 732AB20F60;
        Fri, 11 Mar 2022 16:05:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06F05614DB;
        Sat, 12 Mar 2022 00:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBA8C340E9;
        Sat, 12 Mar 2022 00:04:58 +0000 (UTC)
Date:   Fri, 11 Mar 2022 19:04:57 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Beau Belgrave <beaub@linux.microsoft.com>,
        Anders Roxell <anders.roxell@linaro.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Linux Trace Devel <linux-trace-devel@vger.kernel.org>
Subject: [PATCH] tracing/user_events: Use alloc_pages instead of kzalloc()
 for register pages
Message-ID: <20220311190457.0345eeb2@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

kzalloc virtual addresses do not work with SetPageReserved, use the actual
page virtual addresses instead via alloc_pages.

The issue is reported when booting with user_events and
DEBUG_VM_PGFLAGS=y.

Also make the number of events based on the ORDER.

Link: https://lore.kernel.org/all/CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com/
Link: https://lore.kernel.org/all/20220311223028.1865-1-beaub@linux.microsoft.com/

Cc: Beau Belgrave <beaub@linux.microsoft.com>
Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 4febc1d6ae72..e10ad057e797 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -30,9 +30,10 @@
 
 /*
  * Limits how many trace_event calls user processes can create:
- * Must be multiple of PAGE_SIZE.
+ * Must be a power of two of PAGE_SIZE.
  */
-#define MAX_PAGES 1
+#define MAX_PAGE_ORDER 0
+#define MAX_PAGES (1 << MAX_PAGE_ORDER)
 #define MAX_EVENTS (MAX_PAGES * PAGE_SIZE)
 
 /* Limit how long of an event name plus args within the subsystem. */
@@ -1622,16 +1623,17 @@ static void set_page_reservations(bool set)
 
 static int __init trace_events_user_init(void)
 {
+	struct page *pages;
 	int ret;
 
 	/* Zero all bits beside 0 (which is reserved for failures) */
 	bitmap_zero(page_bitmap, MAX_EVENTS);
 	set_bit(0, page_bitmap);
 
-	register_page_data = kzalloc(MAX_EVENTS, GFP_KERNEL);
-
-	if (!register_page_data)
+	pages = alloc_pages(GFP_KERNEL | __GFP_ZERO, MAX_PAGE_ORDER);
+	if (!pages)
 		return -ENOMEM;
+	register_page_data = page_address(pages);
 
 	set_page_reservations(true);
 
@@ -1640,7 +1642,7 @@ static int __init trace_events_user_init(void)
 	if (ret) {
 		pr_warn("user_events could not register with tracefs\n");
 		set_page_reservations(false);
-		kfree(register_page_data);
+		__free_pages(pages, MAX_PAGE_ORDER);
 		return ret;
 	}
 
-- 
2.34.1

