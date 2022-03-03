Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A2C54CB474
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 02:57:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbiCCB47 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 20:56:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiCCB46 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 20:56:58 -0500
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9760D140C1
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 17:56:14 -0800 (PST)
Received: by mail-ot1-x330.google.com with SMTP id u17-20020a056830231100b005ad13358af9so3306540ote.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 17:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version;
        bh=aA7IZZm4zyyhiO5xDecbrXdcaMTK2IMv+LtAOtcYUws=;
        b=UfNPa4oNTZc+bYm0qOheqHrAgDQa2Fbq+wftjdDYMglREQu0FOhiNinlLbGUmJMExn
         aElYwa/R7YjjdfXf3Akr8ghfT4Z4RwDK/HkmMj3Mt3fIKj44Jfe86teJrx89zX1TGG2Q
         Nhy6GKoafaXDSlNBfD3BJs8qXOtGkhtG67KoZLFSYkhq5mrsBSyzFrh1ctN1sPB8t+qx
         qBxjwQ7yIV875tlUD9HY9SbP6xA8cvZy8gISuXGoBBVL/L++u0Ck4y6NSUAkO/u5shPE
         E/PrhviHT3yBED6mlbRm/+3PY6rE6izYU5BPXv1gszN6HQ+UMypb1r0b1iHqW9T9KYRT
         q7tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version;
        bh=aA7IZZm4zyyhiO5xDecbrXdcaMTK2IMv+LtAOtcYUws=;
        b=zLk6pTMs+3xu0KyPd96gloEzN5p/bu00ThGiiAlnAWaB4qur3RjM5xVMF9OD0Hi5wX
         RmsAc9cvBCw3bqoev0XeGDX++XNZ3gFiovmh0iREgdWWfKHexE8d7fbBHL4oy7StDU+s
         WIQJX+IcQf49s2Oc0vTzPQLHskgFtjUDJjTAZC+5hDImdImge9cC9c/RaB3ceP8VvqWZ
         wkZmxjxqeI7UHvz4t0vwJvF2KMHfYjdsIMPL+1mZyLffhpnk4N92mjZdIdrGhc6Ohjna
         0uszQ+X5gTWRp1DiVsUBYgP7ScJA4ULVX+/m8NlLIcQKh0aRUJycd3+MuahvPtE8EVII
         e86A==
X-Gm-Message-State: AOAM530VegW0rOSieGdg5MZm5dSXxMXyk0sbITrOb/ZWXNUhnfmWGfPE
        uMCKyJSckbioCm4ExNmFIKXsHQ==
X-Google-Smtp-Source: ABdhPJxmUisfwugiR3RBhee8kl5Y+/lwmVxZqlQOEK81+pR4wIF61AxDI5Jf4JZesOO1MZ+gewdBww==
X-Received: by 2002:a05:6830:25cc:b0:5ad:7fe:3bbd with SMTP id d12-20020a05683025cc00b005ad07fe3bbdmr17009974otu.354.1646272573599;
        Wed, 02 Mar 2022 17:56:13 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q13-20020a0568080ecd00b002d44f01f1d7sm323654oiv.40.2022.03.02.17.56.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 17:56:12 -0800 (PST)
Date:   Wed, 2 Mar 2022 17:56:11 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm] mm: delete __ClearPageWaiters()
Message-ID: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The PG_waiters bit is not included in PAGE_FLAGS_CHECK_AT_FREE, and
vmscan.c's free_unref_page_list() callers rely on that not to generate
bad_page() alerts.  So __page_cache_release() and release_pages() (and
the presumably copy-and-pasted put_zone_device_private_or_public_page())
are redundant and misleading to make a special point of clearing it (as
the "__" implies, it could only safely be used on the freeing path).

Delete __ClearPageWaiters().  Remark on this in one of the "possible"
comments in wake_up_page_bit(), and delete the superfluous comments.

Signed-off-by: Hugh Dickins <hughd@google.com>
---
We've used this since 2018, and I see Yu Zhao posted similar in 2020:
https://lore.kernel.org/linux-mm/20200818184704.3625199-3-yuzhao@google.com/
I couldn't join in at that time, but think its reception was over-cautious.

 include/linux/page-flags.h |  2 +-
 mm/filemap.c               | 22 +++++++---------------
 mm/memremap.c              |  2 --
 mm/swap.c                  |  4 ----
 4 files changed, 8 insertions(+), 22 deletions(-)

--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -481,7 +481,7 @@ static unsigned long *folio_flags(struct folio *folio, unsigned n)
 	TESTSETFLAG_FALSE(uname, lname) TESTCLEARFLAG_FALSE(uname, lname)
 
 __PAGEFLAG(Locked, locked, PF_NO_TAIL)
-PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD) __CLEARPAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
+PAGEFLAG(Waiters, waiters, PF_ONLY_HEAD)
 PAGEFLAG(Error, error, PF_NO_TAIL) TESTCLEARFLAG(Error, error, PF_NO_TAIL)
 PAGEFLAG(Referenced, referenced, PF_HEAD)
 	TESTCLEARFLAG(Referenced, referenced, PF_HEAD)
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -1179,24 +1179,16 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	}
 
 	/*
-	 * It is possible for other pages to have collided on the waitqueue
-	 * hash, so in that case check for a page match. That prevents a long-
-	 * term waiter
+	 * It's possible to miss clearing waiters here, when we woke our page
+	 * waiters, but the hashed waitqueue has waiters for other pages on it.
 	 *
-	 * It is still possible to miss a case here, when we woke page waiters
-	 * and removed them from the waitqueue, but there are still other
-	 * page waiters.
+	 * That's okay, it's a rare case. The next waker will clear it. Or,
+	 * it might be left set until the page is freed: when it's masked off
+	 * with others in PAGE_FLAGS_CHECK_AT_PREP, by free_pages_prepare().
 	 */
-	if (!waitqueue_active(q) || !key.page_match) {
+	if (!waitqueue_active(q) || !key.page_match)
 		folio_clear_waiters(folio);
-		/*
-		 * It's possible to miss clearing Waiters here, when we woke
-		 * our page waiters, but the hashed waitqueue has waiters for
-		 * other pages on it.
-		 *
-		 * That's okay, it's a rare case. The next waker will clear it.
-		 */
-	}
+
 	spin_unlock_irqrestore(&q->lock, flags);
 }
 
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -487,8 +487,6 @@ void free_zone_device_page(struct page *page)
 	if (WARN_ON_ONCE(!page->pgmap->ops || !page->pgmap->ops->page_free))
 		return;
 
-	__ClearPageWaiters(page);
-
 	mem_cgroup_uncharge(page_folio(page));
 
 	/*
--- a/mm/swap.c
+++ b/mm/swap.c
@@ -97,7 +97,6 @@ static void __page_cache_release(struct page *page)
 		mod_zone_page_state(page_zone(page), NR_MLOCK, -nr_pages);
 		count_vm_events(UNEVICTABLE_PGCLEARED, nr_pages);
 	}
-	__ClearPageWaiters(page);
 }
 
 static void __put_single_page(struct page *page)
@@ -152,7 +151,6 @@ void put_pages_list(struct list_head *pages)
 			continue;
 		}
 		/* Cannot be PageLRU because it's passed to us using the lru */
-		__ClearPageWaiters(page);
 	}
 
 	free_unref_page_list(pages);
@@ -966,8 +964,6 @@ void release_pages(struct page **pages, int nr)
 			count_vm_event(UNEVICTABLE_PGCLEARED);
 		}
 
-		__ClearPageWaiters(page);
-
 		list_add(&page->lru, &pages_to_free);
 	}
 	if (lruvec)
