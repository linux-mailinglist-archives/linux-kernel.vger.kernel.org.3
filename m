Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65C85453F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 20:19:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345345AbiFISTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 14:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345317AbiFISSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 14:18:55 -0400
Received: from out2.migadu.com (out2.migadu.com [IPv6:2001:41d0:2:aacc::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D61B9CF17
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 11:18:51 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1654798730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=EsGrAYAp6IJFxcDVn2/7Z4jT50O8LabBUCsC9BUqAmM=;
        b=XNdLbz37TBFf1v0b6csPsvWj5sDWbvqbE7S1KwnxS4SfiEscQLGgb7f5GXJzS9M1Gfrm0u
        tNERjdG7bv4iyPAyQkwUJmp5G6Q6965x/8gnLOV1CuT2rdkawheBHtlDCc/DurG82Y82fe
        J9SQ+dLevT+gkykVqB7AQ/67U/n49os=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH v2 1/3] mm: rename kernel_init_free_pages to kernel_init_pages
Date:   Thu,  9 Jun 2022 20:18:45 +0200
Message-Id: <1ecaffc0a9c1404d4d7cf52efe0b2dc8a0c681d8.1654798516.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

Rename kernel_init_free_pages() to kernel_init_pages(). This function is
not only used for free pages but also for pages that were just allocated.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 mm/page_alloc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index e008a3df0485..66ef8c310dce 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1296,7 +1296,7 @@ static inline bool should_skip_kasan_poison(struct page *page, fpi_t fpi_flags)
 	       PageSkipKASanPoison(page);
 }
 
-static void kernel_init_free_pages(struct page *page, int numpages)
+static void kernel_init_pages(struct page *page, int numpages)
 {
 	int i;
 
@@ -1396,7 +1396,7 @@ static __always_inline bool free_pages_prepare(struct page *page,
 			init = false;
 	}
 	if (init)
-		kernel_init_free_pages(page, 1 << order);
+		kernel_init_pages(page, 1 << order);
 
 	/*
 	 * arch_free_page() can make the page's contents inaccessible.  s390
@@ -2441,7 +2441,7 @@ inline void post_alloc_hook(struct page *page, unsigned int order,
 	}
 	/* If memory is still not initialized, do it now. */
 	if (init)
-		kernel_init_free_pages(page, 1 << order);
+		kernel_init_pages(page, 1 << order);
 	/* Propagate __GFP_SKIP_KASAN_POISON to page flags. */
 	if (kasan_hw_tags_enabled() && (gfp_flags & __GFP_SKIP_KASAN_POISON))
 		SetPageSkipKASanPoison(page);
-- 
2.25.1

