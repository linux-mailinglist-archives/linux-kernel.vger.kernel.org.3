Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCCB2568AFD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 16:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232923AbiGFOLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 10:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbiGFOLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 10:11:52 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E8718E0C;
        Wed,  6 Jul 2022 07:11:51 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id a15so14447110pfv.13;
        Wed, 06 Jul 2022 07:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDks3qDrWxLLtCzjVaMIFrgSz1H5Uq4a3TXwwtZzFxU=;
        b=QdEncNZ0k+hZXpv4Je9NVM3o5KHUQH2JCoMQ6DLsFpGWliG+6QNwAEmsq/Qt3SRdsS
         RTiu8tFPpaXbywI4u/EBMYliohLrJVrVDdKeB6NT4F5ZHiJ9Z29jrahAicVWZ7+/p0pr
         0paXAOeQ/Xp96ZA4kY2Z6VEIszydLozOyoXnHawkgOyZPSEIond8HBEfF63v85eiwoZZ
         CS5moumv8nh8Y3nl1fe/MRw5CloGW5vx8Eha+CE0yTilPIeabfmdo4m53cDPnqAoh8I6
         wpTylENw/vomAxkBQFBXeHzF8IZmuPAlYG9UlpOX5KVSTKNofOA9an56MMcXoD9BSDER
         U4Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDks3qDrWxLLtCzjVaMIFrgSz1H5Uq4a3TXwwtZzFxU=;
        b=tWR82TeMFESEiV+M5gkUzBl7sRF8q76eLC1ce7rsZ1uweqTOlAE4+/qh0dubxs8Dwh
         easmICKqvzqPwaKhnf9PdthNvzVH5lEBCo1ye1YRWwDdE7KhVxaHIWv49iqlki4m+C/h
         eWTk7ZuclApO3ryiLvwM+CQZCjoLnjbZLh8hunS27FZNkj4KxuMf5+pr+UPx1q+Gk+rG
         XwmeS2LHhAmKdnXuVZy2tl4uRUP1LSq/Nn25X/uUMEW6VywtuI3tqEVIxf1SwftyNBZT
         VyfO5twdxznDCOlkzow76tgiH7UaQGZO+PTNxt01hIJ9zKuVZfK2Pd2D3kWjCdNuVg4e
         RQSw==
X-Gm-Message-State: AJIora82ZURPWkOCMSsU1hyV/s19dNBJuF3L7PcHLczeS58B3pe73e6p
        po3xD+hdrgcAJyFX1aYzyg4=
X-Google-Smtp-Source: AGRyM1uyELnWqD6Gz30MtI6qAcj4PSyBxUrz7U6Ryjxdzlf6eHAR2R737PkPXE6/DtZrWyBRgvQxKg==
X-Received: by 2002:a65:594e:0:b0:411:c9e8:68b6 with SMTP id g14-20020a65594e000000b00411c9e868b6mr26637930pgu.556.1657116710768;
        Wed, 06 Jul 2022 07:11:50 -0700 (PDT)
Received: from localhost.localdomain (1-171-7-167.dynamic-ip.hinet.net. [1.171.7.167])
        by smtp.gmail.com with ESMTPSA id k2-20020aa79722000000b005283fa73dcesm8738427pfg.77.2022.07.06.07.11.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 06 Jul 2022 07:11:50 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, cy_huang@richtek.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v5 1/2] dt-bindings: iio: adc: Add rtq6056 adc support
Date:   Wed,  6 Jul 2022 22:11:41 +0800
Message-Id: <1657116702-24161-2-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
References: <1657116702-24161-1-git-send-email-u0084500@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add the documentation for Richtek rtq6056.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Since v3
- change the node name to be generic 'adc' in binding example.

Since v2
- Change the resistor property name to be generic 'shunt-resistor-micro-ohms'.

---
 .../bindings/iio/adc/richtek,rtq6056.yaml          | 56 ++++++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
new file mode 100644
index 00000000..88e0086
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/richtek,rtq6056.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/richtek,rtq6056.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: RTQ6056 Bi-Directional Current and Power Monitor with 16-bit ADC
+
+maintainers:
+  - ChiYuan Huang <cy_huang@richtek.com>
+
+description: |
+  The RTQ6056 is a high accuracy current-sense monitor with I2C and SMBus
+  interface, and the device provides full information for system by reading
+  out the loading current and power.
+
+  The device monitors both of the drops across sense resistor and the BUS
+  voltage, converts into the current in amperes, and power in watts through
+  internal analog-to-digital converter ADC. The programmable calibration,
+  adjustable conversion time, and averaging function are also built in for
+  more design flexibility.
+
+  Datasheet is available at
+  https://www.richtek.com/assets/product_file/RTQ6056/DSQ6056-00.pdf
+
+properties:
+  compatible:
+    const: richtek,rtq6056
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  shunt-resistor-micro-ohms:
+    description: Shunt IN+/IN- sensing node resistor
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+      adc@40 {
+        compatible = "richtek,rtq6056";
+        reg = <0x40>;
+        #io-channel-cells = <1>;
+      };
+    };
-- 
2.7.4

