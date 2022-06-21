Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E304A553400
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:51:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349871AbiFUNvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiFUNvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:51:16 -0400
X-Greylist: delayed 110 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Jun 2022 06:51:14 PDT
Received: from mxout.security-mail.net (mxout.security-mail.net [85.31.212.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 146D07661
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:51:14 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 8D5DE323714
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 15:49:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kalray.eu;
        s=sec-sig-email; t=1655819362;
        bh=78tnB+0PflHczeET28vWKLIRzZjUqx2ResLtP96u9HU=;
        h=From:To:Cc:Subject:Date;
        b=Mec2xBQSMOUYMNGg6sL/7x7BtpkedYPkRdTpn08t8kuybXVgoDi0yJJ46yFmkVV0+
         KRezpafN9Un0QfoxnZ0RLMXt6CHrtmm6heYu5zuMcMznAK1h+D7LIlFEW5AdkMa375
         x3I2hSD4Fomb4Ke7Yc1eNZly2E5on0qssnaRtTmU=
Received: from fx303 (localhost [127.0.0.1])
        by fx303.security-mail.net (Postfix) with ESMTP id 62BB93236A7;
        Tue, 21 Jun 2022 15:49:21 +0200 (CEST)
X-Virus-Scanned: E-securemail
Secumail-id: <e493.62b1cc60.6a097.0>
Received: from zimbra2.kalray.eu (unknown [217.181.231.53])
        by fx303.security-mail.net (Postfix) with ESMTPS id 6E93F3236D2;
        Tue, 21 Jun 2022 15:49:20 +0200 (CEST)
Received: from zimbra2.kalray.eu (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTPS id 421C627E04D6;
        Tue, 21 Jun 2022 15:49:20 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by zimbra2.kalray.eu (Postfix) with ESMTP id 28A0527E04D7;
        Tue, 21 Jun 2022 15:49:20 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.10.3 zimbra2.kalray.eu 28A0527E04D7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kalray.eu;
        s=32AE1B44-9502-11E5-BA35-3734643DEF29; t=1655819360;
        bh=Ho7qvdbzlGdpRQ3ww6//eS4KiQzS/QFvcZwfM5YeR+g=;
        h=From:To:Date:Message-Id;
        b=hWVI0oOcQeRRq7uUcTTn0UwsINQ6O0CrmGQsxc2U2fdgANSntuZ9huYrWxMf+UpGd
         KJjTpb9sOZM2UCKyRbB/uDZmNDBLBqmDktckrDcjISKYMATe1joAU8xqRxo7WxApzj
         wqBW51ZpXZCS8BwcHIkE2T3NMO7vWVG34Mjzd/I4=
Received: from zimbra2.kalray.eu ([127.0.0.1])
        by localhost (zimbra2.kalray.eu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q6HlZNV6A6jz; Tue, 21 Jun 2022 15:49:20 +0200 (CEST)
Received: from junon.lin.mbt.kalray.eu (unknown [192.168.37.161])
        by zimbra2.kalray.eu (Postfix) with ESMTPSA id 0521E27E04D6;
        Tue, 21 Jun 2022 15:49:20 +0200 (CEST)
From:   Yann Sionneau <ysionneau@kalray.eu>
To:     linux-kernel@vger.kernel.org
Cc:     Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        jvetter@kalray.eu, jmaselbas@kalray.eu,
        Yann Sionneau <ysionneau@kalray.eu>
Subject: [PATCH] net: phylink: check for pcs_ops being NULL
Date:   Tue, 21 Jun 2022 15:49:17 +0200
Message-Id: <20220621134917.24184-1-ysionneau@kalray.eu>
X-Mailer: git-send-email 2.17.1
X-Virus-Scanned: by Secumail
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Out of tree drivers that have not been updated
after 001f4261fe4d ("net: phylink: use legacy_pre_march2020") would not set the
legacy_pre_march2020 boolean which if not initialized will default to false.
Such drivers will most likely still be using the legacy interface and will
not have pcs_ops.

Check for pcs_ops being NULL even if driver does not advertise itself
as "pre march 2020 legacy". This commit adds a simple check instead of
dereferencing a NULL pointer and prints an error message to indicate
that the driver needs to be updated.

Signed-off-by: Yann Sionneau <ysionneau@kalray.eu>
---
 drivers/net/phy/phylink.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 06943889d747..94abf418afb1 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -874,6 +874,14 @@ static int phylink_change_inband_advert(struct phylink *pl)
 		return 0;
 	}
 
+	if (unlikely(!pl->pcs_ops)) {
+		phylink_err(pl, "%s: Error, net driver needs to either be "
+			    "updated to use pcs_ops or actually advertise it "
+			    "has legacy interface by setting "
+			    "legacy_pre_march2020 boolean", __func__);
+		return -EINVAL;
+	}
+
 	phylink_dbg(pl, "%s: mode=%s/%s adv=%*pb pause=%02x\n", __func__,
 		    phylink_an_mode_str(pl->cur_link_an_mode),
 		    phy_modes(pl->link_config.interface),
-- 
2.17.1

