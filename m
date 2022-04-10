Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1224FAB40
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 02:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233589AbiDJA71 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 20:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbiDJA7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 20:59:24 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70F1CD48
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 17:57:16 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id md4so3701662pjb.4
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 17:57:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jtK/Vrx2NulzdlRFPGXxwDEDEKWt3aWW57PRS+XOqA=;
        b=Q3fqWcBLRFXsFMjVzCyo5s+q9IpD4s0sEc6ysGZlrrkF2Ufdtp/Ec0mcPPf5BV5znC
         UiJEoJeMyXdZdZvbGsISnmRGT23acVGxG1HI86sd0PvBcGdJF9gfmleiafIilCVKT6O4
         0bRk+tVTWeMTIvZeaO12t1sM58Qba6cujenymQ4ivLB1VhHFf34G+f1eE+ijl5CLq9of
         Wc31h0wWKrSURHkYSZ1xP0urSU2pZ/d1jeuF4bUoXbvdaS6BjDigA16RoKbCdyMdQSYz
         a4jC7EtsBZJt2Ap/UAhXVE3CC8WvIvpuFPy8Blgg6pt6UzlA7e4iCOEdLg8iJNQcoGni
         s8CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jtK/Vrx2NulzdlRFPGXxwDEDEKWt3aWW57PRS+XOqA=;
        b=w/jf/oH0gbBeZc+O5iICZaViCjlXzT/mu7qN8erFChzMmWhwvtCJ4VdEljgLM/Lmf1
         hlZjSahq02JtQzcFkhXVW5GcFlIcTsDhsbvCIqqS2mbQjxRZymCuKAkBhJ8gNOk91f9l
         v1dgaTi/5Rd2/uF7j4u9KHX0DLfqOSvuPcXb5aNDK25zVvufVcFbShSY1Ih0KTeSUjLk
         rBrM2EVyWhy8oRlwmPD1FM2xGoY/8iAnzFBqRuQHQdv4VThEmOTC9QH9/HSLd/Mvj6xz
         NBMBEGXf5+ru31IV0KZpXycg/P1tbAUHeA6L9yWcdwgEGgMvpaJL+h5IhWGWDn5lrBtL
         wNZQ==
X-Gm-Message-State: AOAM532OVMHY6eH0tZrNmQxFhsM1z8RDdK1aRVrK4cyUxsFC7LGZ6dqu
        RkeM2fE4Wn8FoL8yH7u0v9A=
X-Google-Smtp-Source: ABdhPJzuaAn5Pz4e119YMSAWmO4/3v2UeHNIGezXp/yG9Yb2N7Uc3Prc+aahlQaU53wphLrS52qHjw==
X-Received: by 2002:a17:903:1108:b0:156:73a7:7c1 with SMTP id n8-20020a170903110800b0015673a707c1mr25778457plh.101.1649552235927;
        Sat, 09 Apr 2022 17:57:15 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:172c:26af:268e:6e9f])
        by smtp.gmail.com with ESMTPSA id l67-20020a633e46000000b003986e01e982sm25088215pga.67.2022.04.09.17.57.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Apr 2022 17:57:15 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Duoming Zhou <duoming@zju.edu.cn>,
        Jakub Kicinski <kuba@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 1/4] xtensa: iss: drop opened_list logic from the network driver
Date:   Sat,  9 Apr 2022 17:56:29 -0700
Message-Id: <20220410005632.3925219-2-jcmvbkbc@gmail.com>
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

opened_list is used to poll all opened devices in the timer callback,
but there's individual timer that is associated with each device.
Drop opened_list and only poll the device that is associated with the
timer in the timer callback.

Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 arch/xtensa/platforms/iss/network.c | 53 ++++++++---------------------
 1 file changed, 14 insertions(+), 39 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index be3aaaad8bee..409def002f55 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -38,9 +38,6 @@
 #define ISS_NET_TIMER_VALUE (HZ / 10)
 
 
-static DEFINE_SPINLOCK(opened_lock);
-static LIST_HEAD(opened);
-
 static DEFINE_SPINLOCK(devices_lock);
 static LIST_HEAD(devices);
 
@@ -63,7 +60,6 @@ struct tuntap_info {
 
 struct iss_net_private {
 	struct list_head device_list;
-	struct list_head opened_list;
 
 	spinlock_t lock;
 	struct net_device *dev;
@@ -311,38 +307,28 @@ static int iss_net_rx(struct net_device *dev)
 	return pkt_len;
 }
 
-static int iss_net_poll(void)
+static int iss_net_poll(struct iss_net_private *lp)
 {
-	struct list_head *ele;
 	int err, ret = 0;
 
-	spin_lock(&opened_lock);
-
-	list_for_each(ele, &opened) {
-		struct iss_net_private *lp;
-
-		lp = list_entry(ele, struct iss_net_private, opened_list);
-
-		if (!netif_running(lp->dev))
-			break;
+	if (!netif_running(lp->dev))
+		return 0;
 
-		spin_lock(&lp->lock);
+	spin_lock(&lp->lock);
 
-		while ((err = iss_net_rx(lp->dev)) > 0)
-			ret++;
+	while ((err = iss_net_rx(lp->dev)) > 0)
+		ret++;
 
-		spin_unlock(&lp->lock);
+	spin_unlock(&lp->lock);
 
-		if (err < 0) {
-			pr_err("Device '%s' read returned %d, shutting it down\n",
-			       lp->dev->name, err);
-			dev_close(lp->dev);
-		} else {
-			/* FIXME reactivate_fd(lp->fd, ISS_ETH_IRQ); */
-		}
+	if (err < 0) {
+		pr_err("Device '%s' read returned %d, shutting it down\n",
+		       lp->dev->name, err);
+		dev_close(lp->dev);
+	} else {
+		/* FIXME reactivate_fd(lp->fd, ISS_ETH_IRQ); */
 	}
 
-	spin_unlock(&opened_lock);
 	return ret;
 }
 
@@ -351,7 +337,7 @@ static void iss_net_timer(struct timer_list *t)
 {
 	struct iss_net_private *lp = from_timer(lp, t, timer);
 
-	iss_net_poll();
+	iss_net_poll(lp);
 	spin_lock(&lp->lock);
 	mod_timer(&lp->timer, jiffies + lp->timer_val);
 	spin_unlock(&lp->lock);
@@ -378,12 +364,6 @@ static int iss_net_open(struct net_device *dev)
 	while ((err = iss_net_rx(dev)) > 0)
 		;
 
-	spin_unlock_bh(&lp->lock);
-	spin_lock_bh(&opened_lock);
-	list_add(&lp->opened_list, &opened);
-	spin_unlock_bh(&opened_lock);
-	spin_lock_bh(&lp->lock);
-
 	timer_setup(&lp->timer, iss_net_timer, 0);
 	lp->timer_val = ISS_NET_TIMER_VALUE;
 	mod_timer(&lp->timer, jiffies + lp->timer_val);
@@ -399,10 +379,6 @@ static int iss_net_close(struct net_device *dev)
 	netif_stop_queue(dev);
 	spin_lock_bh(&lp->lock);
 
-	spin_lock(&opened_lock);
-	list_del(&opened);
-	spin_unlock(&opened_lock);
-
 	del_timer_sync(&lp->timer);
 
 	lp->tp.close(lp);
@@ -520,7 +496,6 @@ static int iss_net_configure(int index, char *init)
 	lp = netdev_priv(dev);
 	*lp = (struct iss_net_private) {
 		.device_list		= LIST_HEAD_INIT(lp->device_list),
-		.opened_list		= LIST_HEAD_INIT(lp->opened_list),
 		.dev			= dev,
 		.index			= index,
 	};
-- 
2.30.2

