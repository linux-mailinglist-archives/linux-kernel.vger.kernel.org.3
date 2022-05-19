Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86AC552DA91
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 18:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242168AbiESQrf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 12:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234294AbiESQrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 12:47:33 -0400
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5215B88D;
        Thu, 19 May 2022 09:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1652978852; x=1684514852;
  h=from:to:cc:subject:date:message-id:mime-version;
  bh=LXflJd7Y5VHLQK0MN/gT14zJ94O0px+SUp5tuELlX4Y=;
  b=a7lQh8ruUi5PU7MLLuzE8E8FFtoY75MCcPLv2Gp6uUa6Ek4vGcJKTvvP
   IfYuvwYjpXX+cVaeHUi4bZWZzgpMRppABKqR25XarR/ny2dSnGOP8prHq
   NBDmLy63vDAQyppmdzsW+pYf/iNSkuX3UF0O5wyyTcW8Ad6gYZuPxaCqg
   w=;
Received: from unknown (HELO ironmsg01-sd.qualcomm.com) ([10.53.140.141])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 19 May 2022 09:47:32 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg01-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2022 09:47:31 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 09:47:31 -0700
Received: from blr-ubuntu-87.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Thu, 19 May 2022 09:47:27 -0700
From:   Sibi Sankar <quic_sibis@quicinc.com>
To:     <bjorn.andersson@linaro.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <ohad@wizery.com>, <agross@kernel.org>,
        <mathieu.poirier@linaro.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <mka@chromium.org>, Sibi Sankar <quic_sibis@quicinc.com>
Subject: [PATCH v4 0/3] Add support for proxy interconnect bandwidth votes
Date:   Thu, 19 May 2022 22:17:02 +0530
Message-ID: <1652978825-5304-1-git-send-email-quic_sibis@quicinc.com>
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

 Depends on:
 https://lore.kernel.org/lkml/20220517070113.18023-1-krzysztof.kozlowski@linaro.org/

Sibi Sankar (3):
  arm64: dts: qcom: sc7280: Add proxy interconnect requirements for
    modem
  dt-bindings: remoteproc: qcom: Convert SC7280 MSS bindings to YAML
  dt-bindings: remoteproc: qcom: Convert SC7180 MSS bindings to YAML

 .../devicetree/bindings/remoteproc/qcom,q6v5.txt   |  47 +---
 .../bindings/remoteproc/qcom,sc7180-mss-pil.yaml   | 236 +++++++++++++++++++
 .../bindings/remoteproc/qcom,sc7280-mss-pil.yaml   | 250 +++++++++++++++++++++
 arch/arm64/boot/dts/qcom/sc7280-chrome-common.dtsi |   1 +
 4 files changed, 489 insertions(+), 45 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7180-mss-pil.yaml
 create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,sc7280-mss-pil.yaml

-- 
2.7.4

