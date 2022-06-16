Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1191854E89B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 19:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbiFPR2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 13:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiFPR2L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 13:28:11 -0400
X-Greylist: delayed 1387 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 16 Jun 2022 10:28:08 PDT
Received: from 18.mo584.mail-out.ovh.net (18.mo584.mail-out.ovh.net [188.165.54.143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24DAA175AF
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 10:28:03 -0700 (PDT)
Received: from player779.ha.ovh.net (unknown [10.109.156.34])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id 955C32222D
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 17:08:40 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player779.ha.ovh.net (Postfix) with ESMTPSA id 64B292B9393D5;
        Thu, 16 Jun 2022 17:08:32 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-103G0059eda0aa4-c3b8-493b-af8c-1b5db0bc1ce2,
                    EEA695ED62D0B30D35F9F30395731DD21189161B) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc:     Stephen Kitt <steve@sk2.org>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2] drm: shmobile: Use backlight helper
Date:   Thu, 16 Jun 2022 19:08:21 +0200
Message-Id: <20220616170821.1348169-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 7176486009031853787
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddvfedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejjeelrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekge
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This started with work on the removal of backlight_properties'
deprecated fb_blank field, much of which can be taken care of by using
helper functions provided by backlight.h instead of directly accessing
fields in backlight_properties. This patch series doesn't involve
fb_blank, but it still seems useful to use helper functions where
appropriate.

Instead of retrieving the backlight brightness in struct
backlight_properties manually, and then checking whether the backlight
should be on at all, use backlight_get_brightness() which does all
this and insulates this from future changes.

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
Cc: David Airlie <airlied@linux.ie>
Cc: Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org
---
Changes since v1: clarified commit message, this doesn't touch fb_blank
---
 drivers/gpu/drm/shmobile/shmob_drm_backlight.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c b/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
index f6628a5ee95f..794573badfe8 100644
--- a/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
+++ b/drivers/gpu/drm/shmobile/shmob_drm_backlight.c
@@ -18,11 +18,7 @@ static int shmob_drm_backlight_update(struct backlight_device *bdev)
 	struct shmob_drm_connector *scon = bl_get_data(bdev);
 	struct shmob_drm_device *sdev = scon->connector.dev->dev_private;
 	const struct shmob_drm_backlight_data *bdata = &sdev->pdata->backlight;
-	int brightness = bdev->props.brightness;
-
-	if (bdev->props.power != FB_BLANK_UNBLANK ||
-	    bdev->props.state & BL_CORE_SUSPENDED)
-		brightness = 0;
+	int brightness = backlight_get_brightness(bdev);
 
 	return bdata->set_brightness(brightness);
 }

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.30.2

