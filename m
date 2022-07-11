Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B979567710
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 21:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbiGETBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 15:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230205AbiGETBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 15:01:41 -0400
Received: from smtp.smtpout.orange.fr (smtp02.smtpout.orange.fr [80.12.242.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E61AE12AC9
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 12:01:39 -0700 (PDT)
Received: from pop-os.home ([90.11.190.129])
        by smtp.orange.fr with ESMTPA
        id 8nniozMgNgoLG8nnioHgwV; Tue, 05 Jul 2022 21:01:37 +0200
X-ME-Helo: pop-os.home
X-ME-Auth: YWZlNiIxYWMyZDliZWIzOTcwYTEyYzlhMmU3ZiQ1M2U2MzfzZDfyZTMxZTBkMTYyNDBjNDJlZmQ3ZQ==
X-ME-Date: Tue, 05 Jul 2022 21:01:37 +0200
X-ME-IP: 90.11.190.129
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-perf-users@vger.kernel.org
Subject: [PATCH] uprobes: Use the bitmap API to allocate bitmaps
Date:   Tue,  5 Jul 2022 21:01:33 +0200
Message-Id: <90858b515127a99d0bcb989a16b5d88829abfce2.1657047672.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use bitmap_zalloc()/bitmap_free() instead of hand-writing them.

It is less verbose and it improves the semantic.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
Out of curiosity, is it normal to have __free_page() in the error handling
path of __create_xol_area() and put_page() in uprobe_clear_state()?

uprobe_clear_state() seems to release the resources allocated in
__create_xol_area(), but the implementation of __free_page() and of
put_page() look quite different.

This is maybe perfectly correct, but looks odd to me.
---
 kernel/events/uprobes.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index 401bc2d24ce0..83fb62eed9c6 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -1485,8 +1485,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 	if (unlikely(!area))
 		goto out;
 
-	area->bitmap = kcalloc(BITS_TO_LONGS(UINSNS_PER_PAGE), sizeof(long),
-			       GFP_KERNEL);
+	area->bitmap = bitmap_zalloc(UINSNS_PER_PAGE, GFP_KERNEL);
 	if (!area->bitmap)
 		goto free_area;
 
@@ -1510,7 +1509,7 @@ static struct xol_area *__create_xol_area(unsigned long vaddr)
 
 	__free_page(area->pages[0]);
  free_bitmap:
-	kfree(area->bitmap);
+	bitmap_free(area->bitmap);
  free_area:
 	kfree(area);
  out:
@@ -1551,7 +1550,7 @@ void uprobe_clear_state(struct mm_struct *mm)
 		return;
 
 	put_page(area->pages[0]);
-	kfree(area->bitmap);
+	bitmap_free(area->bitmap);
 	kfree(area);
 }
 
-- 
2.34.1

