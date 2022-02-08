Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AFC4ACF9A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 04:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346402AbiBHDR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 22:17:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346343AbiBHDRf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 22:17:35 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584E6C0401E6
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 19:17:31 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id k13-20020a4a948d000000b003172f2f6bdfso10739935ooi.1
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 19:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OTRVq8PpVu//vt/IgzSV5+XNtw1vJPrl7jfHJ1N1q2k=;
        b=CQzvhJ6+adAFGsOiX5Pabvae50+/HQzV8PZdM3khyC1ZKPPCo8onTNmo9XXHCIM/HF
         1iU8vR/mBQ/wKLKl8Ghdnj/GBXAkdfAKRx/txUqyCaEsqN9nLSSsVN/EzX2CAgFBy8HB
         KHr73C8YAj+cH7aJFLMbV/0N0840/wexW+/KsPUQTwCLvpBZpRyHCr7qKqAV8asMKMjU
         xjmtBp3tyVO1EMZy3ALxJQGNuncGQItLEJu0P87Xre5qbbnlR6n1ud0hI9vcBSvdc05J
         p352wrsJB6RpQUMWL9at9BGeew5zrPj+9TesT7eAAfyvsSSCBJN8uNspU7sXHs0G1/5l
         QrlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OTRVq8PpVu//vt/IgzSV5+XNtw1vJPrl7jfHJ1N1q2k=;
        b=hff4xqFDkd2ej81LuFaVMXZj44RmQdEPr5ilJRJYyfUHCJFk5VxYGnnSJtM1aqhwXi
         1OrMgOipqTopYsOzcM/Jy/4Mm4TRLlOHqBzE9iBhKc/7UimvqkU3NKwNuwJvxI9meR7N
         rRUJc6763SRlSf5WmdJKJa+cX14jNb383ban4mUrALtXff+97PkUFzdAQHNxviuTAVIm
         wnzzpTMJxzRRszkhgorqJztwiRmeARc9ppEDuGOoUw3HeoL2NNXGXAnssd765VULl+w3
         Qkr/v51V9OBKOn4PZtg4GBOBWkFPvK1yzrhmNh4ENGqn/ROeHW0JDXWlNF7+H2vVxmlZ
         +AYg==
X-Gm-Message-State: AOAM530Wm4Uw44TI1e14J+Jz1ZWEnEm+nv5tQqgfEMtOARtsH0Nvc8Yk
        vzCwFVAzO6YAlpkmeB8a2tLsgA==
X-Google-Smtp-Source: ABdhPJwf9Oa/yS/n5v8HciTRVxjeWulvkF+DJYvLjcsaThC/MGhg+d4EzOLcmscaNUI4nXkN4u+fkQ==
X-Received: by 2002:a05:6870:9511:: with SMTP id u17mr684972oal.300.1644290250381;
        Mon, 07 Feb 2022 19:17:30 -0800 (PST)
Received: from ripper.. ([2600:1700:a0:3dc8:205:1bff:fec0:b9b3])
        by smtp.gmail.com with ESMTPSA id k3sm4763873otl.41.2022.02.07.19.17.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 19:17:29 -0800 (PST)
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
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: [PATCH v2 5/6] dt-bindings: usb: Add binding for fcs,fsa4480
Date:   Mon,  7 Feb 2022 19:19:43 -0800
Message-Id: <20220208031944.3444-6-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220208031944.3444-1-bjorn.andersson@linaro.org>
References: <20220208031944.3444-1-bjorn.andersson@linaro.org>
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

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---

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

