Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE7E04E1AF9
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 11:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243281AbiCTKCR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 06:02:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243836AbiCTKCF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 06:02:05 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 155CD5C859
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:43 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id p8so13141266pfh.8
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oNRpcSr1HaFOuyEkI71aW2rwKdw2XVGrF5tMoGdemZ8=;
        b=IbNfRmZHJZCE7z4L1cQKmWItxXNZKLG9m1P9OGy57MocjhaYUB39Sa1NsCz+IBDpff
         /VBGPslXIhi7M8zHe/Uh+l0yRC9HyUWVSV1BiJl2pr/AplZ4+KNTb35liEX8kqLvjmP3
         6OqwxlGTaaAl/hZcYBddeNf3H30cfS0LlVcz4i8Xm+eR0rMre13a/ClLEWAJm7gVhIUr
         BHU6SqS7BCn/9vqdmvUjcMxsk0rXiqv76yYt55qR+ceqanNAKuQdrSu+9fgsX0Ne+sEX
         r1xmQuI5DBuyvR0In2fC8Z6ZxcKjo6ioPZPp9gcV+acZ+07Wvr8xu3WLuAKfx6/+DZhl
         i2OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oNRpcSr1HaFOuyEkI71aW2rwKdw2XVGrF5tMoGdemZ8=;
        b=MDGoTYMuoilHK6zl2WFWvVktxf/otdj5fe9OJ5jEo6KFb7hi6S8E+U6TlFR+jcUn8T
         O0aTDomn9FKvDtE/JB0i0KHdJ/vZTp/E0mzCPQoN77Wli+duUHhArrED3TddJ8YSc8mZ
         lFuieDFwFHPZ7FrVStyO91dlgpL7Ft0Ll4yoT3MZy++p05g4FQEMVWVttWsmInmewRgc
         EUtLrpaAUeE3W6duRR/3wDN2vqGZXI23MKG9Mk9Yb8M46QdbhXORyckIYRxBYaC3RctU
         F+4F4HAnsVPM5UjLyEcgmfqQzJ05qEEIs6cULwkWzFge6ODo/F1XkZkszgZ6/0Lak9Lc
         4EIg==
X-Gm-Message-State: AOAM533NYFSUXeLnVjjPBjOsPczPOByb+BNBVOzTHeV7oaK4c0GjoAS+
        DngpV8em0k5iqHylPc6Do5A=
X-Google-Smtp-Source: ABdhPJy1jAB6M/0BYwvfn+wZFlkzDqzo35ld9EnV9h5hZLUUT+vMKazYpOuKA9o/6uMdR6crPGwp6Q==
X-Received: by 2002:a63:4526:0:b0:380:7c34:fc84 with SMTP id s38-20020a634526000000b003807c34fc84mr14539438pga.2.1647770442511;
        Sun, 20 Mar 2022 03:00:42 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:7978:d40d:86ff:591d])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f791d0115esm16597810pfk.171.2022.03.20.03.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 03:00:42 -0700 (PDT)
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
Subject: [PATCH 1/5] mtd: spinand: gigadevice: fix Quad IO for GD5F1GQ5UExxG
Date:   Sun, 20 Mar 2022 17:59:57 +0800
Message-Id: <20220320100001.247905-2-gch981213@gmail.com>
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

Read From Cache Quad IO (EBH) uses 2 dummy bytes on this chip according
to page 23 of the datasheet[0].

[0]: https://www.gigadevice.com/datasheet/gd5f1gq5xexxg/

Fixes: 469b99248985 ("mtd: spinand: gigadevice: Support GD5F1GQ5UExxG")
Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/nand/spi/gigadevice.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 1dd1c5898093..da77ab20296e 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -39,6 +39,14 @@ static SPINAND_OP_VARIANTS(read_cache_variants_f,
 		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(true, 0, 1, NULL, 0),
 		SPINAND_PAGE_READ_FROM_CACHE_OP_3A(false, 0, 0, NULL, 0));
 
+static SPINAND_OP_VARIANTS(read_cache_variants_1gq5,
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
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
 					      &write_cache_variants,
 					      &update_cache_variants),
 		     SPINAND_HAS_QE_BIT,
-- 
2.35.1

