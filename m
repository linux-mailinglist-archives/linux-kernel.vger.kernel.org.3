Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88720547AE1
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 17:54:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbiFLPyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 11:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiFLPyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 11:54:40 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0179E3701C;
        Sun, 12 Jun 2022 08:54:39 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id n10so6770996ejk.5;
        Sun, 12 Jun 2022 08:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6jiov0cp9XiR8PJWluZ7P2g3Bm+PYn3UYngHD1B3GHU=;
        b=F+Zuv+Xf8RMuWZIqH5SBLCiorcQoAkm1d0LR/h3extqrC/SD8jH9HZQEC/bX9gyEoM
         +6i13u+N88V3YOi1CXiv/nxVRbfsso0bAgjThbjKIDwFA+7dnf4AvpvwAgIBlET8au7J
         89Hbbe/b8mtkKl/hXhqPuMNvQgoDNkKI3RVr+u7iDKHpyQgzDgFd/FaDMHvhNav1QZaa
         eUJpKS3O5Q/nwC7Gz6U9s5acD9uVVfUETvvgciF7p+7WIfJD4/WJodRvlR4W03b4KeaC
         BBn2Xgz4XSoJHD7sL0cHQyhzKYJQJNaiIO5LUwzRu++swmLMj4snmag3ap5VkGn/qOtx
         tHTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6jiov0cp9XiR8PJWluZ7P2g3Bm+PYn3UYngHD1B3GHU=;
        b=4sFHL1/TsaA++RTCVBvhwlnGcr2A9fy7L7WHmC07vNoDwaQi0hFHwqpprO7tGHAT0U
         A4FU9AZvZ10olO+2yWOm5tNGeP5fdw04Em2rcgL0SKsjK9jSYLluJLwk8iAViATq2CeN
         qy+DecUPZ+2Q0v5gsxFf0zc3re5UBX07lcRF61PQvxXRvHui+BNg0GxwlVu5MF3U6dsd
         dgQ7rLmsY0HPnoib16xJo7WkEVB4oQ51WPV+ofXdkvxokEnVOLo6LpQcbxcCgEsB/Gq1
         gy5SSK2E4ee4cU+DvVgE3SAHIYj2+l3JsV7ZecsyEFHFnnWQY2GI7RjcKWkN1wUCBVdl
         Y8DQ==
X-Gm-Message-State: AOAM532Kyt70B5jM4ODFQG8XVtAePl95OlooePx6Ig/zG4GnSYD5CCA2
        YKBvAcnxVmiZJhJPKHiVcTM=
X-Google-Smtp-Source: ABdhPJxIHsE5l0pCjs4ORf4l4BLENX/SfilIz/ULsPt0czoTY5TwP+fgNqEWjAX2P29z/bLe5nUopQ==
X-Received: by 2002:a17:906:3bd9:b0:6ff:4b5:4a8f with SMTP id v25-20020a1709063bd900b006ff04b54a8fmr43122262ejf.139.1655049277602;
        Sun, 12 Jun 2022 08:54:37 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id o1-20020a1709064f8100b006f3ef214de7sm2609459eju.77.2022.06.12.08.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 08:54:37 -0700 (PDT)
From:   Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
To:     Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
Cc:     linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/3] media: dt-binding: media: Add rk3568-vepu binding
Date:   Sun, 12 Jun 2022 17:53:44 +0200
Message-Id: <20220612155346.16288-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220612155346.16288-1-frattaroli.nicolas@gmail.com>
References: <20220612155346.16288-1-frattaroli.nicolas@gmail.com>
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

The RK3568 and RK3566 have a Hantro VPU node solely dedicated to
encoding. This patch adds a new binding to describe it, as it
does not really fit the rockchip-vpu binding, since there is no
decoder.

Signed-off-by: Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
---
 .../bindings/media/rockchip,rk3568-vepu.yaml  | 69 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 70 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml

diff --git a/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
new file mode 100644
index 000000000000..81b26eb4cd35
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
@@ -0,0 +1,69 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/rockchip,rk3568-vepu.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Hantro G1 VPU encoders implemented on Rockchip SoCs
+
+maintainers:
+  - Nicolas Frattaroli <frattaroli.nicolas@gmail.com>
+
+description:
+  Hantro G1 video encode-only accelerators present on Rockchip SoCs.
+
+properties:
+  compatible:
+    enum:
+      - rockchip,rk3568-vepu
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: aclk
+      - const: hclk
+
+  power-domains:
+    maxItems: 1
+
+  iommus:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/rk3568-cru.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/power/rk3568-power.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        vepu: video-codec@fdee0000 {
+            compatible = "rockchip,rk3568-vepu";
+            reg = <0x0 0xfdee0000 0x0 0x800>;
+            interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+            clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
+            clock-names = "aclk", "hclk";
+            iommus = <&vepu_mmu>;
+            power-domains = <&power RK3568_PD_RGA>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 475e28365385..03c5db88908c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8703,6 +8703,7 @@ L:	linux-media@vger.kernel.org
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
+F:	Documentation/devicetree/bindings/media/rockchip,rk3568-vepu.yaml
 F:	Documentation/devicetree/bindings/media/rockchip-vpu.yaml
 F:	drivers/staging/media/hantro/
 
-- 
2.36.1

