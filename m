Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A812C53FA42
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 11:49:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240097AbiFGJtM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 05:49:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240019AbiFGJsT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 05:48:19 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D99B4757E
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 02:48:16 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id a10so6467618wmj.5
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 02:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ReHEa9nvpM4WWSAEnsEWGM+1xrVLxiybh/+LZPFyWR0=;
        b=fD6TXB5kPsita6JVXR2OYpo6aijOISVKpo6n5j2ZgQKgK3W26Yv38J11s9RL7FHni0
         1+T4yDmUbrdCdQ3DFZzV4h9LVFB+BQqyqlqvotlIv5LNBbeoMwfgxgcIpbEcpg0Ewt5k
         tK0NtJH1n2SmGBL5mxuLq34ZcTRoYcvngCCWU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ReHEa9nvpM4WWSAEnsEWGM+1xrVLxiybh/+LZPFyWR0=;
        b=zdTvnc42tR/HsKc4OZRRJp8W4CdgaU1cJBCgBDgvydSBgYczWkN1r2N6RgC27sXdwz
         3GxAiEjnPZj3n22v2GNy0GyModZNNg9nPgSR00MOixrXM2LAP5m+KeBwLZZmJ4ikY9+Y
         bDrbBNhif0YKK1uQnrXp05QwOu6NdK071731cgCqRwpHSx3V+5xXlwJZpsxKDZKp3JFS
         VjW9NJS42nPVspoeVivYgpGXmk/mlhUEP/VhKAY7D8kbFD96pU2NiOWSy0mRIo0cA3qU
         P82NZHDzyArLvqIVv/GswiF8qV3LuGyiYwmoPiyNWoPXBPBVi+Xqcy2Dri19WSDtEyYi
         Awew==
X-Gm-Message-State: AOAM530AvSsnkWeS8U6UXW6YeSlRAPCaSRiBTQjKnzWKUIZ5FZbN6El5
        jkjaZHIqB9Tasa9eYoxprWHoPBigQordvQ==
X-Google-Smtp-Source: ABdhPJz6EXjs5KfKFdF0bVzLEgjrUaXJX6O6LWDfWxKEhiJV4OHYmXxH0MYw0tLvnFyEu4CB8ac/lA==
X-Received: by 2002:a05:600c:1f0e:b0:397:707f:5a60 with SMTP id bd14-20020a05600c1f0e00b00397707f5a60mr27183939wmb.3.1654595295377;
        Tue, 07 Jun 2022 02:48:15 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.pdxnet.pdxeng.ch (mob-5-90-137-51.net.vodafone.it. [5.90.137.51])
        by smtp.gmail.com with ESMTPSA id o4-20020a05600c510400b0039748be12dbsm23200547wms.47.2022.06.07.02.48.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Jun 2022 02:48:14 -0700 (PDT)
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
Subject: [RFC PATCH 03/13] can: slcan: use the alloc_can_skb() helper
Date:   Tue,  7 Jun 2022 11:47:42 +0200
Message-Id: <20220607094752.1029295-4-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
References: <20220607094752.1029295-1-dario.binacchi@amarulasolutions.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It is used successfully by most (if not all) CAN device drivers. It
allows to remove replicated code.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
---

 drivers/net/can/slcan.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
index 6162a9c21672..964b02f321ab 100644
--- a/drivers/net/can/slcan.c
+++ b/drivers/net/can/slcan.c
@@ -54,6 +54,7 @@
 #include <linux/kernel.h>
 #include <linux/workqueue.h>
 #include <linux/can.h>
+#include <linux/can/dev.h>
 #include <linux/can/skb.h>
 #include <linux/can/can-ml.h>
 
@@ -143,7 +144,7 @@ static struct net_device **slcan_devs;
 static void slc_bump(struct slcan *sl)
 {
 	struct sk_buff *skb;
-	struct can_frame cf;
+	struct can_frame cf, *scf;
 	int i, tmp;
 	u32 tmpid;
 	char *cmd = sl->rbuff;
@@ -201,21 +202,11 @@ static void slc_bump(struct slcan *sl)
 		}
 	}
 
-	skb = dev_alloc_skb(sizeof(struct can_frame) +
-			    sizeof(struct can_skb_priv));
-	if (!skb)
+	skb = alloc_can_skb(sl->dev, &scf);
+	if (unlikely(!skb))
 		return;
 
-	skb->dev = sl->dev;
-	skb->protocol = htons(ETH_P_CAN);
-	skb->pkt_type = PACKET_BROADCAST;
-	skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-	can_skb_reserve(skb);
-	can_skb_prv(skb)->ifindex = sl->dev->ifindex;
-	can_skb_prv(skb)->skbcnt = 0;
-
-	skb_put_data(skb, &cf, sizeof(struct can_frame));
+	memcpy(scf, &cf, sizeof(*scf));
 
 	sl->dev->stats.rx_packets++;
 	if (!(cf.can_id & CAN_RTR_FLAG))
-- 
2.32.0

