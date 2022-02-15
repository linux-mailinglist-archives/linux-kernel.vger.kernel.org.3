Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B48834B6111
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:33:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233628AbiBOCdc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:33:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiBOCda (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:33:30 -0500
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7F1C5593
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:33:21 -0800 (PST)
Received: by mail-qt1-x82d.google.com with SMTP id x5so17243735qtw.10
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:33:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=hA6o7f3VWTxX95Mr0GyMKT1FTGKFiKlNt02jF6v+Tb0=;
        b=rtEYp0Pul7pel5CuZdN22/B3yxGbnNW3jrMy8534GdcI8lYDHPfs/goTA/UvG5nek9
         Wo9HEjPNtZLebFqqkeMWvo5YlcgbC0vQ2MxVDE2fLyPpEN8ztcdUQIVWst7IWcjIJ/TK
         qfhWX4SVMD1lxSp76cqbh3Kw2Vx1FKnwxo9Bc71WyCwwHGSHBcVckXz6DjlzsyigRq8w
         aX5VjHhsufzKtYGundL8X2fHKjL7Risp5ebjQ20lyljFgCNyXta2nqn/gPvvEA9jcdxG
         ENHbUeKNdW4Csx+pHVD+S+m0y/MoXleQ+aI2YObanALTvC1nHb6JKBOsvTKEwz7yzaKJ
         P2uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=hA6o7f3VWTxX95Mr0GyMKT1FTGKFiKlNt02jF6v+Tb0=;
        b=iuyXT6akiqo38oL3U8CUaOQMVIiKqOkpmInReUG8qqcaTrzt54L0JTAj9cf3nmeDBo
         7IPHdXbuZjVUumuhYH5otXs8GCDNiZtTM+zuTRF6vTHWwz1R7YxaNn6cwWb2bl8bxEQW
         lic8POGYRRqVZcsqyKWrbiEZhVbaioFLS9+Bu8fLAXG94hQZ0CGrG4Bi535sDhTD0upS
         IGUiV8U72vdUnh3qhUjkFbZneZVvhfGmcvntK8LYnUV6eUgs8ufyAAbAENLQzosaIkHb
         Y98S+QAo9JCktFte/BIMg2OGI1h/HjPWgOX56+zeEd8xE7OIfyq5SR+VTpLkjPh5lj36
         H5Ig==
X-Gm-Message-State: AOAM533tn8pNuF2EmV9wANDJTHhD9mdaRf0cgw4eO7cWa7KTczYt2mal
        VGgtt5KwpsiKWkRLPclUkgvrvw==
X-Google-Smtp-Source: ABdhPJzAV7n2bz0VYf1XZvzGWHDRqLhyqek+4Pt0HQtX7UeiNiLfzxn1drhbZ4e+Dmo3KTDseUBAdg==
X-Received: by 2002:ac8:4e86:: with SMTP id 6mr1377145qtp.84.1644892400587;
        Mon, 14 Feb 2022 18:33:20 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id u21sm18424379qtw.80.2022.02.14.18.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:33:19 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:33:17 -0800 (PST)
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
Subject: [PATCH v2 08/13] mm/migrate: __unmap_and_move() push good newpage
 to LRU
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <269eec24-978a-984a-8a85-1d29f36ad343@google.com>
References: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
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
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
v2: same as v1.

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

