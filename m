Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926234E1AF8
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 11:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243211AbiCTKC0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 06:02:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242983AbiCTKCP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 06:02:15 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 500565C87A
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:50 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id v4so10818744pjh.2
        for <linux-kernel@vger.kernel.org>; Sun, 20 Mar 2022 03:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XaXs2uUeTlaaN4Zoh4ZKfv8MCTbeO7CY8CWLQW7X/3Y=;
        b=Kl7J0NfPNj1Q7lFrfFQesn3uV7mMpCe/gMmoNkEemB4LwrkgelZ5yJAao3wLWaB8kp
         yXf0jb4i8cd2bSvseYEI67tExQf8zoysPvg6aq9XfWA6DWl6WYdoumqGedCJRssKBbub
         NkT+1RDTaL7RG1+3Kbpvjt/nYjSb1JmgxEZvqFcRE+QKrODHANiZe7s3+P/vW9TgfgKV
         HqPzy8wr2CvMBEojRzrF9snaIRhiJ9qJklbSds3j7ejjFcskVD8flYSSqLYiqix3dqo/
         Ry/WfHfJyqjEcycKggLQ2As271Ug6ci31bTjk8PZdLDBZbZ1I3hY+bHdWd4v4eQ+jTto
         rU3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XaXs2uUeTlaaN4Zoh4ZKfv8MCTbeO7CY8CWLQW7X/3Y=;
        b=eATru8z5rRX8XAU7Kogwdla6aT2vt9ljroSCOAGxy2/kDpYEAzgpkZ4iDTMYPpiQCk
         vgELtJQQHmOD0aUZ1cGggluskSbs9Ygtl7Bi0uEcD0IQ1zltD3Qq8cuXhnekcbM0Z9jd
         I2rfkx3NJJ1BGcEl6vZCQMquKCyr++Uf5u/ZD0U/91Abs9D4OdDx4pAcgbZ7ZkI5rx70
         7HMTm5dKTDf7ga4hYJfY3bpZjPmkRwXXz+BY3kkUZqmkH80nXWBZSaQLq+PRuY5RPqo/
         Zc9//AQGvQexiQ2oglhTihY9eR3SsKziVK9inuAr8yhV3a4VXgQyBmSNDq4N7LRH1QyK
         OMUw==
X-Gm-Message-State: AOAM533On3Iqi3Shk07FSoRU1GlNeal3ClRTJab648v6bgFtS2f5+MjV
        Bj9MZVg6ysVvlckvzA//PoM=
X-Google-Smtp-Source: ABdhPJyslDhbeWkQlq0iPyds0Frtwv/X7cV805UOtmZFyfhNGADfYMg+3NysuGyMFVJYg5zmKiK3Tg==
X-Received: by 2002:a17:903:2d0:b0:14d:8a8d:cb1 with SMTP id s16-20020a17090302d000b0014d8a8d0cb1mr7753086plk.50.1647770449860;
        Sun, 20 Mar 2022 03:00:49 -0700 (PDT)
Received: from guoguo-omen.lan ([2001:250:3000:7000:7978:d40d:86ff:591d])
        by smtp.gmail.com with ESMTPSA id m11-20020a056a00080b00b004f791d0115esm16597810pfk.171.2022.03.20.03.00.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Mar 2022 03:00:49 -0700 (PDT)
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
Subject: [PATCH 3/5] mtd: spinand: gigadevice: add support for GD5F1GQ5RExxG
Date:   Sun, 20 Mar 2022 17:59:59 +0800
Message-Id: <20220320100001.247905-4-gch981213@gmail.com>
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

This chip is the 1.8v version of GD5F1GQ5UExxG.

Signed-off-by: Chuanhong Guo <gch981213@gmail.com>
---
 drivers/mtd/nand/spi/gigadevice.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/mtd/nand/spi/gigadevice.c b/drivers/mtd/nand/spi/gigadevice.c
index 85a61d3d8467..d519bb85f0e7 100644
--- a/drivers/mtd/nand/spi/gigadevice.c
+++ b/drivers/mtd/nand/spi/gigadevice.c
@@ -383,6 +383,16 @@ static const struct spinand_info gigadevice_spinand_table[] = {
 		     SPINAND_HAS_QE_BIT,
 		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
 				     gd5fxgq5xexxg_ecc_get_status)),
+	SPINAND_INFO("GD5F1GQ5RExxG",
+		     SPINAND_ID(SPINAND_READID_METHOD_OPCODE_DUMMY, 0x41),
+		     NAND_MEMORG(1, 2048, 128, 64, 1024, 20, 1, 1, 1),
+		     NAND_ECCREQ(4, 512),
+		     SPINAND_INFO_OP_VARIANTS(&read_cache_variants_1gq5,
+					      &write_cache_variants,
+					      &update_cache_variants),
+		     SPINAND_HAS_QE_BIT,
+		     SPINAND_ECCINFO(&gd5fxgqx_variant2_ooblayout,
+				     gd5fxgq5xexxg_ecc_get_status)),
 };
 
 static const struct spinand_manufacturer_ops gigadevice_spinand_manuf_ops = {
-- 
2.35.1

