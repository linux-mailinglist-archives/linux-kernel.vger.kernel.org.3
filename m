Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC948130D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Dec 2021 14:10:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbhL2NKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Dec 2021 08:10:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239363AbhL2NKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Dec 2021 08:10:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD32EC061574
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 05:10:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 88DA1B81903
        for <linux-kernel@vger.kernel.org>; Wed, 29 Dec 2021 13:10:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC33AC36AE7;
        Wed, 29 Dec 2021 13:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640783433;
        bh=VQ2B0wuDXmafjk9e5koIOksR1NIA/USY11VBWynEVR8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ISW9lcpSNaDv/3bwMyPO1VeTwaF+UMTxb6hwMRvRmELcy4CerL62kExmERH12vaP1
         m1IxgP3ZCiLxmQ3DLNRhYe3Dtf4pQcZhS2boyvENsX2Xr+2dDaMiRbzwtaUZ38BhdM
         gBiJ/FjQ4/CoME6iX5CU7zVg2PeYNCig3CnNfJ7k1tFBMp7D9iMl+e5SA2fzeBJeOE
         MnW7XzTwQU2nTv40sAIQtSlmG9BzzS0y9jTF/WxkbdEKvMp9wjGD2i2yXqflZMt33H
         wMhHs77LYPeVx4ONh2pwINhUJ+34FPaSws6noxeeM6V4nYvw3WXDZFEzXCoNwxx4K0
         fwThJsPGpMW2g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/4] mm/damon: Hide kernel pointer from tracepoint event
Date:   Wed, 29 Dec 2021 13:10:16 +0000
Message-Id: <20211229131016.23641-5-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211229131016.23641-1-sj@kernel.org>
References: <20211229131016.23641-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON's virtual address spaces monitoring primitive uses 'struct pid *'
of the target process as its monitoring target id.  The kernel address
is exposed as-is to the user space via the DAMON tracepoint,
'damon_aggregated'.  Though primarily only privileged users are allowed
to access that, it would be better to avoid unnecessarily exposing
kernel pointers so.  Because the trace result is only required to be
able to distinguish each target, we aren't need to use the pointer
as-is.  This commit makes the tracepoint to use the index of the target
in the context's targets list as its id in the tracepoint, to hide the
kernel space address.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/trace/events/damon.h | 8 ++++----
 mm/damon/core.c              | 4 +++-
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/include/trace/events/damon.h b/include/trace/events/damon.h
index 99ffa601e351..c79f1d4c39af 100644
--- a/include/trace/events/damon.h
+++ b/include/trace/events/damon.h
@@ -11,10 +11,10 @@
 
 TRACE_EVENT(damon_aggregated,
 
-	TP_PROTO(struct damon_target *t, struct damon_region *r,
-		unsigned int nr_regions),
+	TP_PROTO(struct damon_target *t, unsigned int target_id,
+		struct damon_region *r, unsigned int nr_regions),
 
-	TP_ARGS(t, r, nr_regions),
+	TP_ARGS(t, target_id, r, nr_regions),
 
 	TP_STRUCT__entry(
 		__field(unsigned long, target_id)
@@ -26,7 +26,7 @@ TRACE_EVENT(damon_aggregated,
 	),
 
 	TP_fast_assign(
-		__entry->target_id = t->id;
+		__entry->target_id = target_id;
 		__entry->nr_regions = nr_regions;
 		__entry->start = r->ar.start;
 		__entry->end = r->ar.end;
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 6482d510dcbe..1dd153c31c9e 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -514,15 +514,17 @@ static bool kdamond_aggregate_interval_passed(struct damon_ctx *ctx)
 static void kdamond_reset_aggregated(struct damon_ctx *c)
 {
 	struct damon_target *t;
+	unsigned int ti = 0;	/* target's index */
 
 	damon_for_each_target(t, c) {
 		struct damon_region *r;
 
 		damon_for_each_region(r, t) {
-			trace_damon_aggregated(t, r, damon_nr_regions(t));
+			trace_damon_aggregated(t, ti, r, damon_nr_regions(t));
 			r->last_nr_accesses = r->nr_accesses;
 			r->nr_accesses = 0;
 		}
+		ti++;
 	}
 }
 
-- 
2.17.1

