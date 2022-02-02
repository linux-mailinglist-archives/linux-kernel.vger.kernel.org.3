Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45A694A7707
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 18:44:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiBBRma (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Feb 2022 12:42:30 -0500
Received: from so254-9.mailgun.net ([198.61.254.9]:32579 "EHLO
        so254-9.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229816AbiBBRm0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Feb 2022 12:42:26 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643823746; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=J3gQ6FNwmU8yLWv/91sOqrR3jHTVMWZ635ED0cGWAYw=; b=ILMr/ME4HfjksmvlmwV6nAOIvHHQDMwRBovDwjl9oXiXo4cLy1N2OIoZwRPF4UR7FHTzl2c1
 b3um8wuv4MMyRohrIl+0PayjLPDggrd+EvomZwHj6s/iXnqz4eZJ0F1GQnYOtDGzv3WVlpc1
 BTt1TV++Umz0dSw2k6Asemj0wJU=
X-Mailgun-Sending-Ip: 198.61.254.9
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n01.prod.us-west-2.postgun.com with SMTP id
 61fac28154b2901ff1cb7711 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Feb 2022 17:42:25
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 49F27C43616; Wed,  2 Feb 2022 17:42:25 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.0
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76DEAC4338F;
        Wed,  2 Feb 2022 17:42:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 76DEAC4338F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v2 1/2] clk: qcom: clk-rcg2: Update the calc_rate logic to handle determine rate
Date:   Wed,  2 Feb 2022 23:12:12 +0530
Message-Id: <20220202174213.21259-1-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the cases where the RCG parent implements the determine rate ops, the
calc_rate needs to be updated the calculate the rate.

Fixes: bcd61c0f535a0 ("clk: qcom: Add support for root clock generators (RCGs)")
Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 * Split the patch for PLL and RCG.
 * Update the Fixes tag.

 drivers/clk/qcom/clk-rcg2.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e1b1b426fae4..2e120a6dd19a 100644
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

