Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6605D4834FB
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 17:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234778AbiACQls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 11:41:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbiACQlk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 11:41:40 -0500
X-Greylist: delayed 399 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 03 Jan 2022 08:41:40 PST
Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [IPv6:2001:67c:2050:1::465:111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2042EC061785;
        Mon,  3 Jan 2022 08:41:40 -0800 (PST)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:105:465:1:4:0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4JSLv74cSrzQlLN;
        Mon,  3 Jan 2022 17:34:59 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sylv.io; s=MBO0001;
        t=1641227697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xMrRSAFFQ28kkRErHsEHfo+NPf5sueFwy0kVjjKr9jw=;
        b=obmSI9kz6ea/GSHI0nlpnkgVVFZvRG7UR6KcbP+zmWhL6YWTZRWBw6qdiWEhe6Igx31Wtf
        kMLxDAuNsTo+oPbVD3l7l24xmxDbx1H9PcItAV/wR6SW/BU9yONh6YvYW8c1LBgHwU2MDN
        mCw6Cp/K3LFYFnNk0OtB0IAXi1vloGfVWQ9Zx63j5N2MzXfcxy70C8FNJhjduskXT2SUv1
        tyiio4Zy2uzgqkMAxd92twhu4Bvjj2T9DXIuuELRnlQYPfFr5Rl2nWXQaUN6QWe6ADGehU
        fohDY6khF3GZtZvgG9zff99oSpqu/FlvdbBycEKaCJ50JqW6iZhnnEa+LHHPkg==
From:   Marcello Sylvester Bauer <sylv@sylv.io>
To:     linux-hwmon@vger.kernel.org
Cc:     Marcello Sylvester Bauer <sylv@sylv.io>,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Roland Stigge <stigge@antcom.de>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 3/4] dt-bindings: hwmon: Add binding for max6639
Date:   Mon,  3 Jan 2022 17:33:48 +0100
Message-Id: <df3d2ec4f711d310da8a4b23e2a2fa4c019d3500.1641224715.git.sylv@sylv.io>
In-Reply-To: <cover.1641224715.git.sylv@sylv.io>
References: <cover.1641224715.git.sylv@sylv.io>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Devicetree binding documentation for Maxim MAX6639 temperature
monitor with PWM fan-speed controller.

The devicetree documentation for the SD3078 device tree.

Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
---
 .../bindings/hwmon/maxim,max6639.yaml         | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml

diff --git a/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
new file mode 100644
index 000000000000..136ed37b6aac
--- /dev/null
+++ b/Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+
+$id: http://devicetree.org/schemas/hwmon/maxim,max6639.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim max6639
+
+maintainers:
+  - Roland Stigge <stigge@antcom.de>
+
+description: |
+  The MAX6639 is a 2-channel temperature monitor with dual, automatic, PWM
+  fan-speed controller.  It monitors its own temperature and one external
+  diode-connected transistor or the temperatures of two external diode-connected
+  transistors, typically available in CPUs, FPGAs, or GPUs.
+
+  Datasheets:
+    https://datasheets.maximintegrated.com/en/ds/MAX6639-MAX6639F.pdf
+
+properties:
+  compatible:
+    enum:
+      - maxim,max6639
+
+  reg:
+    maxItems: 1
+
+  polarity:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [0, 1]
+    description:
+      PWM output is low at 100% duty cycle when this bit is set to zero. PWM
+      output is high at 100% duty cycle when this bit is set to 1.
+      Fans PWM polarity is set to high (1) by default.
+
+  pulses-per-revolution:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [1, 2, 3, 4]
+    description:
+      Value specifying the number of pulses per revolution of the controlled
+      FAN.
+
+  rpm-range:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [2000, 4000, 8000, 16000]
+    description:
+      Scales the tachometer counter by setting the maximum (full-scale) value
+      of the RPM range.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      max6639@10 {
+        compatible = "maxim,max6639";
+        reg = <0x10>;
+        polarity = <1>;
+        pulses-per-revolution = <2>;
+        rpm-range = <4000>;
+      };
+    };
-- 
2.33.1

