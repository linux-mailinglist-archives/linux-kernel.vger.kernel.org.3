Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA794573209
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 11:07:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236050AbiGMJHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 05:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236021AbiGMJHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 05:07:02 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DEAE8D8E;
        Wed, 13 Jul 2022 02:07:01 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id q5-20020a17090a304500b001efcc885cc4so2538428pjl.4;
        Wed, 13 Jul 2022 02:07:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c7P7rbDeUBszX+Bkg4CL+iblSBl3SVhy5/F6nhgIigA=;
        b=E6GYTkSXE5LcLytAcCf2HNOu2EKvn9ncs8jX/cZg5RzujAq+q4oYGNrkst4oSen0dp
         YPKcqrXAmfrchGTLpfuBaWBw2L5VfFhov4OMvKuutkg20iSwVumod0xDPIYJZQdOFTl1
         L1x36w0cF2NpP1XLUgIm+HXM80EpvBhKRrVIU9R0mPiIojLBKsJO5fs7kYGO1zmj4liQ
         Is2da+jcrnVpwyRk3YWHgzRFUXrUyACN6bZ3dMLyIh/m84a+K298ki10IIZyQ5ddoBMm
         DOMmxtNEJj6GBMzLgXbLxj+/hQgzlPBT/loF8/qkiP/1N9IKu2I3fGuom6wZnEUDr2/Y
         QDjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=c7P7rbDeUBszX+Bkg4CL+iblSBl3SVhy5/F6nhgIigA=;
        b=riQ6WBXC74bSWEp1jw4+19OaEnq+p8HsrOJFlpRZPmnHcqFoNy8n6xopD797tdxyqW
         f2a8gBjrddQ6S9W/jdu3YztDtr4SyrmwKC2Lh0TGHUKN7xJeLC2+XUjSuqErB0/iHiun
         yKDGp/eZcAMj62Bv80D5ms4XU+4aK2/rVpV8Y8o3ml8R3dUcirMDpe7sOZLVwCA9QFp0
         dI2unbuRbv3QvqYoJt89impf4DmGN2VeLf0+DsUNlfbCmPK31yrE9BHp5OetZYn4QCdX
         HTL66U9sKZkloHSihbaWGx1zvkrPIPdGaIp5N7vpMxZ2dVtVEOsQZwIi9zfHlpmo+8xS
         OLrw==
X-Gm-Message-State: AJIora9MQDZLHvzA2S4EYyWJZlRERZt0ZOdr6uF0FR8/yVt8sL9mgn/h
        R28pyfWkDC22UKIsI8tLHQ9TvAPf+w7a/g==
X-Google-Smtp-Source: AGRyM1th2QjWPU2ZA0pEKcbROyKEp6PEjVS+c1MOMWUr9mHhj1Eb7I2v0YPyudSirflfe0LElLZsHw==
X-Received: by 2002:a17:902:d50a:b0:16c:5490:163c with SMTP id b10-20020a170902d50a00b0016c5490163cmr2232862plg.31.1657703220502;
        Wed, 13 Jul 2022 02:07:00 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id gg10-20020a17090b0a0a00b001ef917f1c30sm1051975pjb.6.2022.07.13.02.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 02:06:59 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ctcchien@nuvoton.com, medadyoung@gmail.com, mimi05633@gmail.com,
        KWLIU@nuvoton.com, YSCHU@nuvoton.com, KFTING@nuvoton.com,
        JJLIU0@nuvoton.com, mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
Date:   Wed, 13 Jul 2022 17:06:45 +0800
Message-Id: <20220713090647.8028-2-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220713090647.8028-1-mimi05633@gmail.com>
References: <20220713090647.8028-1-mimi05633@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Mia Lin <mimi05633@gmail.com>
---
 .../bindings/rtc/nuvoton,nct3018y.yaml        | 45 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 46 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
new file mode 100644
index 000000000000..7a1857f5caa8
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/rtc/nuvoton,nct3018y.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NUVOTON NCT3018Y Real Time Clock
+
+allOf:
+  - $ref: "rtc.yaml#"
+
+maintainers:
+  - Medad CChien <ctcchien@nuvoton.com>
+  - Mia Lin <mimi05633@gmail.com>
+
+properties:
+  compatible:
+    const: nuvoton,nct3018y
+
+  reg:
+    maxItems: 1
+
+  start-year: true
+
+  reset-source: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        rtc@6f {
+            compatible = "nuvoton,nct3018y";
+            reg = <0x6f>;
+        };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index fe5daf141501..eca54b275559 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2448,6 +2448,7 @@ S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
 F:	Documentation/devicetree/bindings/arm/npcm/*
+F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	drivers/*/*npcm*
-- 
2.17.1

