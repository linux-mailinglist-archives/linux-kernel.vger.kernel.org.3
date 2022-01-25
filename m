Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0702F49B262
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:54:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348564AbiAYKwD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:52:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377119AbiAYKsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:48:38 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 329FAC061762
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:48:36 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a28so25813210lfl.7
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:48:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/XpXWRDxxsnU1ew1+sOPH+HV0tZqKpMnA8ASy7NyvWA=;
        b=RDyTADt9neT1YBf6tGutdHCr9W8j7iNFG8/cqerG4Oqq3WNHcYUNgRHGeuCUb0M0LG
         LIPhc9kjRvUb/vDDLfUcGIA9sLW8MfYE7beIqvADv5f5T+tZFXU1Ow64OWVIRUWoJsM2
         KGJalNt2egy9qgiH9/4UifhxNMfff1fmL4/wc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/XpXWRDxxsnU1ew1+sOPH+HV0tZqKpMnA8ASy7NyvWA=;
        b=ESlWZkgvaW90hTzvNrEnyLAtEmpC4iiBNH/ZRKtt9xkSCFoTwV62NxnixGELUnOpW0
         r2w+jgitpRYpPOcP7ZNOoGloOw5WPpL/LCGNbXAG4hqOR3sL/j5OuNR9gtEYOULnpMhj
         jCW5bnJ78HY/yXnYz7x7arr4xoWrP/KkKuhBAnpeIKGVH/cfM4Yjh+G3Nk7aNuzcJObi
         LFmxAngTa6RJ7WluTj4wZdcMrnfUl2T81VSI6eq/343BV/w/LcnWlG23hHaLWnyqV6BL
         xBBwVt/Irv93IKzTjuIp5plQ1SIMI2bBZpnXTNhq5bO0kl4KcOuyW5/cA7p450LezgTs
         POvQ==
X-Gm-Message-State: AOAM530OZgTkxGTr2T/xUMvIAZXOpJyW0tDKlBaQ2VGggV1UDPVRX22v
        l4VijOiePU889jEdwNUENyPMWw==
X-Google-Smtp-Source: ABdhPJw0BQJWB/cT0ygD6lkRhPJ84ybwF0Ebt8lHnMss7GTj7816wXKJ7qmqRm2E/ZuYUC0Rou43OA==
X-Received: by 2002:a05:6512:1588:: with SMTP id bp8mr15880818lfb.407.1643107714529;
        Tue, 25 Jan 2022 02:48:34 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::221])
        by smtp.gmail.com with ESMTPSA id d16sm461896ljj.74.2022.01.25.02.48.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 02:48:33 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/4] mtd: add ECC error accounting for each read request
Date:   Tue, 25 Jan 2022 11:48:21 +0100
Message-Id: <20220125104822.8420-4-kernel@kempniu.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125104822.8420-1-kernel@kempniu.pl>
References: <20220125104822.8420-1-kernel@kempniu.pl>
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
better-informed choices about moving data around.

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
index e7b2ba016d8c..a1975204bcc1 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3817,6 +3817,7 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
 			 struct mtd_oob_ops *ops)
 {
 	struct nand_chip *chip = mtd_to_nand(mtd);
+	struct mtd_ecc_stats old_stats;
 	int ret;
 
 	ops->retlen = 0;
@@ -3830,11 +3831,20 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t from,
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

