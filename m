Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30D935A0ACC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 09:54:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233748AbiHYHx7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 03:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229592AbiHYHxo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 03:53:44 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36DE9E8B6
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:53:43 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id z8so4396436edb.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 00:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Lc3v8hBHsCf49bYVex16KFSKbVG0hlFgO3dkVBUtLng=;
        b=e6L6q0BJUH+0W1pJctd5mNfbN9fET2DENNXVuhELy/kF0phr1KgPmbFrEL6S4XysGM
         ENOkFXDnlTf0HOOXyds250s4+e1nZ2S5t+l5rV5GknHKbwpwF6O1m1hlgSlTqwKshIfX
         qN5WrWKcNdQUeCq47fNrJljeHZ8YDMoqz900JcLJAUW0RDTMCs7DXcu6ob3YpWHQN5pj
         MxgcRgZFdqYKrj/le87dmCMrQZsXfgZvKns67C1hqEKSmcZ6LvTmBnZvphVn7aebsrBe
         XwkKOEgJUO8H/YDCOF7FaMrBMN/aSMBZ/ZivCIvOjBrywuiGm3PrCtSNjj6DwGlKw0cU
         MW7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Lc3v8hBHsCf49bYVex16KFSKbVG0hlFgO3dkVBUtLng=;
        b=56r/gccZ1nHTYGnYh907vqGEGBeo32v8GVFPEtFcZditMXMQJovWO/0k0zUa4CgIIS
         b1cEp/KzXT8f1Yfk9yqD1hVr5usw49YjTH41+L0kzQKBxz8m4SczWh+/UaZhaluN0n+T
         /0S4eW5GCv0hlHb9QF0/TOBzUE2+LmZxcFOcOH9NZuZMKv6l4iP5NN2aS1W/8oY6RgoH
         U09wE5uaS84hAFn2KqQ1B0z2cZPDetpeF8iEenUaj+Wj1av1XbWhrgfrCQAM7s6LY9f1
         gFIHjrXt0wAkrSVHYZ+euuIuQI/kSx+AsNwKtXInWhMpJ+pFgZoVvsVsimmBEQWCS1R2
         zYsg==
X-Gm-Message-State: ACgBeo3KNZFpoZbxLK3d3pwwY1A74lkZ4qoLVT4uilXpJpWNPq9lreaB
        tVifW9vRD8sLHPig2b9Ql7a44g==
X-Google-Smtp-Source: AA6agR6Wb3bI3r2PWMumq/hRNZ1lgycNJckeEnHdbCXKdsWIg069biDuqP8AkDqmL9yidwsSFdF9nQ==
X-Received: by 2002:aa7:cc97:0:b0:445:afab:2634 with SMTP id p23-20020aa7cc97000000b00445afab2634mr2190277edt.54.1661414022265;
        Thu, 25 Aug 2022 00:53:42 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:142d:a900:eab:b5b1:a064:1d0d])
        by smtp.gmail.com with ESMTPSA id x22-20020a170906b09600b0073dbfd33a8dsm1491736ejy.21.2022.08.25.00.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Aug 2022 00:53:41 -0700 (PDT)
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
Subject: [PATCH 2/2] mtd: rawnand: marvell: Fix error handle regarding dma_map_sg
Date:   Thu, 25 Aug 2022 09:53:38 +0200
Message-Id: <20220825075338.35338-3-jinpu.wang@ionos.com>
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

dma_map_sg return 0 on error, in case of error return -ENXIO,
also add the dma_unmap_sg as rollback on the following error.

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
Fixes: 02f26ecf8c77 ("mtd: nand: add reworked Marvell NAND controller driver")
Signed-off-by: Jack Wang <jinpu.wang@ionos.com>
---
 drivers/mtd/nand/raw/marvell_nand.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index 2455a581fd70..d9f2f1d0b5ef 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -865,13 +865,19 @@ static int marvell_nfc_xfer_data_dma(struct marvell_nfc *nfc,
 	marvell_nfc_enable_dma(nfc);
 	/* Prepare the DMA transfer */
 	sg_init_one(&sg, nfc->dma_buf, dma_len);
-	dma_map_sg(nfc->dma_chan->device->dev, &sg, 1, direction);
+	ret = dma_map_sg(nfc->dma_chan->device->dev, &sg, 1, direction);
+	if (!ret) {
+		dev_err(nfc->dev, "Could not map DMA S/G list\n");
+		return -ENXIO;
+	}
+
 	tx = dmaengine_prep_slave_sg(nfc->dma_chan, &sg, 1,
 				     direction == DMA_FROM_DEVICE ?
 				     DMA_DEV_TO_MEM : DMA_MEM_TO_DEV,
 				     DMA_PREP_INTERRUPT);
 	if (!tx) {
 		dev_err(nfc->dev, "Could not prepare DMA S/G list\n");
+		dma_unmap_sg(nfc->dma_chan->device->dev, &sg, 1, direction);
 		return -ENXIO;
 	}
 
-- 
2.34.1

