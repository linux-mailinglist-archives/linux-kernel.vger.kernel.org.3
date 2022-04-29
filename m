Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D72B515063
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 18:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378906AbiD2QKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 12:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378827AbiD2QJj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 12:09:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFEEBA7766
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 09:06:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CDBF622B1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 16:06:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B39E6C385B2;
        Fri, 29 Apr 2022 16:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651248380;
        bh=5YMNTMsgfge8ubKXp7EhKpr2TL9m6guiVctUmtgprC8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJBRW49WESwGwEdpEAB5f/EIx6t8TTqQTTGFRq80FMowxFxMpMTuFpW3pdSo/Qh+3
         gx1vbm1C9d8sh1hSOX7a9XDM7KACYx5c7lXTVc8pSCg/vGpKnRvlYs+7pMNhluTazQ
         QtQ7RgTdR4KHxzvD+GcRuSxFio72EL7GiTVwqv7DT1fv8WQqdLeJy1sg1v6452zR7f
         xhfqBWSwyhvZiSNfiNj0fIyj8XPG2+sQmR54VFU0cFztw1alugFZnQO0uz7RYQj+/J
         xYQRiS2iyfQijMDqkIL8qMhikKGiee8PWGjHG30yUh+xs9KfJXgyHpK9AYmm2XTV4H
         lDW22HdPZkt7w==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 08/14] mm/damon/sysfs: reuse damon_set_regions() for regions setting
Date:   Fri, 29 Apr 2022 16:06:00 +0000
Message-Id: <20220429160606.127307-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429160606.127307-1-sj@kernel.org>
References: <20220429160606.127307-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

'damon_set_regions()' is general enough so that it can also be used for
only creating regions.  This commit makes DAMON sysfs interface to reuse
the function rather keeping two implementations for a same purpose.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 331647ab6396..0d6cb9b5bd5b 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2095,28 +2095,31 @@ static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
 static int damon_sysfs_set_regions(struct damon_target *t,
 		struct damon_sysfs_regions *sysfs_regions)
 {
-	int i;
+	struct damon_addr_range *ranges = kmalloc_array(sysfs_regions->nr,
+			sizeof(*ranges), GFP_KERNEL | __GFP_NOWARN);
+	int i, err = -EINVAL;
 
+	if (!ranges)
+		return -ENOMEM;
 	for (i = 0; i < sysfs_regions->nr; i++) {
 		struct damon_sysfs_region *sys_region =
 			sysfs_regions->regions_arr[i];
-		struct damon_region *prev, *r;
 
 		if (sys_region->start > sys_region->end)
-			return -EINVAL;
-		r = damon_new_region(sys_region->start, sys_region->end);
-		if (!r)
-			return -ENOMEM;
-		damon_add_region(r, t);
-		if (damon_nr_regions(t) > 1) {
-			prev = damon_prev_region(r);
-			if (prev->ar.end > r->ar.start) {
-				damon_destroy_region(r, t);
-				return -EINVAL;
-			}
-		}
+			goto out;
+
+		ranges[i].start = sys_region->start;
+		ranges[i].end = sys_region->end;
+		if (i == 0)
+			continue;
+		if (ranges[i - 1].end > ranges[i].start)
+			goto out;
 	}
-	return 0;
+	err = damon_set_regions(t, ranges, sysfs_regions->nr);
+out:
+	kfree(ranges);
+	return err;
+
 }
 
 static int damon_sysfs_add_target(struct damon_sysfs_target *sys_target,
-- 
2.25.1

