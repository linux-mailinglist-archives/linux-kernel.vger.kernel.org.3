Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EC69498634
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 18:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241460AbiAXRPf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 12:15:35 -0500
Received: from m43-7.mailgun.net ([69.72.43.7]:38867 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244403AbiAXRPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 12:15:33 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1643044533; h=Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=piowxZvxdRmjQpd/2H1/kJab1tq+eQt2F5u4/0VD8C0=; b=HmnuTIHjVehS+l+Zp/7SpxMP1tH/x9jki6Kx5Ies+8jJrmGuN+t/5uhyF7aGvC2bx3eOq4JG
 oU4Mws5QKJp53Kdq0J2Mne0XMlNccx6xJfDc/1oIEqgQxqjG5ZjGOXSuMKw+FPahrXk79JrE
 Uv2I3jCgl3CUUjuhM7DTn3Pt3fE=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n04.prod.us-east-1.postgun.com with SMTP id
 61eede7362864ab1016bbae1 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 24 Jan 2022 17:14:27
 GMT
Sender: tdas=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 99D98C4360D; Mon, 24 Jan 2022 17:14:26 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,SPF_FAIL,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from hu-tdas-hyd.qualcomm.com (unknown [202.46.22.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tdas)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3ACDDC4360D;
        Mon, 24 Jan 2022 17:14:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 smtp.codeaurora.org 3ACDDC4360D
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=codeaurora.org
From:   Taniya Das <tdas@codeaurora.org>
To:     Stephen Boyd <sboyd@kernel.org>,
        =?UTF-8?q?Michael=20Turquette=20=C2=A0?= <mturquette@baylibre.com>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
Subject: [PATCH v1] clk: qcom: clk-rcg2: Update logic to calculate D value for RCG
Date:   Mon, 24 Jan 2022 22:44:15 +0530
Message-Id: <20220124171415.12293-1-tdas@codeaurora.org>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current implementation does not check for D value is within
the accepted range for a given M & N value. Update the logic to
calculate the final D value based on the range. While at it, add
support for 2/3 divider in frac_table_pixel.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
---
 drivers/clk/qcom/clk-rcg2.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/qcom/clk-rcg2.c b/drivers/clk/qcom/clk-rcg2.c
index e1b1b426fae4..036c8071c07a 100644
--- a/drivers/clk/qcom/clk-rcg2.c
+++ b/drivers/clk/qcom/clk-rcg2.c
@@ -264,7 +264,7 @@ static int clk_rcg2_determine_floor_rate(struct clk_hw *hw,

 static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 {
-	u32 cfg, mask;
+	u32 cfg, mask, d_val, not2d_val;
 	struct clk_hw *hw = &rcg->clkr.hw;
 	int ret, index = qcom_find_src_index(hw, rcg->parent_map, f->src);

@@ -283,8 +283,18 @@ static int __clk_rcg2_configure(struct clk_rcg2 *rcg, const struct freq_tbl *f)
 		if (ret)
 			return ret;

+		/* Calculate 2d value */
+		d_val = f->n;
+
+		if (d_val > ((f->n - f->m) * 2))
+			d_val = (f->n - f->m) * 2;
+		else if (d_val < f->m)
+			d_val = f->m;
+
+		not2d_val = ~d_val & mask;
+
 		ret = regmap_update_bits(rcg->clkr.regmap,
-				RCG_D_OFFSET(rcg), mask, ~f->n);
+				RCG_D_OFFSET(rcg), mask, not2d_val);
 		if (ret)
 			return ret;
 	}
@@ -720,6 +730,7 @@ static const struct frac_entry frac_table_pixel[] = {
 	{ 2, 9 },
 	{ 4, 9 },
 	{ 1, 1 },
+	{ 2, 3 },
 	{ }
 };

--
Qualcomm INDIA, on behalf of Qualcomm Innovation Center, Inc.is a member
of the Code Aurora Forum, hosted by the  Linux Foundation.

