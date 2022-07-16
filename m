Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E424577121
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 21:32:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232406AbiGPTcQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 15:32:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232300AbiGPTcL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 15:32:11 -0400
Received: from relay01.th.seeweb.it (relay01.th.seeweb.it [5.144.164.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F024B21E38
        for <linux-kernel@vger.kernel.org>; Sat, 16 Jul 2022 12:32:10 -0700 (PDT)
Received: from localhost.localdomain (abxj77.neoplus.adsl.tpnet.pl [83.9.3.77])
        by m-r1.th.seeweb.it (Postfix) with ESMTPA id 257D31F988;
        Sat, 16 Jul 2022 21:32:08 +0200 (CEST)
From:   Konrad Dybcio <konrad.dybcio@somainline.org>
To:     ~postmarketos/upstreaming@lists.sr.ht
Cc:     martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] soc: qcom: rpmpd: Add SM6375 support
Date:   Sat, 16 Jul 2022 21:32:01 +0200
Message-Id: <20220716193201.455728-2-konrad.dybcio@somainline.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220716193201.455728-1-konrad.dybcio@somainline.org>
References: <20220716193201.455728-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for RPMPDs on SM6375.

Signed-off-by: Konrad Dybcio <konrad.dybcio@somainline.org>
---
 drivers/soc/qcom/rpmpd.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soc/qcom/rpmpd.c b/drivers/soc/qcom/rpmpd.c
index 3b5b91621532..a6ea59193c42 100644
--- a/drivers/soc/qcom/rpmpd.c
+++ b/drivers/soc/qcom/rpmpd.c
@@ -29,6 +29,7 @@
 #define RPMPD_RWLM 0x6d6c7772
 #define RPMPD_RWSC 0x63737772
 #define RPMPD_RWSM 0x6d737772
+#define RPMPD_RWGX 0x78677772
 
 /* Operation Keys */
 #define KEY_CORNER		0x6e726f63 /* corn */
@@ -433,6 +434,26 @@ static const struct rpmpd_desc sm6125_desc = {
 	.max_state = RPM_SMD_LEVEL_BINNING,
 };
 
+DEFINE_RPMPD_PAIR(sm6375, vddgx, vddgx_ao, RWGX, LEVEL, 0);
+static struct rpmpd *sm6375_rpmpds[] = {
+	[SM6375_VDDCX] = &sm6125_vddcx,
+	[SM6375_VDDCX_AO] = &sm6125_vddcx_ao,
+	[SM6375_VDDCX_VFL] = &sm6125_vddcx_vfl,
+	[SM6375_VDDMX] = &sm6125_vddmx,
+	[SM6375_VDDMX_AO] = &sm6125_vddmx_ao,
+	[SM6375_VDDMX_VFL] = &sm6125_vddmx_vfl,
+	[SM6375_VDDGX] = &sm6375_vddgx,
+	[SM6375_VDDGX_AO] = &sm6375_vddgx_ao,
+	[SM6375_VDD_LPI_CX] = &sm6115_vdd_lpi_cx,
+	[SM6375_VDD_LPI_MX] = &sm6115_vdd_lpi_mx,
+};
+
+static const struct rpmpd_desc sm6375_desc = {
+	.rpmpds = sm6375_rpmpds,
+	.num_pds = ARRAY_SIZE(sm6375_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO_NO_CPR,
+};
+
 static struct rpmpd *qcm2290_rpmpds[] = {
 	[QCM2290_VDDCX] = &sm6115_vddcx,
 	[QCM2290_VDDCX_AO] = &sm6115_vddcx_ao,
@@ -465,6 +486,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,sdm660-rpmpd", .data = &sdm660_desc },
 	{ .compatible = "qcom,sm6115-rpmpd", .data = &sm6115_desc },
 	{ .compatible = "qcom,sm6125-rpmpd", .data = &sm6125_desc },
+	{ .compatible = "qcom,sm6375-rpmpd", .data = &sm6375_desc },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, rpmpd_match_table);
-- 
2.37.0

