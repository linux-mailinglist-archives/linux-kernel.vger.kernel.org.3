Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DFEF4ED0A6
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 02:05:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352041AbiCaAHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 20:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229606AbiCaAHV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 20:07:21 -0400
Received: from hutie.ust.cz (hutie.ust.cz [185.8.165.127])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 688622B1B6;
        Wed, 30 Mar 2022 17:05:33 -0700 (PDT)
From:   =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cutebit.org; s=mail;
        t=1648685130; bh=vNAuOBEbxoca294MRvbJQo3FQJuHQNSkCGQ2YVXzgTs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=QCK9u2U6MJT4PWy9Qe6btEbbolw5xt6EHdkL9DoSrAieQ0zCSYIXXtWbxiyAU78/n
         Mbkx0pcPFKwPWzSJPpP/C/dO4TjL3rdw72rss1RtR6LKROyfE+kNcTZn6zX0WxwSXo
         wSeWd9SXuI3BKym2mmg9ajUy4GWtEXxJ2HfBypN8=
To:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     =?UTF-8?q?Martin=20Povi=C5=A1er?= <povik+lin@cutebit.org>,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mark Kettenis <kettenis@openbsd.org>,
        Hector Martin <marcan@marcan.st>,
        Sven Peter <sven@svenpeter.dev>
Subject: [RFC PATCH 1/5] dt-bindings: sound: Add Apple Macs sound system
Date:   Thu, 31 Mar 2022 02:04:45 +0200
Message-Id: <20220331000449.41062-2-povik+lin@cutebit.org>
In-Reply-To: <20220331000449.41062-1-povik+lin@cutebit.org>
References: <20220331000449.41062-1-povik+lin@cutebit.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add binding for Apple Silicon Macs' machine-level sound system.

Signed-off-by: Martin Povišer <povik+lin@cutebit.org>
---
 .../bindings/sound/apple,macaudio.yaml        | 103 ++++++++++++++++++
 1 file changed, 103 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/apple,macaudio.yaml

diff --git a/Documentation/devicetree/bindings/sound/apple,macaudio.yaml b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
new file mode 100644
index 000000000000..a6380e4bdd1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/apple,macaudio.yaml
@@ -0,0 +1,103 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/apple,macaudio.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Apple Silicon Macs integrated sound system
+
+maintainers:
+  - Martin Povišer <povik+lin@cutebit.org>
+
+definitions:
+  dai:
+    type: object
+    properties:
+      sound-dai: true
+    required:
+      - sound-dai
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - apple,j274-macaudio
+          - apple,j293-macaudio
+          - apple,j314-macaudio
+      - const: apple,macaudio
+  "#address-cells":
+    const: 1
+  "#size-cells":
+    const: 0
+  model:
+    description: |
+      Model name to use when the sound system is presented to users as a sound card.
+    $ref: /schemas/types.yaml#/definitions/string
+
+patternProperties:
+  "^dai-link(@[0-9a-f]+)?$":
+    description: |
+      A DAI link comprising of CPU and CODEC DAI specifiers and supplemental properties.
+    type: object
+    properties:
+      reg:
+        maxItems: 1
+      mclk-fs:
+        description: |
+          Forced MCLK/samplerate factor (optional).
+        $ref: /schemas/types.yaml#/definitions/uint32
+      link-name:
+        description: Name for the DAI link to present to users.
+        $ref: /schemas/types.yaml#/definitions/string
+      cpu:
+        $ref: "#/definitions/dai"
+      codec:
+        $ref: "#/definitions/dai"
+    required:
+      - reg
+      - cpu
+      - codec
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
+    sound {
+      compatible = "apple,j293-macaudio", "apple,macaudio";
+      model = "MacBook Pro J293 integrated audio";
+
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dai-link@0 {
+        reg = <0>;
+        link-name = "Speakers";
+        mclk-fs = <64>;
+
+        cpu {
+          sound-dai = <&mca 0>, <&mca 1>;
+        };
+        codec {
+          sound-dai = <&speaker_left_front>, <&speaker_right_front>,
+            <&speaker_left_rear>, <&speaker_right_rear>;
+        };
+      };
+
+      dai-link@1 {
+        reg = <1>;
+        link-name = "Headphones Jack";
+        mclk-fs = <64>;
+
+        cpu {
+          sound-dai = <&mca 2>;
+        };
+        codec {
+          sound-dai = <&jack_codec>;
+        };
+      };
+    };
-- 
2.33.0

