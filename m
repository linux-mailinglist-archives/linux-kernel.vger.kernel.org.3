Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7003B470367
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 16:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242508AbhLJPET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 10:04:19 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:42866 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242546AbhLJPEN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 10:04:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 196B3CE2B83
        for <linux-kernel@vger.kernel.org>; Fri, 10 Dec 2021 15:00:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02F36C341CF;
        Fri, 10 Dec 2021 15:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639148435;
        bh=2b/kJPy6Ru8lp4mLuBC4gZhE6gEGLdtczcdpxF4fXV8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IA6wPuKs8/wSWbByJbY83094uMyDXF4cihcUBuGdTNkLB+xqcdS7kvAaK+XX6p3PP
         YmH62jgVYIWn9BByLhZEOrGUh6KrkXbYrdf4oaUK4I76roB1iI/rsWRtIGsfU+YZ63
         4JM9r429ufnL/AbYEgw79x1PZWsgAAYIdKBPSNyrHmoU9SFP5/l5veDCfnk2GWXAPx
         /xPerIXRdUYid/Pbdd1zUXSgYxHoKpbQN4VRqpSrp2ASfWzdhHNOsjov8lrvRddhad
         PUWbpOpUi0FGwT5opBYcSUxIJu2sNBOrgebjNY4s1DS1iVnJAKI6MQBbHshZ+Aht4H
         o52UESh7tSydQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 5/6] mm/damon/dbgfs: Support all DAMOS stats
Date:   Fri, 10 Dec 2021 15:00:15 +0000
Message-Id: <20211210150016.35349-6-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211210150016.35349-1-sj@kernel.org>
References: <20211210150016.35349-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, DAMON debugfs interface is not supporting DAMON-based
Operation Schemes (DAMOS) stats for schemes successfully applied regions
and time/space quota limit exceeds.  This commit adds the support.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index ef79b7b7716d..58dbb9692279 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -105,7 +105,7 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 
 	damon_for_each_scheme(s, c) {
 		rc = scnprintf(&buf[written], len - written,
-				"%lu %lu %u %u %u %u %d %lu %lu %lu %u %u %u %d %lu %lu %lu %lu %lu %lu\n",
+				"%lu %lu %u %u %u %u %d %lu %lu %lu %u %u %u %d %lu %lu %lu %lu %lu %lu %lu %lu %lu\n",
 				s->min_sz_region, s->max_sz_region,
 				s->min_nr_accesses, s->max_nr_accesses,
 				s->min_age_region, s->max_age_region,
@@ -117,7 +117,9 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 				s->quota.weight_age,
 				s->wmarks.metric, s->wmarks.interval,
 				s->wmarks.high, s->wmarks.mid, s->wmarks.low,
-				s->stat.nr_tried, s->stat.sz_tried);
+				s->stat.nr_tried, s->stat.sz_tried,
+				s->stat.nr_applied, s->stat.sz_applied,
+				s->stat.qt_exceeds);
 		if (!rc)
 			return -ENOMEM;
 
-- 
2.17.1

