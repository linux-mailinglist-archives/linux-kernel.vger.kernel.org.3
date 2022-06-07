Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9467541669
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 22:53:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378478AbiFGUwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 16:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358594AbiFGTwo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 15:52:44 -0400
X-Greylist: delayed 179 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 11:21:13 PDT
Received: from 9.mo576.mail-out.ovh.net (9.mo576.mail-out.ovh.net [46.105.56.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED7625DA
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:21:13 -0700 (PDT)
Received: from player728.ha.ovh.net (unknown [10.111.172.36])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id CD860241BC
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:21:11 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player728.ha.ovh.net (Postfix) with ESMTPSA id 83A8D2B3FFBBD;
        Tue,  7 Jun 2022 18:21:03 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G005c1a5820f-bbd6-4097-a39f-86f090581fe2,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 2/3] drm/panel: panel-dsi-cm: Use backlight helpers
Date:   Tue,  7 Jun 2022 20:20:25 +0200
Message-Id: <20220607182026.1121992-3-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607182026.1121992-1-steve@sk2.org>
References: <20220607182026.1121992-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10887170627632334470
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddvgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeghffhleeigffhteeiffelveefhfeiudehkedtgefhgedvleffgfejgfdtveeigeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejvdekrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejie
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
 drivers/gpu/drm/panel/panel-dsi-cm.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel/panel-dsi-cm.c
index b58cb064975f..aa36dc6cedd3 100644
--- a/drivers/gpu/drm/panel/panel-dsi-cm.c
+++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
@@ -86,16 +86,10 @@ static void dsicm_bl_power(struct panel_drv_data *ddata, bool enable)
 		return;
 
 	if (enable) {
-		backlight->props.fb_blank = FB_BLANK_UNBLANK;
-		backlight->props.state = ~(BL_CORE_FBBLANK | BL_CORE_SUSPENDED);
-		backlight->props.power = FB_BLANK_UNBLANK;
+		backlight_enable(backlight);
 	} else {
-		backlight->props.fb_blank = FB_BLANK_NORMAL;
-		backlight->props.power = FB_BLANK_POWERDOWN;
-		backlight->props.state |= BL_CORE_FBBLANK | BL_CORE_SUSPENDED;
+		backlight_disable(backlight);
 	}
-
-	backlight_update_status(backlight);
 }
 
 static void hw_guard_start(struct panel_drv_data *ddata, int guard_msec)
@@ -196,13 +190,7 @@ static int dsicm_bl_update_status(struct backlight_device *dev)
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
 
@@ -219,11 +207,7 @@ static int dsicm_bl_update_status(struct backlight_device *dev)
 
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

