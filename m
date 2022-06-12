Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 866E0547A99
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:00:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237306AbiFLPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237282AbiFLPAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:00:21 -0400
Received: from box.trvn.ru (box.trvn.ru [194.87.146.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BF6149F3D
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 08:00:20 -0700 (PDT)
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id B1FF841D02;
        Sun, 12 Jun 2022 20:00:15 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1655046016; bh=/tYoU7VP1Rn/khkbkGNDTLOLEh/Vu49IcFrpgY0sx3I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=4ZKOeOxsXhGM+g8zP40BpLXslpi3ggurlZOVtBfMEY0mErOv8FOBpIdpoOF8wBvZc
         jYdiMefjlEkOBUnlJGPkK9/3r+zvT4TvrA2bcVNd6WxPGo7ovVXeQrJmx7SxJU6xZs
         a0OxMz8INL0JtdLXeojfThuDFJpFTIO38MZoBTVHUp8VxOoPrpDZF4Mba3hEKJH4Nf
         xviF0BHHuEP76oaQAzBseTw4ORw/gHpFJdp0hZMP8N+PDQyJm7PKhTKADXe05CAFE+
         Mf3DJA9y4phttFbA0VYXGNx3LHzxnZixOO0/Zq6cQJJKevEm6y01yIP95rNn8+ZMBe
         NpPv+ujhW92jA==
From:   Nikita Travkin <nikita@trvn.ru>
To:     mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH v2 1/4] clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is not enabled.
Date:   Sun, 12 Jun 2022 19:59:52 +0500
Message-Id: <20220612145955.385787-2-nikita@trvn.ru>
In-Reply-To: <20220612145955.385787-1-nikita@trvn.ru>
References: <20220612145955.385787-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases when MND is not enabled (e.g. when only Half Integer Divider is
used), setting D registers makes no effect.

Fail instead of making ineffective write.

Fixes: 7f891faf596e ("clk: qcom: clk-rcg2: Add support for duty-cycle for RCG")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/clk/qcom/clk-rcg2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 8e5dce09d162..2375e8122012 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -437,7 +437,7 @@ static int clk_rcg2_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	u32 notn_m, n, m, d, not2d, mask, duty_per;
+	u32 notn_m, n, m, d, not2d, mask, duty_per, cfg;
 	int ret;
 
 	/* Duty-cycle cannot be modified for non-MND RCGs */
@@ -448,6 +448,11 @@ static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 
 	regmap_read(rcg->clkr.regmap, RCG_N_OFFSET(rcg), &notn_m);
 	regmap_read(rcg->clkr.regmap, RCG_M_OFFSET(rcg), &m);
+	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+
+	/* Duty-cycle cannot be modified if MND divider is in bypass mode. */
+	if (!(cfg & CFG_MODE_MASK))
+		return -EINVAL;
 
 	n = (~(notn_m) + m) & mask;
 
-- 
2.35.3

