Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DEE253EA8C
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239184AbiFFNqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:46:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiFFNqT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:46:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD9D61B9A7C
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:46:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id s12so21853421ejx.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uHwQH74Q7N25Q2zdI6IdVXzOKcdi3juWfll5ugT6Tp8=;
        b=HYqm1kQIFYFjJDQgAJt9wjqHr/Y/X21kXW7swzLHk/yT4N57VjWHoyBsEzw0XckAYq
         qCqyJ3ooMy+n3Xw+Ldk31A1qJZmqEOBs7J7IKp2mOCuSjGchK+xPq//cpeKvmAhkmrH5
         m0dVaugF7kY3M/AI+WOLm5+8OL8xEeDqaWV8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uHwQH74Q7N25Q2zdI6IdVXzOKcdi3juWfll5ugT6Tp8=;
        b=uc2pPWvR1aQwwUH491+bFkREG9+roTHeRkREsMvBgsI04orU2I5/AwZPAZywJ8Jqwe
         Dl+ak03Tq8NjplEXr4p1M9WyIEQSx9nOqN+F3fUart+uGQ8vKUi7xweEEfUGxHpbOV/+
         R3F41He6hLGQoT3Dzled0Zd50uae3btaqcI7aXNH+FV99QcjLUtBCCMCCO570WLJykub
         JM2mhtfRDRzQtvmg98XjL4xBkTNl9WHVfpFwrPZysIs5sggJPu5LPEXC81o0mZ7Ehns5
         kY75DI/yE1sIvDV6xf5wM/0/A2jp8Qr/61z3c86IIarIdCSz4C8+kUB8ccoZxW1g8FJp
         QKNg==
X-Gm-Message-State: AOAM532Gu6JYhJEYjI6aTjECOjoli0R6vWQhDCYpKTOMJqhRqleSEwjw
        h11tOvkdnNo6hNP/WmG3zsR7RQ==
X-Google-Smtp-Source: ABdhPJxHAmaTQ7SoG4xOWZo1AxxrADEQ2354vOZDz2LunO92X2LOOVaWdpZupcrtKG2bjWHbFEFu3Q==
X-Received: by 2002:a17:907:2d2a:b0:710:76a1:4d89 with SMTP id gs42-20020a1709072d2a00b0071076a14d89mr11993861ejc.307.1654523178289;
        Mon, 06 Jun 2022 06:46:18 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id a26-20020a1709062b1a00b006f3ef214db4sm5496538ejg.26.2022.06.06.06.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 06:46:17 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     luizluca@gmail.com, Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
        Andrew Lunn <andrew@lunn.ch>,
        Vivien Didelot <vivien.didelot@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next 4/5] net: dsa: realtek: rtl8365mb: remove learn_limit_max private data member
Date:   Mon,  6 Jun 2022 15:45:52 +0200
Message-Id: <20220606134553.2919693-5-alvin@pqrs.dk>
X-Mailer: git-send-email 2.36.0
In-Reply-To: <20220606134553.2919693-1-alvin@pqrs.dk>
References: <20220606134553.2919693-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alvin Šipraga <alsi@bang-olufsen.dk>

The variable is just assigned the value of a macro, so it can be
removed.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 392047558656..a3a4454f77bf 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -563,7 +563,6 @@ struct rtl8365mb_port {
  * @irq: registered IRQ or zero
  * @chip_id: chip identifier
  * @chip_ver: chip silicon revision
- * @learn_limit_max: maximum number of L2 addresses the chip can learn
  * @cpu: CPU tagging and CPU port configuration for this chip
  * @mib_lock: prevent concurrent reads of MIB counters
  * @ports: per-port data
@@ -577,7 +576,6 @@ struct rtl8365mb {
 	int irq;
 	u32 chip_id;
 	u32 chip_ver;
-	u32 learn_limit_max;
 	struct rtl8365mb_cpu cpu;
 	struct mutex mib_lock;
 	struct rtl8365mb_port ports[RTL8365MB_MAX_NUM_PORTS];
@@ -1108,15 +1106,13 @@ static void rtl8365mb_port_stp_state_set(struct dsa_switch *ds, int port,
 static int rtl8365mb_port_set_learning(struct realtek_priv *priv, int port,
 				       bool enable)
 {
-	struct rtl8365mb *mb = priv->chip_data;
-
 	/* Enable/disable learning by limiting the number of L2 addresses the
 	 * port can learn. Realtek documentation states that a limit of zero
 	 * disables learning. When enabling learning, set it to the chip's
 	 * maximum.
 	 */
 	return regmap_write(priv->map, RTL8365MB_LUT_PORT_LEARN_LIMIT_REG(port),
-			    enable ? mb->learn_limit_max : 0);
+			    enable ? RTL8365MB_LEARN_LIMIT_MAX : 0);
 }
 
 static int rtl8365mb_port_set_isolation(struct realtek_priv *priv, int port,
@@ -2026,7 +2022,6 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 		mb->priv = priv;
 		mb->chip_id = chip_id;
 		mb->chip_ver = chip_ver;
-		mb->learn_limit_max = RTL8365MB_LEARN_LIMIT_MAX;
 		mb->jam_table = rtl8365mb_init_jam_8365mb_vc;
 		mb->jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc);
 
-- 
2.36.0

