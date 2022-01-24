Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75EC9497764
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 03:32:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240863AbiAXCbl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Jan 2022 21:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240829AbiAXCbh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Jan 2022 21:31:37 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5EF6C06173B;
        Sun, 23 Jan 2022 18:31:36 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id i14so12607290ila.11;
        Sun, 23 Jan 2022 18:31:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTohMKJe6b+aS5nC8tVrcxj3aKt5LtNCUkDL666J3iI=;
        b=DWdz2Gmn/OxlLt+ZL3Oi79/aoh+vlkt8+Jy/lctVQYoiWxNUZVZgRQ1MzfGAwHR01d
         1vTFgTpTD5R0T5DwAZCKE1mqsqt75iKULaU8zzqEkFHVWLtebsS7aen2+BnIb17JAe98
         4Nn2m8HAs5Wwe4YoxBbl7XRkR4tPeMVziMTFjrU34ltHkEWbtxG3jtRki+FV/K/b+q1A
         v5RhWOHB3HWHQHl25g/+C8kjNeE8500H8facI6VdLXbhz1KK1qkKZrVCDm/BHGjnWgsq
         /Hb0+f7xh5L06bhlsUdxSGlxmHRnVlEN9PSgz5Xo8IsbxEwa7bsguC9O9rfGhgxrBo6W
         xhWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTohMKJe6b+aS5nC8tVrcxj3aKt5LtNCUkDL666J3iI=;
        b=TLERUditO4OcqEOEBcf7PQCEnly+G0E2RIo7YFTKSwrniKcjl1zvfz666gpb+SrSlN
         zaerPDgLnudF0HwZ5LcsP9iMea4fj/MVTqGP7G7wnrZFvIPSbgaxn8TA1tMxaxnV9uGN
         5ylBE6Xz8unZi7D4Fw744gNSAOPThfbmHL0cozM+R9kgs4sw2OZL0F7KDQHNEoieBbZr
         VfasuxeXiwMBrs5S2/ER6xaZIRBHNOxtjpDTsA5HdVEvEvr2XYjADiKj95LXcCb5ld7s
         /H8BzTGySCnPJK0g2+CRPXLFvGhz6cJecgcvZysvOM8n8WLlksrBe6V12p13jfpztqZO
         FKhA==
X-Gm-Message-State: AOAM532aKTvMQJ5IUuTXb0BaDsWHzdvdaVl+wNRiJEQivuQhztbuFLyT
        Y/Q1MQJZrQX1jGk4xS5eHvtIuTdkMVs=
X-Google-Smtp-Source: ABdhPJzPT49xUHz+xvWATznYNwatDlpwDx1OQe+zH/Ir71zoyVxxIeEn1SMa80s7DZKRrXLs4pI2Qg==
X-Received: by 2002:a92:cda7:: with SMTP id g7mr7475640ild.53.1642991495924;
        Sun, 23 Jan 2022 18:31:35 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:582d:ad0e:e5a6:94b6])
        by smtp.gmail.com with ESMTPSA id w4sm6625633ilq.56.2022.01.23.18.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 18:31:35 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, shawnguo@kernel.org,
        aford@beaconembedded.com, Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH V3 02/10] dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
Date:   Sun, 23 Jan 2022 20:31:16 -0600
Message-Id: <20220124023125.414794-3-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220124023125.414794-1-aford173@gmail.com>
References: <20220124023125.414794-1-aford173@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lucas Stach <l.stach@pengutronix.de>

This adds the DT binding for the i.MX8MQ VPU blk-ctrl.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Signed-off-by: Adam Ford <aford173@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>

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

