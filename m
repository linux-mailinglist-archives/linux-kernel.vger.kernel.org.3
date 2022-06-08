Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6925439E4
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 19:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241239AbiFHQ7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234542AbiFHQz3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:55:29 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A8F232BF4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:51:43 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id y19so42627538ejq.6
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bwNtXSOCw0XDwGW95Gh6yPmxJxefcbSMC7JInqj3ttk=;
        b=Rxct20WgTboHnwH6PqKtW7++pYKV4s6f8/GuPXFckXJWce5FIdhfIQjxWy+stF5YKO
         Z0lSYKKnLg4ig8ICRK5K7peNL8aWc5ImcFuv4Gjqo7Iv9OG5FXoD7Oi4HhTY6l2eab/k
         L/YnwAZQTcZMu6AHxHXzQqODUsZ8QOjIewHYo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bwNtXSOCw0XDwGW95Gh6yPmxJxefcbSMC7JInqj3ttk=;
        b=ybY0AB4l1dqR8xh/Dt0U+QwMrhK5kdz65s8FGDso9bmRbcnkoIe3cD4IJPXUS1v5cK
         f5VKNCzTXeh3rMnU+wSGczubVy2FfbjrBSNPW2KAdg3ND6voP1Sn2NYeDh4bHiCmSUK5
         FSKRsOVA9nZp6v8wAjA5puisDyZvK/PLsZyQLdX17+2w2QJzHJ9lln19d3ezaeqCWjrn
         HKxQEkCpmfJxrqLtpNcZJBe6nkvmN/22VRfPhbD7bFuiDEwY08PxwWRr8lOkFJSSJqog
         oxpNwlrT6sbXHhc/1UyWLT18awg0rIULiAMmmZDM4j7WVT/FYHQEqZEr6zn4Sol266ic
         45XA==
X-Gm-Message-State: AOAM530QC+8mHMRO7kxWD+btvMx7HmYLN2u5penWym62JyFNt7SWkQq3
        bfv8xUR+WDK1qHG1SePj2zG16dba2mkX3w==
X-Google-Smtp-Source: ABdhPJyT8syNmYvc4wjS5820GR82CNi66QN6ll0aO6zF7OVFq0JN2AvnN9uxOFrQ28Ic89FJ0rsAGA==
X-Received: by 2002:a17:907:90c4:b0:710:456a:6981 with SMTP id gk4-20020a17090790c400b00710456a6981mr23907500ejb.484.1654707102377;
        Wed, 08 Jun 2022 09:51:42 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id c22-20020a17090654d600b0070587f81bcfsm9569071ejp.19.2022.06.08.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 09:51:41 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     Amarula patchwork <linux-amarula@amarulasolutions.com>,
        michael@amarulasolutions.com,
        Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH v2 13/13] can: slcan: extend the protocol with CAN state info
Date:   Wed,  8 Jun 2022 18:51:16 +0200
Message-Id: <20220608165116.1575390-14-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
References: <20220608165116.1575390-1-dario.binacchi@amarulasolutions.com>
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

It extends the protocol to receive the adapter CAN state changes
(warning, busoff, etc.) and forward them to the netdev upper levels.

Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

---

Changes in v2:
- Continue error handling even if no skb can be allocated.

 drivers/net/can/slcan/slcan-core.c | 66 ++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index aba42e284274..22a261f2477c 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -78,6 +78,9 @@ MODULE_PARM_DESC(maxdev, "Maximum number of slcan interfaces");
 #define SLC_CMD_LEN 1
 #define SLC_SFF_ID_LEN 3
 #define SLC_EFF_ID_LEN 8
+#define SLC_STATE_LEN 1
+#define SLC_STATE_BE_RXCNT_LEN 3
+#define SLC_STATE_BE_TXCNT_LEN 3
 
 struct slcan {
 	struct can_priv         can;
@@ -170,6 +173,67 @@ int slcan_enable_err_rst_on_open(struct net_device *ndev, bool on)
   *			STANDARD SLCAN DECAPSULATION			 *
   ************************************************************************/
 
+static void slc_bump_state(struct slcan *sl)
+{
+	struct net_device *dev = sl->dev;
+	struct sk_buff *skb;
+	struct can_frame *cf;
+	char *cmd = sl->rbuff;
+	u32 rxerr, txerr;
+	enum can_state state, rx_state, tx_state;
+
+	if (*cmd != 's')
+		return;
+
+	cmd += SLC_CMD_LEN;
+	switch (*cmd) {
+	case 'a':
+		state = CAN_STATE_ERROR_ACTIVE;
+		break;
+	case 'w':
+		state = CAN_STATE_ERROR_WARNING;
+		break;
+	case 'p':
+		state = CAN_STATE_ERROR_PASSIVE;
+		break;
+	case 'f':
+		state = CAN_STATE_BUS_OFF;
+		break;
+	default:
+		return;
+	}
+
+	if (state == sl->can.state)
+		return;
+
+	cmd += SLC_STATE_BE_RXCNT_LEN + 1;
+	cmd[SLC_STATE_BE_TXCNT_LEN] = 0;
+	if (kstrtou32(cmd, 10, &txerr))
+		return;
+
+	*cmd = 0;
+	cmd -= SLC_STATE_BE_RXCNT_LEN;
+	if (kstrtou32(cmd, 10, &rxerr))
+		return;
+
+	skb = alloc_can_err_skb(dev, &cf);
+
+	if (skb) {
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+	}
+
+	tx_state = txerr >= rxerr ? state : 0;
+	rx_state = txerr <= rxerr ? state : 0;
+	can_change_state(dev, skb ? cf : NULL, tx_state, rx_state);
+
+	if (state == CAN_STATE_BUS_OFF)
+		can_bus_off(dev);
+
+	if (skb)
+		netif_rx(skb);
+}
+
 static void slc_bump_err(struct slcan *sl)
 {
 	struct net_device *dev = sl->dev;
@@ -372,6 +436,8 @@ static void slc_bump(struct slcan *sl)
 		return slc_bump_frame(sl);
 	case 'e':
 		return slc_bump_err(sl);
+	case 's':
+		return slc_bump_state(sl);
 	default:
 		return;
 	}
-- 
2.32.0

