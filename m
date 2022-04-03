Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 934314F06C9
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 04:28:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbiDCCaP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 22:30:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDCCaO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 22:30:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42B8C05;
        Sat,  2 Apr 2022 19:28:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21F4860E9D;
        Sun,  3 Apr 2022 02:28:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D548C340EE;
        Sun,  3 Apr 2022 02:28:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648952899;
        bh=nnm23szrmLAxXkfUdshG+TguQlKGlYZQUc5dMRlfJqs=;
        h=From:To:Cc:Subject:Date:From;
        b=qygqY/f6QiWvkb96YSDbAeI9UTf1WveoFoPN+knzJDXIfA1TPM2hNWr4n0tTzheu+
         jyb3eOm8qHpubt/ar6jd0AqEV1EQsaZ3wspBMxYMuZlWW5yVLyDE4SEGXjwEWLAL25
         SVZbLZZuNMFEs4ff7hI82Op+Tp+xusAK/j94YtP2/ywYZgiCiaw5FxxlYa+BQ4Orhr
         nVefTpSmFxHlyWlpnjPEis8YtIzPaYJ1KDVrC7vjzudaC59yMXT6pNCSynfQv6awcT
         fVbAKq+gjgUy9F94z3BQOuhiAM0DoR+nUDa3WqVlXKQiwdy7I0oPzkfq9Ywxkhd38w
         +xM7D4AR5JQ1Q==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Tony Lindgren <tony@atomide.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: [PATCH] Revert "clk: Drop the rate range on clk_put()"
Date:   Sat,  2 Apr 2022 19:28:18 -0700
Message-Id: <20220403022818.39572-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This reverts commit 7dabfa2bc4803eed83d6f22bd6f045495f40636b. There are
multiple reports that this breaks boot on various systems. The common
theme is that orphan clks are having rates set on them when that isn't
expected. Let's revert it out for now so that -rc1 boots.

Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reported-by: Tony Lindgren <tony@atomide.com>
Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Reported-by: Naresh Kamboju <naresh.kamboju@linaro.org>
Link: https://lore.kernel.org/r/366a0232-bb4a-c357-6aa8-636e398e05eb@samsung.com
Cc: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c      |  42 ++++++----------
 drivers/clk/clk_test.c | 108 -----------------------------------------
 2 files changed, 14 insertions(+), 136 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 07a27b65b773..ed119182aa1b 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -2332,15 +2332,19 @@ int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 }
 EXPORT_SYMBOL_GPL(clk_set_rate_exclusive);
 
-static int clk_set_rate_range_nolock(struct clk *clk,
-				     unsigned long min,
-				     unsigned long max)
+/**
+ * clk_set_rate_range - set a rate range for a clock source
+ * @clk: clock source
+ * @min: desired minimum clock rate in Hz, inclusive
+ * @max: desired maximum clock rate in Hz, inclusive
+ *
+ * Returns success (0) or negative errno.
+ */
+int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
 {
 	int ret = 0;
 	unsigned long old_min, old_max, rate;
 
-	lockdep_assert_held(&prepare_lock);
-
 	if (!clk)
 		return 0;
 
@@ -2353,6 +2357,8 @@ static int clk_set_rate_range_nolock(struct clk *clk,
 		return -EINVAL;
 	}
 
+	clk_prepare_lock();
+
 	if (clk->exclusive_count)
 		clk_core_rate_unprotect(clk->core);
 
@@ -2396,28 +2402,6 @@ static int clk_set_rate_range_nolock(struct clk *clk,
 	if (clk->exclusive_count)
 		clk_core_rate_protect(clk->core);
 
-	return ret;
-}
-
-/**
- * clk_set_rate_range - set a rate range for a clock source
- * @clk: clock source
- * @min: desired minimum clock rate in Hz, inclusive
- * @max: desired maximum clock rate in Hz, inclusive
- *
- * Return: 0 for success or negative errno on failure.
- */
-int clk_set_rate_range(struct clk *clk, unsigned long min, unsigned long max)
-{
-	int ret;
-
-	if (!clk)
-		return 0;
-
-	clk_prepare_lock();
-
-	ret = clk_set_rate_range_nolock(clk, min, max);
-
 	clk_prepare_unlock();
 
 	return ret;
@@ -4419,7 +4403,9 @@ void __clk_put(struct clk *clk)
 	}
 
 	hlist_del(&clk->clks_node);
-	clk_set_rate_range_nolock(clk, 0, ULONG_MAX);
+	if (clk->min_rate > clk->core->req_rate ||
+	    clk->max_rate < clk->core->req_rate)
+		clk_core_set_rate_nolock(clk->core, clk->core->req_rate);
 
 	owner = clk->core->owner;
 	kref_put(&clk->core->ref, __clk_release);
diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index fd2339cc5898..6731a822f4e3 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -760,65 +760,9 @@ static void clk_range_test_multiple_set_range_rate_maximized(struct kunit *test)
 	clk_put(user1);
 }
 
-/*
- * Test that if we have several subsequent calls to
- * clk_set_rate_range(), across multiple users, the core will reevaluate
- * whether a new rate is needed, including when a user drop its clock.
- *
- * With clk_dummy_maximize_rate_ops, this means that the rate will
- * trail along the maximum as it evolves.
- */
-static void clk_range_test_multiple_set_range_rate_put_maximized(struct kunit *test)
-{
-	struct clk_dummy_context *ctx = test->priv;
-	struct clk_hw *hw = &ctx->hw;
-	struct clk *clk = hw->clk;
-	struct clk *user1, *user2;
-	unsigned long rate;
-
-	user1 = clk_hw_get_clk(hw, NULL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, user1);
-
-	user2 = clk_hw_get_clk(hw, NULL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, user2);
-
-	KUNIT_ASSERT_EQ(test,
-			clk_set_rate(clk, DUMMY_CLOCK_RATE_2 + 1000),
-			0);
-
-	KUNIT_ASSERT_EQ(test,
-			clk_set_rate_range(user1,
-					   0,
-					   DUMMY_CLOCK_RATE_2),
-			0);
-
-	rate = clk_get_rate(clk);
-	KUNIT_ASSERT_GT(test, rate, 0);
-	KUNIT_EXPECT_EQ(test, rate, DUMMY_CLOCK_RATE_2);
-
-	KUNIT_ASSERT_EQ(test,
-			clk_set_rate_range(user2,
-					   0,
-					   DUMMY_CLOCK_RATE_1),
-			0);
-
-	rate = clk_get_rate(clk);
-	KUNIT_ASSERT_GT(test, rate, 0);
-	KUNIT_EXPECT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
-
-	clk_put(user2);
-
-	rate = clk_get_rate(clk);
-	KUNIT_ASSERT_GT(test, rate, 0);
-	KUNIT_EXPECT_EQ(test, rate, DUMMY_CLOCK_RATE_2);
-
-	clk_put(user1);
-}
-
 static struct kunit_case clk_range_maximize_test_cases[] = {
 	KUNIT_CASE(clk_range_test_set_range_rate_maximized),
 	KUNIT_CASE(clk_range_test_multiple_set_range_rate_maximized),
-	KUNIT_CASE(clk_range_test_multiple_set_range_rate_put_maximized),
 	{}
 };
 
@@ -933,61 +877,9 @@ static void clk_range_test_multiple_set_range_rate_minimized(struct kunit *test)
 	clk_put(user1);
 }
 
-/*
- * Test that if we have several subsequent calls to
- * clk_set_rate_range(), across multiple users, the core will reevaluate
- * whether a new rate is needed, including when a user drop its clock.
- *
- * With clk_dummy_minimize_rate_ops, this means that the rate will
- * trail along the minimum as it evolves.
- */
-static void clk_range_test_multiple_set_range_rate_put_minimized(struct kunit *test)
-{
-	struct clk_dummy_context *ctx = test->priv;
-	struct clk_hw *hw = &ctx->hw;
-	struct clk *clk = hw->clk;
-	struct clk *user1, *user2;
-	unsigned long rate;
-
-	user1 = clk_hw_get_clk(hw, NULL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, user1);
-
-	user2 = clk_hw_get_clk(hw, NULL);
-	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, user2);
-
-	KUNIT_ASSERT_EQ(test,
-			clk_set_rate_range(user1,
-					   DUMMY_CLOCK_RATE_1,
-					   ULONG_MAX),
-			0);
-
-	rate = clk_get_rate(clk);
-	KUNIT_ASSERT_GT(test, rate, 0);
-	KUNIT_EXPECT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
-
-	KUNIT_ASSERT_EQ(test,
-			clk_set_rate_range(user2,
-					   DUMMY_CLOCK_RATE_2,
-					   ULONG_MAX),
-			0);
-
-	rate = clk_get_rate(clk);
-	KUNIT_ASSERT_GT(test, rate, 0);
-	KUNIT_EXPECT_EQ(test, rate, DUMMY_CLOCK_RATE_2);
-
-	clk_put(user2);
-
-	rate = clk_get_rate(clk);
-	KUNIT_ASSERT_GT(test, rate, 0);
-	KUNIT_EXPECT_EQ(test, rate, DUMMY_CLOCK_RATE_1);
-
-	clk_put(user1);
-}
-
 static struct kunit_case clk_range_minimize_test_cases[] = {
 	KUNIT_CASE(clk_range_test_set_range_rate_minimized),
 	KUNIT_CASE(clk_range_test_multiple_set_range_rate_minimized),
-	KUNIT_CASE(clk_range_test_multiple_set_range_rate_put_minimized),
 	{}
 };
 
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

