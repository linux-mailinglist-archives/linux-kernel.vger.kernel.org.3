Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6843651F5FD
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbiEIHzc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbiEIHxB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:53:01 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBA581271A1
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:49:07 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id x18so18211802wrc.0
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WOritaX7TiJ2UopsHt1F9UHI9/f6Pz6lo2giHHHHfc=;
        b=vLRuZyi6JG45t+95C6Zta3+FYr+M/sDzl2IdgVFDJRasR/zCxX43dHJf6IvPLSvtqr
         tklZR3oTHy0zplc10ONoKpKCKy119QBEUcXrz1Oo6US9ejSe0sxQ6Vs+zLtR6kmLeO3i
         vHXOUL9q9mUqXk+bL2tcVuMHUhrZPP1KYRc3NROkD5kFaia7iEggoHtDUbiq9gSA8Y+J
         iap1VxxsVh2yRdaMG9hDRwZp/j7XRdaA9/AqTBLQ7QaM9NNAG8CzYhhoBTng+EwPHqU/
         tyeDLWFLZmElgocGQtR1jrB4ySjno+zMB+m2U/GkDTCt1t2NIE1e2YCxprZnmzodlgTM
         w1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WOritaX7TiJ2UopsHt1F9UHI9/f6Pz6lo2giHHHHfc=;
        b=Eg9+C/SjNujB/TJE4rr9cnXQHkGgpaj9wJYPkjRDo5pxDyLt3cpid9OEKSsnQDI0lP
         9bE33Xo2GQ5dLA3zLmpFJAIVadipYmRl8ppcOGy8zyUvyc8dtGhP4/3l87LUh6YmtT0X
         hGtukVAT0S9WoGiqujv7JJcyhjNaqVeqoV+f1980cRhxoycINyk884+gGPfh7olBqC/o
         0MTj8FUCULxrvrIz7ZCEXIbNY6drIJGBdopI1cELsF8TDFp4psd/WveNvQ+1hKSIizqs
         8A64ywbjrFYDcANYJAlG9qrtcPWVrJXggeHduNGbM8vySSZAXvh7kuzMZsAKA6BfH820
         9LPg==
X-Gm-Message-State: AOAM532RrkinbDRLsA+rx1zX7c91i32WHf55qFbTVqVOg691mMqdBVuQ
        dNx58PK8BEAOvSXH4yNzu0iC4w==
X-Google-Smtp-Source: ABdhPJzGdqYQa5SLHwgOMU9gEnMe0J8cSx5N3gasbEOGt8sIW3sW/mNltLBQn2gM6MAQ/S5AV3AtcQ==
X-Received: by 2002:a5d:42c8:0:b0:20a:d91f:87b5 with SMTP id t8-20020a5d42c8000000b0020ad91f87b5mr12678734wrr.301.1652082546379;
        Mon, 09 May 2022 00:49:06 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id bw22-20020a0560001f9600b0020c5253d8d8sm11784768wrb.36.2022.05.09.00.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 May 2022 00:49:05 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     alexandre.torgue@foss.st.com, andrew@lunn.ch, broonie@kernel.org,
        calvin.johnson@oss.nxp.com, davem@davemloft.net,
        edumazet@google.com, hkallweit1@gmail.com,
        jernej.skrabec@gmail.com, joabreu@synopsys.com,
        krzysztof.kozlowski+dt@linaro.org, kuba@kernel.org,
        lgirdwood@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
        peppe.cavallaro@st.com, robh+dt@kernel.org, samuel@sholland.org,
        wens@csie.org
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev, Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/6] phy: handle optional regulator for PHY
Date:   Mon,  9 May 2022 07:48:52 +0000
Message-Id: <20220509074857.195302-2-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220509074857.195302-1-clabbe@baylibre.com>
References: <20220509074857.195302-1-clabbe@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add handling of optional regulators for PHY.
Regulators need to be enabled before PHY scanning, so MDIO bus
initiate this task.

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 drivers/net/mdio/fwnode_mdio.c | 32 ++++++++++++++++++++++++++++++++
 drivers/net/phy/phy_device.c   | 20 ++++++++++++++++++++
 include/linux/phy.h            |  3 +++
 3 files changed, 55 insertions(+)

diff --git a/drivers/net/mdio/fwnode_mdio.c b/drivers/net/mdio/fwnode_mdio.c
index 1c1584fca632..c377cadc14c3 100644
--- a/drivers/net/mdio/fwnode_mdio.c
+++ b/drivers/net/mdio/fwnode_mdio.c
@@ -10,6 +10,7 @@
 #include <linux/fwnode_mdio.h>
 #include <linux/of.h>
 #include <linux/phy.h>
+#include <linux/regulator/consumer.h>
 
 MODULE_AUTHOR("Calvin Johnson <calvin.johnson@oss.nxp.com>");
 MODULE_LICENSE("GPL");
@@ -95,6 +96,8 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 	bool is_c45 = false;
 	u32 phy_id;
 	int rc;
+	struct regulator *regulator_phy;
+	struct regulator *regulator_phy_io;
 
 	mii_ts = fwnode_find_mii_timestamper(child);
 	if (IS_ERR(mii_ts))
@@ -104,6 +107,32 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 					  "ethernet-phy-ieee802.3-c45");
 	if (rc >= 0)
 		is_c45 = true;
+	regulator_phy_io = devm_regulator_get_optional(&bus->dev, "phy-io");
+	if (IS_ERR(regulator_phy_io)) {
+		rc = PTR_ERR(regulator_phy_io);
+		if (rc == -ENODEV)
+			regulator_phy_io = NULL;
+		else
+			return rc;
+	}
+	regulator_phy = devm_regulator_get_optional(&bus->dev, "phy");
+	if (IS_ERR(regulator_phy)) {
+		rc = PTR_ERR(regulator_phy);
+		if (rc == -ENODEV)
+			regulator_phy = NULL;
+		else
+			return rc;
+	}
+	if (regulator_phy_io) {
+		rc = regulator_enable(regulator_phy_io);
+		if (rc)
+			return rc;
+	}
+	if (regulator_phy) {
+		rc = regulator_enable(regulator_phy);
+		if (rc)
+			return rc;
+	}
 
 	if (is_c45 || fwnode_get_phy_id(child, &phy_id))
 		phy = get_phy_device(bus, addr, is_c45);
@@ -114,6 +143,9 @@ int fwnode_mdiobus_register_phy(struct mii_bus *bus,
 		return PTR_ERR(phy);
 	}
 
+	phy->regulator_phy = regulator_phy;
+	phy->regulator_phy_io = regulator_phy_io;
+
 	if (is_acpi_node(child)) {
 		phy->irq = bus->irq[addr];
 
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 431a8719c635..ce64df596580 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -27,6 +27,7 @@
 #include <linux/phy.h>
 #include <linux/phy_led_triggers.h>
 #include <linux/property.h>
+#include <linux/regulator/consumer.h>
 #include <linux/sfp.h>
 #include <linux/skbuff.h>
 #include <linux/slab.h>
@@ -1785,6 +1786,11 @@ int phy_suspend(struct phy_device *phydev)
 	if (!ret)
 		phydev->suspended = true;
 
+	if (phydev->regulator_phy)
+		regulator_disable(phydev->regulator_phy);
+	if (phydev->regulator_phy_io)
+		regulator_disable(phydev->regulator_phy_io);
+
 	return ret;
 }
 EXPORT_SYMBOL(phy_suspend);
@@ -1811,6 +1817,20 @@ int phy_resume(struct phy_device *phydev)
 {
 	int ret;
 
+	if (phydev->regulator_phy_io) {
+		ret = regulator_enable(phydev->regulator_phy_io);
+		if (ret)
+			return ret;
+	}
+	if (phydev->regulator_phy) {
+		ret = regulator_enable(phydev->regulator_phy);
+		if (ret) {
+			if (phydev->regulator_phy_io)
+				regulator_disable(phydev->regulator_phy_io);
+			return ret;
+		}
+	}
+
 	mutex_lock(&phydev->lock);
 	ret = __phy_resume(phydev);
 	mutex_unlock(&phydev->lock);
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 2d12054932ba..c29f45668d94 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -704,6 +704,9 @@ struct phy_device {
 	void (*phy_link_change)(struct phy_device *phydev, bool up);
 	void (*adjust_link)(struct net_device *dev);
 
+	struct regulator *regulator_phy;
+	struct regulator *regulator_phy_io;
+
 #if IS_ENABLED(CONFIG_MACSEC)
 	/* MACsec management functions */
 	const struct macsec_ops *macsec_ops;
-- 
2.35.1

