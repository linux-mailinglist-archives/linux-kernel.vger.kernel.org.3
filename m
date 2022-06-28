Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96FDA55EC63
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234172AbiF1STe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233551AbiF1ST0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:19:26 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC3071FCF8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:19:25 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id ej4so18773027edb.7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 11:19:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tQ21Qe6/HH0PqwPXeho4j5BRYRtlFJgSmNIlYUUtH/g=;
        b=PmczDm6uIboA4bFF/FIMmGWl1NBWMB8ITGdyjJnQQRaWxoTfziOven4LtQBPx96NtX
         y49ow+C3A41T92WECRrRu3KZ83dIbdL1QeVl6NSieUODMA+WUsngHmsuAgbmVJbvuO8M
         /BUrzhCWzSMaSX03DJ5LzeXwCCITW9LFFQ3PAdhTulrgkxKIGdIXGpPS7pJ+qrQIhhge
         R418VGLzfiparjpmAHWAr4Kr81S8BTx4c5on8+1Ashzq2dx2OKTxz6Yaugb6mHkllzdp
         WI5JC8RtnVN5D2oj/KpyIsRYX6TaxxmK4cm/ufXBwS5BRfR9v6QZqgOYQaALa4uxEcRd
         0PSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tQ21Qe6/HH0PqwPXeho4j5BRYRtlFJgSmNIlYUUtH/g=;
        b=uPV78GSKdqzvt7whI/1kJdkJR9coAfz0gYz4PCE4KSB58XvpUuoXM3L1iQLGSCgZzg
         1QZIOWpZWX7te0kUUKmNgMvt5HQUrqIGzCY9kGLtDd43WhcYO7LLO7oaFLUIDLom53Uq
         Ex6nIH4uTbXi0QW3X7GcDDgU/svA36DjCoPcaFwBADk/S5NWQ/frhsuolQAzyrsSzuZ+
         Fs/uE7oHcBo5hDqjuu9CC6MCi5MK9b0VClXHy+1xHyzpzNP3eVyGOKOGdWBam0E28EK+
         APIT9/xeLnNtkznUpzTTg5vfQYQUOEBrUb5r/K/6jQhRsCW/CNGZvn9H7sgti8anIISl
         n6cg==
X-Gm-Message-State: AJIora8O124X1sc11iCw7hTY7iphgO38egACvHP3OBzm0L3DQXMYpK7S
        CtFIoQH7ScpPicUjghOIv6w=
X-Google-Smtp-Source: AGRyM1sfzeHqz9BmBxhOpol3io6Vf9MypkibuGC9+3ldWD5awns9qn/8hQhrcs/OSOeVi5NRYzwqtQ==
X-Received: by 2002:a05:6402:1a4d:b0:435:74ce:7b36 with SMTP id bf13-20020a0564021a4d00b0043574ce7b36mr24501675edb.94.1656440364333;
        Tue, 28 Jun 2022 11:19:24 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id r1-20020a17090638c100b007219c20dcd8sm6730824ejd.196.2022.06.28.11.19.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 11:19:23 -0700 (PDT)
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
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] drm/panel: simple: add bus-format support for panel-dpi
Date:   Tue, 28 Jun 2022 20:18:38 +0200
Message-Id: <20220628181838.2031-5-max.oss.09@gmail.com>
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

Evaluate the device tree bus-format property to set bus_format for
a 'panel-dpi' panel. Additionally infer the bpc value from the
given bus-format.

Valid values for bus-format are found in:
<include/dt-bindings/display/dt-media-bus-format.h>

This completes the addition of panel-dpi to completely specify
a panel-simple panel from the device tree.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v3:
- Moved the bus-format property under the port/endpoint node as
  suggested by Rob Herring

Changes in v2:
- Fix errors found by dt_binding_check

 drivers/gpu/drm/panel/panel-simple.c | 49 ++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4a2e580a2f7b..f1a457f1069e 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -21,9 +21,11 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/display/dt-media-bus-format.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
+#include <linux/of_graph.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_runtime.h>
@@ -449,10 +451,12 @@ static int panel_dpi_probe(struct device *dev,
 			   struct panel_simple *panel)
 {
 	struct display_timing *timing;
+	struct device_node *endpoint;
 	const struct device_node *np;
 	struct panel_desc *desc;
 	unsigned int bus_flags;
 	struct videomode vm;
+	u32 bus_format;
 	int ret;
 
 	np = dev->of_node;
@@ -477,6 +481,51 @@ static int panel_dpi_probe(struct device *dev,
 	of_property_read_u32(np, "width-mm", &desc->size.width);
 	of_property_read_u32(np, "height-mm", &desc->size.height);
 
+	endpoint = of_graph_get_endpoint_by_regs(np, -1, -1);
+	if (endpoint &&
+	    !of_property_read_u32(endpoint, "bus-format", &bus_format)) {
+		/* infer bpc from bus-format */
+		switch (bus_format) {
+		case DT_MEDIA_BUS_FMT_RGB565_1X16:
+			desc->bus_format = MEDIA_BUS_FMT_RGB565_1X16;
+			desc->bpc = 6;
+			break;
+		case DT_MEDIA_BUS_FMT_RGB666_1X18:
+			desc->bus_format = MEDIA_BUS_FMT_RGB666_1X18;
+			desc->bpc = 6;
+			break;
+		case DT_MEDIA_BUS_FMT_RGB666_1X24_CPADHI:
+			desc->bus_format = MEDIA_BUS_FMT_RGB666_1X24_CPADHI;
+			desc->bpc = 6;
+			break;
+		case DT_MEDIA_BUS_FMT_BGR888_1X24:
+			desc->bus_format = MEDIA_BUS_FMT_BGR888_1X24;
+			desc->bpc = 8;
+			break;
+		case DT_MEDIA_BUS_FMT_GBR888_1X24:
+			desc->bus_format = MEDIA_BUS_FMT_GBR888_1X24;
+			desc->bpc = 8;
+			break;
+		case DT_MEDIA_BUS_FMT_RBG888_1X24:
+			desc->bus_format = MEDIA_BUS_FMT_RBG888_1X24;
+			desc->bpc = 8;
+			break;
+		case DT_MEDIA_BUS_FMT_RGB888_1X24:
+			desc->bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+			desc->bpc = 8;
+			break;
+		case DT_MEDIA_BUS_FMT_RGB888_1X32_PADHI:
+			desc->bus_format = MEDIA_BUS_FMT_RGB888_1X32_PADHI;
+			desc->bpc = 8;
+			break;
+		default:
+			dev_err(dev, "%pOF: unknown bus-format property\n", np);
+			return -EINVAL;
+		}
+	}
+
+	of_node_put(endpoint);
+
 	/* Extract bus_flags from display_timing */
 	bus_flags = 0;
 	vm.flags = timing->flags;
-- 
2.20.1

