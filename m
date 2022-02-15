Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DCF54B767D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243239AbiBOSrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:47:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243202AbiBOSqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:46:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E8A2B273
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:46:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A686BB81C36
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08293C340EB;
        Tue, 15 Feb 2022 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950801;
        bh=hoGpv2c9vxG5UOx59LPqcWVHhPYMNKelW2hmb3S3rQ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=J6boZa0aJcnn9cPctIu3L/+2MQPxJjAy55OP8bWG8ba4p3Znl6Ak1oVsLdsrf/ByD
         U+D7weRihQK42CUUqVUdy8q5mpV6YIYB500IbMSZYa4Zcbm4PICMraoN7ZXVd4MS6b
         mzc+lMiDHU6qmJq17ptKIcK5Ziayauac7jO3GtLxhPT9IHhXCEFf+yrXa2GggyqU/1
         xLOigGxKlRZ+q+jbnctLgkEO2AIztPciHWjzUPV/JS93qXbu/YkKLpNgUmQmcpni1a
         h+i9n/u2L/C6W2ATMRpn3Tn0Z7B1wc63a51bYckvLggC9vbRdnBu5vWg+DTpET/z8s
         954LL+ZqvV3jw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     xhao@linux.alibaba.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 5/8] mm/damon/dbgfs: Use damon_select_ops() instead of damon_{v,p}a_set_operations()
Date:   Tue, 15 Feb 2022 18:46:00 +0000
Message-Id: <20220215184603.1479-6-sj@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220215184603.1479-1-sj@kernel.org>
References: <20220215184603.1479-1-sj@kernel.org>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes DAMON debugfs interface to select the registered
monitoring operations for the physical address space or virtual address
spaces depending on user requests instead of setting it on its own.
Note that DAMON debugfs interface is still dependent to DAMON_VADDR with
this change, because it is also using its symbol,
'damon_va_target_valid'.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 719278a8cc5e..8bf9e38b60f4 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -474,12 +474,18 @@ static ssize_t dbgfs_target_ids_write(struct file *file,
 
 	/* remove previously set targets */
 	dbgfs_set_targets(ctx, 0, NULL);
+	if (!nr_targets) {
+		ret = count;
+		goto unlock_out;
+	}
 
 	/* Configure the context for the address space type */
 	if (id_is_pid)
-		damon_va_set_operations(ctx);
+		ret = damon_select_ops(ctx, DAMON_OPS_VADDR);
 	else
-		damon_pa_set_operations(ctx);
+		ret = damon_select_ops(ctx, DAMON_OPS_PADDR);
+	if (ret)
+		goto unlock_out;
 
 	ret = dbgfs_set_targets(ctx, nr_targets, target_pids);
 	if (!ret)
@@ -735,7 +741,11 @@ static struct damon_ctx *dbgfs_new_ctx(void)
 	if (!ctx)
 		return NULL;
 
-	damon_va_set_operations(ctx);
+	if (damon_select_ops(ctx, DAMON_OPS_VADDR) && damon_select_ops(ctx,
+				DAMON_OPS_PADDR)) {
+		damon_destroy_ctx(ctx);
+		return NULL;
+	}
 	ctx->callback.before_terminate = dbgfs_before_terminate;
 	return ctx;
 }
-- 
2.17.1

