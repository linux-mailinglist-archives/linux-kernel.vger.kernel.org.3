Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E34B4F8CC1
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 05:27:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbiDHBcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 21:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233434AbiDHBco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:32:44 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCFDA2BC545
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 18:30:41 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: nfraprado)
        with ESMTPSA id D66171F46B10
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1649381440;
        bh=8LfnufoqbKLUJpGpQ0uLp1AtFcRy4BBDR+hZk2BoruU=;
        h=From:To:Cc:Subject:Date:From;
        b=UVnRobzp+GkWSGygXxshTcnDIxRCggP8nBMb2/Hb9ojxq110fq/bxKpkSitWGctou
         wOzAH3kTK/dYNHRBWDiQL5zpkAhT3Gy0FHMM6jR4+Rdlyh/bAsAfI64ctQWJp/JJpL
         ti8bRdsEnpkIjs5Nwzp2kb93oUljPfLqPsCgLz3r45brTj/wppegYVmVvzsuqIXIHq
         iPapPYOFlf8O8JSf0P3JR9kJWKTiqhO7N2jHMbBGd70WpOuH2OuV/d3zMv7hKj1HCC
         +WLZY17aQYG5SpnsJW+iSFhI7ajfSfvOwRQXayldGtMEL/opVU//piwDEeyLZ1h8/G
         1LWxl9bbRAezg==
From:   =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>
To:     Robert Foss <robert.foss@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        =?UTF-8?q?N=C3=ADcolas=20F=2E=20R=2E=20A=2E=20Prado?= 
        <nfraprado@collabora.com>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] drm/bridge: anx7625: Use uint8 for lane-swing arrays
Date:   Thu,  7 Apr 2022 21:30:34 -0400
Message-Id: <20220408013034.673418-1-nfraprado@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As defined in the anx7625 dt-binding, the analogix,lane0-swing and
analogix,lane1-swing properties are uint8 arrays. Yet, the driver was
reading the array as if it were of uint32 and masking to 8-bit before
writing to the registers. This means that a devicetree written in
accordance to the dt-binding would have its values incorrectly parsed.

Fix the issue by reading the array as uint8 and storing them as uint8
internally, so that we can also drop the masking when writing the
registers.

Fixes: fd0310b6fe7d ("drm/bridge: anx7625: add MIPI DPI input feature")
Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>

---

 drivers/gpu/drm/bridge/analogix/anx7625.c | 8 ++++----
 drivers/gpu/drm/bridge/analogix/anx7625.h | 4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.c b/drivers/gpu/drm/bridge/analogix/anx7625.c
index 6516f9570b86..19a1a90ccff3 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.c
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.c
@@ -1486,12 +1486,12 @@ static void anx7625_dp_adjust_swing(struct anx7625_data *ctx)
 	for (i = 0; i < ctx->pdata.dp_lane0_swing_reg_cnt; i++)
 		anx7625_reg_write(ctx, ctx->i2c.tx_p1_client,
 				  DP_TX_LANE0_SWING_REG0 + i,
-				  ctx->pdata.lane0_reg_data[i] & 0xFF);
+				  ctx->pdata.lane0_reg_data[i]);
 
 	for (i = 0; i < ctx->pdata.dp_lane1_swing_reg_cnt; i++)
 		anx7625_reg_write(ctx, ctx->i2c.tx_p1_client,
 				  DP_TX_LANE1_SWING_REG0 + i,
-				  ctx->pdata.lane1_reg_data[i] & 0xFF);
+				  ctx->pdata.lane1_reg_data[i]);
 }
 
 static void dp_hpd_change_handler(struct anx7625_data *ctx, bool on)
@@ -1598,7 +1598,7 @@ static int anx7625_get_swing_setting(struct device *dev,
 			num_regs = DP_TX_SWING_REG_CNT;
 
 		pdata->dp_lane0_swing_reg_cnt = num_regs;
-		of_property_read_u32_array(dev->of_node, "analogix,lane0-swing",
+		of_property_read_u8_array(dev->of_node, "analogix,lane0-swing",
 					   pdata->lane0_reg_data, num_regs);
 	}
 
@@ -1608,7 +1608,7 @@ static int anx7625_get_swing_setting(struct device *dev,
 			num_regs = DP_TX_SWING_REG_CNT;
 
 		pdata->dp_lane1_swing_reg_cnt = num_regs;
-		of_property_read_u32_array(dev->of_node, "analogix,lane1-swing",
+		of_property_read_u8_array(dev->of_node, "analogix,lane1-swing",
 					   pdata->lane1_reg_data, num_regs);
 	}
 
diff --git a/drivers/gpu/drm/bridge/analogix/anx7625.h b/drivers/gpu/drm/bridge/analogix/anx7625.h
index edbbfe410a56..e257a84db962 100644
--- a/drivers/gpu/drm/bridge/analogix/anx7625.h
+++ b/drivers/gpu/drm/bridge/analogix/anx7625.h
@@ -426,9 +426,9 @@ struct anx7625_platform_data {
 	int mipi_lanes;
 	int audio_en;
 	int dp_lane0_swing_reg_cnt;
-	int lane0_reg_data[DP_TX_SWING_REG_CNT];
+	u8 lane0_reg_data[DP_TX_SWING_REG_CNT];
 	int dp_lane1_swing_reg_cnt;
-	int lane1_reg_data[DP_TX_SWING_REG_CNT];
+	u8 lane1_reg_data[DP_TX_SWING_REG_CNT];
 	u32 low_power_mode;
 	struct device_node *mipi_host_node;
 };
-- 
2.35.1

