Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61187463FFD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 22:24:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344080AbhK3V10 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 16:27:26 -0500
Received: from m-r2.th.seeweb.it ([5.144.164.171]:35649 "EHLO
        m-r2.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344011AbhK3V1I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 16:27:08 -0500
Received: from localhost.localdomain (adsl-d210.84-47-0.t-com.sk [84.47.0.210])
        by m-r2.th.seeweb.it (Postfix) with ESMTPA id BF3BA3F43B;
        Tue, 30 Nov 2021 22:23:46 +0100 (CET)
From:   Martin Botka <martin.botka@somainline.org>
To:     martin.botka1@gmail.com
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        konrad.dybcio@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        paul.bouchara@somainline.org,
        Martin Botka <martin.botka@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] drivers: soc: qcom: rpmpd: Add support for sm6125
Date:   Tue, 30 Nov 2021 22:23:30 +0100
Message-Id: <20211130212332.25401-2-martin.botka@somainline.org>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211130212332.25401-1-martin.botka@somainline.org>
References: <20211130212332.25401-1-martin.botka@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add RPM power domains located in Qualcomm SM6125
SoC.

Signed-off-by: Martin Botka <martin.botka@somainline.org>
---
 drivers/soc/qcom/rpmpd.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 36b2381039e6..0a8d8d24bfb7 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -395,6 +395,28 @@ static const struct rpmpd_desc sm6115_desc = {
 	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
 };
 
+/* sm6125 RPM Power domains */
+DEFINE_RPMPD_PAIR(sm6125, vddcx, vddcx_ao, RWCX, LEVEL, 0);
+DEFINE_RPMPD_VFL(sm6125, vddcx_vfl, RWCX, 0);
+
+DEFINE_RPMPD_PAIR(sm6125, vddmx, vddmx_ao, RWMX, LEVEL, 0);
+DEFINE_RPMPD_VFL(sm6125, vddmx_vfl, RWMX, 0);
+
+static struct rpmpd *sm6125_rpmpds[] = {
+	[SM6125_VDDCX] =		&sm6125_vddcx,
+	[SM6125_VDDCX_AO] =		&sm6125_vddcx_ao,
+	[SM6125_VDDCX_VFL] =		&sm6125_vddcx_vfl,
+	[SM6125_VDDMX] =		&sm6125_vddmx,
+	[SM6125_VDDMX_AO] =		&sm6125_vddmx_ao,
+	[SM6125_VDDMX_VFL] =		&sm6125_vddmx_vfl,
+};
+
+static const struct rpmpd_desc sm6125_desc = {
+	.rpmpds = sm6125_rpmpds,
+	.num_pds = ARRAY_SIZE(sm6125_rpmpds),
+	.max_state = RPM_SMD_LEVEL_BINNING,
+};
+
 static struct rpmpd *qcm2290_rpmpds[] = {
 	[QCM2290_VDDCX] = &sm6115_vddcx,
 	[QCM2290_VDDCX_AO] = &sm6115_vddcx_ao,
@@ -425,6 +447,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,qcs404-rpmpd", .data = &qcs404_desc },
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },
+	{ .compatible = "qcom,sm6125-rpmpd", .data = &sm6125_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpmpd_match_table);
-- 
2.34.0

