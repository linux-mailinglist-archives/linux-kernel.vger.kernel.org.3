Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4189552E05C
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 01:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245728AbiESXMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 19:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245704AbiESXL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 19:11:58 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E31E7F74B4;
        Thu, 19 May 2022 16:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653001917; x=1684537917;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=unpenesDDwrZN5kKZCLWhLbk+6mWJFehUp/g2c0KjOk=;
  b=NlDIatqHm67u0EUgJ1H9WA7NZLICT1JCV0LWM7Vc++fRtbrVG9rUv5zC
   4j4jQ+530jIYEN6NcCNyj3laIrcGkro7GQEyMo/59aSfC/pYyVC36gUmG
   tz8P78ayOk9r2O/UGBiexO397jWaDTGey7ushqXTJFfm2u4BG5UBWRAtZ
   w=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 19 May 2022 16:11:57 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 16:11:57 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 16:11:56 -0700
Received: from khsieh-linux1.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 16:11:56 -0700
From:   Kuogee Hsieh <quic_khsieh@quicinc.com>
To:     <dri-devel@lists.freedesktop.org>, <robdclark@gmail.com>,
        <sean@poorly.run>, <swboyd@chromium.org>, <dianders@chromium.org>,
        <vkoul@kernel.org>, <daniel@ffwll.ch>, <airlied@linux.ie>,
        <agross@kernel.org>, <dmitry.baryshkov@linaro.org>,
        <bjorn.andersson@linaro.org>
CC:     Kuogee Hsieh <quic_khsieh@quicinc.com>,
        <quic_abhinavk@quicinc.com>, <quic_aravindh@quicinc.com>,
        <quic_sbillaka@quicinc.com>, <freedreno@lists.freedesktop.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 2/3] phy: qcom-qmp: add regulator_set_load to dp phy
Date:   Thu, 19 May 2022 16:11:41 -0700
Message-ID: <1653001902-26910-3-git-send-email-quic_khsieh@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653001902-26910-1-git-send-email-quic_khsieh@quicinc.com>
References: <1653001902-26910-1-git-send-email-quic_khsieh@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add regulator_set_load() before enable regulator at
DP phy driver.

Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
---
 drivers/phy/qualcomm/phy-qcom-qmp.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
index b144ae1..fcf87ae 100644
--- a/drivers/phy/qualcomm/phy-qcom-qmp.c
+++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
@@ -3130,6 +3130,7 @@ struct qmp_phy_cfg {
 	int num_resets;
 	/* regulators to be requested */
 	const char * const *vreg_list;
+	const unsigned int *vreg_enable_load;
 	int num_vregs;
 
 	/* array of registers with different offsets */
@@ -3346,6 +3347,10 @@ static const char * const qmp_phy_vreg_l[] = {
 	"vdda-phy", "vdda-pll",
 };
 
+static const unsigned int qmp_phy_vreg_enable_load[] = {
+	21800, 36000
+};
+
 static const struct qmp_phy_cfg ipq8074_usb3phy_cfg = {
 	.type			= PHY_TYPE_USB3,
 	.nlanes			= 1,
@@ -3711,6 +3716,7 @@ static const struct qmp_phy_cfg sc7180_usb3phy_cfg = {
 	.reset_list		= sc7180_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(sc7180_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
+	.vreg_enable_load	= qmp_phy_vreg_enable_load,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
@@ -3749,6 +3755,7 @@ static const struct qmp_phy_cfg sc7180_dpphy_cfg = {
 	.reset_list		= sc7180_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(sc7180_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
+	.vreg_enable_load	= qmp_phy_vreg_enable_load,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
@@ -3940,6 +3947,7 @@ static const struct qmp_phy_cfg sm8150_usb3phy_cfg = {
 	.reset_list		= msm8996_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
+	.vreg_enable_load	= qmp_phy_vreg_enable_load,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
 
@@ -4009,6 +4017,7 @@ static const struct qmp_phy_cfg sc8180x_dpphy_cfg = {
 	.reset_list		= sc7180_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(sc7180_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
+	.vreg_enable_load	= qmp_phy_vreg_enable_load,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v3_usb3phy_regs_layout,
 
@@ -4072,6 +4081,7 @@ static const struct qmp_phy_cfg sm8250_usb3phy_cfg = {
 	.reset_list		= msm8996_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
+	.vreg_enable_load	= qmp_phy_vreg_enable_load,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
 
@@ -4139,6 +4149,7 @@ static const struct qmp_phy_cfg sm8250_dpphy_cfg = {
 	.reset_list		= msm8996_usb3phy_reset_l,
 	.num_resets		= ARRAY_SIZE(msm8996_usb3phy_reset_l),
 	.vreg_list		= qmp_phy_vreg_l,
+	.vreg_enable_load	= qmp_phy_vreg_enable_load,
 	.num_vregs		= ARRAY_SIZE(qmp_phy_vreg_l),
 	.regs			= qmp_v4_usb3phy_regs_layout,
 
@@ -5008,6 +5019,11 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
 		return 0;
 	}
 
+	if (cfg->vreg_enable_load) {
+		for (i = 0; i < cfg->num_vregs; i++)
+			regulator_set_load(qmp->vregs[i].consumer, cfg->vreg_enable_load[i]);
+	}
+
 	/* turn on regulator supplies */
 	ret = regulator_bulk_enable(cfg->num_vregs, qmp->vregs);
 	if (ret) {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

