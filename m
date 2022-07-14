Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ABE85753BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 19:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240203AbiGNRFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 13:05:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232398AbiGNRFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 13:05:11 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2C028711
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 10:05:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 64734CE2978
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 17:05:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBF4C34114;
        Thu, 14 Jul 2022 17:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657818307;
        bh=WadMQH2Ma9dG1nxvj1p2IIitBxICYq77zOLfBOTGYgg=;
        h=From:To:Cc:Subject:Date:From;
        b=PUls/OjFdJhBE9Z5qItunWM8OW6ncv/3+aGrs4HWLkdPET+VLoDMqrN3Sum6FT/+5
         MspF7aN9T1FuLVK6eRspz8G7Bgh8JkXhjKFmWrQK59zNI5eZMfzwcQFKXInGMZ71w8
         2W0xlW6yJCK/7yBRVHQ87I+RSJZoq8D1K+7jYP03IpHi5TBz3mTZWzh7b7cHcJxZHi
         tkQWPniVzUu0aEkTeeA6hnidQJ+bnBgJost+W+eOJWKPHTXow6bXEQmr+sPas60/YS
         oH6tHa32H7doMnvtlZ53DZPjwmLbzY7AlzviaMeWgvMsfIT903nhKesEKZwQeQHBA6
         3FCocgCOX3/5A==
From:   SeongJae Park <sj@kernel.org>
To:     akpm@linux-foundation.org
Cc:     damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, SeongJae Park <sj@kernel.org>
Subject: [PATCH for mm-stable] mm/damon/lru_sort: fix potential memory leak in damon_lru_sort_init()
Date:   Thu, 14 Jul 2022 17:04:58 +0000
Message-Id: <20220714170458.49727-1-sj@kernel.org>
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

'damon_lru_sort_init()' returns an error when 'damon_select_ops()' fails
without freeing 'ctx' which allocated before.  This commit fixes the
potential memory leak by freeing 'ctx' under the situation.

Commit 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists
Sorting"), which caused the problem is not in the mainline but
mm-stable.  Please meld this into the commit.

Fixes: 40e983cca927 ("mm/damon: introduce DAMON-based LRU-lists Sorting")
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/lru_sort.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/lru_sort.c b/mm/damon/lru_sort.c
index c276736a071c..9de6f00a71c5 100644
--- a/mm/damon/lru_sort.c
+++ b/mm/damon/lru_sort.c
@@ -524,8 +524,10 @@ static int __init damon_lru_sort_init(void)
 	if (!ctx)
 		return -ENOMEM;
 
-	if (damon_select_ops(ctx, DAMON_OPS_PADDR))
+	if (damon_select_ops(ctx, DAMON_OPS_PADDR)) {
+		damon_destroy_ctx(ctx);
 		return -EINVAL;
+	}
 
 	ctx->callback.after_wmarks_check = damon_lru_sort_after_wmarks_check;
 	ctx->callback.after_aggregation = damon_lru_sort_after_aggregation;
-- 
2.25.1

