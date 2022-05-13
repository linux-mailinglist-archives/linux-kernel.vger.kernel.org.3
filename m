Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EFD8526640
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382226AbiEMPgs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:36:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382225AbiEMPgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:36:31 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE941101C4;
        Fri, 13 May 2022 08:36:30 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id l11so7813401pgt.13;
        Fri, 13 May 2022 08:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3SdSDF7ewAPst9Zo7lkKDOBWvOM46kArH1FoqTvHna8=;
        b=TVp08MhCiNH0J+l+jaKpwd6/jEhJwrKLGROYxtsWMbZtxKkoazCgcygWI6LQCYJolJ
         MAZrTo+W8GtQ3TyTDG6JrAB+JaSpBmLtNxfuQ8kNlqWUuscAKZ89Na7gxlMNG9nHJJ8d
         aPMXuLpWESRR3NWDfWZHv0eEO6nSo9bQJHzgADVVyX6nBaLbOSK83bileRGefnX0baqD
         aDqIb7lPh79moQXIiaNSJzPqPVBQ8dgImJ+4p81EFoGWVP9frz0eMBTYmP7WhrC2vrIU
         EwY8bSI/U6o+3gYIhlMOWpPRyAl0dMUi2AzDPeRYqIySs/18Jdy3X4Gexw7+BpNRTDXG
         QqwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=3SdSDF7ewAPst9Zo7lkKDOBWvOM46kArH1FoqTvHna8=;
        b=AtUqOfWkKmSIKPBTe7yzIpL27GJnoaUgpLDjXg70qx9nJTITzcMs5qK1XQaGbfBSkn
         8KqyAam1Zszmxv2qrTX8FGXRx8ND/B1jVjCa8Sgt9IH5yDk4B/J8QusxcEviQVgB6tJs
         uyMaji4B9fmfqp7yCaGJSKI4k+UuidScjvBv5hchgOGjSVWNkSSN/WG7K2OcqFmOCI8r
         jFrxRigyNZaCsSv1dVdsxV2a7IbLlkwZnKnpF53Zrmyb+tAcslmwuaN6OvivfVExT1Lz
         Sj6ACx2ANOTIPSS/RwMyhyfpB+YxNtGJWQH18gSN8ZRGashuUys5Au3HnF2IgwGftSuE
         r1CQ==
X-Gm-Message-State: AOAM53082O1Z1iKT0sdiTO0q31qzwBq1FGMcZjSp0h/9t9cqFiiGRbBC
        BtcnHKNnEZEG4ejsZ3Q+pIk=
X-Google-Smtp-Source: ABdhPJyX8EwQoDJOQU9hERyg4fabjGQxCtwU2PZgUAgTQc7WqFpw0HyjMYWUO1X/kp/36BfSY6KelQ==
X-Received: by 2002:a62:6410:0:b0:4f3:9654:266d with SMTP id y16-20020a626410000000b004f39654266dmr4980430pfb.59.1652456190365;
        Fri, 13 May 2022 08:36:30 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id b10-20020a62a10a000000b0050dc762817dsm1942137pff.87.2022.05.13.08.36.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:36:30 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 2/2] can: dev: drop tx skb if in listen only mode
Date:   Sat, 14 May 2022 00:36:06 +0900
Message-Id: <20220513153606.302464-3-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513153606.302464-1-mailhol.vincent@wanadoo.fr>
References: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
 <20220513153606.302464-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Frames can be directly injected to a can driver via the packet
socket. By doing that, it is possible to reach the
net_device_ops::ndo_start_xmit function even if the driver is
configure in listen only mode.

Add a check in can_dropped_invalid_skb() and to discard the skb if
CAN_CTRLMODE_LISTENONLY is set.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/skb.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 8b1991130de5..f7420fc43b99 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -5,6 +5,7 @@
  */
 
 #include <linux/can/dev.h>
+#include <linux/can/netlink.h>
 
 /* Local echo of CAN messages
  *
@@ -286,6 +287,7 @@ static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
 bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 {
 	const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+	struct can_priv *priv = netdev_priv(dev);
 
 	if (skb->protocol == htons(ETH_P_CAN)) {
 		if (unlikely(skb->len != CAN_MTU ||
@@ -299,8 +301,13 @@ bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
 		goto inval_skb;
 	}
 
-	if (!can_skb_headroom_valid(dev, skb))
+	if (!can_skb_headroom_valid(dev, skb)) {
+		goto inval_skb;
+	} else if (priv->ctrlmode & CAN_CTRLMODE_LISTENONLY) {
+		netdev_info_once(dev,
+				 "interface in listen only mode, dropping skb\n");
 		goto inval_skb;
+	}
 
 	return false;
 
-- 
2.35.1

