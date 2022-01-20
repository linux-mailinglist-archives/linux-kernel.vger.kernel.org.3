Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A847049456A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 02:12:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237511AbiATBMK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 20:12:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233976AbiATBMJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 20:12:09 -0500
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A957DC061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:12:09 -0800 (PST)
Received: by mail-yb1-xb49.google.com with SMTP id z15-20020a25bb0f000000b00613388c7d99so8525086ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 17:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=tA2eESNey0k0XP9lk3g/bAUxhAQW5/EDDgeejjFfXNg=;
        b=J3HQT9krlZpsQHQTFN3l8Z8u2Xf/3ewg0BZLCCsSyi7tFH4eLStKDf57djLK731CyH
         2r766eOGcq9rdqLNOJrGcFlsrzoPV46P5LdGiKJmson3U5GH8I/is7v0u5OMLh/I51pU
         n4ocALKdQwW+oeKJENm84eCGpAsDqPaYUxQmMIBz3zGWoVWohLW3g3a+rJsXUAVzrSIl
         Ecl1bJw/BpuRnv1x/vgqFs/zDoTBSHDe1YyhkOThvZc1vjQnStHhiSL9t0CynG+n5mse
         Jw2Jhj1G8Ay/lodL/w4dwWnjl3tqe1F/qt6981+t+OpYfhWHQD9DeFMbbgOpYrTHQbuY
         cfbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=tA2eESNey0k0XP9lk3g/bAUxhAQW5/EDDgeejjFfXNg=;
        b=n5Jumd7szEjvzOt5XI9exnwvXCWs5PmcK4AWyN4JnPWiaFwIOyMn5bzxKutmZDNlDD
         Pe8d04aZ8f8e8pNkVK4jbIkLT2yI4On/G2TVpUAKUd/qeljZ3fiG1l0rR4iPqMmuMbUg
         bx4J0SW3OUjXCswDwDSrsdsH+VVCkmTT2SSBu8WtjU98cUUnJKzkahYVU9a6KOv7qT1s
         Ca/rG5sCg2oJLTvKM7vCU8lrndTTHFQiXQeOGx3F4QgAq4EKco+83spmsTLoGr6uMfi2
         plC7Uia8vLPYdjEM7Uknf4XHft8aPpyE8s+ae+Mstk0v6zRkb2pYGC6bHm7hkHZhKaq0
         9Weg==
X-Gm-Message-State: AOAM5332jH97qLWs3ogEZiSb5QUrTftCYTK7HrubKun3djwzmGPgcLzu
        yEN7bg63zHUB58/5gcfyntrPSjc=
X-Google-Smtp-Source: ABdhPJz3mwdM+0As6FN3WKubqoUI/B4hcSVbjvP6uZO/jii6WDL2eFvY2vyHyvkgUT+SrC7/zokdGqk=
X-Received: from pcc-desktop.svl.corp.google.com ([2620:15c:2ce:200:7641:d112:dd90:7ea1])
 (user=pcc job=sendgmr) by 2002:a25:bb45:: with SMTP id b5mr27616743ybk.174.1642641128808;
 Wed, 19 Jan 2022 17:12:08 -0800 (PST)
Date:   Wed, 19 Jan 2022 17:11:59 -0800
Message-Id: <20220120011200.1322836-1-pcc@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.34.1.703.g22d0c6ccf7-goog
Subject: [PATCH v2] mm/mmzone.c: use try_cmpxchg() in page_cpupid_xchg_last()
From:   Peter Collingbourne <pcc@google.com>
To:     Andrey Konovalov <andreyknvl@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Collingbourne <pcc@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This will let us avoid an additional read from page->flags when
retrying the compare-exchange on some architectures.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Peter Collingbourne <pcc@google.com>
Link: https://linux-review.googlesource.com/id/I2e1f5b5b080ac9c4e0eb7f98768dba6fd7821693
---
 mm/mmzone.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/mm/mmzone.c b/mm/mmzone.c
index eb89d6e018e2..d8a9b0e1b526 100644
--- a/mm/mmzone.c
+++ b/mm/mmzone.c
@@ -89,13 +89,14 @@ int page_cpupid_xchg_last(struct page *page, int cpupid)
 	unsigned long old_flags, flags;
 	int last_cpupid;
 
+	old_flags = READ_ONCE(page->flags);
 	do {
-		old_flags = flags = page->flags;
-		last_cpupid = page_cpupid_last(page);
+		flags = old_flags;
+		last_cpupid = (flags >> LAST_CPUPID_PGSHIFT) & LAST_CPUPID_MASK;
 
 		flags &= ~(LAST_CPUPID_MASK << LAST_CPUPID_PGSHIFT);
 		flags |= (cpupid & LAST_CPUPID_MASK) << LAST_CPUPID_PGSHIFT;
-	} while (unlikely(cmpxchg(&page->flags, old_flags, flags) != old_flags));
+	} while (unlikely(!try_cmpxchg(&page->flags, &old_flags, flags)));
 
 	return last_cpupid;
 }
-- 
2.34.1.703.g22d0c6ccf7-goog

