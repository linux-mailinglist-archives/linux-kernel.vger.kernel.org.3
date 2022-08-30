Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8355A5A35
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 05:42:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiH3DmC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 23:42:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiH3Dl7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 23:41:59 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B78377EA2;
        Mon, 29 Aug 2022 20:41:59 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id v5so3660476plo.9;
        Mon, 29 Aug 2022 20:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=kC8ejgxBHW4BvKEvMuzbJ1b7vMRdrhYLsB+0dVMOcni16inBeQb9PK+Uy1jwvm/SYV
         8ldjsDxnSq+lQiOLdlADmDYA/GFYN5MBipfGf4w+TAyqewCDjTsepQ8S2jvZv1nDFVju
         fSRr5pmIy28/XEL91D0CILqJ8guDmAL54TnK8xXqkApiKByjq7PXUmXHjTuWHU6MDk+w
         zKdjyIQSbpb78KZHgdTEC2ieq82K/HokmOsqXUs3eBayOFk5FguDrbgf0Qt2YIAb+LjQ
         Wpta/W0OnEdxtJZhNXKvhXuueNzcPLMKpnlpiulpfF++7H91FWLZIbTuqJOdpZi2V2pr
         FPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=CX/0guoh/DjN4wN8JJoOSTPFmeqM5+Xm+kwBd/9d3Ho=;
        b=keofJeJGT1Gh1jYLLicru3IxdmE9v37F97RvX+qoe73bl7LGvXZltsuPNIuLir6mH5
         ETha4spG4cWWMr4u7peCTd70jb++y6jrhYIyVQKUYHht0BmSLB2hbYg8AcovCwss3Mnu
         jTf5bWgwnUl6jkmNqktD2YvjeIIWj1lIB/6sIB+GT9q01nkFxyBTOX8EKUNZvam7f5I4
         vyO5qiWEQJ6soOOab4tbfXlukxtNhoCFIB6vyu7usKA709meKE0MUbNbgjgp60KxzvGZ
         IAOOw8h2V6GKLHIDNXR4yqdDF1f6Zprc9jUpAA1+2F5Jxktss+Es3qRpHiT+neQchsQc
         Wd7g==
X-Gm-Message-State: ACgBeo2aDjFV/GYaZ+WqNI9KcmBTZHodoLq80Wq5bmq1BH8YVCh8CZG8
        e5+x4jTtTk5QlI2GOeONGnE=
X-Google-Smtp-Source: AA6agR51dE7ptDcuLrufetVtj+iEdfE6N9pp0vDnAfNSISu8pYX+GFkZu4hpsqWd6ml8H3VuqulzMw==
X-Received: by 2002:a17:902:74c9:b0:174:e7dc:1dfb with SMTP id f9-20020a17090274c900b00174e7dc1dfbmr5407565plt.1.1661830918558;
        Mon, 29 Aug 2022 20:41:58 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-77-88-242.emome-ip.hinet.net. [42.77.88.242])
        by smtp.gmail.com with ESMTPSA id a6-20020a170902ecc600b0016ed5266a5csm8439577plh.170.2022.08.29.20.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 20:41:57 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee@kernel.org, daniel.thompson@linaro.org, jingoohan1@gmail.com,
        pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, jic23@kernel.org, lars@metafoo.de, deller@gmx.de,
        broonie@kernel.org, mazziesaccount@gmail.com,
        andriy.shevchenko@linux.intel.com
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-fbdev@vger.kernel.org, szunichen@gmail.com,
        andy.shevchenko@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v9 03/10] dt-bindings: leds: Add MediaTek MT6370 flashlight
Date:   Tue, 30 Aug 2022 11:40:35 +0800
Message-Id: <20220830034042.9354-4-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220830034042.9354-2-peterwu.pub@gmail.com>
References: <20220830034042.9354-2-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alice Chen <alice_chen@richtek.com>

Add MediaTek MT6370 flashlight binding documentation.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Alice Chen <alice_chen@richtek.com>
Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
---
 .../bindings/leds/mediatek,mt6370-flashlight.yaml  | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml

diff --git a/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
new file mode 100644
index 0000000..e9d02ed
--- /dev/null
+++ b/Documentation/devicetree/bindings/leds/mediatek,mt6370-flashlight.yaml
@@ -0,0 +1,41 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/leds/mediatek,mt6370-flashlight.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Flash LED driver for MT6370 PMIC from MediaTek Integrated.
+
+maintainers:
+  - Alice Chen <alice_chen@richtek.com>
+
+description: |
+  This module is part of the MT6370 MFD device.
+  Add MT6370 flash LED driver include 2-channel flash LED support Torch/Strobe Mode.
+
+properties:
+  compatible:
+    const: mediatek,mt6370-flashlight
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+patternProperties:
+  "^led@[0-1]$":
+    type: object
+    $ref: common.yaml#
+    unevaluatedProperties: false
+
+    properties:
+      reg:
+        enum: [0, 1]
+
+required:
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+
+additionalProperties: false
-- 
2.7.4

