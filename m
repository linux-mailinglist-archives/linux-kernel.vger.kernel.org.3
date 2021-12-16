Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9690C476FA2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 12:14:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230416AbhLPLN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 06:13:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236486AbhLPLNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 06:13:19 -0500
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F167C06173E;
        Thu, 16 Dec 2021 03:13:19 -0800 (PST)
Received: by mail-io1-xd33.google.com with SMTP id z18so34662991iof.5;
        Thu, 16 Dec 2021 03:13:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OBZjeCPmHnZFjVhdtwcLx3XOD2NbI/pF57Ruee40Yio=;
        b=jpubRIei533qi1bG5g2e+TA27Ch+HggU3c7HH8qd+qRcNjvc81BndoRRaTbKhzXs2H
         3IJu3D6x/bQ4pbY6NF3RSGC6V1mix9bqGMjZ8YHsvWFTDumDVWxc3lmpLJ6+DziiU498
         ZG8UgRikzS6df/qYaOhVx7YB+R+h58ECqO2Gj8EK+Rl42h+HeID+1jPfc9svStzBzmB2
         80e1tkNd8zNkEUzcVnOZ8sB7FWAIVraH2DM472FnMLiyzuz3IC+rqszktQSi5+9LXIVH
         lJKW5tVrC8VSBYiRq5GcMRiyk9GmPZfTonlpIp+/+HkPByww+xCIoN3UiiqkjEelppB0
         5oCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OBZjeCPmHnZFjVhdtwcLx3XOD2NbI/pF57Ruee40Yio=;
        b=BkUT7zaM1GD55bVfhRA4TwI2voaARPyTRFbqP5oymQ4pn/aLuvclygGeEdrDG9cURr
         CLnPwQAz+DuESQxD7vUMHhN1neA8oBvt3LsfCZZSU8EBJGhvLpwGMyuo7CaOSCpqQryL
         1IHnOzWZSeGwga1u9SFV8dzcG7DYthQEQf0mM6aVjfheoEIz/kE8U6LS9lk9hMQl9ioJ
         YL+gZZCQz6sltsBe5qqI8vpxvAX5AlsRSvK7Q2dtnWRYFdA0eo5dSMof9yY9wdNx8Czk
         Sz+BewC+z1kwpsHttiEU/6RCwebRhB5+XrsmI94Z+FKiq6jdiS5sJU8gEIz9/G5vk74C
         Rk8A==
X-Gm-Message-State: AOAM531zOVSmk3MF3cHiDpjX3xEVSIEp3BTka4rfdo1sC/IgW5wB/mz/
        tuQ6Cj07I/jhQMMbgZR/8hsUEHeFxS6VuGWo
X-Google-Smtp-Source: ABdhPJwG3RjzIgyAH51KSKIWg4qsgdyIxuRhaKeR9db6RyIEG/6N0qrxBROgwed2usJt5U7DhzTIqg==
X-Received: by 2002:a05:6638:2191:: with SMTP id s17mr8985470jaj.67.1639653198144;
        Thu, 16 Dec 2021 03:13:18 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:fe22:1652:55f7:5197])
        by smtp.gmail.com with ESMTPSA id h1sm3090946iow.31.2021.12.16.03.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 03:13:17 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     abel.vesa@nxp.com, aford@beaconembedded.com,
        benjamin.gaignard@collabora.com, hverkuil-cisco@xs4all.nl,
        Lucas Stach <l.stach@pengutronix.de>,
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
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev
Subject: [PATCH V2 02/10] dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
Date:   Thu, 16 Dec 2021 05:12:47 -0600
Message-Id: <20211216111256.2362683-3-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211216111256.2362683-1-aford173@gmail.com>
References: <20211216111256.2362683-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the DT binding for the i.MX8MQ VPU blk-ctrl.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
new file mode 100644
index 000000000000..7263ebedf09f
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
@@ -0,0 +1,71 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP i.MX8MQ VPU blk-ctrl
+
+maintainers:
+  - Lucas Stach <l.stach@pengutronix.de>
+
+description:
+  The i.MX8MQ VPU blk-ctrl is a top-level peripheral providing access to
+  the NoC and ensuring proper power sequencing of the VPU peripherals
+  located in the VPU domain of the SoC.
+
+properties:
+  compatible:
+    items:
+      - const: fsl,imx8mq-vpu-blk-ctrl
+
+  reg:
+    maxItems: 1
+
+  '#power-domain-cells':
+    const: 1
+
+  power-domains:
+    minItems: 3
+    maxItems: 3
+
+  power-domain-names:
+    items:
+      - const: bus
+      - const: g1
+      - const: g2
+
+  clocks:
+    minItems: 2
+    maxItems: 2
+
+  clock-names:
+    items:
+      - const: g1
+      - const: g2
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
+    #include <dt-bindings/clock/imx8mq-clock.h>
+    #include <dt-bindings/power/imx8mq-power.h>
+
+    vpu_blk_ctrl: blk-ctrl@38320000 {
+      compatible = "fsl,imx8mq-vpu-blk-ctrl";
+      reg = <0x38320000 0x100>;
+      power-domains = <&pgc_vpu>, <&pgc_vpu>, <&pgc_vpu>;
+      power-domain-names = "bus", "g1", "g2";
+      clocks = <&clk IMX8MQ_CLK_VPU_G1_ROOT>,
+               <&clk IMX8MQ_CLK_VPU_G2_ROOT>;
+      clock-names = "g1", "g2";
+      #power-domain-cells = <1>;
+    };
-- 
2.32.0

