Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0BFE55EA08
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 18:43:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240428AbiF1Qh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 12:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237868AbiF1QfA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 12:35:00 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5946BC19
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:32:07 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id g26so26899393ejb.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 09:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CuGBayQTKpzveprbko8jS+HWnVHJqO4mYljV1kMBj3A=;
        b=MtMhCSr/fei8ro6GAgFIQN2QNwArvDPswgWVA92bCcINrM3QNrv44Ufz8bcR70Hin9
         d2E1yfK//6FaPHzSk22x2w3jobVMv2wtKrVGn9OdNqZB7u+60qS6jfZ1dys6YiZ5AtBI
         lBRrfoVADTV1DCY2tdEqS/CwfhNpHWI8tMDXg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CuGBayQTKpzveprbko8jS+HWnVHJqO4mYljV1kMBj3A=;
        b=Iqav+WvYDkB3g2zFiyKsQPlFSj7T2ezNlgfM+MoM8fR7gK/a60XgGfhvGQ5J1B2sFf
         5vqrjp2Z25CkKrNYJTny+wpxXxHVq5qqcgKA+GOYijJuq1AId6g/2BVyuqloeRHuxka3
         LBvbo+pPPpNfjUazY6wa4pKJbmqEYg1Nb5LJDNNztUjfN32dKcaAEgu4QoUxcVF/a304
         oDiWxeNipreIDfnKiiAH64wq3y2mEtJeuDwnlXC0F0pA1VAOKOXabphk06h4EQUi+9hr
         PMAayhj7Taw9X/5UZQwqjRDX0vzR6Ry9QkIpysZMP8+0RxfhItyi5vZNIJfqY5bDyeAn
         xVTA==
X-Gm-Message-State: AJIora8bVlYeXCQaWPKwXgjlwndXDjYgm+JK/w1Om7AmpUTsYeLJcE5E
        INWmO16MQODkupBVCo29cj/jF+SuvfksTw==
X-Google-Smtp-Source: AGRyM1s72MC8BHF9j5Ha54DSEtE2W5iZoGmr+77mt8A8eJMZUG9x4pM48O9yrt22/OipX0MUoLoO3g==
X-Received: by 2002:a17:906:c152:b0:726:3226:2e61 with SMTP id dp18-20020a170906c15200b0072632262e61mr18889180ejc.122.1656433926614;
        Tue, 28 Jun 2022 09:32:06 -0700 (PDT)
Received: from dario-ThinkPad-T14s-Gen-2i.homenet.telecomitalia.it (host-80-116-90-174.pool80116.interbusiness.it. [80.116.90.174])
        by smtp.gmail.com with ESMTPSA id b20-20020a0564021f1400b0042e15364d14sm9916952edb.8.2022.06.28.09.32.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jun 2022 09:32:06 -0700 (PDT)
From:   Dario Binacchi <dario.binacchi@amarulasolutions.com>
To:     linux-kernel@vger.kernel.org
Cc:     michael@amarulasolutions.com,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Oliver Hartkopp <socketcan@hartkopp.net>,
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
Subject: [PATCH v5 12/12] can: slcan: extend the protocol with CAN state info
Date:   Tue, 28 Jun 2022 18:31:36 +0200
Message-Id: <20220628163137.413025-13-dario.binacchi@amarulasolutions.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
References: <20220628163137.413025-1-dario.binacchi@amarulasolutions.com>
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

(no changes since v4)

Changes in v4:
- Add description of slc_bump_state() function.
- Remove check for the 's' character at the beggining of the function.
  It was already checked by the caller function.
- Protect decoding against the case the frame len is longer than the
  received data (add SLC_STATE_FRAME_LEN macro).
- Set cf to NULL in case of alloc_can_err_skb() failure.
- Some small changes to make the decoding more readable.
- Use the character 'b' instead of 'f' for bus-off state.

Changes in v3:
- Drop the patch "can: slcan: simplify the device de-allocation".
- Add the patch "can: netlink: dump bitrate 0 if can_priv::bittiming.bitrate is -1U".

Changes in v2:
- Continue error handling even if no skb can be allocated.

 drivers/net/can/slcan/slcan-core.c | 74 +++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/slcan/slcan-core.c b/drivers/net/can/slcan/slcan-core.c
index 4269b2267be2..54d29a410ad5 100644
--- a/drivers/net/can/slcan/slcan-core.c
+++ b/drivers/net/can/slcan/slcan-core.c
@@ -78,7 +78,11 @@ MODULE_PARM_DESC(maxdev, "Maximum number of slcan interfaces");
 #define SLC_CMD_LEN 1
 #define SLC_SFF_ID_LEN 3
 #define SLC_EFF_ID_LEN 8
-
+#define SLC_STATE_LEN 1
+#define SLC_STATE_BE_RXCNT_LEN 3
+#define SLC_STATE_BE_TXCNT_LEN 3
+#define SLC_STATE_FRAME_LEN       (1 + SLC_CMD_LEN + SLC_STATE_BE_RXCNT_LEN + \
+				   SLC_STATE_BE_TXCNT_LEN)
 struct slcan {
 	struct can_priv         can;
 	int			magic;
@@ -254,6 +258,72 @@ static void slc_bump_frame(struct slcan *sl)
 	dev_kfree_skb(skb);
 }
 
+/* A change state frame must contain state info and receive and transmit
+ * error counters.
+ *
+ * Examples:
+ *
+ * sb256256 : state bus-off: rx counter 256, tx counter 256
+ * sa057033 : state active, rx counter 57, tx counter 33
+ */
+static void slc_bump_state(struct slcan *sl)
+{
+	struct net_device *dev = sl->dev;
+	struct sk_buff *skb;
+	struct can_frame *cf;
+	char *cmd = sl->rbuff;
+	u32 rxerr, txerr;
+	enum can_state state, rx_state, tx_state;
+
+	switch (cmd[1]) {
+	case 'a':
+		state = CAN_STATE_ERROR_ACTIVE;
+		break;
+	case 'w':
+		state = CAN_STATE_ERROR_WARNING;
+		break;
+	case 'p':
+		state = CAN_STATE_ERROR_PASSIVE;
+		break;
+	case 'b':
+		state = CAN_STATE_BUS_OFF;
+		break;
+	default:
+		return;
+	}
+
+	if (state == sl->can.state || sl->rcount < SLC_STATE_FRAME_LEN)
+		return;
+
+	cmd += SLC_STATE_BE_RXCNT_LEN + SLC_CMD_LEN + 1;
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
+	if (skb) {
+		cf->data[6] = txerr;
+		cf->data[7] = rxerr;
+	} else {
+		cf = NULL;
+	}
+
+	tx_state = txerr >= rxerr ? state : 0;
+	rx_state = txerr <= rxerr ? state : 0;
+	can_change_state(dev, cf, tx_state, rx_state);
+
+	if (state == CAN_STATE_BUS_OFF)
+		can_bus_off(dev);
+
+	if (skb)
+		netif_rx(skb);
+}
+
 /* An error frame can contain more than one type of error.
  *
  * Examples:
@@ -387,6 +457,8 @@ static void slc_bump(struct slcan *sl)
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

