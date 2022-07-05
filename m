Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A616D566C95
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236120AbiGEMQp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235280AbiGEMIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:08:49 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D11E0CF7;
        Tue,  5 Jul 2022 05:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657022922; x=1688558922;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=CDyatd/alwRxhQKIcCzS9dAT6SbHX1ERg8cwqTzIgys=;
  b=U65DyMa9iOTEWwlQf7fH7zHF5MYATUOJWytoVUY6TXUcv1BzlTJfWEbn
   /KsnIjbsyRvQmAqsfzcOtvGZU2o3e9Ie/IK/Kx1q7qKbxPDVRyriBFH0A
   H/dcpJ0Id72FI0poSX8q0yArhpI7a3ld1YMHbw2ANOqb03/cqYocQN/QK
   c=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 05 Jul 2022 05:08:42 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 05:08:42 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 05:08:42 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 05:08:39 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <mathieu.poirier@linaro.org>,
        <dmitry.baryshkov@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <konrad.dybcio@somainline.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [V3 1/7] remoteproc: qcom: pas: Add decrypt shutdown support for modem
Date:   Tue, 5 Jul 2022 17:38:14 +0530
Message-ID: <1657022900-2049-2-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
References: <1657022900-2049-1-git-send-email-quic_sibis@quicinc.com>
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

v3:
 * Fixup misc. suggestions and rename to adsp_shutdown_poll_decrypt() [Bjorn]

 drivers/remoteproc/qcom_q6v5_pas.c | 43 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 42 insertions(+), 1 deletion(-)

diff --git a/drivers/remoteproc/qcom_q6v5_pas.c b/drivers/remoteproc/qcom_q6v5_pas.c
index 6ae39c5653b1..297700f87fe8 100644
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
@@ -128,6 +133,19 @@ static void adsp_pds_disable(struct qcom_adsp *adsp, struct device **pds,
 	}
 }
 
+static int adsp_shutdown_poll_decrypt(struct qcom_adsp *adsp)
+{
+	unsigned int retry_num = 50;
+	int ret;
+
+	do {
+		msleep(ADSP_DECRYPT_SHUTDOWN_DELAY_MS);
+		ret = qcom_scm_pas_shutdown(adsp->pas_id);
+	} while (ret == -EINVAL && --retry_num);
+
+	return ret;
+}
+
 static int adsp_unprepare(struct rproc *rproc)
 {
 	struct qcom_adsp *adsp = (struct qcom_adsp *)rproc->priv;
@@ -249,6 +267,9 @@ static int adsp_stop(struct rproc *rproc)
 		dev_err(adsp->dev, "timed out on wait\n");
 
 	ret = qcom_scm_pas_shutdown(adsp->pas_id);
+	if (ret && adsp->decrypt_shutdown)
+		ret = adsp_shutdown_poll_decrypt(adsp);
+
 	if (ret)
 		dev_err(adsp->dev, "failed to shutdown: %d\n", ret);
 
@@ -459,6 +480,7 @@ static int adsp_probe(struct platform_device *pdev)
 	adsp->pas_id = desc->pas_id;
 	adsp->has_aggre2_clk = desc->has_aggre2_clk;
 	adsp->info_name = desc->sysmon_name;
+	adsp->decrypt_shutdown = desc->decrypt_shutdown;
 	platform_set_drvdata(pdev, adsp);
 
 	device_wakeup_enable(adsp->dev);
@@ -877,6 +899,25 @@ static const struct adsp_data sdx55_mpss_resource = {
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
@@ -916,7 +957,7 @@ static const struct of_device_id adsp_of_match[] = {
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

