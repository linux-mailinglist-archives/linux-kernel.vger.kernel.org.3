Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E0B5535BDA
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 10:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349932AbiE0IrP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 04:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349901AbiE0IrG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 04:47:06 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECF4B3153E;
        Fri, 27 May 2022 01:47:01 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so3792802pjq.2;
        Fri, 27 May 2022 01:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=weRfekXLILP2lO9stplYBl5Nh9WF88pncFfI0g1b4VA=;
        b=bwOhKhGjb/m9lMftPARFL9G9QWdmo2ZN94jP34cX52XrrR4UlLbaqJ1zqo77jNXkfj
         3i2Gc1p+tMeyCBKMyKH8uJ9hJ4s44dLuERP6u2zESv19WNVoUp5Vm1Bnl8NxM5bEl0Be
         LK7auQhiGtlONlt7WPJqmNDKpDn2lpMtTQp4z0jqVSH8QstNuceYMFPGaI2L8SkBHn5n
         q1bHWBVQAoQJqHPwjWQMrW+VgZ78JGdNNHLAJ99+JX7FWK/N6fzfULj4+F763GubBIav
         9kXx9mHiny8+d5x6cQed+k+KKaE96oq7caMMX+kKz0TKHxSB4R82BYiguCQDrD++4OLI
         NeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=weRfekXLILP2lO9stplYBl5Nh9WF88pncFfI0g1b4VA=;
        b=NQZhVhOTKZOKTHHQtFkSbzqfZ/vpP2DvcxAXtlXCsm+W65QkzM5p27BVagkHz/VC/p
         4i64uzpSe0YZ4oDcyt45/Cloot16hvFV0av9xdNH21vEt8TW+nItNClR+7qOqCyL/AVh
         tUJfHKYpvi5BtvE/ASopNqR1H/Y/k65l3M2Az1TNW3GExzC2/BTDLEhBBq9fIK+PMFKX
         0o7+4Twr2GefQGjkACzZMebQx+FjF/8T8K2mRmkreCHtSWjF5kftOKxMEdrXZwxFXVMZ
         atXUlefzKjzIN7kOLmfV3ZTrmkVQ8zp0GLWGuv8Es/y0hCdMHU5sqdu2xhdnWL6X+jXu
         J/HA==
X-Gm-Message-State: AOAM532B5TQVlHH2fyXOoTVRSSdi46JOXfIJ7ZXLoJfMvCKCVyJXXZAz
        S8rF8Q2YrRL3if5vWS8KsQo=
X-Google-Smtp-Source: ABdhPJztQyPOcuF5GRPQYyE4itPVdRodDdyKbv4q+AyEl96UVBPCXZXsLrIzvYUJd1Zy4BcI8kIv5Q==
X-Received: by 2002:a17:90b:38c2:b0:1e0:44ca:8de6 with SMTP id nn2-20020a17090b38c200b001e044ca8de6mr7167371pjb.243.1653641221327;
        Fri, 27 May 2022 01:47:01 -0700 (PDT)
Received: from localhost.localdomain ([116.89.143.231])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902d58c00b0015e8d4eb1ebsm3003254plh.53.2022.05.27.01.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 01:47:00 -0700 (PDT)
From:   medadyoung@gmail.com
X-Google-Original-From: ctcchien@nuvoton.com
To:     benjaminfair@google.com, yuenn@google.com, venture@google.com,
        tali.perry1@gmail.com, tmaimon77@gmail.com, avifishman70@gmail.com,
        robh+dt@kernel.org, alexandre.belloni@bootlin.com,
        a.zummo@towertech.it, KWLIU@nuvoton.com, YSCHU@nuvoton.com,
        JJLIU0@nuvoton.com, KFTING@nuvoton.com, ctcchien@nuvoton.com
Cc:     openbmc@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-rtc@vger.kernel.org
Subject: [PATCH v3 1/3] dt-bindings: rtc: nuvoton: add NCT3018Y Real Time Clock
Date:   Fri, 27 May 2022 16:46:45 +0800
Message-Id: <20220527084647.30835-2-ctcchien@nuvoton.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220527084647.30835-1-ctcchien@nuvoton.com>
References: <20220527084647.30835-1-ctcchien@nuvoton.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Medad CChien <ctcchien@nuvoton.com>

Document devicetree bindings for the Nuvoton NCT3018Y Real Time Clock.

Signed-off-by: Medad CChien <ctcchien@nuvoton.com>
---
 .../bindings/rtc/nuvoton,nct3018y.yaml        | 44 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml

diff --git a/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
new file mode 100644
index 000000000000..788d92a32a70
--- /dev/null
+++ b/Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
@@ -0,0 +1,44 @@
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
index 4383949ff654..5a4302e9aad2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2367,6 +2367,7 @@ L:	openbmc@lists.ozlabs.org (moderated for non-subscribers)
 S:	Supported
 F:	Documentation/devicetree/bindings/*/*/*npcm*
 F:	Documentation/devicetree/bindings/*/*npcm*
+F:	Documentation/devicetree/bindings/rtc/nuvoton,nct3018y.yaml
 F:	arch/arm/boot/dts/nuvoton-npcm*
 F:	arch/arm/mach-npcm/
 F:	drivers/*/*npcm*
-- 
2.17.1

