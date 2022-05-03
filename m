Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB8E5190F4
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 00:07:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243493AbiECWJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 18:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243596AbiECWJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 18:09:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4660201AF
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 15:05:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6BD4861721
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 22:05:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D6ADC385A9;
        Tue,  3 May 2022 22:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651615533;
        bh=UsYHQ2RMFhU+kqPVwKX92XprgxwwCA2T6bnN4o6xFNk=;
        h=From:To:Cc:Subject:Date:From;
        b=DWdkr2Zn0xk9I/RIzkgqjqAwye1gPjoCBwYg81adHHk8aJOKVJvquxPtHWZ2f/T7N
         4UUC1cYtIHuV/4kDMmqgVmYWZAPKjChzv0VMZ9oSRNpI35+cJdojXbjKj7PbfIwhbm
         18QhXlaBtAlUTq5NWFtoYKBxa/ZQWlXkGjQB7oW0XN1QwoAeJiswsuHJyJIbMUo4ZJ
         Gu1iqZv7IYDG9DMEqYHVQJU/A9roAxikayJ5M/Ala+DhJThDrIVQfdez2W3d7PEAf5
         zCsrDiBhbXZbVN6GlsMI88ea8QKsRGsZX2YBWfhWsKiCxpdnSwvWuk0DL7zID+Jfxo
         LpHAHAsI3RxwQ==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH] mm/damon/sysfs: fix pid leak under fvaddr ops use case
Date:   Tue,  3 May 2022 22:05:31 +0000
Message-Id: <20220503220531.45913-1-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit c83136469313 ("mm/damon/sysfs: support fixed virtual address
ranges monitoring") in 'mm-unstable' does not put the monitoring target
pid when fvaddr ops is used.  This commit fixes it to put pid properly.

Andrew, please merge this into the 'mm-unstable' commit
("mm/damon/sysfs: support fixed virtual address ranges monitoring").

Fixes: c83136469313 ("mm/damon/sysfs: support fixed virtual address ranges monitoring")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 767ab8c33e4d..f753bb405101 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -2086,7 +2086,8 @@ static void damon_sysfs_destroy_targets(struct damon_ctx *ctx)
 	struct damon_target *t, *next;
 
 	damon_for_each_target_safe(t, next, ctx) {
-		if (ctx->ops.id == DAMON_OPS_VADDR)
+		if (ctx->ops.id == DAMON_OPS_VADDR ||
+				ctx->ops.id == DAMON_OPS_FVADDR)
 			put_pid(t->pid);
 		damon_destroy_target(t);
 	}
@@ -2204,7 +2205,7 @@ static void damon_sysfs_before_terminate(struct damon_ctx *ctx)
 {
 	struct damon_target *t, *next;
 
-	if (ctx->ops.id != DAMON_OPS_VADDR)
+	if (ctx->ops.id != DAMON_OPS_VADDR && ctx->ops.id != DAMON_OPS_FVADDR)
 		return;
 
 	mutex_lock(&ctx->kdamond_lock);
-- 
2.25.1

