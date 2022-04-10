Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DE1D4FAB41
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:57:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233551AbiDJA7q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:59:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233658AbiDJA7e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:59:34 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 888CCC0
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 17:57:21 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id s21so6582662pgv.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 17:57:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4iRUXL5EjBMyBZSPE/qcFAd30W/jy0/d7mesyYzIDjE=;
        b=a6MdRpZNHypAnH2GDSZ1p5dpqA4nHrNO3ZbUHBzNlMwwxwiSspxlmVP8qSgtfAy3Kx
         Ata4cquvJL5jyp4yprQn73mHpLLxLpNIVah/m9DAldEohIV+WcPHhy6T/+HMW1eAJGz/
         EUqI4BeGzJLbypf5p6zbup1US7KHJ6ozxiq6HqvOPxRvIj4NDaSl1W5N1mcQtKwVrdrJ
         UjmNDu1soJOlYWlRifnefGJmUqw3yhBCuNuXZC3ElgXT9WpTngMjrHmAoRXTETSLQPkP
         wz8tvSJO3+RLwVtt2aXQrcRw5Wiy/0di9MQo6yLcmHsYXq98AG/9Y+T2OEb9/w2DrpJO
         WCug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4iRUXL5EjBMyBZSPE/qcFAd30W/jy0/d7mesyYzIDjE=;
        b=QQO8hHYz8gBCHSp1DMXOwXPdf+jVKQbLGr/WK1hkjZMNiER+ZK7jguvhY+IQG6hiLV
         lxhD7bC8O0Dhbk1L43vlsMAz1D/CHhuR9yHM1Y4fKVnz0nnNm1rtWOpkYqEdKEkZsZDV
         NlBm0e9NUlJIwryoQdPT8intO9xBsnryihSa8zAvZRXAAszi39G+pKDr/wr0+GLI93Sm
         DPFQjI/VtH5zAiQsPbe8P5WoAiMTHxqiJ9PoaWheVVxwAtRk1XaNq+1IqonEaWrdSPPo
         W4cN96KJGvcSguYq7YFLnQaUuwlIB3ersdUscntgrxKWVibQtD2B6+FlCYuKnmVsoRqL
         yQCA==
X-Gm-Message-State: AOAM533NC5M58lJjSa5SwEBHLGKtxwxlzgmHfmUJnHsf7hjJc7yWfS6k
        ZpDDlwR9GtnHwLCX4lMXtEA=
X-Google-Smtp-Source: ABdhPJxzQ2ENfrXJ19nbHzvj3yrTKUn+qIqOGgMXwQpALKXXpGJikbZTWUa4stddYRTxHyPP9wDgeA==
X-Received: by 2002:a05:6a00:985:b0:505:9b3b:3fd6 with SMTP id u5-20020a056a00098500b005059b3b3fd6mr5038821pfg.30.1649552240941;
        Sat, 09 Apr 2022 17:57:20 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:172c:26af:268e:6e9f])
        by smtp.gmail.com with ESMTPSA id l67-20020a633e46000000b003986e01e982sm25088215pga.67.2022.04.09.17.57.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 17:57:20 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 4/4] xtensa: iss: extract and constify network callbacks
Date:   Sat,  9 Apr 2022 17:56:32 -0700
Message-Id: <20220410005632.3925219-5-jcmvbkbc@gmail.com>
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

Instead of storing pointers to callback functions in the
struct iss_net_private::tp move them to struct struct iss_net_ops and
store a const pointer to it. Make static const tuntap_ops structure with
tuntap callbacks and initialize tp.net_ops with it in the tuntap_probe.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/network.c | 47 +++++++++++++++++------------
 1 file changed, 28 insertions(+), 19 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 13802babba17..fd84d4891758 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -56,6 +56,17 @@ struct tuntap_info {
 /* ------------------------------------------------------------------------- */
 
 
+struct iss_net_private;
+
+struct iss_net_ops {
+	int (*open)(struct iss_net_private *lp);
+	void (*close)(struct iss_net_private *lp);
+	int (*read)(struct iss_net_private *lp, struct sk_buff **skb);
+	int (*write)(struct iss_net_private *lp, struct sk_buff **skb);
+	unsigned short (*protocol)(struct sk_buff *skb);
+	int (*poll)(struct iss_net_private *lp);
+};
+
 /* This structure contains out private information for the driver. */
 
 struct iss_net_private {
@@ -78,12 +89,7 @@ struct iss_net_private {
 			struct tuntap_info tuntap;
 		} info;
 
-		int (*open)(struct iss_net_private *lp);
-		void (*close)(struct iss_net_private *lp);
-		int (*read)(struct iss_net_private *lp, struct sk_buff **skb);
-		int (*write)(struct iss_net_private *lp, struct sk_buff **skb);
-		unsigned short (*protocol)(struct sk_buff *skb);
-		int (*poll)(struct iss_net_private *lp);
+		const struct iss_net_ops *net_ops;
 	} tp;
 
 };
@@ -211,6 +217,15 @@ static int tuntap_poll(struct iss_net_private *lp)
 	return simc_poll(lp->tp.info.tuntap.fd);
 }
 
+static const struct iss_net_ops tuntap_ops = {
+	.open		= tuntap_open,
+	.close		= tuntap_close,
+	.read		= tuntap_read,
+	.write		= tuntap_write,
+	.protocol	= tuntap_protocol,
+	.poll		= tuntap_poll,
+};
+
 /*
  * ethX=tuntap,[mac address],device name
  */
@@ -253,13 +268,7 @@ static int tuntap_probe(struct iss_net_private *lp, int index, char *init)
 	lp->mtu = TRANSPORT_TUNTAP_MTU;
 
 	lp->tp.info.tuntap.fd = -1;
-
-	lp->tp.open = tuntap_open;
-	lp->tp.close = tuntap_close;
-	lp->tp.read = tuntap_read;
-	lp->tp.write = tuntap_write;
-	lp->tp.protocol = tuntap_protocol;
-	lp->tp.poll = tuntap_poll;
+	lp->tp.net_ops = &tuntap_ops;
 
 	return 1;
 }
@@ -274,7 +283,7 @@ static int iss_net_rx(struct net_device *dev)
 
 	/* Check if there is any new data. */
 
-	if (lp->tp.poll(lp) == 0)
+	if (lp->tp.net_ops->poll(lp) == 0)
 		return 0;
 
 	/* Try to allocate memory, if it fails, try again next round. */
@@ -293,12 +302,12 @@ static int iss_net_rx(struct net_device *dev)
 
 	skb->dev = dev;
 	skb_reset_mac_header(skb);
-	pkt_len = lp->tp.read(lp, &skb);
+	pkt_len = lp->tp.net_ops->read(lp, &skb);
 	skb_put(skb, pkt_len);
 
 	if (pkt_len > 0) {
 		skb_trim(skb, pkt_len);
-		skb->protocol = lp->tp.protocol(skb);
+		skb->protocol = lp->tp.net_ops->protocol(skb);
 
 		spin_lock_bh(&lp->lock);
 		lp->stats.rx_bytes += skb->len;
@@ -347,7 +356,7 @@ static int iss_net_open(struct net_device *dev)
 	struct iss_net_private *lp = netdev_priv(dev);
 	int err;
 
-	err = lp->tp.open(lp);
+	err = lp->tp.net_ops->open(lp);
 	if (err < 0)
 		return err;
 
@@ -373,7 +382,7 @@ static int iss_net_close(struct net_device *dev)
 
 	netif_stop_queue(dev);
 	del_timer_sync(&lp->timer);
-	lp->tp.close(lp);
+	lp->tp.net_ops->close(lp);
 
 	return 0;
 }
@@ -385,7 +394,7 @@ static int iss_net_start_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	netif_stop_queue(dev);
 
-	len = lp->tp.write(lp, &skb);
+	len = lp->tp.net_ops->write(lp, &skb);
 
 	if (len == skb->len) {
 		spin_lock_bh(&lp->lock);
-- 
2.30.2

