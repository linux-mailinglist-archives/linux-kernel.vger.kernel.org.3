Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2485F541840
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:12:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379316AbiFGVLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:11:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358708AbiFGUO0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:14:26 -0400
X-Greylist: delayed 411 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 11:28:13 PDT
Received: from 13.mo582.mail-out.ovh.net (13.mo582.mail-out.ovh.net [188.165.56.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 092771C864B
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:28:12 -0700 (PDT)
Received: from player763.ha.ovh.net (unknown [10.109.143.3])
        by mo582.mail-out.ovh.net (Postfix) with ESMTP id E9437246E6
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:10:55 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player763.ha.ovh.net (Postfix) with ESMTPSA id 94B5A2B565B67;
        Tue,  7 Jun 2022 18:10:44 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R004222dfc05-6ee7-4795-a859-c8c48353692d,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH] drm/bridge: parade-ps8622: Use backlight helper
Date:   Tue,  7 Jun 2022 20:10:22 +0200
Message-Id: <20220607181022.1119546-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 10713782039836788358
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddvvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejieefrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekvd
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

backlight_properties.fb_blank is deprecated. The states it represents
are handled by other properties; but instead of accessing those
properties directly, drivers should use the helpers provided by
backlight.h.

Instead of retrieving the backlight brightness in struct
backlight_properties manually, and then checking whether the backlight
should be on at all, use backlight_get_brightness() which does all
this and insulates this from future changes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Andrzej Hajda <andrzej.hajda@intel.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Robert Foss <robert.foss@linaro.org>
Cc: Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc: Jonas Karlman <jonas@kwiboo.se>
Cc: Jernej Skrabec <jernej.skrabec@gmail.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/bridge/parade-ps8622.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/parade-ps8622.c b/drivers/gpu/drm/bridge/parade-ps8622.c
index 37b308850b4e..b5750e5f71d7 100644
--- a/drivers/gpu/drm/bridge/parade-ps8622.c
+++ b/drivers/gpu/drm/bridge/parade-ps8622.c
@@ -324,11 +324,7 @@ static int ps8622_send_config(struct ps8622_bridge *ps8622)
 static int ps8622_backlight_update(struct backlight_device *bl)
 {
 	struct ps8622_bridge *ps8622 = dev_get_drvdata(&bl->dev);
-	int ret, brightness = bl->props.brightness;
-
-	if (bl->props.power != FB_BLANK_UNBLANK ||
-	    bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
-		brightness = 0;
+	int ret, brightness = backlight_get_brightness(bl);
 
 	if (!ps8622->enabled)
 		return -EINVAL;

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.30.2

