Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA7EC501789
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353668AbiDNPkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354236AbiDNOlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:41:51 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 200C5CD664
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:34:45 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id i184so4461210pgc.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J8XpPS8fF6//JWfsSd8RX2fW6+WaMSPbmBOhZGi8MbQ=;
        b=jx2Nrf2VkS8q76IMPSON7sYZumK4VxWREXX+8G8xMt0+IvbBEkw28ugTypfP52JZU+
         kPl43iO94PcgSFCd5MbuFZw/nWXCXCGJtGJfFZeXdctU46OqDsNjSmkJG493x5tFwsFm
         pnYkQFt/b6NHNwsYP48D8e+uju9FirrxS6WA2EZPt4HUMba+fDeRY7bOlcD15rDnEtaS
         NCYD7lm+BuSYz8FNYYizuPLVDtWXkVjPsV4p39/PGezqC30DFTgHDNuoWnRrI1bHJjVK
         juG6/AkukOFByjK25Vex48lwNP0kt8dWUTiRJ0RK2TlUdpMjF5iltfoyjN2ZjCiQhl35
         f1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J8XpPS8fF6//JWfsSd8RX2fW6+WaMSPbmBOhZGi8MbQ=;
        b=L/D2t2xJdlm490zAKEbjdZg2CoQCQlJ3x9pRNz0uIqURB6X4VAdRh11NVxBUigrRTj
         hMOJzlFm8C6Noa5cSCm+rvo5YbSRESXCuMD1+HNnF2QH5jMD+NqU3nUcissK3lm0JWUs
         RB3kfXXGLNVIM/oldKsd3wDIWQ5A9qnUQPrHxkT/ufM7lRBQZplA0LwWCd5qsOzaXh5S
         mRHS3oLkgR7IdoIJMyO9GFmgFkstUffzSeNDwZMJ40bXd5DOSzI8OjtnquNk9W15DUsd
         CUkLsPdZ1pZ6oobDcO+bH1agNxKA7NrW3BKjR52MlsUnT0mDn4FV5suOg6bPsUQfiAii
         +bPg==
X-Gm-Message-State: AOAM531Pbr4XSw59qLMrIg4NCICtbuJtXXL9I/yCQ9HwU+ZE2VyAs7TN
        cQENY8rIowgbHPW/gLXfE8A=
X-Google-Smtp-Source: ABdhPJxg6LkhK/f+4dkzBNst6mLyHzIY5tyPpKXHH/ea82lbmQG9WigxzTBaAvxHsT91GmLMfKHTnA==
X-Received: by 2002:a05:6a02:206:b0:399:3c9:f465 with SMTP id bh6-20020a056a02020600b0039903c9f465mr2640670pgb.388.1649946885024;
        Thu, 14 Apr 2022 07:34:45 -0700 (PDT)
Received: from guoguo-omen.lan ([2401:c080:1400:4da2:b701:47d5:9291:4cf9])
        by smtp.gmail.com with ESMTPSA id k5-20020a17090ac50500b001cd5ffcca96sm4411017pjt.27.2022.04.14.07.34.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 07:34:44 -0700 (PDT)
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
Subject: [PATCH 2/2] mtd: spinand: probe Winbond W25N01GV/W using param page
Date:   Thu, 14 Apr 2022 22:34:26 +0800
Message-Id: <20220414143426.723168-3-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220414143426.723168-1-gch981213@gmail.com>
References: <20220414143426.723168-1-gch981213@gmail.com>
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
 drivers/mtd/nand/spi/onfi.c    |  4 +++-
 drivers/mtd/nand/spi/winbond.c | 25 ++++++++++++++++---------
 include/linux/mtd/spinand.h    |  3 +++
 3 files changed, 22 insertions(+), 10 deletions(-)

diff --git a/drivers/mtd/nand/spi/onfi.c b/drivers/mtd/nand/spi/onfi.c
index 5cc888e3d038..27484e0cd22d 100644
--- a/drivers/mtd/nand/spi/onfi.c
+++ b/drivers/mtd/nand/spi/onfi.c
@@ -141,7 +141,9 @@ static void nand_bit_wise_majority(const void **srcbufs, unsigned int nsrcbufs,
 	}
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

