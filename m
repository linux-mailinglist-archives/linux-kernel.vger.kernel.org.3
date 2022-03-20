Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E468F4E1AFB
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 11:02:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244002AbiCTKCk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 06:02:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243978AbiCTKCX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 06:02:23 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 316055D667
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id b8so10795862pjb.4
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lTwx4YLysA2ZvSXaGhcB3X5ZKUi0dLU+JyUgnYrwMfs=;
        b=dKGppdpDoq5rZs1MXpORL3y14bsHd6xrmCAEsK9IVGDZ/BJ0jpZXHNAUaCUK+jtX7g
         YbsdfZFhJ7hBhyeZ8qfwQ68rj591nbnt7pqxJQQic3PEOwX6wGFtkxiX8Do1eg+FuHks
         HQ/o+9a1qhiQI4Jz5O2jhkotosPyEVPqZzw3hPpZRlZkWsEebGCH5S0BPJ5g5pn7nTWK
         Jep5htQyjvQuE2KMRoB8Si/X6tOuVtYvmF+MC9QVJZe53h4tneNG73Ukk5kDBSc9AoZP
         pHIeTt9MUd1jUH55vOPd7XaWk9j0XShfrP50FY+cYkN081OFq7MpksqM7bzBCCnBvDta
         oyPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lTwx4YLysA2ZvSXaGhcB3X5ZKUi0dLU+JyUgnYrwMfs=;
        b=eLbpHw0MH8+mWm1cmXU0gtLc5si7XCxWIzv0pWxjZ0z5QUBlArk8HoKtbVhcjDK1+m
         R0tCv3vVCNbNvjuN0NMmTbsaKizeJxqa7JTRXipoYHtGmS6e/ZJLorr8E2vk/ZJ5h7Lz
         DWqRhoYOXu5HPaQrIKunymJ+zY7Mm4ioXawxJMlDpDegxpXDSg/bMwWJdAXMCglv6xPs
         R6cxE4+trNYXOAlG8p9UkbsSTX5bF5HYk4NqPC8xmrZz/dDL6IRCWmllbqOh0l3kIqgN
         ynDvI2Zy4dXC3p3D0wAg58xjdAxchzRhii4awAqAmojOSR6WAGp5IgocJhWUiZVz3aAy
         FbXw==
X-Gm-Message-State: AOAM531yOHCxM8t5xdA5Qt+9sDMh2QT9v7Y2SFS4lLNJgVpn2CapA/PG
        DT7lOrup1RkK5ohmXoJXeyo=
X-Google-Smtp-Source: ABdhPJx2A8BE9AU35FPb3qlCeRo9SMZJlicNYgmyllVs+GMbjQNgpcCYTiejVdh4/FJMhlPZ6Gboqw==
X-Received: by 2002:a17:902:b694:b0:153:1d9a:11a5 with SMTP id c20-20020a170902b69400b001531d9a11a5mr7727950pls.151.1647770457206;
        Sun, 20 Mar 2022 03:00:57 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:7978:d40d:86ff:591d])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f791d0115esm16597810pfk.171.2022.03.20.03.00.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 03:00:57 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Stefan Roese <sr@denx.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 5/5] mtd: spinand: gigadevice: add support for GD5FxGM7xExxG
Date:   Sun, 20 Mar 2022 18:00:01 +0800
Message-Id: <20220320100001.247905-6-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220320100001.247905-1-gch981213@gmail.com>
References: <20220320100001.247905-1-gch981213@gmail.com>
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

Add support for:
 GD5F{1,2}GM7{U,R}ExxG
 GD5F4GM8{U,R}ExxG

These are new 27nm counterparts for the GD5FxGQ4 chips from GigaDevice
with 8b/512b on-die ECC capability.
These chips (and currently supported GD5FxGQ5 chips) have QIO DTR
instruction for reading page cache. It isn't added in this patch because
I don't have a DTR spi controller for testing.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/nand/spi/gigadevice.c | 60 +++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index fcd1c4e474a2..6b043e24855f 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -441,6 +441,66 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GM7UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x91),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GM7RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x81),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GM7UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x92),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GM7RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x82),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GM8UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x95),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GM8RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x85),
+		     NAND_MEMORG(1, 2048, 128, 64, 4096, 80, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
-- 
2.35.1

