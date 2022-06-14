Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F2D54B0FF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 14:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236047AbiFNM35 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 08:29:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243401AbiFNM2i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 08:28:38 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C883A3C4A1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:28:30 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 25so11369440edw.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 05:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=El3W9x0OB1VE70B0Lt3SBVyO+pC/HDeoL5aPqYtLRdg=;
        b=BiAOyZ/XYfnLieytaiCrXuW21pBo0n2NoPpY7GM5pLKNkdZ6mhfHALcly1gSTnfEe4
         qI+fC3AE55af0rHC7Zuc7avKy26528oBP6WLx0X1+3NsDEO9wLlCCMNx981e7baQ+V2m
         AgWjAXSvqm6SDChs9xqMjy0WTm6kXzNF1eumE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=El3W9x0OB1VE70B0Lt3SBVyO+pC/HDeoL5aPqYtLRdg=;
        b=cv7o5veWqpFpGfpghYkKYLUrvIW+PmIdHbIUHiiekBNfpiigKahixpt9qxXrr0WMu2
         qgR3cFG30vWiwgWL2PW3sp4yoOd2ouxtQqvRcpZz4h7U2mHp3IXqU+VK+OVKrlPKTpX/
         Bkv46bRsQa+ta+MiZhbQOWPdEj4WOOWDArUop7ArqchI4eKSdCUzYk/roU8zYG9/hLYh
         0zqFzH1jIEWD72dVZvCTgAnGtEsop4RI/y+Y7NO6m3zbwo5TDXcFFcQiEM2amUy2jeSS
         ggm+bD0Y44bPO7locmtzoB4csspcbB3R3UsnDx6c1v/STE3kJptteiCqwRnCNfwwNGRc
         tFNA==
X-Gm-Message-State: AOAM533CIMTJHERpEA8AXtWBb0jwtZaR5epw7XiwVTll3vx/4ScxAwS/
        k2zyy+TQNBL8gBSPlLQ1BUlbYK690w8CKg==
X-Google-Smtp-Source: ABdhPJxY51V2+bRO3eItM3jvTt+mAR9YkliMJJzg3a6IzB/EvnBrA4haRAhoDvTT+4auNuo5PaeGfQ==
X-Received: by 2002:a05:6402:100c:b0:42d:f407:b050 with SMTP id c12-20020a056402100c00b0042df407b050mr5652088edu.39.1655209708968;
        Tue, 14 Jun 2022 05:28:28 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.amarulasolutions.com (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id z22-20020a17090655d600b006f3ef214e2csm5087043ejp.146.2022.06.14.05.28.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 05:28:28 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v4 02/12] can: slcan: use netdev helpers to print out messages
Date:   Tue, 14 Jun 2022 14:28:11 +0200
Message-Id: <20220614122821.3646071-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
References: <20220614122821.3646071-1-dario.binacchi@amarulasolutions.com>
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

