Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399D554D4CC
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350550AbiFOWvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350414AbiFOWvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:51:31 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E12F856406
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:29 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id fu3so25973143ejc.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zSzdOiSgxbYWZxXEulfQBrTFa8jqymfNEasGrW3oI+Y=;
        b=nDXpbxcKOzdVuZicNv5F2+PRhUSKEiINNs+eqhsd5039Cf3uczSQdHcn4hMpLr4htN
         SPlUe96Ie4d9UdpdL2WOFshK1RHGhks1LECgZ7ivssvVm4ToWloOeGjfchBmf54yC7ru
         Ic6ZF59aeggWbCSv2XJB1bDtiToDd72Z+x1Vw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zSzdOiSgxbYWZxXEulfQBrTFa8jqymfNEasGrW3oI+Y=;
        b=2TUGsUmzOk8/8grleEjtA4PWzL1u9jOkyXZHFrYhCAmBdUXHksfZcgqJxK9TVh2FDT
         y91vKS/bUEgfpTpq/uZxkW9YhyoqFvOcZHCOVO6cmaWUrxr9J6TEQVg6PGNqGhYzkh36
         n3hMr7/vQrWCqTN6iua/yM0eiy7dkA2ea6Tw5Zm2xqflJNW6FE/zqMUaSjysGTJST9+l
         gt/3I2ov+R7T8rwpZzIPifOtdacxr6emrh+nHGKFfo9QbssySzAwkcM6TqmLIvwtCvd1
         Pk0hIBZ+HIWj+AjquTG457zmw/cy81c2gyL48GWtlCNAWSUdgWHfkXhYgg1DIs+FlAkz
         Hu2A==
X-Gm-Message-State: AJIora+ya3wwkneOPClkoHJiUyHM29zlqMiAhk2QZjMK06TbW2rK1Q26
        7e6M3i/AoCzSgeVal/UdujfDJQ==
X-Google-Smtp-Source: AGRyM1sBIJM4d9dE6NYu3F+YuovSCF3q2IZg6I4e2Aisjkqd1z3WeHXXoOP6pexfDH644qGlWTEhjA==
X-Received: by 2002:a17:906:9b86:b0:6f8:24e7:af7d with SMTP id dd6-20020a1709069b8600b006f824e7af7dmr1966601ejc.295.1655333488459;
        Wed, 15 Jun 2022 15:51:28 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id h23-20020aa7c617000000b0042e21f8c412sm371506edq.42.2022.06.15.15.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:51:28 -0700 (PDT)
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
Cc:     Luiz Angelo Daros de Luca <luizluca@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 1/5] net: dsa: realtek: rtl8365mb: rename macro RTL8367RB -> RTL8367RB_VB
Date:   Thu, 16 Jun 2022 00:51:11 +0200
Message-Id: <20220615225116.432283-2-alvin@pqrs.dk>
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

The official name of this switch is RTL8367RB-VB, not RTL8367RB. There
is also an RTL8367RB-VC which is rather different. Change the name of
the CHIP_ID/_VER macros for reasons of consistency.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 769f672e9128..905056250b88 100644
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
@@ -1988,7 +1988,7 @@ static int rtl8365mb_detect(struct realtek_priv *priv)
 				 "found an RTL8365MB-VC switch (ver=0x%04x)\n",
 				 chip_ver);
 			break;
-		case RTL8365MB_CHIP_VER_8367RB:
+		case RTL8365MB_CHIP_VER_8367RB_VB:
 			dev_info(priv->dev,
 				 "found an RTL8367RB-VB switch (ver=0x%04x)\n",
 				 chip_ver);
-- 
2.36.1

