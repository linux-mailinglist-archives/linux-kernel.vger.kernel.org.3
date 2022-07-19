Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16622578F1B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 02:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236742AbiGSAP5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 20:15:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236528AbiGSAPr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 20:15:47 -0400
Received: from out0.migadu.com (out0.migadu.com [94.23.1.103])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32293248C2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 17:15:47 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1658189745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QKjK8ZCYDbi7wJ5mRNldR0JmUEuXPl5aWvMQPqK0SzM=;
        b=NNYTqznYpLLilH6ADHz0XOEI/TSKbuz5CFblIRw1Zi+58+ebbNbin+GL4BY3SVKAONjWwn
        NGYKTUzzHGr3BJjYaa2hulM9wY5VbQ0zWFYkEsyvidYkxNfAInAxsW6zOEwZaNwV6Iti0J
        HDjcJ69PTDs68eHarA3zEtEFWuyV6PM=
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
Subject: [PATCH mm v2 33/33] kasan: better identify bug types for tag-based modes
Date:   Tue, 19 Jul 2022 02:10:13 +0200
Message-Id: <355b5734d7f70a70c87ded21b3c4267e1c401b10.1658189199.git.andreyknvl@google.com>
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

Identify the bug type for the tag-based modes based on the stack trace
entries found in the stack ring.

If a free entry is found first (meaning that it was added last), mark the
bug as use-after-free. If an alloc entry is found first, mark the bug as
slab-out-of-bounds. Otherwise, assign the common bug type.

This change returns the functionalify of the previously dropped
CONFIG_KASAN_TAGS_IDENTIFY.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/kasan/report_tags.c | 25 +++++++++++++++++++++----
 1 file changed, 21 insertions(+), 4 deletions(-)

diff --git a/mm/kasan/report_tags.c b/mm/kasan/report_tags.c
index 7e267e69ce19..cedcdc5890bc 100644
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
 
@@ -89,6 +88,13 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
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
@@ -97,8 +103,19 @@ void kasan_complete_mode_report_info(struct kasan_report_info *info)
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

