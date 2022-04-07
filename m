Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0078C4F74FE
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 06:49:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240828AbiDGEvZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 00:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240830AbiDGEvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 00:51:21 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D158D10F6FB
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 21:49:18 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id j20-20020a17090ae61400b001ca9553d073so5032995pjy.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 21:49:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7rbcSp4fuzvzN4uIAMZ1TVJvFtHbPKyD1JNqsKzlus=;
        b=Q2xkmVxAyy3CrxlyqbBn2kZxvgiIjGR0OydNdl3GHhHTSrkQsl3LO+TnP/g6RD/+5q
         W8YMZ6PCB4s7iuDnWizmM7VOBD5gsjMzQ/+Bb2epAxyAq4UqS+rYWwPcsw0KGHZugI0l
         1xW3jYS2CEqnPSMRwA5ctFd+mEc7dIp8hgTNSmFw9BwEPOK5gCiQLGaNCmk2xkhBnT1j
         QAdC6a84hGgC3SYX97577QBqbcz4kvTsEX3Dpo2C6hJdlW2ulbJldPeGPjQ/uuuA61UT
         8ZZ9szJhn0szhbDd4bkPYMfSpTGKge1FcEYWhcIgWoxTr+Y8W3CX8c2o9jUICwDvbfz5
         SWXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Y7rbcSp4fuzvzN4uIAMZ1TVJvFtHbPKyD1JNqsKzlus=;
        b=lhDGf0wL6Dr/4RmIaCt9hcKBNV7krMYVaiSjPPYiPJYyLrGyCFGnSnvyxIUFTkSj3w
         CrVWjrmYOoNCJeziGA7NBxEfENXKrsUnjFGHz2la1j4nEjhUxG8oAHaJ2uCEnYTDphBm
         tSITCJdGB8SPnA0jpWQdLT5dvK3iuR2Ksdzt79T+gMW0zUqRDxjV9COLFXftqF4ZaQOx
         dxqmUQKamRXzliW2y9holHYFZIPYChjhAhaI1MTFyKeoRW8Ms9KCRv22E0pDCsgcMplx
         BGP2dHiArBQKR99He0xO4QY4SM0Qj70pJdXoB2Qngybyf8o2GW70u2wLmWxlSGAmCvPJ
         ZDCw==
X-Gm-Message-State: AOAM533TXrWjaGVUOosAV/4mHdg9QJnXEerKIvsS61cHKA416ztCcqHX
        +K7Wf/+TLGFYi/ygaMM4Te0LLw==
X-Google-Smtp-Source: ABdhPJywP1gsaETWFMYATeJF/uQxkBYNCMWvbNfGmYqHmdg23ZJoCF8A2ZAS6fpxy2loB+0t1XPJJw==
X-Received: by 2002:a17:90b:3e8c:b0:1c7:3001:f359 with SMTP id rj12-20020a17090b3e8c00b001c73001f359mr13814906pjb.179.1649306958293;
        Wed, 06 Apr 2022 21:49:18 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:c0af:e9e:e3fa:ae9f])
        by smtp.gmail.com with ESMTPSA id k13-20020aa7820d000000b004fa72a52040sm20976546pfi.172.2022.04.06.21.49.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 21:49:17 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Suman Anna <s-anna@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH] dt-bindings: soc: ti: wkup_m3_ipc: convert bindings to json-schema
Date:   Wed,  6 Apr 2022 20:22:10 -0700
Message-Id: <20220407032208.2249485-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert the wkup_m3_ipc bindings documentation to json-schema.

Link: https://lore.kernel.org/linux-arm-kernel/20220221125522.l3tntb6i7yjxp6vb@flattered/
Suggested-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Drew Fustini <dfustini@baylibre.com>
---
 .../bindings/soc/ti/wkup_m3_ipc.txt           | 57 ------------
 .../bindings/soc/ti/wkup_m3_ipc.yaml          | 86 +++++++++++++++++++
 2 files changed, 86 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.yaml

diff --git a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
deleted file mode 100644
index 401550487ed6..000000000000
--- a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-Wakeup M3 IPC Driver
-=====================
-
-The TI AM33xx and AM43xx family of devices use a small Cortex M3 co-processor
-(commonly referred to as Wakeup M3 or CM3) to help with various low power tasks
-that cannot be controlled from the MPU, like suspend/resume and certain deep
-C-states for CPU Idle. Once the wkup_m3_ipc driver uses the wkup_m3_rproc driver
-to boot the wkup_m3, it handles communication with the CM3 using IPC registers
-present in the SoC's control module and a mailbox. The wkup_m3_ipc exposes an
-API to allow the SoC PM code to execute specific PM tasks.
-
-Wkup M3 Device Node:
-====================
-A wkup_m3_ipc device node is used to represent the IPC registers within an
-SoC.
-
-Required properties:
---------------------
-- compatible:		Should be,
-				"ti,am3352-wkup-m3-ipc" for AM33xx SoCs
-				"ti,am4372-wkup-m3-ipc" for AM43xx SoCs
-- reg:			Contains the IPC register address space to communicate
-			with the Wakeup M3 processor
-- interrupts:		Contains the interrupt information for the wkup_m3
-			interrupt that signals the MPU.
-- ti,rproc:		phandle to the wkup_m3 rproc node so the IPC driver
-			can boot it.
-- mboxes:		phandles used by IPC framework to get correct mbox
-			channel for communication. Must point to appropriate
-			mbox_wkupm3 child node.
-
-Example:
---------
-/* AM33xx */
-	l4_wkup: l4_wkup@44c00000 {
-		...
-
-		scm: scm@210000 {
-			compatible = "ti,am3-scm", "simple-bus";
-			reg = <0x210000 0x2000>;
-			#address-cells = <1>;
-			#size-cells = <1>;
-			ranges = <0 0x210000 0x2000>;
-
-			...
-
-			wkup_m3_ipc: wkup_m3_ipc@1324 {
-				compatible = "ti,am3352-wkup-m3-ipc";
-				reg = <0x1324 0x24>;
-				interrupts = <78>;
-				ti,rproc = <&wkup_m3>;
-				mboxes = <&mailbox &mbox_wkupm3>;
-			};
-
-			...
-		};
-	};
diff --git a/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.yaml b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.yaml
new file mode 100644
index 000000000000..04ed5ada1d28
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.yaml
@@ -0,0 +1,86 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/soc/ti/wkup_m3_ipc.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Wakeup M3 IPC device
+
+maintainers:
+  - Dave Gerlach <d-gerlach@ti.com>
+  - Drew Fustini <dfustini@baylibre.com>
+
+description: |+
+
+  The TI AM33xx and AM43xx family of devices use a small Cortex M3 co-processor
+  (commonly referred to as Wakeup M3 or CM3) to help with various low power tasks
+  that cannot be controlled from the MPU, like suspend/resume and certain deep
+  C-states for CPU Idle. Once the wkup_m3_ipc driver uses the wkup_m3_rproc driver
+  to boot the wkup_m3, it handles communication with the CM3 using IPC registers
+  present in the SoC's control module and a mailbox. The wkup_m3_ipc exposes an
+  API to allow the SoC PM code to execute specific PM tasks.
+
+  Wkup M3 Device Node
+  ====================
+  A wkup_m3_ipc device node is used to represent the IPC registers within an
+  SoC.
+
+properties:
+
+  compatible:
+    enum:
+      - ti,am3352-wkup-m3-ipc # for AM33xx SoCs
+      - ti,am4372-wkup-m3-ipc # for AM43xx SoCs
+
+  reg:
+    description:
+      Contains the IPC register address space to communicate with the
+      Wakeup M3 processor
+    maxItems: 1
+
+  interrupts:
+    description:
+      Contains the interrupt information for the wkup_m3 interrupt that
+      signals the MPU
+    maxItems: 1
+
+  ti,rproc:
+    $ref: /schemas/types.yaml#/definitions/phandle
+    description:
+      phandle to the wkup_m3 rproc node so the IPC driver can boot it
+
+  mboxes:
+    description:
+      phandles used by IPC framework to get correct mbox
+      channel for communication. Must point to appropriate
+      mbox_wkupm3 child node.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - ti,rproc
+  - mboxes
+
+additionalProperties: false
+
+examples:
+  - |
+    soc {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        mailbox: mailbox {
+            #mbox-cells = <1>;
+        };
+
+        wkup_m3_ipc: wkup_m3_ipc@1324 {
+           compatible = "ti,am3352-wkup-m3-ipc";
+           reg = <0x1324 0x24>;
+           interrupts = <78>;
+           ti,rproc = <&wkup_m3>;
+           mboxes = <&mailbox &mbox_wkupm3>;
+        };
+    };
+...
-- 
2.32.0

