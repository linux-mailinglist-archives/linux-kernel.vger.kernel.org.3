Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CE355AFB7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 08:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234060AbiFZGpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 02:45:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233984AbiFZGpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 02:45:40 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA9512D32;
        Sat, 25 Jun 2022 23:45:40 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id 89so10751979qvc.0;
        Sat, 25 Jun 2022 23:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=DH9TZJfh8HC/nBAniL+53P7EujTly4gU1fuprgwlesA=;
        b=fG2PsWsmZSbEOhHVcevm4G7WRzBK92EE9yEDp0UEOiq7LvuqC+AB17sqGwy1sN/Sv7
         QaCENapjXwO9vAeH9kq1xHw4EDkUJEgoNlD2ufVj10IUrGB1xtSVKljZlC2MkRmIRbp6
         GeQ3KqPiAM/SfcnqGHRSkgcX1WldbU/EmObHw6bm4lpKDXLjWA3fXC0qQgj6dl231m61
         BIzf3bQV6cIXzey7jmypDMJXg5Rtq6UgFpEnVXlG2GomOIhQG5UV4eKZ/YCrp1Z1WqBu
         bbLi+HxTHXzPBLZN2J5WXl9PHf2WmfFY+nHFLqbDcrDKkrfqbqO8yc8brzZL688e+xy8
         LQkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=DH9TZJfh8HC/nBAniL+53P7EujTly4gU1fuprgwlesA=;
        b=X1uNhRAywG/VEgMw+Wy9Cd9pGtr16safJZWs2ZnAUWD1fwsCGhNecDR14Pfc5598GW
         bwHTj/0yoJIwF9sZSDkkmA3XY5YVqXMh7LEGqseKMIfrajVJuM/mWIMaSdo3PnTlKCiN
         wb8HUM1l9e8S97Atie6N3ObKUOgzq64l7wHYAJJCSnEZnG0UpR4FtjIF2HtMdFBqkaMm
         Yn6/qjT+u8PGNtj7gMjo838f0M6TUl5ovMXIYhr1lTxB5p3t2MLLF0ArSW68A500t7m0
         skD2hWEBWcI9/UcgoEl2J42220tJDgJUAbej5KImOsLOlCGj4cx3Yd+1NfmezNIj7iv9
         3WNQ==
X-Gm-Message-State: AJIora8ns5cFO7Q7LjmKk9oND3c9x+/Ws+HTT7ssj16HQoQ0iGwVfsM/
        vxJcw2Ex7+gMtJgYFwSm1ks=
X-Google-Smtp-Source: AGRyM1tSBgjIOxLj5ecMN0YYD0EU5QftkEzeR5hOoevQZmvzQ8Vl8KiOcqhMdYumEVuRriIjoU4Vpw==
X-Received: by 2002:a05:622a:1ba5:b0:317:c65b:3ad1 with SMTP id bp37-20020a05622a1ba500b00317c65b3ad1mr5117051qtb.117.1656225939284;
        Sat, 25 Jun 2022 23:45:39 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id w15-20020a05620a424f00b006a76a939dbasm5914620qko.112.2022.06.25.23.45.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 23:45:38 -0700 (PDT)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     robh+dt@kernel.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, aisheng.dong@nxp.com, stefan@agner.ch,
        linus.walleij@linaro.org, daniel.lezcano@linaro.org,
        tglx@linutronix.de, olof@lixom.net, linux@armlinux.org.uk,
        abel.vesa@nxp.com, dev@lynxeye.de, marcel.ziswiler@toradex.com,
        tharvey@gateworks.com, leoyang.li@nxp.com,
        sebastian.reichel@collabora.com, cniedermaier@dh-electronics.com,
        Mr.Bossman075@gmail.com, clin@suse.com,
        giulio.benetti@benettiengineering.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org
Subject: [PATCH v4 06/13] dt-bindings: clock: imx: Add documentation for i.MXRT1170 clock
Date:   Sun, 26 Jun 2022 02:45:16 -0400
Message-Id: <20220626064523.3683775-7-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
References: <20220626064523.3683775-1-Mr.Bossman075@gmail.com>
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
V3 -> V4:
 - Add fsl to schema id
---
 .../bindings/clock/fsl,imxrt1170-clock.yaml   | 57 +++++++++++++++++++
 1 file changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
new file mode 100644
index 000000000000..cb768b7ae6d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
@@ -0,0 +1,57 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/fsl,imxrt1170-clock.yaml#
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

