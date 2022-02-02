Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E2D14A7705
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:44:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346330AbiBBRmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:42:32 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:42116 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234635AbiBBRmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:42:31 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643823751; h=References: In-Reply-To: Message-Id: Date:
 Subject: Cc: To: From: Sender;
 bh=XXGHacUGDA8T2oMG/LGqkka2QKznuATpVP6h9ySIS9s=; b=QTqMCp4dfyg/CeAHqucHP7pDRRfFnqA1Wg4fGn/JtO7pnX2opTGN7LTtmp95VNCEwxSVAQA8
 lwLav6Cz+8BluHZmCvj1nRD7J7K1LOn0CSMGy/VwDs+UaOgzX+ROoiRjWMnjye4QKoPq9B9e
 4aVw+FlKOqEh1U8OMc/uLaha0To=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 61fac286d9f69c72767482c7 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Feb 2022 17:42:30
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 66835C43616; Wed,  2 Feb 2022 17:42:30 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.0
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 26728C4338F;
        Wed,  2 Feb 2022 17:42:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 26728C4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 2/2] clk: qcom: clk-alpha-pll: Update to use determine rate ops for PLL
Date:   Wed,  2 Feb 2022 23:12:13 +0530
Message-Id: <20220202174213.21259-2-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220202174213.21259-1-tdas@codeaurora.org>
References: <20220202174213.21259-1-tdas@codeaurora.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32 bit devices, where the PLL requires to support the frequency
beyond the range of the `long int` the round rate ops cannot support.
Thus update the clk_ops to use determine rate instead.

Fixes: 134b55b7e19f8 ("clk: qcom: support Huayra type Alpha PLL")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/qcom/clk-alpha-pll.c b/drivers/clk/qcom/clk-alpha-pll.c
index 4406cf609aae..4e2e93cd8c8b 100644
--- a/drivers/clk/qcom/clk-alpha-pll.c
+++ b/drivers/clk/qcom/clk-alpha-pll.c
@@ -812,12 +812,25 @@ static int alpha_pll_huayra_set_rate(struct clk_hw *hw, unsigned long rate,
 	return 0;
 }

-static long alpha_pll_huayra_round_rate(struct clk_hw *hw, unsigned long rate,
-					unsigned long *prate)
+static int alpha_pll_huayra_determine_rate(struct clk_hw *hw,
+					struct clk_rate_request *req)
 {
+	struct clk_hw *parent_hw;
+	unsigned long rrate, prate;
 	u32 l, a;

-	return alpha_huayra_pll_round_rate(rate, *prate, &l, &a);
+	parent_hw = clk_hw_get_parent(hw);
+	if (!parent_hw)
+		return -EINVAL;
+
+	prate = clk_hw_get_rate(parent_hw);
+	rrate = alpha_huayra_pll_round_rate(req->rate, prate, &l, &a);
+
+	req->best_parent_hw = parent_hw;
+	req->best_parent_rate = prate;
+	req->rate = rrate;
+
+	return 0;
 }

 static int trion_pll_is_enabled(struct clk_alpha_pll *pll,
@@ -946,7 +959,7 @@ const struct clk_ops clk_alpha_pll_huayra_ops = {
 	.disable = clk_alpha_pll_disable,
 	.is_enabled = clk_alpha_pll_is_enabled,
 	.recalc_rate = alpha_pll_huayra_recalc_rate,
-	.round_rate = alpha_pll_huayra_round_rate,
+	.determine_rate = alpha_pll_huayra_determine_rate,
 	.set_rate = alpha_pll_huayra_set_rate,
 };
 EXPORT_SYMBOL_GPL(clk_alpha_pll_huayra_ops);
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

