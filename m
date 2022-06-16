Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD8A54E903
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346276AbiFPSDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiFPSDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:03:14 -0400
X-Greylist: delayed 1797 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 11:03:13 PDT
Received: from 20.mo581.mail-out.ovh.net (20.mo581.mail-out.ovh.net [46.105.49.208])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E93415837
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:03:13 -0700 (PDT)
Received: from player715.ha.ovh.net (unknown [10.108.20.214])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 19F3724EE7
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:25:37 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id 6E97C2B80DB35;
        Thu, 16 Jun 2022 17:25:27 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R003daa04ea3-487e-4441-a761-bef3e850f424,
                    EEA695ED62D0B30D35F9F30395731DD21189161B) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Stephen Kitt <steve@sk2.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] drm/panel: panel-dsi-cm: Use backlight helpers
Date:   Thu, 16 Jun 2022 19:23:14 +0200
Message-Id: <20220616172316.1355133-3-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7462746059164321499
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddvfedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekud
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of retrieving the backlight brightness in struct
backlight_properties manually, and then checking whether the backlight
should be on at all, use backlight_get_brightness() which does all
this and insulates this from future changes.

Instead of setting the power state by manually updating fields in
struct backlight_properties, use backlight_enable() and
backlight_disable(). These also call backlight_update_status() so the
separate call is no longer needed.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
Changes since v1: removed unnecessary parentheses
---
 drivers/gpu/drm/panel/panel-dsi-cm.c | 29 ++++++----------------------
 1 file changed, 6 insertions(+), 23 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel/panel-dsi-cm.c
index b58cb064975f..b0213a518f9d 100644
--- a/drivers/gpu/drm/panel/panel-dsi-cm.c
+++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
@@ -85,17 +85,10 @@ static void dsicm_bl_power(struct panel_drv_data *ddata, bool enable)
 	else
 		return;
 
-	if (enable) {
-		backlight->props.fb_blank = FB_BLANK_UNBLANK;
-		backlight->props.state = ~(BL_CORE_FBBLANK | BL_CORE_SUSPENDED);
-		backlight->props.power = FB_BLANK_UNBLANK;
-	} else {
-		backlight->props.fb_blank = FB_BLANK_NORMAL;
-		backlight->props.power = FB_BLANK_POWERDOWN;
-		backlight->props.state |= BL_CORE_FBBLANK | BL_CORE_SUSPENDED;
-	}
-
-	backlight_update_status(backlight);
+	if (enable)
+		backlight_enable(backlight);
+	else
+		backlight_disable(backlight);
 }
 
 static void hw_guard_start(struct panel_drv_data *ddata, int guard_msec)
@@ -196,13 +189,7 @@ static int dsicm_bl_update_status(struct backlight_device *dev)
 {
 	struct panel_drv_data *ddata = dev_get_drvdata(&dev->dev);
 	int r = 0;
-	int level;
-
-	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&
-			dev->props.power == FB_BLANK_UNBLANK)
-		level = dev->props.brightness;
-	else
-		level = 0;
+	int level = backlight_get_brightness(dev);
 
 	dev_dbg(&ddata->dsi->dev, "update brightness to %d\n", level);
 
@@ -219,11 +206,7 @@ static int dsicm_bl_update_status(struct backlight_device *dev)
 
 static int dsicm_bl_get_intensity(struct backlight_device *dev)
 {
-	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&
-			dev->props.power == FB_BLANK_UNBLANK)
-		return dev->props.brightness;
-
-	return 0;
+	return backlight_get_brightness(dev);
 }
 
 static const struct backlight_ops dsicm_bl_ops = {
-- 
2.30.2

