Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 97F85470364
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242584AbhLJPEO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:04:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242509AbhLJPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:04:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47540C061746
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 07:00:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0186EB82878
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:00:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67EBDC341CB;
        Fri, 10 Dec 2021 15:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639148433;
        bh=C2qhY6YuvnwZQD5xmb0IYoRaBXExlfMZfsAc2y0PKK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GS2hX3w+lE7fcNOTyVglTF42x31DoN0vkwRQHi/ApqVwPrSX4dH3AtiCW1Y+qxBFq
         whwKGmAqCR5tRbgNqpJyVlBgwDbWGgMnPgGv2tIUBjGNnYKRX136NFFlMgK7YB4q9Q
         1P29htK6lydrJacuP456jlVJS5k81QGBKPRwI0gz6/tcAg+pmpAz505UHK7Yvx+56B
         AzpfpR2f4dto5zTiz0zxW/9VdNyJyeoR50QrPeZSGNymUO748vUPi5yP0MtBVaGJiL
         tdWKmdjm4202Ru4T1eqy9XSziG1x/EYQ9QnxkY8S7kI9pd6x2GfwmOfMrtsoUqL2PR
         g8gshGOpJwyWA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/6] mm/damon/schemes: Account how many times quota limit has exceeded
Date:   Fri, 10 Dec 2021 15:00:12 +0000
Message-Id: <20211210150016.35349-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211210150016.35349-1-sj@kernel.org>
References: <20211210150016.35349-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If the time/space quotas of a given DAMON-based operation scheme is too
small, the scheme could show unexpectedly slow progress.  However, there
is no good way to notice the case in runtime.  This commit extends the
DAMOS stat to provide how many times the quota limits exceeded so that
the users can easily notice the case and tune the scheme.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 2 ++
 mm/damon/core.c       | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e0ad3d9aaeed..af648388e759 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -198,12 +198,14 @@ struct damos_watermarks {
  * @sz_tried:	Total size of regions that the scheme is tried to be applied.
  * @nr_applied:	Total number of regions that the scheme is applied.
  * @sz_applied:	Total size of regions that the scheme is applied.
+ * @qt_exceeds: Total number of times the quota of the scheme has exceeded.
  */
 struct damos_stat {
 	unsigned long nr_tried;
 	unsigned long sz_tried;
 	unsigned long nr_applied;
 	unsigned long sz_applied;
+	unsigned long qt_exceeds;
 };
 
 /**
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6d59047b8923..30d4b6e1a434 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -731,6 +731,8 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 		if (time_after_eq(jiffies, quota->charged_from +
 					msecs_to_jiffies(
 						quota->reset_interval))) {
+			if (quota->esz && quota->charged_sz >= quota->esz)
+				s->stat.qt_exceeds++;
 			quota->total_charged_sz += quota->charged_sz;
 			quota->charged_from = jiffies;
 			quota->charged_sz = 0;
-- 
2.17.1

