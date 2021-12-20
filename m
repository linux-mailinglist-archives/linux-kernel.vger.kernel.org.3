Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75B6147B3D7
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232271AbhLTTjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:39:37 -0500
Received: from ip-15.mailobj.net ([213.182.54.15]:60294 "EHLO msg-4.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232236AbhLTTi5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:38:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1640029070; bh=lemlXquTS0nN8VDw9hKqIsDNGAze45CcccMhX4gx0fM=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=jt81mpAIUX+vk9yJcW7r8Lsn6PTMWwbMPWvR+2pSGd+xGgEzFgQ1rytzMuD8s4pCy
         3yQ6MOxyfgY1mAamKJi42QnqNroEvFXybF/N9Ix0FO7drye6X5UrCzpzy0g17B2k/6
         3d3hsnF0gDZp4+9xvte6wzejzJH/GX6XPQ95wQTo=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Mon, 20 Dec 2021 20:37:50 +0100 (CET)
X-EA-Auth: b7Mo3T0KbdTHogRefIKytdYuExPxQulrJ6XWn+/8Bze2SmOx8jmtqxmb7O7UqDw2g42SGmgRi3w+z3Mdzy5T/ZQvpTkTNaTxuhtULkZDfrk=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     stephan@gerhold.net, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/2] ASoC: dt-bindings: codecs: Add bindings for ak4375
Date:   Mon, 20 Dec 2021 20:37:24 +0100
Message-Id: <20211220193725.2650356-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AK4375 is an audio DAC with headphones amplifier controlled via I2C.
Add simple device tree bindings that describe how to set it up.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
Changed in v2:
- Changed avdd-supply to be required
- Picked up Rob's Reviewed-by
  Sorry if it was not appropriate following the avdd change...
---
 .../devicetree/bindings/sound/ak4375.yaml     | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4375.yaml

diff --git a/Documentation/devicetree/bindings/sound/ak4375.yaml b/Documentation/devicetree/bindings/sound/ak4375.yaml
new file mode 100644
index 000000000000..f1d5074a024d
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak4375.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/sound/ak4375.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: AK4375 DAC and headphones amplifier Device Tree Bindings
+
+maintainers:
+  - Vincent Knecht <vincent.knecht@mailoo.org>
+
+properties:
+  compatible:
+    const: asahi-kasei,ak4375
+
+  reg:
+    maxItems: 1
+
+  '#sound-dai-cells':
+    const: 0
+
+  avdd-supply:
+    description: regulator phandle for the AVDD power supply.
+
+  tvdd-supply:
+    description: regulator phandle for the TVDD power supply.
+
+  pdn-gpios:
+    description: optional GPIO to set the PDN pin.
+
+required:
+  - compatible
+  - reg
+  - '#sound-dai-cells'
+  - avdd-supply
+  - tvdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      headphones: audio-codec@10 {
+        compatible = "asahi-kasei,ak4375";
+        reg = <0x10>;
+        avdd-supply = <&reg_headphones_avdd>;
+        tvdd-supply = <&pm8916_l6>;
+        pdn-gpios = <&msmgpio 114 GPIO_ACTIVE_HIGH>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&headphones_pdn_default>;
+        #sound-dai-cells = <0>;
+      };
+    };
-- 
2.31.1



