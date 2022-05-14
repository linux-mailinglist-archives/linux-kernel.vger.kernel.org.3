Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB9CA5270F9
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 14:06:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232267AbiENMGy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 08:06:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232334AbiENMGT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 08:06:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A74F5FFE
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 05:06:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5FFC260E9C
        for <linux-kernel@vger.kernel.org>; Sat, 14 May 2022 12:06:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3712AC340EE;
        Sat, 14 May 2022 12:06:02 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="ogpmZNeb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1652529960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=33xo47b+CaNNZCbSD2Thvjo0BTvMqq1Kl9unuXlBysM=;
        b=ogpmZNebYf3AyGk6kWl19WuIsLINOSWNN4yF67eaPmkjbydeIN8xEmbMe4NDp18Dgc4U/O
        KW/ikKFP2iWm6gLidtn1DNF0KazuxvcA2+JBVYRzaE5AYvWMpV+Sq1U2XKhDs24+eqCwb2
        B6qdmB7u/ofLaKvbSOq8tcnS6wmYsNQ=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id edbeab8f (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 14 May 2022 12:05:59 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: [PATCH] random: move randomize_page() into mm where it belongs
Date:   Sat, 14 May 2022 14:05:56 +0200
Message-Id: <20220514120556.363559-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

randomize_page is an mm function. It is documented like one. It contains
the history of one. It has the naming convention of one. It looks
just like another very similar function in mm, randomize_stack_top().
And it has always been maintained and updated by mm people. There is no
need for it to be in random.c. In the "which shape does not look like
the other ones" test, pointing to randomize_page() is correct.

So move randomize_page() into mm/util.c, right next to the similar
randomize_stack_top() function.

This commit contains no actual code changes.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Jason A. Donenfeld <Jason@zx2c4.com>
---
 drivers/char/random.c | 32 --------------------------------
 include/linux/mm.h    |  1 +
 mm/util.c             | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 32 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 6d8ccb200c5c..5738cab0079e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -620,38 +620,6 @@ int __cold random_prepare_cpu(unsigned int cpu)
 }
 #endif
 
-/**
- * randomize_page - Generate a random, page aligned address
- * @start:	The smallest acceptable address the caller will take.
- * @range:	The size of the area, starting at @start, within which the
- *		random address must fall.
- *
- * If @start + @range would overflow, @range is capped.
- *
- * NOTE: Historical use of randomize_range, which this replaces, presumed that
- * @start was already page aligned.  We now align it regardless.
- *
- * Return: A page aligned address within [start, start + range).  On error,
- * @start is returned.
- */
-unsigned long randomize_page(unsigned long start, unsigned long range)
-{
-	if (!PAGE_ALIGNED(start)) {
-		range -= PAGE_ALIGN(start) - start;
-		start = PAGE_ALIGN(start);
-	}
-
-	if (start > ULONG_MAX - range)
-		range = ULONG_MAX - start;
-
-	range >>= PAGE_SHIFT;
-
-	if (range == 0)
-		return start;
-
-	return start + (get_random_long() % range << PAGE_SHIFT);
-}
-
 
 /**********************************************************************
  *
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 9f44254af8ce..b0183450e484 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2677,6 +2677,7 @@ extern int install_special_mapping(struct mm_struct *mm,
 				   unsigned long flags, struct page **pages);
 
 unsigned long randomize_stack_top(unsigned long stack_top);
+unsigned long randomize_page(unsigned long start, unsigned long range);
 
 extern unsigned long get_unmapped_area(struct file *, unsigned long, unsigned long, unsigned long, unsigned long);
 
diff --git a/mm/util.c b/mm/util.c
index 3492a9e81aa3..ac63e5ca8b21 100644
--- a/mm/util.c
+++ b/mm/util.c
@@ -343,6 +343,38 @@ unsigned long randomize_stack_top(unsigned long stack_top)
 #endif
 }
 
+/**
+ * randomize_page - Generate a random, page aligned address
+ * @start:	The smallest acceptable address the caller will take.
+ * @range:	The size of the area, starting at @start, within which the
+ *		random address must fall.
+ *
+ * If @start + @range would overflow, @range is capped.
+ *
+ * NOTE: Historical use of randomize_range, which this replaces, presumed that
+ * @start was already page aligned.  We now align it regardless.
+ *
+ * Return: A page aligned address within [start, start + range).  On error,
+ * @start is returned.
+ */
+unsigned long randomize_page(unsigned long start, unsigned long range)
+{
+	if (!PAGE_ALIGNED(start)) {
+		range -= PAGE_ALIGN(start) - start;
+		start = PAGE_ALIGN(start);
+	}
+
+	if (start > ULONG_MAX - range)
+		range = ULONG_MAX - start;
+
+	range >>= PAGE_SHIFT;
+
+	if (range == 0)
+		return start;
+
+	return start + (get_random_long() % range << PAGE_SHIFT);
+}
+
 #ifdef CONFIG_ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
 unsigned long arch_randomize_brk(struct mm_struct *mm)
 {
-- 
2.35.1

