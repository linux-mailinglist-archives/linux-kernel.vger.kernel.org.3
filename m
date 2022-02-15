Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C4F4B75DF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbiBOSrK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 13:47:10 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243199AbiBOSqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 13:46:53 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 670852B25A
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 10:46:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 03B4EB81C37
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 18:46:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D2E7C340F3;
        Tue, 15 Feb 2022 18:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644950800;
        bh=eZhIL14gOWoVEWGsNwFN8NXBLL2iSBk+B/sSAvRm98Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=r+7gmoPNoRh8qs/0p5o66zLMtSjxWSdqe62i1kIqnfJj09Z5OgfEwi11Q1sh9o147
         JeDCg2rlzXJXQli1U3qL5jzmVBDX0zdcUwKG8sWTgFGx4TXxPHPWf7lzjyLD/G8u8C
         cyV83LDVqtffhMZJLzbZTD9Q4HNqkGUqaS9X0Jzxt+Fl8WrJLwEvNHurz3Rq8OEzr2
         Q2WxA6SWAlGkqYhAa3nm21HwqXCwGLKzrt41zQBJ4VjshykkchB4RoyMxfLc8CcN/B
         tyVD1UbA2FPLGOfyxDipTPehlnr8HFunLgJtxbJYWXDRlanbaeGtn4VsSq1jk4P8eV
         dkoytfn3Bbjhg==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     xhao@linux.alibaba.com, rientjes@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH 4/8] mm/damon/reclaim: Use damon_select_ops() instead of damon_{v,p}a_set_operations()
Date:   Tue, 15 Feb 2022 18:45:59 +0000
Message-Id: <20220215184603.1479-5-sj@kernel.org>
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

This commit makes DAMON_RECLAIM to select the registered monitoring
operations for the physical address space instead of setting it on its
own.  This allows DAMON_RECLAIM be independent of DAMON_PADDR, but leave
the dependency as is, because it's the only one monitoring operations it
use, and therefore it makes no sense to build DAMON_RECLAIM without
DAMON_PADDR.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/reclaim.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/reclaim.c b/mm/damon/reclaim.c
index 3c93095c793c..b53d9c22fad1 100644
--- a/mm/damon/reclaim.c
+++ b/mm/damon/reclaim.c
@@ -384,7 +384,9 @@ static int __init damon_reclaim_init(void)
 	if (!ctx)
 		return -ENOMEM;
 
-	damon_pa_set_operations(ctx);
+	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
+		return -EINVAL;
+
 	ctx->callback.after_aggregation = damon_reclaim_after_aggregation;
 
 	target = damon_new_target();
-- 
2.17.1

