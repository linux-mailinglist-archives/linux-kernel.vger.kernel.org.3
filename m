Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD5E569BA5
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 09:32:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233004AbiGGHbK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 03:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbiGGHbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 03:31:05 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DC129CAC;
        Thu,  7 Jul 2022 00:31:04 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id e16so4913856pfm.11;
        Thu, 07 Jul 2022 00:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4lS8+zJE8FkMh+rcBQMyeBKxWljY5Kknqq/+RkB5aPM=;
        b=ibSY4GUT3RolxgA1sC9O1GddLeEziQwzoUcb2agxdIJRbtH7st2PSY9nlLwicYIdB0
         /mUJhPQlnJ8/GN6OcnlCP6sr0/VRnnjHTlecOUR/C3mw5+aAMVv1l7Z8KIn7W0ZUWodm
         tEOrH37drWoP0V/na+Unfk/kK2cciF8OpNPyYyCSgDgRdBehQvuyAEZUvlcTAoOm8zDY
         GO3dYJTFAkLPoSDKyOO4DVna+xWp4UJ1peO2KHuJelf8q8cvcg3UsvRepD1/hpALUAO1
         v1wbXw11Kld226/HB8ZLnmJqRtguAxXrpI1noJZtUZKKltu+Nc5aA08s6vIkKjBUWaLA
         mCpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4lS8+zJE8FkMh+rcBQMyeBKxWljY5Kknqq/+RkB5aPM=;
        b=fwX7CcKrNZ8D6Y8Ms5QLtouQ0JcoczFBMUctvLij3Kme0F/TnKnjj/zkQWOMk2+sUm
         ABxJf2S20RIcYmIsbXh8+BJin/t3AXLztehI2YJLF06YjkivCGiK5fAjoTPddIKmUafo
         2Z8x6AKEs9H5RLuc9VcX7+VF43PtMaFmRmcrzMeeGH3ZjuaiTjdZ263GqkzHmQycJKi6
         z/p57RCBR3Q059V0uBZzJVHzpMj6zlfx3h/SZ5pYAz1e9lrEmyVqB5eFRfcupQC+FhcR
         pJHOOiIZbxzI4eNm0c7FMa46S20pcMA0GXlqypSnTQaFSar06y7vEmvSMZp5PAe07SRl
         4ncw==
X-Gm-Message-State: AJIora+f4uHYAvEYHT3YMW9gAUU5TREvHBcXeVdKA38te6mTY1t/bFII
        w7cathg7P9mb/mKz52oBiIA=
X-Google-Smtp-Source: AGRyM1v1Ge2aCi5aURkLzF+dFeddZDOWX7FwDhbuLSQeGbX07a6pkBMo+rpooRlDSBbOjQS2gFljHg==
X-Received: by 2002:a63:31d3:0:b0:412:a9d9:d407 with SMTP id x202-20020a6331d3000000b00412a9d9d407mr4828312pgx.479.1657179064058;
        Thu, 07 Jul 2022 00:31:04 -0700 (PDT)
Received: from localhost.localdomain (60-250-192-107.hinet-ip.hinet.net. [60.250.192.107])
        by smtp.gmail.com with ESMTPSA id s1-20020aa78bc1000000b00528c70c34c2sm928481pfd.115.2022.07.07.00.31.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 00:31:03 -0700 (PDT)
From:   Mia Lin <mimi05633@gmail.com>
To:     avifishman70@gmail.com, tmaimon77@gmail.com, tali.perry1@gmail.com,
        venture@google.com, yuenn@google.com, benjaminfair@google.com,
        a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        ctcchien@nuvoton.com, mimi05633@gmail.com, KWLIU@nuvoton.com,
        YSCHU@nuvoton.com, KFTING@nuvoton.com, JJLIU0@nuvoton.com,
        mylin1@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
Date:   Thu,  7 Jul 2022 15:30:52 +0800
Message-Id: <20220707073054.3954-2-mimi05633@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220707073054.3954-1-mimi05633@gmail.com>
References: <20220707073054.3954-1-mimi05633@gmail.com>
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

