Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217374BA594
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243003AbiBQQUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:20:08 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242990AbiBQQUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:20:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1171D273741
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 08:19:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AD78CB8235B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 16:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A67C340EC;
        Thu, 17 Feb 2022 16:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645114787;
        bh=P6kUoPILhYhj1H1ifaqC4pebGTsEc9wuH7gl6nlprR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V1o9wlMo51/L2Ub2in/MXvW7QvA5HncVdVd9OnlEDQPukvom+zickh53AgQj7UPXE
         L79GqSD0lEoH9wJ6l5DL8q8mrrO/j3pUm1xuGhIrmn7Brhu7l5nB2EkZzNtmurxvC6
         PYPDC3oGWXHZmd9+slxhFJ174enwgLZs7Bq9RVigY/LlDqADZ8zpfPZnXA0jDVEh4J
         r45nLVx+keh8Ss8PRQuHC7vOgD4W4KdmEzHJqu8/Nq9gUqbrXYtUgi1XBpa9dCEwvP
         wna1wZ211U6q72OcpV7n+x0Ve7dLU9ya+PjJYX0snfsapeAAdGn6rISb00KDcfUQbY
         tlb8DP3cTxOVg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     rientjes@google.com, xhao@linux.alibaba.com,
        linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [RFC PATCH 2/4] mm/damon/core: Allow non-exclusive DAMON start/stop
Date:   Thu, 17 Feb 2022 16:19:36 +0000
Message-Id: <20220217161938.8874-3-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220217161938.8874-1-sj@kernel.org>
References: <20220217161938.8874-1-sj@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid interference between DAMON users, current start/stop functions
of DAMON allows only exclusive groups.  This makes use of DAMON a little
bit restrictive.  Meanwhile, admins could somehow aware each DAMON usage
and therefore could address the interference on their own.  This commit
hence allows callers of the functions to specify if the contexts should
run in an exclusive mode or not.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 include/linux/damon.h |  2 +-
 mm/damon/core.c       | 22 ++++++++++++++++------
 mm/damon/dbgfs.c      |  2 +-
 mm/damon/reclaim.c    |  2 +-
 4 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/include/linux/damon.h b/include/linux/damon.h
index 49c4a11ecf20..f8e99e47d747 100644
--- a/include/linux/damon.h
+++ b/include/linux/damon.h
@@ -508,7 +508,7 @@ int damon_nr_running_ctxs(void);
 int damon_register_ops(struct damon_operations *ops);
 int damon_select_ops(struct damon_ctx *ctx, enum damon_ops_id id);
 
-int damon_start(struct damon_ctx **ctxs, int nr_ctxs);
+int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive);
 int damon_stop(struct damon_ctx **ctxs, int nr_ctxs);
 
 #endif	/* CONFIG_DAMON */
diff --git a/mm/damon/core.c b/mm/damon/core.c
index 82e0a4620c4f..08c5e4dd2ed9 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -24,6 +24,7 @@
 
 static DEFINE_MUTEX(damon_lock);
 static int nr_running_ctxs;
+static bool running_exclusive_ctxs;
 
 static DEFINE_MUTEX(damon_ops_lock);
 static struct damon_operations damon_registered_ops[NR_DAMON_OPS];
@@ -434,22 +435,25 @@ static int __damon_start(struct damon_ctx *ctx)
  * damon_start() - Starts the monitorings for a given group of contexts.
  * @ctxs:	an array of the pointers for contexts to start monitoring
  * @nr_ctxs:	size of @ctxs
+ * @exclusive:	exclusiveness of this contexts group
  *
  * This function starts a group of monitoring threads for a group of monitoring
  * contexts.  One thread per each context is created and run in parallel.  The
- * caller should handle synchronization between the threads by itself.  If a
- * group of threads that created by other 'damon_start()' call is currently
- * running, this function does nothing but returns -EBUSY.
+ * caller should handle synchronization between the threads by itself.  If
+ * @exclusive is true and a group of threads that created by other
+ * 'damon_start()' call is currently running, this function does nothing but
+ * returns -EBUSY.
  *
  * Return: 0 on success, negative error code otherwise.
  */
-int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
+int damon_start(struct damon_ctx **ctxs, int nr_ctxs, bool exclusive)
 {
 	int i;
 	int err = 0;
 
 	mutex_lock(&damon_lock);
-	if (nr_running_ctxs) {
+	if ((exclusive && nr_running_ctxs) ||
+			(!exclusive && running_exclusive_ctxs)) {
 		mutex_unlock(&damon_lock);
 		return -EBUSY;
 	}
@@ -460,13 +464,15 @@ int damon_start(struct damon_ctx **ctxs, int nr_ctxs)
 			break;
 		nr_running_ctxs++;
 	}
+	if (exclusive && nr_running_ctxs)
+		running_exclusive_ctxs = true;
 	mutex_unlock(&damon_lock);
 
 	return err;
 }
 
 /*
- * __damon_stop() - Stops monitoring of given context.
+ * __damon_stop() - Stops monitoring of a given context.
  * @ctx:	monitoring context
  *
  * Return: 0 on success, negative error code otherwise.
@@ -506,6 +512,10 @@ int damon_stop(struct damon_ctx **ctxs, int nr_ctxs)
 		if (err)
 			return err;
 	}
+	mutex_lock(&damon_lock);
+	if (!nr_running_ctxs && running_exclusive_ctxs)
+		running_exclusive_ctxs = false;
+	mutex_unlock(&damon_lock);
 
 	return err;
 }
diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 05b574cbcea8..a0dab8b5e45f 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -967,7 +967,7 @@ static ssize_t dbgfs_monitor_on_write(struct file *file,
 				return -EINVAL;
 			}
 		}
-		ret = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs);
+		ret = damon_start(dbgfs_ctxs, dbgfs_nr_ctxs, true);
 	} else if (!strncmp(kbuf, "off", count)) {
 		ret = damon_stop(dbgfs_ctxs, dbgfs_nr_ctxs);
 	} else {
diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index b53d9c22fad1..e34c4d0c4d93 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -330,7 +330,7 @@ static int damon_reclaim_turn(bool on)
 	if (err)
 		goto free_scheme_out;
 
-	err = damon_start(&ctx, 1);
+	err = damon_start(&ctx, 1, true);
 	if (!err) {
 		kdamond_pid = ctx->kdamond->pid;
 		return 0;
-- 
2.17.1

