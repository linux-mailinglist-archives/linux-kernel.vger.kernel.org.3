Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA9B5576B6
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 11:35:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231146AbiFWJf3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 05:35:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230386AbiFWJfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 05:35:25 -0400
X-Greylist: delayed 186 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 23 Jun 2022 02:35:23 PDT
Received: from ironport.ite.com.tw (60-251-196-230.hinet-ip.hinet.net [60.251.196.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12EA149264
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 02:35:22 -0700 (PDT)
Received: from unknown (HELO mse.ite.com.tw) ([192.168.35.30])
  by ironport.ite.com.tw with ESMTP; 23 Jun 2022 17:32:12 +0800
Received: from CSBMAIL1.internal.ite.com.tw (CSBMAIL1.internal.ite.com.tw [192.168.65.58])
        by mse.ite.com.tw with ESMTP id 25N9W7mn009951;
        Thu, 23 Jun 2022 17:32:07 +0800 (GMT-8)
        (envelope-from allen.chen@ite.com.tw)
Received: from VirtualBox.internal.ite.com.tw (192.168.70.46) by
 CSBMAIL1.internal.ite.com.tw (192.168.65.58) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.14; Thu, 23 Jun 2022 17:32:07 +0800
From:   allen <allen.chen@ite.com.tw>
CC:     Allen Chen <allen.chen@ite.com.tw>,
        Pin-yen Lin <treapking@google.com>,
        Jau-Chih Tseng <Jau-Chih.Tseng@ite.com.tw>,
        Hermes Wu <Hermes.Wu@ite.com.tw>,
        Kenneth Hung <Kenneth.Hung@ite.com.tw>,
        Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>,
        Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "open list:DRM DRIVERS" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] drm/bridge: add it6505 driver read config from dt property
Date:   Thu, 23 Jun 2022 17:31:54 +0800
Message-ID: <20220623093154.52701-1-allen.chen@ite.com.tw>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [192.168.70.46]
X-ClientProxiedBy: CSBMAIL1.internal.ite.com.tw (192.168.65.58) To
 CSBMAIL1.internal.ite.com.tw (192.168.65.58)
X-TM-SNTS-SMTP: 532277101033EC0C5799347BF5418EF1C05372C83BD9777B75A722A680D091252002:8
X-MAIL: mse.ite.com.tw 25N9W7mn009951
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: allen chen <allen.chen@ite.com.tw>

add read max-lane and max-pixel-clock from dt property

Signed-off-by: Allen-kh Cheng <allen-kh.cheng@mediatek.corp-partner.google.com>
Signed-off-by: Pin-yen Lin <treapking@chromium.org>
---
 drivers/gpu/drm/bridge/ite-it6505.c | 35 ++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6505.c b/drivers/gpu/drm/bridge/ite-it6505.c
index 4b673c4792d77..c9121d4635a52 100644
--- a/drivers/gpu/drm/bridge/ite-it6505.c
+++ b/drivers/gpu/drm/bridge/ite-it6505.c
@@ -436,6 +436,8 @@ struct it6505 {
 	bool powered;
 	bool hpd_state;
 	u32 afe_setting;
+	u32 max_dpi_pixel_clock;
+	u32 max_lane_count;
 	enum hdcp_state hdcp_status;
 	struct delayed_work hdcp_work;
 	struct work_struct hdcp_wait_ksv_list;
@@ -1466,7 +1468,8 @@ static void it6505_parse_link_capabilities(struct it6505 *it6505)
 	it6505->lane_count = link->num_lanes;
 	DRM_DEV_DEBUG_DRIVER(dev, "Sink support %d lanes training",
 			     it6505->lane_count);
-	it6505->lane_count = min_t(int, it6505->lane_count, MAX_LANE_COUNT);
+	it6505->lane_count = min_t(int, it6505->lane_count,
+				   it6505->max_lane_count);
 
 	it6505->branch_device = drm_dp_is_branch(it6505->dpcd);
 	DRM_DEV_DEBUG_DRIVER(dev, "Sink %sbranch device",
@@ -2895,7 +2898,7 @@ it6505_bridge_mode_valid(struct drm_bridge *bridge,
 	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
 		return MODE_NO_INTERLACE;
 
-	if (mode->clock > DPI_PIXEL_CLK_MAX)
+	if (mode->clock > it6505->max_dpi_pixel_clock)
 		return MODE_CLOCK_HIGH;
 
 	it6505->video_info.clock = mode->clock;
@@ -3057,6 +3060,8 @@ static void it6505_parse_dt(struct it6505 *it6505)
 {
 	struct device *dev = &it6505->client->dev;
 	u32 *afe_setting = &it6505->afe_setting;
+	u32 *max_lane_count = &it6505->max_lane_count;
+	u32 *max_dpi_pixel_clock = &it6505->max_dpi_pixel_clock;
 
 	it6505->lane_swap_disabled =
 		device_property_read_bool(dev, "no-laneswap");
@@ -3072,7 +3077,31 @@ static void it6505_parse_dt(struct it6505 *it6505)
 	} else {
 		*afe_setting = 0;
 	}
-	DRM_DEV_DEBUG_DRIVER(dev, "using afe_setting: %d", *afe_setting);
+
+	if (device_property_read_u32(dev, "max-lane-count",
+				     max_lane_count) == 0) {
+		if (*max_lane_count > 4 || *max_lane_count == 3) {
+			dev_err(dev, "max lane count error, use default");
+			*max_lane_count = MAX_LANE_COUNT;
+		}
+	} else {
+		*max_lane_count = MAX_LANE_COUNT;
+	}
+
+	if (device_property_read_u32(dev, "max-dpi-pixel-clock",
+				     max_dpi_pixel_clock) == 0) {
+		if (*max_dpi_pixel_clock > 297000) {
+			dev_err(dev, "max pixel clock error, use default");
+			*max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
+		}
+	} else {
+		*max_dpi_pixel_clock = DPI_PIXEL_CLK_MAX;
+	}
+
+	DRM_DEV_DEBUG_DRIVER(dev, "using afe_setting: %u, max_lane_count: %u",
+			     it6505->afe_setting, it6505->max_lane_count);
+	DRM_DEV_DEBUG_DRIVER(dev, "using max_dpi_pixel_clock: %u kHz",
+			     it6505->max_dpi_pixel_clock);
 }
 
 static ssize_t receive_timing_debugfs_show(struct file *file, char __user *buf,
-- 
2.25.1

