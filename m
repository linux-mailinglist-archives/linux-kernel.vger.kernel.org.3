Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4779E541D9F
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 00:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384794AbiFGWQU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 18:16:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380110AbiFGVLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:11:30 -0400
Received: from 1.mo560.mail-out.ovh.net (1.mo560.mail-out.ovh.net [46.105.63.121])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FC8721788D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:53:11 -0700 (PDT)
Received: from player796.ha.ovh.net (unknown [10.108.20.107])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 7207E24673
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:47:11 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player796.ha.ovh.net (Postfix) with ESMTPSA id BF54F2B4373C7;
        Tue,  7 Jun 2022 18:47:02 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-100R003d02dbf92-065a-4f26-9890-0ee8986a4b9e,
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
Subject: [PATCH 1/4] platform/x86: acer-wmi: Use backlight helper
Date:   Tue,  7 Jun 2022 20:46:32 +0200
Message-Id: <20220607184635.1127913-2-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220607184635.1127913-1-steve@sk2.org>
References: <20220607184635.1127913-1-steve@sk2.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11326271589753915014
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddvlecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeeghffhleeigffhteeiffelveefhfeiudehkedtgefhgedvleffgfejgfdtveeigeenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejleeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitd
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

Signed-off-by: Stephen Kitt <steve@sk2.org>
Cc: "Lee, Chun-Yi" <jlee@suse.com>
Cc: Hans de Goede <hdegoede@redhat.com>
Cc: Mark Gross <markgross@kernel.org>
Cc: platform-driver-x86@vger.kernel.org
---
 drivers/platform/x86/acer-wmi.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/platform/x86/acer-wmi.c b/drivers/platform/x86/acer-wmi.c
index 9c6943e401a6..e0230ea0cb7e 100644
--- a/drivers/platform/x86/acer-wmi.c
+++ b/drivers/platform/x86/acer-wmi.c
@@ -1615,12 +1615,7 @@ static int read_brightness(struct backlight_device *bd)
 
 static int update_bl_status(struct backlight_device *bd)
 {
-	int intensity = bd->props.brightness;
-
-	if (bd->props.power != FB_BLANK_UNBLANK)
-		intensity = 0;
-	if (bd->props.fb_blank != FB_BLANK_UNBLANK)
-		intensity = 0;
+	int intensity = backlight_get_brightness(bd);
 
 	set_u32(intensity, ACER_CAP_BRIGHTNESS);
 
-- 
2.30.2

