Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1941656695C
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 13:32:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbiGELcV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 07:32:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbiGELcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 07:32:18 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 866BC16584;
        Tue,  5 Jul 2022 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1657020737; x=1688556737;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=DgpD0swGMPgGP3c6S88/tD4BnYuimi0ZGxDZ8vFIhHA=;
  b=AgNiHcTKD5PRRAtnuTt1qeKQd4JsB5aIj75ppjp2sTBKI4jA9M2lI8pO
   M7Z57YNbCu+crtNvatrPsopSpDpHNJkLjYaAm56Z2Fjjtnya2t1Z2MXXo
   B+dZot2q188XRuIXgxe4/h27cY8/p5BPmvIXOqNCkbRAYB89FHzvIAXB9
   I=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 05 Jul 2022 04:32:17 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2022 04:32:17 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 04:32:16 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Tue, 5 Jul 2022 04:32:12 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <swboyd@chromium.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <mathieu.poirier@linaro.org>, <agross@kernel.org>,
        <konrad.dybcio@somainline.org>, <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <mka@chromium.org>,
        Sibi Sankar <quic_sibis@quicinc.com>
Subject: [V5 0/2] Add support for proxy interconnect bandwidth votes
Date:   Tue, 5 Jul 2022 17:01:59 +0530
Message-ID: <1657020721-24939-1-git-send-email-quic_sibis@quicinc.com>
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

Add proxy interconnect bandwidth votes during modem bootup on SC7280 SoCs.

V5:
 * Improve phandle-array schemas [Stephen/Rob/Krzysztof]
 * Add more details to the firmware-name/memory region string array [Stephen/Rob]
 * Drop 'items' from label [Rob]
 * Drop the patch 1 since Bjorn picked it up

V4:
 * Remove older bindings [Matthias/Krzysztof]
 * Convert sc7180/sc7280 to yaml and leave the rest to Sireesh's series
 * Rebased on v2 of Krzysztof's bindings cleanups
 * Misc. Fixes [Krzysztof]

V3:
 * Re-ordered clock list, fixed pdc_sync typo [Rob/Matthias]

V2:
 * Dropped patch 3 from version 1 [Sub with Bjorn's patch]
 * Add YAML support [Krzysztof]
 * Drop interconnect names [Bjorn]

Depends on Krzysztof's remoteproc cleanups and improvements:
https://patchwork.kernel.org/project/linux-arm-msm/cover/20220517070113.18023-1-krzysztof.kozlowski@linaro.org/

Sibi Sankar (2):
  dt-bindings: remoteproc: qcom: Convert SC7280 MSS bindings to YAML
  dt-bindings: remoteproc: qcom: Convert SC7180 MSS bindings to YAML

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  47 +---
 .../bindings/remoteproc/qcom,sc7180-mss-pil.yaml   | 245 +++++++++++++++++++
 .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 266 +++++++++++++++++++++
 3 files changed, 513 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml

-- 
2.7.4

