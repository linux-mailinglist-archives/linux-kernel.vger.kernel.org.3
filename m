Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7675994FA
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346561AbiHSGIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345268AbiHSGIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:12 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28AE723F
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:11 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id kb8so6993326ejc.4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=zxM42Y9uEm9HYeKUiC4xFIG7yPyezX+CS6v5K5nZU8U=;
        b=DP1gLMIPVWB7ZYRop6oPt9NMumqgtsCGEOsM4vtsybhCRs5Dzp0CsQyLxargAIZINe
         ODmtV6u0iTI76C8ByXG7V1u+ccKF2e4qad3XsUzDIL6hye4OHE21JrXHHI932pE31adz
         R5XPcDmOIlBlW11EAcwZZ7lNflcuox+CFV9XjBDIN+0uCxGBFeyNFx2ldpUzzJncXSE0
         1qtTuvw6sM8xrgjoFNXPjTWjVc/9E1DWxISdgmYV5jaFfPcDxncJ6b7lwd3QEA0UaswE
         kDGyILqBu+97OQjN5PmYrcF4nGuApHE1R3j50OpsFP7F3eX1tJg1XxbfZIv3QdZxdek/
         84fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=zxM42Y9uEm9HYeKUiC4xFIG7yPyezX+CS6v5K5nZU8U=;
        b=08Y5u+r5Zd7kTGCj4urtUaA/TXR/5whchVIpz56yvsuf9Eick3WA90QiadIkDTZoKX
         PFXN/cGKCOuiANIrjWGX3oTt9tw1NM1V5pOG8gII+bWIDxMwnHDVvcBbZgAaRkg857it
         z44pg/iqOEUwnnPzSLbqV51Scvmi7Owps026p7jhJJUIveJgKduas9LHJOKT/gIsROot
         Rigr52wC0FEw9gHeY35DXhYBlCUO6Z4sz4b0HP7Lyi0zzL7unD67bVflsvYB5J1oBlzc
         eQx5sDpLcwDymF+poYKfajwlVL/V1SASJwJSCrpdy+MOqI05LhuatJEZdKChkUhcPUyG
         Er1w==
X-Gm-Message-State: ACgBeo2792JA5mL7GlnffrgqZgjDV/10IbyVDTfrJ55EKajE4cExMGt9
        37jfcK44mlGLEv4uSyEJfRlxewDiP+qndg==
X-Google-Smtp-Source: AA6agR7AxvNaR5kMACgc+5EvILcU4znfyr/yCo9fq+C5k8P8mQOI0CDjA9l2YlHqPOv1CkuTKAdmLQ==
X-Received: by 2002:a17:906:5d07:b0:738:b86d:df3d with SMTP id g7-20020a1709065d0700b00738b86ddf3dmr3767679ejt.617.1660889289504;
        Thu, 18 Aug 2022 23:08:09 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:08 -0700 (PDT)
From:   Jack Wang <jinpu.wang@ionos.com>
To:     linux-kernel@vger.kernel.org
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Cai Huoqing <cai.huoqing@linux.dev>,
        linux-mtd@lists.infradead.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 05/19] mtd: rawnand: marvell: Fix error handle regarding dma_map_sg
Date:   Fri, 19 Aug 2022 08:07:47 +0200
Message-Id: <20220819060801.10443-6-jinpu.wang@ionos.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220819060801.10443-1-jinpu.wang@ionos.com>
References: <20220819060801.10443-1-jinpu.wang@ionos.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

dma_map_sg return 0 on error, in case of error return -EIO,
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

