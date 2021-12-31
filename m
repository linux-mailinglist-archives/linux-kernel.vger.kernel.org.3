Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABDF482429
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Dec 2021 14:20:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230274AbhLaNT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Dec 2021 08:19:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbhLaNT6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Dec 2021 08:19:58 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FFEEC061574;
        Fri, 31 Dec 2021 05:19:57 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id b73so17361398wmd.0;
        Fri, 31 Dec 2021 05:19:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYKu1srmFQCpI8rykGJJnfsG32cAQvaoZEbqfDemaO4=;
        b=GalcyacMNctt+2U3h1VRqF8ChGdDy5uAQzIdbtoqMz3IMmXlan3wZrnuoo2InlWIxl
         RlTcPpyg3DifJWSPZGU+PDfGxMHhMELuKXFWik/NNQ0mTum6dLeVFI1qHrnxo52r1NMA
         rsiiNM/TR4CvKZ11TUoM09j3AuJIvnbiitwxuXyPb5c6haYCLTV+R/bQYRKavogDPA7M
         4jnWlFk+VRXH8zD4LIgYzucPc9hNik+kuj/QlXd9Baf1HHmV19P77RiIQw4/0APHSdqe
         xq84oqUmsi4GFXMhKYPc9o1xaXVXkPW+3neW0ojhgqPCj7O0pQOZ+EW/hqE4r46+FbJj
         6+hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=jYKu1srmFQCpI8rykGJJnfsG32cAQvaoZEbqfDemaO4=;
        b=aVAr9sDTPxnfZoSTiEhLcgBxmAr5a1wcdeeXNJYZaX2/L3AgpewhsHces+uu0guhmQ
         xeJrsNccnQvVrTDqE/5La4eOmtxJd+FM7C9Z33TlheHTkc3WjUfSrt9zMonpOAsVlvIs
         X+LVuFB9R5oxaCuz7endHd2TCHAJnZrW8+H8HYYpnRoKjfVR/CMj8LxRiW3W+mVE97sn
         vSElZESSsgwaCiaDwH7aXKe5A8B8vRDwm9agpfnLyBuPIcjjfep+N+taX/9FQ3Yn0L9G
         mFFn9qLjuYOeckEaaxo6p0jZ9KmGRB0INbUEFFiT89xTVQnM303EDtnS/jh76GCaxutX
         cwqw==
X-Gm-Message-State: AOAM533K2cDMFaio/XTdAocLdMS0Z2I1H51P+qQ7NTQqQOxMYbYOH7LR
        xHdeBjfMhv8UMhijEp3aKdPLSUWtTyBD1Q==
X-Google-Smtp-Source: ABdhPJw/XUeixiBtkn2ljsLLjQ7ciXVXiXXAtfRHVbXjXhzRVbzWR0UKbi/sVur/D/BuZD+ShBYH6g==
X-Received: by 2002:a1c:808f:: with SMTP id b137mr29605639wmd.6.1640956795864;
        Fri, 31 Dec 2021 05:19:55 -0800 (PST)
Received: from localhost.localdomain ([84.9.151.116])
        by smtp.googlemail.com with ESMTPSA id r11sm27096683wrw.5.2021.12.31.05.19.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Dec 2021 05:19:55 -0800 (PST)
From:   Iain Hunter <drhunter95@gmail.com>
Cc:     iain@hunterembedded.co.uk, Iain Hunter <drhunter95@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] Add binding for ti,adc1018. It allows selection of channel as a Device Tree property
Date:   Fri, 31 Dec 2021 13:19:15 +0000
Message-Id: <20211231131951.1245508-1-drhunter95@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New binding file uses the adc.yaml to define channel selection 

Signed-off-by: Iain Hunter <drhunter95@gmail.com>
---
 .../bindings/iio/adc/ti,ads1018.yaml          | 126 ++++++++++++++++++
 1 file changed, 126 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
new file mode 100644
index 000000000000..a65fee9d83dd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1018.yaml
@@ -0,0 +1,126 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1018.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1018 4 channel I2C analog to digital converter
+
+maintainers:
+  - Iain Hunter <iain@hunterembedded.co.uk>
+
+description: |
+  Datasheet at: https://www.ti.com/lit/gpn/ads1018
+  Supports both single ended and differential channels.
+
+properties:
+  compatible:
+    const: ti,ads1018
+
+  reg:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  "#io-channel-cells":
+    const: 1
+
+  spi-max-frequency: true
+  spi-cpol: true
+  spi-cpha: true
+
+required:
+  - compatible
+  - reg
+  - "#address-cells"
+  - "#size-cells"
+  - spi-cpha
+
+additionalProperties: false
+
+patternProperties:
+  "^channel@([0-3])$":
+    $ref: "adc.yaml"
+    type: object
+
+    properties:
+      reg:
+        description: |
+            Must be 0, actual channel selected in ti,adc-channels for single ended
+            or ti-adc-channels-diff for differential
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum: [0]
+
+      ti,adc-channels:
+        description: |
+          List of single-ended channels muxed for this ADC. It can have up to 4
+          channels numbered 0-3
+        $ref: /schemas/types.yaml#/definitions/uint32-array
+        deprecated: true
+
+      ti,adc-diff-channels:
+        description: |
+          List of differential channels muxed for this ADC between the pins vinp
+          and vinn. The 4 possible options are:
+          vinp=0, vinn=1
+          vinp=0, vinn=3
+          vinp=1, vinn=3
+          vinp=2, vinn=3
+
+          They are listed in a pair <vinp vinn>.
+
+          Note: At least one of "ti,adc-channels" or "ti,adc-diff-channels" is
+          required.
+        $ref: /schemas/types.yaml#/definitions/uint32-matrix
+        items:
+          items:
+            - description: |
+                "vinp" indicates positive input number
+              minimum: 0
+              maximum: 2
+            - description: |
+                "vinn" indicates negative input number
+              minimum: 1
+              maximum: 3
+
+
+    required:
+      - reg
+
+examples:
+  - |
+    // example on SPI1 with single ended channel 1
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@1 {
+            compatible = "ti,ads1018";
+            reg = <0x0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            spi-cpha;
+            ti,adc-channels = <1>;
+        };
+    };
+  - |
+    // example on SPI0 with differential between inputs 0 and 3
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@0 {
+            compatible = "ti,ads1018";
+            reg = <0x0>;
+            #address-cells = <1>;
+            #size-cells = <0>;
+            spi-cpha;
+            ti,adc-diff-channels = <0 3>;
+        };
+    };
+
+...
-- 
2.25.1

