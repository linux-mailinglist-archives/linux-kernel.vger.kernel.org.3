Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57CAB4F09E7
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:18:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358874AbiDCNUh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:20:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358868AbiDCNUU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:20:20 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC29A286E1;
        Sun,  3 Apr 2022 06:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648991905; x=1680527905;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=02jKCSFUrWcNdgliBGzyvoi3mQqWkLT055iJwDV45LQ=;
  b=cOACwBukWzlAGu5YrnVOdE4H2Ky/SWHGQcHpQcVEbfy9Og5PLFNPVFW3
   qBprWr9pfO4bRtuyO/LlumzdGe31mrJplyGnKavwoLTXV1Lc+ng4QVkSd
   FEIGKejPWLLfAkru/o6MYjq1JXNSK3yZBLQEW9aUgstnyd4uxAnedGMQN
   0=;
Received: from ironmsg08-lv.qualcomm.com ([10.47.202.152])
  by alexa-out.qualcomm.com with ESMTP; 03 Apr 2022 06:18:24 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg08-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 06:18:23 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 3 Apr 2022 06:18:23 -0700
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 3 Apr 2022 06:18:18 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>,
        <amitk@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
        Jishnu Prakash <quic_jprakash@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-msm-owner@vger.kernel.org>, <linux-pm@vger.kernel.org>
Subject: [RESEND PATCH V5 2/4] iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
Date:   Sun, 3 Apr 2022 18:47:47 +0530
Message-ID: <1648991869-20899-3-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648991869-20899-1-git-send-email-quic_jprakash@quicinc.com>
References: <1648991869-20899-1-git-send-email-quic_jprakash@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
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

Add reverse scaling function for PMIC5 Gen2 ADC_TM, to convert
temperature to raw ADC code, for setting thresholds for
thermistor channels.

Signed-off-by: Jishnu Prakash <quic_jprakash@quicinc.com>
Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
---
 drivers/iio/adc/qcom-vadc-common.c       | 11 +++++++++++
 include/linux/iio/adc/qcom-vadc-common.h |  2 ++
 2 files changed, 13 insertions(+)

diff --git a/drivers/iio/adc/qcom-vadc-common.c b/drivers/iio/adc/qcom-vadc-common.c
index 1472389..194d7c3 100644
--- a/drivers/iio/adc/qcom-vadc-common.c
+++ b/drivers/iio/adc/qcom-vadc-common.c
@@ -677,6 +677,17 @@ u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
 }
 EXPORT_SYMBOL(qcom_adc_tm5_temp_volt_scale);
 
+u16 qcom_adc_tm5_gen2_temp_res_scale(int temp)
+{
+	int64_t resistance;
+
+	resistance = qcom_vadc_map_temp_voltage(adcmap7_100k,
+		ARRAY_SIZE(adcmap7_100k), temp);
+
+	return div64_s64(resistance * RATIO_MAX_ADC7, resistance + R_PU_100K);
+}
+EXPORT_SYMBOL(qcom_adc_tm5_gen2_temp_res_scale);
+
 int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 		    unsigned int prescale_ratio,
 		    const struct adc5_data *data,
diff --git a/include/linux/iio/adc/qcom-vadc-common.h b/include/linux/iio/adc/qcom-vadc-common.h
index 33f60f4..598a5d2 100644
--- a/include/linux/iio/adc/qcom-vadc-common.h
+++ b/include/linux/iio/adc/qcom-vadc-common.h
@@ -161,6 +161,8 @@ int qcom_adc5_hw_scale(enum vadc_scale_fn_type scaletype,
 u16 qcom_adc_tm5_temp_volt_scale(unsigned int prescale_ratio,
 				 u32 full_scale_code_volt, int temp);
 
+u16 qcom_adc_tm5_gen2_temp_res_scale(int temp);
+
 int qcom_adc5_prescaling_from_dt(u32 num, u32 den);
 
 int qcom_adc5_hw_settle_time_from_dt(u32 value, const unsigned int *hw_settle);
-- 
2.7.4

