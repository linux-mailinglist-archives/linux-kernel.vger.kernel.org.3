Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B84F476C0B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234964AbhLPIen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234911AbhLPIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:34:36 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A126C06173F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:36 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id cf39so36086134lfb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qWY7bmF5KfvvTmKVPoBmn26utRfpp8Gr9eRTtSxe1EU=;
        b=M8fc62CKtWF+BhetBdh/PC9vPFQKrI92A6jr3NT0Zf1dcdCW4vei2ngeFOlSQtQL8I
         6trNOMda/yDrPa/CGMT4ZQJFZW/TG0PKgA2RTOwUgqCf8UTPnd8klzWPu6yU6SwF4jxZ
         0745abnUw7aCAjwTXQamrfHZ8O2oY/4CtyaHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qWY7bmF5KfvvTmKVPoBmn26utRfpp8Gr9eRTtSxe1EU=;
        b=pXEyYSf4ZHuzWQxZl8s8bmSpN1gwp1eFudnfNL0PMcPbHOHk/yY+wNPuKcgQEHXN52
         eDD5n7Rt+k+AAuPFaX5TDOuWwY6MsQc69WDEbALeRAmOPKjDRKbfkDBIaH8x/kNEqmLJ
         C4RmaMvnGbBDVfSzEvCgxlU9Kl5TPsLmtMwjlyaHrTt77Aeq7hPN10+wNH6vESYh5Ium
         pv0Z3Y1opt4DM6HlpMkVqlp+ZxR5SeMh4UMlwci2HoZXZFaWkZj0NmhF7K4vzSliKdpB
         VjSKS+gyNO561GZm6PBe5K6/cPr1V0rdpQCue77bg7/g2DiDTAv8WhSmpp8zgsFIS8WI
         hTgA==
X-Gm-Message-State: AOAM531mY7h3ihKAPxthZjll4ei6aVQQ6Fj8QgyDwklT4ugbUx7sd574
        sy/bXkNcLraBD5VJB4i8+B3uPQ==
X-Google-Smtp-Source: ABdhPJyciHXuVAMopTawY2pAJBPB8FoixP34x2dQX4Hgwqp7YeN4g6i18LolcbOv15PdxW6uXWDinw==
X-Received: by 2002:ac2:5df6:: with SMTP id z22mr13450497lfq.230.1639643674512;
        Thu, 16 Dec 2021 00:34:34 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id c2sm985679ljf.50.2021.12.16.00.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:34:34 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 4/5] mtd: add ECC error accounting for each read request
Date:   Thu, 16 Dec 2021 09:34:17 +0100
Message-Id: <20211216083418.13512-5-kernel@kempniu.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216083418.13512-1-kernel@kempniu.pl>
References: <20211216083418.13512-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend struct mtd_req_stats with two new fields holding the number of
corrected bitflips and uncorrectable errors detected during a read
operation.  This is a prerequisite for ultimately passing those counters
to user space, where they can be useful to applications for making
better-informed choices about moving data around.  Maintaining these
counters is also necessary for the value returned by mtdchar's MEMREAD
ioctl to be determined correctly.

Unlike 'max_bitflips' (which is set - in a common code path - to the
return value of a function called while the MTD device's mutex is held),
these counters have to be maintained in each MTD driver which defines
the '_read_oob' callback because the statistics need to be calculated
while the MTD device's mutex is held.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/mtd/devices/docg3.c             |  8 ++++++++
 drivers/mtd/nand/onenand/onenand_base.c | 12 ++++++++++++
 drivers/mtd/nand/raw/nand_base.c        | 10 ++++++++++
 drivers/mtd/nand/spi/core.c             | 10 ++++++++++
 include/linux/mtd/mtd.h                 |  2 ++
 5 files changed, 42 insertions(+)

diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index 5b0ae5ddad74..3783ae5c6d23 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -871,6 +871,7 @@ static int doc_read_oob(struct mtd_info *mtd, loff_t from,
 	u8 *buf = ops->datbuf;
 	size_t len, ooblen, nbdata, nboob;
 	u8 hwecc[DOC_ECC_BCH_SIZE], eccconf1;
+	struct mtd_ecc_stats old_stats;
 	int max_bitflips = 0;
 
 	if (buf)
@@ -895,6 +896,7 @@ static int doc_read_oob(struct mtd_info *mtd, loff_t from,
 	ret = 0;
 	skip = from % DOC_LAYOUT_PAGE_SIZE;
 	mutex_lock(&docg3->cascade->lock);
+	old_stats = mtd->ecc_stats;
 	while (ret >= 0 && (len > 0 || ooblen > 0)) {
 		calc_block_sector(from - skip, &block0, &block1, &page, &ofs,
 			docg3->reliable);
@@ -966,6 +968,12 @@ static int doc_read_oob(struct mtd_info *mtd, loff_t from,
 	}
 
 out:
+	if (ops->stats) {
+		ops->stats->uncorrectable_errors +=
+			mtd->ecc_stats.failed - old_stats.failed;
+		ops->stats->corrected_bitflips +=
+			mtd->ecc_stats.corrected - old_stats.corrected;
+	}
 	mutex_unlock(&docg3->cascade->lock);
 	return ret;
 err_in_read:
diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 5810104420a2..f66385faf631 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -1440,6 +1440,7 @@ static int onenand_read_oob(struct mtd_info *mtd, loff_t from,
 			    struct mtd_oob_ops *ops)
 {
 	struct onenand_chip *this = mtd->priv;
+	struct mtd_ecc_stats old_stats;
 	int ret;
 
 	switch (ops->mode) {
@@ -1453,12 +1454,23 @@ static int onenand_read_oob(struct mtd_info *mtd, loff_t from,
 	}
 
 	onenand_get_device(mtd, FL_READING);
+
+	old_stats = mtd->ecc_stats;
+
 	if (ops->datbuf)
 		ret = ONENAND_IS_4KB_PAGE(this) ?
 			onenand_mlc_read_ops_nolock(mtd, from, ops) :
 			onenand_read_ops_nolock(mtd, from, ops);
 	else
 		ret = onenand_read_oob_nolock(mtd, from, ops);
+
+	if (ops->stats) {
+		ops->stats->uncorrectable_errors +=
+			mtd->ecc_stats.failed - old_stats.failed;
+		ops->stats->corrected_bitflips +=
+			mtd->ecc_stats.corrected - old_stats.corrected;
+	}
+
 	onenand_release_device(mtd);
 
 	return ret;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_base.c
index b3a9bc08b4bb..902a88a4caaf 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3750,6 +3750,7 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
 			 struct mtd_oob_ops *ops)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_ecc_stats old_stats;
 	int ret;
 
 	ops->retlen = 0;
@@ -3763,11 +3764,20 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
 	if (ret)
 		return ret;
 
+	old_stats = mtd->ecc_stats;
+
 	if (!ops->datbuf)
 		ret = nand_do_read_oob(chip, from, ops);
 	else
 		ret = nand_do_read_ops(chip, from, ops);
 
+	if (ops->stats) {
+		ops->stats->uncorrectable_errors +=
+			mtd->ecc_stats.failed - old_stats.failed;
+		ops->stats->corrected_bitflips +=
+			mtd->ecc_stats.corrected - old_stats.corrected;
+	}
+
 	nand_release_device(chip);
 	return ret;
 }
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index 2c8685f1f2fa..5c956c8cae9f 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -629,6 +629,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 {
 	struct spinand_device *spinand = mtd_to_spinand(mtd);
 	struct nand_device *nand = mtd_to_nanddev(mtd);
+	struct mtd_ecc_stats old_stats;
 	unsigned int max_bitflips = 0;
 	struct nand_io_iter iter;
 	bool disable_ecc = false;
@@ -640,6 +641,8 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 
 	mutex_lock(&spinand->lock);
 
+	old_stats = mtd->ecc_stats;
+
 	nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 		if (disable_ecc)
 			iter.req.mode = MTD_OPS_RAW;
@@ -662,6 +665,13 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_t from,
 		ops->oobretlen += iter.req.ooblen;
 	}
 
+	if (ops->stats) {
+		ops->stats->uncorrectable_errors +=
+			mtd->ecc_stats.failed - old_stats.failed;
+		ops->stats->corrected_bitflips +=
+			mtd->ecc_stats.corrected - old_stats.corrected;
+	}
+
 	mutex_unlock(&spinand->lock);
 
 	if (ecc_failed && !ret)
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index f976aabcb378..45a0c20305b0 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -41,6 +41,8 @@ struct mtd_erase_region_info {
 };
 
 struct mtd_req_stats {
+	unsigned int uncorrectable_errors;
+	unsigned int corrected_bitflips;
 	unsigned int max_bitflips;
 };
 
-- 
2.34.1

