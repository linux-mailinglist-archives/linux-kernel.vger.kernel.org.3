Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD786481B46
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:14:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238475AbhL3KOv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:14:51 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41194 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238449AbhL3KOs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:14:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4A3BC61654
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4830EC36AEC;
        Thu, 30 Dec 2021 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640859287;
        bh=nXtgWdFbX4LSlCLgWaiTz6E/bBXUDjK9Fjw5HIsAP3Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=daRaVotAWsRllHkbuF4D0kBCLpvDCFzfJDr8z+qyACoQqOzO5mtTCPYjej4RpHW6F
         su3dMtlZXqFizlTJZZtG29n5J8TxXO2x3lQEtEhK5R30H2Zd/y7jGSKFcH7dRl5vrV
         pYRJ7jSeaQ1GDYFIz9HdmeZN+Y7wzMywMxCPKzq1gPdDzN8NMINOa+d2R5zSJJ5GQE
         uvsjYay/DQvWeaFMXUQd8fyVnE+gWz3c3UTFsmnei7H0c5EyhclKNnQrxxEZNxrbkc
         0WMQ7Ck7N/Xj79GnX+dooS05BpsULhmhbxZxB+oeSqHKeT9VD1YA8JH46uGZOmYEpn
         PvI1/ltRBGaRQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 3/4] mm/damon/core: Move damon_set_targets() into dbgfs
Date:   Thu, 30 Dec 2021 10:07:22 +0000
Message-Id: <20211230100723.2238-4-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211230100723.2238-1-sj@kernel.org>
References: <20211230100723.2238-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

damon_set_targets() function is defined in the core for general use
cases, but called from only dbgfs.  Also, because the function is for
general use cases, dbgfs does additional handling of pid type target id
case.  To make the situation simpler, this commit moves the function
into dbgfs and makes it to do the pid type case handling on its own.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 --
 mm/damon/core-test.h  |  5 +++-
 mm/damon/core.c       | 32 --------------------------
 mm/damon/dbgfs-test.h | 14 ++++++------
 mm/damon/dbgfs.c      | 53 +++++++++++++++++++++++++++++++++----------
 5 files changed, 52 insertions(+), 54 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 5e1e3a128b77..bd021af5db3d 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -484,8 +484,6 @@ unsigned int damon_nr_regions(struct damon_target *t);
 
 struct damon_ctx *damon_new_ctx(void);
 void damon_destroy_ctx(struct damon_ctx *ctx);
-int damon_set_targets(struct damon_ctx *ctx,
-		unsigned long *ids, ssize_t nr_ids);
 int damon_set_attrs(struct damon_ctx *ctx, unsigned long sample_int,
 		unsigned long aggr_int, unsigned long primitive_upd_int,
 		unsigned long min_nr_reg, unsigned long max_nr_reg);
diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 7008c3735e99..4a6141ddd6fc 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -86,7 +86,10 @@ static void damon_test_aggregate(struct kunit *test)
 	struct damon_region *r;
 	int it, ir;
 
-	damon_set_targets(ctx, target_ids, 3);
+	for (it = 0; it < 3; it++) {
+		t = damon_new_target(target_ids[it]);
+		damon_add_target(ctx, t);
+	}
 
 	it = 0;
 	damon_for_each_target(t, ctx) {
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 1dd153c31c9e..3fef5c667a31 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -245,38 +245,6 @@ void damon_destroy_ctx(struct damon_ctx *ctx)
 	kfree(ctx);
 }
 
-/**
- * damon_set_targets() - Set monitoring targets.
- * @ctx:	monitoring context
- * @ids:	array of target ids
- * @nr_ids:	number of entries in @ids
- *
- * This function should not be called while the kdamond is running.
- *
- * Return: 0 on success, negative error code otherwise.
- */
-int damon_set_targets(struct damon_ctx *ctx,
-		      unsigned long *ids, ssize_t nr_ids)
-{
-	ssize_t i;
-	struct damon_target *t, *next;
-
-	damon_destroy_targets(ctx);
-
-	for (i = 0; i < nr_ids; i++) {
-		t = damon_new_target(ids[i]);
-		if (!t) {
-			/* The caller should do cleanup of the ids itself */
-			damon_for_each_target_safe(t, next, ctx)
-				damon_destroy_target(t);
-			return -ENOMEM;
-		}
-		damon_add_target(ctx, t);
-	}
-
-	return 0;
-}
-
 /**
  * damon_set_attrs() - Set attributes for the monitoring.
  * @ctx:		monitoring context
diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 00bff058fe08..c1c988b607bc 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -86,23 +86,23 @@ static void damon_dbgfs_test_set_targets(struct kunit *test)
 	ctx->primitive.target_valid = NULL;
 	ctx->primitive.cleanup = NULL;
 
-	damon_set_targets(ctx, ids, 3);
+	dbgfs_set_targets(ctx, ids, 3);
 	sprint_target_ids(ctx, buf, 64);
 	KUNIT_EXPECT_STREQ(test, (char *)buf, "1 2 3\n");
 
-	damon_set_targets(ctx, NULL, 0);
+	dbgfs_set_targets(ctx, NULL, 0);
 	sprint_target_ids(ctx, buf, 64);
 	KUNIT_EXPECT_STREQ(test, (char *)buf, "\n");
 
-	damon_set_targets(ctx, (unsigned long []){1, 2}, 2);
+	dbgfs_set_targets(ctx, (unsigned long []){1, 2}, 2);
 	sprint_target_ids(ctx, buf, 64);
 	KUNIT_EXPECT_STREQ(test, (char *)buf, "1 2\n");
 
-	damon_set_targets(ctx, (unsigned long []){2}, 1);
+	dbgfs_set_targets(ctx, (unsigned long []){2}, 1);
 	sprint_target_ids(ctx, buf, 64);
 	KUNIT_EXPECT_STREQ(test, (char *)buf, "2\n");
 
-	damon_set_targets(ctx, NULL, 0);
+	dbgfs_set_targets(ctx, NULL, 0);
 	sprint_target_ids(ctx, buf, 64);
 	KUNIT_EXPECT_STREQ(test, (char *)buf, "\n");
 
@@ -130,7 +130,7 @@ static void damon_dbgfs_test_set_init_regions(struct kunit *test)
 	int i, rc;
 	char buf[256];
 
-	damon_set_targets(ctx, ids, 3);
+	dbgfs_set_targets(ctx, ids, 3);
 
 	/* Put valid inputs and check the results */
 	for (i = 0; i < ARRAY_SIZE(valid_inputs); i++) {
@@ -158,7 +158,7 @@ static void damon_dbgfs_test_set_init_regions(struct kunit *test)
 		KUNIT_EXPECT_STREQ(test, (char *)buf, "");
 	}
 
-	damon_set_targets(ctx, NULL, 0);
+	dbgfs_set_targets(ctx, NULL, 0);
 	damon_destroy_ctx(ctx);
 }
 
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 3f65af04e4e6..58867b966635 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -358,11 +358,48 @@ static void dbgfs_put_pids(unsigned long *ids, int nr_ids)
 		put_pid((struct pid *)ids[i]);
 }
 
+/*
+ * dbgfs_set_targets() - Set monitoring targets.
+ * @ctx:	monitoring context
+ * @ids:	array of target ids
+ * @nr_ids:	number of entries in @ids
+ *
+ * This function should not be called while the kdamond is running.
+ *
+ * Return: 0 on success, negative error code otherwise.
+ */
+static int dbgfs_set_targets(struct damon_ctx *ctx,
+		      unsigned long *ids, ssize_t nr_ids)
+{
+	ssize_t i;
+	struct damon_target *t, *next;
+
+	damon_for_each_target_safe(t, next, ctx) {
+		if (targetid_is_pid(ctx))
+			put_pid((struct pid *)t->id);
+		damon_destroy_target(t);
+	}
+
+	for (i = 0; i < nr_ids; i++) {
+		t = damon_new_target(ids[i]);
+		if (!t) {
+			/* The caller should do cleanup of the ids itself */
+			damon_for_each_target_safe(t, next, ctx)
+				damon_destroy_target(t);
+			if (targetid_is_pid(ctx))
+				dbgfs_put_pids(ids, nr_ids);
+			return -ENOMEM;
+		}
+		damon_add_target(ctx, t);
+	}
+
+	return 0;
+}
+
 static ssize_t dbgfs_target_ids_write(struct file *file,
 		const char __user *buf, size_t count, loff_t *ppos)
 {
 	struct damon_ctx *ctx = file->private_data;
-	struct damon_target *t, *next_t;
 	bool id_is_pid = true;
 	char *kbuf;
 	unsigned long *targets;
@@ -407,11 +444,7 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	}
 
 	/* remove previously set targets */
-	damon_for_each_target_safe(t, next_t, ctx) {
-		if (targetid_is_pid(ctx))
-			put_pid((struct pid *)t->id);
-		damon_destroy_target(t);
-	}
+	dbgfs_set_targets(ctx, NULL, 0);
 
 	/* Configure the context for the address space type */
 	if (id_is_pid)
@@ -419,13 +452,9 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	else
 		damon_pa_set_primitives(ctx);
 
-	ret = damon_set_targets(ctx, targets, nr_targets);
-	if (ret) {
-		if (id_is_pid)
-			dbgfs_put_pids(targets, nr_targets);
-	} else {
+	ret = dbgfs_set_targets(ctx, targets, nr_targets);
+	if (!ret)
 		ret = count;
-	}
 
 unlock_out:
 	mutex_unlock(&ctx->kdamond_lock);
-- 
2.17.1

