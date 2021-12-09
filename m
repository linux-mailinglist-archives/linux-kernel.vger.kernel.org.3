Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4138646ED39
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 17:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240123AbhLIQlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 11:41:15 -0500
Received: from box.trvn.ru ([194.87.146.52]:37177 "EHLO box.trvn.ru"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232484AbhLIQlO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 11:41:14 -0500
Received: from authenticated-user (box.trvn.ru [194.87.146.52])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by box.trvn.ru (Postfix) with ESMTPSA id 0E7E641F11;
        Thu,  9 Dec 2021 21:37:32 +0500 (+05)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=trvn.ru; s=mail;
        t=1639067853; bh=R94w1FLumb+TBnOujhfbT4mF8MJQyo9KAMn2JGNsyvk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=tGlY3TItarPP7YzRj3umBlYniqehPgj05qATx12yKmD+z7CmqyHhgctXYQGXhDl09
         ppFc3nuWV5Hq1YD/UnradrDcrUbzEQESnNHsJEgCIDeOnRgOp8FPRlr6dOkf7C08FA
         fUMacTUCJunJs6xUeVMap4ZmQc8w8nR/TppyFSbFs33kM0qF5AIFdNpUX9Wvb5Oc29
         gACk0DGjgR7RSTLTU6KePaNhPq4cyY91fcCODiyfgESNpfoOz/zojEnywcFYzMnZYQ
         WuNribOaxk/ABYDXqsy7JvoGRzusvqV74iIb3jraHoSzootLqzSPoju1jM4+H7f5Cd
         97LVCUtAQJOtw==
From:   Nikita Travkin <nikita@trvn.ru>
To:     mturquette@baylibre.com, sboyd@kernel.org, linus.walleij@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org, tdas@codeaurora.org,
        joonwoop@codeaurora.org, svarbanov@mm-sol.com,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Nikita Travkin <nikita@trvn.ru>
Subject: [PATCH 1/4] clk: qcom: clk-rcg2: Fail Duty-Cycle configuration if MND divider is not enabled.
Date:   Thu,  9 Dec 2021 21:37:17 +0500
Message-Id: <20211209163720.106185-2-nikita@trvn.ru>
In-Reply-To: <20211209163720.106185-1-nikita@trvn.ru>
References: <20211209163720.106185-1-nikita@trvn.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases when MND is not enabled (e.g. when only Half Integer Divider is
used), setting D registers makes no effect. Fail instead of making
ineffective write.

Fixes: 7f891faf596e ("clk: qcom: clk-rcg2: Add support for duty-cycle for RCG")
Signed-off-by: Nikita Travkin <nikita@trvn.ru>
---
 drivers/clk/qcom/clk-rcg2.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e1b1b426fae4..6964cf914b60 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -396,7 +396,7 @@ static int clk_rcg2_get_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 {
 	struct clk_rcg2 *rcg = to_clk_rcg2(hw);
-	u32 notn_m, n, m, d, not2d, mask, duty_per;
+	u32 notn_m, n, m, d, not2d, mask, duty_per, cfg;
 	int ret;
 
 	/* Duty-cycle cannot be modified for non-MND RCGs */
@@ -407,6 +407,11 @@ static int clk_rcg2_set_duty_cycle(struct clk_hw *hw, struct clk_duty *duty)
 
 	regmap_read(rcg->clkr.regmap, RCG_N_OFFSET(rcg), &notn_m);
 	regmap_read(rcg->clkr.regmap, RCG_M_OFFSET(rcg), &m);
+	regmap_read(rcg->clkr.regmap, RCG_CFG_OFFSET(rcg), &cfg);
+
+	/* Duty-cycle cannot be modified if MND divider is in bypass mode. */
+	if (!(cfg & CFG_MODE_MASK))
+		return -EINVAL;
 
 	n = (~(notn_m) + m) & mask;
 
-- 
2.30.2

