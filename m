Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6F005AEFC8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbiIFQAu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 12:00:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233660AbiIFQAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 12:00:17 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E723AB00
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 08:19:55 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q3so11635217pjg.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 08:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=1NDwLaBCs5nhmRz61i3eAQ3IF542diGapeEzK/fCX5o=;
        b=Zo5lCexyWBldwLJNn337E+X4XjLh3CKtHzTEdaQ/ECk+dhSOKS4DnmcGXPxy+tuk+U
         DUV5mZGpHmWJrRWFmITH9tJPsFe1PisCnZYzDJPqP0axutpJSiQFSLw/4EbTQLO1dE1Y
         ZfGil5qcOfMj5r12bh+MaLOVAENX22LwVqJbfiy8lNzM7eK8mU+c+KLNV/DP0QAXsk0V
         5eobciFlxZL6g0+VRCohy0KR6AZLqVuB0KtCkAnw2bo6svNgZuDD4BlwJC3aCzLdc5id
         Tr8R3j3r6k3AcZ/1Ex0sSQ94QMEp9vGtRd4+ITU5wwMa0YVVivbd1CotjXtDyWyLYiAo
         +ejw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=1NDwLaBCs5nhmRz61i3eAQ3IF542diGapeEzK/fCX5o=;
        b=0u26rSejzI7Ol27iPnDZoUc9bWqPDIVNikUT8hahox9FGOn2tad3SpCdrI65G07JDD
         tFJhFJ41iJXrRvJEEHcba/34TCL5QDmKnRkLIDPaBG4gf6PccvoPXY1XwhauqCU0fDXT
         U1t4fuoOQ0i8V1DYn21bRF6eviLQHS+9t6qzGv5vEo5K5NxEUrjxpLCPKhJ5rvN4jGNL
         Q6NVBEjihFLYgLijjYnU+QF31eAxYLx03wTd6nW9+v5P/R6VGxsX8vCO2AhOLZWPB0gT
         kokys0z7hcLIseEvoaf7FfS0DAJ0e7D39eeQQGAzNZJMgjdxwD0BXfq6nMrSeS7WErwF
         29rA==
X-Gm-Message-State: ACgBeo3YGY3My9aNkV25BSeOfgKa+E/mIKsF+WEEMVNz724HRZkHJC/l
        PwjKwNziE29GCisDFuEpOQ==
X-Google-Smtp-Source: AA6agR4qbrSGPS0PcXmVtpUkCSbvfk3XXjbUCMdjYOZ7LU95Dyl0T9eBAaOS1Yx1ItBiTzOFcFhj8A==
X-Received: by 2002:a17:90b:1d0a:b0:1ff:35a3:c594 with SMTP id on10-20020a17090b1d0a00b001ff35a3c594mr24869790pjb.14.1662477595386;
        Tue, 06 Sep 2022 08:19:55 -0700 (PDT)
Received: from localhost.localdomain ([43.132.141.9])
        by smtp.gmail.com with ESMTPSA id x4-20020a170902a38400b0016dc26c7d30sm1095554pla.164.2022.09.06.08.19.53
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Sep 2022 08:19:54 -0700 (PDT)
From:   xiakaixu1987@gmail.com
X-Google-Original-From: kaixuxia@tencent.com
To:     sj@kernel.org, akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Kaixu Xia <kaixuxia@tencent.com>
Subject: [PATCH] mm/damon/core: iterate the regions list from current point in damon_set_regions()
Date:   Tue,  6 Sep 2022 23:18:47 +0800
Message-Id: <1662477527-13003-1-git-send-email-kaixuxia@tencent.com>
X-Mailer: git-send-email 1.8.3.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kaixu Xia <kaixuxia@tencent.com>

We iterate the whole regions list every time to get the first/last regions
intersecting with the specific range in damon_set_regions(), in order to
add new region or resize existing regions to fit in the specific range.
Actually, it is unnecessary to iterate the new added regions and the
front regions that have been checked. Just iterate the regions list from
the current point using list_for_each_entry_from() every time to improve
performance.
The kunit tests passed:
 [PASSED] damon_test_apply_three_regions1
 [PASSED] damon_test_apply_three_regions2
 [PASSED] damon_test_apply_three_regions3
 [PASSED] damon_test_apply_three_regions4

Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
---
 include/linux/damon.h | 8 ++++++++
 mm/damon/core.c       | 3 ++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 7b1f4a488230..d54acec048d6 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -463,9 +463,17 @@ static inline struct damon_region *damon_last_region(struct damon_target *t)
 	return list_last_entry(&t->regions_list, struct damon_region, list);
 }
 
+static inline struct damon_region *damon_first_region(struct damon_target *t)
+{
+	return list_first_entry(&t->regions_list, struct damon_region, list);
+}
+
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
 
+#define damon_for_each_region_from(r, t) \
+	list_for_each_entry_from(r, &t->regions_list, list)
+
 #define damon_for_each_region_safe(r, next, t) \
 	list_for_each_entry_safe(r, next, &t->regions_list, list)
 
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 7d25dc582fe3..702e1b7e975b 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -195,6 +195,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 			damon_destroy_region(r, t);
 	}
 
+	r = damon_first_region(t);
 	/* Add new regions or resize existing regions to fit in the ranges */
 	for (i = 0; i < nr_ranges; i++) {
 		struct damon_region *first = NULL, *last, *newr;
@@ -202,7 +203,7 @@ int damon_set_regions(struct damon_target *t, struct damon_addr_range *ranges,
 
 		range = &ranges[i];
 		/* Get the first/last regions intersecting with the range */
-		damon_for_each_region(r, t) {
+		damon_for_each_region_from(r, t) {
 			if (damon_intersect(r, range)) {
 				if (!first)
 					first = r;
-- 
2.27.0

