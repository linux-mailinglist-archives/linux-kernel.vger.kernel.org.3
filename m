Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77FCA52B9C0
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:14:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236059AbiERL4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:56:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235878AbiERL4U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:56:20 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E47CF45
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:56:18 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id tk15so3319851ejc.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b1dlEPWVrVXPU9+OpPy+DjsXYyATJBO85j2ZJWlY2iE=;
        b=TiI4GaMGCOCddV8HiwnOPd+gCJrAzBja0E8iUAqdeogfrF97bB9p2YgK5SmMjS+dHe
         hULnBAFx1ZiHmqCIRYB/YCeauOMyPq6gkykmrA6TbbF6ThxF86HbBWx2PpLbwf6hr919
         cMhrjO2ci5BLTIlmhJCQ/wgDkY31t+Av8D1Jm9PkwQ9AVrNR+OroorbOt0Ym0WBb/10t
         Kxo8lIZrGU4MnUYhi0DTFrTkWEPCANMNwIroHtvKLrE94MUGt+DtPIy/3xQkQsWJMHlu
         0BawCST4HeH4l7tjEgVLCJXDtVtEtSBDQg0xJLyEwEeb0x0qXtdeXNmw8T4qjtomgtFB
         470A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b1dlEPWVrVXPU9+OpPy+DjsXYyATJBO85j2ZJWlY2iE=;
        b=Prn6hCkhAYHmSo0DnX6JFok9RLJ9M8VcF7ZbW2wN9ezZ4K5wW+wsHMiTnMCi8IpmG2
         EACCClpwYJ/Ck/eoEaMc7jGiIjmz4ouyVggDJcGNVDQL0yEa6uw52Jz1Zg6OMATKwe4S
         NKA8gIxVKFWMHUlSPxq5lh6MPCIHMJuYKz0+V9QthFvnhWrSnVShITHFdcjELi+2wjbW
         rQafTpeD7DVAD1OHILcH5CdBbGbYyCC3PBigUBe4GBMxeA5an64SPIqvMpXTtMigVPXM
         WNzDIC6d8o9oNo2E10KJjtnYvUvp6MQbehcipFz6uPUlmFT2MRhytrKqUtbBjxJWwvll
         gnsA==
X-Gm-Message-State: AOAM533Y92ARysKjeqnEfruZqM2xgFTTF3J8iNfRhVyRmbaUrAUT/3TA
        moWtbbwkg+NOAMind9rdLZ0=
X-Google-Smtp-Source: ABdhPJwRW8Qy/kDVW3sedgwCmFrhZm2ha7NIB6DPX7bqZVmgNOIrDmk3X7+B9X5LnQadvHmbSyWwXA==
X-Received: by 2002:a17:907:3d91:b0:6f5:2b6a:ef55 with SMTP id he17-20020a1709073d9100b006f52b6aef55mr24549365ejc.352.1652874976966;
        Wed, 18 May 2022 04:56:16 -0700 (PDT)
Received: from linuxdev2.toradex.int (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id dq20-20020a170907735400b006f5294986besm873999ejc.111.2022.05.18.04.56.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 04:56:16 -0700 (PDT)
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
        Sam Ravnborg <sam@ravnborg.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] drm/panel: simple: add bus-format support for panel-dpi
Date:   Wed, 18 May 2022 13:55:40 +0200
Message-Id: <20220518115541.38407-4-max.oss.09@gmail.com>
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

Evaluate the device tree bus-format property to set bus_format for
a 'panel-dpi' panel. Additionally infer the bpc value from the
given bus-format.

Valid values for bus-format are found in:
<include/dt-bindings/display/dt-media-bus-format.h>

This completes the addition of panel-dpi to completely specify
a panel-simple panel from the device tree.

Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

---

Changes in v2:
    None

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

