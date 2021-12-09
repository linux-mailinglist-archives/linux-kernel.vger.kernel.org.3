Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 43B4E46E8FB
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 14:19:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbhLINVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 08:21:54 -0500
Received: from sin.source.kernel.org ([145.40.73.55]:43750 "EHLO
        sin.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237781AbhLINVw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 08:21:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id F32C8CE25BE;
        Thu,  9 Dec 2021 13:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9EBC341C8;
        Thu,  9 Dec 2021 13:18:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639055894;
        bh=mK2nEZXnZRM/OafiraNlq9hogkM+YDJ/mLO4T08owA8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fSljaKrmzEuBRhBwkVY3vMtIZlwnt4myFFDpVfUoIzsjoRWVGDfX060/EsxTHJ40Y
         OKkb7Kf5c8Af78yQGSqvKPxohLRTI1+7TmQAsnUUUU8Gd43CG1l7IbMjqH9dP1VlHx
         7SrxU89ebExSuGjxIV6xB+VG6x5V2UUt/+Dccoz35iVucsYJ3M05myRVSfiaR3C/cS
         De3si+zY25j5oUoLp0LFzQvZ0uP9KFKG+C0syM2PEm8j8c8q1hwQO5jop9Z4CPIjQU
         m79OFu+KWPCR5doVgsZYWnLAMRbgCKEhu5RtD/EBFM7FQ19BeWd9dvzPs/P7G5lElx
         MHNj2VkRqCJHQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     corbet@lwn.net, linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/6] mm/damon: Convert macro functions to static inline functions
Date:   Thu,  9 Dec 2021 13:18:01 +0000
Message-Id: <20211209131806.19317-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211209131806.19317-1-sj@kernel.org>
References: <20211209131806.19317-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit converts macro functions in DAMON to static inline
functions, for better type checking, code documentation, etc[1].

[1] https://lore.kernel.org/linux-mm/20211202151213.6ec830863342220da4141bc5@linux-foundation.org/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h | 18 ++++++++++++------
 mm/damon/core.c       |  5 ++++-
 mm/damon/vaddr.c      |  6 ++++--
 3 files changed, 20 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index e2c8152985b7..2dbc1f545da2 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -399,14 +399,20 @@ struct damon_ctx {
 	struct list_head schemes;
 };
 
-#define damon_next_region(r) \
-	(container_of(r->list.next, struct damon_region, list))
+static inline struct damon_region *damon_next_region(struct damon_region *r)
+{
+	return container_of(r->list.next, struct damon_region, list);
+}
 
-#define damon_prev_region(r) \
-	(container_of(r->list.prev, struct damon_region, list))
+static inline struct damon_region *damon_prev_region(struct damon_region *r)
+{
+	return container_of(r->list.prev, struct damon_region, list);
+}
 
-#define damon_last_region(t) \
-	(list_last_entry(&t->regions_list, struct damon_region, list))
+static inline struct damon_region *damon_last_region(struct damon_target *t)
+{
+	return list_last_entry(&t->regions_list, struct damon_region, list);
+}
 
 #define damon_for_each_region(r, t) \
 	list_for_each_entry(r, &t->regions_list, list)
diff --git a/mm/damon/core.c b/mm/damon/core.c
index e981fb40052f..70771cf7da89 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -767,7 +767,10 @@ static void kdamond_apply_schemes(struct damon_ctx *c)
 	}
 }
 
-#define sz_damon_region(r) (r->ar.end - r->ar.start)
+static inline unsigned long sz_damon_region(struct damon_region *r)
+{
+	return r->ar.end - r->ar.start;
+}
 
 /*
  * Merge two adjacent regions into one region
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 78ff2bcb66eb..68d9e4134816 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -26,8 +26,10 @@
  * 't->id' should be the pointer to the relevant 'struct pid' having reference
  * count.  Caller must put the returned task, unless it is NULL.
  */
-#define damon_get_task_struct(t) \
-	(get_pid_task((struct pid *)t->id, PIDTYPE_PID))
+static inline struct task_struct *damon_get_task_struct(struct damon_target *t)
+{
+	return get_pid_task((struct pid *)t->id, PIDTYPE_PID);
+}
 
 /*
  * Get the mm_struct of the given target
-- 
2.17.1

