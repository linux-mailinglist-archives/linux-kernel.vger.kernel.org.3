Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4C794D6A64
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:26:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiCKWwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:52:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiCKWwL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:52:11 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C4AC8ECB1B;
        Fri, 11 Mar 2022 14:30:32 -0800 (PST)
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4260520B7178;
        Fri, 11 Mar 2022 14:30:32 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4260520B7178
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1647037832;
        bh=N1x1V2sY7mMppzWbWx3qgkpf7QBnkkPjK7jq4FHoask=;
        h=From:To:Cc:Subject:Date:From;
        b=NJ+BUV1i55rgsecezhByakHPZ4Hzs5zerEkLc++lG+THztYBUCt9sJxZPHAwh3Tx9
         BlSJVyCIivEa8CeF1nXyI4ylhSpouIuWNL1g61LVAJ4DonI3AF0YNovCTNJQ7mjSFb
         QPSISgmiIx2mrTPp7SHZ+7/QaGyAwLbCjibUXvVM=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     anders.roxell@linaro.org, linux-trace-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH] user_events: Use alloc_pages instead of kzalloc for register pages
Date:   Fri, 11 Mar 2022 14:30:28 -0800
Message-Id: <20220311223028.1865-1-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

kzalloc virtual addresses do not work with SetPageReserved, use the
actual page virtual addresses instead via alloc_pages.

The issue is reported when booting with user_events and
DEBUG_VM_PGFLAGS=y.

Link: https://lore.kernel.org/linux-trace-devel/CADYN=9+xY5Vku3Ws5E9S60SM5dCFfeGeRBkmDFbcxX0ZMoFing@mail.gmail.com/#R

Reported-by: Anders Roxell <anders.roxell@linaro.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 2b5e9fdb63a0..59c900789757 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1587,16 +1587,20 @@ static void set_page_reservations(bool set)
 static int __init trace_events_user_init(void)
 {
 	int ret;
+	struct page *register_pages;
 
 	/* Zero all bits beside 0 (which is reserved for failures) */
 	bitmap_zero(page_bitmap, MAX_EVENTS);
 	set_bit(0, page_bitmap);
 
-	register_page_data = kzalloc(MAX_EVENTS, GFP_KERNEL);
+	register_pages = alloc_pages(GFP_KERNEL | __GFP_ZERO,
+				     get_order(MAX_EVENTS));
 
-	if (!register_page_data)
+	if (!register_pages)
 		return -ENOMEM;
 
+	register_page_data = page_address(register_pages);
+
 	set_page_reservations(true);
 
 	ret = create_user_tracefs();
@@ -1604,7 +1608,7 @@ static int __init trace_events_user_init(void)
 	if (ret) {
 		pr_warn("user_events could not register with tracefs\n");
 		set_page_reservations(false);
-		kfree(register_page_data);
+		__free_pages(register_pages, get_order(MAX_EVENTS));
 		return ret;
 	}
 

base-commit: 864ea0e10cc90416a01b46f0d47a6f26dc020820
-- 
2.17.1

