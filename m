Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1467158F007
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:04:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233296AbiHJQEU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:04:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233222AbiHJQDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:03:49 -0400
Received: from mail-il1-f180.google.com (mail-il1-f180.google.com [209.85.166.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA10C6717C;
        Wed, 10 Aug 2022 09:03:47 -0700 (PDT)
Received: by mail-il1-f180.google.com with SMTP id x2so2390803ilp.10;
        Wed, 10 Aug 2022 09:03:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=IrtUFJXfmfdQKeaT5ZVd35+tzRi7zWIlb+Wsybvtzfw=;
        b=fn+NgPYvpGMKGvWn9AH2CClpLqWAjiHwa2xgbuFOJJZWDO6tNkmAKxqUaevcrn4r1T
         cWOWDFHioJOhuEwgVV1qw/W4TBcntibjMdhW9Irnc24GGPQOx9OrJTZz8XKXinu45rmE
         jh48CaEL4LARoctezmsFIJCT32iAL7LYicdjpj1oJbZQIyRYwJfeRxyfWopcsJIHdPTm
         YCtfGjx9BuILxq3yHuJmEG0TveVUG6yJgfLdjWl0HoU6qt1fIRIIT6WPllfKZ4IJ8a3D
         RtttFGH4R+Hah8yWXk6w6l0LcGioOL0/Y27W3EQrpOZF2/DHjDD3KjG3IKg/x8Wd+ury
         tRhg==
X-Gm-Message-State: ACgBeo0lXBH12HaixuZuOrA1xhqMVkqX76759u0uL3JtlH8T7Q0fVaWk
        0BPNKvnEhLWO5qAlEFEATg==
X-Google-Smtp-Source: AA6agR5L6UDKesXHoDGK9TS6LftDSNWSGOXJ/sv+fkC0JxoXQwGpeO5paASudn/YE/O29MWZ9eM0Eg==
X-Received: by 2002:a05:6e02:198b:b0:2e0:d13c:b508 with SMTP id g11-20020a056e02198b00b002e0d13cb508mr8053060ilf.315.1660147426681;
        Wed, 10 Aug 2022 09:03:46 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.248])
        by smtp.googlemail.com with ESMTPSA id a27-20020a02735b000000b00341a215d3cesm7617629jae.63.2022.08.10.09.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:03:46 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] dt-bindings: arm,versatile-sysreg: Convert to DT schema format
Date:   Wed, 10 Aug 2022 10:03:41 -0600
Message-Id: <20220810160341.51995-3-robh@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220810160341.51995-1-robh@kernel.org>
References: <20220810160341.51995-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the arm,versatile-sysreg binding to DT schema format.

The original binding was missing 'simple-mfd' and a 'panel' sub node which
the only user (versatile-ab.dts) of this binding has.

Signed-off-by: Rob Herring <robh@kernel.org>
---
 .../bindings/arm/arm,versatile-sysreg.yaml    | 35 +++++++++++++++++++
 .../bindings/arm/versatile-sysreg.txt         | 10 ------
 2 files changed, 35 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml
 delete mode 100644 Documentation/devicetree/bindings/arm/versatile-sysreg.txt

diff --git a/Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml b/Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml
new file mode 100644
index 000000000000..491eef1e1b10
--- /dev/null
+++ b/Documentation/devicetree/bindings/arm/arm,versatile-sysreg.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only or BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/arm/arm,versatile-sysreg.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Arm Versatile system registers
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description:
+  This is a system control registers block, providing multiple low level
+  platform functions like board detection and identification, software
+  interrupt generation, MMC and NOR Flash control, etc.
+
+properties:
+  compatible:
+    items:
+      - const: arm,versatile-sysreg
+      - const: syscon
+      - const: simple-mfd
+
+  reg:
+    maxItems: 1
+
+  panel:
+    type: object
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+...
diff --git a/Documentation/devicetree/bindings/arm/versatile-sysreg.txt b/Documentation/devicetree/bindings/arm/versatile-sysreg.txt
deleted file mode 100644
index a4f15262d717..000000000000
--- a/Documentation/devicetree/bindings/arm/versatile-sysreg.txt
+++ /dev/null
@@ -1,10 +0,0 @@
-ARM Versatile system registers
---------------------------------------
-
-This is a system control registers block, providing multiple low level
-platform functions like board detection and identification, software
-interrupt generation, MMC and NOR Flash control etc.
-
-Required node properties:
-- compatible value : = "arm,versatile-sysreg", "syscon"
-- reg : physical base address and the size of the registers window
-- 
2.34.1

