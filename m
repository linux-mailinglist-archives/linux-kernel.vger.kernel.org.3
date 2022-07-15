Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE2E5575E0A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233574AbiGOIvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 04:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233042AbiGOIuu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 04:50:50 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4795082462
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:50:47 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id bu42so6842174lfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 01:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+d/aojT1TCgagMDA6o2QljnvpRxpeI/WOeBAtluw3O0=;
        b=Csg+XBvQXDUJJyiEkv/Pn2FIpcj+ic/32obyLUtvvYy93EcsZ0fEMr0vcuA5L4pBVI
         cXOZEYBpHmORuphlcLHebTylvpZLiWXGZ7J0Zkzz9iKINVQTHWzvdWvm7IYYd5kX1byH
         A0EDO3IP1RoJjmfQxuSDz0WN49ZvpFaoknWVa4qNtQBfQFAMBKjA1YJClSv8M5dU/Eyh
         LhUFThZbNEuggtcaGgkAOce4193FmQ1Xya4EBa0O86f0MdLxZwn6IVhF69RJO1VhVlIW
         sN9fgohUnn8up92RwpwvqmUx6b97AJgr42JXP8pTBMRqerwj7hR1uMoV0ixr2KBwNZA6
         pWYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+d/aojT1TCgagMDA6o2QljnvpRxpeI/WOeBAtluw3O0=;
        b=qQDG5S9PKAgdngHpNqu1bAPFRVFBz5SGw7sPdtIKdQRteSD4Zd0oZGCqStfG9b0qcZ
         9wQYSZykyj8LsAD7JgofdM+2Cln788NGocOFkRf5p5Dl35JgWndIz67aO/a1cOUDnpfN
         4KPP2Si7+2bBf58f7ZRptGDv0tIQoxjtXbBaPYMzgy7mHTpDbIoLbRHdKwKIq9X9t0zW
         1mCBPa8y57FdNsj+szIpHC4vsjMxzHyuVwEIoGoHCk2jnw5yQsoei+TS+MJ4RG45vAuD
         0EWPPLyQhUSjsiMUZcENNjY8ZqPrMoidSEBkzZqwYNiWcJK0qNH1dd2roGYqe/WtMQmH
         f7Ag==
X-Gm-Message-State: AJIora8FLY/y0RQ6d1fET0upuHTDRcAd7JhBOnezkBqHIAGPosIucZbh
        fFv0x+19EO6go1je9qQkO0Gzb+83U3kOZQ==
X-Google-Smtp-Source: AGRyM1vGJNBjEBQkEjQov65wX5302UAtQD2jH7TjcEWqfZTkmMOaegIuQZGOutC7HVnFEstpCAhwAw==
X-Received: by 2002:a05:6512:2030:b0:489:c8bf:3f29 with SMTP id s16-20020a056512203000b00489c8bf3f29mr7867805lfs.274.1657875045544;
        Fri, 15 Jul 2022 01:50:45 -0700 (PDT)
Received: from gilgamesh.lab.semihalf.net ([83.142.187.85])
        by smtp.gmail.com with ESMTPSA id e4-20020a2e9e04000000b0025d773448basm667846ljk.23.2022.07.15.01.50.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Jul 2022 01:50:45 -0700 (PDT)
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
Subject: [net-next: PATCH v2 4/8] net: mvpp2: initialize port fwnode pointer
Date:   Fri, 15 Jul 2022 10:50:08 +0200
Message-Id: <20220715085012.2630214-5-mw@semihalf.com>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20220715085012.2630214-1-mw@semihalf.com>
References: <20220715085012.2630214-1-mw@semihalf.com>
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

As a preparation to switch the DSA subsystem from using
of_find_net_device_by_node() to its more generic fwnode_
equivalent, the port's device structure should be updated
with its fwnode pointer, similarly to of_node - see analogous
commit c4053ef32208 ("net: mvpp2: initialize port of_node pointer").

This patch is required to prevent a regression before updating
the DSA API on boards that connect the mvpp2 port to switch,
such as Clearfog GT-8K or CN913x CEx7 Evaluation Board.

Signed-off-by: Marcin Wojtas <mw@semihalf.com>
---
 drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index b84128b549b4..03d5ff649c47 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -6868,7 +6868,7 @@ static int mvpp2_port_probe(struct platform_device *pdev,
 	dev->min_mtu = ETH_MIN_MTU;
 	/* 9704 == 9728 - 20 and rounding to 8 */
 	dev->max_mtu = MVPP2_BM_JUMBO_PKT_SIZE;
-	dev->dev.of_node = port_node;
+	device_set_node(&dev->dev, port_fwnode);
 
 	port->pcs_gmac.ops = &mvpp2_phylink_gmac_pcs_ops;
 	port->pcs_xlg.ops = &mvpp2_phylink_xlg_pcs_ops;
-- 
2.29.0

