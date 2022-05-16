Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88798528A62
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343676AbiEPQ3c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343633AbiEPQ3N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:29:13 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8DCA3B02A;
        Mon, 16 May 2022 09:29:10 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id gh6so29837292ejb.0;
        Mon, 16 May 2022 09:29:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hJB5QWTkjOe+A3TmBJQWslNfP6ImokdCskIDq0K0JSM=;
        b=DnhHqyh6nEcagUBSwSL40ZweMeOpDzDwVizgwFmVcHjJ/CbyNvQe/YL0Q/Sm4VGTef
         snsNOJJGUmDBwBZmNxTZi/yeO28knuXU3t/9CaHyTMjnNfnA+TzcqyFqKjxsB9Y/ucmF
         K10r77Qx0BDVHbx/Qbc2sjxngOV2307zrtQNiPA3dNgys+L3hEaytD7diKMlFZoqZ+gH
         mxnrwG53b5Owa7VQ1Inessh3sUouGHbZEOLGjWEZ+vUC/vH9cRhFpaz4XhdzC+B9FsMz
         4u2kjGEkmvPsnNVLbrePD09DJ2kODMtCttp9GHbTS2BuFJ4fysxycGxi/1+iRChtNXib
         6Hag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hJB5QWTkjOe+A3TmBJQWslNfP6ImokdCskIDq0K0JSM=;
        b=g73rm4OkFmigJcBMg+CQBshDx9L3baQs0xRR9/uMvtZRunVkA30E4db6+REqDaKFBD
         0ZuHIVrIAYcM7Vaq6T5Q0fRxprm1JNom/fnkM/jARuwcOLsS72fzuz+hhARNwx5078tt
         WqXPB2UlT0EetFr/pl7vOJc767xc6vhHIXEigtkIbhRziic0hUhj3Jr/NdNHKEU5tVrP
         rbL1Vj5Wp2TqkLZCEZzRfSMhHts38OvEA6Y01SwWC6/5DNfevxq+1qe2LCz3+HS6essn
         mPn7+PNm+c51o6BjNmpkY3gQVR4/oJDcDrhbNgpSgNZTrUztEbRQRQlPlkJs/Wm7zj4W
         pbww==
X-Gm-Message-State: AOAM532Ipbkj1N17Xyxtl2IpVOzRI61//l1+JwdDxmSuHETu4SnoK6m5
        r/cgxTT8Qp1KoAmo8iT4SLM=
X-Google-Smtp-Source: ABdhPJyZcntD5axDOHiDmfr5EqB4Uv2Nmp/U52P8mLja7/bBTGWg/cytwgQKXKtLEFZNZBC9ymNpMw==
X-Received: by 2002:a17:907:3e8f:b0:6f4:4f42:a75f with SMTP id hs15-20020a1709073e8f00b006f44f42a75fmr16158090ejc.695.1652718549038;
        Mon, 16 May 2022 09:29:09 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906004900b006f3ef214e3bsm58819ejg.161.2022.05.16.09.29.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:29:08 -0700 (PDT)
From:   Max Krummenacher <max.oss.09@gmail.com>
To:     max.krummenacher@toradex.com
Cc:     Christoph Niedermaier <cniedermaier@dh-electronics.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Maxime Ripard <mripard@kernel.org>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/2] dt-bindings: display: add new bus-format property for panel-dpi
Date:   Mon, 16 May 2022 18:28:25 +0200
Message-Id: <20220516162826.23025-2-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20220516162826.23025-1-max.oss.09@gmail.com>
References: <20220516162826.23025-1-max.oss.09@gmail.com>
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

 .../bindings/display/panel/panel-dpi.yaml     | 11 +++++++++
 .../dt-bindings/display/dt-media-bus-format.h | 23 +++++++++++++++++++
 2 files changed, 34 insertions(+)
 create mode 100644 include/dt-bindings/display/dt-media-bus-format.h

diff --git a/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml b/Documentation/devicetree/bindings/display/panel/panel-dpi.yaml
index dae0676b5c6e..ca44e96c3001 100644
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
+    ...
     panel {
         compatible = "startek,startek-kd050c", "panel-dpi";
         label = "osddisplay";
         power-supply = <&vcc_supply>;
         backlight = <&backlight>;
+        bus-format = "DT_MEDIA_BUS_FMT_RGB888_1X24";
 
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

