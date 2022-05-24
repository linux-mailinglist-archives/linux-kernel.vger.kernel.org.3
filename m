Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CDF7532AF5
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237593AbiEXNOI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237577AbiEXNOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:14:04 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D4793445;
        Tue, 24 May 2022 06:14:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653398042; x=1684934042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=vWbILLBnMdHBLbmdFGKxA0kDZzeAvZhYK0/2F+KujsU=;
  b=VRDaEiXdV8dRCi7zGhn+auyZgdA4oNGjbZ24PL0DK0rzfW6/FfUznjXj
   3Bl71HH287c1p6E3mEk9EbRcw3/sJrhMurDvsZysRtYWEEovPTyLuYCj6
   S9+0llSfDsG5EShiN/U+PyxGVwBzqetyCnOToMnAghI/RLqIgCrQV0QLn
   w=;
Received: from ironmsg09-lv.qualcomm.com ([10.47.202.153])
  by alexa-out.qualcomm.com with ESMTP; 24 May 2022 06:14:01 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg09-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:14:01 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:14:01 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:13:57 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Yogesh Lal" <quic_ylal@quicinc.com>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH 1/7] remoteproc: qcom: pas: Fixup the elf class for SM8450 remoteprocs
Date:   Tue, 24 May 2022 18:43:31 +0530
Message-ID: <1653398017-28426-2-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653398017-28426-1-git-send-email-quic_sibis@quicinc.com>
References: <1653398017-28426-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yogesh Lal <quic_ylal@quicinc.com>

The coredumps for the ADSP,CDSP and MPSS subsystems will be 64 bit from
SM8450 SoCs onward. Update the elf class as elf64 accordingly.

Fixes: 5cef9b48458d ("remoteproc: qcom: pas: Add SM8450 remoteproc support")
Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 68 +++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 4 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6ae39c5653b1..8ce68d0bb1bc 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -34,6 +34,7 @@ struct adsp_data {
 	const char *firmware_name;
 	int pas_id;
 	unsigned int minidump_id;
+	bool uses_elf64;
 	bool has_aggre2_clk;
 	bool auto_boot;
 
@@ -450,7 +451,11 @@ static int adsp_probe(struct platform_device *pdev)
 	}
 
 	rproc->auto_boot = desc->auto_boot;
-	rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
+
+	if (desc->uses_elf64)
+		rproc_coredump_set_elf_info(rproc, ELFCLASS64, EM_NONE);
+	else
+		rproc_coredump_set_elf_info(rproc, ELFCLASS32, EM_NONE);
 
 	adsp = (struct qcom_adsp *)rproc->priv;
 	adsp->dev = &pdev->dev;
@@ -617,6 +622,24 @@ static const struct adsp_data sm8350_adsp_resource = {
 	.ssctl_id = 0x14,
 };
 
+static const struct adsp_data sm8450_adsp_resource = {
+	.crash_reason_smem = 423,
+	.firmware_name = "adsp.mdt",
+	.pas_id = 1,
+	.uses_elf64 = true,
+	.has_aggre2_clk = false,
+	.auto_boot = true,
+	.proxy_pd_names = (char*[]){
+		"lcx",
+		"lmx",
+		NULL
+	},
+	.load_state = "adsp",
+	.ssr_name = "lpass",
+	.sysmon_name = "adsp",
+	.ssctl_id = 0x14,
+};
+
 static const struct adsp_data msm8996_adsp_resource = {
 		.crash_reason_smem = 423,
 		.firmware_name = "adsp.mdt",
@@ -751,6 +774,24 @@ static const struct adsp_data sm8350_cdsp_resource = {
 	.ssctl_id = 0x17,
 };
 
+static const struct adsp_data sm8450_cdsp_resource = {
+	.crash_reason_smem = 601,
+	.firmware_name = "cdsp.mdt",
+	.pas_id = 18,
+	.uses_elf64 = true,
+	.has_aggre2_clk = false,
+	.auto_boot = true,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mxc",
+		NULL
+	},
+	.load_state = "cdsp",
+	.ssr_name = "cdsp",
+	.sysmon_name = "cdsp",
+	.ssctl_id = 0x17,
+};
+
 static const struct adsp_data mpss_resource_init = {
 	.crash_reason_smem = 421,
 	.firmware_name = "modem.mdt",
@@ -785,6 +826,25 @@ static const struct adsp_data sc8180x_mpss_resource = {
 	.ssctl_id = 0x12,
 };
 
+static const struct adsp_data sm8450_mpss_resource = {
+	.crash_reason_smem = 421,
+	.firmware_name = "modem.mdt",
+	.pas_id = 4,
+	.minidump_id = 3,
+	.uses_elf64 = true,
+	.has_aggre2_clk = false,
+	.auto_boot = false,
+	.proxy_pd_names = (char*[]){
+		"cx",
+		"mss",
+		NULL
+	},
+	.load_state = "modem",
+	.ssr_name = "mpss",
+	.sysmon_name = "modem",
+	.ssctl_id = 0x12,
+};
+
 static const struct adsp_data slpi_resource_init = {
 		.crash_reason_smem = 424,
 		.firmware_name = "slpi.mdt",
@@ -913,10 +973,10 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm8350-cdsp-pas", .data = &sm8350_cdsp_resource},
 	{ .compatible = "qcom,sm8350-slpi-pas", .data = &sm8350_slpi_resource},
 	{ .compatible = "qcom,sm8350-mpss-pas", .data = &mpss_resource_init},
-	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8350_adsp_resource},
-	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8350_cdsp_resource},
+	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8450_adsp_resource},
+	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8450_cdsp_resource},
 	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sm8350_slpi_resource},
-	{ .compatible = "qcom,sm8450-mpss-pas", .data = &mpss_resource_init},
+	{ .compatible = "qcom,sm8450-mpss-pas", .data = &sm8450_mpss_resource},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adsp_of_match);
-- 
2.7.4

