Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E149541CA4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382760AbiFGWAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379276AbiFGVCS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:02:18 -0400
X-Greylist: delayed 465 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 11:47:22 PDT
Received: from 1.mo581.mail-out.ovh.net (1.mo581.mail-out.ovh.net [178.33.45.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7FBD59326
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:47:22 -0700 (PDT)
Received: from player796.ha.ovh.net (unknown [10.111.208.240])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id 688A5246D0
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:47:20 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id 75B782B4373EA;
        Tue,  7 Jun 2022 18:47:11 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R003534aca89-ad90-49e3-97a3-d35d654dc552,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     "Lee, Chun-Yi" <jlee@suse.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Cezary Jackiewicz <cezary.jackiewicz@gmail.com>,
        Henrique de Moraes Holschuh <hmh@hmh.eng.br>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Stephen Kitt <steve@sk2.org>
Subject: [PATCH 2/4] platform/x86: apple-gmux: Use backlight helper
Date:   Tue,  7 Jun 2022 20:46:33 +0200
Message-Id: <20220607184635.1127913-3-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607184635.1127913-1-steve@sk2.org>
References: <20220607184635.1127913-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11328804866083751558
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeghffhleeigffhteeiffelveefhfeiudehkedtgefhgedvleffgfejgfdtveeigeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekud
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
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/apple-gmux.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/platform/x86/apple-gmux.c b/drivers/platform/x86/apple-gmux.c
index 57553f9b4d1d..ffe98a18440b 100644
--- a/drivers/platform/x86/apple-gmux.c
+++ b/drivers/platform/x86/apple-gmux.c
@@ -291,10 +291,7 @@ static int gmux_get_brightness(struct backlight_device *bd)
 static int gmux_update_status(struct backlight_device *bd)
 {
 	struct apple_gmux_data *gmux_data = bl_get_data(bd);
-	u32 brightness = bd->props.brightness;
-
-	if (bd->props.state & BL_CORE_SUSPENDED)
-		return 0;
+	u32 brightness = backlight_get_brightness(bd);
 
 	gmux_write32(gmux_data, GMUX_PORT_BRIGHTNESS, brightness);
 
-- 
2.30.2

