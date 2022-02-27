Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9F244C5958
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 06:22:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230026AbiB0FVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 00:21:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbiB0FVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 00:21:46 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82B0A1A9
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 21:21:07 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id j2so10784028oie.7
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 21:21:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=p2FWvVh852y2LuuIcxOEeOh71QGBakz57Fy4Yg2jNNk=;
        b=KA7CUCmtmuqwszPd+rLI9ma1GA48BscFi+N6WDfKdfsAoVrlvoilC1tabQctfgtt3M
         FcQ4B8NXp8iTxwzFiXmhyWenouBWK/KBCSdcFIye0WaFmCkg0Qdfbnd4dnjNCExcysll
         j++5OjqKJiD0rswZOI76zprXBM5FbnibqxbhC1RZDQNHNU0PNiJ4jaI5TeSc6mQEti/Q
         AhEWzKAR/Ha51rdBm2yhOqmyo7BBpqwGZSQ3RxOXhVLUsOr41MrP0f9GUg5q2dEFmBAy
         Q9TYZzN9t8nOeYluwKuE5cLUSg5FWFLhjiTy/GOls52uGKrQKpEOy4+WAJiq+XDW9hy1
         ZfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=p2FWvVh852y2LuuIcxOEeOh71QGBakz57Fy4Yg2jNNk=;
        b=joRoTG/d41q6R/7Mk7Eg3tqs4Tb0UF7z+4dYTVCuzZLrooySigbgWf7zz/cZvnRXAd
         HPFz35EvCOTOPDZybTabedpmhvMVpObxj0sMIzOC0oVdSowCAR6DrhzLW8MQSPJvO9YI
         5uukaa2APl1+SqhbsXH2UfOgXELw0JY/ib055an3gLVoFvb6uxqSN4ttatdjfOMkkgOR
         K9tc5iFqWe61B/QhNFjmFUTgie+bQ7QLrjmFI85aKatWlt8FaYzvyX4OQiBXs9A+IWYk
         n15EaCiXeFmKHXj4Zcumk6W4QenXrii+SdGgra9DBe5W4rMOrsJ6jpNzspW43YrfpwvU
         ra4g==
X-Gm-Message-State: AOAM533ke+qzg67E8LrDuyFvCIrhfUcP4gSieHtwRNuW44UksuNGDtGl
        JV98CssRTWoSuT8FMl4a1X2q5A==
X-Google-Smtp-Source: ABdhPJx6ungPL3K2I3A01hBjvb+zC2oK7mINCnfZ+jEAhf8zrgU9LlxSxNMKTYBYD1LkQHJQsjEBvw==
X-Received: by 2002:aca:4b96:0:b0:2d7:2d16:f18e with SMTP id y144-20020aca4b96000000b002d72d16f18emr6583764oia.74.1645939266668;
        Sat, 26 Feb 2022 21:21:06 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q6-20020a9d57c6000000b005ad5a1edd4csm3302900oti.22.2022.02.26.21.21.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Feb 2022 21:21:06 -0800 (PST)
Date:   Sat, 26 Feb 2022 21:20:54 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Andrew Morton <akpm@linux-foundation.org>
cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Matthew Wilcox <willy@infradead.org>, cgel.zte@gmail.com,
        kirill@shutemov.name, songliubraving@fb.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, yang.yang29@zte.com.cn,
        wang.yong12@zte.com.cn
Subject: [PATCH] memfd: fix F_SEAL_WRITE after shmem huge page allocated
In-Reply-To: <8986d97-3933-8fa7-abba-aabd67924bc2@google.com>
Message-ID: <a4f79248-df75-2c8c-3df-ba3317ccb5da@google.com>
References: <20220215073743.1769979-1-cgel.zte@gmail.com> <1f486393-3829-4618-39a1-931afc580835@oracle.com> <d6e74520-88bc-9f57-e189-8e4f389726e@google.com> <Yg5RDDRLVsuT/Rfw@casper.infradead.org> <8986d97-3933-8fa7-abba-aabd67924bc2@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-16.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FROM_FMBLA_NEWDOM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wangyong reports: after enabling tmpfs filesystem to support
transparent hugepage with the following command:

 echo always > /sys/kernel/mm/transparent_hugepage/shmem_enabled

the docker program tries to add F_SEAL_WRITE through the following
command, but it fails unexpectedly with errno EBUSY:

 fcntl(5, F_ADD_SEALS, F_SEAL_WRITE) = -1.

That is because memfd_tag_pins() and memfd_wait_for_pins() were never
updated for shmem huge pages: checking page_mapcount() against
page_count() is hopeless on THP subpages - they need to check
total_mapcount() against page_count() on THP heads only.

Make memfd_tag_pins() (compared > 1) as strict as memfd_wait_for_pins()
(compared != 1): either can be justified, but given the non-atomic
total_mapcount() calculation, it is better now to be strict.  Bear in
mind that total_mapcount() itself scans all of the THP subpages, when
choosing to take an XA_CHECK_SCHED latency break.

Also fix the unlikely xa_is_value() case in memfd_wait_for_pins(): if a
page has been swapped out since memfd_tag_pins(), then its refcount must
have fallen, and so it can safely be untagged.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Reported-by: wangyong <wang.yong12@zte.com.cn>
Signed-off-by: Hugh Dickins <hughd@google.com>
Cc: <stable@vger.kernel.org>
---
Andrew, please remove
fix-shmem-huge-page-failed-to-set-f_seal_write-attribute-problem.patch
fix-shmem-huge-page-failed-to-set-f_seal_write-attribute-problem-fix.patch
from mmotm, and replace them by this patch against 5.17-rc5:
wangyong's patch did not handle the case of pte-mapped huge pages, and I
had this one from earlier, when I found the same issue with MFD_HUGEPAGE
(but MFD_HUGEPAGE did not go in, so I didn't post this one, forgetting
the transparent_hugepage/shmem_enabled case).

 mm/memfd.c |   40 ++++++++++++++++++++++++++++------------
 1 file changed, 28 insertions(+), 12 deletions(-)

--- 5.17-rc5/mm/memfd.c
+++ linux/mm/memfd.c
@@ -31,20 +31,28 @@
 static void memfd_tag_pins(struct xa_state *xas)
 {
 	struct page *page;
-	unsigned int tagged = 0;
+	int latency = 0;
+	int cache_count;
 
 	lru_add_drain();
 
 	xas_lock_irq(xas);
 	xas_for_each(xas, page, ULONG_MAX) {
-		if (xa_is_value(page))
-			continue;
-		page = find_subpage(page, xas->xa_index);
-		if (page_count(page) - page_mapcount(page) > 1)
+		cache_count = 1;
+		if (!xa_is_value(page) &&
+		    PageTransHuge(page) && !PageHuge(page))
+			cache_count = HPAGE_PMD_NR;
+
+		if (!xa_is_value(page) &&
+		    page_count(page) - total_mapcount(page) != cache_count)
 			xas_set_mark(xas, MEMFD_TAG_PINNED);
+		if (cache_count != 1)
+			xas_set(xas, page->index + cache_count);
 
-		if (++tagged % XA_CHECK_SCHED)
+		latency += cache_count;
+		if (latency < XA_CHECK_SCHED)
 			continue;
+		latency = 0;
 
 		xas_pause(xas);
 		xas_unlock_irq(xas);
@@ -73,7 +81,8 @@ static int memfd_wait_for_pins(struct ad
 
 	error = 0;
 	for (scan = 0; scan <= LAST_SCAN; scan++) {
-		unsigned int tagged = 0;
+		int latency = 0;
+		int cache_count;
 
 		if (!xas_marked(&xas, MEMFD_TAG_PINNED))
 			break;
@@ -87,10 +96,14 @@ static int memfd_wait_for_pins(struct ad
 		xas_lock_irq(&xas);
 		xas_for_each_marked(&xas, page, ULONG_MAX, MEMFD_TAG_PINNED) {
 			bool clear = true;
-			if (xa_is_value(page))
-				continue;
-			page = find_subpage(page, xas.xa_index);
-			if (page_count(page) - page_mapcount(page) != 1) {
+
+			cache_count = 1;
+			if (!xa_is_value(page) &&
+			    PageTransHuge(page) && !PageHuge(page))
+				cache_count = HPAGE_PMD_NR;
+
+			if (!xa_is_value(page) && cache_count !=
+			    page_count(page) - total_mapcount(page)) {
 				/*
 				 * On the last scan, we clean up all those tags
 				 * we inserted; but make a note that we still
@@ -103,8 +116,11 @@ static int memfd_wait_for_pins(struct ad
 			}
 			if (clear)
 				xas_clear_mark(&xas, MEMFD_TAG_PINNED);
-			if (++tagged % XA_CHECK_SCHED)
+
+			latency += cache_count;
+			if (latency < XA_CHECK_SCHED)
 				continue;
+			latency = 0;
 
 			xas_pause(&xas);
 			xas_unlock_irq(&xas);
