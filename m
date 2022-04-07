Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33DBB4F818A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343919AbiDGO1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343900AbiDGO1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:27:05 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF64189A38
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:24:19 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id 2so5768393pjw.2
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nK9SRbUB5i4er0Nc2x3M4CSJ4RiMR6/wcutg0xiHzE=;
        b=BG9bTY9/90nnq5XMYGSYghQLUjR1HPYPk0BdlmCStQ6lZrcNzo5f+9DX5UTIzB7zi8
         APQCLYf+sAbyni171SWwk5wHsnAJh3TBFYYWEW0AJKEIjSC8hPAMSSi0Ryd6e+ASdeze
         AQfdcRAGMOo1XFE1iO6sXphVXM5mN3F4Huo/EzXiJz0pHxWBmjW3LXF1krbLhe9rgtgc
         xT8JBUdz4dR6CqVvVUFPci+xTirov06jCjeT+Cs6GXPH8RJH6dXllou0SDB0hJxZtgbB
         8cU3t7A4Rcj9iuRMAo5qAygcSb6L2soxaLvkLsDBLcRlUI9SETudzAkqC8xDF7vfqhWk
         2EoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+nK9SRbUB5i4er0Nc2x3M4CSJ4RiMR6/wcutg0xiHzE=;
        b=m99PX9lvHb/vTV0pJQjsjc69ic9ffRbeMTvZm9EupAWX7tbJCUSDOog3zRqM+y06Mn
         0K7TvDqCHzHMwfApOLo60J//5pcREN12gYfpaJgJqSfWNg6zSq17o7TNNmLPcRpNcNQG
         XE8EiWb4MXMQzgwNPr3l/XLEO7v2ZujQdbzHl6kfDWTeWq1N9AsCR5W4yGFbIoW91q7z
         ECgc+fuDYxZxox/44GVNgR1S16lPhNS5jew/AZxv1RmaAd/qY9mB4sdmk6aOQsWy0Lqh
         4YksbrGuRteyVaKHZqeyEhU/uXgH48GtA6M1uSAgXPgBEXNAM365xipI6MJO9zhXYyH2
         jL0g==
X-Gm-Message-State: AOAM532umnJQsVY370g2qYMB1a1rKuhyzk6hLA3g6eWpq2RgQscwyBVU
        cEW0h6+K7AxHU2NjPeweLc12RQ==
X-Google-Smtp-Source: ABdhPJyWjpOUQOpPX3P6u/QFz5ac/xm/7Q+g/Trta+CDcME4Mv0B0mlxTYchvtAIU5o9eTnl6nrBTg==
X-Received: by 2002:a17:902:d486:b0:157:1cc0:48bd with SMTP id c6-20020a170902d48600b001571cc048bdmr11887plg.108.1649341410446;
        Thu, 07 Apr 2022 07:23:30 -0700 (PDT)
Received: from x1.hsd1.or.comcast.net ([2601:1c2:1001:7090:172d:8708:69ef:da3a])
        by smtp.gmail.com with ESMTPSA id v3-20020a056a00148300b004fb04acde5dsm22499353pfu.166.2022.04.07.07.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:23:30 -0700 (PDT)
From:   Drew Fustini <dfustini@baylibre.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Dave Gerlach <d-gerlach@ti.com>, Suman Anna <s-anna@ti.com>,
        Tony Lindgren <tony@atomide.com>, Nishanth Menon <nm@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Drew Fustini <dfustini@baylibre.com>
Subject: [PATCH v2] dt-bindings: soc: ti: wkup_m3_ipc: convert bindings to json-schema
Date:   Thu,  7 Apr 2022 07:17:51 -0700
Message-Id: <20220407141750.2289293-1-dfustini@baylibre.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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
 .../bindings/soc/ti/wkup_m3_ipc.txt           | 57 -------------
 .../bindings/soc/ti/wkup_m3_ipc.yaml          | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 57 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.txt
 create mode 100644 Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.yaml

Changes in v2:
- removed unnecessary line breaks and shorten property descriptions

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
index 000000000000..50cc89c2d1c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/soc/ti/wkup_m3_ipc.yaml
@@ -0,0 +1,81 @@
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
+  compatible:
+    enum:
+      - ti,am3352-wkup-m3-ipc # for AM33xx SoCs
+      - ti,am4372-wkup-m3-ipc # for AM43xx SoCs
+
+  reg:
+    description:
+      The IPC register address space to communicate with the Wakeup M3 processor
+    maxItems: 1
+
+  interrupts:
+    description: wkup_m3 interrupt that signals the MPU
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

