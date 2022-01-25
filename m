Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5806849BA09
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 18:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383642AbiAYRQg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 12:16:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239715AbiAYRNk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 12:13:40 -0500
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55184C06175F;
        Tue, 25 Jan 2022 09:12:30 -0800 (PST)
Received: by mail-il1-x132.google.com with SMTP id i1so11406559ils.5;
        Tue, 25 Jan 2022 09:12:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kTohMKJe6b+aS5nC8tVrcxj3aKt5LtNCUkDL666J3iI=;
        b=QeCaqLi/Vdl2SNgeMJQrOfBtxIr4UZDZ4m8KOqBa5Jo25eO2GPgIXXHU7lbQxpdZZ4
         TAOo6NqJpNZ3BmR+trzJyR6/kxmGKXnTmFycHCze6HpEXCRabRXx61GrM5Hmlnrt67KR
         t15NtCQKz2Z5wxZN59dOontiWBvQTb4/jwPlxBelRKaZ0XL1Kht0x2HOKvCMBy/+OsLf
         DUQlNSgI5Hu+GY1sHd2ZY3HDPJ0BfVmXJTSZZVz0t1NY76A7uiVidaVEkqJ7jxbML0S9
         MzmVZaROeMepmwMdOD//zFDxp1NS1HLDT/RjFmkA9Jbyj2+YL+wZ5WL9slRoucfKJkHU
         lObg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kTohMKJe6b+aS5nC8tVrcxj3aKt5LtNCUkDL666J3iI=;
        b=kxxfcZuUopMVoknbLd5DgykR35i6ocqkWJTLsoTtVZy2bYA8AFTI53hv7YshdhmWKO
         cvayw3UBCgMHQOM22Gg1UdqAPRTztMWOm/d79vbUag3jc16wX6UHFIX471yDUlUGJAZG
         H+qQip4Y82T5Ugi6/CZv1GonZ7nxVWg4YxLfINjWpUPtnkNvwH94jYvKVFIhrvpmk8An
         VBpc1LUbhxxwhs0E5HS2EEa/ePSNsFyNg+cCwAboVPNzx+gu/DJQDef2QGPfnG+RrkMp
         NFbOsYpCtrdLnqQYZaOI2fIB7iGGwCT8bPJwHl0nu/yny4buhZ9LD8lGEEgTM9Eq8ZPt
         FMLA==
X-Gm-Message-State: AOAM532vFFVZw81zEcy7ZMw/tnYM5IJ5bP43r8VLbSMTpXW78oYpYdN7
        WgDH/LXBXx1GZd0b5slkV3/FjYPsch0=
X-Google-Smtp-Source: ABdhPJwMsq6K5oOSCTxFn77d9mDIztu5yGqMpSFtPQ+fssC6hzOmTp+S1h0capLNnz4toG+uZaagdg==
X-Received: by 2002:a05:6e02:19cc:: with SMTP id r12mr12812738ill.246.1643130749159;
        Tue, 25 Jan 2022 09:12:29 -0800 (PST)
Received: from aford-IdeaCentre-A730.lan ([2601:448:8400:9e8:6592:b6fe:71b1:9f4c])
        by smtp.gmail.com with ESMTPSA id m14sm8090291iov.0.2022.01.25.09.12.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 09:12:28 -0800 (PST)
From:   Adam Ford <aford173@gmail.com>
To:     linux-media@vger.kernel.org
Cc:     aford@beaconembedded.com, cphealy@gmail.com,
        Lucas Stach <l.stach@pengutronix.de>,
        Adam Ford <aford173@gmail.com>, Rob Herring <robh@kernel.org>,
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
Subject: [PATCH V4 03/11] dt-bindings: soc: add binding for i.MX8MQ VPU blk-ctrl
Date:   Tue, 25 Jan 2022 11:11:20 -0600
Message-Id: <20220125171129.472775-4-aford173@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220125171129.472775-1-aford173@gmail.com>
References: <20220125171129.472775-1-aford173@gmail.com>
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

