Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADAA582060
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 08:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiG0GpT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 02:45:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiG0GoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 02:44:11 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 294A4419AC
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:43:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id a13so18596068ljr.11
        for <linux-kernel@vger.kernel.org>; Tue, 26 Jul 2022 23:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2odXpn4NqvflBREYUYmO1+1RxmW+GuL0cfDw3Dw0WVQ=;
        b=M5LVaRcVeMUdyxjTy9X4a749CDwTC2L+S1rGrABeAnCVmMLXlZUhhSAGPfNkGkJs8+
         JQjk61NYK23w4PK9C0W4lFUDAlxAihIBcBlh5KFv0vIjI+zlcJ46UWwxoD0XeXTBsEfr
         myKPItxzYkFMNKpkcL0ZAjkHPWipe+wWSeEH1gOtGAOvMwo+UOQufTqB4HB+R8e8s9NO
         KStZG2zKWuyt6NYOGbHGPOOIVDtWccQdJ6HoEv57uZVC2DzZfmcc4GBuAjSVO2EBPEgA
         zjCxb3hQevi+8G8WdEd0TejJz+EX0kRTiWQHwaNlNeuWmuTtPK+kFS5NWo5mwKzC3g3p
         Lrjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2odXpn4NqvflBREYUYmO1+1RxmW+GuL0cfDw3Dw0WVQ=;
        b=nYuqwcZ3hyjwmMMwDucQlYxuF6o56DXRJH8L7S1p+7xTvSBN/KjFOosDOVkMRB+74V
         n/BR1tDS+X7KKlxxtl2eW2MLzC58WJ0smyz3q0X3Gp2OaIiwKJUUL7aT4q9tYqNcjAYK
         9oNsB0//Hysgl2IADLD5YfjywY8HvlXyxGlK3oaASP0jHnnvCl91ug126Vgz4ElFyU2i
         6onjbSuERrW0ls2xPnOW5IlfXJjqEbvsyGB1uF87F0eX857TzgBiM51kfRHizCG8jETn
         pxBNVVJsI7COdWoTkvk30hMkqK95Baufnmwj9eHVOSZ6wg27sykQG990qpiAYLPNxehp
         k/6g==
X-Gm-Message-State: AJIora/MawhFbft2lp1Y12SA/Me5Yx5l/YnqPp6gaJ8IlchBlRaB7hJx
        iTsIbCwhPYRri/UbnWGCs7LgLkUcq5eVqA==
X-Google-Smtp-Source: AGRyM1v9ZHWvAdoM5hxEHP3+vt59f9C0lTTPauONXgBFyLTQhLSEZgKMsfzvVEnMO3r5sBQvh/at2Q==
X-Received: by 2002:a2e:93c8:0:b0:24d:b348:b070 with SMTP id p8-20020a2e93c8000000b0024db348b070mr7445132ljh.434.1658904229157;
        Tue, 26 Jul 2022 23:43:49 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id w19-20020a05651234d300b0048a97a1df02sm1157231lfr.6.2022.07.26.23.43.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Jul 2022 23:43:48 -0700 (PDT)
From:   Marcin Wojtas <mw@semihalf.com>
To:     linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     rafael@kernel.org, andriy.shevchenko@linux.intel.com,
        sean.wang@mediatek.com, Landen.Chao@mediatek.com,
        linus.walleij@linaro.org, andrew@lunn.ch, vivien.didelot@gmail.com,
        f.fainelli@gmail.com, olteanv@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux@armlinux.org.uk, hkallweit1@gmail.com, gjb@semihalf.com,
        mw@semihalf.com, jaz@semihalf.com, tn@semihalf.com,
        Samer.El-Haj-Mahmoud@arm.com, upstream@semihalf.com
Subject: [net-next: PATCH v3 7/8] net: mdio: introduce fwnode_mdiobus_register_device()
Date:   Wed, 27 Jul 2022 08:43:20 +0200
Message-Id: <20220727064321.2953971-8-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220727064321.2953971-1-mw@semihalf.com>
References: <20220727064321.2953971-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As a preparation patch to extend MDIO capabilities in the ACPI world,
introduce fwnode_mdiobus_register_device() to register non-PHY
devices on the mdiobus.

Use the newly introduced routine instead of of_mdiobus_register_device().

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 include/linux/fwnode_mdio.h    |  3 ++
 drivers/net/mdio/fwnode_mdio.c | 29 ++++++++++++++++++
 drivers/net/mdio/of_mdio.c     | 32 +-------------------
 3 files changed, 33 insertions(+), 31 deletions(-)

diff --git a/include/linux/fwnode_mdio.h b/include/linux/fwnode_mdio.h
index 98755b8c6c8a..39d74c5d1bb0 100644
--- a/include/linux/fwnode_mdio.h
+++ b/include/linux/fwnode_mdio.h
@@ -16,6 +16,9 @@ int fwnode_mdiobus_phy_device_register(struct mii_bus *mdio,
 int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 				struct fwnode_handle *child, u32 addr);
 
+int fwnode_mdiobus_register_device(struct mii_bus *mdio,
+				   struct fwnode_handle *child, u32 addr);
+
 int fwnode_phy_register_fixed_link(struct fwnode_handle *fwnode);
 
 void fwnode_phy_deregister_fixed_link(struct fwnode_handle *fwnode);
diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 454fdae24150..3743f34e7c2d 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -149,6 +149,35 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 }
 EXPORT_SYMBOL(fwnode_mdiobus_register_phy);
 
+int fwnode_mdiobus_register_device(struct mii_bus *mdio,
+				   struct fwnode_handle *child, u32 addr)
+{
+	struct mdio_device *mdiodev;
+	int rc;
+
+	mdiodev = mdio_device_create(mdio, addr);
+	if (IS_ERR(mdiodev))
+		return PTR_ERR(mdiodev);
+
+	/* Associate the fwnode with the device structure so it
+	 * can be looked up later.
+	 */
+	device_set_node(&mdiodev->dev, child);
+
+	/* All data is now stored in the mdiodev struct; register it. */
+	rc = mdio_device_register(mdiodev);
+	if (rc) {
+		mdio_device_free(mdiodev);
+		fwnode_handle_put(child);
+		return rc;
+	}
+
+	dev_dbg(&mdio->dev, "registered mdio device %p fwnode at address %i\n",
+		child, addr);
+	return 0;
+}
+EXPORT_SYMBOL(fwnode_mdiobus_register_device);
+
 /*
  * fwnode_phy_is_fixed_link() and fwnode_phy_register_fixed_link() must
  * support two bindings:
diff --git a/drivers/net/mdio/of_mdio.c b/drivers/net/mdio/of_mdio.c
index 409da6e92f7d..bd941da030bb 100644
--- a/drivers/net/mdio/of_mdio.c
+++ b/drivers/net/mdio/of_mdio.c
@@ -48,36 +48,6 @@ static int of_mdiobus_register_phy(struct mii_bus *mdio,
 	return fwnode_mdiobus_register_phy(mdio, of_fwnode_handle(child), addr);
 }
 
-static int of_mdiobus_register_device(struct mii_bus *mdio,
-				      struct device_node *child, u32 addr)
-{
-	struct fwnode_handle *fwnode = of_fwnode_handle(child);
-	struct mdio_device *mdiodev;
-	int rc;
-
-	mdiodev = mdio_device_create(mdio, addr);
-	if (IS_ERR(mdiodev))
-		return PTR_ERR(mdiodev);
-
-	/* Associate the OF node with the device structure so it
-	 * can be looked up later.
-	 */
-	fwnode_handle_get(fwnode);
-	device_set_node(&mdiodev->dev, fwnode);
-
-	/* All data is now stored in the mdiodev struct; register it. */
-	rc = mdio_device_register(mdiodev);
-	if (rc) {
-		mdio_device_free(mdiodev);
-		of_node_put(child);
-		return rc;
-	}
-
-	dev_dbg(&mdio->dev, "registered mdio device %pOFn at address %i\n",
-		child, addr);
-	return 0;
-}
-
 /* The following is a list of PHY compatible strings which appear in
  * some DTBs. The compatible string is never matched against a PHY
  * driver, so is pointless. We only expect devices which are not PHYs
@@ -186,7 +156,7 @@ int of_mdiobus_register(struct mii_bus *mdio, struct device_node *np)
 		if (of_mdiobus_child_is_phy(child))
 			rc = of_mdiobus_register_phy(mdio, child, addr);
 		else
-			rc = of_mdiobus_register_device(mdio, child, addr);
+			rc = fwnode_mdiobus_register_device(mdio, of_fwnode_handle(child), addr);
 
 		if (rc == -ENODEV)
 			dev_err(&mdio->dev,
-- 
2.29.0

