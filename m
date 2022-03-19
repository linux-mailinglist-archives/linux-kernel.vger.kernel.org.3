Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41D024DE713
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 09:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbiCSIfV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 04:35:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbiCSIfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 04:35:19 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B92EBE036
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 01:33:58 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id e6so6682492pgn.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 01:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8PQKlbtuifCe2sia50BJ6lrE2M1PS4ubrNMMi1Ne9c=;
        b=bfFtFMpcAxaVfh3gkrWqlEq0PnXL0euWimLa+T3aBEH5mwxqjgsrpuZQjag+zmNZLz
         +r8BsOn5CLKF7WlQql1FpniVjZnEnzbOj8WKfgv9XJMrzLj7BVwCFeFYXU29rl0vai7B
         G0uNXAs47kqh7QQ2ymECriz8uuTlKYvvPhXJs+MihE+fctEbHMeqj/d233lTwGu2GFcY
         WhFVtpdLAzrBs2YZvpw5VYM78bJbDBa2XM5wdOUNYAXzAgmmZ+uGHyQIGLipGOOKmWpJ
         q4uYjkABJtjIF3OrBRGqqR75nz5P2wvIsFlxjQ6G5CKL/BlfJluaUO4ZiTfDFVOKuJDG
         ourQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=s8PQKlbtuifCe2sia50BJ6lrE2M1PS4ubrNMMi1Ne9c=;
        b=jCv6UClFccvTH4v15JmoX8FlWRPybfY7rh4IIeyWe5gxuDc4JB7dy37xg5dTtCq4ZE
         Iu19OvG4mV7Y1kZKEpz2GzTDBYVz2DDEwmF4kieTWDiyCXlYNCfArhKfs+z++QpxBRTJ
         dCF9UF2oVoi5vAAlWMvm+tgCnKmuKV67CqDmSt733f3xoSNQ5UICWdHMISwifh46m/bw
         6Rz5jeDpw7RfoR4lA7RF9hoZiIFx3OC5FhbP3Yx/Z3TRZHTGHtCMYhlKLp+pRziSYw49
         xFouD8m7cm6LRFUBd9W7pB0A6MbSj8Db4+eguf9JxfC1xGS0QJsBVcd0SNQFdBogvAxc
         0kxw==
X-Gm-Message-State: AOAM5304RlfaUsa0lvrjkM7aT2Z68T2IE8iLFMqj756V/ulVKL6if9S6
        w1nlmKIWEMSiZSZM1Ij+i74=
X-Google-Smtp-Source: ABdhPJzvPQ5s00j8GuhEw13G6sxP+1nGQ5JUwL/1FT1v3OxYPjLFLpwRxafPNSKIggDmdANj4AkwbQ==
X-Received: by 2002:a63:f94d:0:b0:381:5104:c3d9 with SMTP id q13-20020a63f94d000000b003815104c3d9mr11094175pgk.600.1647678838142;
        Sat, 19 Mar 2022 01:33:58 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:7978:d40d:86ff:591d])
        by smtp.gmail.com with ESMTPSA id g2-20020a056a000b8200b004fa23c8b522sm12306880pfj.156.2022.03.19.01.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Mar 2022 01:33:57 -0700 (PDT)
From:   Chuanhong Guo <gch981213@gmail.com>
To:     linux-mtd@lists.infradead.org
Cc:     Chuanhong Guo <gch981213@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Stefan Roese <sr@denx.de>,
        Reto Schneider <reto.schneider@husqvarnagroup.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH] mtd: spinand: gigadevice: fix Quad IO for GD5F1GQ5UExxG
Date:   Sat, 19 Mar 2022 16:32:59 +0800
Message-Id: <20220319083301.87400-1-gch981213@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Read From Cache Quad IO (EBH) uses 2 dummy bytes on this chip according
to page 23 of the datasheet[0].

[0]: https://www.gigadevice.com/datasheet/gd5f1gq5xexxg/

Fixes: 469b99248985 ("mtd: spinand: gigadevice: Support GD5F1GQ5UExxG")
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/nand/spi/gigadevice.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 1dd1c5898093..f765a394a2d2 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -39,6 +39,14 @@ static SPINAND_OP_VARIANTS(read_cache_variants_f,
 		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(true, 0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(false, 0, 0, NULL, 0));
 
+static SPINAND_OP_VARIANTS(read_cache_variants_q5,
+		SPINAND_PAGE_READ_FROM_CACHE_QUADIO_OP(0, 2, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X4_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_DUALIO_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_X2_OP(0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(true, 0, 1, NULL, 0),
+		SPINAND_PAGE_READ_FROM_CACHE_OP(false, 0, 1, NULL, 0));
+
 static SPINAND_OP_VARIANTS(write_cache_variants,
 		SPINAND_PROG_LOAD_X4(true, 0, NULL, 0),
 		SPINAND_PROG_LOAD(true, 0, NULL, 0));
@@ -339,7 +347,7 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x51),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
 		     NAND_ECCREQ(4, 512),
-		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_q5,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-- 
2.35.1

