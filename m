Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32E0254D4D6
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 00:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350744AbiFOWvu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 18:51:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350522AbiFOWve (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 18:51:34 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 417A456415
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id h23so25963211ejj.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 15:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=pqrs.dk; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TXmIOiKtTji5uvqDZkSqwPGXddUogZT+Gvmhu7MqhdQ=;
        b=TVX+jPHr+YurZEbSw2Ju/dlh1M5+C97k4A0sYp5OVJWanDOEuDVOa2EkHzN0A691PZ
         zjKbKTLHR7zaQMlMlZjakkTU14oQrFsnCdc5FAgUSIFyIObWrSoZlMkZ/eSHxta2gMqv
         Swc43qGqkkf5kbOiQRF5nZe772+0zdPb7I46w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TXmIOiKtTji5uvqDZkSqwPGXddUogZT+Gvmhu7MqhdQ=;
        b=8KroqiekP+v0s9xNtHeX9vJe0m62vkwNisSol8bcgiHP0lcDbl1TJvt68SGA4DW3Qg
         BdV+Iaug0GFS1tTt+HI4Bk17Z2PSM+MgC+6CVP5bHwZ3z9PsbgldIvIC2Kyk1yaCPUvw
         jDjNEZaPM7bC2bEvbSPyapKR3h0sKHn8zDw/3SU4vCTzP4yBU+AmhgD2rkT/tmk1f3v7
         pe9AQAby55V94lIFlH6OumUxtIXugk1HZTEf69v4m2uMQRx57aY1v/V1FB2Q5sOZE4tN
         aD1S+lm7bEUpUpFnQrGIgeWU3C1QZm6nHv7/r//e3885Vr6I73LuNqd1dR/kYEh9fB+S
         b2rw==
X-Gm-Message-State: AJIora+S8cXVAptijIs/h1PnoX5jtqpFXtptvJ+w+K6BRXeOib7gtTTB
        9ON2CKEwFaYPX8OgTI5j+ZgxHw==
X-Google-Smtp-Source: AGRyM1vHmr4I+TxgXhv9ooyE28pTt2qO4gU18bLAATZW0N6FanBovvFpzj2orl0lAgxZ2YZxhMHg7g==
X-Received: by 2002:a17:907:86ac:b0:708:9c4a:c6e9 with SMTP id qa44-20020a17090786ac00b007089c4ac6e9mr1881699ejc.297.1655333491875;
        Wed, 15 Jun 2022 15:51:31 -0700 (PDT)
Received: from localhost.localdomain (80.71.142.18.ipv4.parknet.dk. [80.71.142.18])
        by smtp.gmail.com with ESMTPSA id h23-20020aa7c617000000b0042e21f8c412sm371506edq.42.2022.06.15.15.51.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jun 2022 15:51:31 -0700 (PDT)
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
Subject: [PATCH net-next v3 3/5] net: dsa: realtek: rtl8365mb: correct the max number of ports
Date:   Thu, 16 Jun 2022 00:51:13 +0200
Message-Id: <20220615225116.432283-4-alvin@pqrs.dk>
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

The maximum number of ports is actually 11, according to two
observations:

1. The highest port ID used in the vendor driver is 10. Since port IDs
   are indexed from 0, and since DSA follows the same numbering system,
   this means up to 11 ports are to be presumed.

2. The registers with port mask fields always amount to a maximum port
   mask of 0x7FF, corresponding to a maximum 11 ports.

In view of this, I also deleted the comment.

Signed-off-by: Alvin Šipraga <alsi@bang-olufsen.dk>
Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb.c b/drivers/net/dsa/realtek/rtl8365mb.c
index 42afba122bb4..3599fa5d9f14 100644
--- a/drivers/net/dsa/realtek/rtl8365mb.c
+++ b/drivers/net/dsa/realtek/rtl8365mb.c
@@ -115,8 +115,7 @@
 #define RTL8365MB_PHYADDRMAX		7
 #define RTL8365MB_NUM_PHYREGS		32
 #define RTL8365MB_PHYREGMAX		(RTL8365MB_NUM_PHYREGS - 1)
-/* RTL8370MB and RTL8310SR, possibly suportable by this driver, have 10 ports */
-#define RTL8365MB_MAX_NUM_PORTS		10
+#define RTL8365MB_MAX_NUM_PORTS		11
 #define RTL8365MB_LEARN_LIMIT_MAX	2112
 
 /* valid for all 6-port or less variants */
-- 
2.36.1

