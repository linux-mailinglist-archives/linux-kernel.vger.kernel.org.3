Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AECB4B3A28
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 09:33:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiBMIdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 03:33:51 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiBMIdu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 03:33:50 -0500
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5137A5E77A;
        Sun, 13 Feb 2022 00:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644741225; x=1676277225;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=JURP9AmcoLc1fhFWvK5ML0fsoJH7goTwLeATaM2KKRI=;
  b=yrvwxFISmglv7i+bAGfVWvVNt2q58xsdIlx/iwv7LR5t2jhjC3X2uHCp
   gSZ6YYeYKWIytkmG7GN4w3N0bDu4IJ6Mun2IxBK5JFbXSLD3PHMUjtm7g
   kZBivaKSXHEytU1QfCPyFXjhVr0dFxlJdP0kgh1OJkv7gSBhhgFJ/eOs0
   E=;
Received: from unknown (HELO ironmsg02-sd.qualcomm.com) ([10.53.140.142])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 13 Feb 2022 00:33:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg02-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Feb 2022 00:33:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Sun, 13 Feb 2022 00:33:43 -0800
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 13 Feb 2022 00:33:36 -0800
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <knaack.h@gmx.de>, <lars@metafoo.de>, <pmeerw@pmeerw.net>,
        <manivannan.sadhasivam@linaro.org>, <linus.walleij@linaro.org>,
        <quic_kgunda@quicinc.com>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>, <amitk@kernel.org>
CC:     <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [PATCH V5 0/4] thermal: qcom: Add support for PMIC5 Gen2 ADC_TM
Date:   Sun, 13 Feb 2022 14:03:07 +0530
Message-ID: <1644741191-12039-1-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

Changes in v5:
Fixed some compilation errors in patch 4.

Changes in v4:
Addressed comments given by Jonathan (for using put_unaligned_le16)
and by Dmitry (for using separate init function and correcting args_count)
for qcom-spmi-adc-tm5.c in patch 4.
Added init function in patch 3.

Changes in v3:
Addressed comments given by Jonathan for qcom-spmi-adc-tm5.yaml.
Addressed comments given by Dmitry and Jonathan for qcom-spmi-adc-tm5.c.
Split patch for qcom-spmi-adc-tm5.c into two parts, one to refactor
code to support multiple device generations and the second to add
actual Gen2 ADC_TM changes.

Changes in v2:
Split IIO file changes into separate patch.
Addressed comments given by Dmitry for qcom-spmi-adc-tm5.c.

Changes in v1:
PMIC5 Gen2 ADC_TM is supported on PMIC7 chips and is a close
counterpart of PMIC7 ADC. It has the same functionality as
PMIC5 ADC_TM, to support generating interrupts on ADC value
crossing upper or lower thresholds for monitored channels.

Jishnu Prakash (4):
  dt-bindings: thermal: qcom: add PMIC5 Gen2 ADC_TM bindings
  iio: adc: qcom-vadc-common: add reverse scaling for PMIC5 Gen2 ADC_TM
  thermal: qcom: Add support for multiple generations of devices
  thermal: qcom: add support for PMIC5 Gen2 ADCTM

 .../bindings/thermal/qcom-spmi-adc-tm5.yaml        | 110 ++++-
 drivers/iio/adc/qcom-vadc-common.c                 |  11 +
 drivers/thermal/qcom/qcom-spmi-adc-tm5.c           | 486 +++++++++++++++++++--
 include/linux/iio/adc/qcom-vadc-common.h           |   2 +
 4 files changed, 569 insertions(+), 40 deletions(-)

-- 
2.7.4

