Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7A7478889
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 11:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbhLQKNM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 05:13:12 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:38992 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234756AbhLQKM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 05:12:58 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D6D8B82785;
        Fri, 17 Dec 2021 10:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52939C36AE5;
        Fri, 17 Dec 2021 10:12:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639735975;
        bh=tz94hJXS5Lpe+Fmm8yoGm62o/DyyDUvvDdbkBBkCTs4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W9wCq+gNxoW4yfF52ncTtYtgUBB0HB9mFooO+4nt++v5Yplh21tZg/buirz313GKV
         bkpLtScq4KjYI/UqACl9OTEyBCZsFHvzkgBbbMYfJfUyvo4IUe6I3X0t6K45KVUD4U
         AxrRg05NP/D+/IDTMKDP/52MmzPFeLUiFS1vyauxgx6FjGC+xEpZckDxD8QnlUwpIo
         fwfbHToV42ViH5ROS5iEiavXEEyjUz6nj6vHpLayuSq+5ZwiaH/RMPR8dYPKAh8kva
         lEbq4osu+XmoUb630GM0dWiXQVw5K7BrL9Xuin0tjXEnI1BJk+nXk+FlDA3cXfwFyu
         UiOsjpMimR59A==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1myAEP-000g68-5P; Fri, 17 Dec 2021 11:12:53 +0100
From:   Mauro Carvalho Chehab <mchehab@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>
Subject: [PATCH v2 1/7] dt-bindings: misc: add schema for USB hub on Kirin devices
Date:   Fri, 17 Dec 2021 11:12:45 +0100
Message-Id: <4533bc1f2287641c11069a6dab2800a3b0e74b22.1639735742.git.mchehab@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639735742.git.mchehab@kernel.org>
References: <cover.1639735742.git.mchehab@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yu Chen <chenyu56@huawei.com>

This patch adds binding documentation to support USB HUB and
USB data role switch of HiSilicon HiKey960 and HiKey970 boards.

[mchehab: updated OF schema and added HiKey970 example]
Signed-off-by: Yu Chen <chenyu56@huawei.com>
Signed-off-by: John Stultz <john.stultz@linaro.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Mauro Carvalho Chehab <mchehab@kernel.org>
---

See [PATCH v2 0/7] at: https://lore.kernel.org/all/cover.1639735742.git.mchehab@kernel.org/

 .../bindings/misc/hisilicon,hikey-usb.yaml    | 84 +++++++++++++++++++
 1 file changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml

diff --git a/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
new file mode 100644
index 000000000000..208c49478f1f
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
@@ -0,0 +1,84 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+# Copyright 2019 Linaro Ltd.
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/misc/hisilicon,hikey-usb.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: HiKey960/970 onboard USB GPIO Hub
+
+maintainers:
+  - John Stultz <john.stultz@linaro.org>
+
+description: |
+  Supports the onboard USB GPIO hubs found on HiKey960/970.
+  Such hubs require a power supply for the USB I/O. Depending on the
+  exact hub model, after USB I/O is powered up, a reset should be needed.
+
+  It also acts as a role-switch intermediary to detect the state of
+  the USB-C port, to switch the hub into dual-role USB-C or host mode,
+  which enables and powers up the onboard USB-A host ports.
+
+  Schematics about such hubs can be found here:
+    https://github.com/96boards/documentation/raw/master/consumer/hikey/hikey960/hardware-docs/HiKey960_Schematics.pdf
+    https://www.96boards.org/documentation/consumer/hikey/hikey970/hardware-docs/files/hikey970-schematics.pdf
+
+properties:
+  compatible:
+    enum:
+      - hisilicon,usbhub
+
+  typec-vbus-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandle to the typec-vbus gpio
+
+  otg-switch-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandle to the otg-switch gpio
+
+  hub-reset-en-gpios:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description: phandle to the hub reset gpio
+
+  usb-role-switch:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description: Support role switch.
+
+  hub-vdd-supply:
+    description: regulator for hub power
+
+  port:
+    description: |
+      describe a USB port and its endpoints.
+
+required:
+  - compatible
+  - hub-vdd-supply
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    usb-hub {
+        compatible = "hisilicon,usbhub";
+        typec-vbus-gpios = <&gpio25 2 GPIO_ACTIVE_HIGH>;
+        otg-switch-gpios = <&gpio25 6 GPIO_ACTIVE_HIGH>;
+        hub-reset-en-gpios = <&gpio0 3 GPIO_ACTIVE_HIGH>;
+        hub-vdd-supply = <&usb_hub_vdd>;
+        usb-role-switch;
+        port {
+            #address-cells = <1>;
+            #size-cells = <0>;
+            usb_ep0: endpoint@0 {
+                reg = <0>;
+                remote-endpoint = <&dwc3_role_switch>;
+            };
+            usb_ep1: endpoint@1 {
+                reg = <1>;
+                remote-endpoint = <&rt1711h_ep>;
+            };
+        };
+    };
-- 
2.33.1

