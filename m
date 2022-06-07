Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A26A7541B66
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 23:47:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381823AbiFGVpC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 17:45:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378932AbiFGUwm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 16:52:42 -0400
X-Greylist: delayed 277 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 11:43:22 PDT
Received: from 8.mo575.mail-out.ovh.net (8.mo575.mail-out.ovh.net [46.105.74.219])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 692083F332
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 11:43:20 -0700 (PDT)
Received: from player746.ha.ovh.net (unknown [10.108.16.8])
        by mo575.mail-out.ovh.net (Postfix) with ESMTP id B9FFC22A18
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 18:34:27 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player746.ha.ovh.net (Postfix) with ESMTPSA id 6A0ED1DF14EEC;
        Tue,  7 Jun 2022 18:34:21 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-108S002f51240c6-cd04-485d-92a4-59fa50673865,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH] backlight: Use backlight helper
Date:   Tue,  7 Jun 2022 20:34:11 +0200
Message-Id: <20220607183411.1125030-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11111224708588406284
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedguddvjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejgeeirdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejhe
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
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
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: linuxppc-dev@lists.ozlabs.org
---
 drivers/macintosh/via-pmu-backlight.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintosh/via-pmu-backlight.c
index 2194016122d2..c2d87e7fa85b 100644
--- a/drivers/macintosh/via-pmu-backlight.c
+++ b/drivers/macintosh/via-pmu-backlight.c
@@ -71,12 +71,7 @@ static int pmu_backlight_get_level_brightness(int level)
 static int __pmu_backlight_update_status(struct backlight_device *bd)
 {
 	struct adb_request req;
-	int level = bd->props.brightness;
-
-
-	if (bd->props.power != FB_BLANK_UNBLANK ||
-	    bd->props.fb_blank != FB_BLANK_UNBLANK)
-		level = 0;
+	int level = backlight_get_brightness(bd);
 
 	if (level > 0) {
 		int pmulevel = pmu_backlight_get_level_brightness(level);

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.30.2

