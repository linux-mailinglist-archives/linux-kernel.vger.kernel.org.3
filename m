Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3F4E468CA4
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 19:17:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237254AbhLESUS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 13:20:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237133AbhLESUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 13:20:07 -0500
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FF33C061714;
        Sun,  5 Dec 2021 10:16:40 -0800 (PST)
Received: by mail-io1-xd2b.google.com with SMTP id m9so10467645iop.0;
        Sun, 05 Dec 2021 10:16:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tWudG/7p9Ihv/RchD2aqdeBvOMPxR3CBPXRYkrOCQIc=;
        b=Rta/hbYaQyn4KIRTC5NZcb5EmJDBuP6DlcpgmudYGUBaIaREtTQBqKrTNTn9EdCscp
         RfL3YWIiXlrjpuXAUBtJ8we2gJw3n++XYvGM5hTmZNX0svu1uFiz0aWSSOM/MdiYja4U
         nnMXsutHRNwAmklhoAjvPca1pY/f0crCHzG11+d8nVKy8yJFwczULj3qVVsmm143wxyb
         mIoXFuWvHVfVcXERBth0LxuPg+Skx0Oz2GIpNIBrHyaxIjK0LIvdRbvaeh+i7P1nzF0x
         xXRjG6mLrwk+nZUH3jVP8uwqCWDPSVDumz5a8LSdUQBPmZkvbfMwKQIBWOVzfKBuvfcB
         fIWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tWudG/7p9Ihv/RchD2aqdeBvOMPxR3CBPXRYkrOCQIc=;
        b=a9yBETayUhROMTZVbz+jZWnB6YqQ4W/o95JMHpcVHN4u2kA2FHI9x3JTMLcVv19UKw
         vVBGcq3lZ5g6o8ZAK3Ce+QewscjxzSBopSHAzRNYehZiUKSHK9uBBPRnmKd0QU4xUPpy
         xgFwZk5GsN4jGG22YUaX9I47xK0omzUYPtZN24NbrZvmFLfqgBJCfodCYp5rRYeo0Q/C
         DPB55O42vViVz6DX5Y6qf0i8+d9pB4rjlHT6q4KBJqUeSnq7d4htIJPI+zawrRJASHcv
         mmjmtG+NqPCf+Hfgu6S11yEHNon/eIrWJF1+hSJXUkBdIsUTPy3bMOejmge+segB7DwP
         MoXw==
X-Gm-Message-State: AOAM533Y7if7nWoXZmqtm1/or0EGMYNKou5q1n3zbLLhANcY/ZT1UsQh
        K4vjl9xOXv1tI+GzX907dMe7j9tTchxOHw==
X-Google-Smtp-Source: ABdhPJz76yYAqHOJ31ePlq8l+eSKZz2b7PQOgx+R+/rE+pERvqgyrdRgmvhM0sqqeHT5SBKrzvSo3A==
X-Received: by 2002:a05:6638:2bb:: with SMTP id d27mr39777646jaq.66.1638728199307;
        Sun, 05 Dec 2021 10:16:39 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:9ea0:bb99:b16a:6159])
        by smtp.gmail.com with ESMTPSA id z12sm5808164ilu.27.2021.12.05.10.16.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 10:16:38 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     benjamin.gaignard@collabora.com, cphealy@gmail.com,
        nicolas@ndufresne.ca, Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org,
        linux-staging@lists.linux.dev
Subject: [RFC 2/5] dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
Date:   Sun,  5 Dec 2021 12:16:15 -0600
Message-Id: <20211205181618.1041699-3-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20211205181618.1041699-1-aford173@gmail.com>
References: <20211205181618.1041699-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the DT binding for the i.MX8MQ VPU blk-ctrl.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
---
 .../soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml      | 71 +++++++++++++++++++
 1 file changed, 71 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml

diff --git a/Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml b/Documentation/devicetree/bindings/soc/imx/fsl,imx8mq-vpu-blk-ctrl.yaml
new file mode 100644
index 000000000000..b8cfad0d7a1e
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
+      compatible = "fsl,imx8mq-vpu-blk-ctrl", "syscon";
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

