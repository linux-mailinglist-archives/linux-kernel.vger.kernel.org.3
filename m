Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FCAF4CC8FD
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236995AbiCCWdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:33:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236948AbiCCWdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:33:00 -0500
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EE8158DA4
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:32:08 -0800 (PST)
Received: by mail-oi1-x231.google.com with SMTP id y7so6177775oih.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 14:32:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ASiZOAYz5KFcP3A9IjHRNygM9ZeiNc0Yjtm5LFE6Rdc=;
        b=ae3+M6IkfZ5jIJWwSuAWT+APA3geWlw1DsEAgf4oY1C9rMvnx9bK68l4Zv+1+d21JF
         H43hFi1TMM69h7jkLG8okLLEx7uXxHJdI2TgdG4ioF5OcavJWIcKrbCBM8a2ze9hj0Wb
         vw+2AHq3ru1fv0yg+3ybHn+fzAFilDUx7F5N4gv2GPwIB1z7eg4A73mPWetezFqe+Dca
         AcqNmM9be1MyP0wLK+bq+gbR2AoTuzbzFBBNHr7g1Qpd/6fV56gpEFyzncZk7OgnmRUK
         zsETF1Ke4Mafo0nHUmGb3d8oqz/uB1CpsS2xxajo8Vlm10aoQU+rXrGGRJJ4EUeXFOHL
         iQMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ASiZOAYz5KFcP3A9IjHRNygM9ZeiNc0Yjtm5LFE6Rdc=;
        b=Sy/9Pz4NiLKMjeLeE8dcFqxKqLUVXS0zwZfOROLTXeP+GYjTUWpGa9XBE6ATV7VpiR
         Mgt6BHrryqsDgRpo28sDIy/Zs5I0NUa9TbmNgmahapgv/rDogjE+wpzUL4eXZX9Rqno1
         1KOZmNiKwCrvv5VrdOV16b/TVO/kYlHW7uTilCqATTOXsClvOZYUKaZEsuKL4ln0CKp/
         eeEldZrEV0fUi2J+UzJjNPIbiz3+kRuNGKhymz5gd07waM7b/tJALW3JaVtc1TJci8OV
         yLsOxMJKjWkHrMmd++qwtXhK1LF/UQVqi09IUxVx3Py/TWZk+J9XfkFk9KH2+tx356cQ
         FKvQ==
X-Gm-Message-State: AOAM533icNWusMlt+j7AN7VKsHhS/A/pM9Ha/9sLzjzs+jwi8Bwx6m9l
        3udQXpLbou5VnZZXgBTZ/DoW6w==
X-Google-Smtp-Source: ABdhPJwZTpBb0lAcz7RJZp79KrGZH2AYZv5mXWcLJKlyRZFmJ6c0paiUJ4LUztTfkTxB/BrAkOdzBA==
X-Received: by 2002:a05:6808:1402:b0:2d3:4a20:3dfa with SMTP id w2-20020a056808140200b002d34a203dfamr6624463oiv.143.1646346727905;
        Thu, 03 Mar 2022 14:32:07 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id fq14-20020a0568710b0e00b000d4492531a2sm1764777oab.17.2022.03.03.14.32.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 14:32:07 -0800 (PST)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Daniel Scally <djrscally@gmail.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>
Cc:     linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Rob Herring <robh@kernel.org>
Subject: [PATCH v3 5/6] dt-bindings: usb: Add binding for fcs,fsa4480
Date:   Thu,  3 Mar 2022 14:33:50 -0800
Message-Id: <20220303223351.141238-5-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220303223351.141238-1-bjorn.andersson@linaro.org>
References: <20220303223351.141238-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Fairchild/ON Semiconductor FSA4480 Analog Audio switch is used in
USB Type-C configurations for muxing analog audio onto the USB
connector, and as such used to control the SBU signals for altmodes such
as DisplayPort.

Add a binding for this hardware block.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

Changes since v2:
- Picked up Rob's reviewed-by

Changes since v1:
- None

 .../devicetree/bindings/usb/fcs,fsa4480.yaml  | 72 +++++++++++++++++++
 1 file changed, 72 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml

diff --git a/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
new file mode 100644
index 000000000000..9473f26b0621
--- /dev/null
+++ b/Documentation/devicetree/bindings/usb/fcs,fsa4480.yaml
@@ -0,0 +1,72 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: "http://devicetree.org/schemas/usb/fcs,fsa4480.yaml#"
+$schema: "http://devicetree.org/meta-schemas/core.yaml#"
+
+title: ON Semiconductor Analog Audio Switch
+
+maintainers:
+  - Bjorn Andersson <bjorn.andersson@linaro.org>
+
+properties:
+  compatible:
+    enum:
+      - fcs,fsa4480
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vcc-supply:
+    description: power supply (2.7V-5.5V)
+
+  mode-switch:
+    description: Flag the port as possible handle of altmode switching
+    type: boolean
+
+  orientation-switch:
+    description: Flag the port as possible handler of orientation switching
+    type: boolean
+
+  port:
+    $ref: /schemas/graph.yaml#/properties/port
+    description:
+      A port node to link the FSA4480 to a TypeC controller for the purpose of
+      handling altmode muxing and orientation switching.
+
+required:
+  - compatible
+  - reg
+  - port
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c13 {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        fsa4480@42 {
+          compatible = "fcs,fsa4480";
+          reg = <0x42>;
+
+          interrupts-extended = <&tlmm 2 IRQ_TYPE_LEVEL_LOW>;
+
+          vcc-supply = <&vreg_bob>;
+
+          mode-switch;
+          orientation-switch;
+
+          port {
+            fsa4480_ept: endpoint {
+              remote-endpoint = <&typec_controller>;
+            };
+          };
+        };
+    };
+...
-- 
2.33.1

