Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE14510C8B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 01:18:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356053AbiDZXVZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 19:21:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356032AbiDZXVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 19:21:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C820230558
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 16:18:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 68C2EB823A1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 23:18:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEE5CC385AD;
        Tue, 26 Apr 2022 23:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651015079;
        bh=Ac9sX0cFu6qC2OwtEEo2VbhjwI2Cs/TjEkOWCiwxUHk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=DyHJBDugogDeufQMDnDXEnfyoCbLHqNjRY8Z4se5aWlgrp4Fe4jjiQMUtk/BnXdjD
         Yf+kqTq0l5z5Nz/5ZQHi3Axn6iWNz6a4iGzE+LJgNpuEuQzYilPda1ms31a53a7qUj
         tDH31TkAui+//hvP55k/AGL0PaJ8r524KZGRD6M995+ziZ0+xp1boCeJDFLaefYsdy
         ANCY5ezgb1DeCVzjh7r9evaRGiQXohDP+QoELqZcCJwnefTqw2oEfHbdN4FoIzMp6Q
         xdWXIQXod1pHyCH6PF63lkWbZdfsUij9U10WDHDPd1dgovtY3tlElUvvrLN0qBggwj
         OvCDbB/KL9GtQ==
From:   sj@kernel.org
To:     akpm@linux-foundation.org
Cc:     linux-damon@amazon.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 2/3] mm/damon/sysfs: support fixed virtual address ranges monitoring
Date:   Tue, 26 Apr 2022 23:17:49 +0000
Message-Id: <20220426231750.48822-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426231750.48822-1-sj@kernel.org>
References: <20220426231750.48822-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: SeongJae Park <sj@kernel.org>

This commit makes DAMON sysfs interface to support the fixed virtual
address ranges monitoring.  After this commit, writing 'fvaddr' to the
'operations' DAMON sysfs file makes DAMON uses the monitoring operations
set for fixed virtual address ranges, so that users can monitor accesses
to only interested virtual address ranges.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 719a286d378f..767ab8c33e4d 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1694,7 +1694,7 @@ static struct kobj_type damon_sysfs_attrs_ktype = {
 /* This should match with enum damon_ops_id */
 static const char * const damon_sysfs_ops_strs[] = {
 	"vaddr",
-	"unsupported",	/* fvaddr is not supported by sysfs yet */
+	"fvaddr",
 	"paddr",
 };
 
@@ -1844,9 +1844,6 @@ static ssize_t operations_store(struct kobject *kobj,
 
 	for (id = 0; id < NR_DAMON_OPS; id++) {
 		if (sysfs_streq(buf, damon_sysfs_ops_strs[id])) {
-			/* fvaddr is not supported by sysfs yet */
-			if (id == DAMON_OPS_FVADDR)
-				return -EINVAL;
 			context->ops_id = id;
 			return count;
 		}
@@ -2136,7 +2133,8 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 			damon_sysfs_destroy_targets(ctx);
 			return -ENOMEM;
 		}
-		if (ctx->ops.id == DAMON_OPS_VADDR) {
+		if (ctx->ops.id == DAMON_OPS_VADDR ||
+				ctx->ops.id == DAMON_OPS_FVADDR) {
 			t->pid = find_get_pid(sys_target->pid);
 			if (!t->pid) {
 				damon_sysfs_destroy_targets(ctx);
-- 
2.25.1

