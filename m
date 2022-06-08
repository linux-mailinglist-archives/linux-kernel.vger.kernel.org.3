Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7DB15439C6
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:56:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242268AbiFHQzr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:55:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243655AbiFHQxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:53:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424D03C6D90
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:51:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id fd25so27931356edb.3
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=El3W9x0OB1VE70B0Lt3SBVyO+pC/HDeoL5aPqYtLRdg=;
        b=ofPeQ4nOnRiV0JF8uxnd4QmlVQSgooaO19HSVx/tZLG3+veOye/ByzTR/HcFO9Q/tI
         e/be3ODSpfzJ87HtXgq5GRVhFan097ZAlwFdRS38X7Ij3FvV8uj3ZLaqM62YLR1zPpU9
         10bWbhJ5bH5BhdZB8EBUacC5a9qvqBgTQYHeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=El3W9x0OB1VE70B0Lt3SBVyO+pC/HDeoL5aPqYtLRdg=;
        b=wfk6dw74Ga7djSEcurE4fsIv0Sg+RUbKHYApean2wtV7mVGmuy1b7bpl40sYYpQ2FF
         n9IQVRgbmeXvDXyYoIo/xPYwN7ZAUnG4nXTt/1tQUqrwG0fiz+4FsucvvGOnwrjauglf
         63ZGOaL+qqTB1L36qWTpMOCX+2ddKEEIKeE/iraTaPGPHFTzT7Y42VD1WeAK1oBEXe6O
         6usXgRR32kTyE0HZuO4youKmFCtDCNq1SwrPtSkV8yVdcdqalwGO5Po9nV3zv82gmjXX
         w7/Tx8VUdVZF7Qh2n1hhtEwLliDMwfOV6M/uJq96fkGMzieqihCzmLF3rUcKO/O0a6Lh
         Emxg==
X-Gm-Message-State: AOAM532RLvY6dZbwTv83Ng4J0hUK64MQFFoDzqUtG8Cs96KZUTULroOf
        jvobpV3+V6/H441mB0qw8bL/FHGlNj0Sxg==
X-Google-Smtp-Source: ABdhPJwjP2b4f/NRRms4orlourt1Bsz3XkRyDBXTZTW4to64rEm6B+tMWyZgCtr9Yp4mnYOW5uSRiA==
X-Received: by 2002:a05:6402:1cb5:b0:42d:ddda:7459 with SMTP id cz21-20020a0564021cb500b0042dddda7459mr41312011edb.16.1654707086472;
        Wed, 08 Jun 2022 09:51:26 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm9569071ejp.19.2022.06.08.09.51.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:26 -0700 (PDT)
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
Subject: [PATCH v2 02/13] can: slcan: use netdev helpers to print out messages
Date:   Wed,  8 Jun 2022 18:51:05 +0200
Message-Id: <20220608165116.1575390-3-dario.binacchi@amarulasolutions.com>
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

Replace printk() calls with corresponding netdev helpers.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

(no changes since v1)

 drivers/net/can/slcan.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index b37d35c2a23a..6162a9c21672 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -365,7 +365,7 @@ static netdev_tx_t slc_xmit(struct sk_buff *skb, struct net_device *dev)
 	spin_lock(&sl->lock);
 	if (!netif_running(dev))  {
 		spin_unlock(&sl->lock);
-		printk(KERN_WARNING "%s: xmit: iface is down\n", dev->name);
+		netdev_warn(dev, "xmit: iface is down\n");
 		goto out;
 	}
 	if (sl->tty == NULL) {
@@ -776,8 +776,7 @@ static void __exit slcan_exit(void)
 
 		sl = netdev_priv(dev);
 		if (sl->tty) {
-			printk(KERN_ERR "%s: tty discipline still running\n",
-			       dev->name);
+			netdev_err(dev, "tty discipline still running\n");
 		}
 
 		unregister_netdev(dev);
-- 
2.32.0

