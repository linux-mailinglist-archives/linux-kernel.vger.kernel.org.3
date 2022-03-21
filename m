Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A53C4E2D9D
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:14:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351006AbiCUQO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350868AbiCUQOD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:14:03 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B805C2C668
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=q8EBMwoNwuBouz
        0Xkf/HfJBH6XF1wekxxBDWocbe3sA=; b=l9yO2KSTfNQqBcPWMmkEhCvHF2xnqg
        5XkBnabzQ961G6ct5qiho3ibyS3N0UuYa+4OnF1yXjMQ3HqXyDaXT/SfWPes6X6O
        JPkgzuxla78ig+7SE2KafmIg3nIXvXZJ4+d/7Em7MyywOHQx0a45xs7+avfP9cve
        HA5FSNR2Xdkko=
Received: (qmail 957921 invoked from network); 21 Mar 2022 17:12:33 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:33 +0100
X-UD-Smtp-Session: l3s3148p1@/huQw7zaLNkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 10/15] net: phy: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:18 +0100
Message-Id: <20220321161223.2837-11-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
References: <20220321161223.2837-1-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The function was just renamed to be easier understandable. No functional
change.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
RFC, please do not apply yet

 drivers/net/phy/broadcom.c    | 2 +-
 drivers/net/phy/mdio_bus.c    | 4 ++--
 drivers/net/phy/mdio_device.c | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 3c683e0e40e9..26a8665ab245 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -446,7 +446,7 @@ static int bcm54xx_resume(struct phy_device *phydev)
 	/* Upon exiting power down, the PHY remains in an internal reset state
 	 * for 40us
 	 */
-	fsleep(40);
+	usleep_autoyield(40);
 
 	/* Issue a soft reset after clearing the power down bit
 	 * and before doing any other configuration.
diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index 58d602985877..dfd4c2e1e1e3 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -570,10 +570,10 @@ int __mdiobus_register(struct mii_bus *bus, struct module *owner)
 		return err;
 	} else	if (gpiod) {
 		bus->reset_gpiod = gpiod;
-		fsleep(bus->reset_delay_us);
+		usleep_autoyield(bus->reset_delay_us);
 		gpiod_set_value_cansleep(gpiod, 0);
 		if (bus->reset_post_delay_us > 0)
-			fsleep(bus->reset_post_delay_us);
+			usleep_autoyield(bus->reset_post_delay_us);
 	}
 
 	if (bus->reset) {
diff --git a/drivers/net/phy/mdio_device.c b/drivers/net/phy/mdio_device.c
index 250742ffdfd9..9941a38c3631 100644
--- a/drivers/net/phy/mdio_device.c
+++ b/drivers/net/phy/mdio_device.c
@@ -132,7 +132,7 @@ void mdio_device_reset(struct mdio_device *mdiodev, int value)
 
 	d = value ? mdiodev->reset_assert_delay : mdiodev->reset_deassert_delay;
 	if (d)
-		fsleep(d);
+		usleep_autoyield(d);
 }
 EXPORT_SYMBOL(mdio_device_reset);
 
-- 
2.34.1

