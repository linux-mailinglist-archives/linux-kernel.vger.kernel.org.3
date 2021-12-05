Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 92B94468E04
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 00:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238540AbhLEXTy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 18:19:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbhLEXTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 18:19:50 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87E0FC0613F8
        for <linux-kernel@vger.kernel.org>; Sun,  5 Dec 2021 15:16:22 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id i8-20020a7bc948000000b0030db7b70b6bso9110728wml.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Dec 2021 15:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+c/CHs8+P5F4ROQuUBwTx+ZVLn3ISFq8kc+Oou9iGQ8=;
        b=dAGmoX48rPq8f8yClhp/9pEBKE0wneGWphnEqgy9lL9akQfNz1quxO3SJXvAPC8zg/
         x2Q2plsEBr2kV7BHv1UEvnXXkBMGxSgMfVzkc3C0VmBaF5KMy90UdfvlKeOHPLE40z6V
         JnMUS2kBXX1WsANtZ9RL2L3Coxtr8ZYXnJW8ax5y0uIyshFKzOkKxgAQwVNl5BV492H1
         rwWz3uNPyOPA4ImcMf70NOhDMrVVZRHLwBUGwLkfSnZbRzLyKtmCT/zsBeCpP+eMjl1q
         geYTAh/A5NKsNyyWAqO/zqdTiSba/3wI73QySpp8q1d3ikrFKdz0P59jkcL8ySwYQ2s4
         uDcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=+c/CHs8+P5F4ROQuUBwTx+ZVLn3ISFq8kc+Oou9iGQ8=;
        b=iEL2T6CUNfDwRIN6gI3Qoen4uk1zk2Gq0ncisakEzEev50z1snxLi+Vs48ASChnO0L
         2e8zgEBM3WCntzKs3Xn2onp3y2Y2QCPAoe6lz0ZIMVpnMMfpArH2ch9MG9Va1s3TM7ps
         0RKnV+80F6uc6h6fjykr78nw2CrneG+N1PthiEP3q3QkdajW6Rh3hI9tprhKeA2bP9AA
         eblAVI0oFb0dfVPazFqHgortIA99iNaiTPaG2DasavDOgmwLU+MzYJFUcefkJfJo3j84
         3w3LQepkzUonW7rl6+aonGgz2tqWpd3uvHcwW5ITnAxEIo7390TA4ryPBfUMn4czZWJZ
         YRsQ==
X-Gm-Message-State: AOAM530mCJeGn0hl5ltLuRNK0PiK/45+QyAdF95bhfU9jhVz4qYdXean
        HSHCJ9+ZykYHIqg57XQKH1MHQw==
X-Google-Smtp-Source: ABdhPJwljnwNzc2F5v5ySS4bugsbhLnbG29KOvP4c+1SZcp8/mX3i1Lh4VIFKqoqSuN1Kwhy4cWsRA==
X-Received: by 2002:a1c:ed0a:: with SMTP id l10mr33951514wmh.140.1638746180791;
        Sun, 05 Dec 2021 15:16:20 -0800 (PST)
Received: from localhost.localdomain ([2a01:e34:ed2f:f020:1cec:4235:bb04:b944])
        by smtp.gmail.com with ESMTPSA id c10sm10715312wrb.81.2021.12.05.15.16.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Dec 2021 15:16:18 -0800 (PST)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, robh@kernel.org
Cc:     arnd@linaro.org, heiko@sntech.de, ulf.hansson@linaro.org,
        rjw@rjwysocki.net, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        lukasz.luba@arm.com, Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>
Subject: [PATCH v4 1/5] dt-bindings: Powerzone new bindings
Date:   Mon,  6 Dec 2021 00:15:53 +0100
Message-Id: <20211205231558.779698-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The proposed bindings are describing a set of powerzones.

A power zone is the logical name for a component which is capable of
power capping and where we can measure the power consumption.

A power zone can aggregate several power zones in terms of power
measurement and power limitations. That allows to apply power
constraint to a group of components and let the system balance the
allocated power in order to comply with the constraint.

The ARM System Control and Management Interface (SCMI) can provide a
power zone description.

The powerzone semantic is also found on the Intel platform with the
RAPL register.

The Linux kernel powercap framework deals with the powerzones:

https://www.kernel.org/doc/html/latest/power/powercap/powercap.html

The powerzone can also represent a group of children powerzones, hence
the description can result on a hierarchy. Such hierarchy already
exists with the hardware or can be represented and computed from the
kernel.

The hierarchical description was initially proposed but not desired
given there are other descriptions like the power domain proposing
almost the same description.

https://lore.kernel.org/all/CAL_JsqLuLcHj7525tTUmh7pLqe7T2j6UcznyhV7joS8ipyb_VQ@mail.gmail.com/

The description gives the power constraint dependencies to apply on a
specific group of logically or physically aggregated devices. They do
not represent the physical location or the power domains of the SoC
even if the description could be similar.

Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
   V3:
     - Removed required property 'compatible'
     - Removed powerzone-cells from the topmost node
     - Removed powerzone-cells from cpus 'consumers' in example
     - Set additionnal property to false
   V2:
     - Added pattern properties and stick to powerzone-*
     - Added required property compatible and powerzone-cells
     - Added additionnal property
     - Added compatible
     - Renamed to 'powerzones'
     - Added missing powerzone-cells to the topmost node
     - Fixed errors reported by 'make DT_CHECKER_FLAGS=-m dt_binding_check'
   V1: Initial post
---
 .../devicetree/bindings/power/powerzones.yaml | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/powerzones.yaml

diff --git a/Documentation/devicetree/bindings/power/powerzones.yaml b/Documentation/devicetree/bindings/power/powerzones.yaml
new file mode 100644
index 000000000000..ddb790acfea6
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/powerzones.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: GPL-2.0
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/powerzones.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Power zones description
+
+maintainers:
+  - Daniel Lezcano <daniel.lezcano@linaro.org>
+
+description: |+
+
+  A System on Chip contains a multitude of active components and each
+  of them is a source of heat. Even if a temperature sensor is not
+  present, a source of heat can be controlled by acting on the
+  consumed power via different techniques.
+
+  A powerzone describes a component or a group of components where we
+  can control the maximum power consumption. For instance, a group of
+  CPUs via the performance domain, a LCD screen via the brightness,
+  etc ...
+
+  Different components when they are used together can significantly
+  increase the overall temperature, so the description needs to
+  reflect this dependency in order to assign a power budget for a
+  group of powerzones.
+
+  This description is done via a hierarchy and the DT reflects it. It
+  does not represent the physical location or a topology, eg. on a
+  big.Little system, the little CPUs may not be represented as they do
+  not contribute significantly to the heat, however the GPU can be
+  tied with the big CPUs as they usually have a connection for
+  multimedia or game workloads.
+    
+properties:
+  $nodename:
+    const: powerzones
+
+patternProperties:
+  "^(powerzone)([@-].*)?$":
+    type: object
+    description:
+      A node representing a powerzone acting as an aggregator for all
+      its children powerzones.
+
+    properties:
+      "#powerzone-cells":
+        description:
+          Number of cells in powerzone specifier. Typically 0 for nodes
+          representing but it can be any number in the future to
+          describe parameters of the powerzone.
+
+      powerzones:
+        description:
+          A phandle to a parent powerzone. If no powerzone attribute is
+          set, the described powerzone is the topmost in the hierarchy.
+
+    required:
+      - "#powerzone-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    powerzones {
+
+      SOC_PZ: powerzone-soc {
+        #powerzone-cells = <0>;
+      };
+
+      PKG_PZ: powerzone-pkg {
+        #powerzone-cells = <0>;
+        powerzones = <&SOC_PZ>;
+      };
+
+      GPU_PZ: powerzone-gpu {
+        #powerzone-cells = <0>;
+        powerzones = <&PKG_PZ>;
+      };
+    };
+
+  - |
+    A57_0: big@0 {
+      compatible = "arm,cortex-a57";
+      reg = <0x0 0x0>;
+      device_type = "cpu";
+      powerzones = <&PKG_PZ>;
+    };
+
+    A57_1: big@1 {
+      compatible = "arm,cortex-a57";
+      reg = <0x0 0x0>;
+      device_type = "cpu";
+      powerzones = <&PKG_PZ>;
+    };
+...
-- 
2.25.1

