Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E68A51B82C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 08:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245072AbiEEGsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 02:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233151AbiEEGsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 02:48:13 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6079747396
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 23:44:34 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id iq10so3356743pjb.0
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 23:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=SpMxQmnSg4UVgtzsaV27Dc50ZPZ1XGAaiwMaGVOZnx4=;
        b=O6MdnO7Q8MeRyVhpyem9ME5F879UZYGZOWB5QcbzS5777SzYENXA4ikFQyNn26Ikc2
         ALtRObfn4Uodb1hdfgtuXQLbcgIYIpKeEJ6tJe2ZGTCCiDebqQiK4eLwwRrzo6beKrMA
         wOoUESAL5em0iE8TcrVj4v9RNuQrVAaMtrP2lJSxyF30L0tCmfBidrW2+MW+H+hDZt1B
         sRYTffnr+xQ5aLVm4LYR/hqz2y7QfyvHQyKccXdYO9FZ/moRquUsHvasUW29L7NTmeyV
         xkf0YZddfuBXVh4RNedItJHXVWCwdOzEJph4raS9N/u3/EtLyWM2iKFE/YLKaDx36Hk+
         bxUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :mime-version:content-transfer-encoding;
        bh=SpMxQmnSg4UVgtzsaV27Dc50ZPZ1XGAaiwMaGVOZnx4=;
        b=Ef+iVzLR9JUal11drQ/oWACLgkNXNpKs1ronS9U8cc5VlyMVndudvVf2Gdr9V7TEf8
         LUysSHvVZf59sWKTH8ffQpqlqR29oq2bzw//YinbUIpLIWEHFQDFq6Uj7AUYwvuA5Lln
         /X4qNOEHlnnzK8R8GBJtwmEWdG6DPR+Zhlnl26SdtYFwnigtq9FvcW9j3pFDoA+GnzIi
         QRg36ThGr6MKDkszOQCntCV0s0Bs686NKwnyxbcPK97xr6FVj6j0n6acOfHcPo7oAkFw
         3QjEki0CdIgQV1qCNZgRLXxxxW7BGLKQlq7kgTUjdmJFMpZ+GAeq+6asxGXzJLxorSq8
         vRpg==
X-Gm-Message-State: AOAM530sVTlkA98i086DqQivTm0Y/NnTRIYGqmSkZxpaTk5/UCWMst8t
        CGEHbh+vW0buoGP0ZOFQwo0=
X-Google-Smtp-Source: ABdhPJwmm2POHenL0J+W/qewrTiJqVSaZq1CpWud0SYupgHxX6RZuaTLuRUFBUYDYgXmxJKbcSgpHQ==
X-Received: by 2002:a17:90b:4c0a:b0:1d5:2e1d:ec6 with SMTP id na10-20020a17090b4c0a00b001d52e1d0ec6mr4394269pjb.64.1651733073867;
        Wed, 04 May 2022 23:44:33 -0700 (PDT)
Received: from bbox-1.mtv.corp.google.com ([2620:15c:211:201:8435:b3e7:62fc:4dfa])
        by smtp.gmail.com with ESMTPSA id s19-20020a056a00195300b0050dc762812esm566289pfk.8.2022.05.04.23.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 23:44:32 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
From:   Minchan Kim <minchan@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm <linux-mm@kvack.org>, LKML <linux-kernel@vger.kernel.org>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        John Hubbard <jhubbard@nvidia.com>,
        John Dias <joaodias@google.com>,
        Minchan Kim <minchan@kernel.org>,
        David Hildenbrand <david@redhat.com>
Subject: [PATCH v2] mm: fix is_pinnable_page against on cma page
Date:   Wed,  4 May 2022 23:44:29 -0700
Message-Id: <20220505064429.2818496-1-minchan@kernel.org>
X-Mailer: git-send-email 2.36.0.512.ge40c2bad7a-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Pages on CMA area could have MIGRATE_ISOLATE as well as MIGRATE_CMA
so current is_pinnable_page could miss CMA pages which has MIGRATE_
ISOLATE. It ends up putting CMA pages longterm pinning possible on
pin_user_pages APIs so CMA allocation fails.

The CMA allocation path protects the migration type change race
using zone->lock but what GUP path need to know is just whether the
page is on CMA area or not rather than exact type. Thus, we don't
need zone->lock but just checks the migratype in either of
(MIGRATE_ISOLATE and MIGRATE_CMA).

Adding the MIGRATE_ISOLATE check in is_pinnable_page could cause
rejecting of pinning the page on MIGRATE_ISOLATE pageblock even
thouth it's neither CMA nor movable zone if the page is temporarily
unmovable. However, the migration failure is general issue, not
only come from MIGRATE_ISOLATE and the MIGRATE_ISOLATE is also
transient state like other temporal refcount holding of pages.

Cc: David Hildenbrand <david@redhat.com>
Signed-off-by: Minchan Kim <minchan@kernel.org>
---
* from v1 - https://lore.kernel.org/all/20220502173558.2510641-1-minchan@kernel.org/
  * fix build warning - lkp
  * fix refetching issue of migration type
  * add side effect on !ZONE_MOVABLE and !MIGRATE_CMA in description - david

 include/linux/mm.h | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 6acca5cecbc5..e77758e2035e 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -1625,8 +1625,18 @@ static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
 #ifdef CONFIG_MIGRATION
 static inline bool is_pinnable_page(struct page *page)
 {
-	return !(is_zone_movable_page(page) || is_migrate_cma_page(page)) ||
-		is_zero_pfn(page_to_pfn(page));
+#ifdef CONFIG_CMA
+	/*
+	 * use volatile to use local variable mt instead of
+	 * refetching mt value.
+	 */
+	volatile int mt = get_pageblock_migratetype(page);
+
+	if (mt == MIGRATE_CMA || mt == MIGRATE_ISOLATE)
+		return false;
+#endif
+
+	return !(is_zone_movable_page(page) || is_zero_pfn(page_to_pfn(page)));
 }
 #else
 static inline bool is_pinnable_page(struct page *page)
-- 
2.36.0.512.ge40c2bad7a-goog

