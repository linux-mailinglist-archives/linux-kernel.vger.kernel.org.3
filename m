Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D41569C93
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 10:08:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235255AbiGGIIO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 04:08:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235225AbiGGIIF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 04:08:05 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A87C533E1D
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 01:08:04 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id q82so9936246pgq.6
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 01:08:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j6z46hiTjAFvo7B2XUi7zY5HtGJndA6IMLx4jpxUBEs=;
        b=bvUt6Y9q5nJpoMf/TkNjPflp+QVRATuQJM+2Uz7UJqp5EPiPO9hm1iPptdnP29Trgf
         GF8WQsnxlTuUGqBNzyeIrVmI5q9W6vwey6WxSeyrkaqn60+So2cU+4e08ECU+TrKbmXB
         5USm+ODMNCXqVHy+ehQtT/1Qpj942xdwA2svdpclRz1B3embRd28Tk6pE/rlKQMOEtx5
         jLNtHAz91agwo3TMpRDlobNcVwJm0b5wPOIQ/11YylkiN8qgEbpBHnwsH0MziF35SVc4
         WS8fvK93/1WmrbX0ZJPqzX3hKzOKncxEvYWolJjp1eRxtfzR/tZMeBw8nZd4Oj82TPtw
         XBCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j6z46hiTjAFvo7B2XUi7zY5HtGJndA6IMLx4jpxUBEs=;
        b=sfF5dW9VlHC524GeB7dt8PccCR0iyOClGdmbZb+dxzkWpjKnklz9PvW2sh/fb94cDv
         YKWgld618K6LeS0VQyNlCyAK4bpEyw1+lXN5anlY6sa3hRe7qKoCfZW4SCgLXRR2mXP4
         A+SZN9EjTOtcbKPTy8bj+iI9Ui8zOfJTqIAv6ZdHQHWk6aY81HPaPqzZoE7ZLda2U9xC
         z6XKaiZfrBR72jLZWvSGdPyoF0Cg9ZL3R7M2v5vRxZvDo5KvaNjwaFIycVbfLThlwR6y
         AtdjoKi1nSTPhSmSd+Q71ZGPRaP580dRsGZQRl39zwjBlPlpQAdArMtjtKqBgrike7bG
         u5MA==
X-Gm-Message-State: AJIora9Zzqeeak/1yu3AMj42JOGDrx0BuyKKFrjMK28aoC3vKLDbq9tg
        ZqjZyCXCn/3w0SLAe2vTaZU=
X-Google-Smtp-Source: AGRyM1u1nGKb6bqFtCjv2ok/Qdvnbqj9zUNGHWmEkUcEuoWp5InGOSIlHmtxCpK9b9bLC2iYubbJJw==
X-Received: by 2002:a63:4343:0:b0:411:e30c:fad8 with SMTP id q64-20020a634343000000b00411e30cfad8mr28570543pga.278.1657181284242;
        Thu, 07 Jul 2022 01:08:04 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:a3e3:ea8c:2267:a237])
        by smtp.gmail.com with ESMTPSA id p4-20020a170902e74400b0016c0c82e85csm1377374plf.75.2022.07.07.01.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 01:08:03 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Yang Yingliang <yangyingliang@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH v3 3/3] xtensa: iss: fix handling error cases in iss_net_configure()
Date:   Thu,  7 Jul 2022 01:08:01 -0700
Message-Id: <20220707080801.3496148-4-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220707080801.3496148-1-jcmvbkbc@gmail.com>
References: <20220707080801.3496148-1-jcmvbkbc@gmail.com>
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

From: Yang Yingliang <yangyingliang@huawei.com>

The 'pdev' and 'netdev' need to be released in error cases of
iss_net_configure().

Change the return type of iss_net_configure() to void, because it's
not used.

Fixes: 7282bee78798 ("[PATCH] xtensa: Architecture support for Tensilica Xtensa Part 8")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v2->v3:
- drop err_unregister_device label and return after calling
  platform_device_unregister in case of register_netdevice failure

Changes v1->v2:
- change return type of iss_net_configure() to void

 arch/xtensa/platforms/iss/network.c | 32 ++++++++++++++---------------
 1 file changed, 15 insertions(+), 17 deletions(-)

diff --git a/arch/xtensa/platforms/iss/network.c b/arch/xtensa/platforms/iss/network.c
index 2a22e80a488d..9ac46ab3a296 100644
--- a/arch/xtensa/platforms/iss/network.c
+++ b/arch/xtensa/platforms/iss/network.c
@@ -475,16 +475,15 @@ static void iss_net_pdev_release(struct device *dev)
 	free_netdev(lp->dev);
 }
 
-static int iss_net_configure(int index, char *init)
+static void iss_net_configure(int index, char *init)
 {
 	struct net_device *dev;
 	struct iss_net_private *lp;
-	int err;
 
 	dev = alloc_etherdev(sizeof(*lp));
 	if (dev == NULL) {
 		pr_err("eth_configure: failed to allocate device\n");
-		return 1;
+		return;
 	}
 
 	/* Initialize private element. */
@@ -511,7 +510,7 @@ static int iss_net_configure(int index, char *init)
 	if (!tuntap_probe(lp, index, init)) {
 		pr_err("%s: invalid arguments. Skipping device!\n",
 		       dev->name);
-		goto errout;
+		goto err_free_netdev;
 	}
 
 	pr_info("Netdevice %d (%pM)\n", index, dev->dev_addr);
@@ -519,14 +518,16 @@ static int iss_net_configure(int index, char *init)
 	/* sysfs register */
 
 	if (!driver_registered) {
-		platform_driver_register(&iss_net_driver);
+		if (platform_driver_register(&iss_net_driver))
+			goto err_free_netdev;
 		driver_registered = 1;
 	}
 
 	lp->pdev.id = index;
 	lp->pdev.name = DRIVER_NAME;
 	lp->pdev.dev.release = iss_net_pdev_release;
-	platform_device_register(&lp->pdev);
+	if (platform_device_register(&lp->pdev))
+		goto err_free_netdev;
 	SET_NETDEV_DEV(dev, &lp->pdev.dev);
 
 	dev->netdev_ops = &iss_netdev_ops;
@@ -535,23 +536,20 @@ static int iss_net_configure(int index, char *init)
 	dev->irq = -1;
 
 	rtnl_lock();
-	err = register_netdevice(dev);
-	rtnl_unlock();
-
-	if (err) {
+	if (register_netdevice(dev)) {
+		rtnl_unlock();
 		pr_err("%s: error registering net device!\n", dev->name);
-		/* XXX: should we call ->remove() here? */
-		free_netdev(dev);
-		return 1;
+		platform_device_unregister(&lp->pdev);
+		return;
 	}
+	rtnl_unlock();
 
 	timer_setup(&lp->tl, iss_net_user_timer_expire, 0);
 
-	return 0;
+	return;
 
-errout:
-	/* FIXME: unregister; free, etc.. */
-	return -EIO;
+err_free_netdev:
+	free_netdev(dev);
 }
 
 /* ------------------------------------------------------------------------- */
-- 
2.30.2

