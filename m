Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440C14AB275
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 22:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243840AbiBFVp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 16:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230392AbiBFVpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 16:45:55 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A888EC061348
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 13:45:54 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id u47-20020a4a9732000000b00316d0257de0so8759212ooi.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 13:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=AZqi60Yr8HuyENh7V3NHOA86mYT9XQfDwkJWeap6Hv4=;
        b=EgwdjpiSVtHtN8gYa4GpexZ70qbUL2NhrWgKXCXX2LBjGnHl6TuVJ82lRvT9pl11bg
         GJZIbQQd9vEHvf9Zaur5QaXjfBcZlU0agDbAgqx6EwcJhU9ycAqDSyi/QUJ4XFJ9K08N
         OTfMUECr1/9GvCfG3nvoih7TFdihwBIYkxfomgc/AvmEnFFzxUAaoRPOqI1otAkhH5Vh
         DFi2Jxxxg0xETEmbuQ7CygU4Gh9Xkuh1ncDOi+CmXMyWjIvMfQfyvE3qLgldgW/7DMeW
         zorJdpcn6kqIrFJ70Po9q2a1vrjeggAUpPytS5SWHMYC5ktbrUb60kJ9zlyBYyveZZjp
         uDEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=AZqi60Yr8HuyENh7V3NHOA86mYT9XQfDwkJWeap6Hv4=;
        b=RKaHdumQb9Q5A8O9TH/IWCMfa2pniETSc2swziZvEeAHKpqW3UuNBBYfMm8/rUWCWA
         FD4dm33trCr4QKzqAIQlksRD3Fjka+vLfL4JVy2L/zl1AayZJmWb2BVHOYSI5WOzZghv
         LRhZTU9GIh8w68OLFreLhIslaFR5TTlEo2LaPFV2+YPZZa3tIFVYaEcGCfScZQ+CdBJe
         FPfgpeJUH3t0visGISKkkZlW2jRTSVnDLOoM6rRhJ3Rk17MZ+0oW1TdB+GVn0W306nq0
         qBT/s18v+cas6drVFjJUytWIASflGoUjTbnFk0yeH5z1OkVuMasjpaNv8O8a9v5/trcY
         zPmw==
X-Gm-Message-State: AOAM53368fmxPdsEq+AeTIXmEnzFu2OCpxuS3VhbwVIOqKf4qDeIU/xC
        QsN/scP2P3ncVHboBssne8utnw==
X-Google-Smtp-Source: ABdhPJwuhT+ew2mJdr3D6cKZkrBLmmLSOMdPtFq393BKGZKWDkUv4JaIpVMPIZUPwS+O+DyMnFtz2g==
X-Received: by 2002:a4a:b2ca:: with SMTP id l10mr2861159ooo.13.1644183953803;
        Sun, 06 Feb 2022 13:45:53 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id n24sm3442036oao.40.2022.02.06.13.45.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 13:45:53 -0800 (PST)
Date:   Sun, 6 Feb 2022 13:45:50 -0800 (PST)
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
Subject: [PATCH 09/13] mm/munlock: delete smp_mb() from
 __pagevec_lru_add_fn()
In-Reply-To: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com>
Message-ID: <9121d34d-4889-51f1-56c7-255138f43b8d@google.com>
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

My reading of comment on smp_mb__after_atomic() in __pagevec_lru_add_fn()
says that it can now be deleted; and that remains so when the next patch
is added.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
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

