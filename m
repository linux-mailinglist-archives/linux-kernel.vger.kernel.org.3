Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BAD2529820
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240677AbiEQD2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbiEQD2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:28:15 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6469D3FDA8;
        Mon, 16 May 2022 20:28:14 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id s5so1660885qvo.12;
        Mon, 16 May 2022 20:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j+Q4XN3lDlb3mXxMp+NqQgx5l8SM/aLOCQMLK1x/m6M=;
        b=ewqvkD2vj/X0E+xs1VnF/6et3X9Oiq1Wu7WdlODik1+AUmKDOS+LFotV4909xHsaV6
         HOP80ServOJjox5SaT4+QAjXpxaLQjxjYIFQh0vZwGMgnqXQsyYWqgP+EZlFUYI3xdAG
         mw4zaRzlBRc18UGL9M/S3RFS9zXbg54qncFiwCP7Y8VOiV/7JTSsfhW7ZPZarYXCQZfW
         cnxNiolTKtYPJvoDxq4TlC766Ty4BP29tLptrCIydvybpL+GxzSshY1uQ3dXWR8NuHE7
         aM5IBN5N9uNqkLfXG6o7bsbK4eRH49p7IE78nulXptaiKPO6KLoGnvOs8G7YGtK/TYXS
         zQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j+Q4XN3lDlb3mXxMp+NqQgx5l8SM/aLOCQMLK1x/m6M=;
        b=qNw+sM8KPV6emV6XdLEAoAV3QVGHu+mBacUb8jPr2ZhQsNtU5gZCT3tK7l8E5oF9wQ
         2EtF9o7jNZ+/WZslGtx7VG0G8AF5VL1xNl1XDZ4DPYvZq5dZ29sZj2xsvKQ4xwa7PBM1
         s3CExz8dPZA3qTv/LKtv7bkLtbfzKB6QNiIMPMqI9PrqSGsdhGR9m4K70sS5yP3+3Mlb
         dJuMn2329rSToLBweEluWgpSTlCGCWIVCDgUS59j4VW25uY9eqfYz1anoPXA2yy9gOeG
         6Qh6Qw89KP37pJCV9JUYOo3A+r8cRudMTllVgCJMwBFUOWbbpnSxZ36YZR47FWBdThba
         32pg==
X-Gm-Message-State: AOAM532+EcZSU0vOgUoWFrAH5vceHdsrYuH2VEjiF6D2PrHJ1hHO18Xr
        aUwyVWDCbCkuxMO0gNrMNWI=
X-Google-Smtp-Source: ABdhPJyDK5rkL8eJXzhnSZxGgf5pHHsEF2OYx4jxV+AQuglwMRJT9dRzyqsdUIp/VAp9he/i6tvV+w==
X-Received: by 2002:ad4:574f:0:b0:461:df46:af7b with SMTP id q15-20020ad4574f000000b00461df46af7bmr316768qvx.53.1652758093461;
        Mon, 16 May 2022 20:28:13 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id a19-20020a376613000000b006a098381abcsm7079535qkc.114.2022.05.16.20.28.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 20:28:12 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, arnd@arndb.de, olof@lixom.net, soc@kernel.org,
        linux@armlinux.org.uk, abel.vesa@nxp.com, dev@lynxeye.de,
        marcel.ziswiler@toradex.com, tharvey@gateworks.com,
        leoyang.li@nxp.com, sebastian.reichel@collabora.com,
        cniedermaier@dh-electronics.com, Mr.Bossman075@gmail.com,
        clin@suse.com, giulio.benetti@benettiengineering.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-gpio@vger.kernel.org
Subject: [PATCH v3 07/15] dt-bindings: clock: imx: Add documentation for i.MXRT1170 clock
Date:   Mon, 16 May 2022 23:27:54 -0400
Message-Id: <20220517032802.451743-6-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
References: <20220517032802.451743-1-Mr.Bossman075@gmail.com>
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

Add DT binding documentation for i.MXRT1170 clock driver.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1 -> V2:
 - Change title to Clock Controller
 - Rename to add fsl
V2 -> V3:
 - Remove unused include causing error
---
 .../bindings/clock/fsl,imxrt1170-clock.yaml   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
new file mode 100644
index 000000000000..57881e22c400
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imxrt1170-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Freescale i.MXRT1170 Clock Controller
+
+maintainers:
+  - Giulio Benetti <giulio.benetti@benettiengineering.com>
+  - Jesse Taube <Mr.Bossman075@gmail.com>
+
+description: |
+  The clock consumer should specify the desired clock by having the clock
+  ID in its "clocks" phandle cell. See include/dt-bindings/clock/imxrt*-clock.h
+  for the full list of i.MXRT clock IDs.
+
+properties:
+  compatible:
+    const: fsl,imxrt1170-ccm
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: 32M ext osc
+      - description: 16M int rcosc
+      - description: 32k osc
+
+  clock-names:
+    items:
+      - const: osc
+      - const: rcosc16M
+      - const: osc32k
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    clks: clock-controller@40cc0000 {
+        compatible = "fsl,imxrt1170-ccm";
+        reg = <0x40cc0000 0x4000>;
+        clocks = <&osc>, <&rcosc16M>, <&osc32k>;
+        clock-names = "osc", "rcosc16M", "osc32k";
+        #clock-cells = <1>;
+    };
-- 
2.36.1

