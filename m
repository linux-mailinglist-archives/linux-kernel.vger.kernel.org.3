Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 211924E8911
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Mar 2022 19:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236122AbiC0RCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Mar 2022 13:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232480AbiC0RCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Mar 2022 13:02:15 -0400
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B02B735861
        for <linux-kernel@vger.kernel.org>; Sun, 27 Mar 2022 10:00:35 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1648400433;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=mNdfGwODQpy307VgfLm6WxBMSo9tvm6XjaGTK6OBfVE=;
        b=iphgMXGFANTgMnApo6nGOZQdSL1x+NxCCao2zcWcVYgIy/3XApMWT6d7f984sbgtRsMVwB
        KZ6P4JxKamKuFYJsYod4/r7gHM1Arg2Li8ca77TpaZU3N0iAv1XcnNWWoCqA/9WO0dF3Na
        X5GuK5Rxv71hWptLPiBnmESQPEygptY=
From:   andrey.konovalov@linux.dev
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Matthew Wilcox <willy@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH] mm, kasan: fix __GFP_BITS_SHIFT definition breaking LOCKDEP
Date:   Sun, 27 Mar 2022 19:00:23 +0200
Message-Id: <462ff52742a1fcc95a69778685737f723ee4dfb3.1648400273.git.andreyknvl@google.com>
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

KASAN changes that added new GFP flags mistakenly updated __GFP_BITS_SHIFT
as the total number of GFP bits instead of as a shift used to define
__GFP_BITS_MASK.

This broke LOCKDEP, as __GFP_BITS_MASK now gets the 25th bit enabled
instead of the 28th for __GFP_NOLOCKDEP.

Update __GFP_BITS_SHIFT to always count KASAN GFP bits.

In the future, we could handle all combinations of KASAN and LOCKDEP to
occupy as few bits as possible. For now, we have enough GFP bits to be
inefficient in this quick fix.

Fixes: 9353ffa6e9e9 ("kasan, page_alloc: allow skipping memory init for HW_TAGS")
Fixes: 53ae233c30a6 ("kasan, page_alloc: allow skipping unpoisoning for HW_TAGS")
Fixes: f49d9c5bb15c ("kasan, mm: only define ___GFP_SKIP_KASAN_POISON with HW_TAGS")
Reported-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 include/linux/gfp.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/gfp.h b/include/linux/gfp.h
index 0fa17fb85de5..761f8f1885c7 100644
--- a/include/linux/gfp.h
+++ b/include/linux/gfp.h
@@ -264,9 +264,7 @@ struct vm_area_struct;
 #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
 
 /* Room for N __GFP_FOO bits */
-#define __GFP_BITS_SHIFT (24 +						\
-			  3 * IS_ENABLED(CONFIG_KASAN_HW_TAGS) +	\
-			  IS_ENABLED(CONFIG_LOCKDEP))
+#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
 #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
 
 /**
-- 
2.25.1

