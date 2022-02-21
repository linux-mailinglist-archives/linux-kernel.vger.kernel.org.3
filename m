Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0534BED71
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 23:52:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235838AbiBUWwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 17:52:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbiBUWwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 17:52:08 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5AF34DEEB;
        Mon, 21 Feb 2022 14:51:44 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2965F139F;
        Mon, 21 Feb 2022 14:51:44 -0800 (PST)
Received: from e123648.arm.com (unknown [10.57.9.194])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E7E8C3F66F;
        Mon, 21 Feb 2022 14:51:41 -0800 (PST)
From:   Lukasz Luba <lukasz.luba@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     lukasz.luba@arm.com, dietmar.eggemann@arm.com,
        viresh.kumar@linaro.org, rafael@kernel.org,
        daniel.lezcano@linaro.org, nm@ti.com, sboyd@kernel.org,
        mka@chromium.org, dianders@chromium.org, robh+dt@kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [RFC][PATCH 1/2] dt-bindings: power: add Energy Model bindings
Date:   Mon, 21 Feb 2022 22:51:30 +0000
Message-Id: <20220221225131.15836-2-lukasz.luba@arm.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220221225131.15836-1-lukasz.luba@arm.com>
References: <20220221225131.15836-1-lukasz.luba@arm.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DT bindings for the Energy Model information.

Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 .../bindings/power/energy-model.yaml          | 51 +++++++++++++++++++
 1 file changed, 51 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/energy-model.yaml

diff --git a/Documentation/devicetree/bindings/power/energy-model.yaml b/Documentation/devicetree/bindings/power/energy-model.yaml
new file mode 100644
index 000000000000..804a9b324925
--- /dev/null
+++ b/Documentation/devicetree/bindings/power/energy-model.yaml
@@ -0,0 +1,51 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/power/energy-model.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Energy Model Bindings
+
+maintainers:
+  - Lukasz Luba <lukasz.luba@arm.com>
+
+description: |+
+  Devices work at specific performance states (frequencies). The power which
+  is used at a given performance state is an important information. A framework
+  which maintains this information is Energy Model. This document defines
+  bindings for these Energy Model performance states applicable across wide
+  range of devices. For illustration purpose, this document uses GPU as a device.
+
+  This binding only supports frequency-power pairs.
+
+select: true
+
+properties:
+  operating-points:
+    $ref: /schemas/types.yaml#/definitions/uint32-matrix
+    items:
+      items:
+        - description: Frequency in kHz
+        - description: Power in uW
+
+
+additionalProperties: true
+examples:
+    {
+       gpu_energy_model: energy-model {
+               compatible = "energy-model";
+               energy-model-entries = <
+                               200000 300000
+                               297000 500000
+                               400000 800000
+                               500000 1400000
+                               600000 2000000
+                               800000 2800000
+                               >;
+       };
+    };
+
+    &gpu {
+       energy-model = <&gpu_energy_model>;
+    };
+...
-- 
2.17.1

