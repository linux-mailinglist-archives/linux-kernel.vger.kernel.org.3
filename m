Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC0850AD90
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 04:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443222AbiDVCBh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 22:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233228AbiDVCBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 22:01:35 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8A44A3F6
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:58:44 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 204so4927777qkg.5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 18:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uLSUoJVHY9YahU9ZfsHKs+fyZqAXDk9bw1q64p7TeGw=;
        b=SDDQDb+KtvzNlx1BiMLG+U3FNgd0ZIbI/xsjbp7+9yewARhdm04dup8G+/5HX//eVy
         F2Z2xyLQvxf1fyXUT1W3quthdRjk3qgCLxDUwABX661x7XiB4somepwjjULpOlxtC72t
         FGShHCCXiI2JXXLVF8sYaNSZJFvIk3YpS4BbdYHsZ50CUvObGdd2bnGkgmbjfI+U2W3W
         x9v7PA2byW9YpJhJKJt0ugCEbILsbD8dPu81W1jy//mzEbgopMP1kk+bhMtx8nlklWFG
         OICnj8fQaW1lK5ejKQH9WlNaTCBA/5yQ6iewZ6TxRiFlp13hCfK1Cdh9y0PjINGBiCVj
         tsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uLSUoJVHY9YahU9ZfsHKs+fyZqAXDk9bw1q64p7TeGw=;
        b=SPCQruILNuSy5sLC2VKBdUIoZYP+UtccOo/0HMSohYqFKcPF8mktIFyKpMaduCt970
         RRlX8xPapZflHNMz6syJSywCXYE6kZ7F1PXxtVfldTy1E52jpVnrka0UyM2Q+4C/65Gc
         qvrFuvcnXxSXvG8XEHAPxdUeRs8XbPQcJhfNGHkc0YPxAegvh2vZfQtt+Gd/Z4gNMK8k
         1vVQWmldzpG/YIpdOWn3Uuqn6uuJPzsKvvQ9jn4At/jX424CBPMACiDcrwq7jQTYqNDC
         2gYqDUsm20+QF+jCUit6ApXkqPxUdBQBk0Zs2b5wrsewScCt4pmgqF9Y4bvmTyqLojcH
         M5Sg==
X-Gm-Message-State: AOAM532LHyuJC6UgYxv9QANYo/KRdPP4A7iuPBG8VTaTgYH20jnRrZrT
        Qacr1sci79tg47KX054+Pt0=
X-Google-Smtp-Source: ABdhPJwbb+hX1GyuoG6RhLXFmap/nHREn/i7hG1lL8BKFt76KqbGGPIv5RjssMe27P0pNe+Iy6R3JA==
X-Received: by 2002:a05:620a:2416:b0:69f:534:4a37 with SMTP id d22-20020a05620a241600b0069f05344a37mr1348217qkn.527.1650592723047;
        Thu, 21 Apr 2022 18:58:43 -0700 (PDT)
Received: from localhost ([2601:c4:c432:668:da50:5094:8aba:8f5e])
        by smtp.gmail.com with ESMTPSA id t10-20020a05620a034a00b0069c06c95bf7sm322910qkm.14.2022.04.21.18.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 18:58:42 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH v2] mm/gup: fix comments to pin_user_pages_*()
Date:   Thu, 21 Apr 2022 18:58:39 -0700
Message-Id: <20220422015839.1274328-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pin_user_pages API forces FOLL_PIN in gup_flags, which means that the
API requires struct page **pages to be provided (not NULL). However, the
comment to pin_user_pages() clearly allows for passing in a NULL @pages
argument.

Remove the incorrect comments, and add WARN_ON_ONCE(!pages) calls to
enforce the API.

It has been independently spotted by Minchan Kim and confirmed with
John Hubbard:

https://lore.kernel.org/all/YgWA0ghrrzHONehH@google.com/

CC: Minchan Kim <minchan@kernel.org>
CC: John Hubbard <jhubbard@nvidia.com>
Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
---

v1: https://lore.kernel.org/linux-mm/92a2715c-3c98-251d-9195-872d1cf01f9d@nvidia.com/#t
v2: Remove comment for WARN_ON_ONCE() and reword commit message.
  
 mm/gup.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/mm/gup.c b/mm/gup.c
index f598a037eb04..b1e96b6192de 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -2871,6 +2871,9 @@ int pin_user_pages_fast(unsigned long start, int nr_pages,
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(!pages))
+		return -EINVAL;
+
 	gup_flags |= FOLL_PIN;
 	return internal_get_user_pages_fast(start, nr_pages, gup_flags, pages);
 }
@@ -2893,6 +2896,9 @@ int pin_user_pages_fast_only(unsigned long start, int nr_pages,
 	 */
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return 0;
+
+	if (WARN_ON_ONCE(!pages))
+		return 0;
 	/*
 	 * FOLL_FAST_ONLY is required in order to match the API description of
 	 * this routine: no fall back to regular ("slow") GUP.
@@ -2920,8 +2926,7 @@ EXPORT_SYMBOL_GPL(pin_user_pages_fast_only);
  * @nr_pages:	number of pages from start to pin
  * @gup_flags:	flags modifying lookup behaviour
  * @pages:	array that receives pointers to the pages pinned.
- *		Should be at least nr_pages long. Or NULL, if caller
- *		only intends to ensure the pages are faulted in.
+ *		Should be at least nr_pages long.
  * @vmas:	array of pointers to vmas corresponding to each page.
  *		Or NULL if the caller does not require them.
  * @locked:	pointer to lock flag indicating whether lock is held and
@@ -2944,6 +2949,9 @@ long pin_user_pages_remote(struct mm_struct *mm,
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(!pages))
+		return -EINVAL;
+
 	gup_flags |= FOLL_PIN;
 	return __get_user_pages_remote(mm, start, nr_pages, gup_flags,
 				       pages, vmas, locked);
@@ -2957,8 +2965,7 @@ EXPORT_SYMBOL(pin_user_pages_remote);
  * @nr_pages:	number of pages from start to pin
  * @gup_flags:	flags modifying lookup behaviour
  * @pages:	array that receives pointers to the pages pinned.
- *		Should be at least nr_pages long. Or NULL, if caller
- *		only intends to ensure the pages are faulted in.
+ *		Should be at least nr_pages long.
  * @vmas:	array of pointers to vmas corresponding to each page.
  *		Or NULL if the caller does not require them.
  *
@@ -2976,6 +2983,9 @@ long pin_user_pages(unsigned long start, unsigned long nr_pages,
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(!pages))
+		return -EINVAL;
+
 	gup_flags |= FOLL_PIN;
 	return __gup_longterm_locked(current->mm, start, nr_pages,
 				     pages, vmas, gup_flags);
@@ -2994,6 +3004,9 @@ long pin_user_pages_unlocked(unsigned long start, unsigned long nr_pages,
 	if (WARN_ON_ONCE(gup_flags & FOLL_GET))
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(!pages))
+		return -EINVAL;
+
 	gup_flags |= FOLL_PIN;
 	return get_user_pages_unlocked(start, nr_pages, pages, gup_flags);
 }
-- 
2.32.0

