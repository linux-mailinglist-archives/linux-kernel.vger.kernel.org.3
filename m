Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E7735A84CB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 19:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230436AbiHaRx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 13:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiHaRxd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 13:53:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2021D7404;
        Wed, 31 Aug 2022 10:53:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4654BB8226F;
        Wed, 31 Aug 2022 17:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4D27C433C1;
        Wed, 31 Aug 2022 17:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661968407;
        bh=EzPIK5Xh632H89fEvphyITfWjMOKvZ/kWmaLoiumbtY=;
        h=From:To:Cc:Subject:Date:From;
        b=PloUoGIBm3TrVzrZSdCO2xYevlD9ixacqp7M8w0VsaLZX5eIHOSNEwt50F5qGcWTz
         wQw1PQ2T2z1lV/t9ICthV0qobXoJ5GbVZpqPMttGrg2XOzKhnvV2azCJQVRLFdQKWU
         3FJwiWmn7fGWQQR3exIV1Y9H1sHrCtSN6OGjOgdnd/XNWsgsgUZCnx1G16Dh7RISyd
         qetOxe7ntX/Xrm631XyL+TMzpE3HAOzxuMZCVQU6lzOoTtyP/NFPIBBcX3sXIPgnC4
         0Cj8ZQQrM/hpWslabM/rLDO4qzE1rhkFaFkgFD9jw3DD/gNzM2D/RgAevvW56CHaOo
         0QkE5B0qGQSGQ==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Subject: [PATCH] Revert "clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops"
Date:   Wed, 31 Aug 2022 10:53:25 -0700
Message-Id: <20220831175326.2523912-1-sboyd@kernel.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
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

This reverts commit 35b0fac808b95eea1212f8860baf6ad25b88b087. Alexander
reports that it causes boot failures on i.MX8M Plus based boards
(specifically imx8mp-tqma8mpql-mba8mpxl.dts).

Reported-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>
Fixes: 35b0fac808b9 ("clk: core: Honor CLK_OPS_PARENT_ENABLE for clk gate ops")
Link: https://lore.kernel.org/r/12115951.O9o76ZdvQC@steina-w
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk.c | 28 ----------------------------
 1 file changed, 28 deletions(-)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 2e29a72c68e1..bd0b35cac83e 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -196,9 +196,6 @@ static bool clk_core_rate_is_protected(struct clk_core *core)
 	return core->protect_count;
 }
 
-static int clk_core_prepare_enable(struct clk_core *core);
-static void clk_core_disable_unprepare(struct clk_core *core);
-
 static bool clk_core_is_prepared(struct clk_core *core)
 {
 	bool ret = false;
@@ -211,11 +208,7 @@ static bool clk_core_is_prepared(struct clk_core *core)
 		return core->prepare_count;
 
 	if (!clk_pm_runtime_get(core)) {
-		if (core->flags & CLK_OPS_PARENT_ENABLE)
-			clk_core_prepare_enable(core->parent);
 		ret = core->ops->is_prepared(core->hw);
-		if (core->flags & CLK_OPS_PARENT_ENABLE)
-			clk_core_disable_unprepare(core->parent);
 		clk_pm_runtime_put(core);
 	}
 
@@ -251,13 +244,7 @@ static bool clk_core_is_enabled(struct clk_core *core)
 		}
 	}
 
-	if (core->flags & CLK_OPS_PARENT_ENABLE)
-		clk_core_prepare_enable(core->parent);
-
 	ret = core->ops->is_enabled(core->hw);
-
-	if (core->flags & CLK_OPS_PARENT_ENABLE)
-		clk_core_disable_unprepare(core->parent);
 done:
 	if (core->rpm_enabled)
 		pm_runtime_put(core->dev);
@@ -825,9 +812,6 @@ int clk_rate_exclusive_get(struct clk *clk)
 }
 EXPORT_SYMBOL_GPL(clk_rate_exclusive_get);
 
-static int clk_core_enable_lock(struct clk_core *core);
-static void clk_core_disable_lock(struct clk_core *core);
-
 static void clk_core_unprepare(struct clk_core *core)
 {
 	lockdep_assert_held(&prepare_lock);
@@ -851,18 +835,12 @@ static void clk_core_unprepare(struct clk_core *core)
 
 	WARN(core->enable_count > 0, "Unpreparing enabled %s\n", core->name);
 
-	if (core->flags & CLK_OPS_PARENT_ENABLE)
-		clk_core_enable_lock(core->parent);
-
 	trace_clk_unprepare(core);
 
 	if (core->ops->unprepare)
 		core->ops->unprepare(core->hw);
 
 	trace_clk_unprepare_complete(core);
-
-	if (core->flags & CLK_OPS_PARENT_ENABLE)
-		clk_core_disable_lock(core->parent);
 	clk_core_unprepare(core->parent);
 	clk_pm_runtime_put(core);
 }
@@ -912,9 +890,6 @@ static int clk_core_prepare(struct clk_core *core)
 		if (ret)
 			goto runtime_put;
 
-		if (core->flags & CLK_OPS_PARENT_ENABLE)
-			clk_core_enable_lock(core->parent);
-
 		trace_clk_prepare(core);
 
 		if (core->ops->prepare)
@@ -922,9 +897,6 @@ static int clk_core_prepare(struct clk_core *core)
 
 		trace_clk_prepare_complete(core);
 
-		if (core->flags & CLK_OPS_PARENT_ENABLE)
-			clk_core_disable_lock(core->parent);
-
 		if (ret)
 			goto unprepare;
 	}
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

