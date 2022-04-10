Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4D14FAB43
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiDJA7j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:59:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233599AbiDJA7d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:59:33 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B4564F6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 17:57:19 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id p25so4875478pfn.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 17:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QZNoJQrBGI9JD45OnD6DIZaXO/kMMPWpj/KlmoCg03Y=;
        b=FwOQLSf/HG4LwtLIqHupe+fHvCXm64v1gVZDCBKGg2AlaliD20Q53zlWOFTcpktBiv
         ef1Cse59e0GnvQaf5ZSTC56IoAvVc6DPuHr6mgLHj2KfHXVCw6udysns5/2UmYAyn4nI
         kJ27R9b4jvpvLIoowVRqWDmH9leFfVyM78oaQAZDhF8V0va62+C7krCKyyhaUScoxt+J
         LJ84mJBOOSxbZAsrTHTB3JSWMW5CWKLWHhzNOLXNIO1ndYL3JjsWQ36z26uBoFNIxkGM
         VhNlSrVt8DrfQStWGm5LOemLMwOeE9gSAuHZAbDXl8g42GGQWqw+D1Vt+rvJZuAiAi2x
         cOOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QZNoJQrBGI9JD45OnD6DIZaXO/kMMPWpj/KlmoCg03Y=;
        b=eRA7vri/wvrfWL4Uj0GOURIN0myeRUFPmoOjYrGl3k4N1INeOuRKR16CHOGP0uS4JG
         N6vSiJek4F0W/FlA4TNQC8mIPzXY0r5/tK3x38b5no7IInYKXCorgRPs4XsPDY7YBfIQ
         Hx271XNgNbrG6MzKcFnWwf2VIu68AxfV1f57tfTjT6Tl8KjXgHHRuqbww6fvIa94IINh
         oZwqYvVOyVLr7fYeLJuihluD61OBXeuTN61x3YZOO+REw9lQ282szskfRp0hru8Ydlgq
         PR/xcILatsgIs893ds+yV4WG5ZjGyy9vzOQ+V4tEBL9a6DOhiUUwDk25NZfIbUVwGJsv
         fdsQ==
X-Gm-Message-State: AOAM532M0uwhnGT10+UC3ItWCgu2XaA0k1k1YtAAwVc05WtruJbSVIp3
        zmxu8xJuy3YvrWN8LWYBm2k=
X-Google-Smtp-Source: ABdhPJy2HLDay9p3FhB603mR+SAS80G+Oqjxmw6ZZ7aLpSTa1A+RagKHOXktT7Fg5EH6FApxpv/osg==
X-Received: by 2002:a63:4707:0:b0:382:207b:889c with SMTP id u7-20020a634707000000b00382207b889cmr21322246pga.541.1649552239187;
        Sat, 09 Apr 2022 17:57:19 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:172c:26af:268e:6e9f])
        by smtp.gmail.com with ESMTPSA id l67-20020a633e46000000b003986e01e982sm25088215pga.67.2022.04.09.17.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 17:57:18 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 3/4] xtensa: iss: clean up per-device locking in network driver
Date:   Sat,  9 Apr 2022 17:56:31 -0700
Message-Id: <20220410005632.3925219-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220410005632.3925219-1-jcmvbkbc@gmail.com>
References: <20220410005632.3925219-1-jcmvbkbc@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per-device locking in the ISS network driver is used to protect poll
timer and stats updates. Stat collection is not protected.
Remove per-device locking everywhere except the stats updates. Replace
ndo_get_stats callback with ndo_get_stats64 and use proper locking there
as well.
As a side effect this fixes possible deadlock between iss_net_close
and iss_net_timer.

Reported by: Duoming Zhou <duoming@zju.edu.cn>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/network.c | 39 +++++++++++++----------------
 1 file changed, 18 insertions(+), 21 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index e9454652551b..13802babba17 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -65,7 +65,7 @@ struct iss_net_private {
 	struct net_device *dev;
 	struct platform_device pdev;
 	struct timer_list tl;
-	struct net_device_stats stats;
+	struct rtnl_link_stats64 stats;
 
 	struct timer_list timer;
 	unsigned int timer_val;
@@ -281,7 +281,9 @@ static int iss_net_rx(struct net_device *dev)
 
 	skb = dev_alloc_skb(dev->mtu + 2 + ETH_HEADER_OTHER);
 	if (skb == NULL) {
+		spin_lock_bh(&lp->lock);
 		lp->stats.rx_dropped++;
+		spin_unlock_bh(&lp->lock);
 		return 0;
 	}
 
@@ -298,8 +300,10 @@ static int iss_net_rx(struct net_device *dev)
 		skb_trim(skb, pkt_len);
 		skb->protocol = lp->tp.protocol(skb);
 
+		spin_lock_bh(&lp->lock);
 		lp->stats.rx_bytes += skb->len;
 		lp->stats.rx_packets++;
+		spin_unlock_bh(&lp->lock);
 		netif_rx(skb);
 		return pkt_len;
 	}
@@ -314,13 +318,9 @@ static int iss_net_poll(struct iss_net_private *lp)
 	if (!netif_running(lp->dev))
 		return 0;
 
-	spin_lock(&lp->lock);
-
 	while ((err = iss_net_rx(lp->dev)) > 0)
 		ret++;
 
-	spin_unlock(&lp->lock);
-
 	if (err < 0) {
 		pr_err("Device '%s' read returned %d, shutting it down\n",
 		       lp->dev->name, err);
@@ -338,9 +338,7 @@ static void iss_net_timer(struct timer_list *t)
 	struct iss_net_private *lp = from_timer(lp, t, timer);
 
 	iss_net_poll(lp);
-	spin_lock(&lp->lock);
 	mod_timer(&lp->timer, jiffies + lp->timer_val);
-	spin_unlock(&lp->lock);
 }
 
 
@@ -349,11 +347,9 @@ static int iss_net_open(struct net_device *dev)
 	struct iss_net_private *lp = netdev_priv(dev);
 	int err;
 
-	spin_lock_bh(&lp->lock);
-
 	err = lp->tp.open(lp);
 	if (err < 0)
-		goto out;
+		return err;
 
 	netif_start_queue(dev);
 
@@ -368,22 +364,17 @@ static int iss_net_open(struct net_device *dev)
 	lp->timer_val = ISS_NET_TIMER_VALUE;
 	mod_timer(&lp->timer, jiffies + lp->timer_val);
 
-out:
-	spin_unlock_bh(&lp->lock);
 	return err;
 }
 
 static int iss_net_close(struct net_device *dev)
 {
 	struct iss_net_private *lp = netdev_priv(dev);
-	netif_stop_queue(dev);
-	spin_lock_bh(&lp->lock);
 
+	netif_stop_queue(dev);
 	del_timer_sync(&lp->timer);
-
 	lp->tp.close(lp);
 
-	spin_unlock_bh(&lp->lock);
 	return 0;
 }
 
@@ -393,13 +384,14 @@ static int iss_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	int len;
 
 	netif_stop_queue(dev);
-	spin_lock_bh(&lp->lock);
 
 	len = lp->tp.write(lp, &skb);
 
 	if (len == skb->len) {
+		spin_lock_bh(&lp->lock);
 		lp->stats.tx_packets++;
 		lp->stats.tx_bytes += skb->len;
+		spin_unlock_bh(&lp->lock);
 		netif_trans_update(dev);
 		netif_start_queue(dev);
 
@@ -408,24 +400,29 @@ static int iss_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	} else if (len == 0) {
 		netif_start_queue(dev);
+		spin_lock_bh(&lp->lock);
 		lp->stats.tx_dropped++;
+		spin_unlock_bh(&lp->lock);
 
 	} else {
 		netif_start_queue(dev);
 		pr_err("%s: %s failed(%d)\n", dev->name, __func__, len);
 	}
 
-	spin_unlock_bh(&lp->lock);
 
 	dev_kfree_skb(skb);
 	return NETDEV_TX_OK;
 }
 
 
-static struct net_device_stats *iss_net_get_stats(struct net_device *dev)
+static void iss_net_get_stats64(struct net_device *dev,
+				struct rtnl_link_stats64 *stats)
 {
 	struct iss_net_private *lp = netdev_priv(dev);
-	return &lp->stats;
+
+	spin_lock_bh(&lp->lock);
+	*stats = lp->stats;
+	spin_unlock_bh(&lp->lock);
 }
 
 static void iss_net_set_multicast_list(struct net_device *dev)
@@ -457,7 +454,7 @@ static int driver_registered;
 static const struct net_device_ops iss_netdev_ops = {
 	.ndo_open		= iss_net_open,
 	.ndo_stop		= iss_net_close,
-	.ndo_get_stats		= iss_net_get_stats,
+	.ndo_get_stats64	= iss_net_get_stats64,
 	.ndo_start_xmit		= iss_net_start_xmit,
 	.ndo_validate_addr	= eth_validate_addr,
 	.ndo_change_mtu		= iss_net_change_mtu,
-- 
2.30.2

