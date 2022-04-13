Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BFF44FF11B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 09:57:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbiDMH7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 03:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbiDMH7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 03:59:34 -0400
Received: from mail.meizu.com (edge07.meizu.com [112.91.151.210])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F4014BFCD;
        Wed, 13 Apr 2022 00:57:11 -0700 (PDT)
Received: from IT-EXMB-1-125.meizu.com (172.16.1.125) by mz-mail11.meizu.com
 (172.16.1.15) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 13 Apr
 2022 15:57:05 +0800
Received: from meizu.meizu.com (172.16.137.70) by IT-EXMB-1-125.meizu.com
 (172.16.1.125) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.14; Wed, 13 Apr
 2022 15:57:04 +0800
From:   Haowen Bai <baihaowen@meizu.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
CC:     Haowen Bai <baihaowen@meizu.com>,
        <linux-renesas-soc@vger.kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] clk: renesas: Fix memory leak of 'cpg'
Date:   Wed, 13 Apr 2022 15:57:02 +0800
Message-ID: <1649836623-6444-1-git-send-email-baihaowen@meizu.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.16.137.70]
X-ClientProxiedBy: IT-EXMB-1-126.meizu.com (172.16.1.126) To
 IT-EXMB-1-125.meizu.com (172.16.1.125)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix this issue by freeing the cpg when exiting the function in the
error/normal path.

Signed-off-by: Haowen Bai <baihaowen@meizu.com>
---
 drivers/clk/renesas/clk-r8a7778.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/renesas/clk-r8a7778.c b/drivers/clk/renesas/clk-r8a7778.c
index 3ccc53685bdd..ad2c080402c1 100644
--- a/drivers/clk/renesas/clk-r8a7778.c
+++ b/drivers/clk/renesas/clk-r8a7778.c
@@ -116,7 +116,7 @@ static void __init r8a7778_cpg_clocks_init(struct device_node *np)
 
 	cpg->reg = of_iomap(np, 0);
 	if (WARN_ON(cpg->reg == NULL))
-		return;
+		goto out_free_cpg;
 
 	for (i = 0; i < num_clks; ++i) {
 		const char *name;
@@ -136,6 +136,8 @@ static void __init r8a7778_cpg_clocks_init(struct device_node *np)
 	of_clk_add_provider(np, of_clk_src_onecell_get, &cpg->data);
 
 	cpg_mstp_add_clk_domain(np);
+out_free_cpg:
+	kfree(cpg);
 }
 
 CLK_OF_DECLARE(r8a7778_cpg_clks, "renesas,r8a7778-cpg-clocks",
-- 
2.7.4

