Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40EF4542636
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:56:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386254AbiFHB03 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:26:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1387123AbiFGWt5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 18:49:57 -0400
X-Greylist: delayed 3076 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 07 Jun 2022 12:38:30 PDT
Received: from 2.mo560.mail-out.ovh.net (2.mo560.mail-out.ovh.net [188.165.53.149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59FF02A90C1
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:38:29 -0700 (PDT)
Received: from player732.ha.ovh.net (unknown [10.111.208.131])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id 5E50D246C9
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 19:01:08 +0000 (UTC)
Received: from sk2.org (82-65-25-201.subs.proxad.net [82.65.25.201])
        (Authenticated sender: steve@sk2.org)
        by player732.ha.ovh.net (Postfix) with ESMTPSA id 5C9AD1D75E8C8;
        Tue,  7 Jun 2022 19:01:02 +0000 (UTC)
Authentication-Results: garm.ovh; auth=pass (GARM-101G00425171465-c27e-4da5-ab29-ec544616d68f,
                    38FB55E0ED6224772C245AF554E1AE62085133ED) smtp.auth=steve@sk2.org
X-OVh-ClientIp: 82.65.25.201
From:   Stephen Kitt <steve@sk2.org>
To:     Jens Frederich <jfrederich@gmail.com>,
        Jon Nettleton <jon.nettleton@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Stephen Kitt <steve@sk2.org>,
        linux-staging@lists.linux.dev
Subject: [PATCH] staging: olpc_dcon: Use backlight helper
Date:   Tue,  7 Jun 2022 21:00:49 +0200
Message-Id: <20220607190049.1132154-1-steve@sk2.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 11561866145982154412
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvfedruddthedgudefvdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuthgvphhhvghnucfmihhtthcuoehsthgvvhgvsehskhdvrdhorhhgqeenucggtffrrghtthgvrhhnpeelgeetueejffejfeejvefhtddufeejgfetleegtddukeelieelvddvteduveejtdenucfkpheptddrtddrtddrtddpkedvrdeihedrvdehrddvtddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmohguvgepshhmthhpohhuthdphhgvlhhopehplhgrhigvrhejfedvrdhhrgdrohhvhhdrnhgvthdpihhnvghtpedtrddtrddtrddtpdhmrghilhhfrhhomhepshhtvghvvgesshhkvddrohhrghdpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheeitd
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
Cc: Jens Frederich <jfrederich@gmail.com>
Cc: Jon Nettleton <jon.nettleton@gmail.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-staging@lists.linux.dev
---
 drivers/staging/olpc_dcon/olpc_dcon.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/staging/olpc_dcon/olpc_dcon.c b/drivers/staging/olpc_dcon/olpc_dcon.c
index 7284cb4ac395..b9d570e9ad3b 100644
--- a/drivers/staging/olpc_dcon/olpc_dcon.c
+++ b/drivers/staging/olpc_dcon/olpc_dcon.c
@@ -517,10 +517,7 @@ static struct device_attribute dcon_device_files[] = {
 static int dcon_bl_update(struct backlight_device *dev)
 {
 	struct dcon_priv *dcon = bl_get_data(dev);
-	u8 level = dev->props.brightness & 0x0F;
-
-	if (dev->props.power != FB_BLANK_UNBLANK)
-		level = 0;
+	u8 level = backlight_get_brightness(dev) & 0x0F;
 
 	if (level != dcon->bl_val)
 		dcon_set_backlight(dcon, level);

base-commit: f2906aa863381afb0015a9eb7fefad885d4e5a56
-- 
2.30.2

