Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9114754AE
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 09:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241005AbhLOIys (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 03:54:48 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:52512 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbhLOIyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 03:54:41 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BAFB661852;
        Wed, 15 Dec 2021 08:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D0BFC34605;
        Wed, 15 Dec 2021 08:54:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639558480;
        bh=x4q0tu62o/JYyXjdCl3J5rt+WUYZdMXINBc2PlhIulg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQJP80DhS4g9u+FM7H5GVi3EqvD1qqZcIK18UkbXWPUX44GV+L2utoVBhZVdu11sI
         DqWLMwJC5W8aL5Af89Ldp1mBkDwAo+xBFh6qpaXTPuEVQZ+3twf+0GZMdFW7CtehU4
         NISLeJCXsoz/5RQC2/xdJBMjeRPGfmsmAeE1wI4CfwoEiG1y6Ev7Zk49ySgp9DlGRC
         GOU7ACp3V7/oyKE6+itkTOB2HPV0ujovLYxf3MfZVvzZKmwmQfN5zIMSKZlbbaKimU
         jD/clAjJX3i6bbgW30sskH+AxEmlAtStmv7JUix+diS1YRVE7kRoYjMT7/ZE/ROM25
         gN88Q7wLO1WKw==
Received: from mchehab by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1mxQ3Z-0054Hs-Kj; Wed, 15 Dec 2021 09:54:37 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Wei Xu <xuwei5@hisilicon.com>, Rob Herring <robh+dt@kernel.org>
Cc:     Yu Chen <chenyu56@huawei.com>,
        John Stultz <john.stultz@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Subject: [PATCH RESEND 1/7] dt-bindings: misc: add schema for USB hub on Kirin devices
Date:   Wed, 15 Dec 2021 09:54:27 +0100
Message-Id: <9c3a3ff59408fcb60f7a5817a6f5d5f3053367fc.1639558366.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1639558366.git.mchehab+huawei@kernel.org>
References: <cover.1639558366.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
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
---

To avoid mailbombing on a large number of people, only mailing lists were C/C on the cover.
See [PATCH RESEND 0/7] at: https://lore.kernel.org/all/cover.1639558366.git.mchehab+huawei@kernel.org/

 .../bindings/misc/hisilicon,hikey-usb.yaml    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml

diff --git a/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
new file mode 100644
index 000000000000..761ab686121a
--- /dev/null
+++ b/Documentation/devicetree/bindings/misc/hisilicon,hikey-usb.yaml
@@ -0,0 +1,87 @@
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
+      describe hadware connections between USB endpoints.
+      Two ports are supported: the first being the endpoint that will
+      be notified by this driver, and the second being the endpoint
+      that notifies this driver of a role switch.
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

