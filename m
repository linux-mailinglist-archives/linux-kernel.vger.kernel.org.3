Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C36858597F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Jul 2022 11:19:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbiG3JS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Jul 2022 05:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbiG3JSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Jul 2022 05:18:22 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 060CB41D19;
        Sat, 30 Jul 2022 02:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1659172701; x=1690708701;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=WVPx/KX6To8JoYkXn1eofLsUkqE8StNK5f16O84HSHs=;
  b=RGBQaUvkzMFhn5GSsr3ensbkM4EJJ4TX+4xhyCCtcrhvohHMTwS5JZyE
   A5kIzuY4w0hiGw1m7ejR8rsWbGup4c3OiLzSD7jhx3ZGAH+gs37PizFRA
   uxfNJFAjnbfOl8EIGwOGQ/rMIVjTaRgbCSDW9PuzUuztUVt1tMgi+pNlP
   Y=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 30 Jul 2022 02:18:20 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2022 02:18:20 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 02:18:19 -0700
Received: from hyd-lnxbld559.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sat, 30 Jul 2022 02:18:15 -0700
From:   Akhil P Oommen <quic_akhilpo@quicinc.com>
To:     freedreno <freedreno@lists.freedesktop.org>,
        <dri-devel@lists.freedesktop.org>, <linux-arm-msm@vger.kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        "Stephen Boyd" <swboyd@chromium.org>
CC:     Douglas Anderson <dianders@chromium.org>,
        Akhil P Oommen <quic_akhilpo@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Stephen Boyd <sboyd@kernel.org>, <linux-clk@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/5] clk: qcom: Allow custom reset ops
Date:   Sat, 30 Jul 2022 14:47:41 +0530
Message-ID: <20220730144713.2.I4b69f984a97535179acd9637426a1331f84f6646@changeid>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1659172664-10345-1-git-send-email-quic_akhilpo@quicinc.com>
References: <1659172664-10345-1-git-send-email-quic_akhilpo@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to allow soc specific clk drivers to specify a custom reset
operation. A consumer-driver of the reset framework can call
"reset_control_reset()" api to trigger this.

Signed-off-by: Akhil P Oommen <quic_akhilpo@quicinc.com>
---

 drivers/clk/qcom/reset.c | 6 ++++++
 drivers/clk/qcom/reset.h | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/clk/qcom/reset.c b/drivers/clk/qcom/reset.c
index 819d194..4782bf1 100644
--- a/drivers/clk/qcom/reset.c
+++ b/drivers/clk/qcom/reset.c
@@ -13,6 +13,12 @@
 
 static int qcom_reset(struct reset_controller_dev *rcdev, unsigned long id)
 {
+	struct qcom_reset_controller *rst = to_qcom_reset_controller(rcdev);
+	const struct qcom_reset_map *map = &rst->reset_map[id];
+
+	if (map->op)
+		return map->op(map);
+
 	rcdev->ops->assert(rcdev, id);
 	udelay(1);
 	rcdev->ops->deassert(rcdev, id);
diff --git a/drivers/clk/qcom/reset.h b/drivers/clk/qcom/reset.h
index 2a08b5e..295deeb 100644
--- a/drivers/clk/qcom/reset.h
+++ b/drivers/clk/qcom/reset.h
@@ -11,6 +11,8 @@
 struct qcom_reset_map {
 	unsigned int reg;
 	u8 bit;
+	int (*op)(const struct qcom_reset_map *map);
+	void *priv;
 };
 
 struct regmap;
-- 
2.7.4

