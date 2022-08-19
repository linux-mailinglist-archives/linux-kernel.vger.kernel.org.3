Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 233D3599523
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 08:11:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346447AbiHSGIj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 02:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344900AbiHSGIL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 02:08:11 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6FC7C6CC4
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:09 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id s11so4417877edd.13
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 23:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=OzHUmQwcd+nCjF20f8h6cgiTVwPuicRa6w7QZAA1SIg=;
        b=YvXzy4ZZy1mdY4EMhepxkx1ON9GYFpmRW9Ft40fg5ySPmER4WpPEAyH3L2RPcRsDzn
         E3fbrhOX1RZ6y3tlBQK1gEOw3s81guyqOtbmH27tahaoKKVBaXeNpEHk6YF11vQlUI4y
         GJnFXYkXFW6nvVO8SaIE+GRZ1PupQN3KqmS/i5opp1YE2pZzKO8Fiilwqy6WRK0ij+M1
         pu2ShCoE+5XhledK85vKM0BQXjbtLuuesDCNfsvvfiMVj+UfZ6ghPG8gzgGa0P/3cHAe
         lapqf0KVRt2y3d06Mam60j47THi3xFU81mHpIEcUU33+bd+tpRGo+dBzZLdB1iqy/wxF
         4fwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=OzHUmQwcd+nCjF20f8h6cgiTVwPuicRa6w7QZAA1SIg=;
        b=Rrt3++RgYnd5BB2N6QkPdOXTV/4cSvsIoYPvjoTu/XE6kd4qA9ds318o08SBP3X0SP
         2okeNteubC9S1a2VaRZSoAgIKcNJ/qtwsd9QhPZQRGlsTivDkrhR9a7L4ZOt2/G/0nkT
         zr6+HXYOyWTWYk27D6zchjqcBwpOyKr5i4o0Vbxk2J4CHISX6EC9ulabYxCEBJqgXmLx
         E4/GQOnF8RJ3VylOs2X+59liJurcndE23EJ77rPCxrHbDt7ac1tU+m2c5zLYnadzTSKy
         4MSW4M77LBqs/aMLyYXPoEUTLCYrZ5yqmaXzTlcCukEY5HGltgRxSVmdgL+sTQdQI1rp
         oHgQ==
X-Gm-Message-State: ACgBeo2EQkWzRQFFosV0IJRkdV6VR9cJZqaVzhxXtuC+QTf3Rj9De34b
        d0+J7BkgyemjlRyBkc5aWpGWL2wC3d3Hcg==
X-Google-Smtp-Source: AA6agR5DmMBvK+oUIDsQEG+pVfZgLO3Ld7GCkKqrInhA0LiEoWlC+RNyND2neXiQETWHpQprWlyS9g==
X-Received: by 2002:a05:6402:42c3:b0:43d:682f:c0ca with SMTP id i3-20020a05640242c300b0043d682fc0camr4885929edc.334.1660889288038;
        Thu, 18 Aug 2022 23:08:08 -0700 (PDT)
Received: from lb02065.fritz.box ([2001:9e8:143b:fd00:5207:8c7f:747a:b80d])
        by smtp.gmail.com with ESMTPSA id y14-20020a1709063a8e00b0073a644ef803sm1809660ejd.101.2022.08.18.23.08.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Aug 2022 23:08:07 -0700 (PDT)
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
Subject: [PATCH v1 04/19] mtd: rawnand: stm32_fmc2: Fix dma_map_sg error check
Date:   Fri, 19 Aug 2022 08:07:46 +0200
Message-Id: <20220819060801.10443-5-jinpu.wang@ionos.com>
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

