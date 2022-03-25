Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893944E728C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:59:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353056AbiCYMAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357763AbiCYMAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:00:21 -0400
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1044F17E1E;
        Fri, 25 Mar 2022 04:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1648209528; x=1679745528;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=LMr1iiJKkuTv0bMFAJG3HlqVsflpA3e4LxxBxL0Ys8U=;
  b=p7OXsg+3ikovO2oSp2OSPOnDHLr/byhnRYdlIxdsjAVWqaU/S5hcPT+5
   JwtztH8fkJG+lLiH9yqbcJVw9QFV0eWFxLdrie93uW9UJUarbmUNUm5A/
   e2AxY7jOifsTy2QpDUiEf1I77AADzBfqXiuw4t5TK0MnyJu1gcgQJzsMQ
   c=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 25 Mar 2022 04:58:47 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2022 04:58:47 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:58:47 -0700
Received: from c-skakit-linux.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Fri, 25 Mar 2022 04:58:42 -0700
From:   Satya Priya <quic_c_skakit@quicinc.com>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Das Srinagesh <gurus@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <quic_collinsd@quicinc.com>, <quic_subbaram@quicinc.com>,
        <quic_jprakash@quicinc.com>,
        Satya Priya <quic_c_skakit@quicinc.com>
Subject: [PATCH V8 1/7] dt-bindings: mfd: pm8008: Modify the compatible as per driver
Date:   Fri, 25 Mar 2022 17:28:05 +0530
Message-ID: <1648209491-30165-2-git-send-email-quic_c_skakit@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
References: <1648209491-30165-1-git-send-email-quic_c_skakit@quicinc.com>
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

Modify the compatible string as per the pm8008 mfd driver.
Add reset-gpios property and make interrupts and interrupt-cells
as optional properties, they are not strictly required and may
cause yaml compilation errors when not added in the DT files.

Also, change the node name in example to match with the
pm8008_infra DT node.

Signed-off-by: Satya Priya <quic_c_skakit@quicinc.com>
---
Changes in V5:
 - Remove compatible for regulators node.
 - Move supply nodes of the regulators to chip level.

Changes in V6:
 - No changes.

Changes in V7:
 - Removed the intermediate regulators node and added ldos
   directly under mfd node.

Changes in V8:
 - Change the compatible as per driver, remove interrupts from required
   properties, add reset-gpios and move regulators to separate binding.

 Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
index ec3138c..12431ea 100644
--- a/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
+++ b/Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml
@@ -16,7 +16,7 @@ description: |
 
 properties:
   compatible:
-    const: qcom,pm8008
+    const: qcom,pm8008-infra
 
   reg:
     description:
@@ -44,6 +44,10 @@ properties:
   "#size-cells":
     const: 0
 
+  reset-gpios:
+    description: |
+      Specifies the GPIO to be toggled to bring pm8008 chip out of reset.
+
 patternProperties:
   "^gpio@[0-9a-f]+$":
     type: object
@@ -88,10 +92,8 @@ patternProperties:
 required:
   - compatible
   - reg
-  - interrupts
   - "#address-cells"
   - "#size-cells"
-  - "#interrupt-cells"
 
 additionalProperties: false
 
@@ -99,11 +101,12 @@ examples:
   - |
     #include <dt-bindings/mfd/qcom-pm8008.h>
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
     qupv3_se13_i2c {
       #address-cells = <1>;
       #size-cells = <0>;
-      pm8008i@8 {
-        compatible = "qcom,pm8008";
+      pm8008_infra: pmic@8 {
+        compatible = "qcom,pm8008-infra";
         reg = <0x8>;
         #address-cells = <1>;
         #size-cells = <0>;
@@ -113,6 +116,8 @@ examples:
         interrupt-parent = <&tlmm>;
         interrupts = <32 IRQ_TYPE_EDGE_RISING>;
 
+        reset-gpios = <&pm8350c_gpios 4 GPIO_ACTIVE_HIGH>;
+
         pm8008_gpios: gpio@c000 {
           compatible = "qcom,pm8008-gpio", "qcom,spmi-gpio";
           reg = <0xc000>;
-- 
2.7.4

