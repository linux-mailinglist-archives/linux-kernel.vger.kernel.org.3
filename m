Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0310149774F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:32:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240890AbiAXCbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240865AbiAXCbm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:31:42 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9E90C06173B;
        Sun, 23 Jan 2022 18:31:41 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id h23so17705382iol.11;
        Sun, 23 Jan 2022 18:31:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0qZ67tpkeFBSJ9t9tgLEVEiGlxTQ2nB9WsG2l3ZlOQ=;
        b=iPkHd1C+doSlRjE1qZo0dWd1BGCsSIHtFUaBZIBi7SqZq7NqZGzwBjHvdVfg8vxnIn
         eAjMINqwCOZ7m8Ch0qlMjNZgeYNY/7o1OSASx7/9KM5DOEWZnd2fT5pXNknOJeykpzp+
         eiu6N+ZvJw72629YDAIxO6MxbVgg7XrYMHucYz0LIOQGA3qb8tNo8RZn0MYm/FfRtbMz
         VYlk/0KG+akLKMQ1DqK36AQLdGmariBzaAJdc9xBsetmr5ZWIBLYGZeHBhIytBcvDUw6
         BWCeJoQZHffkw8xDiz3tIRG2ZoSnwPt/aYZ1zZSkN5ICmeqInnckYT7dMBWLXWinENdh
         RMHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0qZ67tpkeFBSJ9t9tgLEVEiGlxTQ2nB9WsG2l3ZlOQ=;
        b=3ccVoMpK6mMVpm7Ef52TGJmJf1B4dMiJ53PW7WIi1NcZqPYQihrxZ3HvLlsBwpxiZ5
         sy3cYlSIaDPViRCkHejuiRikVHWn8IY4zg250uPO8EpnFzDuNiVMORoWPl1qmcJBkm8X
         nm30aBz5ZL7ooMd/1Xy7Wm0cZo81NMS8El3I5/E/5PzbBTUskbSEWRfvBReMeiFcRg5g
         Cb4QHnwwyo1oEUnoHnhlywZ5mw4/6gDVTc5TUHIISsKgeWBByTeQD7Vl4NWym7qrpcVm
         AaqFeNvFB3xx8WLUO1rmFcaiE6IGGLVEyoVPK3X25o0FwIXqs2RVYUD7wPbDkEVYh03Z
         rbSw==
X-Gm-Message-State: AOAM531I26S/fdtOaOR9LNHchNeZL2Gv5RIsDoPprRJMz1xfN4jBBJcr
        TDpnwFdwWjwlFDWTlo9pb9Ce4eEDpGA=
X-Google-Smtp-Source: ABdhPJwTWD0sqVlemPzHrR/znGRysXOUccdjrkZ5rHuwWsFHTrINqiYX6kZ0bp26wW9rT6w8CY4f1g==
X-Received: by 2002:a6b:f104:: with SMTP id e4mr799402iog.49.1642991500812;
        Sun, 23 Jan 2022 18:31:40 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:582d:ad0e:e5a6:94b6])
        by smtp.gmail.com with ESMTPSA id w4sm6625633ilq.56.2022.01.23.18.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 18:31:40 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        aford@beaconembedded.com, Adam Ford <aford173@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH V3 04/10] dt-bindings: media: nxp, imx8mq-vpu: Split G1 and G2 nodes
Date:   Sun, 23 Jan 2022 20:31:18 -0600
Message-Id: <20220124023125.414794-5-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124023125.414794-1-aford173@gmail.com>
References: <20220124023125.414794-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The G1 and G2 are independent and separate decoder blocks
that are enabled by the vpu-blk-ctrl power-domain controller,
which now has a proper driver.

Because these blocks only share the power-domain, and can be
independently fused out, update the bindings to support separate
nodes for the G1 and G2 decoders with vpu-blk-ctrl power-domain
support.

The new DT + old kernel isn't a supported configuration.

Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
index 762be3f96ce9..9c28d562112b 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
@@ -15,33 +15,20 @@ description:
 
 properties:
   compatible:
-    const: nxp,imx8mq-vpu
+    oneOf:
+      - const: nxp,imx8mq-vpu
+        deprecated: true
+      - const: nxp,imx8mq-vpu-g1
+      - const: nxp,imx8mq-vpu-g2
 
   reg:
-    maxItems: 3
-
-  reg-names:
-    items:
-      - const: g1
-      - const: g2
-      - const: ctrl
+    maxItems: 1
 
   interrupts:
-    maxItems: 2
-
-  interrupt-names:
-    items:
-      - const: g1
-      - const: g2
+    maxItems: 1
 
   clocks:
-    maxItems: 3
-
-  clock-names:
-    items:
-      - const: g1
-      - const: g2
-      - const: bus
+    maxItems: 1
 
   power-domains:
     maxItems: 1
@@ -49,31 +36,33 @@ properties:
 required:
   - compatible
   - reg
-  - reg-names
   - interrupts
-  - interrupt-names
   - clocks
-  - clock-names
 
 additionalProperties: false
 
 examples:
   - |
         #include <dt-bindings/clock/imx8mq-clock.h>
+        #include <dt-bindings/power/imx8mq-power.h>
+        #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+        vpu_g1: video-codec@38300000 {
+                compatible = "nxp,imx8mq-vpu-g1";
+                reg = <0x38300000 0x10000>;
+                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>;
+                power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G1>;
+        };
+  - |
+        #include <dt-bindings/clock/imx8mq-clock.h>
+        #include <dt-bindings/power/imx8mq-power.h>
         #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-        vpu: video-codec@38300000 {
-                compatible = "nxp,imx8mq-vpu";
-                reg = <0x38300000 0x10000>,
-                      <0x38310000 0x10000>,
-                      <0x38320000 0x10000>;
-                reg-names = "g1", "g2", "ctrl";
-                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>,
-                             <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
-                interrupt-names = "g1", "g2";
-                clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
-                         <&clk IMX8MQ_CLK_VPU_G2_ROOT>,
-                         <&clk IMX8MQ_CLK_VPU_DEC_ROOT>;
-                clock-names = "g1", "g2", "bus";
-                power-domains = <&pgc_vpu>;
+        vpu_g2: video-codec@38300000 {
+                compatible = "nxp,imx8mq-vpu-g2";
+                reg = <0x38310000 0x10000>;
+                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+                clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
+                power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
         };
-- 
2.32.0

