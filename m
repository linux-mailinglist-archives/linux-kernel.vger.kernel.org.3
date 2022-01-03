Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BB26483932
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 00:40:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiACXkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 18:40:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbiACXkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 18:40:00 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 966B8C061761;
        Mon,  3 Jan 2022 15:39:59 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id h5so32697817qvh.8;
        Mon, 03 Jan 2022 15:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J9XtswLznY8/PDWy9Q49U0lzb9uDsaGNnebX2qgsJVs=;
        b=B+LE8bvv1HdjVsmngH+MZr3wOZOo/J9KiuBh8uB6IFB/IOgRCVqIVvBJ8ZAdvrw/q0
         XdbMTKpFEwsTwC9jAQEUpBDfUTAmvd1c0WvXN8bZLwmFdMja3WHsJylaB1GiYAV0v11y
         45eoKmzaLOXAURl7r+gEUXnKGxBFApECPTVE0oIV16ChR65qXRKjlTOs5FpedNQ2duVK
         i0Sbf7Y8iME0rbsn5sq5cj8BhElEOeMrHu3HS0Ix7dovSRvrWd26IcJ2fC+I+N8WAWtn
         9Kvp+Mmt4BlJYl1viBImiJoKNvaMk3Vx2h5ztScJffblZcOecdGjrEe5myII848w+UpF
         0v7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J9XtswLznY8/PDWy9Q49U0lzb9uDsaGNnebX2qgsJVs=;
        b=7DaZeaGMuAPzFBMhX0+3rv84B9ZuvU3sX+CS/d47HlwCYKLmd5nmp3GHpFrizloTTM
         SxgMLo24IYobbZ8CWyrdh8MmTL00hWCJC66RXVWZw1or8QS8uxyNcDMWA5vouUEHNtTH
         I7PpqHQKGWvQLCZC1hSPzeROQA2VnXssTFpH3wxveNnnOXAapEqtpO8pBEjJTzhkECG4
         zI0q11ZjNWXASGUuwLa1jNzrfwFHn2/qVQIj7j1nV2cUBtlLrz8Mmi2MFXiuV6WiY6G5
         KZZWVytBfxNgMd6pDsqlP19CuzFztDeXnWc9GEHJUVMSoiLOK/vN1NUmDNoJPyUBe41V
         BfnA==
X-Gm-Message-State: AOAM532dr4O+wGDMuPNabus8q5sC+v88/7tcfwWByoYzFazEk2g5z8ZC
        gRFgxN2purWPgmWtCuVkfOY=
X-Google-Smtp-Source: ABdhPJzjQyZp+NAUW781RrdsRo4Nr7N/Dfi7gO7b/ChLSXaqxav3Q/zECWt3eKyqY0ooyA1Y63+fYA==
X-Received: by 2002:a05:6214:2302:: with SMTP id gc2mr6668867qvb.126.1641253198735;
        Mon, 03 Jan 2022 15:39:58 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id o5sm26965991qkp.132.2022.01.03.15.39.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 15:39:58 -0800 (PST)
From:   Jesse Taube <mr.bossman075@gmail.com>
X-Google-Original-From: Jesse Taube <Mr.Bossman075@gmail.com>
To:     linux-imx@nxp.com
Cc:     mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com, ulf.hansson@linaro.org, aisheng.dong@nxp.com,
        stefan@agner.ch, linus.walleij@linaro.org,
        gregkh@linuxfoundation.org, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, linux@armlinux.org.uk, abel.vesa@nxp.com,
        adrian.hunter@intel.com, jirislaby@kernel.org,
        giulio.benetti@benettiengineering.com,
        nobuhiro1.iwamatsu@toshiba.co.jp, Mr.Bossman075@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-serial@vger.kernel.org, Jesse Taube <mr.bossman075@gmail.com>
Subject: [PATCH v7 4/7] dt-bindings: clock: imx: Add documentation for i.MXRT1050 clock
Date:   Mon,  3 Jan 2022 18:39:45 -0500
Message-Id: <20220103233948.198119-5-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
References: <20220103233948.198119-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Taube <mr.bossman075@gmail.com>

Add DT binding documentation for i.MXRT1050 clock driver.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
---
V1->V2:
* Replace macros with values
V2->V3:
* Remove anatop
* Use lpuart not gpt
* include imxrt1050-clock.h
* 2 space tabs to 4
* Remove oneOf enum
* Change maxItems to 2
V3->V4:
* Nothing done
V4->V5:
* Remove extra newline
* Rename ccm to clock-controller
* Change minItems to const
* Change minItems to description
* Rename file to add 1050
* Change commit description to just 1050
V5->V6:
* Add maxItems for clocks description
V6->V7:
* Nothing done
---
 .../bindings/clock/imxrt1050-clock.yaml       | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml b/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
new file mode 100644
index 000000000000..35fd08c143f4
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imxrt1050-clock.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imxrt1050-clock.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Clock bindings for Freescale i.MXRT
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
+    const: fsl,imxrt1050-ccm
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 2
+
+  clocks:
+    description: 24m osc
+    maxItems: 1
+
+  clock-names:
+    const: osc
+
+  '#clock-cells':
+    const: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+  - '#clock-cells'
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/imxrt1050-clock.h>
+
+    clks: clock-controller@400fc000 {
+        compatible = "fsl,imxrt1050-ccm";
+        reg = <0x400fc000 0x4000>;
+        interrupts = <95>, <96>;
+        clocks = <&osc>;
+        clock-names = "osc";
+        #clock-cells = <1>;
+    };
+
+    lpuart1: serial@40184000 {
+        compatible = "fsl,imxrt1050-lpuart";
+        reg = <0x40184000 0x4000>;
+        interrupts = <20>;
+        clocks = <&clks IMXRT1050_CLK_LPUART1>;
+        clock-names = "ipg";
+    };
-- 
2.34.1

