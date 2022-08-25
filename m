Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7815A0ACB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:54:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbiHYHxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233350AbiHYHxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:53:43 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819F8A2D91
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:53:42 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id w20so9259611edd.10
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=78LV1OFXn4kU+Li1Jo3v1pAvNQIAGmy0sk/6bF76fRQ=;
        b=Wd51wZvW5WFwaIoYN+lZ7WHoYz8LAT/LPsPSjAobWsPxeAy1SqWwSgQXNTbCFJEEFN
         dTuv8fiTkttDgJ+zDqXUQeTmFin9tS1kg3LomvI5oh0xcddf71DyXfveF39TixR4DFxu
         hRv+fJxhv+j9rRQqeUIqwJdFXp/gz2MKdQZ34HsnWsPDKV8Q8eHBxuC1P1GC5+3VcuO1
         V8j+cHHxip61cL0sUUkKKMjZn25Dy9eHrHWW2KQR3wVa/Gy0MXSsERnN8iNyTpYkxiTI
         7pzltRRgFUBUU2HudbKJ/l9Iz4WZwQhzAGhVZS8aqWN/dybO0mS+upWrof4DYmhTSpK8
         BxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=78LV1OFXn4kU+Li1Jo3v1pAvNQIAGmy0sk/6bF76fRQ=;
        b=GQc4IM/idYifBGlC6WNROgiwz9LC18R1B2yoqd9XwJPI5/KyzlwGCsNJ02KS1lXGNd
         +U8LPcYFQBSQOjtjKrOv7sVWmtvAqWsiB/0F1IxX8G0hEp4IWVItjDUEWs5B1cQvQTxM
         GL0bNDGoPNOc7oHpK/RVeC5YhdELgM1Q4X8Pn8mBrjtCgCK373XEtWypOEDYjsVbYkm1
         qrewte4Y0Fk4QEhUKgttokPGX84GKIul+OXWLLqVsPb1COhiY0rTOo0FX5lsGDZJshEH
         exPxG6iDXteVm4oaH/WTMUGa6pRvoUU3iTLKoWCojvOg16MBU4zyS2f3K2KEkgoekT5M
         FDWA==
X-Gm-Message-State: ACgBeo1twZygA5DTI5dZ71v46O3jfHlJe2IrDqIsuFCxY+LcxtYhe+Ja
        o4cJgMqGYyE2ufS0C8E/OscI8g==
X-Google-Smtp-Source: AA6agR5W9ulp4PdYSwLAp/6nQblVWJxOhoKk/OJmVAtEANwcbeTL0n2XJqbo+/Dr37lNINquqWbUNQ==
X-Received: by 2002:a05:6402:3509:b0:43e:d80b:44a8 with SMTP id b9-20020a056402350900b0043ed80b44a8mr2174857edd.255.1661414021084;
        Thu, 25 Aug 2022 00:53:41 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906b09600b0073dbfd33a8dsm1491736ejy.21.2022.08.25.00.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:53:40 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     miquel.raynal@bootlin.com, linux-mtd@lists.infradead.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] mtd: rawnand: stm32_fmc2: Fix dma_map_sg error check
Date:   Thu, 25 Aug 2022 09:53:37 +0200
Message-Id: <20220825075338.35338-2-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220825075338.35338-1-jinpu.wang@ionos.com>
References: <20220825075338.35338-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, in case of error return -EIO.

Cc: Miquel Raynal <miquel.raynal@bootlin.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Vignesh Raghavendra <vigneshr@ti.com>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Christophe Kerello <christophe.kerello@foss.st.com>
Cc: Cai Huoqing <cai.huoqing@linux.dev>
Cc: linux-mtd@lists.infradead.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org
Fixes: 2cd457f328c1 ("mtd: rawnand: stm32_fmc2: add STM32 FMC2 NAND flash controller driver")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 87c1c7dd97eb..a0c825af19fa 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -862,8 +862,8 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 
 	ret = dma_map_sg(nfc->dev, nfc->dma_data_sg.sgl,
 			 eccsteps, dma_data_dir);
-	if (ret < 0)
-		return ret;
+	if (!ret)
+		return -EIO;
 
 	desc_data = dmaengine_prep_slave_sg(dma_ch, nfc->dma_data_sg.sgl,
 					    eccsteps, dma_transfer_dir,
@@ -893,8 +893,10 @@ static int stm32_fmc2_nfc_xfer(struct nand_chip *chip, const u8 *buf,
 
 		ret = dma_map_sg(nfc->dev, nfc->dma_ecc_sg.sgl,
 				 eccsteps, dma_data_dir);
-		if (ret < 0)
+		if (!ret) {
+			ret = -EIO;
 			goto err_unmap_data;
+		}
 
 		desc_ecc = dmaengine_prep_slave_sg(nfc->dma_ecc_ch,
 						   nfc->dma_ecc_sg.sgl,
-- 
2.34.1

