Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EDDA5331B0
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:20:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240766AbiEXTUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiEXTUS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:20:18 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5637A64BC4
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:20:17 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id p10so8461400wrg.12
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=message-id:subject:from:reply-to:to:cc:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=Mt9M1gkKLEXdm19V1RfAKfuaLVzEHPQcfZI5XRLDbh4=;
        b=PrABYHIthafLbtt2NStkcGUWnO5SCbjjjzTw21Pbth452TR7xqAeVPv2Y/HhOHJLdj
         EpRuW5CpzFyZ7BX+aS9dw18F/oSjjR6J+KKWAwPrlAgHGqYFwgQo+cAvAydT1oryibWi
         Ld6RlTGccTEhtPCnJzrHPB+sc4fQMHBT3LqhzGh9jI2HOVl+IMLxm8VD2WcFoO6SgEES
         0kJqd+r5yZWUT5jNJ2qKkIy1nGiVtk6JllvWclX8Pj6imU5ZXSSQccIWBtCNTG0yfTwG
         /SGpdubZZttf64U6cmG3+enqXA8CtJZf9NOSLJ8Blu7OKxo12GDTNzd43BSY5CbjMKDJ
         EQ1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:reply-to:to:cc:date
         :user-agent:mime-version:content-transfer-encoding;
        bh=Mt9M1gkKLEXdm19V1RfAKfuaLVzEHPQcfZI5XRLDbh4=;
        b=C169WRaH4TAJkDFK3ACU9wRIEk7bRnsx3UPUZ078rwe0v+kEjESJgMqHuISAqdLojU
         1Ss79J37upHS/oRHCy7Cx2pLFb/MR8B+y7AlGWthMNcx5joc3ZDK+/L/FW0sSjHAzx3Q
         A1ZTrA0daRnWgLBcMtLoXg7mMji80IsQmBKId9rHo4gL26cZulg/IiIcffCtOXXo/AQd
         kOGtzDk2T50Wa+F7M2++YqAwJ2N6/0nVifq7RwdX6R1GTSHlP66sY+nfipD+UMCxkqq4
         JajD/6gJiVX0tCcsByQpJkvt1Xkp4eZ1JweCI9uV8ozsDLKHcXUSNVE36SmqxDU3G9Rq
         Fxng==
X-Gm-Message-State: AOAM533N+gTeLy7KpUy0OAvJ4OPTUYAfspiBC4czAvWAYq5ANSxYQOr8
        NXeTCLQzQ2UnHmtoce7unss=
X-Google-Smtp-Source: ABdhPJycIU8EUWa6sk6j8pSnaz8LvsntfLNkERrRa89WZqkB7pk10YjIdZwAi5wZTQSkZIxIr2USWg==
X-Received: by 2002:a5d:4948:0:b0:20e:58f8:f4ce with SMTP id r8-20020a5d4948000000b0020e58f8f4cemr25040149wrs.229.1653420015848;
        Tue, 24 May 2022 12:20:15 -0700 (PDT)
Received: from mars.fritz.box ([2a02:8070:bb0:8700:3e7c:3fff:fe20:2cae])
        by smtp.gmail.com with ESMTPSA id m8-20020a056000024800b0020fdc90aeabsm213865wrz.82.2022.05.24.12.20.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 12:20:15 -0700 (PDT)
Message-ID: <48b49de3712267780916b665d3b2a3323e6f10ce.camel@googlemail.com>
Subject: [PATCH] mtd: spi-nor: atmel: Add at25ql641 support
From:   Christoph Fritz <chf.fritz@googlemail.com>
Reply-To: chf.fritz@googlemail.com
To:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>,
        Michael Walle <michael@walle.cc>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        ClaudiuBeznea <claudiu.beznea@microchip.com>,
        linux-mtd@lists.infradead.org,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Tue, 24 May 2022 21:20:13 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds AT25QL641 to the list of supported nor flashs.

Signed-off-by: Christoph Fritz <chf.fritz@googlemail.com>
---
 drivers/mtd/spi-nor/atmel.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/mtd/spi-nor/atmel.c b/drivers/mtd/spi-nor/atmel.c
index 656dd80a0be7..dfbc12071093 100644
--- a/drivers/mtd/spi-nor/atmel.c
+++ b/drivers/mtd/spi-nor/atmel.c
@@ -186,6 +186,8 @@ static const struct flash_info atmel_nor_parts[] = {
 		.fixups = &atmel_nor_global_protection_fixups },
 	{ "at25sl321",	INFO(0x1f4216, 0, 64 * 1024, 64)
 		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
+	{ "at25ql641",	INFO(0x1f4317, 0, 64 * 1024, 128)
+		NO_SFDP_FLAGS(SECT_4K | SPI_NOR_DUAL_READ | SPI_NOR_QUAD_READ) },
 	{ "at26f004",   INFO(0x1f0400, 0, 64 * 1024,  8)
 		NO_SFDP_FLAGS(SECT_4K) },
 	{ "at26df081a", INFO(0x1f4501, 0, 64 * 1024, 16)
-- 
2.30.2


