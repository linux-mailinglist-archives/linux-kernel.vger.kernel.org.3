Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B32647F182
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 00:46:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230303AbhLXXqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Dec 2021 18:46:12 -0500
Received: from ixit.cz ([94.230.151.217]:50334 "EHLO ixit.cz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229576AbhLXXqL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Dec 2021 18:46:11 -0500
Received: from localhost.localdomain (ip-89-176-96-70.net.upcbroadband.cz [89.176.96.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ixit.cz (Postfix) with ESMTPSA id B39172243C;
        Sat, 25 Dec 2021 00:46:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ixit.cz; s=dkim;
        t=1640389569;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=CfFCbj1sFlf04RoseWgD0zYu4RJXqwj8cFEv1GIOEI0=;
        b=aPDJByjvrjiVWfvWd0rYkusJEkjJKKW3n2kYhtaiFH590RUV3MGnch6i4tfTzcy5Oo2yjy
        q6ehHOVLE6Ii+q7A1seVsiw9ZJtr2nLaq0HIWa9/+O2+JHzFf+Gwy+/cF4lumrGLhWQVK+
        wXh9rn1sEF136fnauvoBpAj94zwzL5U=
From:   David Heidelberg <david@ixit.cz>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     ~okias/devicetree@lists.sr.ht, David Heidelberg <david@ixit.cz>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH] dt-bindings: timer: convert MSM timer to yaml
Date:   Sat, 25 Dec 2021 00:46:06 +0100
Message-Id: <20211224234607.109049-1-david@ixit.cz>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Convert Qualcomm MSM Timer to yaml format.

Signed-off-by: David Heidelberg <david@ixit.cz>

---
It has currently issue, that it fights with watchdog/qcom-wdt.yaml
Both bindings and drivers use similar sets of compatibles and qcom-wdt
isn't very strictly defined.

 .../bindings/timer/qcom,msm-timer.txt         | 47 -----------
 .../bindings/timer/qcom,msm-timer.yaml        | 78 +++++++++++++++++++
 2 files changed, 78 insertions(+), 47 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
 create mode 100644 Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml

diff --git a/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt b/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
deleted file mode 100644
index 5e10c345548f..000000000000
--- a/Documentation/devicetree/bindings/timer/qcom,msm-timer.txt
+++ /dev/null
@@ -1,47 +0,0 @@
-* MSM Timer
-
-Properties:
-
-- compatible : Should at least contain "qcom,msm-timer". More specific
-               properties specify which subsystem the timers are paired with.
-
-               "qcom,kpss-timer" - krait subsystem
-               "qcom,scss-timer" - scorpion subsystem
-
-- interrupts : Interrupts for the debug timer, the first general purpose
-               timer, and optionally a second general purpose timer, and
-               optionally as well, 2 watchdog interrupts, in that order.
-
-- reg : Specifies the base address of the timer registers.
-
-- clocks: Reference to the parent clocks, one per output clock. The parents
-          must appear in the same order as the clock names.
-
-- clock-names: The name of the clocks as free-form strings. They should be in
-               the same order as the clocks.
-
-- clock-frequency : The frequency of the debug timer and the general purpose
-                    timer(s) in Hz in that order.
-
-Optional:
-
-- cpu-offset : per-cpu offset used when the timer is accessed without the
-               CPU remapping facilities. The offset is
-               cpu-offset + (0x10000 * cpu-nr).
-
-Example:
-
-       timer@200a000 {
-               compatible = "qcom,scss-timer", "qcom,msm-timer";
-               interrupts = <1 1 0x301>,
-                            <1 2 0x301>,
-                            <1 3 0x301>,
-                            <1 4 0x301>,
-                            <1 5 0x301>;
-               reg = <0x0200a000 0x100>;
-               clock-frequency = <19200000>,
-                                 <32768>;
-               clocks = <&sleep_clk>;
-               clock-names = "sleep";
-               cpu-offset = <0x40000>;
-       };
diff --git a/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml b/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
new file mode 100644
index 000000000000..238eb985d0fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/timer/qcom,msm-timer.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/timer/qcom,msm-timer.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm MSM Timer
+
+maintainers:
+  - Rob Herring <robh@kernel.org>
+
+properties:
+  $nodename:
+    pattern: '^timer@[a-f0-9]+$'
+
+  compatible:
+    oneOf:
+      - items:
+          - const: qcom,kpss-timer
+          - enum:
+              - qcom,kpss-wdt-apq8064
+              - qcom,kpss-wdt-ipq8064
+              - qcom,kpss-wdt-msm8960
+          - const: qcom,msm-timer
+      - items:
+          - enum:
+              - qcom,kpss-timer  # Krait subsystem
+              - qcom,scss-timer  # Scorpion subsystem
+          - const: qcom,msm-timer
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    minItems: 1
+    items:
+      - description: 1st purpose timer
+      - description: 2nd general purpose timer
+      - description: 1st watchdog interrupt
+      - description: 2nd watchdog interrupt
+      - description: 3nd watchdog interrupt
+
+  clocks: true
+
+  clock-names: true
+
+  clock-frequency: true
+
+  cpu-offset:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: >
+      Per-cpu offset used when the timer is accessed without the
+      CPU remapping facilities. The offset is cpu-offset + (0x10000 * cpu-nr).
+
+required:
+  - compatible
+  - reg
+  - interrupts
+  - clock-frequency
+
+additionalProperties: false
+
+examples:
+  - |
+    timer@200a000 {
+        compatible = "qcom,scss-timer", "qcom,msm-timer";
+        interrupts = <1 1 0x301>,
+                     <1 2 0x301>,
+                     <1 3 0x301>,
+                     <1 4 0x301>,
+                     <1 5 0x301>;
+        reg = <0x0200a000 0x100>;
+        clock-frequency = <19200000>,
+                          <32768>;
+        clocks = <&sleep_clk>;
+        clock-names = "sleep";
+        cpu-offset = <0x40000>;
+    };
-- 
2.34.1

