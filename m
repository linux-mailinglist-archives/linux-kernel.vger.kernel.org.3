Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916D5494990
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 09:34:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359207AbiATIeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 03:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbiATIeM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 03:34:12 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B14BC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:34:11 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id l35-20020a05600c1d2300b0034d477271c1so11855119wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 00:34:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=yhUmQjlVEm98FuejkV49ied/cxReTiKl0adLMVVp/04=;
        b=Y42GihL3YeLZb7uOM3lU8skBE5QQEe7cNwRcCy0HbdHWbxuACLx6rCIJ7ZlZRc+i5y
         VNKL2Pn4Ndxc7/9dEOr6Zw9maTwRAc5j6bbpGDBcBkZfq7iGzYP2yvuJBMPxhd+mig9E
         uTsIEPSARAXp6Q6m3wMfzf2aHGi15lXF1HSwbzaGdGdQWIjRfblf7m6vkObCXhpGKtO9
         1xwxeEKHJUzRVR9gxU3aVOvx8vp7yzbEcHitPn7vAgRWJzaccbTWW905+N21KN9b3EkT
         f39NLJ0EYUQR5FpW+axFTzVh23rP/jnArwSCCzYq3huXQcKLfyLMjKv8SuR6zE3EYvdu
         Iutw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yhUmQjlVEm98FuejkV49ied/cxReTiKl0adLMVVp/04=;
        b=klQnGIeqGWrtc8OAjkYyBxeRAJumaMkK64tXe3yCLLDjnyJSp4NSihRbDsemYccnfY
         IA/39PvnyH9sQO1WqbVln4rQISlQVqJTE7AnW7nMr98QcvlV4z0jIr4SA0Oki0/tJEt8
         EHuG7quth76Hro8a+o/r4MaIVA6m0KQ9XLfo9/PQypNuFM4gqz4/GkNRG+/64KIvfQh1
         ffo6slrwPokHqwGu98djOvoOcNZEYgRj1W2A8Cslurvqa9EqQh245qcGD7K/rqyJukoy
         FziltcvAgz5ZuZvoVQpJza3L6Jj4+wXfej4tpOZSEjDCLBSSgymLQghWLWaqAMpS8djr
         E52A==
X-Gm-Message-State: AOAM5322dmYikrRYrSjsoluTKWRE20TniNhCHZI0rMroeKPD09XvEm63
        VlaT6/jVHRxUwx3M+LvDytppVw==
X-Google-Smtp-Source: ABdhPJyZC1bKOAl9gpX++fV1urhuFYoqoxlV8kFLB45AN5ZXdk0Gt49gPUaC4fSIBNIPuRC2+YZDBw==
X-Received: by 2002:a05:600c:3d9b:: with SMTP id bi27mr7592930wmb.36.1642667650031;
        Thu, 20 Jan 2022 00:34:10 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:ced2:397a:bee8:75f5])
        by smtp.gmail.com with ESMTPSA id u16sm1821975wmq.24.2022.01.20.00.34.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 00:34:07 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     dri-devel@lists.freedesktop.org,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org
Cc:     linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v2 1/6] dt-bindings: display: add Amlogic MIPI DSI Host Controller bindings
Date:   Thu, 20 Jan 2022 09:33:52 +0100
Message-Id: <20220120083357.1541262-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220120083357.1541262-1-narmstrong@baylibre.com>
References: <20220120083357.1541262-1-narmstrong@baylibre.com>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3532; h=from:subject; bh=nfzFDo4vSJe6xj0FTwEJ/U/lIAnr1DaEgJJpcHdVaxw=; b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBh6R2HY5ZuFCHuvgCYy0WNIdOndZlC1wP7beVGnIlw N220U86JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCYekdhwAKCRB33NvayMhJ0fFMEA DL88tmgR+ibybnnUB80PN5R7nYIMoWYyi7G9P96HUH0rg1ZSKt8xZjDvTWZ5Mu2jRSzx4JPL0trLwP Pd0fIEwl9GDLdZvTBN8z6tG8XA4oN+IYzxO9Mr2ahLj2Y+Vt1I8sLwu2DEJVrfUytQkbiemOjwHfU3 v83Su7MHGk4VNjDkW14KLnHp9D2khQQeXuRb7NaDpT5qjbHJLX9e+dJ8XvoLeHUCCW49h1ndd/B2tU YM86fgTy52FNr/gccY8B+35jwy3mfIWIwxYDJlAWeP6he51KvHCGMIGgB6dY3tR3wd0U6gtFJjMd0M ejgvyiaAmm2DniNpxD/cRbAFbUBQGWGRK8yedVrrNEMhWqOs7Kt78eEUDnUOIhjep5ARt+zJ/gJxPF AQOU0a0q4HCjkDoKavdmzADEUFOMfRDkcgeOnt/irj+ybg2rpOMqQzH3/oKsTdmPy+u6arMYrdSC/D yujqmVRg9v527fWkEH8bSIf7lKg+zqD4hUv4NWxEiy7/zsiU5zAYkBo86cHL1g6xE2KJWcnY2zsF8k 7RGmD2Nd1r2ZJNP3j9Z843W5OY0PuTsP972KMMkEaz0pP0Lv6SFOOu7A/ibol68PPQtQws7gZurDay buWGws0Z8TzWI8xpQbEHlPfSuMyZQDIfjugE5kCOuZpuUuyTLlzgKwEvjlhA==
X-Developer-Key: i=narmstrong@baylibre.com; a=openpgp; fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Amlogic G12A, G12B & SM1 SoCs embeds a Synopsys DW-MIPI-DSI transceiver (ver 1.21a),
with a custom glue managing the IP resets, clock and data input similar to the DW-HDMI Glue
on the same Amlogic SoCs.

Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../display/amlogic,meson-dw-mipi-dsi.yaml    | 116 ++++++++++++++++++
 1 file changed, 116 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml

diff --git a/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml b/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
new file mode 100644
index 000000000000..e057659545a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/amlogic,meson-dw-mipi-dsi.yaml
@@ -0,0 +1,116 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2020 BayLibre, SAS
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/display/amlogic,meson-dw-mipi-dsi.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: Amlogic specific extensions to the Synopsys Designware MIPI DSI Host Controller
+
+maintainers:
+  - Neil Armstrong <narmstrong@baylibre.com>
+
+description: |
+  The Amlogic Meson Synopsys Designware Integration is composed of
+  - A Synopsys DesignWare MIPI DSI Host Controller IP
+  - A TOP control block controlling the Clocks & Resets of the IP
+
+allOf:
+  - $ref: dsi-controller.yaml#
+
+properties:
+  compatible:
+    enum:
+      - amlogic,meson-g12a-dw-mipi-dsi
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    minItems: 2
+
+  clock-names:
+    minItems: 2
+    items:
+      - const: pclk
+      - const: px_clk
+      - const: meas_clk
+
+  resets:
+    minItems: 1
+
+  reset-names:
+    items:
+      - const: top
+
+  phys:
+    minItems: 1
+
+  phy-names:
+    items:
+      - const: dphy
+
+  ports:
+    $ref: /schemas/graph.yaml#/properties/ports
+
+    properties:
+      port@0:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: Input node to receive pixel data.
+
+      port@1:
+        $ref: /schemas/graph.yaml#/properties/port
+        description: DSI output node to panel.
+
+    required:
+      - port@0
+      - port@1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - phys
+  - phy-names
+  - ports
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    dsi@7000 {
+          compatible = "amlogic,meson-g12a-dw-mipi-dsi";
+          reg = <0x6000 0x400>;
+          resets = <&reset_top>;
+          reset-names = "top";
+          clocks = <&clk_pclk>, <&clk_px>;
+          clock-names = "pclk", "px_clk";
+          phys = <&mipi_dphy>;
+          phy-names = "dphy";
+
+          ports {
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              /* VPU VENC Input */
+              mipi_dsi_venc_port: port@0 {
+                  reg = <0>;
+
+                  mipi_dsi_in: endpoint {
+                       remote-endpoint = <&dpi_out>;
+                  };
+              };
+
+              /* DSI Output */
+              mipi_dsi_panel_port: port@1 {
+                  reg = <1>;
+
+                  mipi_out_panel: endpoint {
+                      remote-endpoint = <&mipi_in_panel>;
+                  };
+              };
+          };
+    };
-- 
2.25.1

