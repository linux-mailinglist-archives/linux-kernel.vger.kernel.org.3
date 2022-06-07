Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D04F53FA39
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240076AbiFGJsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240014AbiFGJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:48:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FF5AE7323
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:48:15 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id k19so23330081wrd.8
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:48:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tNUOqb45O/Ilv1mJP0lwEr7O4bll5ez6OZhdGeCnOYk=;
        b=aSj7vDU7AbFC0EV4ObqejY5ilPc6PDl68qCalrtM9AmersGWrZkqOD8wsWwyrgx0Kl
         aMFgab1d7o18753cuOu0YkvSNdpu3yt2QTmjSbwP/LYS6lRkNxaon38FkZGVtqFBMg51
         CuSG3xaF9d+PVJKpPo8kSeiP/71ZGpwPNnjdA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tNUOqb45O/Ilv1mJP0lwEr7O4bll5ez6OZhdGeCnOYk=;
        b=l4muHwf3p+RvupuRDx2tevHbnaUqu+TcFXw8azHY9K5wIkiQ3Z2NtWvfPgOIliUPRw
         zAwhhtzNR3MpVs+9/2qHT39eqHJK6cmNkMGdCH6YLN66SN8bLGytMEaaGeCrGDDzPFF0
         cnxPENZMNm9y6hBpH0TVtd6kSL3zVKIQsu+PWmTXGJlL70DNVWNhu4RctQXKHAUczYbX
         jh4URiIFDXjxwhiU6CFoX1NiL1y6sDqgwsZsyh9BYaywalVV1FndEzUUVbAHaeUQNKhD
         6wswQYlAnKOeTunJFah6CaO2PXqTpbipt7KsFVueSc8rPpEeJGiJrwXDn1E2XoTmhfIk
         aEcg==
X-Gm-Message-State: AOAM532EaEFgIKNmlBIXj/GuHXnTK/i/T3FiFRWLqXmPhV6EwTwmMF3a
        MSH2b2yMnSJPNcr157bR619yZUVCUXAPhw==
X-Google-Smtp-Source: ABdhPJzxV76XCOBQmc7+Lj65tB9pSTfRlZHibJl7Uk43JIepJsgft9u0vd0PcfX2LWMukczoGmh+Hw==
X-Received: by 2002:a05:6000:1acc:b0:20f:e35e:450 with SMTP id i12-20020a0560001acc00b0020fe35e0450mr25899806wry.531.1654595293242;
        Tue, 07 Jun 2022 02:48:13 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (mob-5-90-137-51.net.vodafone.it. [5.90.137.51])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0039748be12dbsm23200547wms.47.2022.06.07.02.48.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:48:12 -0700 (PDT)
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
Subject: [RFC PATCH 02/13] can: slcan: use netdev helpers to print out messages
Date:   Tue,  7 Jun 2022 11:47:41 +0200
Message-Id: <20220607094752.1029295-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
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

