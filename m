Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDCEF556FB1
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 03:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377065AbiFWBC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 21:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiFWBC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 21:02:28 -0400
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7563A41F9B;
        Wed, 22 Jun 2022 18:02:26 -0700 (PDT)
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 23 Jun 2022 10:02:24 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id CB9BD205845A;
        Thu, 23 Jun 2022 10:02:24 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 23 Jun 2022 10:02:24 +0900
Received: from plum.e01.socionext.com (unknown [10.212.243.119])
        by kinkan2.css.socionext.com (Postfix) with ESMTP id 6F134B62E2;
        Thu, 23 Jun 2022 10:02:24 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Subject: [PATCH] clk: Fix referring to wrong pointer in devm_clk_release()
Date:   Thu, 23 Jun 2022 10:02:22 +0900
Message-Id: <1655946142-1346-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

At bind phase, __devm_clk_get() calls devres_alloc() to allocate devres,
and dr->data is treated as a variable "state".

At unbind phase, release_nodes() calls devm_clk_release() specified by
devres_alloc().

The argument "res" of devm_clk_release() is dr->data, and this entity is
"state", however in devm_clk_release(), "*res" is treated as "state",
resulting in pointer inconsistency.

Unbinding a driver caused a panic.

    Unable to handle kernel execute from non-executable memory
    at virtual address ffff000100236810
    ...
    pc : 0xffff000100236810
    lr : devm_clk_release+0x6c/0x9c
    ...
    Call trace:
     0xffff000100236810
     release_nodes+0xb0/0x150
     devres_release_all+0x94/0xf8
     device_unbind_cleanup+0x20/0x70
     device_release_driver_internal+0x114/0x1a0
     device_driver_detach+0x20/0x30

Cc: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Fixes: abae8e57e49a ("clk: generalize devm_clk_get() a bit")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/clk/clk-devres.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clk/clk-devres.c b/drivers/clk/clk-devres.c
index 43ccd20e0298..1f37ed7ad395 100644
--- a/drivers/clk/clk-devres.c
+++ b/drivers/clk/clk-devres.c
@@ -11,7 +11,7 @@ struct devm_clk_state {
 
 static void devm_clk_release(struct device *dev, void *res)
 {
-	struct devm_clk_state *state = *(struct devm_clk_state **)res;
+	struct devm_clk_state *state = (struct devm_clk_state *)res;
 
 	if (state->exit)
 		state->exit(state->clk);
-- 
2.25.1

