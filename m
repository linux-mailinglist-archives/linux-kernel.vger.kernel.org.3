Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A4905310B2
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 15:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbiEWNCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233492AbiEWNCh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:02:37 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 803FD22BD5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:02:36 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id a38so10747783pgl.9
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:02:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDMJSeyEhz3D8bGy5InCdDzKQ32lo+eZUXii2YT076w=;
        b=SYoS4zFvTiXtdoMfpCOIouQm7bVwMfE6+UlK4HDAtlU3277AH047Ur9x22r05V5pow
         9DBafu+rDDrqZ4wr7PQ3NaEXstFSubiBcJjb0s+Gukf+htgc0+zHXf3e+IUiL/+nVQR2
         ZQ4AWIqsVFyttV9JF0c73CazcawkwE5OzrCJllCj7o8MDHd2TCNkThwa0ci/vm1Le2EO
         ldZvmd6H4kQabjMegLcnFMGx/y11KMsjKXTcTho3xDc2yGkl1E69QHblnYlqSePLtw7Z
         eqmzYpdyg3V9Qnj8QwKEgp/vWwdLCbltz3g5CK5ZtqheawxjxXWCYi457kfWpHOwPkWo
         Z7Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DDMJSeyEhz3D8bGy5InCdDzKQ32lo+eZUXii2YT076w=;
        b=rRS8reb/SFsIlrXAB6/06ujydIFm1Ef+zSXDl/EIJpLbQQPxNl3GgpvLp5NEcUd4xb
         uqc27RPALeyQt+zp/Et1iX8q7f7TdC8A/WLw5anGki4ZjXbqJuPttGuTsSK5ScSOF155
         77JpQ+PNKTcXHN00ePmR/Tg3NhuRAiMmVT9sLXdn7ABPgLg075B2953Wy4k35gG0xT+a
         GvW624chFvBFsJrrIRY8BC9rVn7gDNXAtyF/xg+eWlLIGtW94rcyih+zNadb9NNxQhgy
         aGDEvkJIOIXsjLzPhwpjiC8/bkLeF3KJpozMvSNK8RyYf9q9UyGp2YDZ4UUDdYEzMRuJ
         w/IA==
X-Gm-Message-State: AOAM532iMgNGtkXYTu8+XfPI6bYQ1/vdpUkl9kPoF0rSuagMLCPHlUQw
        hu95FJg4GZPZ6udQZSGUgcw=
X-Google-Smtp-Source: ABdhPJyP+rcgfnE++8labjEMCnSV+ws14gytPrT5o3etY2G6nnehd2OCtnI6uORIs7/BS9FFYiU+1A==
X-Received: by 2002:a05:6a00:2d0:b0:518:95f8:d00a with SMTP id b16-20020a056a0002d000b0051895f8d00amr7304351pft.8.1653310955804;
        Mon, 23 May 2022 06:02:35 -0700 (PDT)
Received: from 167-179-157-192.a7b39d.syd.nbn.aussiebb.net (167-179-157-192.a7b39d.syd.nbn.aussiebb.net. [167.179.157.192])
        by smtp.gmail.com with ESMTPSA id v22-20020aa78096000000b0050dc76281d0sm7380271pff.170.2022.05.23.06.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:02:35 -0700 (PDT)
From:   Jonathan Liu <net147@gmail.com>
To:     dri-devel@lists.freedesktop.org
Cc:     Marek Vasut <marex@denx.de>, Maxime Ripard <maxime@cerno.tech>,
        Jonathan Liu <net147@gmail.com>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: bridge: icn6211: Adjust clock phase using SYS_CTRL_1
Date:   Mon, 23 May 2022 23:01:44 +1000
Message-Id: <20220523130144.444225-1-net147@gmail.com>
X-Mailer: git-send-email 2.36.1
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

The code from [1] sets SYS_CTRL_1 to different values depending on the
desired clock phase (0, 1/4, 1/2 or 3/4). A clock phase of 0 aligns the
positive edge of the clock with the pixel data while other values delay
the clock by a fraction of the clock period. A clock phase of 1/2 aligns
the negative edge of the clock with the pixel data.

The driver currently hard codes SYS_CTRL_1 to 0x88 which corresponds to
aligning the positive edge of the clock with the pixel data. This won't
work correctly for panels that require aligning the negative edge of the
clock with the pixel data.

Adjust the clock phase to 0 if DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE is
present in bus_flags, otherwise adjust the clock phase to 1/2 as
appropriate for DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE.

[1] https://github.com/tdjastrzebski/ICN6211-Configurator

Signed-off-by: Jonathan Liu <net147@gmail.com>
---
V2: Use GENMASK and FIELD_PREP macros
---
 drivers/gpu/drm/bridge/chipone-icn6211.c | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index 47dea657a752..f1538fb5f8a9 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -9,6 +9,8 @@
 #include <drm/drm_print.h>
 #include <drm/drm_mipi_dsi.h>
 
+#include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
@@ -26,6 +28,11 @@
 #define PD_CTRL(n)		(0x0a + ((n) & 0x3)) /* 0..3 */
 #define RST_CTRL(n)		(0x0e + ((n) & 0x1)) /* 0..1 */
 #define SYS_CTRL(n)		(0x10 + ((n) & 0x7)) /* 0..4 */
+#define SYS_CTRL_1_CLK_PHASE_MSK	GENMASK(5, 4)
+#define CLK_PHASE_0			0
+#define CLK_PHASE_1_4			1
+#define CLK_PHASE_1_2			2
+#define CLK_PHASE_3_4			3
 #define RGB_DRV(n)		(0x18 + ((n) & 0x3)) /* 0..3 */
 #define RGB_DLY(n)		(0x1c + ((n) & 0x1)) /* 0..1 */
 #define RGB_TEST_CTRL		0x1e
@@ -336,7 +343,7 @@ static void chipone_atomic_enable(struct drm_bridge *bridge,
 	const struct drm_bridge_state *bridge_state;
 	u16 hfp, hbp, hsync;
 	u32 bus_flags;
-	u8 pol, id[4];
+	u8 pol, sys_ctrl_1, id[4];
 
 	chipone_readb(icn, VENDOR_ID, id);
 	chipone_readb(icn, DEVICE_ID_H, id + 1);
@@ -414,7 +421,14 @@ static void chipone_atomic_enable(struct drm_bridge *bridge,
 	chipone_configure_pll(icn, mode);
 
 	chipone_writeb(icn, SYS_CTRL(0), 0x40);
-	chipone_writeb(icn, SYS_CTRL(1), 0x88);
+	sys_ctrl_1 = 0x88;
+
+	if (bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
+		sys_ctrl_1 |= FIELD_PREP(SYS_CTRL_1_CLK_PHASE_MSK, CLK_PHASE_0);
+	else
+		sys_ctrl_1 |= FIELD_PREP(SYS_CTRL_1_CLK_PHASE_MSK, CLK_PHASE_1_2);
+
+	chipone_writeb(icn, SYS_CTRL(1), sys_ctrl_1);
 
 	/* icn6211 specific sequence */
 	chipone_writeb(icn, MIPI_FORCE_0, 0x20);
-- 
2.36.1

