Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB654B7595
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243226AbiBOSrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:47:15 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243205AbiBOSqz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:46:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE67B2BB0D
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:46:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 808A7B81BE4
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D63C340F2;
        Tue, 15 Feb 2022 18:46:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950802;
        bh=XXGeNtrspMb0Dwxmyk26Ohtm/O4a1cfPDFdOFE7eyIk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=a3Asl/Q0jZHzZ8Fx18aS9Edo012+2tW8XzSsF+ko6ooB0CUZ014JYnq8gv3cZY7ho
         ywxRC5EIwUEzNjahfZ5A7JXMOTEX1e/qYX7RQNx+lPvfBWHuK/n/ne7TIYCWNhSplS
         fAei8gKcZhNrT6fYpgw/EuJya/XutP92YBGFVZQulobaWum0Qv8ydZGAPttHIbOusg
         i13hw9VVXETh0QI6IEWmbw09HRwlYJFUXqXqXrHxcqLwGjUweJ0h4zhaM6EdfdmM1C
         askxjC7YovIT/JDpyh0X1GLsXEqlscTjfRFmDmef49vmI2U09TBJJHIjju28rqt3MP
         XvIQjnVzLjaNw==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     xhao@linux.alibaba.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 6/8] mm/damon/dbgfs: Use operations id for knowing if the target has pid
Date:   Tue, 15 Feb 2022 18:46:01 +0000
Message-Id: <20220215184603.1479-7-sj@kernel.org>
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

DAMON debugfs interface depends on monitoring operations for virtual
address spaces because it knows if the target has pid or not by seeing
if the context is configured to use one of the virtual address space
monitoring operation functions.  We can replace that check with
'enum damon_ops_id' now, to make it independent.  This commit makes the
change.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/damon/dbgfs.c b/mm/damon/dbgfs.c
index 8bf9e38b60f4..05b574cbcea8 100644
--- a/mm/damon/dbgfs.c
+++ b/mm/damon/dbgfs.c
@@ -277,7 +277,7 @@ static ssize_t dbgfs_schemes_write(struct file *file, const char __user *buf,
 
 static inline bool target_has_pid(const struct damon_ctx *ctx)
 {
-	return ctx->ops.target_valid == damon_va_target_valid;
+	return ctx->ops.id == DAMON_OPS_VADDR;
 }
 
 static ssize_t sprint_target_ids(struct damon_ctx *ctx, char *buf, ssize_t len)
@@ -741,8 +741,8 @@ static struct damon_ctx *dbgfs_new_ctx(void)
 	if (!ctx)
 		return NULL;
 
-	if (damon_select_ops(ctx, DAMON_OPS_VADDR) && damon_select_ops(ctx,
-				DAMON_OPS_PADDR)) {
+	if (damon_select_ops(ctx, DAMON_OPS_VADDR) &&
+			damon_select_ops(ctx, DAMON_OPS_PADDR)) {
 		damon_destroy_ctx(ctx);
 		return NULL;
 	}
-- 
2.17.1

