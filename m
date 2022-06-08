Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55AAC5439D3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:57:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243534AbiFHQ4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245377AbiFHQxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:53:36 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CE332342B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:51:32 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id u12so42644352eja.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nVyQpX+Yrz3qKt1Nh+jQPIqCDb+sgmjzafkew5xQQck=;
        b=EbNQlONLEw3flg+v8r7QTPOnPPJjDqYyauDId67C9ZpX0EjOci3Gm9WoX8m07QgFXN
         w6dKi3IzR1XQuYf2Ngd5xSWYWTQKGu2/d+F0HuUqgO73NK+niApZ3J3YwyiUwkZaYgNP
         Ayn5woO2pi3yTGTM3n7s+1CmRBu6gpNEm1oWE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nVyQpX+Yrz3qKt1Nh+jQPIqCDb+sgmjzafkew5xQQck=;
        b=wcF6HZr78cwzlsoYjmpr3BI41s4oi7y2PkKgg/hErBow4eQVYN26fVo11C5ooxeYQq
         olfpGWyDjkomF9qZtJ+Ubi40J29xBJ5Zk85i4NTPU0x5SNK6QTfT0Ugu38BjG8tK+mG3
         7lWQGx6CdvTNjWtz2YfxGjajInJL5J4epgGifTc7clEyZJs+Y12TVmeKnKAqFXZfYzGI
         QMGnpF5+NhmASZiZKKqggHoGVqj6BzSVih6L1eJiI/5I6LloZiqSf8M3nEpKOAj2oAra
         7Q1Q2ArSHgtfwS26YxoCkhaSfH/s6p9PRwNx4s7A2uAv0zI+R9tM8xPSCk2WpDh8Sdgz
         hkxg==
X-Gm-Message-State: AOAM531MTGMBn2CNpvAJc0kJk5QjPUIoD4QC/0aG16fxOw9DF9NK984F
        zjHrnlQRIy7VB48LXZcFHqT0x0cEgIQflQ==
X-Google-Smtp-Source: ABdhPJzS0WTgsEmT6o/MldkA0xQDsGfnejkAvMiaThfxPCarALGnI2DSJejx4G0f9/wXxWeUN+pCuw==
X-Received: by 2002:a17:907:6e13:b0:711:c722:4fc with SMTP id sd19-20020a1709076e1300b00711c72204fcmr18014645ejc.253.1654707090839;
        Wed, 08 Jun 2022 09:51:30 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm9569071ejp.19.2022.06.08.09.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:30 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 05/13] can: slcan: simplify the device de-allocation
Date:   Wed,  8 Jun 2022 18:51:08 +0200
Message-Id: <20220608165116.1575390-6-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
References: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since slcan_devs array contains the addresses of the created devices, I
think it is more natural to use its address to remove it from the list.
It is not necessary to store the index of the array that points to the
device in the driver's private data.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/slcan.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 929cb55e08af..cf05c30b8da5 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -432,11 +432,17 @@ static int slc_open(struct net_device *dev)
 
 static void slc_dealloc(struct slcan *sl)
 {
-	int i = sl->dev->base_addr;
+	unsigned int i;
 
-	free_candev(sl->dev);
-	if (slcan_devs)
-		slcan_devs[i] = NULL;
+	for (i = 0; i < maxdev; i++) {
+		if (sl->dev == slcan_devs[i]) {
+			free_candev(sl->dev);
+			slcan_devs[i] = NULL;
+			return;
+		}
+	}
+
+	pr_err("slcan: can't free %s resources\n",  sl->dev->name);
 }
 
 static int slcan_change_mtu(struct net_device *dev, int new_mtu)
@@ -533,7 +539,6 @@ static struct slcan *slc_alloc(void)
 
 	snprintf(dev->name, sizeof(dev->name), "slcan%d", i);
 	dev->netdev_ops = &slc_netdev_ops;
-	dev->base_addr  = i;
 	sl = netdev_priv(dev);
 
 	/* Initialize channel control data */
-- 
2.32.0

