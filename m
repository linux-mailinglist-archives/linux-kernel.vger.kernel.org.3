Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C1DC846DECC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 00:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241030AbhLHXED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 18:04:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241012AbhLHXEC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 18:04:02 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B45DC061746
        for <linux-kernel@vger.kernel.org>; Wed,  8 Dec 2021 15:00:29 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id p27-20020a05600c1d9b00b0033bf8532855so2849922wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Dec 2021 15:00:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kryo-se.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOKpev+2V3cKtqcej7seNPIVNOu0LVpLbhiS4arwDwo=;
        b=GnQ6uG+aO8etYAhcx9NNwxNZgNwwsGKl5PUwumWLmqaJWCsF+wjY2gcs9IqUf9M6+l
         o1E41FO2W16Oz66sSFtzvnv2+9aQaaRdIS0NOBO9W/97KZ14suo/MC4BldUwNywxXqj4
         L/nuG2Pu1viONh2LSKCnTG6B+omRPQJcnUYVUdORkOi+iVLJWmQpfM5gRXZC3rqW1qBC
         FzhEpCIn428DruhbhfBybvRC1zkt2KL0H0yr5O0sl2ruVoVNkH26t+H56c1B0KJa4mf4
         mAIRnuxWqkezHrK4eat2IlmN19ZtmFU9ranDWPtPBcSgV0Y4y9DqRTHbFAJbLbgw4Ep1
         ve0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DOKpev+2V3cKtqcej7seNPIVNOu0LVpLbhiS4arwDwo=;
        b=I2Kkd+7Olbo3MNO6Y0QOgoxijkiOAH8DC0lhJgBa/bOm5mWGzh51KGFZtNpyigc6DL
         FiFISzU2vUsB3/M1gXRRSw/I1t8KT4H4S9cCwlAlqA81m3A7DXm/ImRVbYugJdppcojm
         kRDWX4mFlWxLnbtCUz59oN157FkvVBb3yfGWs4FaPUeAd8JIWP6QXJwqWFKbiWQBLIpk
         myOcJ75j64JUlnNYUatDiviFSDgmgV4jkE4lCanAvan3yQwAkBVsq1iRuBhcHDW5Fk8v
         Jn2OLZsExryKvtKNd5aFJmgxBXvvwAtMOVCUeGYHEkV5b0uHq/oETY8MZHL0yNAOUpdO
         FxZw==
X-Gm-Message-State: AOAM530+JwOcYQo4iMK5tXYnAtMxgOQBG+qRJbdJ5RrX7q22OcUMq4x6
        1ufa6OIAl5oBxUZa6L8Grm3+cQ==
X-Google-Smtp-Source: ABdhPJxPZ/0Nazb/N5GfpfOx9DNC9hdOuKxEToAJHsKiq3AeN+D+8qoqO5Xv0JHQpX1XIWt2h8RXNw==
X-Received: by 2002:a05:600c:4e8f:: with SMTP id f15mr2252545wmq.116.1639004427891;
        Wed, 08 Dec 2021 15:00:27 -0800 (PST)
Received: from kerfuffle.. ([2a02:168:9619:0:e47f:e8d:2259:ad13])
        by smtp.gmail.com with ESMTPSA id n1sm4166594wmq.6.2021.12.08.15.00.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 15:00:27 -0800 (PST)
From:   Erik Ekman <erik@kryo.se>
To:     Rasesh Mody <rmody@marvell.com>,
        Sudarsana Kalluru <skalluru@marvell.com>,
        GR-Linux-NIC-Dev@marvell.com,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>
Cc:     Erik Ekman <erik@kryo.se>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] net: bna: Update supported link modes
Date:   Thu,  9 Dec 2021 00:00:22 +0100
Message-Id: <20211208230022.153496-1-erik@kryo.se>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BR-series installation guide from https://driverdownloads.qlogic.com/
mentions the cards support 10Gbase-SR/LR as well as direct attach cables.

The cards only have SFP+ ports, so 10000baseT is not the right mode.
Switch to using more specific link modes added in commit 5711a98221443
("net: ethtool: add support for 1000BaseX and missing 10G link modes").

Only compile tested.

Signed-off-by: Erik Ekman <erik@kryo.se>
---
 .../net/ethernet/brocade/bna/bnad_ethtool.c   | 22 +++++++++----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
index 391b85f25141..d5bf1d4c8dae 100644
--- a/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
+++ b/drivers/net/ethernet/brocade/bna/bnad_ethtool.c
@@ -235,13 +235,18 @@ static int
 bnad_get_link_ksettings(struct net_device *netdev,
 			struct ethtool_link_ksettings *cmd)
 {
-	u32 supported, advertising;
-
-	supported = SUPPORTED_10000baseT_Full;
-	advertising = ADVERTISED_10000baseT_Full;
+	ethtool_link_ksettings_zero_link_mode(cmd, supported);
+	ethtool_link_ksettings_zero_link_mode(cmd, advertising);
+
+	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseCR_Full);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseSR_Full);
+	ethtool_link_ksettings_add_link_mode(cmd, supported, 10000baseLR_Full);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10000baseCR_Full);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10000baseSR_Full);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, 10000baseLR_Full);
 	cmd->base.autoneg = AUTONEG_DISABLE;
-	supported |= SUPPORTED_FIBRE;
-	advertising |= ADVERTISED_FIBRE;
+	ethtool_link_ksettings_add_link_mode(cmd, supported, FIBRE);
+	ethtool_link_ksettings_add_link_mode(cmd, advertising, FIBRE);
 	cmd->base.port = PORT_FIBRE;
 	cmd->base.phy_address = 0;
 
@@ -253,11 +258,6 @@ bnad_get_link_ksettings(struct net_device *netdev,
 		cmd->base.duplex = DUPLEX_UNKNOWN;
 	}
 
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.supported,
-						supported);
-	ethtool_convert_legacy_u32_to_link_mode(cmd->link_modes.advertising,
-						advertising);
-
 	return 0;
 }
 
-- 
2.33.1

