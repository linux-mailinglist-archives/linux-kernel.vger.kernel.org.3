Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7490547C8B
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 23:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236613AbiFLVjx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 17:39:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236546AbiFLVjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 17:39:49 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C09E51AD88
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 14:39:47 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id c2so4907379edf.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 14:39:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=El3W9x0OB1VE70B0Lt3SBVyO+pC/HDeoL5aPqYtLRdg=;
        b=FIZh5UTrlRbIHsCTBAPteoUF41feurhGY1j95FK7rMWDVMIlldVYABzLSWhURo+iRZ
         5X9PK4jys25T9M8PvpocVL0htqhFvlb7Qq9ALIEgghXvfpHLwq5JYOr4QhvJvqBzX2ZX
         9W1i0yEhMFUD5RYthu+fwLfuXuQLB3xqBVoBE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=El3W9x0OB1VE70B0Lt3SBVyO+pC/HDeoL5aPqYtLRdg=;
        b=408G3CDXnsgIeR79Go9XRoEzpepmwP9+cOJ6iUfznXWrJkbIjYCIt//jf+ACQcOL2z
         siU47fhv6U2NvQyxjV4C1E7gbDUgMFJV9alEKnybP2UdNez0M+Vvbs1nOhEIpRSls6YX
         nyMcQ0YLRXWHWSmdZeEfpfS12RlQeurPftGq1uIqKhPCyfN1hHayIlfSTwjsK6ORSv7V
         cb9zBF1drGwPETrJAxQgbJzePrzIm4eWzWamvFf1Y9grrnov8+rF03bWLoOtFYtAfqGT
         DL+ZSSGZCXbE7lk4p4K41TlRR1m3Yl2MzgXVqkABYK9f0XiHp9LkTsW6lwSfw+R97NsZ
         Jw1w==
X-Gm-Message-State: AOAM531GCeUdyoQgJZdbHHEf8gDj0TMeGt4hQTgRHDYm7PVFd/hotCRr
        WZCq40Jb4ETN7oCKOuL8bNSK2VNjqNQtmg==
X-Google-Smtp-Source: ABdhPJww3i7CVaj0ctxJLxdZv/2+Ex6h2WRxPQWXOiFgSNJiw7emFfgKJIduJPbDUDTWtLrMOo3Zpw==
X-Received: by 2002:aa7:c306:0:b0:42d:d4cc:c606 with SMTP id l6-20020aa7c306000000b0042dd4ccc606mr62413182edq.341.1655069986039;
        Sun, 12 Jun 2022 14:39:46 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id u10-20020a1709061daa00b00711d546f8a8sm2909398ejh.139.2022.06.12.14.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jun 2022 14:39:45 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v3 02/13] can: slcan: use netdev helpers to print out messages
Date:   Sun, 12 Jun 2022 23:39:16 +0200
Message-Id: <20220612213927.3004444-3-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
References: <20220612213927.3004444-1-dario.binacchi@amarulasolutions.com>
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

