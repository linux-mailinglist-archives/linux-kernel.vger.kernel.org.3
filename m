Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3F21526588
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380498AbiEMPBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381878AbiEMPBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:01:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC82F48332
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 08:00:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 888CE62294
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 15:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85191C34100;
        Fri, 13 May 2022 15:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652454038;
        bh=dvkE+Xle/CL236kYATrTSaFb/CzjqEqgY0TtOELuS3s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=G8xkcMwft8MJgi5PphUHDXBPYWeRuVAR9cEtuPyM3CN3b3Stzq8L9ooP1Xmc8xPc6
         5PPqqjAnCV1UyX2GcnApgnhwTq94CHyWAsTfFHUSlxGkzjNq8SIehWGhdObmVyCSJI
         dg6QFE3X8lSkpdgqFCieCzbpPGH2nJrpP7BhimaJKGUoigLKieCQkTGNCK9L0IuftZ
         0jyXQ3FsdasiWkPdTUqNpq4juzPBY7aWZ5jS70hVOn+avgDIPnQcFFedlc6nNpy9DB
         EwVsolHZXS/3tLcnqYnIkyh4xwa6N1BtPOLsU1FUi0Y5CCQXGb86NqZ0pNdy4lawcB
         Rj5bHogHTx8aQ==
From:   SeongJae Park <sj@kernel.org>
Cc:     linux-damon@amazon.com, damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 3/3] mm/damon/paddr: Support DAMOS_COLD
Date:   Fri, 13 May 2022 17:00:00 +0200
Message-Id: <20220513150000.25797-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220513150000.25797-1-sj@kernel.org>
References: <20220513150000.25797-1-sj@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMOS_COLD is currently supported by the virtual address spaces
monitoring operations set (vaddr).  This commit adds support of the
action to the physical address space monitoring operations set (paddr).
Using this together with hot DAMOS action, users can proactively sort
LRU lists so that performance degradation under memory pressure can be
reduced.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/paddr.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/mm/damon/paddr.c b/mm/damon/paddr.c
index 69980b922bf4..761b1580271c 100644
--- a/mm/damon/paddr.c
+++ b/mm/damon/paddr.c
@@ -249,6 +249,22 @@ static unsigned long damon_pa_mark_accessed(struct damon_region *r)
 	return applied * PAGE_SIZE;
 }
 
+static unsigned long damon_pa_cold(struct damon_region *r)
+{
+	unsigned long addr, applied = 0;
+
+	for (addr = r->ar.start; addr < r->ar.end; addr += PAGE_SIZE) {
+		struct page *page = damon_get_page(PHYS_PFN(addr));
+
+		if (!page)
+			continue;
+		deactivate_page(page);
+		put_page(page);
+		applied++;
+	}
+	return applied * PAGE_SIZE;
+}
+
 static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		struct damon_target *t, struct damon_region *r,
 		struct damos *scheme)
@@ -258,6 +274,8 @@ static unsigned long damon_pa_apply_scheme(struct damon_ctx *ctx,
 		return damon_pa_pageout(r);
 	case DAMOS_HOT:
 		return damon_pa_mark_accessed(r);
+	case DAMOS_COLD:
+		return damon_pa_cold(r);
 	default:
 		break;
 	}
@@ -273,6 +291,8 @@ static int damon_pa_scheme_score(struct damon_ctx *context,
 		return damon_pageout_score(context, r, scheme);
 	case DAMOS_HOT:
 		return damon_hot_score(context, r, scheme);
+	case DAMOS_COLD:
+		return damon_pageout_score(context, r, scheme);
 	default:
 		break;
 	}
-- 
2.17.1

