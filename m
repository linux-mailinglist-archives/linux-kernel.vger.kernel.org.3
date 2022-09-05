Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3289A5ADAD0
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 23:12:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238185AbiIEVM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 17:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236817AbiIEVLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 17:11:54 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 469311A3B6
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 14:11:23 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1662412281;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T0DFoi3F6F/yHkLbxOafy4/ej0Np4BxwTKaKbEY2PpY=;
        b=ZeoiyJr1jjpFNmkmG/13VDVsI2zwOCkgFnqbQoY0OmxGj7kDqkXITogtKnu2Vk/FQ6NTK2
        RkCbHeSiCmGLbaA5/1yTvKbzKFMXrMg51IqxLvGvzMHaDaqIfF0JIYg1OYxXcSs+eq5wEV
        xCIucEo3Idwt/50BmiT7fZfQh8iRf1c=
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
Subject: [PATCH mm v3 33/34] kasan: better identify bug types for tag-based modes
Date:   Mon,  5 Sep 2022 23:05:48 +0200
Message-Id: <13ce7fa07d9d995caedd1439dfae4d51401842f2.1662411800.git.andreyknvl@google.com>
In-Reply-To: <cover.1662411799.git.andreyknvl@google.com>
References: <cover.1662411799.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Identify the bug type for the tag-based modes based on the stack trace
entries found in the stack ring.

If a free entry is found first (meaning that it was added last), mark the
bug as use-after-free. If an alloc entry is found first, mark the bug as
slab-out-of-bounds. Otherwise, assign the common bug type.

This change returns the functionalify of the previously dropped
CONFIG_KASAN_TAGS_IDENTIFY.

Reviewed-by: Marco Elver <elver@google.com>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report_tags.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 57f7355377f1..d3510424d29b 100644
--- a/mm/kasan/report_tags.c
+++ b/mm/kasan/report_tags.c
@@ -10,7 +10,7 @@
 
 extern struct kasan_stack_ring stack_ring;
 
-static const char *get_bug_type(struct kasan_report_info *info)
+static const char *get_common_bug_type(struct kasan_report_info *info)
 {
 	/*
 	 * If access_size is a negative number, then it has reason to be
@@ -37,9 +37,8 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 	bool is_free;
 	bool alloc_found = false, free_found = false;
 
-	info->bug_type = get_bug_type(info);
-
-	if (!info->cache || !info->object)
+	if (!info->cache || !info->object) {
+		info->bug_type = get_common_bug_type(info);
 		return;
 	}
 
@@ -84,6 +83,13 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 			info->free_track.pid = pid;
 			info->free_track.stack = stack;
 			free_found = true;
+
+			/*
+			 * If a free entry is found first, the bug is likely
+			 * a use-after-free.
+			 */
+			if (!info->bug_type)
+				info->bug_type = "use-after-free";
 		} else {
 			/* Second alloc of the same object. Give up. */
 			if (alloc_found)
@@ -92,8 +98,19 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
 			info->alloc_track.pid = pid;
 			info->alloc_track.stack = stack;
 			alloc_found = true;
+
+			/*
+			 * If an alloc entry is found first, the bug is likely
+			 * an out-of-bounds.
+			 */
+			if (!info->bug_type)
+				info->bug_type = "slab-out-of-bounds";
 		}
 	}
 
 	write_unlock_irqrestore(&stack_ring.lock, flags);
+
+	/* Assign the common bug type if no entries were found. */
+	if (!info->bug_type)
+		info->bug_type = get_common_bug_type(info);
 }
-- 
2.25.1

