Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B231481B48
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238514AbhL3KOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:14:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238424AbhL3KOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:14:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCEAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 02:14:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E193861656
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:14:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE713C36AED;
        Thu, 30 Dec 2021 10:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640859288;
        bh=QBpIsgjD2SrUkAcy3O+ViFmesUtP0TJpxBDb/a0uq6E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Fgnv6o/aN9WbEw86c7fBdOoRyrhykEZwpVlOM1zUsaGeE37hw84nztz17Zrgvqoi8
         IwBmD3NLQff3IFnfNcq2JgydTf0mLNQA1ySlAvHdWIdCNdoQsAdCgDDd3rysWaZVyE
         Cu9uNvJtdmiStqDgZgniFC6+ZunQIuuqeRadenKYOFNLEuE36+xtIZhq0qLmAlGhHA
         oO0X8wMMdu+EpPW/krDpyxEWqsYD6GkUjTJ55/gw3LiR2x5QBGcK4Vujj3oT5thCdT
         Ns+hRFRIkc3RQ1TYdxbYg8KJRqjoUIkz1I44t7zo3VR/lufezptXCiD77EGnUyTgq7
         4kkyTVAiYHlAg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/4] mm/damon: Remove the target id concept
Date:   Thu, 30 Dec 2021 10:07:23 +0000
Message-Id: <20211230100723.2238-5-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211230100723.2238-1-sj@kernel.org>
References: <20211230100723.2238-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON asks each monitoring target ('struct damon_target') to have one
'unsigned long' integer called 'id', which should be unique among the
targets of same monitoring context.  Meaning of it is, however, totally
up to the monitoring primitives that registered to the monitoring
context.  For example, the virtual address spaces monitoring primitives
treats the id as a 'struct pid' pointer.

This makes the code flexible, but ugly, not well-documented, and
type-unsafe[1].  Also, identification of each target can be done via its
index.  For the reason, this commit removes the concept and uses clear
type definition.  For now, only 'struct pid' pointer is used for the
virtual address spaces monitoring.  If DAMON is extended in future so
that we need to put another identifier field in the struct, we will use
a union for such primitives-dependent fields and document which
primitives are using which type.

[1] https://lore.kernel.org/linux-mm/20211013154535.4aaeaaf9d0182922e405dd1e@linux-foundation.org/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  11 ++-
 mm/damon/core-test.h  |  18 +++--
 mm/damon/core.c       |   4 +-
 mm/damon/dbgfs-test.h |  63 ++++++-----------
 mm/damon/dbgfs.c      | 152 +++++++++++++++++++++++++-----------------
 mm/damon/reclaim.c    |   3 +-
 mm/damon/vaddr-test.h |   6 +-
 mm/damon/vaddr.c      |   4 +-
 8 files changed, 133 insertions(+), 128 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index bd021af5db3d..7c1d915b3587 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -60,19 +60,18 @@ struct damon_region {
 
 /**
  * struct damon_target - Represents a monitoring target.
- * @id:			Unique identifier for this target.
+ * @pid:		The PID of the virtual address space to monitor.
  * @nr_regions:		Number of monitoring target regions of this target.
  * @regions_list:	Head of the monitoring target regions of this target.
  * @list:		List head for siblings.
  *
  * Each monitoring context could have multiple targets.  For example, a context
  * for virtual memory address spaces could have multiple target processes.  The
- * @id of each target should be unique among the targets of the context.  For
- * example, in the virtual address monitoring context, it could be a pidfd or
- * an address of an mm_struct.
+ * @pid should be set for appropriate address space monitoring primitives
+ * including the virtual address spaces monitoring primitives.
  */
 struct damon_target {
-	unsigned long id;
+	struct pid *pid;
 	unsigned int nr_regions;
 	struct list_head regions_list;
 	struct list_head list;
@@ -475,7 +474,7 @@ struct damos *damon_new_scheme(
 void damon_add_scheme(struct damon_ctx *ctx, struct damos *s);
 void damon_destroy_scheme(struct damos *s);
 
-struct damon_target *damon_new_target(unsigned long id);
+struct damon_target *damon_new_target(void);
 void damon_add_target(struct damon_ctx *ctx, struct damon_target *t);
 bool damon_targets_empty(struct damon_ctx *ctx);
 void damon_free_target(struct damon_target *t);
diff --git a/mm/damon/core-test.h b/mm/damon/core-test.h
index 4a6141ddd6fc..b4085deb9fa0 100644
--- a/mm/damon/core-test.h
+++ b/mm/damon/core-test.h
@@ -24,7 +24,7 @@ static void damon_test_regions(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, 2ul, r->ar.end);
 	KUNIT_EXPECT_EQ(test, 0u, r->nr_accesses);
 
-	t = damon_new_target(42);
+	t = damon_new_target();
 	KUNIT_EXPECT_EQ(test, 0u, damon_nr_regions(t));
 
 	damon_add_region(r, t);
@@ -52,8 +52,7 @@ static void damon_test_target(struct kunit *test)
 	struct damon_ctx *c = damon_new_ctx();
 	struct damon_target *t;
 
-	t = damon_new_target(42);
-	KUNIT_EXPECT_EQ(test, 42ul, t->id);
+	t = damon_new_target();
 	KUNIT_EXPECT_EQ(test, 0u, nr_damon_targets(c));
 
 	damon_add_target(c, t);
@@ -78,7 +77,6 @@ static void damon_test_target(struct kunit *test)
 static void damon_test_aggregate(struct kunit *test)
 {
 	struct damon_ctx *ctx = damon_new_ctx();
-	unsigned long target_ids[] = {1, 2, 3};
 	unsigned long saddr[][3] = {{10, 20, 30}, {5, 42, 49}, {13, 33, 55} };
 	unsigned long eaddr[][3] = {{15, 27, 40}, {31, 45, 55}, {23, 44, 66} };
 	unsigned long accesses[][3] = {{42, 95, 84}, {10, 20, 30}, {0, 1, 2} };
@@ -87,7 +85,7 @@ static void damon_test_aggregate(struct kunit *test)
 	int it, ir;
 
 	for (it = 0; it < 3; it++) {
-		t = damon_new_target(target_ids[it]);
+		t = damon_new_target();
 		damon_add_target(ctx, t);
 	}
 
@@ -125,7 +123,7 @@ static void damon_test_split_at(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r;
 
-	t = damon_new_target(42);
+	t = damon_new_target();
 	r = damon_new_region(0, 100);
 	damon_add_region(r, t);
 	damon_split_region_at(c, t, r, 25);
@@ -146,7 +144,7 @@ static void damon_test_merge_two(struct kunit *test)
 	struct damon_region *r, *r2, *r3;
 	int i;
 
-	t = damon_new_target(42);
+	t = damon_new_target();
 	r = damon_new_region(0, 100);
 	r->nr_accesses = 10;
 	damon_add_region(r, t);
@@ -194,7 +192,7 @@ static void damon_test_merge_regions_of(struct kunit *test)
 	unsigned long eaddrs[] = {112, 130, 156, 170, 230};
 	int i;
 
-	t = damon_new_target(42);
+	t = damon_new_target();
 	for (i = 0; i < ARRAY_SIZE(sa); i++) {
 		r = damon_new_region(sa[i], ea[i]);
 		r->nr_accesses = nrs[i];
@@ -218,14 +216,14 @@ static void damon_test_split_regions_of(struct kunit *test)
 	struct damon_target *t;
 	struct damon_region *r;
 
-	t = damon_new_target(42);
+	t = damon_new_target();
 	r = damon_new_region(0, 22);
 	damon_add_region(r, t);
 	damon_split_regions_of(c, t, 2);
 	KUNIT_EXPECT_LE(test, damon_nr_regions(t), 2u);
 	damon_free_target(t);
 
-	t = damon_new_target(42);
+	t = damon_new_target();
 	r = damon_new_region(0, 220);
 	damon_add_region(r, t);
 	damon_split_regions_of(c, t, 4);
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 3fef5c667a31..bf495236d741 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -144,7 +144,7 @@ void damon_destroy_scheme(struct damos *s)
  *
  * Returns the pointer to the new struct if success, or NULL otherwise
  */
-struct damon_target *damon_new_target(unsigned long id)
+struct damon_target *damon_new_target(void)
 {
 	struct damon_target *t;
 
@@ -152,7 +152,7 @@ struct damon_target *damon_new_target(unsigned long id)
 	if (!t)
 		return NULL;
 
-	t->id = id;
+	t->pid = NULL;
 	t->nr_regions = 0;
 	INIT_LIST_HEAD(&t->regions_list);
 
diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index c1c988b607bc..0d3a14c00acf 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -12,66 +12,58 @@
 
 #include <kunit/test.h>
 
-static void damon_dbgfs_test_str_to_target_ids(struct kunit *test)
+static void damon_dbgfs_test_str_to_ints(struct kunit *test)
 {
 	char *question;
-	unsigned long *answers;
-	unsigned long expected[] = {12, 35, 46};
+	int *answers;
+	int expected[] = {12, 35, 46};
 	ssize_t nr_integers = 0, i;
 
 	question = "123";
-	answers = str_to_target_ids(question, strlen(question),
-			&nr_integers);
+	answers = str_to_ints(question, strlen(question), &nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)1, nr_integers);
-	KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
+	KUNIT_EXPECT_EQ(test, 123, answers[0]);
 	kfree(answers);
 
 	question = "123abc";
-	answers = str_to_target_ids(question, strlen(question),
-			&nr_integers);
+	answers = str_to_ints(question, strlen(question), &nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)1, nr_integers);
-	KUNIT_EXPECT_EQ(test, 123ul, answers[0]);
+	KUNIT_EXPECT_EQ(test, 123, answers[0]);
 	kfree(answers);
 
 	question = "a123";
-	answers = str_to_target_ids(question, strlen(question),
-			&nr_integers);
+	answers = str_to_ints(question, strlen(question), &nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
 	kfree(answers);
 
 	question = "12 35";
-	answers = str_to_target_ids(question, strlen(question),
-			&nr_integers);
+	answers = str_to_ints(question, strlen(question), &nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)2, nr_integers);
 	for (i = 0; i < nr_integers; i++)
 		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
 	kfree(answers);
 
 	question = "12 35 46";
-	answers = str_to_target_ids(question, strlen(question),
-			&nr_integers);
+	answers = str_to_ints(question, strlen(question), &nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)3, nr_integers);
 	for (i = 0; i < nr_integers; i++)
 		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
 	kfree(answers);
 
 	question = "12 35 abc 46";
-	answers = str_to_target_ids(question, strlen(question),
-			&nr_integers);
+	answers = str_to_ints(question, strlen(question), &nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)2, nr_integers);
 	for (i = 0; i < 2; i++)
 		KUNIT_EXPECT_EQ(test, expected[i], answers[i]);
 	kfree(answers);
 
 	question = "";
-	answers = str_to_target_ids(question, strlen(question),
-			&nr_integers);
+	answers = str_to_ints(question, strlen(question), &nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
 	kfree(answers);
 
 	question = "\n";
-	answers = str_to_target_ids(question, strlen(question),
-			&nr_integers);
+	answers = str_to_ints(question, strlen(question), &nr_integers);
 	KUNIT_EXPECT_EQ(test, (ssize_t)0, nr_integers);
 	kfree(answers);
 }
@@ -79,30 +71,20 @@ static void damon_dbgfs_test_str_to_target_ids(struct kunit *test)
 static void damon_dbgfs_test_set_targets(struct kunit *test)
 {
 	struct damon_ctx *ctx = dbgfs_new_ctx();
-	unsigned long ids[] = {1, 2, 3};
 	char buf[64];
 
-	/* Make DAMON consider target id as plain number */
-	ctx->primitive.target_valid = NULL;
-	ctx->primitive.cleanup = NULL;
+	/* Make DAMON consider target has no pid */
+	ctx->primitive = (struct damon_primitive){};
 
-	dbgfs_set_targets(ctx, ids, 3);
-	sprint_target_ids(ctx, buf, 64);
-	KUNIT_EXPECT_STREQ(test, (char *)buf, "1 2 3\n");
-
-	dbgfs_set_targets(ctx, NULL, 0);
+	dbgfs_set_targets(ctx, 0, NULL);
 	sprint_target_ids(ctx, buf, 64);
 	KUNIT_EXPECT_STREQ(test, (char *)buf, "\n");
 
-	dbgfs_set_targets(ctx, (unsigned long []){1, 2}, 2);
-	sprint_target_ids(ctx, buf, 64);
-	KUNIT_EXPECT_STREQ(test, (char *)buf, "1 2\n");
-
-	dbgfs_set_targets(ctx, (unsigned long []){2}, 1);
+	dbgfs_set_targets(ctx, 1, NULL);
 	sprint_target_ids(ctx, buf, 64);
-	KUNIT_EXPECT_STREQ(test, (char *)buf, "2\n");
+	KUNIT_EXPECT_STREQ(test, (char *)buf, "42\n");
 
-	dbgfs_set_targets(ctx, NULL, 0);
+	dbgfs_set_targets(ctx, 0, NULL);
 	sprint_target_ids(ctx, buf, 64);
 	KUNIT_EXPECT_STREQ(test, (char *)buf, "\n");
 
@@ -112,7 +94,6 @@ static void damon_dbgfs_test_set_targets(struct kunit *test)
 static void damon_dbgfs_test_set_init_regions(struct kunit *test)
 {
 	struct damon_ctx *ctx = damon_new_ctx();
-	unsigned long ids[] = {1, 2, 3};
 	/* Each line represents one region in ``<target idx> <start> <end>`` */
 	char * const valid_inputs[] = {"1 10 20\n 1   20 30\n1 35 45",
 		"1 10 20\n",
@@ -130,7 +111,7 @@ static void damon_dbgfs_test_set_init_regions(struct kunit *test)
 	int i, rc;
 	char buf[256];
 
-	dbgfs_set_targets(ctx, ids, 3);
+	dbgfs_set_targets(ctx, 3, NULL);
 
 	/* Put valid inputs and check the results */
 	for (i = 0; i < ARRAY_SIZE(valid_inputs); i++) {
@@ -158,12 +139,12 @@ static void damon_dbgfs_test_set_init_regions(struct kunit *test)
 		KUNIT_EXPECT_STREQ(test, (char *)buf, "");
 	}
 
-	dbgfs_set_targets(ctx, NULL, 0);
+	dbgfs_set_targets(ctx, 0, NULL);
 	damon_destroy_ctx(ctx);
 }
 
 static struct kunit_case damon_test_cases[] = {
-	KUNIT_CASE(damon_dbgfs_test_str_to_target_ids),
+	KUNIT_CASE(damon_dbgfs_test_str_to_ints),
 	KUNIT_CASE(damon_dbgfs_test_set_targets),
 	KUNIT_CASE(damon_dbgfs_test_set_init_regions),
 	{},
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 58867b966635..78ff645433c6 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -275,7 +275,7 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 	return ret;
 }
 
-static inline bool targetid_is_pid(const struct damon_ctx *ctx)
+static inline bool target_has_pid(const struct damon_ctx *ctx)
 {
 	return ctx->primitive.target_valid == damon_va_target_valid;
 }
@@ -283,17 +283,19 @@ static inline bool targetid_is_pid(const struct damon_ctx *ctx)
 static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
 {
 	struct damon_target *t;
-	unsigned long id;
+	int id;
 	int written = 0;
 	int rc;
 
 	damon_for_each_target(t, ctx) {
-		id = t->id;
-		if (targetid_is_pid(ctx))
+		if (target_has_pid(ctx))
 			/* Show pid numbers to debugfs users */
-			id = (unsigned long)pid_vnr((struct pid *)id);
+			id = pid_vnr(t->pid);
+		else
+			/* Show 42 for physical address space, just for fun */
+			id = 42;
 
-		rc = scnprintf(&buf[written], len - written, "%lu ", id);
+		rc = scnprintf(&buf[written], len - written, "%d ", id);
 		if (!rc)
 			return -ENOMEM;
 		written += rc;
@@ -321,75 +323,114 @@ static ssize_t dbgfs_target_ids_read(struct file *file,
 }
 
 /*
- * Converts a string into an array of unsigned long integers
+ * Converts a string into an integers array
  *
- * Returns an array of unsigned long integers if the conversion success, or
- * NULL otherwise.
+ * Returns an array of integers array if the conversion success, or NULL
+ * otherwise.
  */
-static unsigned long *str_to_target_ids(const char *str, ssize_t len,
-					ssize_t *nr_ids)
+static int *str_to_ints(const char *str, ssize_t len, ssize_t *nr_ints)
 {
-	unsigned long *ids;
-	const int max_nr_ids = 32;
-	unsigned long id;
+	int *array;
+	const int max_nr_ints = 32;
+	int nr;
 	int pos = 0, parsed, ret;
 
-	*nr_ids = 0;
-	ids = kmalloc_array(max_nr_ids, sizeof(id), GFP_KERNEL);
-	if (!ids)
+	*nr_ints = 0;
+	array = kmalloc_array(max_nr_ints, sizeof(*array), GFP_KERNEL);
+	if (!array)
 		return NULL;
-	while (*nr_ids < max_nr_ids && pos < len) {
-		ret = sscanf(&str[pos], "%lu%n", &id, &parsed);
+	while (*nr_ints < max_nr_ints && pos < len) {
+		ret = sscanf(&str[pos], "%d%n", &nr, &parsed);
 		pos += parsed;
 		if (ret != 1)
 			break;
-		ids[*nr_ids] = id;
-		*nr_ids += 1;
+		array[*nr_ints] = nr;
+		*nr_ints += 1;
 	}
 
-	return ids;
+	return array;
 }
 
-static void dbgfs_put_pids(unsigned long *ids, int nr_ids)
+static void dbgfs_put_pids(struct pid **pids, int nr_pids)
 {
 	int i;
 
-	for (i = 0; i < nr_ids; i++)
-		put_pid((struct pid *)ids[i]);
+	for (i = 0; i < nr_pids; i++)
+		put_pid(pids[i]);
+}
+
+/*
+ * Converts a string into an struct pid pointers array
+ *
+ * Returns an array of struct pid pointers if the conversion success, or NULL
+ * otherwise.
+ */
+static struct pid **str_to_pids(const char *str, ssize_t len, ssize_t *nr_pids)
+{
+	int *ints;
+	ssize_t nr_ints;
+	struct pid **pids;
+
+	*nr_pids = 0;
+
+	ints = str_to_ints(str, len, &nr_ints);
+	if (!ints)
+		return NULL;
+
+	pids = kmalloc_array(nr_ints, sizeof(*pids), GFP_KERNEL);
+	if (!pids)
+		goto out;
+
+	for (; *nr_pids < nr_ints; (*nr_pids)++) {
+		pids[*nr_pids] = find_get_pid(ints[*nr_pids]);
+		if (!pids[*nr_pids]) {
+			dbgfs_put_pids(pids, *nr_pids);
+			kfree(ints);
+			kfree(pids);
+			return NULL;
+		}
+	}
+
+out:
+	kfree(ints);
+	return pids;
 }
 
 /*
  * dbgfs_set_targets() - Set monitoring targets.
  * @ctx:	monitoring context
- * @ids:	array of target ids
- * @nr_ids:	number of entries in @ids
+ * @nr_targets:	number of targets
+ * @pids:	array of target pids (size is same to @nr_targets)
  *
- * This function should not be called while the kdamond is running.
+ * This function should not be called while the kdamond is running.  @pids is
+ * ignored if the context is not configured to have pid in each target.  On
+ * failure, reference counts of all pids in @pids are decremented.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-static int dbgfs_set_targets(struct damon_ctx *ctx,
-		      unsigned long *ids, ssize_t nr_ids)
+static int dbgfs_set_targets(struct damon_ctx *ctx, ssize_t nr_targets,
+		struct pid **pids)
 {
 	ssize_t i;
 	struct damon_target *t, *next;
 
 	damon_for_each_target_safe(t, next, ctx) {
-		if (targetid_is_pid(ctx))
-			put_pid((struct pid *)t->id);
+		if (target_has_pid(ctx))
+			put_pid(t->pid);
 		damon_destroy_target(t);
 	}
 
-	for (i = 0; i < nr_ids; i++) {
-		t = damon_new_target(ids[i]);
+	for (i = 0; i < nr_targets; i++) {
+		t = damon_new_target();
 		if (!t) {
-			/* The caller should do cleanup of the ids itself */
 			damon_for_each_target_safe(t, next, ctx)
 				damon_destroy_target(t);
-			if (targetid_is_pid(ctx))
-				dbgfs_put_pids(ids, nr_ids);
+			if (target_has_pid(ctx))
+				dbgfs_put_pids(pids, nr_targets);
 			return -ENOMEM;
 		}
+		if (target_has_pid(ctx))
+			t->pid = pids[i];
 		damon_add_target(ctx, t);
 	}
 
@@ -402,10 +443,9 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	struct damon_ctx *ctx = file->private_data;
 	bool id_is_pid = true;
 	char *kbuf;
-	unsigned long *targets;
+	struct pid **target_pids = NULL;
 	ssize_t nr_targets;
 	ssize_t ret;
-	int i;
 
 	kbuf = user_input_str(buf, count, ppos);
 	if (IS_ERR(kbuf))
@@ -413,38 +453,27 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 
 	if (!strncmp(kbuf, "paddr\n", count)) {
 		id_is_pid = false;
-		/* target id is meaningless here, but we set it just for fun */
-		scnprintf(kbuf, count, "42    ");
-	}
-
-	targets = str_to_target_ids(kbuf, count, &nr_targets);
-	if (!targets) {
-		ret = -ENOMEM;
-		goto out;
+		nr_targets = 1;
 	}
 
 	if (id_is_pid) {
-		for (i = 0; i < nr_targets; i++) {
-			targets[i] = (unsigned long)find_get_pid(
-					(int)targets[i]);
-			if (!targets[i]) {
-				dbgfs_put_pids(targets, i);
-				ret = -EINVAL;
-				goto free_targets_out;
-			}
+		target_pids = str_to_pids(kbuf, count, &nr_targets);
+		if (!target_pids) {
+			ret = -ENOMEM;
+			goto out;
 		}
 	}
 
 	mutex_lock(&ctx->kdamond_lock);
 	if (ctx->kdamond) {
 		if (id_is_pid)
-			dbgfs_put_pids(targets, nr_targets);
+			dbgfs_put_pids(target_pids, nr_targets);
 		ret = -EBUSY;
 		goto unlock_out;
 	}
 
 	/* remove previously set targets */
-	dbgfs_set_targets(ctx, NULL, 0);
+	dbgfs_set_targets(ctx, 0, NULL);
 
 	/* Configure the context for the address space type */
 	if (id_is_pid)
@@ -452,14 +481,13 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 	else
 		damon_pa_set_primitives(ctx);
 
-	ret = dbgfs_set_targets(ctx, targets, nr_targets);
+	ret = dbgfs_set_targets(ctx, nr_targets, target_pids);
 	if (!ret)
 		ret = count;
 
 unlock_out:
 	mutex_unlock(&ctx->kdamond_lock);
-free_targets_out:
-	kfree(targets);
+	kfree(target_pids);
 out:
 	kfree(kbuf);
 	return ret;
@@ -688,12 +716,12 @@ static void dbgfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
 
-	if (!targetid_is_pid(ctx))
+	if (!target_has_pid(ctx))
 		return;
 
 	mutex_lock(&ctx->kdamond_lock);
 	damon_for_each_target_safe(t, next, ctx) {
-		put_pid((struct pid *)t->id);
+		put_pid(t->pid);
 		damon_destroy_target(t);
 	}
 	mutex_unlock(&ctx->kdamond_lock);
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index bc476cef688e..29da37192e4a 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -387,8 +387,7 @@ static int __init damon_reclaim_init(void)
 	damon_pa_set_primitives(ctx);
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
-	/* 4242 means nothing but fun */
-	target = damon_new_target(4242);
+	target = damon_new_target();
 	if (!target) {
 		damon_destroy_ctx(ctx);
 		return -ENOMEM;
diff --git a/mm/damon/vaddr-test.h b/mm/damon/vaddr-test.h
index 6a1b9272ea12..f0d0ba591792 100644
--- a/mm/damon/vaddr-test.h
+++ b/mm/damon/vaddr-test.h
@@ -139,7 +139,7 @@ static void damon_do_test_apply_three_regions(struct kunit *test,
 	struct damon_region *r;
 	int i;
 
-	t = damon_new_target(42);
+	t = damon_new_target();
 	for (i = 0; i < nr_regions / 2; i++) {
 		r = damon_new_region(regions[i * 2], regions[i * 2 + 1]);
 		damon_add_region(r, t);
@@ -251,7 +251,7 @@ static void damon_test_apply_three_regions4(struct kunit *test)
 static void damon_test_split_evenly_fail(struct kunit *test,
 		unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
-	struct damon_target *t = damon_new_target(42);
+	struct damon_target *t = damon_new_target();
 	struct damon_region *r = damon_new_region(start, end);
 
 	damon_add_region(r, t);
@@ -270,7 +270,7 @@ static void damon_test_split_evenly_fail(struct kunit *test,
 static void damon_test_split_evenly_succ(struct kunit *test,
 	unsigned long start, unsigned long end, unsigned int nr_pieces)
 {
-	struct damon_target *t = damon_new_target(42);
+	struct damon_target *t = damon_new_target();
 	struct damon_region *r = damon_new_region(start, end);
 	unsigned long expected_width = (end - start) / nr_pieces;
 	unsigned long i = 0;
diff --git a/mm/damon/vaddr.c b/mm/damon/vaddr.c
index 73ee9719f8ba..47c28cbab018 100644
--- a/mm/damon/vaddr.c
+++ b/mm/damon/vaddr.c
@@ -23,12 +23,12 @@
 #endif
 
 /*
- * 't->id' should be the pointer to the relevant 'struct pid' having reference
+ * 't->pid' should be the pointer to the relevant 'struct pid' having reference
  * count.  Caller must put the returned task, unless it is NULL.
  */
 static inline struct task_struct *damon_get_task_struct(struct damon_target *t)
 {
-	return get_pid_task((struct pid *)t->id, PIDTYPE_PID);
+	return get_pid_task(t->pid, PIDTYPE_PID);
 }
 
 /*
-- 
2.17.1

