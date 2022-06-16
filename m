Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EACDE54E904
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 20:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354635AbiFPSD2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 14:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353050AbiFPSDY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 14:03:24 -0400
Received: from 2.mo582.mail-out.ovh.net (2.mo582.mail-out.ovh.net [46.105.76.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0558D15FE6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 11:03:20 -0700 (PDT)
Received: from player715.ha.ovh.net (unknown [10.108.4.8])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id 8EE5C242D9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:25:47 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player715.ha.ovh.net (Postfix) with ESMTPSA id 7183B2B80DB79;
        Thu, 16 Jun 2022 17:25:37 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R003b60a427b-fa1c-499e-9478-618c9dcb0ba6,
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
Subject: [PATCH v2 3/3] drm/panel: sony-acx565akm: Use backlight helpers
Date:   Thu, 16 Jun 2022 19:23:15 +0200
Message-Id: <20220616172316.1355133-4-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7465560809102542555
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddvfedguddtjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejudehrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of retrieving the backlight brightness in struct
backlight_properties manually, and then checking whether the backlight
should be on at all, use backlight_get_brightness() which does all
this and insulates this from future changes.

Instead of manually checking the power state in struct
backlight_properties, use backlight_is_blank().

While we're at it, drop .fb_blank from the initialisation function; it
is deprecated, and this helps make progress towards enabling its
removal. This change makes no functional difference since
FB_BLANK_UNBLANK is the default value.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
Changes since v1: removed the last remaining .fb_blank reference
---
 drivers/gpu/drm/panel/panel-sony-acx565akm.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-sony-acx565akm.c b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
index 0d7541a33f87..3d6a286056a0 100644
--- a/drivers/gpu/drm/panel/panel-sony-acx565akm.c
+++ b/drivers/gpu/drm/panel/panel-sony-acx565akm.c
@@ -298,13 +298,7 @@ static void acx565akm_set_brightness(struct acx565akm_panel *lcd, int level)
 static int acx565akm_bl_update_status_locked(struct backlight_device *dev)
 {
 	struct acx565akm_panel *lcd = dev_get_drvdata(&dev->dev);
-	int level;
-
-	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&
-	    dev->props.power == FB_BLANK_UNBLANK)
-		level = dev->props.brightness;
-	else
-		level = 0;
+	int level = backlight_get_brightness(dev);
 
 	acx565akm_set_brightness(lcd, level);
 
@@ -330,8 +324,7 @@ static int acx565akm_bl_get_intensity(struct backlight_device *dev)
 
 	mutex_lock(&lcd->mutex);
 
-	if (dev->props.fb_blank == FB_BLANK_UNBLANK &&
-	    dev->props.power == FB_BLANK_UNBLANK)
+	if (!backlight_is_blank(dev))
 		intensity = acx565akm_get_actual_brightness(lcd);
 	else
 		intensity = 0;
@@ -349,7 +342,6 @@ static const struct backlight_ops acx565akm_bl_ops = {
 static int acx565akm_backlight_init(struct acx565akm_panel *lcd)
 {
 	struct backlight_properties props = {
-		.fb_blank = FB_BLANK_UNBLANK,
 		.power = FB_BLANK_UNBLANK,
 		.type = BACKLIGHT_RAW,
 	};
-- 
2.30.2

