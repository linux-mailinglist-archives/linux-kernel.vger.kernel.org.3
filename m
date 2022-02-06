Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32CFD4AB274
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:44:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243247AbiBFVn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiBFVn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:43:57 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039B8C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:43:57 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id r27so15138711oiw.4
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 13:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=VKjWDSDEqSXkMBseTZ4kYaUBzUWcD2iDw3Sk4fM5TfU=;
        b=oVJyzbVxwCoRIqqb/a/jVLhXKxolruR0BPQ8MlppBLhDAxgdTVmRqTo1aYZcsaaG4g
         3xQgZjoFD68v2KcCXOqkiU/cWafPHJ+re0aEizZ7t+agvr2mUknoVNKNN4VimGs/YYFC
         tT38/gyOPGVipPYXv1SEL1yq7KCGb/m+UeDMiMXYinOrz+VvVbXl7zD6wWSKxKJznOul
         W2pFIzlEpSJdqEW0MCSuBLXTqafil/jxo19+1kIugDEwkUmODuhmfeAsWf9GCHlm9Axk
         VxoJCzuhezM3XkDxD1pq0WAq53gzsvlpI9d838/fizl5cHG5ut0LUmtUmmfLFIcZX6/a
         lXXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=VKjWDSDEqSXkMBseTZ4kYaUBzUWcD2iDw3Sk4fM5TfU=;
        b=kPN87afnnuj/CY5zFcTeFDxaHAkk5aCUUpX6ta4heCJPO2rwv86FpgagJldCVqysUH
         JVUHipxauSXLcXa2v411gpBuIj1H6Nw2xCYZK5Yu/Pnk9jND0pF98FhUeIz457GZMRpH
         RRcgNXedjQx8NTEHmDEo5fZm1HiZzA5A0bvS8rYUNxIsJfdyqqz3y3WKv6XyXH7vpsdy
         3Gxsy08OA7eD0GsBVYGWVxzHqpwa0c1AdBAIcfJ9YkGo2nh+oTEE0A3fauWVAB5vPxFA
         aa8EEssX11qgXrtpECOovlUKJZ5XXoOwFhFwFKzcUKi8CCZk5EMju8MrBSF4m4MMIR0M
         qmMA==
X-Gm-Message-State: AOAM532UdcSbUR9n4AVsZM/HR8z9E1gi+SGpVH4V2TSmDUZMlVz3BjYu
        c0HLnClCFSNDblMVSLe/mKG8qA==
X-Google-Smtp-Source: ABdhPJyHq22zIK1nECWEXuekkWijhLH6Ab/9ickoD6sMJ6sbVBKBP6Z+c1YzZyQaPuloMWoBb56QTQ==
X-Received: by 2002:a05:6808:1b0d:: with SMTP id bx13mr5911648oib.178.1644183835825;
        Sun, 06 Feb 2022 13:43:55 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id x19sm3271502otj.59.2022.02.06.13.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:43:55 -0800 (PST)
Date:   Sun, 6 Feb 2022 13:43:53 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 08/13] mm/migrate: __unmap_and_move() push good newpage to
 LRU
In-Reply-To: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
Message-ID: <33fb71cf-ea55-123a-bf9d-fdad297cae1@google.com>
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Compaction, NUMA page movement, THP collapse/split, and memory failure
do isolate unevictable pages from their "LRU", losing the record of
mlock_count in doing so (isolators are likely to use page->lru for their
own private lists, so mlock_count has to be presumed lost).

That's unfortunate, and we should put in some work to correct that: one
can imagine a function to build up the mlock_count again - but it would
require i_mmap_rwsem for read, so be careful where it's called.  Or
page_referenced_one() and try_to_unmap_one() might do that extra work.

But one place that can very easily be improved is page migration's
__unmap_and_move(): a small adjustment to where the successful new page
is put back on LRU, and its mlock_count (if any) is built back up by
remove_migration_ptes().

Signed-off-by: Hugh Dickins <hughd@google.com>
---
 mm/migrate.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/mm/migrate.c b/mm/migrate.c
index 7c4223ce2500..f4bcf1541b62 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -1032,6 +1032,21 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	if (!page_mapped(page))
 		rc = move_to_new_page(newpage, page, mode);
 
+	/*
+	 * When successful, push newpage to LRU immediately: so that if it
+	 * turns out to be an mlocked page, remove_migration_ptes() will
+	 * automatically build up the correct newpage->mlock_count for it.
+	 *
+	 * We would like to do something similar for the old page, when
+	 * unsuccessful, and other cases when a page has been temporarily
+	 * isolated from the unevictable LRU: but this case is the easiest.
+	 */
+	if (rc == MIGRATEPAGE_SUCCESS) {
+		lru_cache_add(newpage);
+		if (page_was_mapped)
+			lru_add_drain();
+	}
+
 	if (page_was_mapped)
 		remove_migration_ptes(page,
 			rc == MIGRATEPAGE_SUCCESS ? newpage : page, false);
@@ -1045,20 +1060,12 @@ static int __unmap_and_move(struct page *page, struct page *newpage,
 	unlock_page(page);
 out:
 	/*
-	 * If migration is successful, decrease refcount of the newpage
+	 * If migration is successful, decrease refcount of the newpage,
 	 * which will not free the page because new page owner increased
-	 * refcounter. As well, if it is LRU page, add the page to LRU
-	 * list in here. Use the old state of the isolated source page to
-	 * determine if we migrated a LRU page. newpage was already unlocked
-	 * and possibly modified by its owner - don't rely on the page
-	 * state.
+	 * refcounter.
 	 */
-	if (rc == MIGRATEPAGE_SUCCESS) {
-		if (unlikely(!is_lru))
-			put_page(newpage);
-		else
-			putback_lru_page(newpage);
-	}
+	if (rc == MIGRATEPAGE_SUCCESS)
+		put_page(newpage);
 
 	return rc;
 }
-- 
2.34.1

