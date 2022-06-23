Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D0D557960
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbiFWL6T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiFWL5m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:57:42 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7CD4D604;
        Thu, 23 Jun 2022 04:57:29 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so2338431pjb.2;
        Thu, 23 Jun 2022 04:57:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7HWR+XrxeM7/sjAiAZKDHqat2vkGa8jaXAxlWVZnC0=;
        b=V+78teS62SASXdOfx7TZewVrd1ivQP7w33yLDNP9CtG8d7wYoepRejnElm/F1Aotlx
         FWfyPFiSR6EIRJzroGdrNhSCHlZ+bwiIM8Qi2dA2Hl/cDVUQ3smD7bghNfZht3mFKpN/
         PacdhwHAvzWrg9uFXN/BjJks6N0Ry3wWXbEiPvnOxQUZ3mzg+OIxHy6mBsvNkCpAEfNd
         83nmGJSbFzkNXraC7YiDrSpfdhENH+XWFqtuYf3eqxmi4V4sALj2HI9qjv79m0wlYqEG
         KINu1F9SLWcflzZSj5Ctw0vewxGzAEgP37r56U/SVQ93rPsO+Hy6yMIDDeHwWw2gnhuV
         cOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=I7HWR+XrxeM7/sjAiAZKDHqat2vkGa8jaXAxlWVZnC0=;
        b=7LNn1oNO8sZI8IkLQmXlFc0EG/Q9YoAtaBnegSr2ZEYKp+Qom4rd0LCVYQd9F9qr3i
         Vlb3qEvxCGEGGPdl/kyrR75sxkr3aWk455Vk13wLGqcxwT7bIHhlQOjGrOiGdaZucHgZ
         Ee8wT+gGkgMCnw3LE+E+lOLBjk1av6ImKHEQiIQdniUMtCSvlVSAIrxVclby4+wtLyXD
         1hgeNzSlZDKRGHlpdRWa2rCn5vsyLuAKxLnY/G17AIRNIjPN5bkvJSz9RSKcsIJxGt/Q
         Taww4Y+d0BrEVnHJkGd/fAlbjixCmRS3lKnvzg/8z00nIS26sRBImlCuYF5kkRRQfGna
         Rd4g==
X-Gm-Message-State: AJIora/MyJ8Hdj0fjeG96p7gTuK0x7IxwCsFS3swSoDO6BZ8SI91SrGb
        o3F5EaqiLWNG4Hw/UCz/lCg=
X-Google-Smtp-Source: AGRyM1uxQ7dI2z4dyCllfu8yMXjcF4cxOxSDFWef/L9zfYb81WNkJaw0YO3RFllbFfTRoD4s7yXzBQ==
X-Received: by 2002:a17:90a:66c1:b0:1e8:43ae:f7c0 with SMTP id z1-20020a17090a66c100b001e843aef7c0mr3621574pjl.245.1655985449724;
        Thu, 23 Jun 2022 04:57:29 -0700 (PDT)
Received: from RD-3580-24288.rt.l (111-71-94-93.emome-ip.hinet.net. [111.71.94.93])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b003fbfe88be17sm15016516pgo.24.2022.06.23.04.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:57:29 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: [PATCH v3 04/14] dt-bindings: leds: Add Mediatek MT6370 flashlight
Date:   Thu, 23 Jun 2022 19:56:21 +0800
Message-Id: <20220623115631.22209-5-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623115631.22209-1-peterwu.pub@gmail.com>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
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

Add Mediatek MT6370 flashlight binding documentation.

Signed-off-by: Alice Chen <alice_chen@richtek.com>
---

v3
- Remove the description of enum.
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

