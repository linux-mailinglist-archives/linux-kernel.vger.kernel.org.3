Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 666AF565A05
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 17:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232937AbiGDPie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 11:38:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230210AbiGDPic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 11:38:32 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8999BDFFB
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 08:38:30 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s14so11539128ljs.3
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 08:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=36Fo3nrBjoWjM4WDiir3vWCMAuOSPdmTYxT8kWTupbw=;
        b=F5iw3ocErp6G/79qF+y+Zvj/c7eDlOClKuycFQdoDdMFRpxBoxDMeuOotY/K4i+AKN
         MvTavltYKEnlOI2huJvVql0zS37Zoc6CnTj4SKO1FakntuxPEjqpPNbpSAA67CYiq0lB
         mlb356NkiYwVzSN+Sy/AU/h7b33HThAcbkUkWBRQn2yVYWutEY0AfMtMIhOVZgEHPn7y
         j2/d8HTC+Ws1kytynSdw3mtkl0xyLgqFFoD18ARPnJg2+KKf/GR9JxdZlEvldZ/fTz6q
         LpW3QAtV21IXRK2VU+G7A4QpG+Ja04eWowRfi8ZCbgJiH7kjiWaJAcxGC+2X2789MWJF
         6Dxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=36Fo3nrBjoWjM4WDiir3vWCMAuOSPdmTYxT8kWTupbw=;
        b=fa5NCWdfelLBn4YtnlSpfANvQ7cM65aekTNByVwCuymWiMpDbnrdBXa1IIz6qADX39
         5TA2H1SWWrGFFg2FoChplJ7ijynCZTJBWfg6JSIYx92SvLEIBv0VHM97FVD4N/ts31fe
         lODJ9pNnwIVJjjy68Y+gnxz3x3uF9fLk1dGL4W24Uo9eDlQHwJ8cRN5ul7giwdPm1vaH
         PTxWAJ5dtvCsRd12ILgBmZMFV5ShBw8mB/ieV4rWd1BLssx1gmkZINYhtgX7EvK0h1ad
         Yg8YwoArqBtL68SlCQLE3ucl+3aj9BtDzU8x2bWYTMgOILjnX1g/Uh+fkidNDndKdpQ/
         kJ/w==
X-Gm-Message-State: AJIora9xCmTNMzYOuRgWsPs0mdY+Q9CCjirGD/HeucPBpnNxxxd5fyJ8
        qZfE3QpN2/6T7bPuAXV9pjUc9g==
X-Google-Smtp-Source: AGRyM1sDU5ztSDUAsix5exO9MzhM8q0VzoTIvbDo4k9dJG2fJlMpytyCEXpqIjsC7qZRlcN8VUjoYg==
X-Received: by 2002:a2e:8e7c:0:b0:25b:fae1:8a24 with SMTP id t28-20020a2e8e7c000000b0025bfae18a24mr12824152ljk.520.1656949108867;
        Mon, 04 Jul 2022 08:38:28 -0700 (PDT)
Received: from krzk-bin.home ([84.20.121.239])
        by smtp.gmail.com with ESMTPSA id d10-20020a0565123d0a00b0048110fd06c4sm4214010lfv.53.2022.07.04.08.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 08:38:28 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] ASoC: dt-bindings: qcom,sdm845: convert to dtschema
Date:   Mon,  4 Jul 2022 17:38:24 +0200
Message-Id: <20220704153824.23226-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the Samsung SDM845 sound card bindings to DT schema.

Changes during conversion: do not require 'codec' under dai-links - not
present in all nodes of examples and DTS; not required by the driver.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/sound/qcom,sdm845.txt |  91 ----------
 .../bindings/sound/qcom,sdm845.yaml           | 166 ++++++++++++++++++
 2 files changed, 166 insertions(+), 91 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.txt
 create mode 100644 Documentation/devicetree/bindings/sound/qcom,sdm845.yaml

diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt b/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
deleted file mode 100644
index de4c604641da..000000000000
--- a/Documentation/devicetree/bindings/sound/qcom,sdm845.txt
+++ /dev/null
@@ -1,91 +0,0 @@
-* Qualcomm Technologies Inc. SDM845 ASoC sound card driver
-
-This binding describes the SDM845 sound card, which uses qdsp for audio.
-
-- compatible:
-	Usage: required
-	Value type: <stringlist>
-	Definition: must be one of this
-			"qcom,sdm845-sndcard"
-			"qcom,db845c-sndcard"
-			"lenovo,yoga-c630-sndcard"
-
-- audio-routing:
-	Usage: Optional
-	Value type: <stringlist>
-	Definition:  A list of the connections between audio components.
-		  Each entry is a pair of strings, the first being the
-		  connection's sink, the second being the connection's
-		  source. Valid names could be power supplies, MicBias
-		  of codec and the jacks on the board.
-
-- model:
-	Usage: required
-	Value type: <stringlist>
-	Definition: The user-visible name of this sound card.
-
-- aux-devs
-	Usage: optional
-	Value type: <array of phandles>
-	Definition: A list of phandles for auxiliary devices (e.g. analog
-		    amplifiers) that do not appear directly within the DAI
-		    links. Should be connected to another audio component
-		    using "audio-routing".
-
-= dailinks
-Each subnode of sndcard represents either a dailink, and subnodes of each
-dailinks would be cpu/codec/platform dais.
-
-- link-name:
-	Usage: required
-	Value type: <string>
-	Definition: User friendly name for dai link
-
-= CPU, PLATFORM, CODEC dais subnodes
-- cpu:
-	Usage: required
-	Value type: <subnode>
-	Definition: cpu dai sub-node
-
-- codec:
-	Usage: required
-	Value type: <subnode>
-	Definition: codec dai sub-node
-
-- platform:
-	Usage: Optional
-	Value type: <subnode>
-	Definition: platform dai sub-node
-
-- sound-dai:
-	Usage: required
-	Value type: <phandle>
-	Definition: dai phandle/s and port of CPU/CODEC/PLATFORM node.
-
-Example:
-
-audio {
-	compatible = "qcom,sdm845-sndcard";
-	model = "sdm845-snd-card";
-	pinctrl-names = "default", "sleep";
-	pinctrl-0 = <&pri_mi2s_active &pri_mi2s_ws_active>;
-	pinctrl-1 = <&pri_mi2s_sleep &pri_mi2s_ws_sleep>;
-
-	mm1-dai-link {
-		link-name = "MultiMedia1";
-		cpu {
-			sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
-		};
-	};
-
-	pri-mi2s-dai-link {
-		link-name = "PRI MI2S Playback";
-		cpu {
-			sound-dai = <&q6afedai PRIMARY_MI2S_RX>;
-		};
-
-		platform {
-			sound-dai = <&q6routing>;
-		};
-	};
-};
diff --git a/Documentation/devicetree/bindings/sound/qcom,sdm845.yaml b/Documentation/devicetree/bindings/sound/qcom,sdm845.yaml
new file mode 100644
index 000000000000..5e7e6b051cf0
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/qcom,sdm845.yaml
@@ -0,0 +1,166 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/qcom,sdm845.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm Technologies Inc. SDM845 ASoC sound card
+
+maintainers:
+  - Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,sdm845-sndcard
+      - qcom,db845c-sndcard
+      - lenovo,yoga-c630-sndcard
+
+  audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description:
+      A list of the connections between audio components.  Each entry is a pair
+      of strings, the first being the connection's sink, the second being the
+      connection's source. Valid names could be power supplies, MicBias of
+      codec and the jacks on the board.
+
+  aux-devs:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: |
+      List of phandles for auxiliary devices (e.g. analog amplifiers) that do
+      not appear directly within the DAI links. Should be connected to another
+      audio component using "audio-routing".
+
+  model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: User-visible sound card name
+
+patternProperties:
+  ".*-dai-link$":
+    type: object
+    description:
+      Each subnode represents a dai link. Subnodes of each dai links would be
+      cpu/codec dais.
+
+    properties:
+      link-name:
+        $ref: /schemas/types.yaml#/definitions/string
+        description: User friendly name for dai link.
+
+      cpu:
+        type: object
+        description: CPU DAI subnode.
+        properties:
+          sound-dai:
+            maxItems: 1
+
+      codec:
+        type: object
+        description: Codec DAI subnode.
+        properties:
+          sound-dai:
+            minItems: 1
+            maxItems: 4
+
+      platform:
+        type: object
+        description: Platform DAI subnode.
+        properties:
+          sound-dai:
+            maxItems: 1
+
+    required:
+      - link-name
+      - cpu
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - model
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/sound/qcom,q6afe.h>
+    #include <dt-bindings/sound/qcom,q6asm.h>
+
+    sound {
+        compatible = "qcom,sdm845-sndcard";
+        model = "Samsung-W737";
+
+        audio-routing = "RX_BIAS", "MCLK",
+                        "AMIC2", "MIC BIAS2",
+                        "SpkrLeft IN", "SPK1 OUT",
+                        "SpkrRight IN", "SPK2 OUT",
+                        "MM_DL1",  "MultiMedia1 Playback",
+                        "MM_DL3",  "MultiMedia3 Playback",
+                        "MultiMedia2 Capture", "MM_UL2";
+
+        mm1-dai-link {
+            link-name = "MultiMedia1";
+            cpu {
+                sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA1>;
+            };
+        };
+
+        mm2-dai-link {
+            link-name = "MultiMedia2";
+            cpu {
+                sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA2>;
+            };
+        };
+
+        mm3-dai-link {
+            link-name = "MultiMedia3";
+            cpu {
+                sound-dai = <&q6asmdai MSM_FRONTEND_DAI_MULTIMEDIA3>;
+            };
+        };
+
+        slim-dai-link {
+            link-name = "SLIM Playback";
+            cpu {
+                sound-dai = <&q6afedai SLIMBUS_0_RX>;
+            };
+
+            platform {
+                sound-dai = <&q6routing>;
+            };
+
+            codec {
+                sound-dai = <&left_spkr>, <&right_spkr>, <&swm 0>, <&wcd9340 0>;
+            };
+        };
+
+        slimcap-dai-link {
+            link-name = "SLIM Capture";
+            cpu {
+                sound-dai = <&q6afedai SLIMBUS_0_TX>;
+            };
+
+            platform {
+                sound-dai = <&q6routing>;
+            };
+
+            codec {
+                sound-dai = <&wcd9340 1>;
+            };
+        };
+
+        slim-wcd-dai-link {
+            link-name = "SLIM WCD Playback";
+            cpu {
+                sound-dai = <&q6afedai SLIMBUS_1_RX>;
+            };
+
+            platform {
+                sound-dai = <&q6routing>;
+            };
+
+            codec {
+                sound-dai = <&wcd9340 2>;
+            };
+        };
+    };
-- 
2.34.1

