Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF56D4EE451
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 00:45:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242658AbiCaWqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 18:46:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241816AbiCaWqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 18:46:42 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B0713F93
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:44:54 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id p15so2232410ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 15:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBnAVbpNqoCSWYSx8Ql1qE8bBicsUKv/dG3nqRT3QLE=;
        b=My5YOtImdr7UEoWwDcs2sJJgmp/EYwERA/O451PPXh6jdxmfilUqBiLjSyc2fw374C
         QUWiMmlQHOitjuPFMIL05o4gy0/dwlsmxQhjHKq4WFM3RDE1rbHe4T54t+cDCLl/Tzmd
         SilQQqAKstEEuboM7Xz8FwgkEcYYyOpkXhzYznRRbkJzt+M41ovHbuOX3wkz0pnAgbGh
         QzXy/nFkOmySoEXuzC6aMZX6K6b0OtKfjFC1VOTfnLpwCLCK6M9UgP1VBfITzNZXhuta
         cKhPXnXwMwNq4GqDBdgRTnd6SoI2zV5KI3FSzl7gerqzy3t0HLyB/rOS/QhY8IBv9DWM
         p9fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=kBnAVbpNqoCSWYSx8Ql1qE8bBicsUKv/dG3nqRT3QLE=;
        b=UnqYNXYk9Wrgf/lhDzaeOyci4zS24aC+Guf1lfh9WG0kNqaI/Mb/Pth4ALKewrXy1D
         h6Ry0zZ/GraK5f9wmU5R3mPOv7nManEVW64WndNBcTIvWQLKlMEJKg5LmNUKg/pmw6Dv
         7qcfyx120CK9DzVcQ7xvQh/3SW7iPoFgoDuy85KPprcCkgfJf9Wq9Ip1dEy0BGKPdEn6
         Xpn25n+N3EAViPxWBjOv/qS4DerIqxzCTQoSsZRZ70t89iAqJKjnCbBBJesDjDoMZWrq
         28LKVGMGYMITmUhhVPyUvRiLahwQbi+RUjuMyo3ySLAwzRzvqlnnDoLWBOSd1pPm9H3c
         FXvA==
X-Gm-Message-State: AOAM530SDNCfFUAsbPRvQNmQ+x6gtkcsTXMlSIWEVXKgcfuF64+Oswnn
        PZAoOnv9LGw/8mCqcE9aCMI=
X-Google-Smtp-Source: ABdhPJypkvOUIsmp4p7ZZmma10hTeATGviLbd10EbEyAfGvQ538gSlqmRsbB+hEE1DATtqOx7Ml4ag==
X-Received: by 2002:a17:906:9acd:b0:6e0:b74d:d932 with SMTP id ah13-20020a1709069acd00b006e0b74dd932mr6806151ejc.695.1648766692559;
        Thu, 31 Mar 2022 15:44:52 -0700 (PDT)
Received: from localhost.localdomain (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.googlemail.com with ESMTPSA id b12-20020a056402278c00b004195a50759fsm332229ede.84.2022.03.31.15.44.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 15:44:52 -0700 (PDT)
From:   Jakob Koschel <jakobkoschel@gmail.com>
To:     Mike Kravetz <mike.kravetz@oracle.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Mike Rapoport <rppt@kernel.org>,
        "Brian Johannesmeyer" <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>, Jakob Koschel <jakobkoschel@gmail.com>
Subject: [PATCH] hugetlb: remove use of list iterator variable after loop
Date:   Fri,  1 Apr 2022 00:43:23 +0200
Message-Id: <20220331224323.903842-1-jakobkoschel@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In preparation to limit the scope of the list iterator to the list
traversal loop, use a dedicated pointer to iterate through the list [1].

Before hugetlb_resv_map_add() was expecting a file_region struct, but
in case the list iterator in add_reservation_in_range() did not exit
early, the variable passed in, is not actually a valid structure.

In such a case 'rg' is computed on the head element of the list and
represents an out-of-bounds pointer. This still remains safe *iff* you
only use the link member (as it is done in hugetlb_resv_map_add()).

To avoid the type-confusion altogether and limit the list iterator to
the loop, only a list_head pointer is kept to pass to
hugetlb_resv_map_add().

Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/ [1]
Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
---
 mm/hugetlb.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index b34f50156f7e..bb0cac980a0f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -370,7 +370,7 @@ static void coalesce_file_region(struct resv_map *resv, struct file_region *rg)
 }
 
 static inline long
-hugetlb_resv_map_add(struct resv_map *map, struct file_region *rg, long from,
+hugetlb_resv_map_add(struct resv_map *map, struct list_head *rg, long from,
 		     long to, struct hstate *h, struct hugetlb_cgroup *cg,
 		     long *regions_needed)
 {
@@ -379,7 +379,7 @@ hugetlb_resv_map_add(struct resv_map *map, struct file_region *rg, long from,
 	if (!regions_needed) {
 		nrg = get_file_region_entry_from_cache(map, from, to);
 		record_hugetlb_cgroup_uncharge_info(cg, h, map, nrg);
-		list_add(&nrg->link, rg->link.prev);
+		list_add(&nrg->link, rg);
 		coalesce_file_region(map, nrg);
 	} else
 		*regions_needed += 1;
@@ -402,47 +402,52 @@ static long add_reservation_in_range(struct resv_map *resv, long f, long t,
 	long add = 0;
 	struct list_head *head = &resv->regions;
 	long last_accounted_offset = f;
-	struct file_region *rg = NULL, *trg = NULL;
+	struct file_region *iter, *trg = NULL;
+	struct list_head *rg = NULL;
 
 	if (regions_needed)
 		*regions_needed = 0;
 
 	/* In this loop, we essentially handle an entry for the range
-	 * [last_accounted_offset, rg->from), at every iteration, with some
+	 * [last_accounted_offset, iter->from), at every iteration, with some
 	 * bounds checking.
 	 */
-	list_for_each_entry_safe(rg, trg, head, link) {
+	list_for_each_entry_safe(iter, trg, head, link) {
 		/* Skip irrelevant regions that start before our range. */
-		if (rg->from < f) {
+		if (iter->from < f) {
 			/* If this region ends after the last accounted offset,
 			 * then we need to update last_accounted_offset.
 			 */
-			if (rg->to > last_accounted_offset)
-				last_accounted_offset = rg->to;
+			if (iter->to > last_accounted_offset)
+				last_accounted_offset = iter->to;
 			continue;
 		}
 
 		/* When we find a region that starts beyond our range, we've
 		 * finished.
 		 */
-		if (rg->from >= t)
+		if (iter->from >= t) {
+			rg = iter->link.prev;
 			break;
+		}
 
-		/* Add an entry for last_accounted_offset -> rg->from, and
+		/* Add an entry for last_accounted_offset -> iter->from, and
 		 * update last_accounted_offset.
 		 */
-		if (rg->from > last_accounted_offset)
-			add += hugetlb_resv_map_add(resv, rg,
+		if (iter->from > last_accounted_offset)
+			add += hugetlb_resv_map_add(resv, iter->link.prev,
 						    last_accounted_offset,
-						    rg->from, h, h_cg,
+						    iter->from, h, h_cg,
 						    regions_needed);
 
-		last_accounted_offset = rg->to;
+		last_accounted_offset = iter->to;
 	}
 
 	/* Handle the case where our range extends beyond
 	 * last_accounted_offset.
 	 */
+	if (!rg)
+		rg = head->prev;
 	if (last_accounted_offset < t)
 		add += hugetlb_resv_map_add(resv, rg, last_accounted_offset,
 					    t, h, h_cg, regions_needed);

base-commit: f82da161ea75dc4db21b2499e4b1facd36dab275
-- 
2.25.1

