Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD5304B6116
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 03:34:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233660AbiBOCfB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 21:35:01 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbiBOCfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 21:35:00 -0500
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ACBD3AEB
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:34:50 -0800 (PST)
Received: by mail-qk1-x72f.google.com with SMTP id de39so6605775qkb.13
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 18:34:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=klh+DPqWZ+BlnUaC467qqykgES+6efAa+duJH3TYeKQ=;
        b=jBkp8ISwEWhgcDAzMbPhNGwAR1nASKVb7CoYeFtaLEF/od82lqGj5kJWJxxx3EfYvw
         HARVTVmf4PvZvD5gbkHVJGZL8Qpt7sIYLwOOI0ntN217CcbSoJjuWfBJwDPhMb66JRm+
         j5bsT6aT3EgKAVckTOcYnP3SwkxTysD8FDjEYT6RFLZSY9XIuDUZjtHMHplFrNP2sq7W
         74tuE87UchsdHKKjwsUvDOrSl3RyQRAchqim6HJRns8K/SSS8gn7WeTPMvEJk7UCSxl5
         5yP8gG5lcuD1rwU1oZ0TOUdrlpwFG874LE/tYnD9s+RijMGeRxZ4XsycvemP6XdVIg74
         LrZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=klh+DPqWZ+BlnUaC467qqykgES+6efAa+duJH3TYeKQ=;
        b=WRCgbmRLQaOEjCSENlZ1ncnr+MMrq7WRvEVuzzmZRBpgIzxhGWLQ8kfLfa6iwnZcKU
         Z7xbRV2dMi1MMEAKpoUIQoGpj09OEd2zbe8BYpxFi7kxv1U1Wtv8d57rb7VeUl+iJNwI
         PEtQ3X3iMIqYw+9sSc7900YxXKR2SrYyzAWvb8QEk/Q2lmet19HyuYvB0u/RPe8eTkEG
         40GLmC8RxjxeLKrw55Rz4y/wUo8aZ2i2YCLByofkPQQRVNRXBnMnxHyqjKPuUcvUCfMy
         9uCTUADp/GlfYyTh5m6UuZ+Mdkvk3dhYv8I5eoEPxHpbJKDFVAIozmIkY2jyuiDbPZ3m
         JDZQ==
X-Gm-Message-State: AOAM531WmlRq/muVBinCUEZqcZGuttvns8fdT/vWBb4P77utK50qZgED
        VIeACdmJxG98EZb8OQuea7Egog==
X-Google-Smtp-Source: ABdhPJzGX7gP6ZEL5R3ZPtyweqq4fZ2IbQmSK/ERVYTD1l3o8HEmWHpmokabNmD4RrCsoVQTrR9s4g==
X-Received: by 2002:a37:f902:: with SMTP id l2mr1013027qkj.392.1644892489924;
        Mon, 14 Feb 2022 18:34:49 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id bk23sm16516786qkb.3.2022.02.14.18.34.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 18:34:49 -0800 (PST)
Date:   Mon, 14 Feb 2022 18:34:46 -0800 (PST)
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
Subject: [PATCH v2 09/13] mm/munlock: delete smp_mb() from
 __pagevec_lru_add_fn()
In-Reply-To: <55a49083-37f9-3766-1de9-9feea7428ac@google.com>
Message-ID: <28a7c6ff-6270-9060-8df0-862bdcaac366@google.com>
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

My reading of comment on smp_mb__after_atomic() in __pagevec_lru_add_fn()
says that it can now be deleted; and that remains so when the next patch
is added.

Signed-off-by: Hugh Dickins <hughd@google.com>
Acked-by: Vlastimil Babka <vbabka@suse.cz>
---
v2: same as v1.

 mm/swap.c | 37 +++++++++----------------------------
 1 file changed, 9 insertions(+), 28 deletions(-)

diff --git a/mm/swap.c b/mm/swap.c
index 682a03301a2c..3f770b1ea2c1 100644
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -1025,37 +1025,18 @@ static void __pagevec_lru_add_fn(struct folio *folio, struct lruvec *lruvec)
 
 	VM_BUG_ON_FOLIO(folio_test_lru(folio), folio);
 
+	folio_set_lru(folio);
 	/*
-	 * A folio becomes evictable in two ways:
-	 * 1) Within LRU lock [munlock_vma_page() and __munlock_pagevec()].
-	 * 2) Before acquiring LRU lock to put the folio on the correct LRU
-	 *    and then
-	 *   a) do PageLRU check with lock [check_move_unevictable_pages]
-	 *   b) do PageLRU check before lock [clear_page_mlock]
-	 *
-	 * (1) & (2a) are ok as LRU lock will serialize them. For (2b), we need
-	 * following strict ordering:
-	 *
-	 * #0: __pagevec_lru_add_fn		#1: clear_page_mlock
-	 *
-	 * folio_set_lru()			folio_test_clear_mlocked()
-	 * smp_mb() // explicit ordering	// above provides strict
-	 *					// ordering
-	 * folio_test_mlocked()			folio_test_lru()
+	 * Is an smp_mb__after_atomic() still required here, before
+	 * folio_evictable() tests PageMlocked, to rule out the possibility
+	 * of stranding an evictable folio on an unevictable LRU?  I think
+	 * not, because munlock_page() only clears PageMlocked while the LRU
+	 * lock is held.
 	 *
-	 *
-	 * if '#1' does not observe setting of PG_lru by '#0' and
-	 * fails isolation, the explicit barrier will make sure that
-	 * folio_evictable check will put the folio on the correct
-	 * LRU. Without smp_mb(), folio_set_lru() can be reordered
-	 * after folio_test_mlocked() check and can make '#1' fail the
-	 * isolation of the folio whose mlocked bit is cleared (#0 is
-	 * also looking at the same folio) and the evictable folio will
-	 * be stranded on an unevictable LRU.
+	 * (That is not true of __page_cache_release(), and not necessarily
+	 * true of release_pages(): but those only clear PageMlocked after
+	 * put_page_testzero() has excluded any other users of the page.)
 	 */
-	folio_set_lru(folio);
-	smp_mb__after_atomic();
-
 	if (folio_evictable(folio)) {
 		if (was_unevictable)
 			__count_vm_events(UNEVICTABLE_PGRESCUED, nr_pages);
-- 
2.34.1

