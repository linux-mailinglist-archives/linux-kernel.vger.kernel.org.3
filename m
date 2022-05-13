Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E20652663F
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 17:36:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382171AbiEMPgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 11:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382219AbiEMPg2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 11:36:28 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5184F2DC6;
        Fri, 13 May 2022 08:36:27 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d22so8284913plr.9;
        Fri, 13 May 2022 08:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=I7l1Xm9qehIrYZIkT6lmz4zbqDX5vJCIeT/thGsyl/E=;
        b=VRWAuALO2Af7o/62+j66JdKdxL0rMt2KMj/NaWp9Si4SMu++SSGKzBG6uOls+/wRn1
         JZGr8eVqcmg1+ljceUfzl5iIP7Q/7kuOahMYEkyJ/bWL6Fl3W8Uq4wcgxWvNcjmkKlr1
         o3NaZGaOjYBJsrOORMuHHyxKFGc/1wMak/oQTnE8BppGXSO4oknfp42KdB+ZaQnIFTU3
         h94hPlAC5pv/AF0rSwQ2lb6kDlznKYmeslyr1h6ciLcQKCF33GEUz2n2g32P1ooJPLaU
         CoQjiM3r1Zfa7pN4eKe21DpcQDJWM1+/nnWKOiqnmhgrR+8nHofh/LaRP+JtqarmQOhL
         Mg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=I7l1Xm9qehIrYZIkT6lmz4zbqDX5vJCIeT/thGsyl/E=;
        b=a5UguZMxtKkDYWtEibbdpUm802ZvHiZVcp6GqI5FH2m49rKlXWTpipsPYmVYa++SMj
         Tl0SqnO0PN+1c39WuX434ZGS+CBG5noDYwTogDXPCIbguSJXRcu/zvTWNQst+TIjQ2dz
         N7nzxeq7BtKcj8gy8TLpCdvJZNA/FMtzf2mTTXjQun1I+WHky+F0ZSJzPjS5Is9xuizs
         BsotAEWglqSC1x1H1DRrdCWYF3ZF+lbUV6+dKEJbAVnqLcifjeQp4uN/DBDsk8tKGgYb
         dp5E611sS3qHSuvHkp6C1oGEvbZwDyhFRdy9stmoyHr6rEof67pIhKGw8WomPomI+r4q
         maMA==
X-Gm-Message-State: AOAM533gg6Q1RIfApGfDZhNS0AwsLANlUOHGGUo2a07DqtP7DmWSRwte
        iNd8y+gboBdjl+XzfBs1BGIqz8HexyVt7int
X-Google-Smtp-Source: ABdhPJxgmirE5WiHq4PtXYEBZb9gW1HP4FSI3hKRiYplfUiVttocN/cB6TB1YADyvfFONKAVP4+YvA==
X-Received: by 2002:a17:902:cec9:b0:15e:cbf4:c246 with SMTP id d9-20020a170902cec900b0015ecbf4c246mr5132972plg.1.1652456186689;
        Fri, 13 May 2022 08:36:26 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id b10-20020a62a10a000000b0050dc762817dsm1942137pff.87.2022.05.13.08.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 08:36:26 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v2 1/2] can: skb:: move can_dropped_invalid_skb and can_skb_headroom_valid to skb.c
Date:   Sat, 14 May 2022 00:36:05 +0900
Message-Id: <20220513153606.302464-2-mailhol.vincent@wanadoo.fr>
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

The functions can_dropped_invalid_skb() and can_skb_headroom_valid()
grew a lot over the years to a point which it does make much sense to
have them defined as static inline in header files. Move those two
functions to the .c counterpart of skb.h.

can_skb_headroom_valid() only caller being can_dropped_invalid_skb(),
the declaration is removed from the header. Only
can_dropped_invalid_skb() gets its symbol exported.

While doing so, do a small cleanup: add brackets around the else block
in can_dropped_invalid_skb().

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/skb.c | 58 ++++++++++++++++++++++++++++++++++++++
 include/linux/can/skb.h   | 59 +--------------------------------------
 2 files changed, 59 insertions(+), 58 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index 61660248c69e..8b1991130de5 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -252,3 +252,61 @@ struct sk_buff *alloc_can_err_skb(struct net_device *dev, struct can_frame **cf)
 	return skb;
 }
 EXPORT_SYMBOL_GPL(alloc_can_err_skb);
+
+/* Check for outgoing skbs that have not been created by the CAN subsystem */
+static bool can_skb_headroom_valid(struct net_device *dev, struct sk_buff *skb)
+{
+	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
+	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
+		return false;
+
+	/* af_packet does not apply CAN skb specific settings */
+	if (skb->ip_summed == CHECKSUM_NONE) {
+		/* init headroom */
+		can_skb_prv(skb)->ifindex = dev->ifindex;
+		can_skb_prv(skb)->skbcnt = 0;
+
+		skb->ip_summed = CHECKSUM_UNNECESSARY;
+
+		/* perform proper loopback on capable devices */
+		if (dev->flags & IFF_ECHO)
+			skb->pkt_type = PACKET_LOOPBACK;
+		else
+			skb->pkt_type = PACKET_HOST;
+
+		skb_reset_mac_header(skb);
+		skb_reset_network_header(skb);
+		skb_reset_transport_header(skb);
+	}
+
+	return true;
+}
+
+/* Drop a given socketbuffer if it does not contain a valid CAN frame. */
+bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb)
+{
+	const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+
+	if (skb->protocol == htons(ETH_P_CAN)) {
+		if (unlikely(skb->len != CAN_MTU ||
+			     cfd->len > CAN_MAX_DLEN))
+			goto inval_skb;
+	} else if (skb->protocol == htons(ETH_P_CANFD)) {
+		if (unlikely(skb->len != CANFD_MTU ||
+			     cfd->len > CANFD_MAX_DLEN))
+			goto inval_skb;
+	} else {
+		goto inval_skb;
+	}
+
+	if (!can_skb_headroom_valid(dev, skb))
+		goto inval_skb;
+
+	return false;
+
+inval_skb:
+	kfree_skb(skb);
+	dev->stats.tx_dropped++;
+	return true;
+}
+EXPORT_SYMBOL_GPL(can_dropped_invalid_skb);
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index fdb22b00674a..182749e858b3 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -31,6 +31,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 				struct canfd_frame **cfd);
 struct sk_buff *alloc_can_err_skb(struct net_device *dev,
 				  struct can_frame **cf);
+bool can_dropped_invalid_skb(struct net_device *dev, struct sk_buff *skb);
 
 /*
  * The struct can_skb_priv is used to transport additional information along
@@ -96,64 +97,6 @@ static inline struct sk_buff *can_create_echo_skb(struct sk_buff *skb)
 	return nskb;
 }
 
-/* Check for outgoing skbs that have not been created by the CAN subsystem */
-static inline bool can_skb_headroom_valid(struct net_device *dev,
-					  struct sk_buff *skb)
-{
-	/* af_packet creates a headroom of HH_DATA_MOD bytes which is fine */
-	if (WARN_ON_ONCE(skb_headroom(skb) < sizeof(struct can_skb_priv)))
-		return false;
-
-	/* af_packet does not apply CAN skb specific settings */
-	if (skb->ip_summed == CHECKSUM_NONE) {
-		/* init headroom */
-		can_skb_prv(skb)->ifindex = dev->ifindex;
-		can_skb_prv(skb)->skbcnt = 0;
-
-		skb->ip_summed = CHECKSUM_UNNECESSARY;
-
-		/* perform proper loopback on capable devices */
-		if (dev->flags & IFF_ECHO)
-			skb->pkt_type = PACKET_LOOPBACK;
-		else
-			skb->pkt_type = PACKET_HOST;
-
-		skb_reset_mac_header(skb);
-		skb_reset_network_header(skb);
-		skb_reset_transport_header(skb);
-	}
-
-	return true;
-}
-
-/* Drop a given socketbuffer if it does not contain a valid CAN frame. */
-static inline bool can_dropped_invalid_skb(struct net_device *dev,
-					  struct sk_buff *skb)
-{
-	const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
-
-	if (skb->protocol == htons(ETH_P_CAN)) {
-		if (unlikely(skb->len != CAN_MTU ||
-			     cfd->len > CAN_MAX_DLEN))
-			goto inval_skb;
-	} else if (skb->protocol == htons(ETH_P_CANFD)) {
-		if (unlikely(skb->len != CANFD_MTU ||
-			     cfd->len > CANFD_MAX_DLEN))
-			goto inval_skb;
-	} else
-		goto inval_skb;
-
-	if (!can_skb_headroom_valid(dev, skb))
-		goto inval_skb;
-
-	return false;
-
-inval_skb:
-	kfree_skb(skb);
-	dev->stats.tx_dropped++;
-	return true;
-}
-
 static inline bool can_is_canfd_skb(const struct sk_buff *skb)
 {
 	/* the CAN specific type of skb is identified by its data length */
-- 
2.35.1

