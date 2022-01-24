Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3A9149780C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 05:23:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241327AbiAXEXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 23:23:42 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:56030 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241316AbiAXEXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 23:23:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1642998219; x=1674534219;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=dZzloF4oT5jbyzBQY8Mdf2h+6q83pUadE06GE3Me2tI=;
  b=ETnxNKJ+ZkZSK3YKGYWFrubYGpy0lg0zkANcksreZx1VlB5ScuKUx/yV
   /AX7cqyQcXXtKrjm9VjpGP1AYFnHsi1Zs6ZuCghPt2B/VdKPm+qQMyO9c
   EdZz3Api9g3ZL3WyUX/ZjxxcNJ2h/RAobQu29jSZcBa2A4fAl7jZM0KYE
   0=;
Received: from unknown (HELO ironmsg03-sd.qualcomm.com) ([10.53.140.143])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 23 Jan 2022 20:23:39 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg03-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2022 20:23:36 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 20:23:36 -0800
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Sun, 23 Jan 2022 20:23:26 -0800
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
Subject: [PATCH V4 0/4] thermal: qcom: Add support for PMIC5 Gen2 ADC_TM
Date:   Mon, 24 Jan 2022 09:53:10 +0530
Message-ID: <1642998194-12899-1-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

