Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86B8B49795F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 08:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241732AbiAXH0o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 02:26:44 -0500
Received: from zg8tmtyylji0my4xnjqunzqa.icoremail.net ([162.243.164.74]:56066
        "HELO zg8tmtyylji0my4xnjqunzqa.icoremail.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S229829AbiAXH0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 02:26:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pku.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
        Message-Id:In-Reply-To:References; bh=I3Vy/L8aqL5+sOn1AC2y5VQwID
        51IGdObUXQDrCQTOk=; b=WymN6G9dOXfeWGIGElXeQeMa5RhQDeEZehAQPXtkWf
        u8G+aKLfD22d+Uq0EnisnIgt8yuNRu18jsJ1GUXysCVlSB1vE1iSohLn8MKysaeh
        2tiH2J41QcFF03ZVwckwI0C9ov58JNQf1joDu6g9daHNycPOphnPi4km8qLC+0Lh
        M=
Received: from localhost (unknown [10.129.21.144])
        by front01 (Coremail) with SMTP id 5oFpogBHTjpEU+5hb_KwAA--.34590S2;
        Mon, 24 Jan 2022 15:20:37 +0800 (CST)
From:   Yongzhi Liu <lyz_cs@pku.edu.cn>
To:     a.hajda@samsung.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com, airlied@linux.ie,
        daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Yongzhi Liu <lyz_cs@pku.edu.cn>
Subject: [PATCH v2] drm/bridge: Add missing pm_runtime_put_sync
Date:   Sun, 23 Jan 2022 23:20:35 -0800
Message-Id: <1643008835-73961-1-git-send-email-lyz_cs@pku.edu.cn>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <Ye21tlZKRRe2vUzR@pendragon.ideasonboard.com>
References: <Ye21tlZKRRe2vUzR@pendragon.ideasonboard.com>
X-CM-TRANSID: 5oFpogBHTjpEU+5hb_KwAA--.34590S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4Utw48CF4DAFW8uFWfXwb_yoW8Cw1rpF
        4Ig34YyrWIvFZ3Kw4xAw1kZFyruas3tFWrCrW2qw13Zw1Yv3Wqqr43AF4aqFyFgFy5Ar15
        Jr4ktFyfuFy0qr7anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUU9Y1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJr0_GcWl84ACjcxK6I8E
        87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c
        8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_
        Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwI
        xGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc2xSY4AK
        6svPMxAIw28IcxkI7VAKI48JMxAIw28IcVCjz48v1sIEY20_Kr1UJr1l4I8I3I0E4IkC6x
        0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2
        zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF
        4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
        CwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCT
        nIWIevJa73UjIFyTuYvjfUoOJ5UUUUU
X-CM-SenderInfo: irzqijirqukmo6sn3hxhgxhubq/1tbiAwEOBlPy7uC2rwAGs6
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm_runtime_get_sync() will increase the rumtime PM counter
even when it returns an error. Thus a pairing decrement is needed
to prevent refcount leak. Fix this by replacing this API with
pm_runtime_resume_and_get(), which will not change the runtime
PM counter on error. Besides, a matching decrement is needed
on the error handling path to keep the counter balanced.

Signed-off-by: Yongzhi Liu <lyz_cs@pku.edu.cn>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 9282e61..30aacd9 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -862,18 +862,19 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 	memcpy(&dsi->mode, adjusted_mode, sizeof(dsi->mode));
 	drm_mode_debug_printmodeline(adjusted_mode);
 
-	pm_runtime_get_sync(dev);
+	if (pm_runtime_resume_and_get(dev) < 0)
+		return;
 
 	if (clk_prepare_enable(dsi->lcdif_clk) < 0)
-		return;
+		goto runtime_put;
 	if (clk_prepare_enable(dsi->core_clk) < 0)
-		return;
+		goto runtime_put;
 
 	/* Step 1 from DSI reset-out instructions */
 	ret = reset_control_deassert(dsi->rst_pclk);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev, "Failed to deassert PCLK: %d\n", ret);
-		return;
+		goto runtime_put;
 	}
 
 	/* Step 2 from DSI reset-out instructions */
@@ -883,13 +884,18 @@ nwl_dsi_bridge_mode_set(struct drm_bridge *bridge,
 	ret = reset_control_deassert(dsi->rst_esc);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev, "Failed to deassert ESC: %d\n", ret);
-		return;
+		goto runtime_put;
 	}
 	ret = reset_control_deassert(dsi->rst_byte);
 	if (ret < 0) {
 		DRM_DEV_ERROR(dev, "Failed to deassert BYTE: %d\n", ret);
-		return;
+		goto runtime_put;
 	}
+
+	return;
+
+runtime_put:
+	pm_runtime_put_sync(dev);
 }
 
 static void
-- 
2.7.4

