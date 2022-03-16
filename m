Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5ABC4DAA5D
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 07:07:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353693AbiCPGI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 02:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241418AbiCPGIx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 02:08:53 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F77B60A92;
        Tue, 15 Mar 2022 23:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647410859; x=1678946859;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references;
  bh=LPUfzeaTyr5ek29w4i5coSoqEmtD9nYkIv5gQoB2Fpk=;
  b=FMoAChQ8Zld/f8Ls+JXpaOA0yLqnPFimh5vHeJLw63Wrd+p0E2dKFo0T
   d39fYSFgKyHFd2iUPlD0aEy7mb1dPrq/DCkyx1sQfHDTrn69GL5o9TvYG
   kkc0RoCNKUIR0HzFlX1jJB2tXnOzTWwu6KrkwluorgE6EORfFHbBUTFq2
   o=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 15 Mar 2022 23:07:39 -0700
X-QCInternal: smtphost
Received: from ironmsg01-blr.qualcomm.com ([10.86.208.130])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/AES256-SHA; 15 Mar 2022 23:07:37 -0700
X-QCInternal: smtphost
Received: from hu-rohiagar-hyd.qualcomm.com (HELO hu-sgudaval-hyd.qualcomm.com) ([10.213.106.138])
  by ironmsg01-blr.qualcomm.com with ESMTP; 16 Mar 2022 11:37:23 +0530
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3970568)
        id EDAB94495; Wed, 16 Mar 2022 11:37:21 +0530 (+0530)
From:   Rohit Agarwal <quic_rohiagar@quicinc.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org, lgirdwood@gmail.com,
        broonie@kernel.org, rnayak@codeaurora.org, collinsd@codeaurora.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rohit Agarwal <quic_rohiagar@quicinc.com>
Subject: [PATCH 4/6] soc: qcom: rpmhpd: Add SDX65 power domains
Date:   Wed, 16 Mar 2022 11:37:15 +0530
Message-Id: <1647410837-22537-5-git-send-email-quic_rohiagar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
References: <1647410837-22537-1-git-send-email-quic_rohiagar@quicinc.com>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add power domains found in Qualcomm SDX65 SoC.

Signed-off-by: Rohit Agarwal <quic_rohiagar@quicinc.com>
---
 drivers/soc/qcom/rpmhpd.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/soc/qcom/rpmhpd.c b/drivers/soc/qcom/rpmhpd.c
index 58f1dc9..11102ac 100644
--- a/drivers/soc/qcom/rpmhpd.c
+++ b/drivers/soc/qcom/rpmhpd.c
@@ -210,6 +210,21 @@ static const struct rpmhpd_desc sdx55_desc = {
 	.num_pds = ARRAY_SIZE(sdx55_rpmhpds),
 };
 
+/* SDX65 RPMH powerdomains */
+static struct rpmhpd *sdx65_rpmhpds[] = {
+	[SDX65_CX] = &cx_w_mx_parent,
+	[SDX65_CX_AO] = &cx_ao_w_mx_parent,
+	[SDX65_MSS] = &mss,
+	[SDX65_MX] = &mx,
+	[SDX65_MX_AO] = &mx_ao,
+	[SDX65_MXC] = &mxc,
+};
+
+static const struct rpmhpd_desc sdx65_desc = {
+	.rpmhpds = sdx65_rpmhpds,
+	.num_pds = ARRAY_SIZE(sdx65_rpmhpds),
+};
+
 /* SM6350 RPMH powerdomains */
 static struct rpmhpd *sm6350_rpmhpds[] = {
 	[SM6350_CX] = &cx_w_mx_parent,
@@ -369,6 +384,7 @@ static const struct of_device_id rpmhpd_match_table[] = {
 	{ .compatible = "qcom,sc8180x-rpmhpd", .data = &sc8180x_desc },
 	{ .compatible = "qcom,sdm845-rpmhpd", .data = &sdm845_desc },
 	{ .compatible = "qcom,sdx55-rpmhpd", .data = &sdx55_desc},
+	{ .compatible = "qcom,sdx65-rpmhpd", .data = &sdx65_desc},
 	{ .compatible = "qcom,sm6350-rpmhpd", .data = &sm6350_desc },
 	{ .compatible = "qcom,sm8150-rpmhpd", .data = &sm8150_desc },
 	{ .compatible = "qcom,sm8250-rpmhpd", .data = &sm8250_desc },
-- 
2.7.4

