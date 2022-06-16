Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0A454E220
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 15:38:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377136AbiFPNii (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 09:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377128AbiFPNiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 09:38:23 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80EBF2181D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:38:21 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id q15so795344wmj.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 06:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PxD5eSuoVNmuy9uK+8ImVic/9oJqQQRTmLdQoVDSq7Y=;
        b=KUiIidYubKIQhmnPtrgcqWcZFytwUm9hJxPJTs/iRO0+H51/6/n1Xd/98LXtsAUToW
         DSycfm5OK+VF5Aw54NXyUhKkia6/lS63d8eVYhUiqo8opHX3+jl7rAM/1NYDeJA2Apb6
         vP3T6unqET61xpxyXVK6Wn11V9+x+kRab3KMpVF4PSz5cANkm5TBzLGt9QHcyTU9PZkH
         HIS0CBP/4eOD5uv6gBTn6kDHVMXBFeCsgVaIxAtndx9CBM2vjwI7L3rt59SRZXILAKlW
         54oA0+OZ6itH/HyVQ2d3DxcXnIrj0VxfSPMfLnN822oL790a8DpzHIOB0TJhHspehk5D
         4B1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PxD5eSuoVNmuy9uK+8ImVic/9oJqQQRTmLdQoVDSq7Y=;
        b=NSa06X4/lbLf5gEZ5bBEv8GAiPO+t3+/R4pp9BpfWLbwR55dag0X+ClFzjxExwW+7a
         BvkCeSwxxeZ0O/MnLJckC3CAp9UB252hEwraVwfQRCWB3qzXb0gPMIpe8HkqI+I8DYtm
         tLwT+zuOU6XYv1QlVaPyp4FL+qgDwgFN+kOETqorGfIrpVSucaetHCgDH5viuf+p/xF7
         7vjQ+81ieMiCx3MRXJq0KIICsHIXLEVrJnqYU88PdyPT5/XY4dn1re5/QxP9qSXoEqnX
         9RuvwhwBgqQe1Lwu7SIHzzpsleMS90ZTRKXnkN/UZl7SYMNyCRyomO9egBw+11X5yDtt
         VWMw==
X-Gm-Message-State: AJIora8O6MAAlvuB8pVtpL5ho43zTKD8MU91V21oYJNm8QHdavy/3X8+
        U8xxLdhBQ5A5L7bhpMecuVM4yw==
X-Google-Smtp-Source: AGRyM1tWwdUCxZ5lku8fS/JAqMfPYZ1pVuLz3qlRsQKA25sJXVvPekovAHC6E/LUsIRHdr7iSUur7w==
X-Received: by 2002:a7b:c1d1:0:b0:39c:605c:1530 with SMTP id a17-20020a7bc1d1000000b0039c605c1530mr5150562wmj.80.1655386699992;
        Thu, 16 Jun 2022 06:38:19 -0700 (PDT)
Received: from localhost.localdomain ([2a0d:e487:34f:da80:9c48:d9f8:5c33:3dd5])
        by smtp.gmail.com with ESMTPSA id v12-20020a5d678c000000b0020c5253d90asm1935423wru.86.2022.06.16.06.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jun 2022 06:38:19 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kishon@ti.com, vkoul@kernel.org, devicetree@vger.kernel.org
Cc:     linux-phy@lists.infradead.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH v4 1/2] dt-bindings: phy: add Amlogic G12A Analog MIPI D-PHY bindings
Date:   Thu, 16 Jun 2022 15:38:10 +0200
Message-Id: <20220616133811.1674777-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220616133811.1674777-1-narmstrong@baylibre.com>
References: <20220616133811.1674777-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A SoCs embeds an Analog MIPI D-PHY to communicate with DSI
panels, this adds the bindings.

This Analog D-PHY works with a separate Digital MIPI D-PHY.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 .../phy/amlogic,g12a-mipi-dphy-analog.yaml    | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml

diff --git a/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
new file mode 100644
index 000000000000..7aa0c05d6ce4
--- /dev/null
+++ b/Documentation/devicetree/bindings/phy/amlogic,g12a-mipi-dphy-analog.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/phy/amlogic,g12a-mipi-dphy-analog.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic G12A MIPI analog PHY
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+properties:
+  compatible:
+    const: amlogic,g12a-mipi-dphy-analog
+
+  "#phy-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - "#phy-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    phy@0 {
+          compatible = "amlogic,g12a-mipi-dphy-analog";
+          reg = <0x0 0xc>;
+          #phy-cells = <0>;
+    };
-- 
2.25.1

