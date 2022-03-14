Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5294D7F55
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 11:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238080AbiCNKBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 06:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiCNKBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 06:01:45 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6001719C28;
        Mon, 14 Mar 2022 03:00:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647252035; x=1678788035;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LeMnOhM+GEPGEkeVg5rUIbVD4CakRFa9JprrFWKhPWQ=;
  b=N2oKZ6vMTbK/q+580dyLoe6PGyApoWwIk3xU3hCC+ZsKOx2y3OSD+UZu
   m+/yxrFmDQOhuPVXm9ob55gUJP34p9ANUdqENJB+jSbA/m6oi8dwJfZm+
   T0H1IlAJrbErrqBdnuwmiTQc6H1p8LxPUqcBp01YxBQwIfXYJWh8HUBpH
   s=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 14 Mar 2022 03:00:34 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 03:00:34 -0700
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Mar 2022 03:00:33 -0700
Received: from hu-ylal-hyd.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Mon, 14 Mar 2022 03:00:30 -0700
From:   Yogesh Lal <quic_ylal@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <quic_sibis@quicinc.com>
CC:     <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Yogesh Lal <quic_ylal@quicinc.com>
Subject: [PATCH] remoteproc: qcom: pas: Add elf64 support to coredump
Date:   Mon, 14 Mar 2022 15:30:13 +0530
Message-ID: <1647252013-7794-1-git-send-email-quic_ylal@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support to use elf64 coredumps to remote processors.

Signed-off-by: Yogesh Lal <quic_ylal@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 67 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 1ae47cc..58c335e 100644
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
@@ -721,6 +744,24 @@ static const struct adsp_data sm8350_cdsp_resource = {
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
@@ -755,6 +796,25 @@ static const struct adsp_data sc8180x_mpss_resource = {
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
@@ -879,10 +939,11 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm8350-cdsp-pas", .data = &sm8350_cdsp_resource},
 	{ .compatible = "qcom,sm8350-slpi-pas", .data = &sm8350_slpi_resource},
 	{ .compatible = "qcom,sm8350-mpss-pas", .data = &mpss_resource_init},
-	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8350_adsp_resource},
-	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8350_cdsp_resource},
+	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8450_adsp_resource},
+	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8450_cdsp_resource},
 	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sm8350_slpi_resource},
 	{ .compatible = "qcom,sm8450-mpss-pas", .data = &mpss_resource_init},
+	{ .compatible = "qcom,sm8450-mpss-pas", .data = &sm8450_mpss_resource},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adsp_of_match);
-- 
2.7.4

