Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8926A56A8C5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 19:00:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236390AbiGGQ7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236319AbiGGQ71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:59:27 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 885B7140FD;
        Thu,  7 Jul 2022 09:59:26 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d10so6811082pfd.9;
        Thu, 07 Jul 2022 09:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eliIMioWidh5kLoAeqiqdJgwE4VwB0SBXU+BPYgusfQ=;
        b=plTFrtGtsJhhrfsS4lGaEY3+HCBiOH4su3Nkg7Zatn5j++2C5fjFSExy7+osqHb5Os
         GtFtevptBdPRU+VR07vfNGoRvB/3+yawdTtGbBSr2ZFY9sGlqXl6NvBAS+15ouuW4Afl
         U0/QvQBRe5WqiJ5SwVeEzERmGLy4X/PdLgV2dIIj0WiRLfiPrWKd0mMVbUG6TBVDaXIC
         WqEfENy8pfGKEQ7vwwpcEyYtAftG1dGnVEmDknMgtJoBX/k0QfItXSexjn4PIz4igXxQ
         vNY376sfBlguYevgagS1iIGGat3YlObwzuf6ZzVrG6e6Ew8cGE53l2AGNPG2Nj5NPLGF
         e17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eliIMioWidh5kLoAeqiqdJgwE4VwB0SBXU+BPYgusfQ=;
        b=CreKpvAkpuF01U7dY73MAxE2iJz4lvakLbSZsoTe69QIjcncISAu4IxfvZORJfLDHu
         92vQ6KjPDhhl/E8SRTayLL6Zlh4/e84aClXiJYvzS0+ciEPrenH637/Yt9tvGAAbpi3f
         LHSeX4MAAR0NEd4qv183E+5cYKipptrspIJNfz4ypJiCrobw/ZzrxUxGKkka2iFU8TVI
         cErucAda9BhlLbp75c2UMkroS9tx9+BF1Cdph1+bQqsU4JO9mME6IB2MPQtkxMLO515u
         1P26FXB2RRxIB7S3sVt/RxLSgwS+jIDrbi/J9763X9e7s6BqGV17V2vjppLsnyKddvCP
         anug==
X-Gm-Message-State: AJIora/g/zr/MUC6XK3WhKgdcODOTMwViZSsJ4yWRznLRGH7w4m3Rq5+
        BXH0esOydK+s1EDMKFxdrdO4h0FIVHqf9Q==
X-Google-Smtp-Source: AGRyM1u+QpXuU1C7Ozi0UtchNSl/19rAChTfEtffBwDQzTYxAwJ/MURVaDBNgpuNy9qLcOFjKYhQCw==
X-Received: by 2002:a05:6a00:1908:b0:525:5dad:cb1c with SMTP id y8-20020a056a00190800b005255dadcb1cmr54026824pfi.47.1657213165985;
        Thu, 07 Jul 2022 09:59:25 -0700 (PDT)
Received: from jaschultz-Thelio-Major.corp.microsoft.com ([2001:4898:80e8:37:6a04:c27c:dcee:eb11])
        by smtp.gmail.com with ESMTPSA id v14-20020aa7808e000000b00518e1251197sm28184185pff.148.2022.07.07.09.59.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 09:59:25 -0700 (PDT)
From:   Jarrett Schultz <jaschultzms@gmail.com>
X-Google-Original-From: Jarrett Schultz <jaschultzMS@gmail.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Dmitry Antipov <dmanti@microsoft.com>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Jarrett Schultz <jaschultz@microsoft.com>
Subject: [PATCH v5 3/6] dt-bindings: input: Document Microsoft G6 Touch Digitizer
Date:   Thu,  7 Jul 2022 09:58:59 -0700
Message-Id: <20220707165902.3184-4-jaschultzMS@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707165902.3184-1-jaschultzMS@gmail.com>
References: <20220707165902.3184-1-jaschultzMS@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jarrett Schultz <jaschultz@microsoft.com>

Documentation describes the required and optional properties for
implementing Device Tree for a Microsoft G6 Touch Digitizer that
supports HID over SPI Protocol 1.0 specification.

Signed-off-by: Dmitry Antipov <dmanti@microsoft.com>
Signed-off-by: Jarrett Schultz <jaschultz@microsoft.com>
---
 .../input/microsoft,g6-touch-digitizer.yaml   | 135 ++++++++++++++++++
 1 file changed, 135 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml

diff --git a/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml b/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
new file mode 100644
index 000000000000..b607bbb32a42
--- /dev/null
+++ b/Documentation/devicetree/bindings/input/microsoft,g6-touch-digitizer.yaml
@@ -0,0 +1,135 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/input/microsoft,g6-touch-digitizer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microsoft G6 Touch Digitizer
+
+maintainers:
+  - Dmitry Antipov <dmanti@microsoft.com>
+
+description: |
+  Microsoft G6 touch digitizer is a HID over SPI device supporting HID Over SPI
+  Protocol Specification 1.0, available at
+  https://www.microsoft.com/en-us/download/details.aspx?id=103325.
+
+properties:
+  compatible:
+    items:
+      - const: microsoft,g6-touch-digitizer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+    description:
+      GPIO specifier for the digitizer's reset pin (active low). The line must
+      be flagged with GPIO_ACTIVE_LOW.
+
+  vdd-supply:
+    description:
+      Regulator for the VDD supply voltage.
+
+  input-report-header-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 16777215
+    description:
+      A value to be included in the Read Approval packet, listing an address of
+      the input report header to be put on the SPI bus. This address has 24
+      bits.
+
+  input-report-body-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 16777215
+    description:
+      A value to be included in the Read Approval packet, listing an address of
+      the input report body to be put on the SPI bus. This address has 24 bits.
+
+  output-report-address:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    minimum: 0
+    maximum: 16777215
+    description:
+      A value to be included in the Output Report sent by the host, listing an
+      address where the output report on the SPI bus is to be written to. This
+      address has 24 bits.
+
+  post-power-on-delay-ms:
+    description:
+      Optional time in ms required by the device after enabling its regulators
+      or powering it on, before it is ready for communication.
+
+  minimal-reset-delay-ms:
+    description:
+      Optional minimum amount of time in ms that device needs to be in reset
+      state for the reset to take effect.
+
+  read-opcode:
+    description: 
+      Value to be used in Read Approval packets. 1 byte.
+
+  write-opcode:
+    description:
+      Value to be used in Write Approval packets. 1 byte.
+
+  hid-over-spi-flags:
+    description:
+      16 bits.
+      Bits 0-12 - Reserved (must be 0)
+      Bit 13 - SPI Write Mode. Possible values -
+        * 0b0- Writes are carried out in Single-SPI mode
+        * 0b1- Writes are carried out in the Multi-SPI mode specified by bits
+               14-15
+      Bits 14-15 - Multi-SPI Mode. Possible values - 
+        * 0b00- Single SPI
+        * 0b01- Dual SPI
+        * 0b10- Quad SPI
+
+required:
+  - compatible
+  - interrupts
+  - reset-gpios
+  - vdd-supply
+  - input-report-header-address
+  - input-report-body-address
+  - output-report-address
+  - read-opcode
+  - write-opcode
+  - hid-over-spi-flags
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
+    spi {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      hid@0 {
+        compatible = "microsoft,g6-touch-digitizer";
+        reg = <0x0>;
+        interrupts-extended = <&gpio 42 IRQ_TYPE_EDGE_FALLING>;
+        reset-gpios = <&gpio 27 GPIO_ACTIVE_LOW>;
+        vdd-supply = <&pm8350c_l3>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&ts_d6_reset_assert &ts_d6_int_bias>;
+        input-report-header-address = <0x1000>;
+        input-report-body-address = <0x1004>;
+        output-report-address = <0x2000>;
+        read-opcode = <0x0b>;
+        write-opcode = <0x02>;
+        hid-over-spi-flags = <0x00>;
+        post-power-on-delay-ms = <5>;
+        minimal-reset-delay-ms = <5>;
+      };
+    };
-- 
2.25.1

