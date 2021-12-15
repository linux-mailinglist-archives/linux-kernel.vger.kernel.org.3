Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6EE474F7A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 01:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238632AbhLOAqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 19:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238618AbhLOAqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 19:46:47 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D712C06173F;
        Tue, 14 Dec 2021 16:46:47 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id s11so18644511ilv.3;
        Tue, 14 Dec 2021 16:46:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wn4y4nOlo3Oeq4CoVpUuRwguDTGRA4xmrBgSN6cvGKk=;
        b=jZS/DO/BkJGMgBGZnAaN7hMIjK9+fmNDEcuyb3asK05XoVLGInRStpkp5naNeCfxCQ
         tgeyEnP7+eH5QtYWKjRBabSpl3DKS0ula2BOPfbfZQ5zeUXdC+ME2bAxn7tsqcK8c1Yi
         2ofGOqhdU+7a8UqYqOJVxNB3TezzwC/CRkW7O1HiLSG36zFIRn9kpQhU24sK4JyEH3M0
         WDrjXwqna3D1ZAzDgUzkQzFO4wXsM7aY4ICE+9GxXIIsqjjcuqA8ic9QhsMGCfDQZabM
         Wa2Fek+z1leXEJHxsnZqIeIq/NUkR1Cl7dt2WoTy8iuOQCm7HXm/paZlw8yQwRP29pfp
         mFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wn4y4nOlo3Oeq4CoVpUuRwguDTGRA4xmrBgSN6cvGKk=;
        b=lGszUJvbnZisOmLFkEuakpxned6uohrdYBBVeLleMu7I0R9l5JgJuFVhqTncU1yMNn
         3q7/Wtr+Cwctq2nzJPJ7DqIJq8uQfm78IL64VL2pgZNaxetdCb/ZwAqw7pSuql7bUpQa
         2GcNcrWFzWNvYSIQ7gr+hL0WZfE8dpU8QaYKgHiCbyioPzOeT6G9tsqHMo/AtX7fYdmd
         ofxtfFK1X3G7P7xjJ2xE/6/7TwCR32maAa4deZQKn8RpSfIjmKYkFr/mcVYDyFFznJjN
         wkhdFf5kWSqGc2UCOGHukhIdM0xGGpZUotqyujlz/RxYU6mLUm4a6HMxuJw1eIo99F9s
         y2ng==
X-Gm-Message-State: AOAM533KTCyj+Rp01y8JoiZVfQVIRnrNCNHibrrz6QvkQvnwmc/WKxmE
        ZKGL2w4iLTDIcAd7I4NjRCnGb9yuuTjGOQ==
X-Google-Smtp-Source: ABdhPJwpeCFb6K9PUvDwvjpvBflb97s9MjaFWpTH7tCXWTlW46vcfUU3F71Bx/1KVWvrIl2ZDvuDDA==
X-Received: by 2002:a05:6e02:1d8c:: with SMTP id h12mr5415515ila.314.1639529206310;
        Tue, 14 Dec 2021 16:46:46 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:8256:b93c:84fb:458b])
        by smtp.gmail.com with ESMTPSA id y8sm218857iox.32.2021.12.14.16.46.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 16:46:45 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     tharvey@gateworks.com, aford@beaconembedded.com,
        michael@amarulasolutions.com, jagan@amarulasolutions.com,
        Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V5 4/9] dt-bindings: soc: add binding for i.MX8MN DISP blk-ctrl
Date:   Tue, 14 Dec 2021 18:46:21 -0600
Message-Id: <20211215004626.2241839-5-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211215004626.2241839-1-aford173@gmail.com>
References: <20211215004626.2241839-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the DT binding for the i.MX8MN DISP blk-ctrl.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
new file mode 100644
index 000000000000..fbeaac399c50
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx8mn-disp-blk-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8MN DISP blk-ctrl
+
+maintainers:
+  - Lucas Stach <l.stach@pengutronix.de>
+
+description:
+  The i.MX8MN DISP blk-ctrl is a top-level peripheral providing access to
+  the NoC and ensuring proper power sequencing of the display and MIPI CSI
+  peripherals located in the DISP domain of the SoC.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8mn-disp-blk-ctrl
+      - const: syscon
+
+  reg:
+    maxItems: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  power-domains:
+    minItems: 5
+    maxItems: 5
+
+  power-domain-names:
+    items:
+      - const: bus
+      - const: isi
+      - const: lcdif
+      - const: mipi-dsi
+      - const: mipi-csi
+
+  clocks:
+    minItems: 11
+    maxItems: 11
+
+  clock-names:
+    items:
+      - const: disp_axi
+      - const: disp_apb
+      - const: disp_axi_root
+      - const: disp_apb_root
+      - const: lcdif-axi
+      - const: lcdif-apb
+      - const: lcdif-pix
+      - const: dsi-pclk
+      - const: dsi-ref
+      - const: csi-aclk
+      - const: csi-pclk
+
+required:
+  - compatible
+  - reg
+  - power-domains
+  - power-domain-names
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imx8mn-clock.h>
+    #include <dt-bindings/power/imx8mn-power.h>
+
+    disp_blk_ctl: blk_ctrl@32e28000 {
+      compatible = "fsl,imx8mn-disp-blk-ctrl", "syscon";
+      reg = <0x32e28000 0x100>;
+      power-domains = <&pgc_dispmix>, <&pgc_dispmix>,
+                      <&pgc_dispmix>, <&pgc_mipi>,
+                      <&pgc_mipi>;
+      power-domain-names = "bus", "isi", "lcdif", "mipi-dsi",
+                           "mipi-csi";
+      clocks = <&clk IMX8MN_CLK_DISP_AXI>,
+               <&clk IMX8MN_CLK_DISP_APB>,
+               <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+               <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+               <&clk IMX8MN_CLK_DISP_AXI_ROOT>,
+               <&clk IMX8MN_CLK_DISP_APB_ROOT>,
+               <&clk IMX8MN_CLK_DISP_PIXEL_ROOT>,
+               <&clk IMX8MN_CLK_DSI_CORE>,
+               <&clk IMX8MN_CLK_DSI_PHY_REF>,
+               <&clk IMX8MN_CLK_CSI1_PHY_REF>,
+               <&clk IMX8MN_CLK_CAMERA_PIXEL_ROOT>;
+       clock-names = "disp_axi", "disp_apb", "disp_axi_root", "disp_apb_root",
+                     "lcdif-axi", "lcdif-apb", "lcdif-pix", "dsi-pclk",
+                     "dsi-ref", "csi-aclk", "csi-pclk";
+       #power-domain-cells = <1>;
+    };
-- 
2.32.0

