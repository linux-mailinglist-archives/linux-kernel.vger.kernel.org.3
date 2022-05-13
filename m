Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 974335263D7
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357293AbiEMOYe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:24:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355954AbiEMOY0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:24:26 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF37850E09;
        Fri, 13 May 2022 07:24:25 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso7973428pjg.0;
        Fri, 13 May 2022 07:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mTM/kX6SVqsh/584K0OxOVMxJNbBbJojAc06+3q+noc=;
        b=THHZJjXytAJZclhK0bpp/StN56jpSkHFqNU6fPOgzPAjO/HrVdWtKojjDJYmdwTpqH
         JedTnC6qF6skZiX1SQBOsq9DcZs0dbUd6u0gAOMGVVTOAdG7o8qKOR6oUjko+P+nX1Bt
         b7aRDLYP93M4BlUq85TAI4QzsYw01Ediw8szmlSpX/hBmbceGozMkjSUPdmTWaclXWxv
         yPQuHRleIJU/1MoYGRMfJ00al1+QilC2ZQyR0ZSyzY70fjJ6GAWSZB5t3Xkg4oOWiu/O
         nIDz8Sfbh5ur/W6wcoyntdbbw3BCMIvuvqagkxKvUGVGGWzqI9SREy2yLm4tn7TurkTc
         MYbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=mTM/kX6SVqsh/584K0OxOVMxJNbBbJojAc06+3q+noc=;
        b=iC4CFiGGCJcC5BGi9GRMbMbrR1j+e5w16qzMtIprdqe5+eJ554L0JE3GsSX2Kq2x7E
         iWeYm+4dYmlVnc9Pm7RygEq6cRN9Z6U1vNxSaqJ1223PRGuBoFOjjBMnRPDqxaC/3yOw
         C5rJF2cTiOopNrKZdWZco4ZwrLULkF8o7ALy8CaQrlzCFLDsyDmEbh/IxwM6nxf3e2nf
         85ghl+iS4f/vMLGzUA0hOH1u1otkvhqdtF8bsbMf+QI/V6duzlYmSfZ8YSmlmbs4k4Y3
         9XYo8Ac4LV7J9Rkd/owI0jqP7kXPXEo0qFMjWt6885RO66HcsOitOhlxInhTpxD5Si8T
         S6lw==
X-Gm-Message-State: AOAM531iQe3b6dAK9tZg8pnJgSDk8LGz/kA3rXmZ2iUpJrDGO4Pf9yV3
        AYu4Cj9p9jl9tRpYe9uAi5E=
X-Google-Smtp-Source: ABdhPJyX8XhNTJuqpdaLK2CBnxji9ZIZ3WOnDPmRsky4JKsie/lRiYbynXtG+lsWAfSfL6cs76jHHA==
X-Received: by 2002:a17:902:e811:b0:15e:b27b:92ef with SMTP id u17-20020a170902e81100b0015eb27b92efmr4988168plg.142.1652451865060;
        Fri, 13 May 2022 07:24:25 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170903048a00b0015e8d4eb2ccsm1684488plb.278.2022.05.13.07.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:24:24 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 1/2] can: move can_dropped_invalid_skb from skb.h to dev.h
Date:   Fri, 13 May 2022 23:23:54 +0900
Message-Id: <20220513142355.250389-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
References: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
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

This is a preparation patch for next change.

We want to introduce a check towards CAN_CTRLMODE_LISTENONLY in
can_dopped_invalid_skb(). To do so, we would need to include
linux/can/dev.h (for struct can_priv) and uapi/linux/can/netlink.h
(for the definition of CAN_CTRLMODE_LISTEONLY). Instead of adding
those header and contributing to the include hell, we prever to
relocate can_dropped_invalid_skb() to linux/can/dev.h where all the
needed headers are already present.

While doing so, do a small cleanup: re-indent the second line of the
function argument and add brackets around the else block.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/can/dev.h | 29 +++++++++++++++++++++++++++++
 include/linux/can/skb.h | 28 ----------------------------
 2 files changed, 29 insertions(+), 28 deletions(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index c2ea47f30046..bbe27e22c7a7 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -156,6 +156,35 @@ static inline u32 can_get_static_ctrlmode(struct can_priv *priv)
 	return priv->ctrlmode & ~priv->ctrlmode_supported;
 }
 
+/* Drop a given socketbuffer if it does not contain a valid CAN frame. */
+static inline bool can_dropped_invalid_skb(struct net_device *dev,
+					   struct sk_buff *skb)
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
+
 void can_setup(struct net_device *dev);
 
 struct net_device *alloc_candev_mqs(int sizeof_priv, unsigned int echo_skb_max,
diff --git a/include/linux/can/skb.h b/include/linux/can/skb.h
index fdb22b00674a..985791c84a8d 100644
--- a/include/linux/can/skb.h
+++ b/include/linux/can/skb.h
@@ -126,34 +126,6 @@ static inline bool can_skb_headroom_valid(struct net_device *dev,
 	return true;
 }
 
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

