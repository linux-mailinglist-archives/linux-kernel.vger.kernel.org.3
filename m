Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95AD24A9743
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357973AbiBDJ55 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:57:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357972AbiBDJ5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:57:52 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC6CC06173E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 01:57:52 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id d10so17731731eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 04 Feb 2022 01:57:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20210112.gappssmtp.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cyDRSsWcHEG7hFPkAKnfju7a8QtsJi/di5YQi268j44=;
        b=xmXIflvQ0olpkcLN5e8KHJFoYtAAfGC7PHDhOuUmiJd22KEzYU8EhYwgxbehJTegRs
         yjVFHYRXh8lk+GF2XqdTAkd9W81RXoVYariwKCDe+XFLoRbEn0FAviu1BxhspTNjw6wH
         M3MF2VapwlKMRwY3ul/ZFWrS+3MBE2aUbl5+4zkFO//31ldN22/DDU7QA2+kIgC7K8pF
         c9LFv/tTFYUT2GVfdzDA10VzJe2gJzh0aG6PdTnEmJxLMA+MFPQ0RZAjUhPqGzn0aSjP
         +uknDtqAHHMrCWn7WeZT0VxIhTi5j29/3i9ckxLyTpxVEZ3axzhsmSDBePlvaXC6D21e
         YpcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=cyDRSsWcHEG7hFPkAKnfju7a8QtsJi/di5YQi268j44=;
        b=2dslfz5kARs8/Eds+4zFEIR5foWg8ZZbj9vb9dWoLp7b0CUaPX3bIbQQSQALu4HVsA
         ZCOxEcI76ifj0DnOkAR1f8yxgUy0Y+3xX1vJquvbpwIS8HIKR2AuZqKVL+F2jAw5DyCJ
         ha9elyPOdwMbKazccv4kZq+Mea428QIg+88K1HLEPyk+GbIlnovYtgc9d1pOjmjkjXDS
         7zVSAT6BjU1/PRDJ2OYlrmwubwYj5yZ1czzehNbC6RVCdvKlR/mxH7Ka39+Ez2PaL271
         Ha609IAyji/Vw85/XLlyI/veOGzuKIXYGkkbmImLND3eyDurWItYh6xKX+ayi511Zz8Q
         m+MA==
X-Gm-Message-State: AOAM532HEnnWgM07Uk26zssMvxAHgIolHjWz4j2L+iFCdps6jb48/1S2
        27/ksh1QNbA6kCHgGdmuzRWLBe/YAu0giA==
X-Google-Smtp-Source: ABdhPJx9J4fURkkOGQKp5zlDmFPGwUa3axz6IJqXqoY80p+/4AgfrVw/BzxQOcXOMqOSbCg9VenOtQ==
X-Received: by 2002:a17:906:7306:: with SMTP id di6mr1725645ejc.521.1643968670333;
        Fri, 04 Feb 2022 01:57:50 -0800 (PST)
Received: from localhost ([2a02:768:2307:40d6::f9e])
        by smtp.gmail.com with ESMTPSA id k23sm485989ejr.65.2022.02.04.01.57.49
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 04 Feb 2022 01:57:49 -0800 (PST)
Sender: Michal Simek <monstr@monstr.eu>
From:   Michal Simek <michal.simek@xilinx.com>
To:     linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com
Cc:     Alex Helms <alexander.helms.jy@renesas.com>,
        Rob Herring <robh@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        David Cater <david.cater.jc@renesas.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v9 1/2] dt-bindings: Add binding for Renesas 8T49N241
Date:   Fri,  4 Feb 2022 10:57:38 +0100
Message-Id: <833d3837892f0879233695636291af97a746e584.1643968653.git.michal.simek@xilinx.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <cover.1643968653.git.michal.simek@xilinx.com>
References: <cover.1643968653.git.michal.simek@xilinx.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alex Helms <alexander.helms.jy@renesas.com>

Renesas 8T49N241 has 4 outputs, 1 integral and 3 fractional dividers.
The 8T49N241 accepts up to two differential or single-ended input clocks
and a fundamental-mode crystal input. The internal PLL can lock to either
of the input reference clocks or to the crystal to behave as a frequency
synthesizer.

Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
Reviewed-by: Rob Herring <robh@kernel.org>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Michal Simek <michal.simek@xilinx.com>
---

(no changes since v1)

 .../bindings/clock/renesas,8t49n241.yaml      | 190 ++++++++++++++++++
 MAINTAINERS                                   |   6 +
 2 files changed, 196 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/renesas,8t49n241.yaml

diff --git a/Documentation/devicetree/bindings/clock/renesas,8t49n241.yaml b/Documentation/devicetree/bindings/clock/renesas,8t49n241.yaml
new file mode 100644
index 000000000000..42af3b05fcef
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/renesas,8t49n241.yaml
@@ -0,0 +1,190 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/renesas,8t49n241.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Binding for Renesas 8T49N241 Universal Frequency Translator
+
+description: |
+  The 8T49N241 has one fractional-feedback PLL that can be used as a
+  jitter attenuator and frequency translator. It is equipped with one
+  integer and three fractional output dividers, allowing the generation
+  of up to four different output frequencies, ranging from 8kHz to 1GHz.
+  These frequencies are completely independent of each other, the input
+  reference frequencies and the crystal reference frequency. The device
+  places virtually no constraints on input to output frequency conversion,
+  supporting all FEC rates, including the new revision of ITU-T
+  Recommendation G.709 (2009), most with 0ppm conversion error.
+  The outputs may select among LVPECL, LVDS, HCSL or LVCMOS output levels.
+
+  The driver can read a full register map from the DT, and will use that
+  register map to initialize the attached part (via I2C) when the system
+  boots. Any configuration not supported by the common clock framework
+  must be done via the full register map, including optimized settings.
+
+  The 8T49N241 accepts up to two differential or single-ended input clocks
+  and a fundamental-mode crystal input. The internal PLL can lock to either
+  of the input reference clocks or just to the crystal to behave as a
+  frequency synthesizer. The PLL can use the second input for redundant
+  backup of the primary input reference, but in this case, both input clock
+  references must be related in frequency.
+
+  All outputs are currently assumed to be LVDS, unless overridden in the
+  full register map in the DT.
+
+maintainers:
+  - Alex Helms <alexander.helms.jy@renesas.com>
+  - David Cater <david.cater.jc@renesas.com>
+
+properties:
+  compatible:
+    enum:
+      - renesas,8t49n241
+
+  reg:
+    description: I2C device address
+    maxItems: 1
+
+  '#clock-cells':
+    const: 1
+
+  clock-names:
+    minItems: 1
+    maxItems: 3
+    items:
+      enum: [ xtal, clk0, clk1 ]
+
+  clocks:
+    minItems: 1
+    maxItems: 3
+
+  renesas,settings:
+    description: Optional, complete register map of the device.
+      Optimized settings for the device must be provided in full
+      and are written during initialization.
+    $ref: /schemas/types.yaml#/definitions/uint8-array
+    minItems: 791
+    maxItems: 791
+
+required:
+  - compatible
+  - reg
+  - '#clock-cells'
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    /* 25MHz reference clock */
+    clk0: clk0 {
+      compatible = "fixed-clock";
+      #clock-cells = <0>;
+      clock-frequency = <25000000>;
+    };
+
+    i2c@0 {
+        reg = <0x0 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        renesas8t49n241_1: clock-generator@6c {
+            compatible = "renesas,8t49n241";
+            reg = <0x6c>;
+            #clock-cells = <1>;
+
+            clocks = <&clk0>;
+            clock-names = "clk0";
+        };
+    };
+
+    /* Consumer referencing the 8T49N241 Q1 */
+    consumer {
+        /* ... */
+        clocks = <&renesas8t49n241_1 1>;
+        /* ... */
+    };
+  - |
+    /* 40MHz crystal */
+    xtal: xtal {
+      compatible = "fixed-clock";
+      #clock-cells = <0>;
+      clock-frequency = <40000000>;
+    };
+
+    i2c@0 {
+        reg = <0x0 0x100>;
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        renesas8t49n241_2: clock-generator@6c {
+            compatible = "renesas,8t49n241";
+            reg = <0x6c>;
+            #clock-cells = <1>;
+
+            clocks = <&xtal>;
+            clock-names = "xtal";
+
+            renesas,settings = [
+                09 50 00 60 67 C5 6C FF 03 00 30 00 00 01 00 00
+                01 07 00 00 07 00 00 77 6D 06 00 00 00 00 00 FF
+                FF FF FF 00 3F 00 2A 00 16 33 33 00 01 00 00 D0
+                00 00 00 00 00 00 00 00 00 04 00 00 00 02 00 00
+                00 00 00 00 00 00 00 17 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 D7 0A 2B 20 00 00 00 0B
+                00 00 00 00 00 00 00 00 00 00 27 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                C3 00 08 01 00 00 00 00 00 00 00 00 00 30 00 00
+                00 0A 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
+                00 00 00 00 85 00 00 9C 01 D4 02 71 07 00 00 00
+                00 83 00 10 02 08 8C
+            ];
+        };
+    };
+
+    /* Consumer referencing the 8T49N241 Q1 */
+    consumer {
+        /* ... */
+        clocks = <&renesas8t49n241_2 1>;
+        /* ... */
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index ea3e6c914384..a69c45dcbc23 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16425,6 +16425,12 @@ L:	linux-remoteproc@vger.kernel.org
 S:	Maintained
 F:	drivers/net/wwan/rpmsg_wwan_ctrl.c
 
+RENESAS 8T49N24X DRIVER
+M:	Alex Helms <alexander.helms.jy@renesas.com>
+M:	David Cater <david.cater.jc@renesas.com>
+S:	Odd Fixes
+F:	Documentation/devicetree/bindings/clock/renesas,8t49n241.yaml
+
 RENESAS CLOCK DRIVERS
 M:	Geert Uytterhoeven <geert+renesas@glider.be>
 L:	linux-renesas-soc@vger.kernel.org
-- 
2.35.0

