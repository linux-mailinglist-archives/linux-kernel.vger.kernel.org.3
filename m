Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E654E1AFA
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 11:01:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244067AbiCTKCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 06:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243908AbiCTKCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 06:02:16 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 087E55EDDD
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:54 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q5so1167774plg.3
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HsVJmSPxGv/ua7JkMd1tIRNttw+E7BtumVyOfqfONlU=;
        b=Ne2CBROykIoGHI3CdKLx7jPrmwtAjcB4/mwPHf/2QF2ipEFz7iZFe1E9pcwxJydG3C
         XGM3gu/fg1B9MMMJNIMl7BbBWnyMxB7AVVLqAD7fWMuDPsHYaRm0z0EKwhBUGVnS7p+P
         FJHz6iqsiZ+9D6rqc3dYPTN9pLvxLYjrdg5f2rYQgW7apQpx1fk6CV/KMIWs66/7tVn0
         kXsfYwbcfaBKO3whu0PIW28p1bvpzsXy+SbHYCZjkR6VLQpFJ0HEz4WE64qY103hl+t0
         bH0vXI7MNt9lnGF3f6H5vF7IhHmHnNmjMzobXeOdlqQzO8nGf3CF1Ve2M1mHW32jT2vy
         O0tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HsVJmSPxGv/ua7JkMd1tIRNttw+E7BtumVyOfqfONlU=;
        b=4IoxZR4cMN8eUhilqPPQqsPHvOOLsGM6UuACSVwFuO337iIOpn2nWj12Fga6qbRvwA
         xtfhkbknhOUXIE3PWDXgoZgFNxtvFyBdmFFi70eNwUL+UCBNv97TI8mZiI616tOvh+My
         SuMsUfWvAVUj7//8By4N67lbf99e9QSQirH+0f+/IxYKv2ZRQxGTEKKLHXyzphRXoejw
         J9ycEKBnI3u0ZWxIc9WOj8Wpj9EPvUHyxjZUlzj1qKyMz/+tjzJS+rFiELT1ec2aXzIO
         279Sv0aspq1zLJ8DP6cIqHMH/Ubo+G+kPJFj/DXU9ItIHqFrPTTq28BtrzL+kFHDdM9r
         JyWA==
X-Gm-Message-State: AOAM530kI4onq6GPfxqiJHplH4YpQo0tfegWZGJXEHO1WA5Ai609bJcW
        a16Hfuyvibm8htvjpA0UL4s=
X-Google-Smtp-Source: ABdhPJyDnTvRx0nCssTLA5II5kcWpDTCLY1uagW/jC/lgi7zl63LqJ66wBQcib2k02G7ZK0bP0eogQ==
X-Received: by 2002:a17:903:32c8:b0:154:2161:df5b with SMTP id i8-20020a17090332c800b001542161df5bmr7616196plr.164.1647770453543;
        Sun, 20 Mar 2022 03:00:53 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:7978:d40d:86ff:591d])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f791d0115esm16597810pfk.171.2022.03.20.03.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 03:00:53 -0700 (PDT)
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
Subject: [PATCH 4/5] mtd: spinand: gigadevice: add support for GD5F{2,4}GQ5xExxG
Date:   Sun, 20 Mar 2022 18:00:00 +0800
Message-Id: <20220320100001.247905-5-gch981213@gmail.com>
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
 GD5F2GQ5{U,R}ExxG
 GD5F4GQ6{U,R}ExxG

These chips uses 4 dummy bytes for quad io and 2 dummy bytes for dual io.
Besides that and memory layout, they are identical to their 1G variant.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/nand/spi/gigadevice.c | 48 +++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index d519bb85f0e7..fcd1c4e474a2 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -47,6 +47,14 @@ static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
 		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
 
+static SPINAND_OP_VARIANTS(read_cache_variants_2gq5,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 4, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD(true, 0, NULL, 0));
@@ -393,6 +401,46 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x52),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ5RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x42),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GQ6UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x55),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F4GQ6RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x45),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 2, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_2gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
-- 
2.35.1

