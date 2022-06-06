Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4453EC4F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:10:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239190AbiFFNqW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 09:46:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239048AbiFFNqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 09:46:15 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A76B1B1865
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 06:46:14 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id n10so29082088ejk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 06:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hM/8L0QQElJsG/ZP5E7Xm7971VYDngZ9OkzPm4OYvuE=;
        b=OJs8LpvrKqi5Cd/dGV4X9s3P+/ySjRV6bVK4kcv4eoRQDVu8BWaMoFAMh81BUHldVs
         L3JfVc21sD/XqfokWo0cpvMxm3hbVeaFI0Jt693xfKSsG6dbpulwLsu2EYZQ/KJGHyBu
         Qh4dcbTDjxCnrY9P+TvPwLihtKe6DfBR+dL9o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hM/8L0QQElJsG/ZP5E7Xm7971VYDngZ9OkzPm4OYvuE=;
        b=pK/LRedbLg66mq9hNwz9dd3LxgpFRGIhX2QstBQwOpBTdiZtUrJXEJFZF24sGc+eJ7
         RMaU/9x4QHdfqns+iF8RLaqPVlcpuzdZmcVt+/wMEe2yg7HK2HImi36BrIiP2VRo7sqf
         7+q8W533UMhVBSW5WnzVBdY8oZjpvFbYea4Uutr0ACh9AEaPRg1igjLDlquJ0IbIQtJ2
         NVSbdWhRUTiu1DdIcXNOypZ7obvh5ExD516EkGAxZjGDoayvj+7ZTmlNl4bxXSTQo9oO
         TAOeDRDa4DAJcIfsdBVXajRe8qSLzm5PKbi6Q2K862NWv5E8Qve2bYJ7SWzytCoCuH0Q
         lU4A==
X-Gm-Message-State: AOAM530O8nI8kbg78MqvuhQ9A4TMajLjUmHwLFXBcFDaLGyt2cwR8CeH
        8CmAsB95yckkOjsCcJjXsca9Kw==
X-Google-Smtp-Source: ABdhPJwDtrN5NZdSXdvq60ci2ZzH2UR8lC1o4NQ/iJefcuNGMyK/r2DHNkCOrIizzW/WLbjiNyv2CA==
X-Received: by 2002:a17:907:7da5:b0:711:c9cd:61e0 with SMTP id oz37-20020a1709077da500b00711c9cd61e0mr6287983ejc.443.1654523172865;
        Mon, 06 Jun 2022 06:46:12 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id a26-20020a1709062b1a00b006f3ef214db4sm5496538ejg.26.2022.06.06.06.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 06:46:12 -0700 (PDT)
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
Subject: [PATCH net-next 1/5] net: dsa: realtek: rtl8365mb: rename macro RTL8367RB -> RTL8367RB_VB
Date:   Mon,  6 Jun 2022 15:45:49 +0200
Message-Id: <20220606134553.2919693-2-alvin@pqrs.dk>
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

The official name of this switch is RTL8367RB-VB, not RTL8367RB. There
is also an RTL8367RB-VC which is rather different. Change the name of
the CHIP_ID/_VER macros for reasons of consistency.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 3bb42a9f236d..0cc90e96aab7 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -108,8 +108,8 @@
 #define RTL8365MB_CHIP_ID_8367S		0x6367
 #define RTL8365MB_CHIP_VER_8367S	0x00A0
 
-#define RTL8365MB_CHIP_ID_8367RB	0x6367
-#define RTL8365MB_CHIP_VER_8367RB	0x0020
+#define RTL8365MB_CHIP_ID_8367RB_VB	0x6367
+#define RTL8365MB_CHIP_VER_8367RB_VB	0x0020
 
 /* Family-specific data and limits */
 #define RTL8365MB_PHYADDRMAX		7
@@ -2008,7 +2008,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 				 "found an RTL8365MB-VC switch (ver=0x%04x)\n",
 				 chip_ver);
 			break;
-		case RTL8365MB_CHIP_VER_8367RB:
+		case RTL8365MB_CHIP_VER_8367RB_VB:
 			dev_info(priv->dev,
 				 "found an RTL8367RB-VB switch (ver=0x%04x)\n",
 				 chip_ver);
-- 
2.36.0

