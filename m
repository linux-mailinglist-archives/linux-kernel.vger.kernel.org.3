Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 517A758614D
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 22:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238450AbiGaUWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 16:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238282AbiGaUWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 16:22:11 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A13906409;
        Sun, 31 Jul 2022 13:22:10 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id z22so11450578edd.6;
        Sun, 31 Jul 2022 13:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MBKwjfllj9jHmHpk5aP7RGCr5Sey5BCkshas/2Sh93A=;
        b=VS4nqW/XEaR1UPiSRCafl+AOpzCuWQyMo4+fwwC53N7yDNVDlmkL5WanXtunFuVppT
         Ybv1cvpvvE49FUvRlu7SsS+N5AtpYzgJoUn8NApOYHD/pCSyHRtOqJnSRh0pWbdpWFKT
         Ov4IGHqK6NIwfLvnmkRIGK43b7+Y1tpr2Cz79H32kTBuSy9EiIZl1kZAbf0IccP7KvSu
         vUWQd2bBR3bL6n9wo4kdX7VfY5fJej5/Z8f9Ic+/F/ADv8Ez8d78emjjymjTYyNN70Fi
         h2fluVvBeHgft3gpvyU61hFwj0CRYlwUe9tAkySMKSXNcvFM6IrzmzOwBky1oJl12s9K
         zV5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MBKwjfllj9jHmHpk5aP7RGCr5Sey5BCkshas/2Sh93A=;
        b=0VEtEVOlXumeQzJesLC465fyrtVhq/e1dHJqiwqxVbsK9Go0DdCxc6ERCANsqvNA/M
         ht9NA+nRpdUa/mTSmrkMG51vFr9tK0VQlvm9CrLdcS5+MVFaTBxWWqvEj4Ss4z5wzNjU
         tvD1W7CeTVuo3/6MxCwGptPV7dsvGSrUUIIS3ChWfTOI+Bya6LmczM29bWI23sr5ArHe
         +swHaRNzptfpzS1awHmvhnv1HOx/N1yadSXvNEH4erGOsnbraVCc++S1evtZZteAC49+
         ZYnbouI+iB5wF3Ax5g4z4vA5Cgk99VtpQaEm0tupb6u9esxq70LswPPRFwnTDqusSf5G
         8luw==
X-Gm-Message-State: AJIora8S769jb7kAe9jL+jnAc4ScsS6HvF8RNyWVyzFIpnIXOWNraHMg
        y2tpWnqhDwgCQjrwGFAxYM87sFImPSI=
X-Google-Smtp-Source: AGRyM1tvJ0SiUZyg5F4dDxtxeq4OVf8UCXzfi05OsyYG7Gf1NqOD8i+l0QMwT7yZ9MKj5k7N9p9BXQ==
X-Received: by 2002:a05:6402:34c1:b0:43c:e6a:397d with SMTP id w1-20020a05640234c100b0043c0e6a397dmr12581554edc.160.1659298929007;
        Sun, 31 Jul 2022 13:22:09 -0700 (PDT)
Received: from localhost.localdomain (dynamic-095-115-050-116.95.115.pool.telefonica.de. [95.115.50.116])
        by smtp.googlemail.com with ESMTPSA id q23-20020aa7cc17000000b0043d0955d546sm4978629edt.69.2022.07.31.13.22.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Jul 2022 13:22:08 -0700 (PDT)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-spi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, bert@biot.com, sander@svanheule.net,
        mail@birger-koblitz.de,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v3 2/2] spi: realtek-rtl: Improve readability when clearing the size mask
Date:   Sun, 31 Jul 2022 22:21:52 +0200
Message-Id: <20220731202152.1358252-3-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220731202152.1358252-1-martin.blumenstingl@googlemail.com>
References: <20220731202152.1358252-1-martin.blumenstingl@googlemail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Define the bitmask RTL_SPI_SFCSR_LEN_MASK so it only sets the bits of
this specific part of the register instead of setting all bits except
the relevant ones. This makes it consistent with single bit macros in
the spi-realtek-rtl driver as well as with the approach that many other
drivers use.

Suggested-by: Sander Vanheule <sander@svanheule.net>
Tested-by: Sander Vanheule <sander@svanheule.net>
Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
---
 drivers/spi/spi-realtek-rtl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-realtek-rtl.c b/drivers/spi/spi-realtek-rtl.c
index 866b0477dbd7..0371d44cbfbd 100644
--- a/drivers/spi/spi-realtek-rtl.c
+++ b/drivers/spi/spi-realtek-rtl.c
@@ -20,7 +20,7 @@ struct rtspi {
 #define RTL_SPI_SFCSR_CSB1		BIT(30)
 #define RTL_SPI_SFCSR_RDY		BIT(27)
 #define RTL_SPI_SFCSR_CS		BIT(24)
-#define RTL_SPI_SFCSR_LEN_MASK		~(0x03 << 28)
+#define RTL_SPI_SFCSR_LEN_MASK		(0x03 << 28)
 #define RTL_SPI_SFCSR_LEN1		(0x00 << 28)
 #define RTL_SPI_SFCSR_LEN4		(0x03 << 28)
 
@@ -49,7 +49,7 @@ static void set_size(struct rtspi *rtspi, int size)
 	u32 value;
 
 	value = readl(REG(RTL_SPI_SFCSR));
-	value &= RTL_SPI_SFCSR_LEN_MASK;
+	value &= ~RTL_SPI_SFCSR_LEN_MASK;
 	if (size == 4)
 		value |= RTL_SPI_SFCSR_LEN4;
 	else if (size == 1)
-- 
2.37.1

