Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 723E2527153
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 15:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiENNgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 09:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232645AbiENNgt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 09:36:49 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2417922B27;
        Sat, 14 May 2022 06:36:48 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id ks9so20980907ejb.2;
        Sat, 14 May 2022 06:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7nM+O9rcnvWoPgEj551BXLaNSuGi3Sqb5ztVGD4qhv4=;
        b=masoxyItOVKrANFWKJdgypb3tEPp8p8acKsSxEyuYIDqy9bxP16M/Gzx+bBWBdLKXU
         OJ5LSRnTyx19ejGGLlLo3mot55qjl4/WU7mhVHx0YbeAVjRMg2Gj1nPAEvq/C9ohv5yF
         xleLGuQwdEwPrYAYsqv0YxR25XeMOpfVW0dWYB9GynEFVgglGSWORBlTwrHTtEyf7DoI
         PwFxB7/lnztlKc83IfrzPrixhoVEsgGe94MsAO7wItudyl1UCsAi7LraRjiL0B6VJCV+
         sugN+zy+Y1J1TbE7j5tczgDa4T4L1JwlSzPMrCV2Fuzc2vFlKGb9ZxPH4gbN/0UA0JVg
         sKLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7nM+O9rcnvWoPgEj551BXLaNSuGi3Sqb5ztVGD4qhv4=;
        b=6w67ztn7IH92dbwMG6h02UHBxweGe+NjGULK1O7zB5W9Me06rQgs+cYbvyb+PGOsud
         aQi4ujOKA5KBzlI7g5Y28wpRYhhJ+9TBKZWJanQz9O1mknC0Yz/e/L8j3vysJbX9nXpM
         oWX75Ve1V3sdBAW78amycdoKf3VbMRXjAdezpDOAQeQFQ9zPXDuThHjUfllDGKM4l2Fw
         1DumqSfFY//GsvNDzc/jpjUjcwRPiG/frrMuwCEPFy+/KM+JR+y0B49QmQK0wzJk0UhO
         L6FRklhdn+sbWVBoIavutKH+VeLgYK8ByI9ttGmvOx8hhXMD594aUjkaP5VSQ9OrwCHF
         /sMQ==
X-Gm-Message-State: AOAM530xcd5tuDOgabspNR7kbENkLUoWFsgVNvk8B2Z1HOTbN/zTbzxZ
        xGtrzoeSOzSV+rjVEagwYIewjNir7Sf/8A==
X-Google-Smtp-Source: ABdhPJxgRlXeTS7HB6rRCXSHuxYkg45W2dCOnI6rKbQx0pIsQgZxuplwN6sk+hX6WRqruvKcw4xVqA==
X-Received: by 2002:a17:906:4944:b0:6e8:a48d:804e with SMTP id f4-20020a170906494400b006e8a48d804emr8250192ejt.164.1652535406688;
        Sat, 14 May 2022 06:36:46 -0700 (PDT)
Received: from localhost.localdomain (84-72-105-84.dclient.hispeed.ch. [84.72.105.84])
        by smtp.gmail.com with ESMTPSA id ci18-20020a170907267200b006f3ef214e49sm1736739ejc.175.2022.05.14.06.36.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 May 2022 06:36:46 -0700 (PDT)
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
Subject: [PATCH v4 1/3] media: dt-binding: media: Add rockchip-vepu binding
Date:   Sat, 14 May 2022 15:36:02 +0200
Message-Id: <20220514133604.174905-2-frattaroli.nicolas@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220514133604.174905-1-frattaroli.nicolas@gmail.com>
References: <20220514133604.174905-1-frattaroli.nicolas@gmail.com>
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
 .../bindings/media/rockchip-vepu.yaml         | 64 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 65 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/rockchip-vepu.yaml

diff --git a/Documentation/devicetree/bindings/media/rockchip-vepu.yaml b/Documentation/devicetree/bindings/media/rockchip-vepu.yaml
new file mode 100644
index 000000000000..b7ba5bf3517a
--- /dev/null
+++ b/Documentation/devicetree/bindings/media/rockchip-vepu.yaml
@@ -0,0 +1,64 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/media/rockchip-vepu.yaml#"
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
+        #include <dt-bindings/clock/rk3568-cru.h>
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+        #include <dt-bindings/power/rk3568-power.h>
+
+        vepu: video-codec@fdee0000 {
+                compatible = "rockchip,rk3568-vepu";
+                reg = <0x0 0xfdee0000 0x0 0x800>;
+                interrupts = <GIC_SPI 64 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&cru ACLK_JENC>, <&cru HCLK_JENC>;
+                clock-names = "aclk", "hclk";
+                iommus = <&vepu_mmu>;
+                power-domains = <&power RK3568_PD_RGA>;
+        };
diff --git a/MAINTAINERS b/MAINTAINERS
index 9ce78f2275dc..f901a42e5d0f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8637,6 +8637,7 @@ L:	linux-media@vger.kernel.org
 L:	linux-rockchip@lists.infradead.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
+F:	Documentation/devicetree/bindings/media/rockchip-vepu.yaml
 F:	Documentation/devicetree/bindings/media/rockchip-vpu.yaml
 F:	drivers/staging/media/hantro/
 
-- 
2.36.1

