Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D741F46B031
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 02:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239090AbhLGB6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 20:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237555AbhLGB6h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 20:58:37 -0500
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75878C0613F8;
        Mon,  6 Dec 2021 17:55:06 -0800 (PST)
Received: by mail-io1-xd31.google.com with SMTP id y16so15225919ioc.8;
        Mon, 06 Dec 2021 17:55:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=v92hmZhCqOeQNRoL1iE4lgtGbhoSwewU6XylFnXIQ3Y=;
        b=bpVO1R65BVgiXde5x1dOBiFaWy1doBQ7duXiRmqXmSf+AUgE06EkCG1FrYQi0HMXUg
         m5LMuQhL7a3hK4yVeAi6zbo/ACVQ72RxTzf++sQrNji9XFvwxjMFBGc0A/jz2bFkauSU
         wGGful+ftKAxK/f63rRaDazBtTEtIhHbqBGVLv3Ilin2+JOpSYzsXjus4JGYu5DGWnlq
         7ohWfKLO2v1Z7+HTXQG0Y0quVcw1PuM+Ee9ulBIKGRnV/XrZ4BbEjtp43dnbBxSgSnx+
         bkux5F+jJaNW1AbJpiKcSyRei2wrjw+QPHFnd1ZnLqrCO2gFnGhnb1WKpLyTuaaAYaI+
         AY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=v92hmZhCqOeQNRoL1iE4lgtGbhoSwewU6XylFnXIQ3Y=;
        b=OnkYcdjoVFyoyqhe6pnWxWZ0PvG8f4NnyXk3xn1Yah9y5kyMBZRTiDyWSjt8LKt+VP
         lrbRKZYySSpzc6rLEFl9tvHnuIUM76AD73O4BHFomFWY7l5/kkHeACK8jfNBE+UTMAm9
         YeMOlexrpU9mlC5fxcXq1lOszhk1kwGn0Kw1zfDTYoXcLnoRCwRdwSqUo5TKdvVhNwb4
         utEgCbAvRRlf4ItT5U9cBF4MimXoArQoxjPZTrI8nuwt5hUKfbyVGp0l6m1SQGiGxREf
         WqaePutj8olQ4MKozFhUqrOwELqWr0k/pacIuxwl2Tna26bcIUFOk5+EJS6sJ2ZfpUjV
         zPsA==
X-Gm-Message-State: AOAM531BUV/8UsHzT9jv+irCssbqL9sUgl5NmMB8aAY0IxvsoKlkTGD7
        ZHSO1A8VT8GoJfsPtT/GxKosfDzstR0ua/a5
X-Google-Smtp-Source: ABdhPJwEakC2/INc2whzZH6HJ4Tjw21HR8r0Qv/gYqURv8Z1rGX738AJkQMMi/8EKYV2cRCqqQhVog==
X-Received: by 2002:a05:6602:8ce:: with SMTP id h14mr34936559ioz.177.1638842105473;
        Mon, 06 Dec 2021 17:55:05 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6db8:c9e4:6f6d:f38e])
        by smtp.gmail.com with ESMTPSA id j21sm8623639ila.6.2021.12.06.17.55.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 17:55:04 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     cphealy@gmail.com, benjamin.gaignard@collabora.com,
        hverkuil@xs4all.nl, Adam Ford <aford173@gmail.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Lucas Stach <l.stach@pengutronix.de>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [RFC V2 3/6] dt-bindings: media: nxp,imx8mq-vpu: Update the bindings for G2 support
Date:   Mon,  6 Dec 2021 19:54:42 -0600
Message-Id: <20211207015446.1250854-4-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211207015446.1250854-1-aford173@gmail.com>
References: <20211207015446.1250854-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Introducing the G2 hevc video decoder requires modifications of the bindings to allow
one node per VPU.

VPUs share one hardware control block which is provided as a phandle on
a syscon.
Each node has now one reg and one interrupt.
Add a compatible for G2 hardware block: nxp,imx8mq-vpu-g2.

To be compatible with older DT the driver is still capable to use the 'ctrl'
reg-name even if it is deprecated now.

Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
index 762be3f96ce9..eaeba4ce262a 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
@@ -15,37 +15,36 @@ description:
 
 properties:
   compatible:
-    const: nxp,imx8mq-vpu
+    oneOf:
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
+    maxItems: 1
 
   interrupt-names:
-    items:
+    oneOf:
       - const: g1
       - const: g2
 
   clocks:
-    maxItems: 3
+    maxItems: 1
 
   clock-names:
-    items:
+    oneOf:
       - const: g1
       - const: g2
-      - const: bus
 
   power-domains:
     maxItems: 1
 
+  nxp,imx8m-vpu-ctrl:
+    description: Specifies a phandle to syscon VPU hardware control block
+    $ref: "/schemas/types.yaml#/definitions/phandle"
+
 required:
   - compatible
   - reg
@@ -60,20 +59,27 @@ additionalProperties: false
 examples:
   - |
         #include <dt-bindings/clock/imx8mq-clock.h>
+        #include <dt-bindings/power/imx8mq-power.h>
         #include <dt-bindings/interrupt-controller/arm-gic.h>
 
-        vpu: video-codec@38300000 {
+        vpu_g1: video-codec@38300000 {
                 compatible = "nxp,imx8mq-vpu";
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
+                reg = <0x38300000 0x10000>;
+                reg-names "g1";
+                interrupts = <GIC_SPI 7 IRQ_TYPE_LEVEL_HIGH>;
+                interrupt-names = "g1";
+                clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
+                clock-names = "g1";
+                power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G1>;
+        };
+
+        vpu_g2: video-codec@38310000 {
+                compatible = "nxp,imx8mq-vpu-g2";
+                reg = <0x38300000 0x10000>;
+                reg-names "g2";
+                interrupts = <GIC_SPI 8 IRQ_TYPE_LEVEL_HIGH>;
+                interrupt-names = "g2";
+                clocks = <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
+                clock-names = "g2";
+                power-domains = <&vpu_blk_ctrl IMX8MQ_VPUBLK_PD_G2>;
         };
-- 
2.32.0

