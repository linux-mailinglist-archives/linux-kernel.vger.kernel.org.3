Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42746513DF8
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 23:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352538AbiD1VwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Apr 2022 17:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352502AbiD1VwM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Apr 2022 17:52:12 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D165BC3E0A;
        Thu, 28 Apr 2022 14:48:53 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id 1so4159594qvs.8;
        Thu, 28 Apr 2022 14:48:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Gn7ITOapzCSzC+UQtM9UH81e8sishwGd1JBZzz5dmQ0=;
        b=QI2TXltuvtMXE9cecftYJaV4Si7Yl+BLHTKNw9x6DaB8Nf1eSsA2VrBHCpiFU0fSyb
         3BBW5az7wDYeIIfVcnvEl/bPeMQu9V2/qdMMjAfJfzAM9P7/EYQAPPKPOyINz0cBztVL
         m3++hDriXgeyuWH2M+KpqSUOaMFQiff3K5DGY8LMaRygbz/o3ZeqITM9k2b/9olhyuQn
         F+UDp6PMpcLJiL0P7pLpQJ7qkpCba/l0pbeMngAWMDiCJ/SKngFgRWfmKWiUukg3Igrt
         SUXxixSCqbClWXUFIeGO+wHGhTXavhOoe0l7NoMSqX1gIXn+C3MgxV5EzlwUOQoFebCo
         LDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Gn7ITOapzCSzC+UQtM9UH81e8sishwGd1JBZzz5dmQ0=;
        b=ceFx4kUMxT+Dkt+j643fk6stsO94vNUde/TrvhmKqwiRhyW0xxZp2IYqdwyY34lltq
         aVcZaILe6jowv5FWc2QvchRZCNFk9YkOg57Kv0VwsZx/UxyyrOEg6Eh+0W2VKP1r8g6m
         K7cfz2I50C8ECKkT+DLO1k+ZBs80vYvYzNYdxq5N0lxsYNenIqOS1OUpIRMMBqe4wRZh
         LDu/SbErMFmifwS6EmUTY0XVQEkC2e+qv3BpR7egVSLJTKumG6n1tXEzC51VaMR+p2xk
         cJdq7jmnoqhUwoVuL34F0ia/XhCtDLLApdIBOmLQ0rn0N0BMS4lB/uGCWEhwgugWGm0u
         bqiw==
X-Gm-Message-State: AOAM531uo7/jJO9UzpcDE4ZYMef9zMXoG39ViqW/Xtek80yF9Kb5jPPO
        lgrdUKMjuq1W+KMxdPYLZEg=
X-Google-Smtp-Source: ABdhPJwEdti+wpPjI/D1brW1LYLvBuG5CvGZfc48iyfzoDbNOlsVLdU+j5YjI9EqNPBdH8VTpxonEw==
X-Received: by 2002:ad4:4eea:0:b0:446:62c2:4e88 with SMTP id dv10-20020ad44eea000000b0044662c24e88mr26448288qvb.116.1651182532499;
        Thu, 28 Apr 2022 14:48:52 -0700 (PDT)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id bl5-20020a05620a1a8500b0069f51e47c5esm546442qkb.110.2022.04.28.14.48.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Apr 2022 14:48:52 -0700 (PDT)
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
Subject: [PATCH v2 07/15] dt-bindings: clock: imx: Add documentation for i.MXRT1170 clock
Date:   Thu, 28 Apr 2022 17:48:30 -0400
Message-Id: <20220428214838.1040278-8-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
References: <20220428214838.1040278-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
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
---
 .../bindings/clock/fsl,imxrt1170-clock.yaml   | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml b/Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
new file mode 100644
index 000000000000..a092ac0f7a50
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/fsl,imxrt1170-clock.yaml
@@ -0,0 +1,59 @@
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
+    #include <dt-bindings/clock/imxrt1170-clock.h>
+
+    clks: clock-controller@40cc0000 {
+        compatible = "fsl,imxrt1170-ccm";
+        reg = <0x40cc0000 0x4000>;
+        clocks = <&osc>, <&rcosc16M>, <&osc32k>;
+        clock-names = "osc", "rcosc16M", "osc32k";
+        #clock-cells = <1>;
+    };
-- 
2.35.1

