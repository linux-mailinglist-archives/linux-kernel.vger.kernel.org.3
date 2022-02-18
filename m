Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F664BB28A
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbiBRGgl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:36:41 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiBRGgg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:36:36 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0D503F88D;
        Thu, 17 Feb 2022 22:36:17 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id v5-20020a17090a4ec500b001b8b702df57so11551265pjl.2;
        Thu, 17 Feb 2022 22:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQbAoqa1KwsbzMCJZPl0QEWgqTPAIhCjokqucaj50oY=;
        b=AYiuXzt+VjjBbC8zDKNraQA+ivOdwWihW359vxsCkXzMcRx2t7py4bkBRZjgd+W/xV
         +zZUcRr0FejKug0DGu7gQNZ9WG7i317125t/vZiO3jacVxigNHyPNZImGAoNeCHdEN9R
         1YYRi20EyMR++891bATZSZ9pEWDhHp8OM//irMJSflSfAJjjzjB5EbyVKEoIMnSornb5
         /ffUzCTkA2tLG8DUVFgMI+U/5LIfROe1HYM0lVpBcNiHYLLeUSokukLWRnHD+mRJuRr6
         fo67qJQuI4XvqqASObdLtKshonxZ2RgQPS2A0zdsJD86x/SdGzRkrQuKzyDx9bFKjlzf
         r5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uQbAoqa1KwsbzMCJZPl0QEWgqTPAIhCjokqucaj50oY=;
        b=6GEPhjZSZJ3knU8wrgsjZqQ5bX4fKwVAyN77BgbDlmoLub8nMPlqpPWu6n1BtVRngW
         rtANRmhIGlB2yliKhqyP3E3ie/MB/ZHLEFsI635i0TsW6pjL04k3HsOTdgC5QqeDyMTN
         PvdNDXPqKL9AqCk3CFm4fbe3uIj3fkc5dnGfv/B9G4WyBtGxn32RlDPcW0RwUmg0It1r
         ETQ2OW++pluFZyjTg0Wt+NRyLisbjVK/41TwC80UelCPKZaR0dUScNPQ10oA2pqjVQSx
         rvvFc4bQ/dW54l+eVoYTkEA6iA0biKp8kyQg5Wwp1XSA7YpCjzrrwUX6GaqFft4qsWZZ
         nRQg==
X-Gm-Message-State: AOAM531mb4VSMcXXbQAcCR8qWj2FX7CM4PZ6FYy+cu+CskAgkTA8cSMB
        CVJ7bZoN8f2oQO8lOjJBBu+TarUssZ0nxi+K
X-Google-Smtp-Source: ABdhPJybcMeibfzO9kHX/YbZmh51OF4KbpZX/mTydmB1H9MdHMPIId3WfgzwMptueR01D0dG5cCTBQ==
X-Received: by 2002:a17:902:930b:b0:14d:b0c0:1f71 with SMTP id bc11-20020a170902930b00b0014db0c01f71mr6270349plb.113.1645166177121;
        Thu, 17 Feb 2022 22:36:17 -0800 (PST)
Received: from localhost.localdomain ([101.78.151.222])
        by smtp.gmail.com with ESMTPSA id a29sm9664298pgl.24.2022.02.17.22.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Feb 2022 22:36:16 -0800 (PST)
From:   Rex Nie <rexnie3@gmail.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org, spanda@codeaurora.org,
        dianders@chromium.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        hsinyi@chromium.org, rexnie3@gmail.com
Subject: [PATCH] drm/panel: Add panel-edp: add lcd innolux,n140hca-eac
Date:   Fri, 18 Feb 2022 14:36:10 +0800
Message-Id: <20220218063610.1530630-1-rexnie3@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

innolux,n140hca-eac is a eDP-based LCD panel. This panel has 1920x1080
resolution in 14-inch TFT panel.

Signed-off-by: Rex Nie <rexnie3@gmail.com>
---
 .../display/panel/innolux,n140hca-eac.yaml    | 43 +++++++++++++++++++
 drivers/gpu/drm/panel/panel-edp.c             | 26 +++++++++++
 2 files changed, 69 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/innolux,n140hca-eac.yaml

diff --git a/Documentation/devicetree/bindings/display/panel/innolux,n140hca-eac.yaml b/Documentation/devicetree/bindings/display/panel/innolux,n140hca-eac.yaml
new file mode 100644
index 000000000000..5493e383c97c
--- /dev/null
+++ b/Documentation/devicetree/bindings/display/panel/innolux,n140hca-eac.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/display/panel/innolux,n140hca-eac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Innolux N140HCA-EAC 14 inch eDP 1080p display panel
+
+maintainers:
+  - Sandeep Panda <spanda@codeaurora.org>
+  - Douglas Anderson <dianders@chromium.org>
+
+allOf:
+  - $ref: panel-common.yaml#
+
+properties:
+  compatible:
+    const: innolux,n140hca-eac
+
+  enable-gpios: true
+  power-supply: true
+  backlight: true
+  no-hpd: true
+
+required:
+  - compatible
+  - power-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    panel_edp: panel-edp {
+        compatible = "innolux,n140hca-eac";
+        enable-gpios = <&pio 96 GPIO_ACTIVE_HIGH>;
+        power-supply = <&pp3300_disp_x>;
+        backlight = <&backlight_lcd0>;
+        no-hpd;
+    };
+
+...
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index f7bfcf63d48e..f5f9c9cb26ba 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1330,6 +1330,29 @@ static const struct panel_desc innolux_n125hce_gn1 = {
 	},
 };
 
+static const struct display_timing innolux_n140hca_eac_timing = {
+	.pixelclock = { 72600000, 76420000, 80240000 },
+	.hactive = { 1920, 1920, 1920 },
+	.hfront_porch = { 80, 80, 80 },
+	.hback_porch = { 190, 190, 190 },
+	.hsync_len = { 60, 60, 60 },
+	.vactive = { 1080, 1080, 1080 },
+	.vfront_porch = { 6, 6, 6 },
+	.vback_porch = { 38, 38, 38 },
+	.vsync_len = { 8, 8, 8 },
+	.flags = DISPLAY_FLAGS_VSYNC_LOW | DISPLAY_FLAGS_HSYNC_LOW,
+};
+
+static const struct panel_desc innolux_n140hca_eac = {
+	.timings = &innolux_n140hca_eac_timing,
+	.num_timings = 1,
+	.bpc = 6,
+	.size = {
+		.width = 309,
+		.height = 174,
+	},
+};
+
 static const struct drm_display_mode innolux_p120zdg_bf1_mode = {
 	.clock = 206016,
 	.hdisplay = 2160,
@@ -1750,6 +1773,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "innolux,n125hce-gn1",
 		.data = &innolux_n125hce_gn1,
+	}, {
+		.compatible = "innolux,n140hca-eac",
+		.data = &innolux_n140hca_eac,
 	}, {
 		.compatible = "innolux,p120zdg-bf1",
 		.data = &innolux_p120zdg_bf1,
-- 
2.25.1

