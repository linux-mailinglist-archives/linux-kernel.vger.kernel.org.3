Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D008546991
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Jun 2022 17:40:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346178AbiFJPju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 11:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345428AbiFJPjV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 11:39:21 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31B928DC01
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:39:19 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x5so30715214edi.2
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 08:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=AareH3Xp+hp4A5FOtY4uNivgTY9OEK29GzGPxmxFOws=;
        b=cerH8wlG313nA0z0Y7JIP0fnogppEEaTDR4YmPZvIIxv2wRJq3Kq8l+xWfW7dFVRN/
         jyeFFxTIn5hReE15OTzXVG8bqJG0kAI3ueQkwX8823WsOL3xlFtg5cCOeczLROZmimhL
         1LZBzKju0bGg2IsnaN6U4rS8A8QuS9MTKReaE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=AareH3Xp+hp4A5FOtY4uNivgTY9OEK29GzGPxmxFOws=;
        b=FoQzTIpiAq/RFPXuKSjOziJrhb2KCOCexbE7qCshAx40TBRUJ4xc8oH9G3M+oad7bx
         UWK8Y1Ay+WdBvznPNsjAgMRI7vYjJi2moLIjKAuPZUgnbU6T/v7shX1RiYuwItcJeog7
         dtSK8sfEvBlVfzzu3E3w5pEdoh0x0bTA47X7Mqnrrvl5jWl9dr0CngUzv1hsO/iAbLbh
         Usb7RxqCLvLlJMynLKvDHuSDk6ea2e9ko6ccQ7B7GJ/ZA083tPPdvw/uzU7tdZfkDJ2h
         QrVnDwRpT8nfbxjkv/RyD3nySKwjI/nXNiVHkXEoijZpI5OYfwZdtnyjSWsS2crLll/J
         QHZQ==
X-Gm-Message-State: AOAM5327adj20x+sXluta2bxSGoRhSwzsJPrXB8PUz6VYZu1TIQowJrt
        YqZJ0v/vJ0VqX4IJrYp2+cshfOEUzVC1YvRe
X-Google-Smtp-Source: ABdhPJy4raIs0VwqrQPiBQc3E+6FgvT/KawaF9u4p4aP/jcqe9nJxFcsMMLVxxPhpWnrV5KLM9ze4g==
X-Received: by 2002:aa7:c752:0:b0:42d:ee9d:5ace with SMTP id c18-20020aa7c752000000b0042dee9d5acemr52401926eds.318.1654875558812;
        Fri, 10 Jun 2022 08:39:18 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id h24-20020a170906829800b0070f7d1c5a18sm9783857ejx.55.2022.06.10.08.39.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jun 2022 08:39:17 -0700 (PDT)
From:   =?UTF-8?q?Alvin=20=C5=A0ipraga?= <alvin@pqrs.dk>
To:     hauke@hauke-m.de, Linus Walleij <linus.walleij@linaro.org>,
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
Subject: [PATCH net-next v2 4/5] net: dsa: realtek: rtl8365mb: remove learn_limit_max private data member
Date:   Fri, 10 Jun 2022 17:38:28 +0200
Message-Id: <20220610153829.446516-5-alvin@pqrs.dk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220610153829.446516-1-alvin@pqrs.dk>
References: <20220610153829.446516-1-alvin@pqrs.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
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
index 3599fa5d9f14..676b88798976 100644
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
@@ -1088,15 +1086,13 @@ static void rtl8365mb_port_stp_state_set(struct dsa_switch *ds, int port,
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
@@ -2003,7 +1999,6 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 		mb->priv = priv;
 		mb->chip_id = chip_id;
 		mb->chip_ver = chip_ver;
-		mb->learn_limit_max = RTL8365MB_LEARN_LIMIT_MAX;
 		mb->jam_table = rtl8365mb_init_jam_8365mb_vc;
 		mb->jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc);
 
-- 
2.36.1

