Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FB2E52DD14
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241930AbiESSvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243401AbiESSvE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:51:04 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8F1E32ED8
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:51:00 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id ay35so1773183wmb.5
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 11:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVrso6fiVQrzi/HfLaD8z5m4C5/B3zTk0qBr6sq01RQ=;
        b=TAeL8EKap/C4tHWgh3R6CDq5IuLjiax1NyG0DCsREnD0c2fEEEeNHK53qsBzRlpcRC
         YrWMgaAM/9bgglVUWFjAqiotoiOXyYDAoDcZRGhh9+WlIjfsmJD/2/dqhWImLgBfNPP+
         49e8Fw2co8BQL8gywjHxhKsLXM20p3zErmicI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zVrso6fiVQrzi/HfLaD8z5m4C5/B3zTk0qBr6sq01RQ=;
        b=uhzypn6Qbkkl92aT9gxNRaHtKsfupigYd75ZU3dfX+diPRXpvnSrw4k+/kZC5jDto+
         N5BMZjSQUx6QkWnexL3FdKiRI8BZLviKi1Ky+SUsbrLbNS5ymbzxgEC2oM7nb7ZjWrNP
         LvwAyiAA7cGeukOEcEqkrU08npe/cpXqJtyvUDimbV+9bSBTiOF3aTvXkMTDrxbldha9
         0s8LubuNaBtUU+jF0Qv5so2RwVCLoQh8qhfNReqcs+MmQULjk53UyrChcjgS8ATWQqux
         LZVQGe694aP1LoPZ/rUIbCJ2/TfplfOzderdUUvINi7weB5q9sSf5CGXHJrHtphJRVxV
         kdOg==
X-Gm-Message-State: AOAM533yglTjt6B1k+DbnnHhIMj+AuqDRmE1K8KFYKAJT0CTZzLLHxEz
        PA0pgj1Nr8uaLw8g1bmgeyza+A==
X-Google-Smtp-Source: ABdhPJxBZeshs+x8J/WZRYu/f5XVSo28i1rMFyazIa8c8iBxTY/lJcS4+qFJpP5fjRv8z+xXq2oBYg==
X-Received: by 2002:a7b:c4cc:0:b0:394:7d6c:fdf4 with SMTP id g12-20020a7bc4cc000000b003947d6cfdf4mr5578743wmk.163.1652986259580;
        Thu, 19 May 2022 11:50:59 -0700 (PDT)
Received: from tom-ThinkPad-T14s-Gen-2i.station (net-188-217-53-154.cust.vodafonedsl.it. [188.217.53.154])
        by smtp.gmail.com with ESMTPSA id j11-20020adfb30b000000b0020c5253d8fdsm300457wrd.73.2022.05.19.11.50.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 11:50:59 -0700 (PDT)
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
Subject: [PATCH v2] net: phy: DP83822: enable rgmii mode if phy_interface_is_rgmii
Date:   Thu, 19 May 2022 20:50:56 +0200
Message-Id: <20220519185057.1657115-1-tommaso.merciai@amarulasolutions.com>
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
Changes since v1:
 - Improve commit msg
 - Add definition of bit 9 reg rcsr (rgmii mode en)
 - Handle case: phy_interface_is_rgmii is false

 drivers/net/phy/dp83822.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/net/phy/dp83822.c b/drivers/net/phy/dp83822.c
index ce17b2af3218..7cb9d084707b 100644
--- a/drivers/net/phy/dp83822.c
+++ b/drivers/net/phy/dp83822.c
@@ -94,6 +94,9 @@
 #define DP83822_WOL_INDICATION_SEL BIT(8)
 #define DP83822_WOL_CLR_INDICATION BIT(11)
 
+/* RCSR bits */
+#define DP83822_RGMII_MODE_EN	BIT(9)
+
 /* RSCR bits */
 #define DP83822_RX_CLK_SHIFT	BIT(12)
 #define DP83822_TX_CLK_SHIFT	BIT(11)
@@ -408,6 +411,12 @@ static int dp83822_config_init(struct phy_device *phydev)
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

