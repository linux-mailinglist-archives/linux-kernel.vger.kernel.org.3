Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEFBB4E1AF6
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 11:01:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243921AbiCTKCW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 06:02:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243865AbiCTKCL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 06:02:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A17B15C859
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:46 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id s72so5591086pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LTwzTKEFt9r8jP7uT4ZdrIfdQ5eoJtObC+eOqWqA/5k=;
        b=pGYJdZ9JGUHqACE7Wo1kH1/4SWHusyLqh7vOs88kB/ANKRJiPeQWbuUhjbD/y+lnVS
         tzzBzXC4gjRl2oNblmq4QK9ok+bnI36pHkw46g5IVLLdSJk8ccfuYLZCiJTs46ipMqiq
         whF44sC6A5eYsxKBn3lv6fIAHXIVA6l5zpUqfYAhmydoKYeXij4Wy18gxdapmqF5cJEC
         zqn0c3VP+A1csESD6B7Hll3y5atjP9mDBh2gtWUPpaEVVUiCU5+YvA6nahYNcPCxT9EB
         hb+2In+w+wgu8SOjngBRLW8trCgmdyJUZuBaANabmmHtk9/hFB4RnxxJHTKcoMHR2obv
         2Kbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LTwzTKEFt9r8jP7uT4ZdrIfdQ5eoJtObC+eOqWqA/5k=;
        b=tdFevm4BTrE3HjdDAn8s8dkX1eVMm5AJJMAkiZ/pfmLhEAxuHXQGovSaZcOVUOFDG2
         l2EgbPDirjoXnv5GyUHZK+WLmXC1QcKIF97tpgXi5/snY56nRmLcgyhcKoS92gpdnjdi
         Mti05RDHGChGRCEcASkcyRbRW+4/PZ8p7nuBB6ZfhS32/iTLi0RWHHLsN6fR47zXH3x0
         OsMyccVAMDHabJAxzuJkmh+CH81/CbLba5nPeyqdC/6tskocmlB+6K3H/tqUBXHFpl/P
         WzmJZZtJGC2sZgZaQCEIbiluVuHpkfC0pLbZVFDS2jvypGKQZFfasyb28FpAK66ZEKwW
         N1aw==
X-Gm-Message-State: AOAM531Nle1I901swhSrbwr9Dydnb8V0I/Tz8uWYcBHnJ10dimrcGbUT
        M6yEeJIIb4ZSrKpUKLmu7Yk=
X-Google-Smtp-Source: ABdhPJzzhsB8eVdLU3zpBDUoZRQHw/S92XAe2joj9yAUpwvC832u0plQ2lx9rIoKi1jxE6IL1aJNkA==
X-Received: by 2002:a05:6a00:3316:b0:4fa:80fd:f3f6 with SMTP id cq22-20020a056a00331600b004fa80fdf3f6mr6014005pfb.65.1647770446175;
        Sun, 20 Mar 2022 03:00:46 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:7978:d40d:86ff:591d])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f791d0115esm16597810pfk.171.2022.03.20.03.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 03:00:45 -0700 (PDT)
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
Subject: [PATCH 2/5] mtd: spinand: gigadevice: add support for GD5FxGQ4xExxG
Date:   Sun, 20 Mar 2022 17:59:58 +0800
Message-Id: <20220320100001.247905-3-gch981213@gmail.com>
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
 GD5F1GQ4RExxG
 GD5F2GQ4{U,R}ExxG

These chips differ from GD5F1GQ4UExxG only in chip ID, voltage
and capacity.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/nand/spi/gigadevice.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index da77ab20296e..85a61d3d8467 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -333,6 +333,36 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ4RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xc1),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ4UExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xd2),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F2GQ4RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_ADDR, 0xc2),
+		     NAND_MEMORG(1, 2048, 128, 64, 2048, 40, 1, 1, 1),
+		     NAND_ECCREQ(8, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq4uexxg_ecc_get_status)),
 	SPINAND_INFO("GD5F1GQ4UFxxG",
 		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE, 0xb1, 0x48),
 		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
-- 
2.35.1

