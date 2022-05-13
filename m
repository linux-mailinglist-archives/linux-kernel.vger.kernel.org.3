Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 440525263E4
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353017AbiEMOZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359467AbiEMOYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:24:48 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE1AD527D1;
        Fri, 13 May 2022 07:24:45 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id c11so8064090plg.13;
        Fri, 13 May 2022 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EXVXiPbk+krY68vv3JVFR+K7ANBpW2/j7bjI9Co2KDw=;
        b=Lily5PBWVzsRsoKTheNp++BxMUwyzfse43IwxdM4KdKiwxr22BTE2kx3Ow2wxjOf+C
         lH4YXnDCqazomi/ap9qEmHZRTELee86xvEOnQBuPbC8Az508qFAxZGEmkWFu97uiTAZD
         Q6lTJx4RBjBKMO9cRXZBmzzUdoywVD62Du3xLaMjBYbgESWo9VJZ1XX4GG6o1WF0IzLM
         6hwHVRGorDIVDB8N7Nn/c5KQO8pCIHWtYUabYbddkqX0UtY+Sl8ux8FjnuGi5vh3CnFU
         My8cQRNntwUUEpSChBTx6GdqGKcYGwkc3mlOfz2lTrdHx+nCauRiSDnRfL3gYSbgX7YK
         11cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=EXVXiPbk+krY68vv3JVFR+K7ANBpW2/j7bjI9Co2KDw=;
        b=cRoqmhZNvnKkFlkfiEyeBjVxTQ9nZKLrnRU5N+sYwh46qw9nbVr8B0C5Hs6zc9kecQ
         3zkjAJCQYT2T0PTroKODoudpv6R+fMBGPWeeAZm6qn9td4xNvgp2fGAtbAu1TcN+l9ht
         cE9/Nc/+ApTgLvSeDg4cuOrV5KfpNFmFfOCBpVOZKnndcLNg7e1qyYg7SlgKakKmvFPs
         dhq5noQ9WkT5X/+JfNYSybEO6wuHHZv+whkRcKTuSgmfEvzdrwfFyXPLy8qy3XQpaG9Y
         z68YhfptSMaMQIfKlSb+u2qGAGyvOEwvcq55Bi9xfYl29MeydBcA4sEcqNyYecW3jxZ5
         OBEg==
X-Gm-Message-State: AOAM531M0v7egKx92aRkBv9BGtP96QWnkZXC3LTFJ7IJQ4lNs3THYS75
        dBQWiJM5ERPgfjJGdoMEOj0=
X-Google-Smtp-Source: ABdhPJwP14hRxwH8tjUgqDpmuXMdXTYtmj77UCtxNmry5UzcQ8PKGLOciYn4wKhQnTKfIIfZgjlOZA==
X-Received: by 2002:a17:902:f542:b0:15e:b6d2:88d9 with SMTP id h2-20020a170902f54200b0015eb6d288d9mr4934948plf.128.1652451884713;
        Fri, 13 May 2022 07:24:44 -0700 (PDT)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id jj10-20020a170903048a00b0015e8d4eb2ccsm1684488plb.278.2022.05.13.07.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 May 2022 07:24:44 -0700 (PDT)
Sender: Vincent Mailhol <vincent.mailhol@gmail.com>
From:   Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To:     Marc Kleine-Budde <mkl@pengutronix.de>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH 2/2] can: dev: drop tx skb if in listen only mode
Date:   Fri, 13 May 2022 23:23:55 +0900
Message-Id: <20220513142355.250389-3-mailhol.vincent@wanadoo.fr>
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

Frames can be directly injected to a can driver via the packet
socket. By doing that, it is possible to reach the
net_device_ops::ndo_start_xmit function even if the driver is
configure in listen only mode.

Add a check in can_dropped_invalid_skb() and to discard the skb if
CAN_CTRLMODE_LISTENONLY is set.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/linux/can/dev.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index bbe27e22c7a7..c3ed48e54c29 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -161,6 +161,7 @@ static inline bool can_dropped_invalid_skb(struct net_device *dev,
 					   struct sk_buff *skb)
 {
 	const struct canfd_frame *cfd = (struct canfd_frame *)skb->data;
+	struct can_priv *priv = netdev_priv(dev);
 
 	if (skb->protocol == htons(ETH_P_CAN)) {
 		if (unlikely(skb->len != CAN_MTU ||
@@ -174,8 +175,13 @@ static inline bool can_dropped_invalid_skb(struct net_device *dev,
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

