Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D5BD4E2D98
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 17:14:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350957AbiCUQOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 12:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350856AbiCUQOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 12:14:00 -0400
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D72072B1A4
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding; s=k1; bh=Dg6BP5ZGy7IAIx
        EnDCYIEu7neW0XgK82Rr5a7qQWPcE=; b=c1UYzCPhAoqYa6Gq36S2d4H8TIT/ej
        IBffDnLPjLej18kMqmJsAoQMczpGFnyjOY2eyHJG3F4W6U6o1JlMcImIm3o/cdgX
        Zg0aHFMUwPvwKhikA3QapOYye4c76nWcBCGV5fPD6AIFlCgRZRffyxhok7QFsRNO
        Mu8zlQgZdBg5U=
Received: (qmail 957898 invoked from network); 21 Mar 2022 17:12:33 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 21 Mar 2022 17:12:33 +0100
X-UD-Smtp-Session: l3s3148p1@R/KHw7zaKtkgAwDPXxCoAIeNYiWy88zT
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-renesas-soc@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Subject: [RFC PATCH 09/15] net: mdio: use new name 'usleep_autoyield' instead of 'fsleep'
Date:   Mon, 21 Mar 2022 17:12:17 +0100
Message-Id: <20220321161223.2837-10-wsa+renesas@sang-engineering.com>
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

 drivers/net/mdio/mdio-ipq4019.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-ipq4019.c b/drivers/net/mdio/mdio-ipq4019.c
index 4eba5a91075c..6e7de2e82e3a 100644
--- a/drivers/net/mdio/mdio-ipq4019.c
+++ b/drivers/net/mdio/mdio-ipq4019.c
@@ -192,7 +192,7 @@ static int ipq_mdio_reset(struct mii_bus *bus)
 		val = readl(priv->eth_ldo_rdy);
 		val |= BIT(0);
 		writel(val, priv->eth_ldo_rdy);
-		fsleep(IPQ_PHY_SET_DELAY_US);
+		usleep_autoyield(IPQ_PHY_SET_DELAY_US);
 	}
 
 	/* Configure MDIO clock source frequency if clock is specified in the device tree */
-- 
2.34.1

