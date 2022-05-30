Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A690F537526
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 09:24:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232779AbiE3GXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 02:23:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232767AbiE3GXK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 02:23:10 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00C2B487;
        Sun, 29 May 2022 23:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653891790; x=1685427790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=Zhjw5wjT4DU/ZqIbobCSO5u3VL9ubyxGEYoFZFgyKcA=;
  b=ANVfcTbBi/nb/9KH1Wi7DfVBp29hQ9PHWzAigdPGASCm1/5KbPJ5DUiB
   Cpd2QLh54Udsfj+eqM9fn+lIwfzzfF26VNn7mcu8FHn2Eckjgd1vafu4s
   UvQlQNF3qVjGFKG8IpUkoj8zaIzecHmJqWw3t+Bq+9hxKheVYzGv0stwJ
   4=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 29 May 2022 23:23:09 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 May 2022 23:23:08 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 29 May 2022 23:23:08 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 29 May 2022 23:23:05 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [V2 1/6] remoteproc: qcom: pas: Add decrypt shutdown support for modem
Date:   Mon, 30 May 2022 11:52:46 +0530
Message-ID: <1653891771-17103-2-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653891771-17103-1-git-send-email-quic_sibis@quicinc.com>
References: <1653891771-17103-1-git-send-email-quic_sibis@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

The initial shutdown request to modem on SM8450 SoCs would start the
decryption process and will keep returning errors until the modem shutdown
is complete. Fix this by retrying shutdowns in fixed intervals.

Err Logs on modem shutdown:
qcom_q6v5_pas 4080000.remoteproc: failed to shutdown: -22
remoteproc remoteproc3: can't stop rproc: -22

Fixes: 5cef9b48458d ("remoteproc: qcom: pas: Add SM8450 remoteproc support")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 67 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6ae39c5653b1..02435810dc7c 100644
--- a/drivers/remoteproc/qcom_q6v5_pas.c
+++ b/drivers/remoteproc/qcom_q6v5_pas.c
@@ -8,6 +8,7 @@
  */
 
 #include <linux/clk.h>
+#include <linux/delay.h>
 #include <linux/firmware.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
@@ -29,6 +30,8 @@
 #include "qcom_q6v5.h"
 #include "remoteproc_internal.h"
 
+#define ADSP_DECRYPT_SHUTDOWN_DELAY_MS	100
+
 struct adsp_data {
 	int crash_reason_smem;
 	const char *firmware_name;
@@ -36,6 +39,7 @@ struct adsp_data {
 	unsigned int minidump_id;
 	bool has_aggre2_clk;
 	bool auto_boot;
+	bool decrypt_shutdown;
 
 	char **proxy_pd_names;
 
@@ -65,6 +69,7 @@ struct qcom_adsp {
 	unsigned int minidump_id;
 	int crash_reason_smem;
 	bool has_aggre2_clk;
+	bool decrypt_shutdown;
 	const char *info_name;
 
 	struct completion start_done;
@@ -128,6 +133,20 @@ static void adsp_pds_disable(struct qcom_adsp *adsp, struct device **pds,
 	}
 }
 
+static int adsp_decrypt_shutdown(struct qcom_adsp *adsp)
+{
+	int retry_num = 50;
+	int ret = -EINVAL;
+
+	while (retry_num && ret) {
+		msleep(ADSP_DECRYPT_SHUTDOWN_DELAY_MS);
+		ret = qcom_scm_pas_shutdown(adsp->pas_id);
+		retry_num--;
+	}
+
+	return ret;
+}
+
 static int adsp_unprepare(struct rproc *rproc)
 {
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
@@ -249,6 +268,9 @@ static int adsp_stop(struct rproc *rproc)
 		dev_err(adsp->dev, "timed out on wait\n");
 
 	ret = qcom_scm_pas_shutdown(adsp->pas_id);
+	if (ret && adsp->decrypt_shutdown)
+		ret = adsp_decrypt_shutdown(adsp);
+
 	if (ret)
 		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
 
@@ -459,6 +481,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->pas_id = desc->pas_id;
 	adsp->has_aggre2_clk = desc->has_aggre2_clk;
 	adsp->info_name = desc->sysmon_name;
+	adsp->decrypt_shutdown = desc->decrypt_shutdown;
 	platform_set_drvdata(pdev, adsp);
 
 	device_wakeup_enable(adsp->dev);
@@ -533,6 +556,7 @@ static const struct adsp_data adsp_resource_init = {
 		.pas_id = 1,
 		.has_aggre2_clk = false,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.ssr_name = "lpass",
 		.sysmon_name = "adsp",
 		.ssctl_id = 0x14,
@@ -544,6 +568,7 @@ static const struct adsp_data sdm845_adsp_resource_init = {
 		.pas_id = 1,
 		.has_aggre2_clk = false,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.load_state = "adsp",
 		.ssr_name = "lpass",
 		.sysmon_name = "adsp",
@@ -556,6 +581,7 @@ static const struct adsp_data sm6350_adsp_resource = {
 	.pas_id = 1,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -573,6 +599,7 @@ static const struct adsp_data sm8150_adsp_resource = {
 		.pas_id = 1,
 		.has_aggre2_clk = false,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.proxy_pd_names = (char*[]){
 			"cx",
 			NULL
@@ -589,6 +616,7 @@ static const struct adsp_data sm8250_adsp_resource = {
 	.pas_id = 1,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -606,6 +634,7 @@ static const struct adsp_data sm8350_adsp_resource = {
 	.pas_id = 1,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -623,6 +652,7 @@ static const struct adsp_data msm8996_adsp_resource = {
 		.pas_id = 1,
 		.has_aggre2_clk = false,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.proxy_pd_names = (char*[]){
 			"cx",
 			NULL
@@ -638,6 +668,7 @@ static const struct adsp_data cdsp_resource_init = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
@@ -649,6 +680,7 @@ static const struct adsp_data sdm845_cdsp_resource_init = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.load_state = "cdsp",
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
@@ -661,6 +693,7 @@ static const struct adsp_data sm6350_cdsp_resource = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mx",
@@ -678,6 +711,7 @@ static const struct adsp_data sm8150_cdsp_resource = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		NULL
@@ -694,6 +728,7 @@ static const struct adsp_data sm8250_cdsp_resource = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		NULL
@@ -710,6 +745,7 @@ static const struct adsp_data sc8280xp_nsp0_resource = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"nsp",
 		NULL
@@ -725,6 +761,7 @@ static const struct adsp_data sc8280xp_nsp1_resource = {
 	.pas_id = 30,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"nsp",
 		NULL
@@ -740,6 +777,7 @@ static const struct adsp_data sm8350_cdsp_resource = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mxc",
@@ -758,6 +796,7 @@ static const struct adsp_data mpss_resource_init = {
 	.minidump_id = 3,
 	.has_aggre2_clk = false,
 	.auto_boot = false,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mss",
@@ -775,6 +814,7 @@ static const struct adsp_data sc8180x_mpss_resource = {
 	.pas_id = 4,
 	.has_aggre2_clk = false,
 	.auto_boot = false,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		NULL
@@ -791,6 +831,7 @@ static const struct adsp_data slpi_resource_init = {
 		.pas_id = 12,
 		.has_aggre2_clk = true,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.proxy_pd_names = (char*[]){
 			"ssc_cx",
 			NULL
@@ -806,6 +847,7 @@ static const struct adsp_data sm8150_slpi_resource = {
 		.pas_id = 12,
 		.has_aggre2_clk = false,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.proxy_pd_names = (char*[]){
 			"lcx",
 			"lmx",
@@ -823,6 +865,7 @@ static const struct adsp_data sm8250_slpi_resource = {
 	.pas_id = 12,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -840,6 +883,7 @@ static const struct adsp_data sm8350_slpi_resource = {
 	.pas_id = 12,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -856,6 +900,7 @@ static const struct adsp_data wcss_resource_init = {
 	.firmware_name = "wcnss.mdt",
 	.pas_id = 6,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.ssr_name = "mpss",
 	.sysmon_name = "wcnss",
 	.ssctl_id = 0x12,
@@ -867,6 +912,7 @@ static const struct adsp_data sdx55_mpss_resource = {
 	.pas_id = 4,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mss",
@@ -877,6 +923,25 @@ static const struct adsp_data sdx55_mpss_resource = {
 	.ssctl_id = 0x22,
 };
 
+static const struct adsp_data sm8450_mpss_resource = {
+	.crash_reason_smem = 421,
+	.firmware_name = "modem.mdt",
+	.pas_id = 4,
+	.minidump_id = 3,
+	.has_aggre2_clk = false,
+	.auto_boot = false,
+	.decrypt_shutdown = true,
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
 static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,msm8226-adsp-pil", .data = &adsp_resource_init},
 	{ .compatible = "qcom,msm8974-adsp-pil", .data = &adsp_resource_init},
@@ -916,7 +981,7 @@ static const struct of_device_id adsp_of_match[] = {
 	{ .compatible = "qcom,sm8450-adsp-pas", .data = &sm8350_adsp_resource},
 	{ .compatible = "qcom,sm8450-cdsp-pas", .data = &sm8350_cdsp_resource},
 	{ .compatible = "qcom,sm8450-slpi-pas", .data = &sm8350_slpi_resource},
-	{ .compatible = "qcom,sm8450-mpss-pas", .data = &mpss_resource_init},
+	{ .compatible = "qcom,sm8450-mpss-pas", .data = &sm8450_mpss_resource},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, adsp_of_match);
-- 
2.7.4

