Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C048549F2F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 22:33:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235083AbiFMUda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 16:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiFMUc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 16:32:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F259C4E3B7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 12:23:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0D3AA614E3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 19:23:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC34C341C5;
        Mon, 13 Jun 2022 19:23:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655148189;
        bh=kMFgX2OiG0wP+m/airbACgnFus0Mqohfs1JXeb3bcyc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cEHxWCWcDQnzLU9nrgqKVHPe8OuFolxLzHQbWGm0FDF8s2xyR+UTbdrrPSpXxDWb+
         2gja07x61ylmEov3ngjkYe9zoxwsLiRsSLnjjcuXyTF1V+f2m0lVxOgZUrUBy+RKLl
         HoyjSta5L7tdYRjPc5ynMnYKljYgVJoGjtPLFVephMY8pxOffmSghJkInlXkTdzq7j
         EQ0n+oOBMJcI9B9+LUGI/G25iNl58r5iAnolPTravhz/k2gCL6FnuyQlG3VTunei/h
         CU1/VdnwPkiKUvgic43cy3ptsNJfigiY8JonZzcVNLWAvemNXegxPvstsoUcuQP2t0
         o3V9PurM1s9Nw==
From:   SeongJae Park <sj@kernel.org>
To:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] mm/damon/dbgfs: add mappings between 'schemes' file's action inputs and 'damos_action' values
Date:   Mon, 13 Jun 2022 19:22:54 +0000
Message-Id: <20220613192301.8817-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220613192301.8817-1-sj@kernel.org>
References: <20220613192301.8817-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON debugfs interface assumes users will write 'damos_action' value
directly to the 'schemes' file.  This makes adding new 'damos_action' in
the middle of its definition breaks the backward compatibility of DAMON
debugfs interface, as values of some 'damos_action' could be changed.
To support backward compatibility in the cases, this commit adds
mappings between the user inputs and 'damos_action' value and makes
DAMON debugfs code uses those.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 64 +++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 50 insertions(+), 14 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 5ae810927309..cb8a7e9926a4 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -97,6 +97,31 @@ static ssize_t dbgfs_attrs_write(struct file *file,
 	return ret;
 }
 
+/*
+ * Return corresponding dbgfs' scheme action value (int) for the given
+ * damos_action if the given damos_action value is valid and supported by
+ * dbgfs, negative error code otherwise.
+ */
+static int damos_action_to_dbgfs_scheme_action(enum damos_action action)
+{
+	switch (action) {
+	case DAMOS_WILLNEED:
+		return 0;
+	case DAMOS_COLD:
+		return 1;
+	case DAMOS_PAGEOUT:
+		return 2;
+	case DAMOS_HUGEPAGE:
+		return 3;
+	case DAMOS_NOHUGEPAGE:
+		return 4;
+	case DAMOS_STAT:
+		return 5;
+	default:
+		return -EINVAL;
+	}
+}
+
 static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 {
 	struct damos *s;
@@ -109,7 +134,7 @@ static ssize_t sprint_schemes(struct damon_ctx *c, char *buf, ssize_t len)
 				s->min_sz_region, s->max_sz_region,
 				s->min_nr_accesses, s->max_nr_accesses,
 				s->min_age_region, s->max_age_region,
-				s->action,
+				damos_action_to_dbgfs_scheme_action(s->action),
 				s->quota.ms, s->quota.sz,
 				s->quota.reset_interval,
 				s->quota.weight_sz,
@@ -160,18 +185,27 @@ static void free_schemes_arr(struct damos **schemes, ssize_t nr_schemes)
 	kfree(schemes);
 }
 
-static bool damos_action_valid(int action)
+/*
+ * Return corresponding damos_action for the given dbgfs input for a scheme
+ * action if the input is valid, negative error code otherwise.
+ */
+static enum damos_action dbgfs_scheme_action_to_damos_action(int dbgfs_action)
 {
-	switch (action) {
-	case DAMOS_WILLNEED:
-	case DAMOS_COLD:
-	case DAMOS_PAGEOUT:
-	case DAMOS_HUGEPAGE:
-	case DAMOS_NOHUGEPAGE:
-	case DAMOS_STAT:
-		return true;
+	switch (dbgfs_action) {
+	case 0:
+		return DAMOS_WILLNEED;
+	case 1:
+		return DAMOS_COLD;
+	case 2:
+		return DAMOS_PAGEOUT;
+	case 3:
+		return DAMOS_HUGEPAGE;
+	case 4:
+		return DAMOS_NOHUGEPAGE;
+	case 5:
+		return DAMOS_STAT;
 	default:
-		return false;
+		return -EINVAL;
 	}
 }
 
@@ -189,7 +223,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 	int pos = 0, parsed, ret;
 	unsigned long min_sz, max_sz;
 	unsigned int min_nr_a, max_nr_a, min_age, max_age;
-	unsigned int action;
+	unsigned int action_input;
+	enum damos_action action;
 
 	schemes = kmalloc_array(max_nr_schemes, sizeof(scheme),
 			GFP_KERNEL);
@@ -204,7 +239,7 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 		ret = sscanf(&str[pos],
 				"%lu %lu %u %u %u %u %u %lu %lu %lu %u %u %u %u %lu %lu %lu %lu%n",
 				&min_sz, &max_sz, &min_nr_a, &max_nr_a,
-				&min_age, &max_age, &action, &quota.ms,
+				&min_age, &max_age, &action_input, &quota.ms,
 				&quota.sz, &quota.reset_interval,
 				&quota.weight_sz, &quota.weight_nr_accesses,
 				&quota.weight_age, &wmarks.metric,
@@ -212,7 +247,8 @@ static struct damos **str_to_schemes(const char *str, ssize_t len,
 				&wmarks.low, &parsed);
 		if (ret != 18)
 			break;
-		if (!damos_action_valid(action))
+		action = dbgfs_scheme_action_to_damos_action(action_input);
+		if ((int)action < 0)
 			goto fail;
 
 		if (min_sz > max_sz || min_nr_a > max_nr_a || min_age > max_age)
-- 
2.25.1

