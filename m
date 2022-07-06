Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF35684C0
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233026AbiGFKIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:08:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiGFKHo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:07:44 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7024D255AE
        for <linux-kernel@vger.kernel.org>; Wed,  6 Jul 2022 03:07:33 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id r14so15527759wrg.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Jul 2022 03:07:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RV7crcrnHKpDR+JNHqiUBuQdjQCZb9VboNC1TvQ0gW8=;
        b=zJUCSNvP9yZ+p4ALIcEWbwB922qRIYqUJVITA2czxsD6ZIQEUTbLfBNpLINcHzMJeo
         4aEo/MxYDJKeUBNvZhinZBh4HD+ncGq/Bdx7rDsjmP4e8x7FoAQ7l1+GNNbmvC9v8b0C
         WUjZzAADOPJffgFIfN+n1MVs83XedLrQ78MWi1901rjT55Puzw4JpbHNurAwiQC0nZX9
         ru7IpD6az0PPFppMQt7ws4bjs2YNUuhk089MizGAbxDULrqRgvoDAaOt1qG0QgQL08UJ
         DZPn4PnffwtRnLQy7k3NSfo7S05XN8YRFaQ1cKyNZSrR+RNBiyXJIbSyHVzhvowFn+03
         3j3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RV7crcrnHKpDR+JNHqiUBuQdjQCZb9VboNC1TvQ0gW8=;
        b=Nu1KcamkDwVVNrvulh44WCiBOgJnGjvBdKlQndVdYOIHaGYK7PklFrjy1UA9A8rOjX
         vgaanyL///+DERzv+Wg9y66dG0BeBLBMH8wWm+MaSnn9AwJDCJGGOhQ3gQBYtf4ZLn8n
         7fI+sqb41EUkwqmKqHCRW/0TVCsXQfC02MH3C+OSi7Sw05CyskoD6CPcopVAbvJEQXrt
         fdCaETDswrkOq8EoMHZSSDK4ai++xuQ/MWs75CIGy+6FACEmKUq2QU7e1AwiXd7P7Xwb
         So32n+7vek8AQ82BzbKlnFF1l85Y/p6bAhEbuWb/UxR3Yy4lwD56/8ni4dwrb7v024Ds
         iVBg==
X-Gm-Message-State: AJIora+v3rIyQeyivcvZUe7ADSYB4USxuPLu1unHXwX3ZGhdJgWF6gRn
        GmMZ4GU8E+SN2VViLso+ZvuM+A==
X-Google-Smtp-Source: AGRyM1vsuEiLpgFjfJ2YRNAqjZ43kbtzJyqEr1FOLrjFzorK5fs+8U5fYUK6WXGBeNENzwT3W+Msdw==
X-Received: by 2002:a05:6000:237:b0:21d:4d65:32b3 with SMTP id l23-20020a056000023700b0021d4d6532b3mr24855054wrz.169.1657102051976;
        Wed, 06 Jul 2022 03:07:31 -0700 (PDT)
Received: from srini-hackbase.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id n35-20020a05600c3ba300b003a039054567sm24678143wms.18.2022.07.06.03.07.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 03:07:31 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 4/7] dt-bindings: nvmem: convert mtk-efuse.txt to YAML schema
Date:   Wed,  6 Jul 2022 11:06:24 +0100
Message-Id: <20220706100627.6534-5-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
References: <20220706100627.6534-1-srinivas.kandagatla@linaro.org>
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

From: Chunfeng Yun <chunfeng.yun@mediatek.com>

Convert mtk-efuse.txt to YAML schema mediatek,efuse.yaml

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/mediatek,efuse.yaml        | 87 +++++++++++++++++++
 .../devicetree/bindings/nvmem/mtk-efuse.txt   | 43 ---------
 2 files changed, 87 insertions(+), 43 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
 delete mode 100644 Documentation/devicetree/bindings/nvmem/mtk-efuse.txt

diff --git a/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
new file mode 100644
index 000000000000..f6e01ddb7499
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/mediatek,efuse.yaml
@@ -0,0 +1,87 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/mediatek,efuse.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek efuse
+
+description: |
+  MediaTek's efuse is used for storing calibration data, it can be accessed
+  on ARM devices usiong I/O mapped memory.
+
+maintainers:
+  - Andrew-CT Chen <andrew-ct.chen@mediatek.com>
+  - Lala Lin <lala.lin@mediatek.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  $nodename:
+    pattern: "^efuse@[0-9a-f]+$"
+
+  compatible:
+    oneOf:
+      - items:
+          - enum:
+              - mediatek,mt7622-efuse
+              - mediatek,mt7623-efuse
+              - mediatek,mt8173-efuse
+              - mediatek,mt8192-efuse
+              - mediatek,mt8195-efuse
+              - mediatek,mt8516-efuse
+          - const: mediatek,efuse
+      - const: mediatek,mt8173-efuse
+        deprecated: true
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    efuse@11c10000 {
+        compatible = "mediatek,mt8195-efuse", "mediatek,efuse";
+        reg = <0x11c10000 0x1000>;
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        u3_tx_imp_p0: usb3-tx-imp@184,1 {
+            reg = <0x184 0x1>;
+            bits = <0 5>;
+        };
+        u3_rx_imp_p0: usb3-rx-imp@184,2 {
+            reg = <0x184 0x2>;
+            bits = <5 5>;
+        };
+        u3_intr_p0: usb3-intr@185 {
+            reg = <0x185 0x1>;
+            bits = <2 6>;
+        };
+        comb_tx_imp_p1: usb3-tx-imp@186,1 {
+            reg = <0x186 0x1>;
+            bits = <0 5>;
+        };
+        comb_rx_imp_p1: usb3-rx-imp@186,2 {
+            reg = <0x186 0x2>;
+            bits = <5 5>;
+        };
+        comb_intr_p1: usb3-intr@187 {
+            reg = <0x187 0x1>;
+            bits = <2 6>;
+        };
+        u2_intr_p0: usb2-intr-p0@188,1 {
+            reg = <0x188 0x1>;
+            bits = <0 5>;
+        };
+        u2_intr_p1: usb2-intr-p1@188,2 {
+            reg = <0x188 0x2>;
+            bits = <5 5>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt b/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
deleted file mode 100644
index 39d529599444..000000000000
--- a/Documentation/devicetree/bindings/nvmem/mtk-efuse.txt
+++ /dev/null
@@ -1,43 +0,0 @@
-= Mediatek MTK-EFUSE device tree bindings =
-
-This binding is intended to represent MTK-EFUSE which is found in most Mediatek SOCs.
-
-Required properties:
-- compatible: should be
-	      "mediatek,mt7622-efuse", "mediatek,efuse": for MT7622
-	      "mediatek,mt7623-efuse", "mediatek,efuse": for MT7623
-	      "mediatek,mt8173-efuse" or "mediatek,efuse": for MT8173
-	      "mediatek,mt8192-efuse", "mediatek,efuse": for MT8192
-	      "mediatek,mt8195-efuse", "mediatek,efuse": for MT8195
-	      "mediatek,mt8516-efuse", "mediatek,efuse": for MT8516
-- reg: Should contain registers location and length
-- bits: contain the bits range by offset and size
-
-= Data cells =
-Are child nodes of MTK-EFUSE, bindings of which as described in
-bindings/nvmem/nvmem.txt
-
-Example:
-
-	efuse: efuse@10206000 {
-		compatible = "mediatek,mt8173-efuse";
-		reg	   = <0 0x10206000 0 0x1000>;
-		#address-cells = <1>;
-		#size-cells = <1>;
-
-		/* Data cells */
-		thermal_calibration: calib@528 {
-			reg = <0x528 0xc>;
-		};
-	};
-
-= Data consumers =
-Are device nodes which consume nvmem data cells.
-
-For example:
-
-	thermal {
-		...
-		nvmem-cells = <&thermal_calibration>;
-		nvmem-cell-names = "calibration";
-	};
-- 
2.25.1

