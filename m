Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8745424D5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:53:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384127AbiFHBEn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382966AbiFGVwI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:52:08 -0400
X-Greylist: delayed 538 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 12:10:08 PDT
Received: from 3.mo575.mail-out.ovh.net (3.mo575.mail-out.ovh.net [46.105.58.60])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21170434A4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:10:08 -0700 (PDT)
Received: from player797.ha.ovh.net (unknown [10.109.138.131])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id 60A9224473
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:10:06 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player797.ha.ovh.net (Postfix) with ESMTPSA id 4E982273DCAD8;
        Tue,  7 Jun 2022 19:09:57 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-102R004f66d6445-5b4d-4b53-8766-d6f361bee8fc,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Lee Jones <lee.jones@linaro.org>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc:     dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>
Subject: [PATCH 2/4] backlight: arcxcnn: Use backlight helper
Date:   Tue,  7 Jun 2022 21:09:23 +0200
Message-Id: <20220607190925.1134737-3-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607190925.1134737-1-steve@sk2.org>
References: <20220607190925.1134737-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11713299682955658886
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedgudeffecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeghffhleeigffhteeiffelveefhfeiudehkedtgefhgedvleffgfejgfdtveeigeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleejrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhe
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

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: Lee Jones <lee.jones@linaro.org>
Cc: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Helge Deller <deller@gmx.de>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-fbdev@vger.kernel.org
---
 drivers/video/backlight/arcxcnn_bl.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/video/backlight/arcxcnn_bl.c b/drivers/video/backlight/arcxcnn_bl.c
index 7b1c0a0e6cad..a706899eb7ac 100644
--- a/drivers/video/backlight/arcxcnn_bl.c
+++ b/drivers/video/backlight/arcxcnn_bl.c
@@ -130,12 +130,9 @@ static int arcxcnn_set_brightness(struct arcxcnn *lp, u32 brightness)
 static int arcxcnn_bl_update_status(struct backlight_device *bl)
 {
 	struct arcxcnn *lp = bl_get_data(bl);
-	u32 brightness = bl->props.brightness;
+	u32 brightness = backlight_get_brightness(bl);
 	int ret;
 
-	if (bl->props.state & (BL_CORE_SUSPENDED | BL_CORE_FBBLANK))
-		brightness = 0;
-
 	ret = arcxcnn_set_brightness(lp, brightness);
 	if (ret)
 		return ret;
-- 
2.30.2

