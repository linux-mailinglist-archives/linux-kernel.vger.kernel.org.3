Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A2052B9A1
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236036AbiERL4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235965AbiERL4T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:56:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A39DB55BF;
        Wed, 18 May 2022 04:56:16 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id i40so2661936eda.7;
        Wed, 18 May 2022 04:56:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+A/4woOo192qqTkRjLVbL7AmgutNUKDEYrhbPWSEIww=;
        b=hBLSKEJTHtC3+1dEDg7GT1nUV/CKzTUjoKk2zRSn2QL3s+ZYozYyV8Qm9goHinditO
         hOuJoM0D1UmXoosbZsi45uE7L8vFjD02riODsVQs09mvqP/xijtDIExjOi2hvWDPfbF0
         C0lgEvp/VMB1UV9x2xlvSBPZgVQawsjavHsRFlSFZqwzmFPeBJjjJs8x3O31Y4kbgnhy
         T/6xE7Zbob8c3d/tfogiJ/MNGVJnH5V1kZYPGXabj3l/cm2mVU2uObVGVaaZmDwvAKN2
         MPYeqZNtwgNk4+M3jfSZwwfdRrpam+pdcaX26nBeCmqTPJmL7KCU8TvAO03QWxQWW7Us
         Egpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+A/4woOo192qqTkRjLVbL7AmgutNUKDEYrhbPWSEIww=;
        b=jbOz9q20SycpQ9xqh2aFNkCGllgn5/2tj2IJb4Jv/sIC9Z3Awvk8mmK7TNOSqqtar8
         kgvh3n3vo2XxuKihf8mwaOieJdfBLji3jPk/s5WX1WEe0HMACGLYClP2ATd6oYxgkKCw
         gKuV0I8vZpPEeHusg0LmAYejDKJqJ2USA5NING4yF8lXDpkL8czA0Tg1hIO4fGZLlorw
         lPrn8dgg27KEQnSD8CEkZDpnc4AkhSlT1CyNIbe6Eq13vr1X050bPs8PFIuyVW0HWjbA
         Uuijg7HIN55JSjvboahOeRxh4yWFpylMcfJkgKsSw5xEEmVYdX3O0Ipdxftmw3AbrSdS
         Lasg==
X-Gm-Message-State: AOAM533hnq338SlxawyDLZM5icGlVUxUvrN9XPkvt6ZacvujjpyYHrGf
        6lBe0xN6WmJHX2dveqPkIpM=
X-Google-Smtp-Source: ABdhPJw7EAfh/9Ch9Mnt9pi5tInayRrDWvKmcdnqjM7XPkDEyaDSMw1+dTgaaqvWbhBX7BcIeMNEaA==
X-Received: by 2002:a05:6402:5108:b0:427:e323:4c67 with SMTP id m8-20020a056402510800b00427e3234c67mr23894739edd.326.1652874974666;
        Wed, 18 May 2022 04:56:14 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id dq20-20020a170907735400b006f5294986besm873999ejc.111.2022.05.18.04.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 04:56:14 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Marek Vasut <marex@denx.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Maxime Ripard <mripard@kernel.org>,
        Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] dt-bindings: display: add new bus-format property for panel-dpi
Date:   Wed, 18 May 2022 13:55:38 +0200
Message-Id: <20220518115541.38407-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220518115541.38407-1-max.oss.09@gmail.com>
References: <20220518115541.38407-1-max.oss.09@gmail.com>
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

Changes in v2:
    - Fix errors found by dt_binding_check

 .../bindings/display/panel/panel-dpi.yaml     | 11 +++++++++
 .../dt-bindings/display/dt-media-bus-format.h | 23 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/dt-bindings/display/dt-media-bus-format.h

diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
index dae0676b5c6e..a20b5898941e 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
@@ -21,6 +21,14 @@ properties:
       - {}
       - const: panel-dpi
 
+  bus-format:
+    $ref: /schemas/types.yaml#/definitions/uint32
+    description: |
+      Describes how the display panel is connected to the display interface.
+      Valid values are defined in <dt-bindings/display/dt-media-bus-format.h>.
+      The mapping between the color/significance of the panel lines to the
+      parallel data lines are defined in [1].
+      [1] https://www.kernel.org/doc/html/v5.17/userspace-api/media/v4l/subdev-formats.html#packed-rgb-formats
   backlight: true
   enable-gpios: true
   height-mm: true
@@ -39,11 +47,14 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/display/dt-media-bus-format.h>
+
     panel {
         compatible = "startek,startek-kd050c", "panel-dpi";
         label = "osddisplay";
         power-supply = <&vcc_supply>;
         backlight = <&backlight>;
+        bus-format = <DT_MEDIA_BUS_FMT_RGB888_1X24>;
 
         port {
             lcd_in: endpoint {
diff --git a/include/dt-bindings/display/dt-media-bus-format.h b/include/dt-bindings/display/dt-media-bus-format.h
new file mode 100644
index 000000000000..c0f2a7b59aa1
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
+#define DT_MEDIA_BUS_FMT_RGB565_1X16		1
+#define DT_MEDIA_BUS_FMT_RGB666_1X18		2
+#define DT_MEDIA_BUS_FMT_RBG888_1X24		3
+#define DT_MEDIA_BUS_FMT_RGB666_1X24_CPADHI	4
+#define DT_MEDIA_BUS_FMT_BGR888_1X24		5
+#define DT_MEDIA_BUS_FMT_GBR888_1X24		6
+#define DT_MEDIA_BUS_FMT_RGB888_1X24		7
+#define DT_MEDIA_BUS_FMT_RGB888_1X32_PADHI	8
+
+#endif /* __DT_BINDINGS_DT_MEDIA_BUS_FORMAT_H */
-- 
2.20.1

