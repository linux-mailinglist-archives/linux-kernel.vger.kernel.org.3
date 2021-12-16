Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87B24476FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:15:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236557AbhLPLNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:13:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236521AbhLPLNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:13:25 -0500
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 603D3C061747;
        Thu, 16 Dec 2021 03:13:24 -0800 (PST)
Received: by mail-io1-xd2c.google.com with SMTP id y16so34688693ioc.8;
        Thu, 16 Dec 2021 03:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hIJ2BXRPTEtzu/ZO8rXZU4lpHiRp6LC7zg0PG2dAKgA=;
        b=j21orvp1x1uJGdqNmShqe1kyn9caZrVG9j25F7I5+iYeqvshwZ06bRf77n665sNSEr
         2ZwH8W8aIjIRIjCpPQ+JVnN43gpGA2GVXQSgTmU0MSsBfaQaKn/lln3BPiBdeppiT+XI
         cWhlyAwOcym+uEhYnzY89OUX/W3N9oO34zZxJL/aIq614k7ZReg4fLBbFxONMDIo0/tA
         BmIMwHWiI0nR8nudaKeefj0tQbT10E+NMZfurhivu08OuyG7fh3qT2VLnM0+3EZnptvp
         779dk2HV7p+a79INg1LArV4CUb8T+v5SURyCa4QojZCSKBESow/71Fz89UcOTt1mn4Tp
         XR9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hIJ2BXRPTEtzu/ZO8rXZU4lpHiRp6LC7zg0PG2dAKgA=;
        b=4Y0tVqbUEUVvAyhpAGLnvswgajOyPEQd3ppVpR2IC1TQk2G78pINqO6uM1SaPj0wIp
         Jko982qZ0dIlApCSB1VrG2i6+kUAIV6fPWHTsi31l59ahm8Z4qjyLmeyAD5tYSf+++vI
         y6iAw7mp24z9wjUZD0/j9HFIbZSXMH+aMT8JKoRl7X5l5ZZGmC8pggQVD393qjQ5FiQc
         oLTvoJlhyDphPT04tthUWo2CXDF5QP9Q3ME1lyviIhNtF28YRm3cTVEPDNjruC6mX8Rw
         agkv7LGO6+RnZjG6Iff98d+bz0Vj273YfWWr3lRargmrJER9Q1yA5mY7RVUKsrmTXs7T
         /+2A==
X-Gm-Message-State: AOAM533tQxdUS5BJhowuuk90KQ2oIgmF5B4EiHqAkuvVXyvG1qdq5CeE
        /tODgfcm9CcTM8ciwAH83n8NM+G22rA6Fihx
X-Google-Smtp-Source: ABdhPJw4RmmjDj7+SbxpCTshhpxpOsQ5eYDEAGda/dzashZVSPmaKDpNrjhyVeIORPvbz7fpa9W/Bw==
X-Received: by 2002:a05:6602:42:: with SMTP id z2mr9035083ioz.208.1639653203369;
        Thu, 16 Dec 2021 03:13:23 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:fe22:1652:55f7:5197])
        by smtp.gmail.com with ESMTPSA id h1sm3090946iow.31.2021.12.16.03.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:13:22 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     abel.vesa@nxp.com, aford@beaconembedded.com,
        benjamin.gaignard@collabora.com, hverkuil-cisco@xs4all.nl,
        Adam Ford <aford173@gmail.com>,
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
Subject: [PATCH V2 04/10] dt-bindings: media: nxp,imx8mq-vpu: Split G1 and G2 nodes
Date:   Thu, 16 Dec 2021 05:12:49 -0600
Message-Id: <20211216111256.2362683-5-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216111256.2362683-1-aford173@gmail.com>
References: <20211216111256.2362683-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The G1 and G2 are separate decoder blocks that are enabled by the
vpu-blk-ctrl power-domain controller, which now has a proper driver.
Update the bindings to support separate nodes for the G1 and G2
decoders with vpu-blk-ctrl power-domain support.

Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
index 762be3f96ce9..c1e157251de7 100644
--- a/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
+++ b/Documentation/devicetree/bindings/media/nxp,imx8mq-vpu.yaml
@@ -15,33 +15,20 @@ description:
 
 properties:
   compatible:
-    const: nxp,imx8mq-vpu
+     oneOf:
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

