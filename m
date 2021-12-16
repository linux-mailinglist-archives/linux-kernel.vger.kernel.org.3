Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C3B476C0A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhLPIek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234900AbhLPIeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:34:36 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C803C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:35 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id bn20so37375312ljb.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y0Ca0cvudJW/HfTxvd0IREbnHXnhaLoN5nQwo8TiSyA=;
        b=lN9Lgwn1x7plPsJLEVUAFccR+ZVhExtjEsvOTLYUNtDqV0rYwoVtmM+yMV8F0q8RA8
         JDPIZq9E4oeSYxo5yjaGADV39SI0/U1vdtxydnp8v1ndNY1B44U8P8tDJCThwxzDunUI
         kElgwMlR1mpTE5IkZB6O80ui9Lr4/0HRM3KrE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y0Ca0cvudJW/HfTxvd0IREbnHXnhaLoN5nQwo8TiSyA=;
        b=EySWikoDeT0hpha8uMyw/8WZ/hntr8j5GcEaqUDYILMVvzD0ZDvEUSMZnJZ+9oRZZw
         imCJ+MDwRSsV8jRk3V4vjgkyTWmWdpiH/ne5VDkJB2JgLxJB4uYGOR4fipp8gnrPAkXb
         Za42H1/yRW11E9ZO73PWcKUACdtyoZMP9bEKa429ce0vMVNCJxT6qhsHFC0mYlG+py2y
         51FQHy3E4XRFV45EPrtXNaC+GykvbHk9n8r5lMVP3H7JTfOszPVsEPDSSxMigQMeZLLO
         Xru8X8FkxiV3AAlUH3CKiM9kz1RHHaxC0hJnfYBt+sKlcGiQNJsgekM/c8F5JBInIAnp
         bl5Q==
X-Gm-Message-State: AOAM530bj3pHPzijzQXTrONt6De85+ZybAdVSajBFUwtaYmdeAIieCqr
        ZVh4VZ3FcY+1Gb0f8zq6RVm5XTPxstNdlQ==
X-Google-Smtp-Source: ABdhPJyz7ydX/PPTO6UHoqK8B2uKbxpoEIAR55NQAfbLwSlFup5HUvATVkb27MaF4RAxLwktNAGU3w==
X-Received: by 2002:a2e:5c46:: with SMTP id q67mr14656708ljb.271.1639643673455;
        Thu, 16 Dec 2021 00:34:33 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id c2sm985679ljf.50.2021.12.16.00.34.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:34:32 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] mtd: always initialize 'stats' in struct mtd_oob_ops
Date:   Thu, 16 Dec 2021 09:34:16 +0100
Message-Id: <20211216083418.13512-4-kernel@kempniu.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216083418.13512-1-kernel@kempniu.pl>
References: <20211216083418.13512-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As the 'stats' field in struct mtd_oob_ops is used in conditional
expressions, ensure it is always zero-initialized in all such structures
to prevent random stack garbage from being interpreted as a pointer.

Strictly speaking, this problem currently only needs to be fixed for
struct mtd_oob_ops structures subsequently passed to mtd_read_oob().
However, this commit goes a step further and makes all instances of
struct mtd_oob_ops in the tree zero-initialized, in hope of preventing
future problems, e.g. if struct mtd_req_stats gets extended with write
statistics at some point.

Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
Obviously this objective can be achieved in various ways.  I was aiming
for a minimal diff which does the job.

 drivers/mtd/inftlcore.c                 | 6 +++---
 drivers/mtd/mtdswap.c                   | 6 +++---
 drivers/mtd/nand/onenand/onenand_base.c | 4 ++--
 drivers/mtd/nand/onenand/onenand_bbt.c  | 2 +-
 drivers/mtd/nand/raw/nand_bbt.c         | 8 ++++----
 drivers/mtd/nand/raw/sm_common.c        | 2 +-
 drivers/mtd/nftlcore.c                  | 6 +++---
 drivers/mtd/sm_ftl.c                    | 4 ++--
 drivers/mtd/ssfdc.c                     | 2 +-
 drivers/mtd/tests/nandbiterrs.c         | 2 +-
 drivers/mtd/tests/oobtest.c             | 8 ++++----
 drivers/mtd/tests/readtest.c            | 2 +-
 fs/jffs2/wbuf.c                         | 6 +++---
 13 files changed, 29 insertions(+), 29 deletions(-)

diff --git a/drivers/mtd/inftlcore.c b/drivers/mtd/inftlcore.c
index 6b48397c750c..58ca1c21ebe6 100644
--- a/drivers/mtd/inftlcore.c
+++ b/drivers/mtd/inftlcore.c
@@ -136,7 +136,7 @@ static void inftl_remove_dev(struct mtd_blktrans_dev *dev)
 int inftl_read_oob(struct mtd_info *mtd, loff_t offs, size_t len,
 		   size_t *retlen, uint8_t *buf)
 {
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int res;
 
 	ops.mode = MTD_OPS_PLACE_OOB;
@@ -156,7 +156,7 @@ int inftl_read_oob(struct mtd_info *mtd, loff_t offs, size_t len,
 int inftl_write_oob(struct mtd_info *mtd, loff_t offs, size_t len,
 		    size_t *retlen, uint8_t *buf)
 {
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int res;
 
 	ops.mode = MTD_OPS_PLACE_OOB;
@@ -176,7 +176,7 @@ int inftl_write_oob(struct mtd_info *mtd, loff_t offs, size_t len,
 static int inftl_write(struct mtd_info *mtd, loff_t offs, size_t len,
 		       size_t *retlen, uint8_t *buf, uint8_t *oob)
 {
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int res;
 
 	ops.mode = MTD_OPS_PLACE_OOB;
diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index e86b04bc1d6b..ce3796b929e7 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -323,7 +323,7 @@ static int mtdswap_read_markers(struct mtdswap_dev *d, struct swap_eb *eb)
 	struct mtdswap_oobdata *data, *data2;
 	int ret;
 	loff_t offset;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 
 	offset = mtdswap_eb_offset(d, eb);
 
@@ -370,7 +370,7 @@ static int mtdswap_write_marker(struct mtdswap_dev *d, struct swap_eb *eb,
 	struct mtdswap_oobdata n;
 	int ret;
 	loff_t offset;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 
 	ops.ooboffs = 0;
 	ops.oobbuf = (uint8_t *)&n;
@@ -878,7 +878,7 @@ static unsigned int mtdswap_eblk_passes(struct mtdswap_dev *d,
 	loff_t base, pos;
 	unsigned int *p1 = (unsigned int *)d->page_buf;
 	unsigned char *p2 = (unsigned char *)d->oob_buf;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int ret;
 
 	ops.mode = MTD_OPS_AUTO_OOB;
diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/onenand/onenand_base.c
index 958bac54b190..5810104420a2 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -2935,7 +2935,7 @@ static int do_otp_write(struct mtd_info *mtd, loff_t to, size_t len,
 	struct onenand_chip *this = mtd->priv;
 	unsigned char *pbuf = buf;
 	int ret;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 
 	/* Force buffer page aligned */
 	if (len < mtd->writesize) {
@@ -2977,7 +2977,7 @@ static int do_otp_lock(struct mtd_info *mtd, loff_t from, size_t len,
 		size_t *retlen, u_char *buf)
 {
 	struct onenand_chip *this = mtd->priv;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int ret;
 
 	if (FLEXONENAND(this)) {
diff --git a/drivers/mtd/nand/onenand/onenand_bbt.c b/drivers/mtd/nand/onenand/onenand_bbt.c
index def89f108007..c9d106d87ab3 100644
--- a/drivers/mtd/nand/onenand/onenand_bbt.c
+++ b/drivers/mtd/nand/onenand/onenand_bbt.c
@@ -61,7 +61,7 @@ static int create_bbt(struct mtd_info *mtd, uint8_t *buf, struct nand_bbt_descr
 	int startblock;
 	loff_t from;
 	size_t readlen, ooblen;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int rgn;
 
 	printk(KERN_INFO "Scanning device for bad blocks\n");
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bbt.c
index ab630af3a309..817fff3584e3 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -313,7 +313,7 @@ static int scan_read_oob(struct nand_chip *this, uint8_t *buf, loff_t offs,
 			 size_t len)
 {
 	struct mtd_info *mtd = nand_to_mtd(this);
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int res, ret = 0;
 
 	ops.mode = MTD_OPS_PLACE_OOB;
@@ -354,7 +354,7 @@ static int scan_write_bbt(struct nand_chip *this, loff_t offs, size_t len,
 			  uint8_t *buf, uint8_t *oob)
 {
 	struct mtd_info *mtd = nand_to_mtd(this);
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 
 	ops.mode = MTD_OPS_PLACE_OOB;
 	ops.ooboffs = 0;
@@ -416,7 +416,7 @@ static int scan_block_fast(struct nand_chip *this, struct nand_bbt_descr *bd,
 {
 	struct mtd_info *mtd = nand_to_mtd(this);
 
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int ret, page_offset;
 
 	ops.ooblen = mtd->oobsize;
@@ -756,7 +756,7 @@ static int write_bbt(struct nand_chip *this, uint8_t *buf,
 	uint8_t rcode = td->reserved_block_code;
 	size_t retlen, len = 0;
 	loff_t to;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 
 	ops.ooblen = mtd->oobsize;
 	ops.ooboffs = 0;
diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_common.c
index ba24cb36d0b9..6df33e8d77df 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -99,7 +99,7 @@ static const struct mtd_ooblayout_ops oob_sm_small_ops = {
 static int sm_block_markbad(struct nand_chip *chip, loff_t ofs)
 {
 	struct mtd_info *mtd = nand_to_mtd(chip);
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	struct sm_oob oob;
 	int ret;
 
diff --git a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
index 913db0dd6a8d..64d319e959b2 100644
--- a/drivers/mtd/nftlcore.c
+++ b/drivers/mtd/nftlcore.c
@@ -124,7 +124,7 @@ int nftl_read_oob(struct mtd_info *mtd, loff_t offs, size_t len,
 		  size_t *retlen, uint8_t *buf)
 {
 	loff_t mask = mtd->writesize - 1;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int res;
 
 	ops.mode = MTD_OPS_PLACE_OOB;
@@ -145,7 +145,7 @@ int nftl_write_oob(struct mtd_info *mtd, loff_t offs, size_t len,
 		   size_t *retlen, uint8_t *buf)
 {
 	loff_t mask = mtd->writesize - 1;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int res;
 
 	ops.mode = MTD_OPS_PLACE_OOB;
@@ -168,7 +168,7 @@ static int nftl_write(struct mtd_info *mtd, loff_t offs, size_t len,
 		      size_t *retlen, uint8_t *buf, uint8_t *oob)
 {
 	loff_t mask = mtd->writesize - 1;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int res;
 
 	ops.mode = MTD_OPS_PLACE_OOB;
diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index 0cff2cda1b5a..cb182333d635 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -239,7 +239,7 @@ static int sm_read_sector(struct sm_ftl *ftl,
 			  uint8_t *buffer, struct sm_oob *oob)
 {
 	struct mtd_info *mtd = ftl->trans->mtd;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	struct sm_oob tmp_oob;
 	int ret = -EIO;
 	int try = 0;
@@ -323,7 +323,7 @@ static int sm_write_sector(struct sm_ftl *ftl,
 			   int zone, int block, int boffset,
 			   uint8_t *buffer, struct sm_oob *oob)
 {
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	struct mtd_info *mtd = ftl->trans->mtd;
 	int ret;
 
diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 1d05c121904c..04da685c36be 100644
--- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -163,7 +163,7 @@ static int read_physical_sector(struct mtd_info *mtd, uint8_t *sect_buf,
 /* Read redundancy area (wrapper to MTD_READ_OOB */
 static int read_raw_oob(struct mtd_info *mtd, loff_t offs, uint8_t *buf)
 {
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int ret;
 
 	ops.mode = MTD_OPS_RAW;
diff --git a/drivers/mtd/tests/nandbiterrs.c b/drivers/mtd/tests/nandbiterrs.c
index 08084c018a59..98d7508f95b1 100644
--- a/drivers/mtd/tests/nandbiterrs.c
+++ b/drivers/mtd/tests/nandbiterrs.c
@@ -99,7 +99,7 @@ static int write_page(int log)
 static int rewrite_page(int log)
 {
 	int err = 0;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 
 	if (log)
 		pr_info("rewrite page\n");
diff --git a/drivers/mtd/tests/oobtest.c b/drivers/mtd/tests/oobtest.c
index 532997e10e29..13fed398937e 100644
--- a/drivers/mtd/tests/oobtest.c
+++ b/drivers/mtd/tests/oobtest.c
@@ -56,7 +56,7 @@ static void do_vary_offset(void)
 static int write_eraseblock(int ebnum)
 {
 	int i;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int err = 0;
 	loff_t addr = (loff_t)ebnum * mtd->erasesize;
 
@@ -165,7 +165,7 @@ static size_t memffshow(loff_t addr, loff_t offset, const void *cs,
 static int verify_eraseblock(int ebnum)
 {
 	int i;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int err = 0;
 	loff_t addr = (loff_t)ebnum * mtd->erasesize;
 	size_t bitflips;
@@ -260,7 +260,7 @@ static int verify_eraseblock(int ebnum)
 
 static int verify_eraseblock_in_one_go(int ebnum)
 {
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int err = 0;
 	loff_t addr = (loff_t)ebnum * mtd->erasesize;
 	size_t len = mtd->oobavail * pgcnt;
@@ -338,7 +338,7 @@ static int __init mtd_oobtest_init(void)
 	int err = 0;
 	unsigned int i;
 	uint64_t tmp;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	loff_t addr = 0, addr0;
 
 	printk(KERN_INFO "\n");
diff --git a/drivers/mtd/tests/readtest.c b/drivers/mtd/tests/readtest.c
index e70d588083a3..99670ef91f2b 100644
--- a/drivers/mtd/tests/readtest.c
+++ b/drivers/mtd/tests/readtest.c
@@ -47,7 +47,7 @@ static int read_eraseblock_by_page(int ebnum)
 				err = ret;
 		}
 		if (mtd->oobsize) {
-			struct mtd_oob_ops ops;
+			struct mtd_oob_ops ops = { };
 
 			ops.mode      = MTD_OPS_PLACE_OOB;
 			ops.len       = 0;
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index c6821a509481..4061e0ba7010 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -1035,7 +1035,7 @@ int jffs2_check_oob_empty(struct jffs2_sb_info *c,
 {
 	int i, ret;
 	int cmlen = min_t(int, c->oobavail, OOB_CM_SIZE);
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 
 	ops.mode = MTD_OPS_AUTO_OOB;
 	ops.ooblen = NR_OOB_SCAN_PAGES * c->oobavail;
@@ -1076,7 +1076,7 @@ int jffs2_check_oob_empty(struct jffs2_sb_info *c,
 int jffs2_check_nand_cleanmarker(struct jffs2_sb_info *c,
 				 struct jffs2_eraseblock *jeb)
 {
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int ret, cmlen = min_t(int, c->oobavail, OOB_CM_SIZE);
 
 	ops.mode = MTD_OPS_AUTO_OOB;
@@ -1101,7 +1101,7 @@ int jffs2_write_nand_cleanmarker(struct jffs2_sb_info *c,
 				 struct jffs2_eraseblock *jeb)
 {
 	int ret;
-	struct mtd_oob_ops ops;
+	struct mtd_oob_ops ops = { };
 	int cmlen = min_t(int, c->oobavail, OOB_CM_SIZE);
 
 	ops.mode = MTD_OPS_AUTO_OOB;
-- 
2.34.1

