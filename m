Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 809FB53EF18
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbiFFUCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232846AbiFFUCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:02:15 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CDDB1EAF9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:02:13 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n10so31064968ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rasmusvillemoes.dk; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4YhtFq7gpt5SCvZO+T7ylGVP3MGJYIhRqtlKBWOMr0=;
        b=WlYCSdpxeDlJZcJ/ihVtIrbtovOo784RLDbNUT40brnr1yFo1QrCUhbRPHF1UyywPD
         Y6FPmoMwCWYbbgFXlv2x6X6yh1OuRHPXOEhlj3puWT0IQkVj2k/oKfebEG2hwjAgXDA1
         gLtt52Crqd+2u4zQgPVAGx2hMmir3pQH/4JKI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=f4YhtFq7gpt5SCvZO+T7ylGVP3MGJYIhRqtlKBWOMr0=;
        b=K1FzKo0QXZPsrQSQFovFH4DWnv10EgTyHfQX0n29ZzE5tcc2GhXQTGWrpKOWPXCtZ0
         Z1f/oY5hybqDurgu1TYJHZF04tQDOmD0dMXznMY+M6DvlGM+0MXacEDQ2+iFUfpIT7ST
         hz2Jpfjq+NnYvCVnvTe5ocgE/GKIXx2y99+h2VaQQZFdTEOWST4hgdS+gcfzyqB3Hn5Z
         2/83VcwQKcb3DyVgPcUV5sDM7TQDhMdbhRNoRR+V619ytYfqlIRxmR3uHcC4T8S4XNd6
         WNcs5jTxgywlY3ImvBimFChJC2YNqsNuYV5e8PbmIvMZJWZAzXCD/yWMHCmA1AZOmPyA
         F+VA==
X-Gm-Message-State: AOAM5339ExFNaTGhadVeK+MNXahUg+Z8pte/EOYURt/i8qqMTjluD17U
        u4npM70sEt4phOUJRVenwlSoSA==
X-Google-Smtp-Source: ABdhPJwt2I4FbXbOCurE7PeUk1wWg0jl/KOh25KW4tm8zgWkp/EEVNLY0dHSV5SrZCmD9o57qYXMxQ==
X-Received: by 2002:a17:906:1193:b0:70d:cf39:a4db with SMTP id n19-20020a170906119300b0070dcf39a4dbmr17730625eja.44.1654545731648;
        Mon, 06 Jun 2022 13:02:11 -0700 (PDT)
Received: from prevas-ravi.tritech.se ([80.208.64.233])
        by smtp.gmail.com with ESMTPSA id o8-20020a1709062e8800b006f3ef214e0esm6664814eji.116.2022.06.06.13.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:02:11 -0700 (PDT)
From:   Rasmus Villemoes <linux@rasmusvillemoes.dk>
To:     Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: fixed_phy: set phy_mask before calling mdiobus_register()
Date:   Mon,  6 Jun 2022 22:02:08 +0200
Message-Id: <20220606200208.1665417-1-linux@rasmusvillemoes.dk>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's no point probing for phys on this artificial bus, so we can
save a little bit of boot time by telling mdiobus_register() not to do
that.

This doesn't have any functional change, since, at this point,
fixed_mdio_read() returns 0xffff for all addresses/registers, so

  mdiobus_scan() -> get_phy_device() -> get_phy_c22_id()

will return -ENODEV, which is just ignored.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
---
I was trying to debug something and got distracted by the printk() I
added in get_phy_device() triggering 32 times in a row.

drivers/net/phy/fixed_phy.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/phy/fixed_phy.c b/drivers/net/phy/fixed_phy.c
index 03abe6233bbb..aef739c20ac4 100644
--- a/drivers/net/phy/fixed_phy.c
+++ b/drivers/net/phy/fixed_phy.c
@@ -353,6 +353,7 @@ static int __init fixed_mdio_bus_init(void)
 	fmb->mii_bus->parent = &pdev->dev;
 	fmb->mii_bus->read = &fixed_mdio_read;
 	fmb->mii_bus->write = &fixed_mdio_write;
+	fmb->mii_bus->phy_mask = ~0;
 
 	ret = mdiobus_register(fmb->mii_bus);
 	if (ret)
-- 
2.31.1

