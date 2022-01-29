Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A1A94A2F61
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 13:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345826AbiA2MYv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 07:24:51 -0500
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123]:32960
        "EHLO smtp-relay-internal-1.canonical.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345654AbiA2MYk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 07:24:40 -0500
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 926363F1C6
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 12:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1643459079;
        bh=tXqK0pipG2DbLRjVtcGxzSWNM2TWL5POjuuSkj4vEW8=;
        h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=IaW3LdpdbTff9xH8SspyupTT21wzY14hYmcMTrISstTTeAppHtlnBNq7dQWUXOeAG
         SepEfZlb8dgazZKCrpmvNEtnSUiNhYXIOykonRe2ZKhNU1u5n2Glyly3ypG28yMyEs
         zY8/+E2tejh2XywXxB4btPuQQzFqUyq0hNF1+GB8RS4A47G/uikn2LT7Ui7fXtEYmu
         CyQgTY+9RnFyit6lh+GTyc7hCLgcNZ4R+Ox8QfidezL9wIfsXO72ixLjwkyNlZbb7j
         IQBppbrNoy8n78fOcuVKltAU+3ZYAfXdN1vjMIiEejE6D6vXS+ECCD/gFkAx0lC9YH
         gE7Ka7JFiji4Q==
Received: by mail-wm1-f69.google.com with SMTP id l16-20020a7bcf10000000b0034ffdd81e7aso4224781wmg.4
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 04:24:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXqK0pipG2DbLRjVtcGxzSWNM2TWL5POjuuSkj4vEW8=;
        b=OPqxj+BkXSeXrclX701fMOo8E4LLhK+/1/NYyWBw8rLqyr1txhE81USV/l030aBh9c
         zg3xk3A82RPciT9809L70EP3lCq5pJ+LZSWyFqUQSLT2jVT8hL0mEmG6nbIwo28FRRh+
         KUclTVaNOWocrVo3iUNp4PCOIwA+3+uMz5eqNtAn5WR4BLR7MZU3zKp0eJQeU8wxjYQk
         MZ89uY218g1diRBDbemyZfbG8E8har3fWdN12gmLN4CgC6rS4XMvANQvZriG0QYYPgNP
         YU7JUpahFzkXZgy8TbJFYVJZouUrepSV8+LfcqlcYXsQEvAxoucJo0ownVH0S1psCjSt
         wMuw==
X-Gm-Message-State: AOAM532u2gcXz0EkWw1jYSFvcOWYmkGPilccuhFN/LDqpGrJS5CaQDbS
        PUQE2XHRbyDPm3+FP7ScxVbCmG+Isd3CBwHssTlUuFGcjEbZLBbm25cf+0UX7IDjJivprtf6/aq
        rL0SX8sz+z3ansxxrfdVrENzqi0qX2joCmmGATCOOTA==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr19068539wmi.118.1643459079233;
        Sat, 29 Jan 2022 04:24:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzdmqfActw14wC7FL3RmrVzbohLPY/HdEUge5K9x5B3jaX/pE3A4wDMlx+joQVK33YEdtkdlQ==
X-Received: by 2002:a7b:c153:: with SMTP id z19mr19068521wmi.118.1643459078995;
        Sat, 29 Jan 2022 04:24:38 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-168-84.adslplus.ch. [188.155.168.84])
        by smtp.gmail.com with ESMTPSA id m28sm1106875wms.34.2022.01.29.04.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Jan 2022 04:24:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Jonathan Bakker <xc-racer2@live.ca>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 6/6] ASoC: dt-bindings: samsung,tm2: convert to dtschema
Date:   Sat, 29 Jan 2022 13:24:30 +0100
Message-Id: <20220129122430.45694-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
References: <20220129122357.45545-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the audio complex on Samsung TM2 boards with Samsung Exynos SoC
to DT schema format.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 .../bindings/sound/samsung,tm2-audio.txt      | 42 ----------
 .../bindings/sound/samsung,tm2.yaml           | 80 +++++++++++++++++++
 2 files changed, 80 insertions(+), 42 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
 create mode 100644 Documentation/devicetree/bindings/sound/samsung,tm2.yaml

diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt b/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
deleted file mode 100644
index f5ccc12ddc00..000000000000
--- a/Documentation/devicetree/bindings/sound/samsung,tm2-audio.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-Samsung Exynos5433 TM2(E) audio complex with WM5110 codec
-
-Required properties:
-
- - compatible		 : "samsung,tm2-audio"
- - model		 : the user-visible name of this sound complex
- - audio-codec		 : the first entry should be phandle of the wm5110 audio
-			   codec node, as described in ../mfd/arizona.txt;
-			   the second entry should be phandle of the HDMI
-			   transmitter node
- - i2s-controller	 : the list of phandle and argument tuples pointing to
-			   I2S controllers, the first entry should be I2S0 and
-			   the second one I2S1
- - audio-amplifier	 : the phandle of the MAX98504 amplifier
- - samsung,audio-routing : a list of the connections between audio components;
-			   each entry is a pair of strings, the first being the
-			   connection's sink, the second being the connection's
-			   source; valid names for sources and sinks are the
-			   WM5110's and MAX98504's pins and the jacks on the
-			   board: HP, SPK, Main Mic, Sub Mic, Third Mic,
-			   Headset Mic
- - mic-bias-gpios	 : GPIO pin that enables the Main Mic bias regulator
-
-
-Example:
-
-sound {
-	compatible = "samsung,tm2-audio";
-	audio-codec = <&wm5110>, <&hdmi>;
-	i2s-controller = <&i2s0 0>, <&i2s1 0>;
-	audio-amplifier = <&max98504>;
-	mic-bias-gpios = <&gpr3 2 0>;
-	model = "wm5110";
-	samsung,audio-routing =
-		"HP", "HPOUT1L",
-		"HP", "HPOUT1R",
-		"SPK", "SPKOUT",
-		"SPKOUT", "HPOUT2L",
-		"SPKOUT", "HPOUT2R",
-		"Main Mic", "MICBIAS2",
-		"IN1R", "Main Mic";
-};
diff --git a/Documentation/devicetree/bindings/sound/samsung,tm2.yaml b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
new file mode 100644
index 000000000000..74712d6f3ef4
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/samsung,tm2.yaml
@@ -0,0 +1,80 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/samsung,tm2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Samsung Exynos5433 TM2(E) audio complex with WM5110 codec
+
+maintainers:
+  - Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
+  - Sylwester Nawrocki <s.nawrocki@samsung.com>
+
+properties:
+  compatible:
+    const: samsung,tm2-audio
+
+  audio-amplifier:
+    description: Phandle to the MAX98504 amplifier.
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+  audio-codec:
+    description: Phandles to the codecs.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: Phandle to the WM5110 audio codec.
+      - description: Phandle to the HDMI transmitter node.
+
+  samsung,audio-routing:
+    description: |
+      List of the connections between audio components; each entry is
+      a pair of strings, the first being the connection's sink, the second
+      being the connection's source; valid names for sources and sinks are the
+      WM5110's and MAX98504's pins and the jacks on the board: HP, SPK, Main
+      Mic, Sub Mic, Third Mic, Headset Mic.
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+
+  i2s-controller:
+    description: Phandles to the I2S controllers.
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    items:
+      - description: Phandle to I2S0.
+      - description: Phandle to I2S1.
+
+  mic-bias-gpios:
+    description: GPIO pin that enables the Main Mic bias regulator.
+
+  model:
+    description: The user-visible name of this sound complex.
+    $ref: /schemas/types.yaml#/definitions/string
+
+required:
+  - compatible
+  - audio-amplifier
+  - audio-codec
+  - samsung,audio-routing
+  - i2s-controller
+  - mic-bias-gpios
+  - model
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    sound {
+        compatible = "samsung,tm2-audio";
+        audio-codec = <&wm5110>, <&hdmi>;
+        i2s-controller = <&i2s0 0>, <&i2s1 0>;
+        audio-amplifier = <&max98504>;
+        mic-bias-gpios = <&gpr3 2 GPIO_ACTIVE_HIGH>;
+        model = "wm5110";
+        samsung,audio-routing = "HP", "HPOUT1L",
+                                "HP", "HPOUT1R",
+                                "SPK", "SPKOUT",
+                                "SPKOUT", "HPOUT2L",
+                                "SPKOUT", "HPOUT2R",
+                                "RCV", "HPOUT3L",
+                                "RCV", "HPOUT3R";
+    };
-- 
2.32.0

