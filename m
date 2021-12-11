Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD05471738
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 23:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232238AbhLKWt4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 17:49:56 -0500
Received: from ixit.cz ([94.230.151.217]:42144 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231378AbhLKWtz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 17:49:55 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id 7258424AF0;
        Sat, 11 Dec 2021 23:49:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1639262991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MiD41UMlUsSuuZDUhlYfTFmGQrqd9ccMZAMJ/nY2g2I=;
        b=KfS1cdFAu+9Z7Ce5Knup28nmRxtPgbUYI3aYjf59Lh46qjBAnyEsN5soWXuZDcr4lGODVQ
        K2gNZ+//P9WxE9ifGTfDC5uAtHJRFehkor1KryDY/WmVaVNQo5Priqz3Zh9tW9Ci+TFpuP
        B9hycYagVJaIoCnR5t6Fn4HbIgtwNX8=
From:   David Heidelberg <david@ixit.cz>
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Dmitry Osipenko <digetx@gmail.com>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] dt-bindings: sound: nvidia,tegra-audio: Convert multiple txt bindings to yaml
Date:   Sat, 11 Dec 2021 23:49:44 +0100
Message-Id: <20211211224946.79875-1-david@ixit.cz>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam: Yes
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Tegra audio complex with the
  * ALC5632
  * MAX98090
  * RT5640
  * RT5677
  * SGTL5000
  * TrimSlice
  * WM8753
  * WM8903
  * WM9712
codec to the YAML format.

Additional changes:
 - added missing HPOUTL to the WM9712 codec.
 - extended rt5677 codec with multiple pins

Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Signed-off-by: David Heidelberg <david@ixit.cz>
---
v2:
 - converted from one big schema into the common properties and then references to it
 - few additional changes mentioned in commit message
 .../sound/nvidia,tegra-audio-alc5632.txt      |  48 --------
 .../sound/nvidia,tegra-audio-alc5632.yaml     |  74 +++++++++++++
 .../sound/nvidia,tegra-audio-common.yaml      |  83 ++++++++++++++
 .../sound/nvidia,tegra-audio-max98090.txt     |  53 ---------
 .../sound/nvidia,tegra-audio-max98090.yaml    |  97 +++++++++++++++++
 .../sound/nvidia,tegra-audio-rt5640.txt       |  52 ---------
 .../sound/nvidia,tegra-audio-rt5640.yaml      |  85 +++++++++++++++
 .../sound/nvidia,tegra-audio-rt5677.txt       |  67 ------------
 .../sound/nvidia,tegra-audio-rt5677.yaml      | 103 ++++++++++++++++++
 .../sound/nvidia,tegra-audio-sgtl5000.txt     |  42 -------
 .../sound/nvidia,tegra-audio-sgtl5000.yaml    |  67 ++++++++++++
 .../sound/nvidia,tegra-audio-trimslice.txt    |  21 ----
 .../sound/nvidia,tegra-audio-trimslice.yaml   |  33 ++++++
 .../sound/nvidia,tegra-audio-wm8753.txt       |  40 -------
 .../sound/nvidia,tegra-audio-wm8753.yaml      |  79 ++++++++++++++
 .../sound/nvidia,tegra-audio-wm8903.txt       |  62 -----------
 .../sound/nvidia,tegra-audio-wm8903.yaml      |  93 ++++++++++++++++
 .../sound/nvidia,tegra-audio-wm9712.txt       |  60 ----------
 .../sound/nvidia,tegra-audio-wm9712.yaml      |  76 +++++++++++++
 19 files changed, 790 insertions(+), 445 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.yaml
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max98090.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max98090.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.yaml
 delete mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt
 create mode 100644 Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.yaml

diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
deleted file mode 100644
index 57f40f93453e..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.txt
+++ /dev/null
@@ -1,48 +0,0 @@
-NVIDIA Tegra audio complex
-
-Required properties:
-- compatible : "nvidia,tegra-audio-alc5632"
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - pll_a
-  - pll_a_out0
-  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
-- nvidia,model : The user-visible name of this sound complex.
-- nvidia,audio-routing : A list of the connections between audio components.
-  Each entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source. Valid names for sources and
-  sinks are the ALC5632's pins as documented in the binding for the device
-  and:
-
-  * Headset Stereophone
-  * Int Spk
-  * Headset Mic
-  * Digital Mic
-
-- nvidia,i2s-controller : The phandle of the Tegra I2S controller
-- nvidia,audio-codec : The phandle of the ALC5632 audio codec
-
-Example:
-
-sound {
-	compatible = "nvidia,tegra-audio-alc5632-paz00",
-				 "nvidia,tegra-audio-alc5632";
-
-	nvidia,model = "Compal PAZ00";
-
-	nvidia,audio-routing =
-				"Int Spk", "SPK_OUTP",
-				"Int Spk", "SPK_OUTN",
-				"Headset Mic","MICBIAS1",
-				"MIC1_N", "Headset Mic",
-				"MIC1_P", "Headset Mic",
-				"Headset Stereophone", "HP_OUT_R",
-				"Headset Stereophone", "HP_OUT_L";
-
-	nvidia,i2s-controller = <&tegra_i2s1>;
-	nvidia,audio-codec = <&alc5632>;
-
-	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
-	clock-names = "pll_a", "pll_a_out0", "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.yaml
new file mode 100644
index 000000000000..7ef774910e5c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-alc5632.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-alc5632.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with ALC5632 CODEC
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: nvidia,tegra-audio-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: '^[a-z0-9]+,tegra-audio-alc5632(-[a-z0-9]+)+$'
+      - const: nvidia,tegra-audio-alc5632
+
+  nvidia,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source. Valid names for sources and
+      sinks are the pins (documented in the binding document),
+      and the jacks on the board.
+    minItems: 2
+    items:
+      enum:
+        # Board Connectors
+        - "Headset Stereophone"
+        - "Int Spk"
+        - "Headset Mic"
+        - "Digital Mic"
+
+        # CODEC Pins
+        - SPKOUT
+        - SPKOUTN
+        - MICBIAS1
+        - MIC1
+        - HPR
+        - HPL
+        - DMICDAT
+
+required:
+  - nvidia,i2s-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "nvidia,tegra-audio-alc5632-paz00",
+                     "nvidia,tegra-audio-alc5632";
+
+        nvidia,model = "Compal PAZ00";
+
+        nvidia,audio-routing = "Int Spk", "SPKOUT",
+                               "Int Spk", "SPKOUTN",
+                               "Headset Mic", "MICBIAS1",
+                               "MIC1", "Headset Mic",
+                               "Headset Stereophone", "HPR",
+                               "Headset Stereophone", "HPL",
+                               "DMICDAT", "Digital Mic";
+
+        nvidia,i2s-controller = <&i2s>;
+        nvidia,audio-codec = <&codec>;
+
+        clocks = <&clk 112>, <&clk 113>, <&clk 93>;
+        clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
new file mode 100644
index 000000000000..82801b4f46dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-common.yaml
@@ -0,0 +1,83 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/sound/nvidia,tegra-audio-common.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Common properties for NVIDIA Tegra audio complexes
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+properties:
+  clocks:
+    items:
+      - description: PLL A clock
+      - description: PLL A OUT0 clock
+      - description: The Tegra cdev1/extern1 clock, which feeds the card's mclk
+
+  clock-names:
+    items:
+      - const: pll_a
+      - const: pll_a_out0
+      - const: mclk
+
+  nvidia,model:
+    $ref: /schemas/types.yaml#/definitions/string
+    description: The user-visible name of this sound complex.
+
+  nvidia,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source. Valid names for sources and
+      sinks are the pins (documented in the binding document),
+      and the jacks on the board.
+
+  nvidia,ac97-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the AC97 controller
+
+  nvidia,i2s-controller:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of the Tegra I2S controller
+
+  nvidia,audio-codec:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description: The phandle of audio codec
+
+  nvidia,spkr-en-gpios:
+    maxItems: 1
+    description: The GPIO that enables the speakers
+
+  nvidia,hp-mute-gpios:
+    maxItems: 1
+    description: The GPIO that mutes the headphones
+
+  nvidia,hp-det-gpios:
+    maxItems: 1
+    description: The GPIO that detect headphones are plugged in
+
+  nvidia,mic-det-gpios:
+    maxItems: 1
+    description: The GPIO that detect microphone is plugged in
+
+  nvidia,ear-sel-gpios:
+    maxItems: 1
+    description: The GPIO that switch between the microphones
+
+  nvidia,int-mic-en-gpios:
+    maxItems: 1
+    description: The GPIO that enables the internal microphone
+
+  nvidia,ext-mic-en-gpios:
+    maxItems: 1
+    description: The GPIO that enables the external microphone
+
+  nvidia,headset:
+    type: boolean
+    description: The Mic Jack represents state of the headset microphone pin
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max98090.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max98090.txt
deleted file mode 100644
index c3495beba358..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max98090.txt
+++ /dev/null
@@ -1,53 +0,0 @@
-NVIDIA Tegra audio complex, with MAX98090 CODEC
-
-Required properties:
-- compatible : "nvidia,tegra-audio-max98090"
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - pll_a
-  - pll_a_out0
-  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
-- nvidia,model : The user-visible name of this sound complex.
-- nvidia,audio-routing : A list of the connections between audio components.
-  Each entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source. Valid names for sources and
-  sinks are the MAX98090's pins (as documented in its binding), and the jacks
-  on the board:
-
-  * Headphones
-  * Speakers
-  * Mic Jack
-  * Int Mic
-
-- nvidia,i2s-controller : The phandle of the Tegra I2S controller that's
-  connected to the CODEC.
-- nvidia,audio-codec : The phandle of the MAX98090 audio codec.
-
-Optional properties:
-- nvidia,hp-det-gpios : The GPIO that detect headphones are plugged in
-- nvidia,mic-det-gpios : The GPIO that detect microphones are plugged in
-
-Example:
-
-sound {
-	compatible = "nvidia,tegra-audio-max98090-venice2",
-		     "nvidia,tegra-audio-max98090";
-	nvidia,model = "NVIDIA Tegra Venice2";
-
-	nvidia,audio-routing =
-		"Headphones", "HPR",
-		"Headphones", "HPL",
-		"Speakers", "SPKR",
-		"Speakers", "SPKL",
-		"Mic Jack", "MICBIAS",
-		"IN34", "Mic Jack";
-
-	nvidia,i2s-controller = <&tegra_i2s1>;
-	nvidia,audio-codec = <&acodec>;
-
-	clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
-		 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-		 <&tegra_car TEGRA124_CLK_EXTERN1>;
-	clock-names = "pll_a", "pll_a_out0", "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max98090.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max98090.yaml
new file mode 100644
index 000000000000..ccc2ee77ca30
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-max98090.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-max98090.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with MAX98090 CODEC
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: nvidia,tegra-audio-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - pattern: '^[a-z0-9]+,tegra-audio-max98090(-[a-z0-9]+)+$'
+          - const: nvidia,tegra-audio-max98090
+      - items:
+          - enum:
+              - nvidia,tegra-audio-max98090-nyan-big
+              - nvidia,tegra-audio-max98090-nyan-blaze
+          - const: nvidia,tegra-audio-max98090-nyan
+          - const: nvidia,tegra-audio-max98090
+
+  nvidia,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source. Valid names for sources and
+      sinks are the pins (documented in the binding document),
+      and the jacks on the board.
+    minItems: 2
+    items:
+      enum:
+        # Board Connectors
+        - "Headphones"
+        - "Speakers"
+        - "Mic Jack"
+        - "Int Mic"
+
+        # CODEC Pins
+        - MIC1
+        - MIC2
+        - DMICL
+        - DMICR
+        - IN1
+        - IN2
+        - IN3
+        - IN4
+        - IN5
+        - IN6
+        - IN12
+        - IN34
+        - IN56
+        - HPL
+        - HPR
+        - SPKL
+        - SPKR
+        - RCVL
+        - RCVR
+        - MICBIAS
+
+required:
+  - nvidia,i2s-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra124-car.h>
+
+    sound {
+        compatible = "nvidia,tegra-audio-max98090-venice2",
+                     "nvidia,tegra-audio-max98090";
+        nvidia,model = "NVIDIA Tegra Venice2";
+
+        nvidia,audio-routing =
+                "Headphones", "HPR",
+                "Headphones", "HPL",
+                "Speakers", "SPKR",
+                "Speakers", "SPKL",
+                "Mic Jack", "MICBIAS",
+                "IN34", "Mic Jack";
+
+        nvidia,i2s-controller = <&tegra_i2s1>;
+        nvidia,audio-codec = <&acodec>;
+
+        clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
+                 <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
+                 <&tegra_car TEGRA124_CLK_EXTERN1>;
+        clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
deleted file mode 100644
index 7788808dcd0b..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.txt
+++ /dev/null
@@ -1,52 +0,0 @@
-NVIDIA Tegra audio complex, with RT5640 CODEC
-
-Required properties:
-- compatible : "nvidia,tegra-audio-rt5640"
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - pll_a
-  - pll_a_out0
-  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
-- nvidia,model : The user-visible name of this sound complex.
-- nvidia,audio-routing : A list of the connections between audio components.
-  Each entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source. Valid names for sources and
-  sinks are the RT5640's pins (as documented in its binding), and the jacks
-  on the board:
-
-  * Headphones
-  * Speakers
-  * Mic Jack
-
-- nvidia,i2s-controller : The phandle of the Tegra I2S controller that's
-  connected to the CODEC.
-- nvidia,audio-codec : The phandle of the RT5640 audio codec. This binding
-  assumes that AIF1 on the CODEC is connected to Tegra.
-
-Optional properties:
-- nvidia,hp-det-gpios : The GPIO that detects headphones are plugged in
-
-Example:
-
-sound {
-	compatible = "nvidia,tegra-audio-rt5640-dalmore",
-			"nvidia,tegra-audio-rt5640";
-	nvidia,model = "NVIDIA Tegra Dalmore";
-
-	nvidia,audio-routing =
-		"Headphones", "HPOR",
-		"Headphones", "HPOL",
-		"Speakers", "SPORP",
-		"Speakers", "SPORN",
-		"Speakers", "SPOLP",
-		"Speakers", "SPOLN";
-
-	nvidia,i2s-controller = <&tegra_i2s1>;
-	nvidia,audio-codec = <&rt5640>;
-
-	nvidia,hp-det-gpios = <&gpio 143 0>; /* GPIO PR7 */
-
-	clocks = <&tegra_car 216>, <&tegra_car 217>, <&tegra_car 120>;
-	clock-names = "pll_a", "pll_a_out0", "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml
new file mode 100644
index 000000000000..e768fb0e9a59
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5640.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-rt5640.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with RT5639 or RT5640 CODEC
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: nvidia,tegra-audio-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: '^[a-z0-9]+,tegra-audio-rt56(39|40)(-[a-z0-9]+)+$'
+      - const: nvidia,tegra-audio-rt5640
+
+  nvidia,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source. Valid names for sources and
+      sinks are the pins (documented in the binding document),
+      and the jacks on the board.
+    minItems: 2
+    items:
+      enum:
+        # Board Connectors
+        - "Headphones"
+        - "Speakers"
+        - "Mic Jack"
+
+        # CODEC Pins
+        - DMIC1
+        - DMIC2
+        - MICBIAS1
+        - IN1P
+        - IN1R
+        - IN2P
+        - IN2R
+        - HPOL
+        - HPOR
+        - LOUTL
+        - LOUTR
+        - MONOP
+        - MONON
+        - SPOLP
+        - SPOLN
+        - SPORP
+        - SPORN
+
+required:
+  - nvidia,i2s-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "nvidia,tegra-audio-rt5640-dalmore",
+                     "nvidia,tegra-audio-rt5640";
+        nvidia,model = "NVIDIA Tegra Dalmore";
+
+        nvidia,audio-routing =
+                "Headphones", "HPOR",
+                "Headphones", "HPOL",
+                "Speakers", "SPORP",
+                "Speakers", "SPORN",
+                "Speakers", "SPOLP",
+                "Speakers", "SPOLN";
+
+        nvidia,i2s-controller = <&tegra_i2s1>;
+        nvidia,audio-codec = <&rt5640>;
+
+        nvidia,hp-det-gpios = <&gpio 143 0>;
+
+        clocks = <&clk 216>, <&clk 217>, <&clk 120>;
+        clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
+
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt
deleted file mode 100644
index a4589cda214e..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.txt
+++ /dev/null
@@ -1,67 +0,0 @@
-NVIDIA Tegra audio complex, with RT5677 CODEC
-
-Required properties:
-- compatible : "nvidia,tegra-audio-rt5677"
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - pll_a
-  - pll_a_out0
-  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
-- nvidia,model : The user-visible name of this sound complex.
-- nvidia,audio-routing : A list of the connections between audio components.
-  Each entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source. Valid names for sources and
-  sinks are the RT5677's pins (as documented in its binding), and the jacks
-  on the board:
-
-  * Headphone
-  * Speaker
-  * Headset Mic
-  * Internal Mic 1
-  * Internal Mic 2
-
-- nvidia,i2s-controller : The phandle of the Tegra I2S controller that's
-  connected to the CODEC.
-- nvidia,audio-codec : The phandle of the RT5677 audio codec. This binding
-  assumes that AIF1 on the CODEC is connected to Tegra.
-
-Optional properties:
-- nvidia,hp-det-gpios : The GPIO that detects headphones are plugged in
-- nvidia,hp-en-gpios : The GPIO that enables headphone amplifier
-- nvidia,mic-present-gpios: The GPIO that mic jack is plugged in
-- nvidia,dmic-clk-en-gpios : The GPIO that gates DMIC clock signal
-
-Example:
-
-sound {
-	compatible = "nvidia,tegra-audio-rt5677-ryu",
-	        "nvidia,tegra-audio-rt5677";
-	nvidia,model = "NVIDIA Tegra Ryu";
-
-	nvidia,audio-routing =
-		"Headphone", "LOUT2",
-		"Headphone", "LOUT1",
-		"Headset Mic", "MICBIAS1",
-		"IN1P", "Headset Mic",
-		"IN1N", "Headset Mic",
-		"DMIC L1", "Internal Mic 1",
-		"DMIC R1", "Internal Mic 1",
-		"DMIC L2", "Internal Mic 2",
-		"DMIC R2", "Internal Mic 2",
-		"Speaker", "PDM1L",
-		"Speaker", "PDM1R";
-
-	nvidia,i2s-controller = <&tegra_i2s1>;
-	nvidia,audio-codec = <&rt5677>;
-
-	nvidia,hp-det-gpios = <&gpio TEGRA_GPIO(R, 7) GPIO_ACTIVE_HIGH>;
-	nvidia,mic-present-gpios = <&gpio TEGRA_GPIO(O, 5) GPIO_ACTIVE_LOW>;
-	nvidia,hp-en-gpios = <&rt5677 1 GPIO_ACTIVE_HIGH>;
-	nvidia,dmic-clk-en-gpios = <&rt5677 2 GPIO_ACTIVE_HIGH>;
-
-	clocks = <&tegra_car TEGRA124_CLK_PLL_A>,
-	         <&tegra_car TEGRA124_CLK_PLL_A_OUT0>,
-	         <&tegra_car TEGRA124_CLK_EXTERN1>;
-	clock-names = "pll_a", "pll_a_out0", "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml
new file mode 100644
index 000000000000..03ff691c26c8
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-rt5677.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-rt5677.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with RT5677 CODEC
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: nvidia,tegra-audio-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: '^[a-z0-9]+,tegra-audio-rt5677(-[a-z0-9]+)+$'
+      - const: nvidia,tegra-audio-rt5677
+
+  nvidia,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source. Valid names for sources and
+      sinks are the pins (documented in the binding document),
+      and the jacks on the board.
+    minItems: 2
+    items:
+      enum:
+        # Board Connectors
+        - "Headphone"
+        - "Speaker"
+        - "Headset Mic"
+        - "Internal Mic 1"
+        - "Internal Mic 2"
+
+        # CODEC Pins
+        - IN1P
+        - IN1N
+        - IN2P
+        - IN2N
+        - MICBIAS1
+        - DMIC1
+        - DMIC2
+        - DMIC3
+        - DMIC4
+        - "DMIC L1"
+        - "DMIC L2"
+        - "DMIC L3"
+        - "DMIC L4"
+        - "DMIC R1"
+        - "DMIC R2"
+        - "DMIC R3"
+        - "DMIC R4"
+        - LOUT1
+        - LOUT2
+        - LOUT3
+        - PDM1L
+        - PDM1R
+        - PDM2L
+        - PDM2R
+
+required:
+  - nvidia,i2s-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "nvidia,tegra-audio-rt5677-ryu",
+                     "nvidia,tegra-audio-rt5677";
+        nvidia,model = "NVIDIA Tegra Ryu";
+
+        nvidia,audio-routing =
+                "Headphone", "LOUT2",
+                "Headphone", "LOUT1",
+                "Headset Mic", "MICBIAS1",
+                "IN1P", "Headset Mic",
+                "IN1N", "Headset Mic",
+                "DMIC L1", "Internal Mic 1",
+                "DMIC R1", "Internal Mic 1",
+                "DMIC L2", "Internal Mic 2",
+                "DMIC R2", "Internal Mic 2",
+                "Speaker", "PDM1L",
+                "Speaker", "PDM1R";
+
+        nvidia,i2s-controller = <&tegra_i2s1>;
+        nvidia,audio-codec = <&rt5677>;
+
+        nvidia,hp-det-gpios = <&gpio 143 0>;
+        nvidia,mic-present-gpios = <&gpio 132 1>;
+        nvidia,hp-en-gpios = <&rt5677 1 0>;
+        nvidia,dmic-clk-en-gpios = <&rt5677 2 1>;
+
+        clocks = <&clk 216>,
+                 <&clk 217>,
+                 <&clk 121>;
+        clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.txt
deleted file mode 100644
index 5da7da4ea07a..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.txt
+++ /dev/null
@@ -1,42 +0,0 @@
-NVIDIA Tegra audio complex, with SGTL5000 CODEC
-
-Required properties:
-- compatible : "nvidia,tegra-audio-sgtl5000"
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - pll_a
-  - pll_a_out0
-  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
-- nvidia,model : The user-visible name of this sound complex.
-- nvidia,audio-routing : A list of the connections between audio components.
-  Each entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source. Valid names for sources and
-  sinks are the SGTL5000's pins (as documented in its binding), and the jacks
-  on the board:
-
-  * Headphone Jack
-  * Line In Jack
-  * Mic Jack
-
-- nvidia,i2s-controller : The phandle of the Tegra I2S controller that's
-  connected to the CODEC.
-- nvidia,audio-codec : The phandle of the SGTL5000 audio codec.
-
-Example:
-
-sound {
-	compatible = "toradex,tegra-audio-sgtl5000-apalis_t30",
-		     "nvidia,tegra-audio-sgtl5000";
-	nvidia,model = "Toradex Apalis T30";
-	nvidia,audio-routing =
-		"Headphone Jack", "HP_OUT",
-		"LINE_IN", "Line In Jack",
-		"MIC_IN", "Mic Jack";
-	nvidia,i2s-controller = <&tegra_i2s2>;
-	nvidia,audio-codec = <&sgtl5000>;
-	clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
-		 <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
-		 <&tegra_car TEGRA30_CLK_EXTERN1>;
-	clock-names = "pll_a", "pll_a_out0", "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.yaml
new file mode 100644
index 000000000000..943e7c01741c
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-sgtl5000.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-sgtl5000.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with SGTL5000 CODEC
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: nvidia,tegra-audio-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: '^[a-z0-9]+,tegra-audio-sgtl5000([-_][a-z0-9]+)+$'
+      - const: nvidia,tegra-audio-sgtl5000
+
+  nvidia,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source. Valid names for sources and
+      sinks are the pins (documented in the binding document),
+      and the jacks on the board.
+    minItems: 2
+    items:
+      enum:
+        # Board Connectors
+        - "Headphone Jack"
+        - "Line In Jack"
+        - "Mic Jack"
+
+        # CODEC Pins
+        - HP_OUT
+        - LINE_OUT
+        - LINE_IN
+        - MIC_IN
+
+required:
+  - nvidia,i2s-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/tegra30-car.h>
+
+    sound {
+      compatible = "toradex,tegra-audio-sgtl5000-apalis_t30",
+                   "nvidia,tegra-audio-sgtl5000";
+      nvidia,model = "Toradex Apalis T30 SGTL5000";
+      nvidia,audio-routing =
+              "Headphone Jack", "HP_OUT",
+              "LINE_IN", "Line In Jack",
+              "MIC_IN", "Mic Jack";
+      nvidia,i2s-controller = <&tegra_i2s2>;
+      nvidia,audio-codec = <&codec>;
+      clocks = <&tegra_car TEGRA30_CLK_PLL_A>,
+               <&tegra_car TEGRA30_CLK_PLL_A_OUT0>,
+               <&tegra_car TEGRA30_CLK_EXTERN1>;
+      clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt
deleted file mode 100644
index ef1fe7358279..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.txt
+++ /dev/null
@@ -1,21 +0,0 @@
-NVIDIA Tegra audio complex for TrimSlice
-
-Required properties:
-- compatible : "nvidia,tegra-audio-trimslice"
-- clocks : Must contain an entry for each entry in clock-names.
-- clock-names : Must include the following entries:
-  "pll_a" (The Tegra clock of that name),
-  "pll_a_out0" (The Tegra clock of that name),
-  "mclk" (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
-- nvidia,i2s-controller : The phandle of the Tegra I2S1 controller
-- nvidia,audio-codec : The phandle of the WM8903 audio codec
-
-Example:
-
-sound {
-	compatible = "nvidia,tegra-audio-trimslice";
-	nvidia,i2s-controller = <&tegra_i2s1>;
-	nvidia,audio-codec = <&codec>;
-	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
-	clock-names = "pll_a", "pll_a_out0", "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.yaml
new file mode 100644
index 000000000000..8c87cd166238
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-trimslice.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-trimslice.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with TrimSlice CODEC
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: nvidia,tegra-audio-common.yaml#
+
+properties:
+  compatible:
+    const: nvidia,tegra-audio-trimslice
+
+required:
+  - nvidia,i2s-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "nvidia,tegra-audio-trimslice";
+        nvidia,i2s-controller = <&tegra_i2s1>;
+        nvidia,audio-codec = <&codec>;
+        clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
+        clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
deleted file mode 100644
index 96f6a57dd6b4..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.txt
+++ /dev/null
@@ -1,40 +0,0 @@
-NVIDIA Tegra audio complex
-
-Required properties:
-- compatible : "nvidia,tegra-audio-wm8753"
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - pll_a
-  - pll_a_out0
-  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
-- nvidia,model : The user-visible name of this sound complex.
-- nvidia,audio-routing : A list of the connections between audio components.
-  Each entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source. Valid names for sources and
-  sinks are the WM8753's pins as documented in the binding for the WM8753,
-  and the jacks on the board:
-
-  * Headphone Jack
-  * Mic Jack
-
-- nvidia,i2s-controller : The phandle of the Tegra I2S1 controller
-- nvidia,audio-codec : The phandle of the WM8753 audio codec
-Example:
-
-sound {
-	compatible = "nvidia,tegra-audio-wm8753-whistler",
-		     "nvidia,tegra-audio-wm8753"
-	nvidia,model = "tegra-wm8753-harmony";
-
-	nvidia,audio-routing =
-		"Headphone Jack", "LOUT1",
-		"Headphone Jack", "ROUT1";
-
-	nvidia,i2s-controller = <&i2s1>;
-	nvidia,audio-codec = <&wm8753>;
-
-	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
-	clock-names = "pll_a", "pll_a_out0", "mclk";
-};
-
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.yaml
new file mode 100644
index 000000000000..a5b431d7d0c2
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8753.yaml
@@ -0,0 +1,79 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-wm8753.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with WM8753 CODEC
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: nvidia,tegra-audio-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: '^[a-z0-9]+,tegra-audio-wm8753(-[a-z0-9]+)+$'
+      - const: nvidia,tegra-audio-wm8753
+
+  nvidia,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source. Valid names for sources and
+      sinks are the pins (documented in the binding document),
+      and the jacks on the board.
+    minItems: 2
+    items:
+      enum:
+        # Board Connectors
+        - "Headphone Jack"
+        - "Mic Jack"
+
+        # CODEC Pins
+        - LOUT1
+        - LOUT2
+        - ROUT1
+        - ROUT2
+        - MONO1
+        - MONO2
+        - OUT3
+        - OUT4
+        - LINE1
+        - LINE2
+        - RXP
+        - RXN
+        - ACIN
+        - ACOP
+        - MIC1N
+        - MIC1
+        - MIC2N
+        - MIC2
+        - "Mic Bias"
+
+required:
+  - nvidia,i2s-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "nvidia,tegra-audio-wm8753-whistler",
+                     "nvidia,tegra-audio-wm8753";
+        nvidia,model = "tegra-wm8753-harmony";
+
+        nvidia,audio-routing =
+                "Headphone Jack", "LOUT1",
+                "Headphone Jack", "ROUT1";
+
+        nvidia,i2s-controller = <&i2s1>;
+        nvidia,audio-codec = <&wm8753>;
+
+        clocks = <&clk 112>, <&clk 113>, <&clk 93>;
+        clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
deleted file mode 100644
index bbd581a8c5bc..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.txt
+++ /dev/null
@@ -1,62 +0,0 @@
-NVIDIA Tegra audio complex
-
-Required properties:
-- compatible : "nvidia,tegra-audio-wm8903"
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - pll_a
-  - pll_a_out0
-  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
-- nvidia,model : The user-visible name of this sound complex.
-- nvidia,audio-routing : A list of the connections between audio components.
-  Each entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source. Valid names for sources and
-  sinks are the WM8903's pins (documented in the WM8903 binding document),
-  and the jacks on the board:
-
-  * Headphone Jack
-  * Int Spk
-  * Mic Jack
-  * Int Mic
-
-- nvidia,i2s-controller : The phandle of the Tegra I2S1 controller
-- nvidia,audio-codec : The phandle of the WM8903 audio codec
-
-Optional properties:
-- nvidia,spkr-en-gpios : The GPIO that enables the speakers
-- nvidia,hp-mute-gpios : The GPIO that mutes the headphones
-- nvidia,hp-det-gpios : The GPIO that detect headphones are plugged in
-- nvidia,int-mic-en-gpios : The GPIO that enables the internal microphone
-- nvidia,ext-mic-en-gpios : The GPIO that enables the external microphone
-- nvidia,headset : The Mic Jack represents state of the headset microphone pin
-
-Example:
-
-sound {
-	compatible = "nvidia,tegra-audio-wm8903-harmony",
-		     "nvidia,tegra-audio-wm8903"
-	nvidia,model = "tegra-wm8903-harmony";
-
-	nvidia,audio-routing =
-		"Headphone Jack", "HPOUTR",
-		"Headphone Jack", "HPOUTL",
-		"Int Spk", "ROP",
-		"Int Spk", "RON",
-		"Int Spk", "LOP",
-		"Int Spk", "LON",
-		"Mic Jack", "MICBIAS",
-		"IN1L", "Mic Jack";
-
-	nvidia,i2s-controller = <&i2s1>;
-	nvidia,audio-codec = <&wm8903>;
-
-	nvidia,spkr-en-gpios = <&codec 2 0>;
-	nvidia,hp-det-gpios = <&gpio 178 0>; /* gpio PW2 */
-	nvidia,int-mic-en-gpios = <&gpio 184 0>; /*gpio PX0 */
-	nvidia,ext-mic-en-gpios = <&gpio 185 0>; /* gpio PX1 */
-
-	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
-	clock-names = "pll_a", "pll_a_out0", "mclk";
-};
-
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.yaml
new file mode 100644
index 000000000000..1b836acab980
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm8903.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-wm8903.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with WM8903 CODEC
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: nvidia,tegra-audio-common.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - pattern: '^[a-z0-9]+,tegra-audio-wm8903(-[a-z0-9]+)+$'
+          - const: nvidia,tegra-audio-wm8903
+      - items:
+          - pattern: ad,tegra-audio-plutux
+          - const: nvidia,tegra-audio-wm8903
+
+  nvidia,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source. Valid names for sources and
+      sinks are the pins (documented in the binding document),
+      and the jacks on the board.
+    minItems: 2
+    items:
+      enum:
+        # Board Connectors
+        - "Headphone Jack"
+        - "Int Spk"
+        - "Mic Jack"
+        - "Int Mic"
+
+        # CODEC Pins
+        - IN1L
+        - IN1R
+        - IN2L
+        - IN2R
+        - IN3L
+        - IN3R
+        - DMICDAT
+        - HPOUTL
+        - HPOUTR
+        - LINEOUTL
+        - LINEOUTR
+        - LOP
+        - LON
+        - ROP
+        - RON
+        - MICBIAS
+
+required:
+  - nvidia,i2s-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "nvidia,tegra-audio-wm8903-harmony",
+                     "nvidia,tegra-audio-wm8903";
+        nvidia,model = "tegra-wm8903-harmony";
+
+        nvidia,audio-routing =
+                "Headphone Jack", "HPOUTR",
+                "Headphone Jack", "HPOUTL",
+                "Int Spk", "ROP",
+                "Int Spk", "RON",
+                "Int Spk", "LOP",
+                "Int Spk", "LON",
+                "Mic Jack", "MICBIAS",
+                "IN1L", "Mic Jack";
+
+        nvidia,i2s-controller = <&i2s1>;
+        nvidia,audio-codec = <&wm8903>;
+
+        nvidia,spkr-en-gpios = <&codec 2 0>;
+        nvidia,hp-det-gpios = <&gpio 178 0>;
+        nvidia,int-mic-en-gpios = <&gpio 184 0>;
+        nvidia,ext-mic-en-gpios = <&gpio 185 0>;
+
+        clocks = <&clk 112>, <&clk 113>, <&clk 93>;
+        clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt
deleted file mode 100644
index 436f6cd9d07c..000000000000
--- a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-NVIDIA Tegra audio complex
-
-Required properties:
-- compatible : "nvidia,tegra-audio-wm9712"
-- clocks : Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names : Must include the following entries:
-  - pll_a
-  - pll_a_out0
-  - mclk (The Tegra cdev1/extern1 clock, which feeds the CODEC's mclk)
-- nvidia,model : The user-visible name of this sound complex.
-- nvidia,audio-routing : A list of the connections between audio components.
-  Each entry is a pair of strings, the first being the connection's sink,
-  the second being the connection's source. Valid names for sources and
-  sinks are the WM9712's pins, and the jacks on the board:
-
-  WM9712 pins:
-
-  * MONOOUT
-  * HPOUTL
-  * HPOUTR
-  * LOUT2
-  * ROUT2
-  * OUT3
-  * LINEINL
-  * LINEINR
-  * PHONE
-  * PCBEEP
-  * MIC1
-  * MIC2
-  * Mic Bias
-
-  Board connectors:
-
-  * Headphone
-  * LineIn
-  * Mic
-
-- nvidia,ac97-controller : The phandle of the Tegra AC97 controller
-
-
-Example:
-
-sound {
-	compatible = "nvidia,tegra-audio-wm9712-colibri_t20",
-		         "nvidia,tegra-audio-wm9712";
-	nvidia,model = "Toradex Colibri T20";
-
-	nvidia,audio-routing =
-		"Headphone", "HPOUTL",
-		"Headphone", "HPOUTR",
-		"LineIn", "LINEINL",
-		"LineIn", "LINEINR",
-		"Mic", "MIC1";
-
-	nvidia,ac97-controller = <&ac97>;
-
-	clocks = <&tegra_car 112>, <&tegra_car 113>, <&tegra_car 93>;
-	clock-names = "pll_a", "pll_a_out0", "mclk";
-};
diff --git a/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.yaml b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.yaml
new file mode 100644
index 000000000000..a1448283344b
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/nvidia,tegra-audio-wm9712.yaml
@@ -0,0 +1,76 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/nvidia,tegra-audio-wm9712.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra audio complex with WM9712 CODEC
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <thierry.reding@gmail.com>
+
+allOf:
+  - $ref: nvidia,tegra-audio-common.yaml#
+
+properties:
+  compatible:
+    items:
+      - pattern: '^[a-z0-9]+,tegra-audio-wm9712([-_][a-z0-9]+)+$'
+      - const: nvidia,tegra-audio-wm9712
+
+  nvidia,audio-routing:
+    $ref: /schemas/types.yaml#/definitions/non-unique-string-array
+    description: |
+      A list of the connections between audio components.
+      Each entry is a pair of strings, the first being the connection's sink,
+      the second being the connection's source. Valid names for sources and
+      sinks are the pins (documented in the binding document),
+      and the jacks on the board.
+    minItems: 2
+    items:
+      enum:
+        # Board Connectors
+        - "Headphone"
+        - "LineIn"
+        - "Mic"
+
+        # CODEC Pins
+        - MONOOUT
+        - HPOUTL
+        - HPOUTR
+        - LOUT2
+        - ROUT2
+        - OUT3
+        - LINEINL
+        - LINEINR
+        - PHONE
+        - PCBEEP
+        - MIC1
+        - MIC2
+        - "Mic Bias"
+
+required:
+  - nvidia,ac97-controller
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    sound {
+        compatible = "nvidia,tegra-audio-wm9712-colibri_t20",
+                     "nvidia,tegra-audio-wm9712";
+        nvidia,model = "Toradex Colibri T20";
+
+        nvidia,audio-routing =
+                "Headphone", "HPOUTL",
+                "Headphone", "HPOUTR",
+                "LineIn", "LINEINL",
+                "LineIn", "LINEINR",
+                "Mic", "MIC1";
+
+        nvidia,ac97-controller = <&ac97>;
+
+        clocks = <&clk 112>, <&clk 113>, <&clk 93>;
+        clock-names = "pll_a", "pll_a_out0", "mclk";
+    };
-- 
2.33.0

