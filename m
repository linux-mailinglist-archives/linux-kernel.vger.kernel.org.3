Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F12BD52F66D
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 01:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354154AbiETX6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 19:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236380AbiETX6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 19:58:52 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7763A1A0ADC
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:58:51 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id h205-20020a1c21d6000000b003972dda143eso1781881wmh.3
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 16:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZudmt8QjK7Ob0wwst9Iisd3ub5uSgdUrqhdvCAPlJY=;
        b=n8YxOwsVsDs+d/Xov7EF5yekr3+BjzL7dG3FuFiONfF/sfoECLWTB3fLCdqaQTT5Bc
         KCx4DZrjRGSNXTM14Rem+/1taT7VIFFAclXaS9I/+TrXfOlxiQJBpxtkVZF2h6HyfFkR
         G0vtzP5zKGwENv+H7JPdHm4S6+BLi+JIfWofs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=CZudmt8QjK7Ob0wwst9Iisd3ub5uSgdUrqhdvCAPlJY=;
        b=6rwPJSIyfUtY0QglJ9kwfeEIS1qCu86Nvv91XmeSibHdMyB94UM4AOH0cL/Vqc1ENJ
         z8Y2WfHbqj7riKXdP0ylAp4N+3lcycT1WAAcrVUjRpA63FwH9gQUgLPUPRULgBA0+klJ
         AWMHzcr2UW/fSD77jlsIizmJxeLeQKts2tC3TpYBixAv3MqDeZl5bMMZ64cYzqLTfwS3
         yD9Gf/zPogLdSoPjnm1HmYdpgOTaQTGdcxprFgxS7Ik9/9+pz2b9Y3UJV9xFeA3/kiuB
         OsWPYK+vNa3xUVq+7Nnio0PHojNzFwqrQb3XiwO/qSq46iPBMQiWAKKaCrikq8SPRikN
         LrOQ==
X-Gm-Message-State: AOAM530Hi3m6WePq4K+oZZdwZgnEB8wqBIQ8ubRlSn/VPiihXjUYD2w5
        ToGv0lwysJbaOpV6bHK4cCJv0jqPEubADg==
X-Google-Smtp-Source: ABdhPJyDdA9UiEi//2k2WCzJgQm8Dc/PW76V4KuUHKDVaRIJJzXRJoXMEnvbcpjfiuMh8OSv8ZtKIA==
X-Received: by 2002:a05:600c:3c8b:b0:397:2db3:97a8 with SMTP id bg11-20020a05600c3c8b00b003972db397a8mr9203193wmb.132.1653091130092;
        Fri, 20 May 2022 16:58:50 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-53-154.cust.vodafonedsl.it. [188.217.53.154])
        by smtp.gmail.com with ESMTPSA id l41-20020a05600c1d2900b003973343c014sm3216306wms.33.2022.05.20.16.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 16:58:49 -0700 (PDT)
From:   Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     tommaso.merciai@amarulasolutions.com, michael@amarulasolutions.com,
        alberto.bianchi@amarulasolutions.com,
        linux-amarula@amarulasolutions.com, linuxfancy@googlegroups.com,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] net: phy: DP83822: enable rgmii mode if phy_interface_is_rgmii
Date:   Sat, 21 May 2022 01:58:46 +0200
Message-Id: <20220520235846.1919954-1-tommaso.merciai@amarulasolutions.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RGMII mode can be enable from dp83822 straps, and also writing bit 9
of register 0x17 - RMII and Status Register (RCSR).
When phy_interface_is_rgmii rgmii mode must be enabled, same for
contrary, this prevents malconfigurations of hw straps

References:
 - https://www.ti.com/lit/gpn/dp83822i p66

Signed-off-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Co-developed-by: Michael Trimarchi <michael@amarulasolutions.com>
Suggested-by: Alberto Bianchi <alberto.bianchi@amarulasolutions.com>
Tested-by: Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
---
Changes since v2:
 - Fix comment of register name RSCR -> RCSR
 - Fix define DP83822_RGMII_MODE_EN location

Changes since v1:
 - Improve commit msg
 - Add definition of bit 9 reg rcsr (rgmii mode en)
 - Handle case: phy_interface_is_rgmii is false

 drivers/net/phy/dp83822.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index ce17b2af3218..e6ad3a494d32 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -94,7 +94,8 @@
 #define DP83822_WOL_INDICATION_SEL BIT(8)
 #define DP83822_WOL_CLR_INDICATION BIT(11)
 
-/* RSCR bits */
+/* RCSR bits */
+#define DP83822_RGMII_MODE_EN	BIT(9)
 #define DP83822_RX_CLK_SHIFT	BIT(12)
 #define DP83822_TX_CLK_SHIFT	BIT(11)
 
@@ -408,6 +409,12 @@ static int dp83822_config_init(struct phy_device *phydev)
 			if (err)
 				return err;
 		}
+
+		phy_set_bits_mmd(phydev, DP83822_DEVADDR,
+					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
+	} else {
+		phy_clear_bits_mmd(phydev, DP83822_DEVADDR,
+					MII_DP83822_RCSR, DP83822_RGMII_MODE_EN);
 	}
 
 	if (dp83822->fx_enabled) {
-- 
2.25.1

