Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F26BE4CDFBF
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 22:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbiCDV0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 16:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCDV0K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 16:26:10 -0500
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D69042A0A
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 13:25:22 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id kc12so894766qvb.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 13:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=g4zsR1Wj3/3QZO0onyp15XijSsWOU/B1j8r3EXAcAjM=;
        b=rIWW6nrqGWNwH4EOFGdph8Wa3FS6RUsmbfSf8hTbthhwFAMTWtLS2KmWOI11SpQtUY
         KXoxyg/o7fSXbsW+dWmXiiUpfrOnLtVL3wq9oTJHWjWWSspd4ioDxpppGaj4TFGs7vb+
         /HVH5kv27JoDk7QvLPojlhdsIA0Jw4mRsnuyQDuLOgK69J+c2Ll1aMX4a+W8UcnL8EyQ
         Jm2QqnQ9DcQbueHfslxJH8vdSOxZWwwLcsq8bo/iT0y+K1TMvGo+wBsy69z/dB4NuGzN
         Jv0tt0Pfzqjq159m+783Gbhl+PyGhR1qNTpKjD4eem3TSng7DkZC5MZgUyy0TBHfz8s/
         Q36w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=g4zsR1Wj3/3QZO0onyp15XijSsWOU/B1j8r3EXAcAjM=;
        b=mz934w3ADT0V33cgaazDLwtbMOBkDimSkUWvle4Z4VUNUgcCLxGvmLyCyBmwJ5MejC
         mZr+br05EAM4Elb0C0LbHBtNGCZnZQmt4LtWkAlF/5c8OoR+HpVm1XXxo2xdVsgyZ6Bi
         Wb3z2ksCNNnaHXo5OG6HRt7o0+PkcTudNPFdhmjAUxZMVCYFoVHas4QXTCJXJQNe2K+x
         kZzjTTjS95Aj279zNzSAYG51+YSj2gUhPqKe/fSBdeBuqTtw/UcOjTeikYC6MBkvhV+r
         94YWmwOd4/4q+6saco1+uOgCTJkYoHWdAZKHko5ZvhdqzCI2QwnOwYcJ99FUoU3YDkQ+
         Ipww==
X-Gm-Message-State: AOAM5316Qfe4SHDq+QIAcQ1f2xOkIMZxyKVenRpeOsBTpikW+N3l7mQI
        EIC6hQ7PtVmpe1abh96B7bI+uw==
X-Google-Smtp-Source: ABdhPJzFAVY3sBGoyU6FMYgY4UuCX7qDhnqSlTDwlnSCL76wlczbZHNH1YB2GQSs/V8TnsILHIqv9Q==
X-Received: by 2002:a05:6214:c4b:b0:432:df0e:7a09 with SMTP id r11-20020a0562140c4b00b00432df0e7a09mr562317qvj.127.1646429121070;
        Fri, 04 Mar 2022 13:25:21 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id az33-20020a05620a172100b00648af7287desm2799830qkb.26.2022.03.04.13.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 13:25:20 -0800 (PST)
Date:   Fri, 4 Mar 2022 13:25:18 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Matthew Wilcox <willy@infradead.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: [PATCH mmotm v2] mm: delete __ClearPageWaiters()
In-Reply-To: <6e5262ff-8596-a86-7388-eddb2b2c53c@google.com>
Message-ID: <3eafa969-5b1a-accf-88fe-318784c791a@google.com>
References: <351df0af-78f2-c20-2a6d-e5f978e5ca1@google.com> <a2f6aa01-8003-6791-718d-3898f77ef643@redhat.com> <9dda55d5-eafa-3177-2a4c-32ccb7e146e3@google.com> <90aafe84-fe7d-c70e-8e15-c222869f30fc@redhat.com>
 <6e5262ff-8596-a86-7388-eddb2b2c53c@google.com>
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
bad_page() alerts.  So __page_cache_release(), put_pages_list() and
release_pages() (and presumably copy-and-pasted free_zone_device_page())
are redundant and misleading to make a special point of clearing it (as
the "__" implies, it could only safely be used on the freeing path).

Delete __ClearPageWaiters().  Remark on this in one of the "possible"
comments in folio_wake_bit(), and delete the superfluous comments.

Signed-off-by: Hugh Dickins <hughd@google.com>
Tested-by: Yu Zhao <yuzhao@google.com>
---
v2: Add Tested-by from Yu Zhao.
    Update to latest function names in the commit message.
    Reword comment in folio_wake_bit() per David Hildenbrand.

 include/linux/page-flags.h |  2 +-
 mm/filemap.c               | 23 ++++++++---------------
 mm/memremap.c              |  2 --
 mm/swap.c                  |  4 ----
 4 files changed, 9 insertions(+), 22 deletions(-)

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
@@ -1179,24 +1179,17 @@ static void folio_wake_bit(struct folio *folio, int bit_nr)
 	}
 
 	/*
-	 * It is possible for other pages to have collided on the waitqueue
-	 * hash, so in that case check for a page match. That prevents a long-
-	 * term waiter
+	 * It's possible to miss clearing waiters here, when we woke our page
+	 * waiters, but the hashed waitqueue has waiters for other pages on it.
+	 * That's okay, it's a rare case. The next waker will clear it.
 	 *
-	 * It is still possible to miss a case here, when we woke page waiters
-	 * and removed them from the waitqueue, but there are still other
-	 * page waiters.
+	 * Note that, depending on the page pool (buddy, hugetlb, ZONE_DEVICE,
+	 * other), the flag may be cleared in the course of freeing the page;
+	 * but that is not required for correctness.
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
