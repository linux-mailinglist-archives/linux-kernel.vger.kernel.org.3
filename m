Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA1FC4C5DEC
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 18:55:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbiB0R41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 12:56:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiB0R40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 12:56:26 -0500
Received: from m43-7.mailgun.net (m43-7.mailgun.net [69.72.43.7])
        by lindbergh.monkeyblade.net (Postfix) with UTF8SMTPS id 1842B4C402
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 09:55:49 -0800 (PST)
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1645984549; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=gkmEjTo7bEyVIL1ziLsQ9rJ6k22A10FoGJSEH0UOV3Y=; b=eqA4W2tBvqN4ppE+ecq1dfrO74Zz2+do9OI+GhHlCVVrYkwWTXPDj6DM8YVAIeW0empMXwYi
 2DxTaTam8TqEaNX4tntMzMSw/8FZyUGrgnMcmD1l4tIeONDWBzsR1uLyxDRlVRWLQxs8BXZY
 /aaXhpOFlmD5EGughlyWZOYYXLo=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 621bbb2333c4b4b759947a26 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 27 Feb 2022 17:55:47
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 4F3A9C4360D; Sun, 27 Feb 2022 17:55:47 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0785EC4338F;
        Sun, 27 Feb 2022 17:55:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 0785EC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [v3 1/2] clk: qcom: clk-rcg2: Update logic to calculate D value for RCG
Date:   Sun, 27 Feb 2022 23:25:35 +0530
Message-Id: <20220227175536.3131-1-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The display pixel clock has a requirement on certain newer platforms to
support M/N as (2/3) and the final D value calculated results in
underflow errors.
As the current implementation does not check for D value is within
the accepted range for a given M & N value. Update the logic to
calculate the final D value based on the range.

Fixes: 99cbd064b059f ("clk: qcom: Support display RCG clocks")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
[v3]
  * Use clamp_t() instead of clamp().
  * Update the commit message for the display use case.

 drivers/clk/qcom/clk-rcg2.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e1b1b426fae4..b831975a9606 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -264,7 +264,7 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,

 static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 {
-	u32 cfg, mask;
+	u32 cfg, mask, d_val, not2d_val, n_minus_m;
 	struct clk_hw *hw = &rcg->clkr.hw;
 	int ret, index = qcom_find_src_index(hw, rcg->parent_map, f->src);

@@ -283,8 +283,17 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 		if (ret)
 			return ret;

+		/* Calculate 2d value */
+		d_val = f->n;
+
+		n_minus_m = f->n - f->m;
+		n_minus_m *= 2;
+
+		d_val = clamp_t(u32, d_val, f->m, n_minus_m);
+		not2d_val = ~d_val & mask;
+
 		ret = regmap_update_bits(rcg->clkr.regmap,
-				RCG_D_OFFSET(rcg), mask, ~f->n);
+				RCG_D_OFFSET(rcg), mask, not2d_val);
 		if (ret)
 			return ret;
 	}
--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

