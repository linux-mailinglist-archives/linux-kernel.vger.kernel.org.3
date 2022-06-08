Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37482543E00
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 22:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiFHU5O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 16:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbiFHU5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 16:57:09 -0400
Received: from 17.mo583.mail-out.ovh.net (17.mo583.mail-out.ovh.net [46.105.56.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 591D4208710
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 13:57:05 -0700 (PDT)
Received: from player693.ha.ovh.net (unknown [10.109.146.240])
        by mo583.mail-out.ovh.net (Postfix) with ESMTP id 51828243AD
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 20:57:03 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player693.ha.ovh.net (Postfix) with ESMTPSA id F0CB22B5316F7;
        Wed,  8 Jun 2022 20:56:53 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-107S00185b07d8f-96d6-4095-b4d8-e86ccb7a7ee7,
                    17AB8856E930E35E66C22CFEE532C9037B5FA013) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>,
        Helge Deller <deller@gmx.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Cc:     linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] fbdev: atmel_lcdfb: Rework backlight status updates
Date:   Wed,  8 Jun 2022 22:56:23 +0200
Message-Id: <20220608205623.2106113-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 945474448624879238
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddtjedgudehudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrheileefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekfe
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of checking the state of various backlight_properties fields
against the memorised state in atmel_lcdfb_info.bl_power,
atmel_bl_update_status() should retrieve the desired state using
backlight_get_brightness (which takes into account the power state,
blanking etc.). This means the explicit checks using props.fb_blank
and props.power can be dropped.

Then brightness can only be negative if the backlight is on but
props.brightness is negative, so the test before reading the
brightness value from the hardware can be simplified to
(brightness < 0).

As a result, bl_power in struct atmel_lcdfb_info is no longer
necessary, so remove that while we're at it. Since we only ever care
about reading the current state in backlight_properties, drop the
updates at the end of the function.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Claudiu Beznea <claudiu.beznea@microchip.com>
Cc: linux-fbdev@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/video/fbdev/atmel_lcdfb.c | 21 ++-------------------
 1 file changed, 2 insertions(+), 19 deletions(-)

diff --git a/drivers/video/fbdev/atmel_lcdfb.c b/drivers/video/fbdev/atmel_lcdfb.c
index 1fc8de4ecbeb..06159a4da293 100644
--- a/drivers/video/fbdev/atmel_lcdfb.c
+++ b/drivers/video/fbdev/atmel_lcdfb.c
@@ -49,7 +49,6 @@ struct atmel_lcdfb_info {
 	struct clk		*lcdc_clk;
 
 	struct backlight_device	*backlight;
-	u8			bl_power;
 	u8			saved_lcdcon;
 
 	u32			pseudo_palette[16];
@@ -109,22 +108,10 @@ static u32 contrast_ctr = ATMEL_LCDC_PS_DIV8
 static int atmel_bl_update_status(struct backlight_device *bl)
 {
 	struct atmel_lcdfb_info *sinfo = bl_get_data(bl);
-	int			power = sinfo->bl_power;
-	int			brightness = bl->props.brightness;
+	int			brightness = backlight_get_brightness(bl);
 
-	/* REVISIT there may be a meaningful difference between
-	 * fb_blank and power ... there seem to be some cases
-	 * this doesn't handle correctly.
-	 */
-	if (bl->props.fb_blank != sinfo->bl_power)
-		power = bl->props.fb_blank;
-	else if (bl->props.power != sinfo->bl_power)
-		power = bl->props.power;
-
-	if (brightness < 0 && power == FB_BLANK_UNBLANK)
+	if (brightness < 0)
 		brightness = lcdc_readl(sinfo, ATMEL_LCDC_CONTRAST_VAL);
-	else if (power != FB_BLANK_UNBLANK)
-		brightness = 0;
 
 	lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_VAL, brightness);
 	if (contrast_ctr & ATMEL_LCDC_POL_POSITIVE)
@@ -133,8 +120,6 @@ static int atmel_bl_update_status(struct backlight_device *bl)
 	else
 		lcdc_writel(sinfo, ATMEL_LCDC_CONTRAST_CTR, contrast_ctr);
 
-	bl->props.fb_blank = bl->props.power = sinfo->bl_power = power;
-
 	return 0;
 }
 
@@ -155,8 +140,6 @@ static void init_backlight(struct atmel_lcdfb_info *sinfo)
 	struct backlight_properties props;
 	struct backlight_device	*bl;
 
-	sinfo->bl_power = FB_BLANK_UNBLANK;
-
 	if (sinfo->backlight)
 		return;
 

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.30.2

