Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A040C530A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 10:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230512AbiEWHqv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 03:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231187AbiEWHqi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 03:46:38 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB37A1838D;
        Mon, 23 May 2022 00:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1653291995; x=1684827995;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=XrtKVN4g3MG5KTfFdlYJV1duSLDHAPq7glOyZCO8+9g=;
  b=VLXqr/b/ek7u5GP9FNiLovyPv3Zc3pok9AJRgHL/ZJrRA1xctofX4SNs
   O1TSmG5KHspslY8eRSAlamHtAHP5Hs0GbGX2hUXkv7SeCV7kZxPj9JmuG
   EujMteOlmVrHAqvxtvU5NHm5zFS+Ug4h6eYpbH3wVAZVB1yCeubbRZ7AS
   E=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 May 2022 00:01:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2022 00:01:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 00:01:23 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Mon, 23 May 2022 00:01:19 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>
CC:     <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <quic_psodagud@quicinc.com>, <eberman@codeaurora.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [RFC 2/3] firmware: qcom_scm: Add bw voting support to the SCM interface
Date:   Mon, 23 May 2022 12:30:57 +0530
Message-ID: <1653289258-17699-3-git-send-email-quic_sibis@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1653289258-17699-1-git-send-email-quic_sibis@quicinc.com>
References: <1653289258-17699-1-git-send-email-quic_sibis@quicinc.com>
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

The SMC calls required by remoteproc PAS driver on SM8450 SoCs get a
performance benefit from having a max vote to the crypto->ddr path.
Add support for bandwidth (bw) voting for those SMC calls when the
interconnects property is specified.

Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
---
 drivers/firmware/qcom_scm.c | 69 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
index 3163660fa8e2..1de22d411e51 100644
--- a/drivers/firmware/qcom_scm.c
+++ b/drivers/firmware/qcom_scm.c
@@ -7,6 +7,7 @@
 #include <linux/cpumask.h>
 #include <linux/export.h>
 #include <linux/dma-mapping.h>
+#include <linux/interconnect.h>
 #include <linux/module.h>
 #include <linux/types.h>
 #include <linux/qcom_scm.h>
@@ -31,8 +32,13 @@ struct qcom_scm {
 	struct clk *core_clk;
 	struct clk *iface_clk;
 	struct clk *bus_clk;
+	struct icc_path *path;
 	struct reset_controller_dev reset;
 
+	/* control access to the interconnect path */
+	struct mutex scm_bw_lock;
+	int scm_vote_count;
+
 	u64 dload_mode_addr;
 };
 
@@ -99,6 +105,42 @@ static void qcom_scm_clk_disable(void)
 	clk_disable_unprepare(__scm->bus_clk);
 }
 
+static int qcom_scm_bw_enable(void)
+{
+	int ret = 0;
+
+	if (!__scm->path)
+		return 0;
+
+	if (IS_ERR(__scm->path))
+		return -EINVAL;
+
+	mutex_lock(&__scm->scm_bw_lock);
+	if (!__scm->scm_vote_count) {
+		ret = icc_set_bw(__scm->path, 0, UINT_MAX);
+		if (ret < 0) {
+			dev_err(__scm->dev, "failed to set bandwidth request\n");
+			goto err_bw;
+		}
+	}
+	__scm->scm_vote_count++;
+err_bw:
+	mutex_unlock(&__scm->scm_bw_lock);
+
+	return ret;
+}
+
+static void qcom_scm_bw_disable(void)
+{
+	if (IS_ERR_OR_NULL(__scm->path))
+		return;
+
+	mutex_lock(&__scm->scm_bw_lock);
+	if (__scm->scm_vote_count-- == 1)
+		icc_set_bw(__scm->path, 0, 0);
+	mutex_unlock(&__scm->scm_bw_lock);
+}
+
 enum qcom_scm_convention qcom_scm_convention = SMC_CONVENTION_UNKNOWN;
 static DEFINE_SPINLOCK(scm_query_lock);
 
@@ -444,10 +486,15 @@ int qcom_scm_pas_init_image(u32 peripheral, const void *metadata, size_t size,
 	if (ret)
 		goto out;
 
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		return ret;
+
 	desc.args[1] = mdata_phys;
 
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 
+	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
 
 out:
@@ -507,7 +554,12 @@ int qcom_scm_pas_mem_setup(u32 peripheral, phys_addr_t addr, phys_addr_t size)
 	if (ret)
 		return ret;
 
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		return ret;
+
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];
@@ -537,7 +589,12 @@ int qcom_scm_pas_auth_and_reset(u32 peripheral)
 	if (ret)
 		return ret;
 
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		return ret;
+
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
+	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];
@@ -566,8 +623,13 @@ int qcom_scm_pas_shutdown(u32 peripheral)
 	if (ret)
 		return ret;
 
+	ret = qcom_scm_bw_enable();
+	if (ret)
+		return ret;
+
 	ret = qcom_scm_call(__scm->dev, &desc, &res);
 
+	qcom_scm_bw_disable();
 	qcom_scm_clk_disable();
 
 	return ret ? : res.result[0];
@@ -1277,8 +1339,15 @@ static int qcom_scm_probe(struct platform_device *pdev)
 	if (ret < 0)
 		return ret;
 
+	mutex_init(&scm->scm_bw_lock);
+
 	clks = (unsigned long)of_device_get_match_data(&pdev->dev);
 
+	scm->path = devm_of_icc_get(&pdev->dev, NULL);
+	if (IS_ERR(scm->path))
+		return dev_err_probe(&pdev->dev, PTR_ERR(scm->path),
+				     "failed to acquire interconnect path\n");
+
 	scm->core_clk = devm_clk_get(&pdev->dev, "core");
 	if (IS_ERR(scm->core_clk)) {
 		if (PTR_ERR(scm->core_clk) == -EPROBE_DEFER)
-- 
2.7.4

