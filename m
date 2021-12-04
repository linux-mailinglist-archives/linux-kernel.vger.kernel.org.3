Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FAFA4682C7
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 07:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244279AbhLDGOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 01:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242140AbhLDGOU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 01:14:20 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14647C061751;
        Fri,  3 Dec 2021 22:10:55 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id 8so5646928qtx.5;
        Fri, 03 Dec 2021 22:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uIXLxIuMwC34QjAguBG050yUt+MXx4od/4nSlb5Y1Es=;
        b=IUV0fnXjH+J/b5a+Gm9BG+QE1RsI2H/6QL0hIuEi2jtA2xd5WWoecNNngIpLvETvmc
         CBUk66TmUvKtoc1chh6r2noNvyB8NfQ6+pBtoTreIYMeiQCbm53OCsUM/ypOg4Enm7ZK
         B/ECKZIOUbUh61cZJYXxUeUd1zZ3PdL/zkxy8DuDOeDc3gASXABP15np6Bd+RQHxoKNQ
         St7pNWRBYF0Qp69MSsh+DMFtku6T2G67WEKF6L7jCEuF5X/5kA1g6tU1B5vQTNiocbpB
         yC7bENjrd3L8FxLx9QC2zvhoFU/uyYdK/30T/B0nN4s7E3A9PAet3A83rg+H9dsNm3Ys
         yh8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uIXLxIuMwC34QjAguBG050yUt+MXx4od/4nSlb5Y1Es=;
        b=0HoXTENA+3gfrw+RPVfUOVlK0KZsSiFfL6IxBweKq41EAlOwDRNB2AzsbMFqBe3+dc
         dUZDEZwdvpyACHGD4tcnaxnO+MqnxoQcFqROeHBfF9IIPKHUMmVZsuoKD/OLfaqgjEBD
         kNO7Ce3PoSgnanJT/XPyU2LF/NRZ4eMkXHEhvQZVBKKpVYxfH5xHkvT9USZlEu1rH9+X
         dgzg79hh11Oxf+B77h/UhZi+8w1Uf4iz2JQmhT51L/2P3B3GaHZy8mFoXL3B81iIc1zt
         U0PPFgQEG27Gj2xQoeFnNIYFmRsiZjhpvhEgGSkts7yAHJkneFzn/t0ihi7bHQbS0MxZ
         L/rQ==
X-Gm-Message-State: AOAM530iJNTHdDzEeXo4N1z41jivaW+Fr0FwfL96hjtVP3VwbcyXJqvx
        LsU/6oWlPe3knqMfv7TIAeQ=
X-Google-Smtp-Source: ABdhPJwD2SVpXtEskCG7P11vgva5D+ze3xEsZ+kEWMqsTfo+qt0ZE4/shIWKS3wjRzAOBM5fmMTmAQ==
X-Received: by 2002:a05:622a:4cf:: with SMTP id q15mr26073106qtx.543.1638598254286;
        Fri, 03 Dec 2021 22:10:54 -0800 (PST)
Received: from jesse-desktop.jtp-bos.lab (146-115-144-188.s4282.c3-0.nwt-cbr1.sbo-nwt.ma.cable.rcncustomer.com. [146.115.144.188])
        by smtp.gmail.com with ESMTPSA id l1sm3500913qkp.125.2021.12.03.22.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 22:10:54 -0800 (PST)
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
        linux-serial@vger.kernel.org,
        Jesse Taube <mr.bossman075@gmail.com>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v4 06/13] dt-bindings: clock: imx: Add documentation for i.MXRT clock
Date:   Sat,  4 Dec 2021 01:10:35 -0500
Message-Id: <20211204061042.1248028-7-Mr.Bossman075@gmail.com>
X-Mailer: git-send-email 2.34.0
In-Reply-To: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
References: <20211204061042.1248028-1-Mr.Bossman075@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jesse Taube <mr.bossman075@gmail.com>

Add DT binding documentation for i.MXRT clock driver.

Cc: Giulio Benetti <giulio.benetti@benettiengineering.com>
Signed-off-by: Jesse Taube <Mr.Bossman075@gmail.com>
Reviewed-by: Rob Herring <robh@kernel.org>
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
---
 .../bindings/clock/imxrt-clock.yaml           | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/imxrt-clock.yaml

diff --git a/Documentation/devicetree/bindings/clock/imxrt-clock.yaml b/Documentation/devicetree/bindings/clock/imxrt-clock.yaml
new file mode 100644
index 000000000000..8af48c59ff99
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/imxrt-clock.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/imxrt-clock.yaml#
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
+    minItems: 1
+
+  clock-names:
+    minItems: 1
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
+    ccm@400fc000 {
+        compatible = "fsl,imxrt1050-ccm";
+        reg = <0x400fc000 0x4000>;
+        interrupts = <95>, <96>;
+        clocks = <&osc>;
+        clock-names = "osc";
+        #clock-cells = <1>;
+    };
+
+
+    lpuart1: serial@40184000 {
+        compatible = "fsl,imxrt1050-lpuart";
+        reg = <0x40184000 0x4000>;
+        interrupts = <20>;
+        clocks = <&clks IMXRT1050_CLK_LPUART1>;
+        clock-names = "ipg";
+    };
-- 
2.34.0

