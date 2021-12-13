Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62D77473107
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 17:00:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240302AbhLMQAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 11:00:10 -0500
Received: from ip-15.mailobj.net ([213.182.54.15]:42254 "EHLO msg-4.mailo.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240293AbhLMQAI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 11:00:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailoo.org; s=mailo;
        t=1639411171; bh=E3kyiEeT5dBdXWhbp1IxPuCcvru4Lfbtt7wr9gZYQ2k=;
        h=X-EA-Auth:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
         MIME-Version:Content-Transfer-Encoding;
        b=d3GqlFbWXAkuQMYjrVoutU1EGlIJOi1ljXLqLng5C1uUnT26uwl4jfe1qYyzN2y6f
         3vtHb5C6Nm6zBWAM7xHz/a+f+Hcek39i22YXBnhXtOM4Dj6b7E1F9OYWWoFsw3TufG
         K0qFVvsX3niu4rJLkBxjj3r/xd4ShmkZi5KYnByA=
Received: by b-6.in.mailobj.net [192.168.90.16] with ESMTP
        via proxy.mailoo.org [213.182.55.207]
        Mon, 13 Dec 2021 16:59:31 +0100 (CET)
X-EA-Auth: wFsVhjkcT7DL+4gBttlWG8tX9AXPDvpJqJmfnzCnwvqZa0Pgv7B5tNpI1VmhAt5iIHMq7MY78Fq2Jy45N2iiWjWzYnxc9QJsAewSTKabX6s=
From:   Vincent Knecht <vincent.knecht@mailoo.org>
To:     lgirdwood@gmail.com, broonie@kernel.org, robh+dt@kernel.org,
        perex@perex.cz, tiwai@suse.com
Cc:     stephan@gerhold.net, obayerd@eurocomposant.fr,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Vincent Knecht <vincent.knecht@mailoo.org>
Subject: [PATCH 1/2] ASoC: dt-bindings: codecs: Add bindings for ak4375
Date:   Mon, 13 Dec 2021 16:59:11 +0100
Message-Id: <20211213155914.2558902-1-vincent.knecht@mailoo.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

AK4375 is an audio DAC with headphones amplifier controlled via I2C.
Add simple device tree bindings that describe how to set it up.

Signed-off-by: Vincent Knecht <vincent.knecht@mailoo.org>
---
 .../devicetree/bindings/sound/ak4375.yaml     | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/sound/ak4375.yaml

diff --git a/Documentation/devicetree/bindings/sound/ak4375.yaml b/Documentation/devicetree/bindings/sound/ak4375.yaml
new file mode 100644
index 000000000000..295972801872
--- /dev/null
+++ b/Documentation/devicetree/bindings/sound/ak4375.yaml
@@ -0,0 +1,56 @@
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
+    description: optional regulator phandle for the AVDD power supply.
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



