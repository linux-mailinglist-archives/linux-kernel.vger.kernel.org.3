Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9377E55EC60
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:19:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233829AbiF1ST2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:19:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232467AbiF1STY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:19:24 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0A51FCF8;
        Tue, 28 Jun 2022 11:19:23 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id g26so27476665ejb.5;
        Tue, 28 Jun 2022 11:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QDzRSgTFisXj4PhtHzenD5g/xgSjfVV7DuADmvvCFi4=;
        b=KjOrEhBWvtHjEyKbpXF7eQD4bLkJuwue0iuwTZJTw5hNgkEN3O8cqoFiHp+R0M4qIB
         hUKCXk0gVivWEe2CV525KldBaU74ez+Dftnz1LAn5nhEow3JsRXIdzxrqcsG+/1jXMW8
         i2YDIRSMtjoPBIC3qlsemd6lYJI7q1vRHBTMjqO1HccKPG1yEp8xyOplZzUU2xqDgOd4
         FNh4mBA2WnIZOjMUJaVeCeMM9FZ1SZbgCdcWGENLoAUz1txjfIU5v3MyVZE1d8piLRHw
         2zxvdhlNcPxImU9pyVOt4je3tu4t9JZmwhXA8BH20N1AURbZRn6cRp5jrLk/uRA2pBL9
         Htug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QDzRSgTFisXj4PhtHzenD5g/xgSjfVV7DuADmvvCFi4=;
        b=MveOM3YnP5kiW2XCccP89P42LyGSxQKZ3VZJ6Zya9bgUP2JB3TLrRq4Sq7HkXTPq/A
         oRZytbgSvJhU8SoxbIlla6E1cFtnKDNnbBVLT1SB6QPbb/eYpoJI+EGqPQTAvSTInQW7
         3SObxuq74XiqwcFFqWP8U8xcl7QF76lsvzoEJDnyrtHsn3t5iVj8XbuLM7HgSosIer2p
         QNVPB71L6zZCZiwgkkU3oLcXABafS5jpdsOkTMxG2eO9WCLS4ClH6zTuEYoxSiRnSM3v
         UqetaXxhN3PEn3LoajwDyta1qzu6f3knpcfik0zuavqWFLqGfuElfw14VHuWDkWN98MZ
         orOQ==
X-Gm-Message-State: AJIora+40fN/lOzLUI5XNqLdLJ5TfB/jK1GXCdYyP1QWTtc2ZOjlxEer
        f0bSRZghBJuzPqZm5m3O544=
X-Google-Smtp-Source: AGRyM1vBJjG4uIergMlENJ7RYpKM+QuPhC2nbICQYgDNlFIIXLBRz8dC3CqcVT568BW5XQ2Qui0HdQ==
X-Received: by 2002:a17:907:60c8:b0:726:d5c1:385c with SMTP id hv8-20020a17090760c800b00726d5c1385cmr3812511ejc.490.1656440361725;
        Tue, 28 Jun 2022 11:19:21 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm6730824ejd.196.2022.06.28.11.19.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:19:21 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Rob Herring <robh@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Maxime Ripard <mripard@kernel.org>,
        Marek Vasut <marex@denx.de>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/4] dt-bindings: display: add new bus-format property for panel-dpi
Date:   Tue, 28 Jun 2022 20:18:36 +0200
Message-Id: <20220628181838.2031-3-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220628181838.2031-1-max.oss.09@gmail.com>
References: <20220628181838.2031-1-max.oss.09@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Max Krummenacher <max.krummenacher@toradex.com>

The property is used to set the enum bus_format and infer the bpc
for a panel defined by 'panel-dpi'.
This specifies how the panel is connected to the display interface.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v3:
- Changed the V4L number space as suggested by Rob Herring
- Set constraints for bus-format as suggested by Rob Herring, used
  the range reserved for RGB formats.
- Editorial changes as suggested by Rob Herring
- Moved the bus-format property under the port/endpoint node as
  suggested by Rob Herring

Changes in v2:
- Fix errors found by dt_binding_check

 .../bindings/display/panel/panel-dpi.yaml     | 26 ++++++++++++++++++-
 .../dt-bindings/display/dt-media-bus-format.h | 23 ++++++++++++++++
 2 files changed, 48 insertions(+), 1 deletion(-)
 create mode 100644 include/dt-bindings/display/dt-media-bus-format.h

diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
index dae0676b5c6e..52f5db03b6a8 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
@@ -26,7 +26,28 @@ properties:
   height-mm: true
   label: true
   panel-timing: true
-  port: true
+
+  port:
+    $ref: /schemas/graph.yaml#/$defs/port-base
+    description:
+      Input port node, receives the panel data.
+
+    properties:
+      endpoint:
+        $ref: /schemas/graph.yaml#/$defs/endpoint-base
+
+        properties:
+          bus-format:
+            $ref: /schemas/types.yaml#/definitions/uint32
+            minimum: 0x1001
+            maximum: 0x1fff
+            description: |
+              Describes how the display panel is connected to the display interface.
+              Valid values are defined in <dt-bindings/display/dt-media-bus-format.h>.
+              The mapping between the color/significance of the panel lines to the
+              parallel data lines are defined in:
+              https://www.kernel.org/doc/html/v5.17/userspace-api/media/v4l/subdev-formats.html#packed-rgb-formats
+
   power-supply: true
   reset-gpios: true
   width-mm: true
@@ -39,6 +60,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/display/dt-media-bus-format.h>
+
     panel {
         compatible = "startek,startek-kd050c", "panel-dpi";
         label = "osddisplay";
@@ -47,6 +70,7 @@ examples:
 
         port {
             lcd_in: endpoint {
+                bus-format = <DT_MEDIA_BUS_FMT_RGB888_1X24>;
                 remote-endpoint = <&dpi_out>;
             };
         };
diff --git a/include/dt-bindings/display/dt-media-bus-format.h b/include/dt-bindings/display/dt-media-bus-format.h
new file mode 100644
index 000000000000..a032d9724ed4
--- /dev/null
+++ b/include/dt-bindings/display/dt-media-bus-format.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0-only OR MIT */
+/*
+ * Copyright 2022 Max Krummenacher <max.krummenacher@toradex.com>
+ */
+
+#ifndef __DT_BINDINGS_DT_MEDIA_BUS_FORMAT_H
+#define __DT_BINDINGS_DT_MEDIA_BUS_FORMAT_H
+
+/*
+ * Attention: Keep these macro names in sync with
+ * include/uapi/linux/media-bus-format.h
+ */
+
+#define DT_MEDIA_BUS_FMT_RGB565_1X16		0x1017
+#define DT_MEDIA_BUS_FMT_RGB666_1X18		0x1009
+#define DT_MEDIA_BUS_FMT_RBG888_1X24		0x100e
+#define DT_MEDIA_BUS_FMT_RGB666_1X24_CPADHI	0x1015
+#define DT_MEDIA_BUS_FMT_BGR888_1X24		0x1013
+#define DT_MEDIA_BUS_FMT_GBR888_1X24		0x1014
+#define DT_MEDIA_BUS_FMT_RGB888_1X24		0x100a
+#define DT_MEDIA_BUS_FMT_RGB888_1X32_PADHI	0x100f
+
+#endif /* __DT_BINDINGS_DT_MEDIA_BUS_FORMAT_H */
-- 
2.20.1

