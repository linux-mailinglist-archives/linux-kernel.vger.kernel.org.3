Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3D19528A63
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 18:29:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343668AbiEPQ3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 12:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343645AbiEPQ3M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 12:29:12 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A8B3A5FC
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:29:11 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id i19so29696204eja.11
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 09:29:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Y5Y01zEzcSsKU36y1NINY4WVk0Q8FiEw0n1MhQ5vAp8=;
        b=MzyxhcHxfpe4omR3oQIY9vDe3Ma0gJNH+l6vr8yMxzIcE7WLpzv3gQNngtko+7CHYK
         wnP0JeSPU3TtjfSYW/enDtVoXotkr2zQaxjJ4/noQLVUmKYH/Evyj3q+VW9NG0M+7/sb
         ytL/7GBUy8dZKftxMPUtkUWexMF7cLI54DvLkj9ENKp2ajx9lcLrjW/wH4upreuq5cYF
         qM0rYYi40WxtyS/YxBSmjDaGd6XUd6zhO6FYmPFSzl9krsIP29DwGB1BnX/jGT0qMgxM
         5L27yb+KWA/IP1ElTWNYxoAkEazXi+bOENadZ9R133tfM5XSvTKGWI9l0NBcNVKqxbtX
         5PbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Y5Y01zEzcSsKU36y1NINY4WVk0Q8FiEw0n1MhQ5vAp8=;
        b=BSr8VPh9H+hUL2ogMjCNaWtoFO7axQZ/m0Htn1N3SkHAcHeyTkz7rOolPUdKsLKvxu
         uIlEelDpbgJVCrSVzw1nsP/ivWj2S5qY+PIZ+4r2NpxM/of3GU5HZMs0aX8cbb9j8p/F
         Ms3p8cNI59QuT+JJJg2+1FTBHTeKXWxoupXHIFRLpFJ2uy8mBDNBO5iDjSIdLh9gfZXq
         6037t/xrg+YvDwqbkKYQ+9G6lfMtncq8o6ky/B+1TFSgjoA1qdeZ7WVaZKEJstrIdikz
         K06omywJmdKMQcyR/Kw01HqP35roLD2ByynHqIpAILTkUbaN5DxbtPzv7gat4TKgDoVi
         I9WQ==
X-Gm-Message-State: AOAM53242PeW6kLmPRk9p9oyVUFqFqSw5VXWouZRWKk0deSxBVkZGXqd
        8JLPLFN77efTSJum517tS/c=
X-Google-Smtp-Source: ABdhPJxCd+3OM7rVUlCJ415U5mos+W3z/pfP53EArLwIpkBM+GZj9NipDl9K9kC3z669g20z47imFg==
X-Received: by 2002:a17:906:730e:b0:6f4:e9e7:4f4 with SMTP id di14-20020a170906730e00b006f4e9e704f4mr15402269ejc.509.1652718550402;
        Mon, 16 May 2022 09:29:10 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id 9-20020a170906004900b006f3ef214e3bsm58819ejg.161.2022.05.16.09.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 May 2022 09:29:10 -0700 (PDT)
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
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1 2/2] drm/panel: simple: add bus-format support for panel-dpi
Date:   Mon, 16 May 2022 18:28:26 +0200
Message-Id: <20220516162826.23025-3-max.oss.09@gmail.com>
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

Evaluate the device tree bus-format property to set bus_format for
a 'panel-dpi' panel. Additionally infer the bpc value from the
given bus-format.

Valid values for bus-format are found in:
<include/dt-bindings/display/dt-media-bus-format.h>

This completes the addition of panel-dpi to completely specify
a panel-simple panel from the device tree.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

 drivers/gpu/drm/panel/panel-simple.c | 43 ++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index a34f4198a534..090c60abb014 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -21,6 +21,7 @@
  * DEALINGS IN THE SOFTWARE.
  */
 
+#include <dt-bindings/display/dt-media-bus-format.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/module.h>
@@ -453,6 +454,7 @@ static int panel_dpi_probe(struct device *dev,
 	struct panel_desc *desc;
 	unsigned int bus_flags;
 	struct videomode vm;
+	u32 bus_format;
 	int ret;
 
 	np = dev->of_node;
@@ -477,6 +479,47 @@ static int panel_dpi_probe(struct device *dev,
 	of_property_read_u32(np, "width-mm", &desc->size.width);
 	of_property_read_u32(np, "height-mm", &desc->size.height);
 
+	if (!of_property_read_u32(np, "bus-format", &bus_format)) {
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
 	/* Extract bus_flags from display_timing */
 	bus_flags = 0;
 	vm.flags = timing->flags;
-- 
2.20.1

