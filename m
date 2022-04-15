Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D9A850210E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 05:50:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349293AbiDODwI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 23:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349240AbiDODvo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 23:51:44 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070839A9AB
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:49:08 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id c23so6288040plo.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 20:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hmXe1JnisYjIy8E3ctv5eLkxXX1YzruQ3DOG/Iu3yuw=;
        b=b/yYhWtksjk3exw7rSoqjIkeOofJYEP5CgsOJkjkYUZBZAFlAsRtUUFTgiUeVy3yKF
         AM1Ooe0GXd2xMR/8a8Qc8v5DRM3sq+IMC5BIa7jBY4ExR4mNjBS+kEla4kEER1WwKqCr
         mXLEupITf2Qkng+472V44axDCkP7C0RV089LF8BmqZ0XlGSpkTvBVPoWM9d5G654Ps8R
         J5YYf1JwO3g6Viwwm+1CeKXprslSbCNdriAPG/pv79bDLpQfoSZhbyMctp23K6F/P1Lp
         QAUzdCJvDatRxT8r9n4DhpxaLRVtFyR0luR2a5DaPIyCMLEJ2rD0ohp7/Fi/EDWamgae
         cXog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hmXe1JnisYjIy8E3ctv5eLkxXX1YzruQ3DOG/Iu3yuw=;
        b=iemmrzFZ/h9QwSG2g/h4f294lTPxVIuCSa/mHweZ/li78hWcFayPlx/D58rfnfZK8L
         eto9r6JlaZ8w7ba01ATk/ZeDkkGm1aOSOD6vPyBPY9591540vfTEiBad17Lj3wdMxb77
         t/y67pJ8A5GsBF/htfjIO0Cmh+srtvtB4EBpbN/7TS7hZSoXx+HO1uf2RP7pithAKRmo
         E+R6sMP5sps9vwN8lopH4zcFHYnV8YwGh9JhJxHxov3tJfdDUUe9d7rGZYVyDFJsDjnV
         6sW8Ih5TNrdLFX9w5Aw7BTtHXhRcKnJawQtH3F+yN1QeCRR9txCVWjwpDYFNaVFxSq2q
         aiHQ==
X-Gm-Message-State: AOAM532rPcmopOUPn1XSSWiXpzxvJfCQ9ZQQBJFoii/fE+XIq1b2kLNj
        kYTjfT8rAEAI559N5dSoGEI=
X-Google-Smtp-Source: ABdhPJwG/IiJivi3KNf7cYN8eCaNCZZrwpo7X42fMk+AI66iUpJnCF7j8NSW42TdYA/40tUEUjVhzg==
X-Received: by 2002:a17:902:e891:b0:158:8b58:b94 with SMTP id w17-20020a170902e89100b001588b580b94mr15047555plg.161.1649994547585;
        Thu, 14 Apr 2022 20:49:07 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id ng17-20020a17090b1a9100b001c9f79927bfsm7426380pjb.25.2022.04.14.20.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 20:49:07 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        Daniel Palmer <daniel@0x0f.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 3/3] mtd: spinand: probe Winbond W25N01GV/W using param page
Date:   Fri, 15 Apr 2022 11:48:44 +0800
Message-Id: <20220415034844.1024538-4-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415034844.1024538-1-gch981213@gmail.com>
References: <20220415034844.1024538-1-gch981213@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The JEDEC ID of EFAA21 is assigned to both W25N01G and W25N01K.
Probing the chip with JEDEC ID isn't reliable anymore. Use parameter
page instead.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
Change since v1: none

 drivers/mtd/nand/spi/onfi.c    |  4 +++-
 drivers/mtd/nand/spi/winbond.c | 25 ++++++++++++++++---------
 include/linux/mtd/spinand.h    |  3 +++
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/spi/onfi.c b/drivers/mtd/nand/spi/onfi.c
index 6d3a7e7c4f6e..45447112a96d 100644
--- a/drivers/mtd/nand/spi/onfi.c
+++ b/drivers/mtd/nand/spi/onfi.c
@@ -80,7 +80,9 @@ static bool spinand_onfi_validate(const struct nand_onfi_params *p)
 	return crc == le16_to_cpu(p->crc);
 }
 
-static const struct spinand_manufacturer *spinand_onfi_manufacturers[] = {};
+static const struct spinand_manufacturer *spinand_onfi_manufacturers[] = {
+	&winbond_onfi_spinand_manufacturer,
+};
 
 static const struct spinand_onfi_info *
 spinand_onfi_chip_match(struct nand_onfi_params *p,
diff --git a/drivers/mtd/nand/spi/winbond.c b/drivers/mtd/nand/spi/winbond.c
index 76684428354e..601316c80b3e 100644
--- a/drivers/mtd/nand/spi/winbond.c
+++ b/drivers/mtd/nand/spi/winbond.c
@@ -85,15 +85,15 @@ static const struct spinand_info winbond_spinand_table[] = {
 		     0,
 		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL),
 		     SPINAND_SELECT_TARGET(w25m02gv_select_target)),
-	SPINAND_INFO("W25N01GV",
-		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0xaa),
-		     NAND_MEMORG(1, 2048, 64, 64, 1024, 20, 1, 1, 1),
-		     NAND_ECCREQ(1, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
-					      &write_cache_variants,
-					      &update_cache_variants),
-		     0,
-		     SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
+};
+
+static const struct spinand_onfi_info winbond_spinand_onfi_table[] = {
+	SPINAND_ONFI_INFO(SPINAND_ONFI_MODELS("W25N01GV", "W25N01GW"),
+			  SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+						   &write_cache_variants,
+						   &update_cache_variants),
+			  0,
+			  SPINAND_ECCINFO(&w25m02gv_ooblayout, NULL)),
 };
 
 static int winbond_spinand_init(struct spinand_device *spinand)
@@ -125,3 +125,10 @@ const struct spinand_manufacturer winbond_spinand_manufacturer = {
 	.nchips = ARRAY_SIZE(winbond_spinand_table),
 	.ops = &winbond_spinand_manuf_ops,
 };
+
+const struct spinand_manufacturer winbond_onfi_spinand_manufacturer = {
+	.name = "Winbond",
+	.onfi_chips = winbond_spinand_onfi_table,
+	.nchips = ARRAY_SIZE(winbond_spinand_onfi_table),
+	.ops = &winbond_spinand_manuf_ops,
+};
diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index dc218082d773..610320b03773 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -268,6 +268,9 @@ extern const struct spinand_manufacturer paragon_spinand_manufacturer;
 extern const struct spinand_manufacturer toshiba_spinand_manufacturer;
 extern const struct spinand_manufacturer winbond_spinand_manufacturer;
 
+/* SPI NAND manufacturers with ONFI parameter page support */
+extern const struct spinand_manufacturer winbond_onfi_spinand_manufacturer;
+
 /**
  * struct spinand_op_variants - SPI NAND operation variants
  * @ops: the list of variants for a given operation
-- 
2.35.1

