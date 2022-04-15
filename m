Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248DE502AC7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 15:03:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345616AbiDONDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 09:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353911AbiDONDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 09:03:05 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD55D369CF;
        Fri, 15 Apr 2022 06:00:36 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id c6so9835334edn.8;
        Fri, 15 Apr 2022 06:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xW+gwC4xCGMG6v1+4KhcIxH5r8ftuUTVjmJpXMqAdEg=;
        b=Yp3eZYPPhOsjc+QxsXPHTTBdboJ0BeFHw13LmFM2tSqUI0TBFGtapShRL8Im2VxHQo
         XHn1Gw67rtIrdzkC7kDEirvAOGzVgdBz8Aw9HWPMFLzmmzseLtYnNorEsRQQLfo4tUXQ
         jThGRyZK3aabB0ldsKsPc3xO0ERCnJNd5vXUkMd7AKU7oeiF4gyh5hkyUlU1DurTxVUB
         i9L+n4ExjWVPwqGsziLAqOZLjSQ01vJmPknO0Dass4k108kwOlXQD9ACCyMr3YwwZBMb
         En6wKcD0BXQJMGLUdVZGl/yTTy33slQNEc+6hMHjzcrCqT3VD0C2x8SWbmIaL7SFPJ5T
         XOfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xW+gwC4xCGMG6v1+4KhcIxH5r8ftuUTVjmJpXMqAdEg=;
        b=Plh6TaxxADrIDjZmeY6p8vRe+kxO7+LFtJqls5pUPB7MagWZajMvryuZYATA6L2e0d
         EqpcGOGlAnNgeKY8GEZ3bQlikBsqy3rXllpu1RJ0IKD/MaCtQ8GVMYjXmwevS58qTfx3
         exHysc8J5kJk582w120QWgnsvHQkMF48qVF61StrEVY61aiovuXdtbCc82m6G8fXLCoa
         PlZnTTMECXyMog/re8pWL9Y/nlk5tI9G7nVa5j8/VpHja1mgUTahUNyn3z3WQqF1uRxH
         /tf+Yuh956fZwcwdNpFR2n+jtPAUHdra6eUI215Br6T9FhQgFPppZPyOMzSNehBZPjVV
         7EGw==
X-Gm-Message-State: AOAM532oG+d7gjR1VVZFGzD042xIkXWXfEozlJOLK0aV0zFwrD6IwwO3
        LBTP0gdCBaGtsQlB8FWOYPA=
X-Google-Smtp-Source: ABdhPJx4lK/gMeHeTHho19M6IQ04MwcPwB5RNfj8Psq174kbFB8MiWHKy7AREWRzB3t8nLw1PSO+xA==
X-Received: by 2002:a05:6402:514:b0:41d:787f:b99d with SMTP id m20-20020a056402051400b0041d787fb99dmr7984739edv.76.1650027635070;
        Fri, 15 Apr 2022 06:00:35 -0700 (PDT)
Received: from poker.lan (static.2-229-210-222.ip198.fastwebnet.it. [2.229.210.222])
        by smtp.gmail.com with ESMTPSA id i26-20020a50d75a000000b0041e84bb406fsm2704715edj.0.2022.04.15.06.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 06:00:34 -0700 (PDT)
From:   Andrea Merello <andrea.merello@gmail.com>
To:     jic23@kernel.org, mchehab+huawei@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     lars@metafoo.de, robh+dt@kernel.org, andy.shevchenko@gmail.com,
        matt.ranostay@konsulko.com, ardeleanalex@gmail.com,
        jacopo@jmondi.org, Andrea Merello <andrea.merello@iit.it>
Subject: [v4 11/14] dt-bindings: iio: imu: add documentation for Bosch BNO055 bindings
Date:   Fri, 15 Apr 2022 15:00:02 +0200
Message-Id: <20220415130005.85879-12-andrea.merello@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220415130005.85879-1-andrea.merello@gmail.com>
References: <20220415130005.85879-1-andrea.merello@gmail.com>
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

From: Andrea Merello <andrea.merello@iit.it>

Introduce new documentation file for the Bosch BNO055 IMU

Signed-off-by: Andrea Merello <andrea.merello@iit.it>
---
 .../bindings/iio/imu/bosch,bno055.yaml        | 59 +++++++++++++++++++
 1 file changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml

diff --git a/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml b/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
new file mode 100644
index 000000000000..e0d06db161a9
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/imu/bosch,bno055.yaml
@@ -0,0 +1,59 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/imu/bosch,bno055.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Bosch BNO055
+
+maintainers:
+  - Andrea Merello <andrea.merello@iit.it>
+
+description: |
+  Inertial Measurement Unit with Accelerometer, Gyroscope, Magnetometer and
+  internal MCU for sensor fusion
+  https://www.bosch-sensortec.com/products/smart-sensors/bno055/
+
+properties:
+  compatible:
+    enum:
+      - bosch,bno055
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    serial {
+      imu {
+        compatible = "bosch,bno055";
+        reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
+        clocks = <&imu_clk>;
+      };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      imu@28 {
+        compatible = "bosch,bno055";
+        reg = <0x28>;
+        reset-gpios = <&gpio0 54 GPIO_ACTIVE_LOW>;
+        clocks = <&imu_clk>;
+      };
+    };
-- 
2.17.1

