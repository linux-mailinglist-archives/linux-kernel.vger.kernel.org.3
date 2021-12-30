Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22138481B47
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 11:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbhL3KOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 05:14:52 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:60222 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238447AbhL3KOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 05:14:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8E13B81B46
        for <linux-kernel@vger.kernel.org>; Thu, 30 Dec 2021 10:14:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9D9C36AEA;
        Thu, 30 Dec 2021 10:14:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640859286;
        bh=KRjGkotj8UsNZZHm2nN5LnWrrqlRx64w2AAqvZmvnvM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z0xW5YTTthz1/PvJq4nSWXJEfMyv6KWpfo3YrISoFSBy8FrmLTxiTqzU1PvAt5p0f
         lAV4kdLAjG7LeTGzuQZxtPU7cPpHMexTCRNThhZkSn6816+RJ0XTysBcp+mInhgRpQ
         VnBYmE3kZmXDSRnbOTKREGhk5IMzfaDeJaaj8eqgQqhiv/Bn6ILndQ+fXXAsVYtdx/
         JtNAqeFCqAPcDqNykSyzGuFmePaCOpVYpMHvMtfNl4wuMzazc7SFpGQ5ZD8BKIHmur
         gsXJf0WM9bLzZIU1K8LnrRRYb1w8CmNd7y3nl4YhnKPPO8+eaZz88d4s8EhPzKLmd0
         tMFKCuCuWEvaA==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        SeongJae Park <sj@kernel.org>
Subject: [PATCH 1/4] mm/damon/dbgfs/init_regions: Use target index instead of target id
Date:   Thu, 30 Dec 2021 10:07:20 +0000
Message-Id: <20211230100723.2238-2-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211230100723.2238-1-sj@kernel.org>
References: <20211230100723.2238-1-sj@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Target id is a 'unsigned long' data, which can be interpreted
differently by each monitoring primitives.  For example, it means
'struct pid *' for the virtual address spaces monitoring, while it means
nothing but an integer to be displayed to debugfs interface users for
the physical address space monitoring.  It's flexible but makes code
ugly and type-unsafe[1].

To be prepared for eventual removal of the concept, this commit removes
a use case of the concept in 'init_regions' debugfs file handling.  In
detail, this commit replaces use of the id with the index of each target
in the context's targets list.

[1] https://lore.kernel.org/linux-mm/20211013154535.4aaeaaf9d0182922e405dd1e@linux-foundation.org/

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs-test.h | 20 ++++++++++----------
 mm/damon/dbgfs.c      | 25 ++++++++++++-------------
 2 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 86b9f9528231..00bff058fe08 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -113,19 +113,19 @@ static void damon_dbgfs_test_set_init_regions(struct kunit *test)
 {
 	struct damon_ctx *ctx = damon_new_ctx();
 	unsigned long ids[] = {1, 2, 3};
-	/* Each line represents one region in ``<target id> <start> <end>`` */
-	char * const valid_inputs[] = {"2 10 20\n 2   20 30\n2 35 45",
-		"2 10 20\n",
-		"2 10 20\n1 39 59\n1 70 134\n  2  20 25\n",
+	/* Each line represents one region in ``<target idx> <start> <end>`` */
+	char * const valid_inputs[] = {"1 10 20\n 1   20 30\n1 35 45",
+		"1 10 20\n",
+		"1 10 20\n0 39 59\n0 70 134\n  1  20 25\n",
 		""};
 	/* Reading the file again will show sorted, clean output */
-	char * const valid_expects[] = {"2 10 20\n2 20 30\n2 35 45\n",
-		"2 10 20\n",
-		"1 39 59\n1 70 134\n2 10 20\n2 20 25\n",
+	char * const valid_expects[] = {"1 10 20\n1 20 30\n1 35 45\n",
+		"1 10 20\n",
+		"0 39 59\n0 70 134\n1 10 20\n1 20 25\n",
 		""};
-	char * const invalid_inputs[] = {"4 10 20\n",	/* target not exists */
-		"2 10 20\n 2 14 26\n",		/* regions overlap */
-		"1 10 20\n2 30 40\n 1 5 8"};	/* not sorted by address */
+	char * const invalid_inputs[] = {"3 10 20\n",	/* target not exists */
+		"1 10 20\n 1 14 26\n",		/* regions overlap */
+		"0 10 20\n1 30 40\n 0 5 8"};	/* not sorted by address */
 	char *input, *expect;
 	int i, rc;
 	char buf[256];
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 5b899601e56c..3f65af04e4e6 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -440,18 +440,20 @@ static ssize_t sprint_init_regions(struct damon_ctx *c, char *buf, ssize_t len)
 {
 	struct damon_target *t;
 	struct damon_region *r;
+	int target_idx = 0;
 	int written = 0;
 	int rc;
 
 	damon_for_each_target(t, c) {
 		damon_for_each_region(r, t) {
 			rc = scnprintf(&buf[written], len - written,
-					"%lu %lu %lu\n",
-					t->id, r->ar.start, r->ar.end);
+					"%d %lu %lu\n",
+					target_idx, r->ar.start, r->ar.end);
 			if (!rc)
 				return -ENOMEM;
 			written += rc;
 		}
+		target_idx++;
 	}
 	return written;
 }
@@ -485,22 +487,19 @@ static ssize_t dbgfs_init_regions_read(struct file *file, char __user *buf,
 	return len;
 }
 
-static int add_init_region(struct damon_ctx *c,
-			 unsigned long target_id, struct damon_addr_range *ar)
+static int add_init_region(struct damon_ctx *c, int target_idx,
+		struct damon_addr_range *ar)
 {
 	struct damon_target *t;
 	struct damon_region *r, *prev;
-	unsigned long id;
+	unsigned long idx = 0;
 	int rc = -EINVAL;
 
 	if (ar->start >= ar->end)
 		return -EINVAL;
 
 	damon_for_each_target(t, c) {
-		id = t->id;
-		if (targetid_is_pid(c))
-			id = (unsigned long)pid_vnr((struct pid *)id);
-		if (id == target_id) {
+		if (idx++ == target_idx) {
 			r = damon_new_region(ar->start, ar->end);
 			if (!r)
 				return -ENOMEM;
@@ -523,7 +522,7 @@ static int set_init_regions(struct damon_ctx *c, const char *str, ssize_t len)
 	struct damon_target *t;
 	struct damon_region *r, *next;
 	int pos = 0, parsed, ret;
-	unsigned long target_id;
+	int target_idx;
 	struct damon_addr_range ar;
 	int err;
 
@@ -533,11 +532,11 @@ static int set_init_regions(struct damon_ctx *c, const char *str, ssize_t len)
 	}
 
 	while (pos < len) {
-		ret = sscanf(&str[pos], "%lu %lu %lu%n",
-				&target_id, &ar.start, &ar.end, &parsed);
+		ret = sscanf(&str[pos], "%d %lu %lu%n",
+				&target_idx, &ar.start, &ar.end, &parsed);
 		if (ret != 3)
 			break;
-		err = add_init_region(c, target_id, &ar);
+		err = add_init_region(c, target_idx, &ar);
 		if (err)
 			goto fail;
 		pos += parsed;
-- 
2.17.1

