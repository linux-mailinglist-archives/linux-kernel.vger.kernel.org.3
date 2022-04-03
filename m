Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E116C4F09E4
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358842AbiDCNUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:20:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233134AbiDCNUF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:20:05 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DBDC654E;
        Sun,  3 Apr 2022 06:18:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648991891; x=1680527891;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=x+JdWaJ97FFrpcglLaz6xn7zuWH0Ym2G8LL9FRXR2Qw=;
  b=KSGtw60XAoXybh7QWIFRUCgTZ/ctqKkT8E7Ts5386zrq2Tr71mT78IC3
   Ad6BGQhSzZCdDXX/wZO+24cHy8t3HT4SMGg6gIpkncg6D7jcLGAKpALsF
   a2JnDwH1deK04wGzS1yoc8jPyzcaB1QDKBCpnhm92apnl+Q7QjDmfdP93
   U=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 03 Apr 2022 06:18:10 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2022 06:18:09 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 3 Apr 2022 06:18:08 -0700
Received: from jprakash-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Sun, 3 Apr 2022 06:18:04 -0700
From:   Jishnu Prakash <quic_jprakash@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <devicetree@vger.kernel.org>, <mka@chromium.org>,
        <dmitry.baryshkov@linaro.org>, <robh+dt@kernel.org>,
        <linus.walleij@linaro.org>, <quic_aghayal@quicinc.com>,
        <daniel.lezcano@linaro.org>, <rui.zhang@intel.com>,
        <quic_subbaram@quicinc.com>, <jic23@kernel.org>, <amitk@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-msm-owner@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        Jishnu Prakash <quic_jprakash@quicinc.com>
Subject: [RESEND PATCH V5 0/4] thermal: qcom: Add support for PMIC5 Gen2 ADC_TM
Date:   Sun, 3 Apr 2022 18:47:45 +0530
Message-ID: <1648991869-20899-1-git-send-email-quic_jprakash@quicinc.com>
X-Mailer: git-send-email 2.7.4
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

Resending patch series to thermal tree.

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

