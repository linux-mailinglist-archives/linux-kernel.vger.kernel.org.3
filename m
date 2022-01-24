Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 22781498730
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:48:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244764AbiAXRsS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:48:18 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:40737 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244756AbiAXRsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:48:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643046497; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=n6pHHOxCCYOAM02Hqw1Syr3yAj3bYgyJj+Ni9K6zpx8=; b=wHNg7AWc6wqv/BHGDO0VwzRiZH6Jx4xXLYiqaGuWXyCQr7q9dCOEipmVeJrz/VWGpcDNQC/z
 AvPpD8H/HGgnuJZ7xlrIJOVvFGR2j5f4bm0G9SrId7EzWgbph2d7unkITTiHvy2J+XGhhRMr
 JaFu8y2TpuX4T8MxAzh1anH9J/Q=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n08.prod.us-east-1.postgun.com with SMTP id
 61eee6609c5d22ce3133a972 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Jan 2022 17:48:16
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 63607C43619; Mon, 24 Jan 2022 17:48:15 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3251BC4338F;
        Mon, 24 Jan 2022 17:48:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3251BC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] clk qcom: clk-alpha-pll: Update to use determine rate ops for PLL
Date:   Mon, 24 Jan 2022 23:18:05 +0530
Message-Id: <20220124174805.31021-1-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 32 bit devices, where the PLL requires to support the frequency
beyond the range of the `long int` the round rate ops cannot support.
Thus update the clk_ops to use determine rate instead.

While at it also fix the code in RCG.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-alpha-pll.c | 21 +++++++++++++++++----
 drivers/clk/qcom/clk-rcg2.c      | 10 +++++-----
 2 files changed, 22 insertions(+), 9 deletions(-)

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
diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index 036c8071c07a..19614ece4e9d 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -147,19 +147,19 @@ static int clk_rcg2_set_parent(struct clk_hw *hw, u8 index)
 static unsigned long
 calc_rate(unsigned long rate, u32 m, u32 n, u32 mode, u32 hid_div)
 {
+	u64 tmp = rate;
+
 	if (hid_div) {
-		rate *= 2;
-		rate /= hid_div + 1;
+		tmp *= 2;
+		do_div(tmp, hid_div + 1);
 	}

 	if (mode) {
-		u64 tmp = rate;
 		tmp *= m;
 		do_div(tmp, n);
-		rate = tmp;
 	}

-	return rate;
+	return tmp;
 }

 static unsigned long
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

