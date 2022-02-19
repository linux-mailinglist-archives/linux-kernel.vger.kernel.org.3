Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 743B34BC997
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 18:49:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242719AbiBSRuG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 12:50:06 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236566AbiBSRuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 12:50:05 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710655C858
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 09:49:45 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id e129-20020a25d387000000b006245d830ca6so2673658ybf.13
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 09:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=g6NUY8tWVaq9hcc+7rvde17O72ywerB7Kw8Oqcv6Cb8=;
        b=O7hSka9m0Losb8V4/MYsnc1jyzFMyVcjtIBwf5aOuBQhnKI5PJ5SUJZLQDdthEGXkf
         oKvbQRTnBPz85wCj9iCvNyZAchcUULrl9UbaFw38VP4rek0jLNzck2VSqE5MzSBEAPvi
         BcURtgl4WRLsAhlnSTGJenIqDNWF5A7Gm7JxV/jj2nfv3Uox4GSokTaqUmW+Aq+vseEb
         5Eb26fIhmLlqmRkqLFG3uUq4l9NHZz9KphHZD3NqexhGND7e2Hdrwjp8TrvZfIJyHSKC
         jtRSzKAd/wJq96JuQXDifhX/Kphnt6w5DUdeE8JawqjgxYAxwfKUw9we7FA/26OqIRRy
         Lx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=g6NUY8tWVaq9hcc+7rvde17O72ywerB7Kw8Oqcv6Cb8=;
        b=AuXGrNAUWb8egFGEpevclYol+99pYUjFoJYBVxDGr5k5NB73FT6hZsdxKBI3OXKauf
         QBXS3KEoCH7iZsplobOcBNPXz0BeMTWaC0v8qgg9QQl5zmtOLogJ5FQsTCIU2VmZAGYj
         WWf87kB1yFtjnMqVLGTgQNv1ulQkFThq/Yx7hNTXs5WGRHkhyuCfPYi0rfvlzMMg2bOB
         URTER+q+cLYXD/xF01KwY0yq4eAQcA6zuH79dLxqUc3KKy3fNHG4PQGYBmUDvveQUmBq
         ZTYxH+31u+KDKpu5Allw2hHxGUPaH6DzKniEPwRqZcivbSJf1NSqqAUEl745EUS3wGTq
         hKVg==
X-Gm-Message-State: AOAM5326l+oJxkIknQqNFHwfki0jKSNCPN3zZigRrdvphhvdr6PeMX62
        UBr4VmKeRaH3yhTVy2Me+ICyNQjVMzs=
X-Google-Smtp-Source: ABdhPJwf14QjNvOBlEKfJtniVeJfLtC2EP2lzgT+pRF8F00YZc/vptpdnJGB4C1slL1oxsIeafyrTGtmROs=
X-Received: from surenb-desktop.mtv.corp.google.com ([2620:15c:211:200:cbd0:4467:228e:5eea])
 (user=surenb job=sendgmr) by 2002:a25:bdc9:0:b0:61d:dfc5:a755 with SMTP id
 g9-20020a25bdc9000000b0061ddfc5a755mr11864217ybk.357.1645292984665; Sat, 19
 Feb 2022 09:49:44 -0800 (PST)
Date:   Sat, 19 Feb 2022 09:49:40 -0800
Message-Id: <20220219174940.2570901-1-surenb@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.35.1.473.g83b2b277ed-goog
Subject: [PATCH 1/1] mm: count time in drain_all_pages during direct reclaim
 as memory pressure
From:   Suren Baghdasaryan <surenb@google.com>
To:     akpm@linux-foundation.org
Cc:     hannes@cmpxchg.org, mhocko@suse.com, peterz@infradead.org,
        guro@fb.com, shakeelb@google.com, minchan@kernel.org,
        timmurray@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kernel-team@android.com,
        surenb@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When page allocation in direct reclaim path fails, the system will
make one attempt to shrink per-cpu page lists and free pages from
high alloc reserves. Draining per-cpu pages into buddy allocator can
be a very slow operation because it's done using workqueues and the
task in direct reclaim waits for all of them to finish before
proceeding. Currently this time is not accounted as psi memory stall.

While testing mobile devices under extreme memory pressure, when
allocations are failing during direct reclaim, we notices that psi
events which would be expected in such conditions were not triggered.
After profiling these cases it was determined that the reason for
missing psi events was that a big chunk of time spent in direct
reclaim is not accounted as memory stall, therefore psi would not
reach the levels at which an event is generated. Further investigation
revealed that the bulk of that unaccounted time was spent inside
drain_all_pages call.

Annotate drain_all_pages and unreserve_highatomic_pageblock during
page allocation failure in the direct reclaim path so that delays
caused by these calls are accounted as memory stall.

Reported-by: Tim Murray <timmurray@google.com>
Signed-off-by: Suren Baghdasaryan <surenb@google.com>
---
 mm/page_alloc.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 3589febc6d31..7fd0d392b39b 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4639,8 +4639,12 @@ __alloc_pages_direct_reclaim(gfp_t gfp_mask, unsigned int order,
 	 * Shrink them and try again
 	 */
 	if (!page && !drained) {
+		unsigned long pflags;
+
+		psi_memstall_enter(&pflags);
 		unreserve_highatomic_pageblock(ac, false);
 		drain_all_pages(NULL);
+		psi_memstall_leave(&pflags);
 		drained = true;
 		goto retry;
 	}
-- 
2.35.1.473.g83b2b277ed-goog

