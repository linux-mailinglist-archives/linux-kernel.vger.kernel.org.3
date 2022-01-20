Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53BF9494EA8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 14:11:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359581AbiATNLJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 08:11:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359721AbiATNLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 08:11:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED8C9C061401
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 05:11:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C1D261755
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 13:11:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430E3C340E2;
        Thu, 20 Jan 2022 13:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642684265;
        bh=5gRZ+S+6LIfd4teIFYxNtsVZfUSw171Ca0JEDrDLF/4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Mlw3GAC5koWopaGm68URxXemQh8HaLQ0Zmq2CDL1a9nuYPXys51YP+o6rphTReBWc
         FVs0E0OcDxx6mPeYGbOwoi/HKnvTuZPqk7Pyer66k7x3NyKGIfWzhZlchcJG5xf2al
         LZy2u4vjzz5wp+8QyTslZHS1gDEUdXryQxSQcfNEkvoHrpAULEoAt3tEhIMvn7YG19
         M53SChm2cVYrTY1uG4/6ruUKvMZmegnfRiafGg8vnLP2yILI66V/lxuRGqqsOVvvmC
         aaevXnSJpk1kiDzpBuOQ77V6Zpe3fjndW7Mdc6IkjQqpIwAcj40iXBW6LJbzTtFTPk
         n+xBwaR9l6nLw==
From:   alexs@kernel.org
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Alex Shi <alexs@kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Yu Zhao <yuzhao@google.com>, Arnd Bergmann <arnd@arndb.de>,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Johannes Weiner <hannes@cmpxchg.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 4/5] mm: remove add_page_to_lru_list_tail()
Date:   Thu, 20 Jan 2022 21:10:23 +0800
Message-Id: <20220120131024.502877-5-alexs@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120131024.502877-1-alexs@kernel.org>
References: <20220120131024.502877-1-alexs@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Shi <alexs@kernel.org>

The function could be fully replaced by lruvec_add_folio_tail, no reason
to keep a duplicate one.

Signed-off-by: Alex Shi <alexs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Yu Zhao <yuzhao@google.com>
Cc: Alex Shi <alexs@kernel.org>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
---
 include/linux/mm_inline.h | 6 ------
 mm/swap.c                 | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
index 7d7abd5ff73f..4df5b39cc97b 100644
--- a/include/linux/mm_inline.h
+++ b/include/linux/mm_inline.h
@@ -102,12 +102,6 @@ void lruvec_add_folio_tail(struct lruvec *lruvec, struct folio *folio)
 	list_add_tail(&folio->lru, &lruvec->lists[lru]);
 }
 
-static __always_inline void add_page_to_lru_list_tail(struct page *page,
-				struct lruvec *lruvec)
-{
-	lruvec_add_folio_tail(lruvec, page_folio(page));
-}
-
 static __always_inline
 void lruvec_del_folio(struct lruvec *lruvec, struct folio *folio)
 {
diff --git a/mm/swap.c b/mm/swap.c
index fb101a06dce4..23c0afb76be6 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -550,7 +550,7 @@ static void lru_deactivate_file_fn(struct page *page, struct lruvec *lruvec)
 		 * The page's writeback ends up during pagevec
 		 * We move that page into tail of inactive.
 		 */
-		add_page_to_lru_list_tail(page, lruvec);
+		lruvec_add_folio_tail(lruvec, page_folio(page));
 		__count_vm_events(PGROTATED, nr_pages);
 	}
 
-- 
2.25.1

