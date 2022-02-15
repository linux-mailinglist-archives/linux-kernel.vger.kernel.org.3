Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFBD94B76EA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241333AbiBOSrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:47:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243200AbiBOSqy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:46:54 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B7F2B26F
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:46:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 515AA61704
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:46:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53470C340EC;
        Tue, 15 Feb 2022 18:46:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950802;
        bh=uGH7d6y/OHdOl0x2ve29e4TlqSB6UdInuFYiQWpPpCA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X6s0DqO5B0nteyv1plXpOpGu+XiGmasMs02/UBZJAyHpK72Nn6gusSGHV/G/PC+il
         gSsB9B2AdtHfHtYaGNZCtFAqeN3Alx+58r10fzBjtxGSn3Fpgizr1dEGF7lkE7WohV
         N9zHgAOpAgby4M1+tapxLjfvv6Z3x8ePvLHYmZ8xEsH7aiKZgLq7VTcj08+Z2NBX7d
         OX8z4xiZk1oHRWOtkEX8Fop3p2bUpJhRPrfpS8yoFbr/6JTSfY6faWodgWjBI1br8+
         XxlTe/IGFevkzeC41SH1wrx0hLrnHlGdrGNuqc8wJBoVgVq+SBzHlPR59hSsfYTqsu
         oWuKpLoTCaT5g==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     xhao@linux.alibaba.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 7/8] mm/damon/dbgfs-test: Fix is_target_id() change
Date:   Tue, 15 Feb 2022 18:46:02 +0000
Message-Id: <20220215184603.1479-8-sj@kernel.org>
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

DAMON kunit tests for DAMON debugfs interface fails because it still
assumes setting empty monitoring operations makes DAMON debugfs
interface believe the target of the context don't have pid.  This commit
fixes the kunit test fails by explicitly setting the context's
monitoring operations with the operations for the physical address
space, which let debugfs knows the target will not have pid.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/dbgfs-test.h | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/dbgfs-test.h b/mm/damon/dbgfs-test.h
index 8f7f32595055..0bb0d532b159 100644
--- a/mm/damon/dbgfs-test.h
+++ b/mm/damon/dbgfs-test.h
@@ -74,7 +74,7 @@ static void damon_dbgfs_test_set_targets(struct kunit *test)
 	char buf[64];
 
 	/* Make DAMON consider target has no pid */
-	ctx->ops = (struct damon_operations){};
+	damon_select_ops(ctx, DAMON_OPS_PADDR);
 
 	dbgfs_set_targets(ctx, 0, NULL);
 	sprint_target_ids(ctx, buf, 64);
@@ -111,6 +111,8 @@ static void damon_dbgfs_test_set_init_regions(struct kunit *test)
 	int i, rc;
 	char buf[256];
 
+	damon_select_ops(ctx, DAMON_OPS_PADDR);
+
 	dbgfs_set_targets(ctx, 3, NULL);
 
 	/* Put valid inputs and check the results */
-- 
2.17.1

