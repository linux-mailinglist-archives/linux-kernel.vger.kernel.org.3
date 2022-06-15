Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C3154D4C9
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:51:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350567AbiFOWvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350488AbiFOWvc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:51:32 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D8D56406
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:31 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id s12so26019591ejx.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XE/B3EfYYQf1mtimqgsF3ZVDA9bOVjSyLpITpl2gz98=;
        b=CAAN8l3+EJB/bqURL9Y6xhpSqAw97LvZavrZ6FBByM//joPRSbkhGQni6zU6ykVcWk
         4ciGFpFoSsXg5m0xStFX/r9KVDJNckeOxtYXIxLFcx293locPU+LaIOSlYfBiYFdsEwm
         JqXoAAKaq2ZL7MYjGEDKtEfn5K9G9HV7PDONM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XE/B3EfYYQf1mtimqgsF3ZVDA9bOVjSyLpITpl2gz98=;
        b=66bjCqwTMbtxrDCUe4mNql/S5bL88UA4m2D8DOL0iiSHXdowHBKGOkEozwY1FmXcxS
         VrMlfz4+4QEsguovgv2h5k4XLzknXOVqJ7QveiWetB0OLoopXspLYIvxP272ONqOJiMe
         KJhdpX56A8cYQd/dlu/HJQzZVJikdhZBpCiCNOarHboK+uQhG+CviY763mO4qFDI0+FK
         mObc/wnOm9u0KvaAVlPjPUPzQ+lnyjmgCD3kKaQtj43D9xu59KHHEE9Effg8Y5hainMt
         4rRqdZdydAxpLDqz/cB4ijVu9RIU3SIK05J+UFj0uYeN+JLPIeVgomOkGw2Iy889Ou99
         mlvQ==
X-Gm-Message-State: AJIora+EEECPDMFMLgy5XzyaTEJG9aZhoQ9eEg3SWvSl1sc7iMWG4qLL
        kyK7WxazvKxxCGd85dFoqfIEWw==
X-Google-Smtp-Source: AGRyM1u/n8oPQZ/PAaY1yIz7bNcJISipoi7XTrNBfYUp8Pz+3ypt2FpQLPAsoP+rXtgzLQ2+TCYh7w==
X-Received: by 2002:a17:906:a858:b0:70e:a4d8:1c45 with SMTP id dx24-20020a170906a85800b0070ea4d81c45mr1821800ejb.213.1655333489994;
        Wed, 15 Jun 2022 15:51:29 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id h23-20020aa7c617000000b0042e21f8c412sm371506edq.42.2022.06.15.15.51.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:51:29 -0700 (PDT)
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
Subject: [PATCH net-next v3 2/5] net: dsa: realtek: rtl8365mb: remove port_mask private data member
Date:   Thu, 16 Jun 2022 00:51:12 +0200
Message-Id: <20220615225116.432283-3-alvin@pqrs.dk>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220615225116.432283-1-alvin@pqrs.dk>
References: <20220615225116.432283-1-alvin@pqrs.dk>
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

There is no real need for this variable: the line change interrupt mask
is sufficiently masked out when getting linkup_ind and linkdown_ind in
the interrupt handler.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 905056250b88..42afba122bb4 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -564,7 +564,6 @@ struct rtl8365mb_port {
  * @irq: registered IRQ or zero
  * @chip_id: chip identifier
  * @chip_ver: chip silicon revision
- * @port_mask: mask of all ports
  * @learn_limit_max: maximum number of L2 addresses the chip can learn
  * @cpu: CPU tagging and CPU port configuration for this chip
  * @mib_lock: prevent concurrent reads of MIB counters
@@ -579,7 +578,6 @@ struct rtl8365mb {
 	int irq;
 	u32 chip_id;
 	u32 chip_ver;
-	u32 port_mask;
 	u32 learn_limit_max;
 	struct rtl8365mb_cpu cpu;
 	struct mutex mib_lock;
@@ -1489,13 +1487,10 @@ static irqreturn_t rtl8365mb_irq(int irq, void *data)
 {
 	struct realtek_priv *priv = data;
 	unsigned long line_changes = 0;
-	struct rtl8365mb *mb;
 	u32 stat;
 	int line;
 	int ret;
 
-	mb = priv->chip_data;
-
 	ret = rtl8365mb_get_and_clear_status_reg(priv, RTL8365MB_INTR_STATUS_REG,
 						 &stat);
 	if (ret)
@@ -1520,7 +1515,7 @@ static irqreturn_t rtl8365mb_irq(int irq, void *data)
 
 		linkdown_ind = FIELD_GET(RTL8365MB_PORT_LINKDOWN_IND_MASK, val);
 
-		line_changes = (linkup_ind | linkdown_ind) & mb->port_mask;
+		line_changes = linkup_ind | linkdown_ind;
 	}
 
 	if (!line_changes)
@@ -2009,7 +2004,6 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 		mb->priv = priv;
 		mb->chip_id = chip_id;
 		mb->chip_ver = chip_ver;
-		mb->port_mask = GENMASK(priv->num_ports - 1, 0);
 		mb->learn_limit_max = RTL8365MB_LEARN_LIMIT_MAX;
 		mb->jam_table = rtl8365mb_init_jam_8365mb_vc;
 		mb->jam_size = ARRAY_SIZE(rtl8365mb_init_jam_8365mb_vc);
-- 
2.36.1

