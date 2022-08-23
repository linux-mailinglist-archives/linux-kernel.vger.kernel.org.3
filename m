Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE42259E966
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 19:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiHWRYh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 13:24:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243776AbiHWRVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 13:21:46 -0400
Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1D3AC256;
        Tue, 23 Aug 2022 07:57:40 -0700 (PDT)
Received: by mail-oo1-f50.google.com with SMTP id a1-20020a4ab101000000b0044acf001f83so2467329ooo.10;
        Tue, 23 Aug 2022 07:57:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=ooqlkbw3TE2NJhyebQ5cGozeHzUv+AJJEgZF4B67gIY=;
        b=TNOXgnEyh2aDs7Wv8jIyawSY1lITrOYbPAjxbGVdcmLzs/acYuV3HJ1XQsic6Fcl7a
         wf9i1aHddoJNqdAe9KqILI1cF724fyY2dvDzXGEfQKnZp/XswGNe3VRs8ZIsHj7UHQU1
         6OA+/b1DrvDJhBHjEzsmzDlg9vFehbAyV391QbFkU1xuUQE+4nEFpN1/kqWFyvbZSSpF
         d+6PmbmznA1GG/+Iu9DXAgj6F6CGCq80emXxtpyqd0YnEBO+HZ1RL7N/hW3ZlmOkX9eH
         d5TB5erjJUlwlo9wV4NntTRyDGNjEec+mxHr7KhJRcoovd5geiUQWboPB8pk1hFaFrEv
         9GsQ==
X-Gm-Message-State: ACgBeo0kJ8vs4V5JKbQbio0nO3ZENmXdOeJ+j+oU06zJx0bHJnFn20te
        b/p32inUeAy4YyRs4rQICA==
X-Google-Smtp-Source: AA6agR5+a7sOjSPzaSgig28307qEt+b/EO4MrhzoXJrDqx7W1/FQV0jwLw+HKQCyDk3RmgEqKpT4Hw==
X-Received: by 2002:a4a:e411:0:b0:442:c893:86b7 with SMTP id t17-20020a4ae411000000b00442c89386b7mr8088683oov.22.1661266659387;
        Tue, 23 Aug 2022 07:57:39 -0700 (PDT)
Received: from xps15.. (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.googlemail.com with ESMTPSA id t1-20020a056870600100b0011c65559b04sm3840637oaa.34.2022.08.23.07.57.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 07:57:38 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Amelie Delaunay <amelie.delaunay@foss.st.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     Ray Jui <ray.jui@broadcom.com>,
        Scott Branden <scott.branden@broadcom.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH] dt-bindings: phy: Add missing (unevaluated|additional)Properties on child nodes
Date:   Tue, 23 Aug 2022 09:56:45 -0500
Message-Id: <20220823145649.3118479-14-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In order to ensure only documented properties are present, node schemas
must have unevaluatedProperties or additionalProperties set to false
(typically).

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml          | 1 +
 Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml   | 2 ++
 .../devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml          | 2 ++
 Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml    | 3 +++
 4 files changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml b/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml
index 045699c65779..808e90b2465d 100644
--- a/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/brcm,cygnus-pcie-phy.yaml
@@ -32,6 +32,7 @@ properties:
 patternProperties:
   "^pcie-phy@[0-9]+$":
     type: object
+    additionalProperties: false
     description: >
       PCIe PHY child nodes
 
diff --git a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
index dc287d428e49..801993813b18 100644
--- a/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
+++ b/Documentation/devicetree/bindings/phy/phy-stm32-usbphyc.yaml
@@ -77,6 +77,8 @@ patternProperties:
       connector:
         type: object
         $ref: /schemas/connector/usb-connector.yaml
+        unevaluatedProperties: false
+
         properties:
           vbus-supply: true
 
diff --git a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
index b078009ed509..563e85c48c6a 100644
--- a/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,qmp-usb3-dp-phy.yaml
@@ -81,6 +81,7 @@ properties:
 patternProperties:
   "^usb3-phy@[0-9a-f]+$":
     type: object
+    additionalProperties: false
     description:
       The USB3 PHY.
 
@@ -121,6 +122,7 @@ patternProperties:
 
   "^dp-phy@[0-9a-f]+$":
     type: object
+    additionalProperties: false
     description:
       The DP PHY.
 
diff --git a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
index dcd63908aeae..7c7c3e3e6346 100644
--- a/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,phy-j721e-wiz.yaml
@@ -79,6 +79,7 @@ properties:
 
   refclk-dig:
     type: object
+    additionalProperties: false
     description: |
       WIZ node should have subnode for refclk_dig to select the reference
       clock source for the reference clock used in the PHY and PMA digital
@@ -108,6 +109,7 @@ properties:
 patternProperties:
   "^pll[0|1]-refclk$":
     type: object
+    additionalProperties: false
     description: |
       WIZ node should have subnodes for each of the PLLs present in
       the SERDES.
@@ -133,6 +135,7 @@ patternProperties:
 
   "^cmn-refclk1?-dig-div$":
     type: object
+    additionalProperties: false
     description:
       WIZ node should have subnodes for each of the PMA common refclock
       provided by the SERDES.
-- 
2.34.1

