Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 909A358454F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbiG1Rvr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiG1Rvj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:51:39 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C75774CE8
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:51:36 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l22so3220941wrz.7
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:51:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hYR+FRbx1OoSYWhKNCDaiub79lE270GG8ynXK3jcmfw=;
        b=qj9q+6OHGP4CZVwdB/XXLfT9tVoRp8E4RNgOXXIhtb/J+TwR1aRYxJcvrxWzg9mb+e
         lHg+sHZ60A1nbJF9ncX8hP8VO8z/pfYKxlRLIULx45KWPa3Jx3FgJfcLqW7+FkHFHzrH
         eNferYYln9VUOEavMpwz7WNiSr3sXu7Ftg2eZFFXNgnrlX/suW5oxGPLd6AZ1wk3aD24
         4LMIh7i5au0273aMHtuPDdOTXyQX8JWO8IWDf11UpZ9q2M/DluimOOKpNIVphqmvd8uk
         6GKk/xaVsQBPAZmtdyBc+ZL8XnK2xz4g9HaxyX5DcDfq3uZBZ6d5+laEU20SP/gZGUrM
         azCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hYR+FRbx1OoSYWhKNCDaiub79lE270GG8ynXK3jcmfw=;
        b=UhJrV35wegctHTfylsG5Aq2C+FVh0dh8s0P/JzpXAfJCBYzzGhuG7Z5InCUUHtCD3L
         0bzpUMBYIuqRxTPBknnzHtqoCmqnYKvwv9yXgPb8tOPsBgaG5FAvPk3g9EE2o044VYqy
         IeQjaeQXa10asQbbXk2a8tPW4ORg9DLZ32EBaPLsMl9EQMega1Bh6wX4H6VGQdOGPmIZ
         F00lIPirycvzo1xFaHWjU9WsDGhyuzMXmGLHLi74WCGc/2Z34+YytVnxJtSrT0EcLu6D
         lQ0HMx1hCfPRTftW2g17r+jymA7QiGP20aYsNpLATUf0ePStiDvN0fBnAHjBWVkILkXm
         /uPg==
X-Gm-Message-State: ACgBeo05Dgeh9ko4Qg10N6cJZjy28H9xeazmceBWyb4xz8vMygAy9rsK
        TA0fqMakKOxzpsBXy/krSHSnQQqJWTtr0w==
X-Google-Smtp-Source: AA6agR6Qdp2PlK05m717LPiOx7/Z70R6xOxsYbjxwB5NU/ZD6Q0G6dbZ0BOBIitPxcdNqE1s0yL/eA==
X-Received: by 2002:a05:6000:156e:b0:21d:c50a:7cdb with SMTP id 14-20020a056000156e00b0021dc50a7cdbmr74483wrz.16.1659030694625;
        Thu, 28 Jul 2022 10:51:34 -0700 (PDT)
Received: from localhost.localdomain (33.169.185.81.rev.sfr.net. [81.185.169.33])
        by smtp.gmail.com with ESMTPSA id c5-20020a05600c0a4500b003a3442f1229sm8274027wmq.29.2022.07.28.10.51.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:51:34 -0700 (PDT)
From:   Julien Panis <jpanis@baylibre.com>
To:     jic23@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        mranostay@ti.com, Julien Panis <jpanis@baylibre.com>
Subject: [PATCH v3 1/2] dt-binding: iio: time: add ti,am62-ecap-capture.yaml
Date:   Thu, 28 Jul 2022 19:51:23 +0200
Message-Id: <20220728175124.468461-2-jpanis@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728175124.468461-1-jpanis@baylibre.com>
References: <20220728175124.468461-1-jpanis@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit adds a YAML binding for TI ECAP used in capture operating mode.

Signed-off-by: Julien Panis <jpanis@baylibre.com>
---
 .../iio/time/ti,am62-ecap-capture.yaml        | 61 +++++++++++++++++++
 1 file changed, 61 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/time/ti,am62-ecap-capture.yaml

diff --git a/Documentation/devicetree/bindings/iio/time/ti,am62-ecap-capture.yaml b/Documentation/devicetree/bindings/iio/time/ti,am62-ecap-capture.yaml
new file mode 100644
index 000000000000..5c358592942b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/time/ti,am62-ecap-capture.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/time/ti,am62-ecap-capture.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Texas Instruments Enhanced Capture (eCAP) Module
+
+maintainers:
+  - Julien Panis <jpanis@baylibre.com>
+
+description: |
+  The eCAP module resources can be used to capture timestamps
+  on input signal events (falling/rising edges).
+
+properties:
+  compatible:
+    const: ti,am62-ecap-capture
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: fck
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clocks
+  - clock-names
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/soc/ti,sci_pm_domain.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        capture@23100000 { /* eCAP in capture mode on am62x */
+            compatible = "ti,am62-ecap-capture";
+            reg = <0x00 0x23100000 0x00 0x100>;
+            interrupts = <GIC_SPI 113 IRQ_TYPE_EDGE_RISING>;
+            power-domains = <&k3_pds 51 TI_SCI_PD_EXCLUSIVE>;
+            clocks = <&k3_clks 51 0>;
+            clock-names = "fck";
+        };
+    };
-- 
2.25.1

