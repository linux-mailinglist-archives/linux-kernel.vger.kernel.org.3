Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4D1532AF8
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 15:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237619AbiEXNON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 09:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237580AbiEXNOG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 09:14:06 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D90B93452;
        Tue, 24 May 2022 06:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653398044; x=1684934044;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=cl4H40MXCz7CNbZqdvHzzNX0nAf4IZjii0p2pCXC9sU=;
  b=QBWeVr8sVz9UVl32aWTu1BoCiTOEuUbJ0H0AJ6XWBkZI7UhhvxW6fVfu
   0TEk6w4tJzqc7k8a2SjDnMUODd0+ENljHop++CQvsywgtMEqPketV37R7
   9huG54jV8TslKHq3l5RCIKXdkpfZ0WS5AcJ0jpsx7E2xpOk3nYthbZXOI
   M=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 24 May 2022 06:14:04 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 May 2022 06:14:04 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:14:04 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 24 May 2022 06:14:01 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Sibi Sankar" <quic_sibis@quicinc.com>
Subject: [PATCH 2/7] remoteproc: qcom: pas: Add decrypt shutdown support for modem
Date:   Tue, 24 May 2022 18:43:32 +0530
Message-ID: <1653398017-28426-3-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653398017-28426-1-git-send-email-quic_sibis@quicinc.com>
References: <1653398017-28426-1-git-send-email-quic_sibis@quicinc.com>
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

The initial shutdown request to modem on SM8450 SoCs would start the
decryption process and will keep returning errors until the modem shutdown
is complete. Fix this by retrying shutdowns in fixed intervals.

Err Logs on modem shutdown:
qcom_q6v5_pas 4080000.remoteproc: failed to shutdown: -22
remoteproc remoteproc3: can't stop rproc: -22

Fixes: 5cef9b48458d ("remoteproc: qcom: pas: Add SM8450 remoteproc support")
Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/remoteproc/qcom_q6v5_pas.c | 49 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 8ce68d0bb1bc..7313fc0a3c01 100644
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
@@ -37,6 +40,7 @@ struct adsp_data {
 	bool uses_elf64;
 	bool has_aggre2_clk;
 	bool auto_boot;
+	bool decrypt_shutdown;
 
 	char **proxy_pd_names;
 
@@ -66,6 +70,7 @@ struct qcom_adsp {
 	unsigned int minidump_id;
 	int crash_reason_smem;
 	bool has_aggre2_clk;
+	bool decrypt_shutdown;
 	const char *info_name;
 
 	struct completion start_done;
@@ -129,6 +134,20 @@ static void adsp_pds_disable(struct qcom_adsp *adsp, struct device **pds,
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
@@ -250,6 +269,9 @@ static int adsp_stop(struct rproc *rproc)
 		dev_err(adsp->dev, "timed out on wait\n");
 
 	ret = qcom_scm_pas_shutdown(adsp->pas_id);
+	if (ret && adsp->decrypt_shutdown)
+		ret = adsp_decrypt_shutdown(adsp);
+
 	if (ret)
 		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
 
@@ -464,6 +486,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->pas_id = desc->pas_id;
 	adsp->has_aggre2_clk = desc->has_aggre2_clk;
 	adsp->info_name = desc->sysmon_name;
+	adsp->decrypt_shutdown = desc->decrypt_shutdown;
 	platform_set_drvdata(pdev, adsp);
 
 	device_wakeup_enable(adsp->dev);
@@ -538,6 +561,7 @@ static const struct adsp_data adsp_resource_init = {
 		.pas_id = 1,
 		.has_aggre2_clk = false,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.ssr_name = "lpass",
 		.sysmon_name = "adsp",
 		.ssctl_id = 0x14,
@@ -549,6 +573,7 @@ static const struct adsp_data sdm845_adsp_resource_init = {
 		.pas_id = 1,
 		.has_aggre2_clk = false,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.load_state = "adsp",
 		.ssr_name = "lpass",
 		.sysmon_name = "adsp",
@@ -561,6 +586,7 @@ static const struct adsp_data sm6350_adsp_resource = {
 	.pas_id = 1,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -578,6 +604,7 @@ static const struct adsp_data sm8150_adsp_resource = {
 		.pas_id = 1,
 		.has_aggre2_clk = false,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.proxy_pd_names = (char*[]){
 			"cx",
 			NULL
@@ -594,6 +621,7 @@ static const struct adsp_data sm8250_adsp_resource = {
 	.pas_id = 1,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -611,6 +639,7 @@ static const struct adsp_data sm8350_adsp_resource = {
 	.pas_id = 1,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -629,6 +658,7 @@ static const struct adsp_data sm8450_adsp_resource = {
 	.uses_elf64 = true,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -646,6 +676,7 @@ static const struct adsp_data msm8996_adsp_resource = {
 		.pas_id = 1,
 		.has_aggre2_clk = false,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.proxy_pd_names = (char*[]){
 			"cx",
 			NULL
@@ -661,6 +692,7 @@ static const struct adsp_data cdsp_resource_init = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
 	.ssctl_id = 0x17,
@@ -672,6 +704,7 @@ static const struct adsp_data sdm845_cdsp_resource_init = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.load_state = "cdsp",
 	.ssr_name = "cdsp",
 	.sysmon_name = "cdsp",
@@ -684,6 +717,7 @@ static const struct adsp_data sm6350_cdsp_resource = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mx",
@@ -701,6 +735,7 @@ static const struct adsp_data sm8150_cdsp_resource = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		NULL
@@ -717,6 +752,7 @@ static const struct adsp_data sm8250_cdsp_resource = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		NULL
@@ -733,6 +769,7 @@ static const struct adsp_data sc8280xp_nsp0_resource = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"nsp",
 		NULL
@@ -748,6 +785,7 @@ static const struct adsp_data sc8280xp_nsp1_resource = {
 	.pas_id = 30,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"nsp",
 		NULL
@@ -763,6 +801,7 @@ static const struct adsp_data sm8350_cdsp_resource = {
 	.pas_id = 18,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mxc",
@@ -781,6 +820,7 @@ static const struct adsp_data sm8450_cdsp_resource = {
 	.uses_elf64 = true,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mxc",
@@ -799,6 +839,7 @@ static const struct adsp_data mpss_resource_init = {
 	.minidump_id = 3,
 	.has_aggre2_clk = false,
 	.auto_boot = false,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mss",
@@ -816,6 +857,7 @@ static const struct adsp_data sc8180x_mpss_resource = {
 	.pas_id = 4,
 	.has_aggre2_clk = false,
 	.auto_boot = false,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		NULL
@@ -834,6 +876,7 @@ static const struct adsp_data sm8450_mpss_resource = {
 	.uses_elf64 = true,
 	.has_aggre2_clk = false,
 	.auto_boot = false,
+	.decrypt_shutdown = true,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mss",
@@ -851,6 +894,7 @@ static const struct adsp_data slpi_resource_init = {
 		.pas_id = 12,
 		.has_aggre2_clk = true,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.proxy_pd_names = (char*[]){
 			"ssc_cx",
 			NULL
@@ -866,6 +910,7 @@ static const struct adsp_data sm8150_slpi_resource = {
 		.pas_id = 12,
 		.has_aggre2_clk = false,
 		.auto_boot = true,
+		.decrypt_shutdown = false,
 		.proxy_pd_names = (char*[]){
 			"lcx",
 			"lmx",
@@ -883,6 +928,7 @@ static const struct adsp_data sm8250_slpi_resource = {
 	.pas_id = 12,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -900,6 +946,7 @@ static const struct adsp_data sm8350_slpi_resource = {
 	.pas_id = 12,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"lcx",
 		"lmx",
@@ -916,6 +963,7 @@ static const struct adsp_data wcss_resource_init = {
 	.firmware_name = "wcnss.mdt",
 	.pas_id = 6,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.ssr_name = "mpss",
 	.sysmon_name = "wcnss",
 	.ssctl_id = 0x12,
@@ -927,6 +975,7 @@ static const struct adsp_data sdx55_mpss_resource = {
 	.pas_id = 4,
 	.has_aggre2_clk = false,
 	.auto_boot = true,
+	.decrypt_shutdown = false,
 	.proxy_pd_names = (char*[]){
 		"cx",
 		"mss",
-- 
2.7.4

