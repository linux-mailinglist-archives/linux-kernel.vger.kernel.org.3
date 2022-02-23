Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5859C4C1E93
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 23:36:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244465AbiBWWfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 17:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244089AbiBWWfk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 17:35:40 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C4D50064
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:35:11 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j17so270933wrc.0
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 14:35:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6hRZD6N659v/Uhm1WCmy8CVfNDpkSy/hE0ouy3/yCRk=;
        b=JLmt2pqzSuFqCTMy4tGGWGOUY9cJpIvFOaqgJTynrAgIlh9aBMe7dHMjQfAPINZBcI
         NLtAzsgFaQuH8/GyDBUSsw1q7xxssNRB2b8QSqsmtMepjW0I7CIqHrLBkjX6wvOiZoBI
         HQohKdLLDYRtuHl/eFIYbuug8JVUEeuGp2SSqr1OfLQsfVjl9bFPUKjGpNBHxpqPlcDM
         AHs5Fq6dV18YU9LvWvub0xcA8iqje6nvLEF+1S3hKxKW0mNauguGyDlnEqWYVVhKMZtp
         2ETz1skme069prsyRdXbd2oamO6yKCtLcJXKii4D0jv6WJvAhJm2sy1L2Jhf03lvWw95
         Dpuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6hRZD6N659v/Uhm1WCmy8CVfNDpkSy/hE0ouy3/yCRk=;
        b=K6ScnNI2fcGKzaxDI+WHLwZ3gJey8ncS89zM8yTUeQUeofNO92JnmTsAHOH6VBIUv6
         m0MDTK5ERG09IXAoqgmHzdupcRpQUamg2NxZaUB34LwcdqCzpBVOoOJcYSpQy7SlwDcX
         SGWl8TnAOTUJCqxj+4z4f0Gn+KDaRWESRg5L/VkWKgfZHxp+n91iXuV/0+Bj+fP0+kPv
         bbF8FGXopVplO7PQ6P5f4hLE86EuzoV7afJgoe0tzJ+R2vb/5RFpoQP6Hh3h6L4+kyHf
         RBvP1tv6sqRjzrybKKH1Dlk7Va50jS/pdUN+fEi/RApektP1FfgUy7Ll1lPJgqw2eBno
         Ahjw==
X-Gm-Message-State: AOAM530ffrnmIGr60VGXCX8/DedmoWtkV9pa2aUk383yQ8I+f6EiMK6c
        PYcY9Caxa4ZQsfFIMaB3mSErV3FFj2fLEw==
X-Google-Smtp-Source: ABdhPJzlCiLKhzQyqlb0+W5jcsxKJQVGASkIz2zp7TAIlv6rtg5xUG3lelogwq5yccIGMFeD+eZhRg==
X-Received: by 2002:a05:6000:1ac5:b0:1ea:7870:d7eb with SMTP id i5-20020a0560001ac500b001ea7870d7ebmr1274205wry.171.1645655709701;
        Wed, 23 Feb 2022 14:35:09 -0800 (PST)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id c9sm729435wrn.51.2022.02.23.14.35.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 14:35:09 -0800 (PST)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org,
        Vincent Shih <vincent.sunplus@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 3/3] dt-bindings: nvmem: Add bindings doc for Sunplus OCOTP driver
Date:   Wed, 23 Feb 2022 22:35:02 +0000
Message-Id: <20220223223502.29454-4-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
References: <20220223223502.29454-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vincent Shih <vincent.sunplus@gmail.com>

Add bindings doc for Sunplus OCOTP driver

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Vincent Shih <vincent.sunplus@gmail.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 .../bindings/nvmem/sunplus,sp7021-ocotp.yaml  | 86 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml

diff --git a/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
new file mode 100644
index 000000000000..4b28f37dfb67
--- /dev/null
+++ b/Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+# Copyright (C) Sunplus Co., Ltd. 2021
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/nvmem/sunplus,sp7021-ocotp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: On-Chip OTP Memory for Sunplus SP7021
+
+maintainers:
+  - Vincent Shih <vincent.sunplus@gmail.com>
+
+allOf:
+  - $ref: "nvmem.yaml#"
+
+properties:
+  compatible:
+    const: sunplus,sp7021-ocotp
+
+  reg:
+    maxItems: 2
+
+  reg-names:
+    items:
+      - const: hb_gpio
+      - const: otprx
+
+  clocks:
+    maxItems: 1
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 1
+
+  thermal-calibration:
+    type: object
+    description: thermal calibration values
+
+  disconnect-voltage:
+    type: object
+    description: disconnect voltages of usb2 port 0 and port 1
+
+  mac-address0:
+    type: object
+    description: MAC address of ethernet port 0
+
+  mac-address1:
+    type: object
+    description: MAC address of ethernet port 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/sp-sp7021.h>
+
+    otp: otp@9c00af00 {
+        compatible = "sunplus,sp7021-ocotp";
+        reg = <0x9c00af00 0x34>, <0x9c00af80 0x58>;
+        reg-names = "hb_gpio", "otprx";
+        clocks = <&clks OTPRX>;
+
+        #address-cells = <1>;
+        #size-cells = <1>;
+        therm_calib: thermal-calibration@14 {
+          reg = <0x14 0x3>;
+        };
+        disc_vol: disconnect-voltage@18 {
+          reg = <0x18 0x2>;
+        };
+        mac_addr0: mac-address0@34 {
+          reg = <0x34 0x6>;
+        };
+        mac_addr1: mac-address1@3a {
+          reg = <0x3a 0x6>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 534772dfc3ef..507697a11838 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18494,6 +18494,7 @@ F:	drivers/rtc/rtc-sunplus.c
 SUNPLUS OCOTP DRIVER
 M:	Vincent Shih <vincent.sunplus@gmail.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/nvmem/sunplus,sp7021-ocotp.yaml
 F:	drivers/nvmem/sunplus-ocotp.c
 
 SUPERH
-- 
2.21.0

