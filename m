Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09225560112
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbiF2NNe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:13:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233556AbiF2NNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:13:23 -0400
X-Greylist: delayed 906 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 29 Jun 2022 06:13:20 PDT
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED998AE
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656507467; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=WsGnRTckF0BGKXrSKcAI/VLJM8pMwjP4cXPCLbWL1hwCijxuAGvJTyKS8MbngdCYCrVvIzEqkuSwm2L/Xy3aakvUfJ9JjKIhZUo6AuAZMWq/E3QEvOgOS3x2yL5cvMvnVKMecK8BJHliCbRckSdfAC1WwVIvrg+jDweqtXwNqHM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1656507467; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=9nM6W6jGheZLc3UdqNpDF5frp0g4zihbSyyBkeKQDKU=; 
        b=NvFrVDQpk3L5QwnP8lGR5mJEQQneKgqs/lZrOMDvITPIQGSajggCHxg1bl6ja32YyALaab+oCNz5ZEPyP94/iaDYSiSFnTAGbYeTDijR//lbtFo1dG66S33VQQYgTVd1IctmjcQIfoOXfttGAV0NnHM6p664m+BnMElWTo681SE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=kempniu.pl;
        spf=pass  smtp.mailfrom=kernel@kempniu.pl;
        dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656507467;
        s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=9nM6W6jGheZLc3UdqNpDF5frp0g4zihbSyyBkeKQDKU=;
        b=QItxOZ/sLdh6Sr9ovmcHtHUPyESls9o+NgV5VX/vti36nGGI//G9UlvR3xUyGJy2
        eBRfLUUIKT9JYqt4KIOhm3z3rM2bFW2i9y3a2Hl5kGbpc5HnPaQSO9j4IsPWmPAiy0s
        5NYasPLTvaYZhEBnMIxnGpPD/f9vMoF/HwEY0vyI=
Received: from larwa.hq.kempniu.pl (212.180.138.61 [212.180.138.61]) by mx.zoho.eu
        with SMTPS id 1656507466730434.1905891921904; Wed, 29 Jun 2022 14:57:46 +0200 (CEST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20220629125737.14418-3-kernel@kempniu.pl>
Subject: [PATCH v4 2/4] mtd: always initialize 'stats' in struct mtd_oob_ops
Date:   Wed, 29 Jun 2022 14:57:35 +0200
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629125737.14418-1-kernel@kempniu.pl>
References: <20220629125737.14418-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Signed-off-by: Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempniu.pl>
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
@@ -136,7 +136,7 @@ static void inftl_remove_dev(struct mtd_blktrans_dev *d=
ev)
 int inftl_read_oob(struct mtd_info *mtd, loff_t offs, size_t len,
 =09=09   size_t *retlen, uint8_t *buf)
 {
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int res;
=20
 =09ops.mode =3D MTD_OPS_PLACE_OOB;
@@ -156,7 +156,7 @@ int inftl_read_oob(struct mtd_info *mtd, loff_t offs, s=
ize_t len,
 int inftl_write_oob(struct mtd_info *mtd, loff_t offs, size_t len,
 =09=09    size_t *retlen, uint8_t *buf)
 {
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int res;
=20
 =09ops.mode =3D MTD_OPS_PLACE_OOB;
@@ -176,7 +176,7 @@ int inftl_write_oob(struct mtd_info *mtd, loff_t offs, =
size_t len,
 static int inftl_write(struct mtd_info *mtd, loff_t offs, size_t len,
 =09=09       size_t *retlen, uint8_t *buf, uint8_t *oob)
 {
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int res;
=20
 =09ops.mode =3D MTD_OPS_PLACE_OOB;
diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index dc7f1532a37f..680366616da2 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -323,7 +323,7 @@ static int mtdswap_read_markers(struct mtdswap_dev *d, =
struct swap_eb *eb)
 =09struct mtdswap_oobdata *data, *data2;
 =09int ret;
 =09loff_t offset;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
=20
 =09offset =3D mtdswap_eb_offset(d, eb);
=20
@@ -370,7 +370,7 @@ static int mtdswap_write_marker(struct mtdswap_dev *d, =
struct swap_eb *eb,
 =09struct mtdswap_oobdata n;
 =09int ret;
 =09loff_t offset;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
=20
 =09ops.ooboffs =3D 0;
 =09ops.oobbuf =3D (uint8_t *)&n;
@@ -878,7 +878,7 @@ static unsigned int mtdswap_eblk_passes(struct mtdswap_=
dev *d,
 =09loff_t base, pos;
 =09unsigned int *p1 =3D (unsigned int *)d->page_buf;
 =09unsigned char *p2 =3D (unsigned char *)d->oob_buf;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int ret;
=20
 =09ops.mode =3D MTD_OPS_AUTO_OOB;
diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/one=
nand/onenand_base.c
index 958bac54b190..5810104420a2 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -2935,7 +2935,7 @@ static int do_otp_write(struct mtd_info *mtd, loff_t =
to, size_t len,
 =09struct onenand_chip *this =3D mtd->priv;
 =09unsigned char *pbuf =3D buf;
 =09int ret;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
=20
 =09/* Force buffer page aligned */
 =09if (len < mtd->writesize) {
@@ -2977,7 +2977,7 @@ static int do_otp_lock(struct mtd_info *mtd, loff_t f=
rom, size_t len,
 =09=09size_t *retlen, u_char *buf)
 {
 =09struct onenand_chip *this =3D mtd->priv;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int ret;
=20
 =09if (FLEXONENAND(this)) {
diff --git a/drivers/mtd/nand/onenand/onenand_bbt.c b/drivers/mtd/nand/onen=
and/onenand_bbt.c
index b17315f8e1d4..d7fe35bc45cb 100644
--- a/drivers/mtd/nand/onenand/onenand_bbt.c
+++ b/drivers/mtd/nand/onenand/onenand_bbt.c
@@ -61,7 +61,7 @@ static int create_bbt(struct mtd_info *mtd, uint8_t *buf,=
 struct nand_bbt_descr
 =09int startblock;
 =09loff_t from;
 =09size_t readlen;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int rgn;
=20
 =09printk(KERN_INFO "Scanning device for bad blocks\n");
diff --git a/drivers/mtd/nand/raw/nand_bbt.c b/drivers/mtd/nand/raw/nand_bb=
t.c
index a3723da2e0a0..e4664fa6fd9e 100644
--- a/drivers/mtd/nand/raw/nand_bbt.c
+++ b/drivers/mtd/nand/raw/nand_bbt.c
@@ -313,7 +313,7 @@ static int scan_read_oob(struct nand_chip *this, uint8_=
t *buf, loff_t offs,
 =09=09=09 size_t len)
 {
 =09struct mtd_info *mtd =3D nand_to_mtd(this);
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int res, ret =3D 0;
=20
 =09ops.mode =3D MTD_OPS_PLACE_OOB;
@@ -354,7 +354,7 @@ static int scan_write_bbt(struct nand_chip *this, loff_=
t offs, size_t len,
 =09=09=09  uint8_t *buf, uint8_t *oob)
 {
 =09struct mtd_info *mtd =3D nand_to_mtd(this);
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
=20
 =09ops.mode =3D MTD_OPS_PLACE_OOB;
 =09ops.ooboffs =3D 0;
@@ -416,7 +416,7 @@ static int scan_block_fast(struct nand_chip *this, stru=
ct nand_bbt_descr *bd,
 {
 =09struct mtd_info *mtd =3D nand_to_mtd(this);
=20
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int ret, page_offset;
=20
 =09ops.ooblen =3D mtd->oobsize;
@@ -756,7 +756,7 @@ static int write_bbt(struct nand_chip *this, uint8_t *b=
uf,
 =09uint8_t rcode =3D td->reserved_block_code;
 =09size_t retlen, len =3D 0;
 =09loff_t to;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
=20
 =09ops.ooblen =3D mtd->oobsize;
 =09ops.ooboffs =3D 0;
diff --git a/drivers/mtd/nand/raw/sm_common.c b/drivers/mtd/nand/raw/sm_com=
mon.c
index ba24cb36d0b9..6df33e8d77df 100644
--- a/drivers/mtd/nand/raw/sm_common.c
+++ b/drivers/mtd/nand/raw/sm_common.c
@@ -99,7 +99,7 @@ static const struct mtd_ooblayout_ops oob_sm_small_ops =
=3D {
 static int sm_block_markbad(struct nand_chip *chip, loff_t ofs)
 {
 =09struct mtd_info *mtd =3D nand_to_mtd(chip);
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09struct sm_oob oob;
 =09int ret;
=20
diff --git a/drivers/mtd/nftlcore.c b/drivers/mtd/nftlcore.c
index 913db0dd6a8d..64d319e959b2 100644
--- a/drivers/mtd/nftlcore.c
+++ b/drivers/mtd/nftlcore.c
@@ -124,7 +124,7 @@ int nftl_read_oob(struct mtd_info *mtd, loff_t offs, si=
ze_t len,
 =09=09  size_t *retlen, uint8_t *buf)
 {
 =09loff_t mask =3D mtd->writesize - 1;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int res;
=20
 =09ops.mode =3D MTD_OPS_PLACE_OOB;
@@ -145,7 +145,7 @@ int nftl_write_oob(struct mtd_info *mtd, loff_t offs, s=
ize_t len,
 =09=09   size_t *retlen, uint8_t *buf)
 {
 =09loff_t mask =3D mtd->writesize - 1;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int res;
=20
 =09ops.mode =3D MTD_OPS_PLACE_OOB;
@@ -168,7 +168,7 @@ static int nftl_write(struct mtd_info *mtd, loff_t offs=
, size_t len,
 =09=09      size_t *retlen, uint8_t *buf, uint8_t *oob)
 {
 =09loff_t mask =3D mtd->writesize - 1;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int res;
=20
 =09ops.mode =3D MTD_OPS_PLACE_OOB;
diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index 7f955fade838..4cfec3b7b446 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -239,7 +239,7 @@ static int sm_read_sector(struct sm_ftl *ftl,
 =09=09=09  uint8_t *buffer, struct sm_oob *oob)
 {
 =09struct mtd_info *mtd =3D ftl->trans->mtd;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09struct sm_oob tmp_oob;
 =09int ret =3D -EIO;
 =09int try =3D 0;
@@ -323,7 +323,7 @@ static int sm_write_sector(struct sm_ftl *ftl,
 =09=09=09   int zone, int block, int boffset,
 =09=09=09   uint8_t *buffer, struct sm_oob *oob)
 {
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09struct mtd_info *mtd =3D ftl->trans->mtd;
 =09int ret;
=20
diff --git a/drivers/mtd/ssfdc.c b/drivers/mtd/ssfdc.c
index 1d05c121904c..04da685c36be 100644
--- a/drivers/mtd/ssfdc.c
+++ b/drivers/mtd/ssfdc.c
@@ -163,7 +163,7 @@ static int read_physical_sector(struct mtd_info *mtd, u=
int8_t *sect_buf,
 /* Read redundancy area (wrapper to MTD_READ_OOB */
 static int read_raw_oob(struct mtd_info *mtd, loff_t offs, uint8_t *buf)
 {
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int ret;
=20
 =09ops.mode =3D MTD_OPS_RAW;
diff --git a/drivers/mtd/tests/nandbiterrs.c b/drivers/mtd/tests/nandbiterr=
s.c
index 08084c018a59..98d7508f95b1 100644
--- a/drivers/mtd/tests/nandbiterrs.c
+++ b/drivers/mtd/tests/nandbiterrs.c
@@ -99,7 +99,7 @@ static int write_page(int log)
 static int rewrite_page(int log)
 {
 =09int err =3D 0;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
=20
 =09if (log)
 =09=09pr_info("rewrite page\n");
diff --git a/drivers/mtd/tests/oobtest.c b/drivers/mtd/tests/oobtest.c
index 532997e10e29..13fed398937e 100644
--- a/drivers/mtd/tests/oobtest.c
+++ b/drivers/mtd/tests/oobtest.c
@@ -56,7 +56,7 @@ static void do_vary_offset(void)
 static int write_eraseblock(int ebnum)
 {
 =09int i;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int err =3D 0;
 =09loff_t addr =3D (loff_t)ebnum * mtd->erasesize;
=20
@@ -165,7 +165,7 @@ static size_t memffshow(loff_t addr, loff_t offset, con=
st void *cs,
 static int verify_eraseblock(int ebnum)
 {
 =09int i;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int err =3D 0;
 =09loff_t addr =3D (loff_t)ebnum * mtd->erasesize;
 =09size_t bitflips;
@@ -260,7 +260,7 @@ static int verify_eraseblock(int ebnum)
=20
 static int verify_eraseblock_in_one_go(int ebnum)
 {
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int err =3D 0;
 =09loff_t addr =3D (loff_t)ebnum * mtd->erasesize;
 =09size_t len =3D mtd->oobavail * pgcnt;
@@ -338,7 +338,7 @@ static int __init mtd_oobtest_init(void)
 =09int err =3D 0;
 =09unsigned int i;
 =09uint64_t tmp;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09loff_t addr =3D 0, addr0;
=20
 =09printk(KERN_INFO "\n");
diff --git a/drivers/mtd/tests/readtest.c b/drivers/mtd/tests/readtest.c
index e70d588083a3..99670ef91f2b 100644
--- a/drivers/mtd/tests/readtest.c
+++ b/drivers/mtd/tests/readtest.c
@@ -47,7 +47,7 @@ static int read_eraseblock_by_page(int ebnum)
 =09=09=09=09err =3D ret;
 =09=09}
 =09=09if (mtd->oobsize) {
-=09=09=09struct mtd_oob_ops ops;
+=09=09=09struct mtd_oob_ops ops =3D { };
=20
 =09=09=09ops.mode      =3D MTD_OPS_PLACE_OOB;
 =09=09=09ops.len       =3D 0;
diff --git a/fs/jffs2/wbuf.c b/fs/jffs2/wbuf.c
index c6821a509481..4061e0ba7010 100644
--- a/fs/jffs2/wbuf.c
+++ b/fs/jffs2/wbuf.c
@@ -1035,7 +1035,7 @@ int jffs2_check_oob_empty(struct jffs2_sb_info *c,
 {
 =09int i, ret;
 =09int cmlen =3D min_t(int, c->oobavail, OOB_CM_SIZE);
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
=20
 =09ops.mode =3D MTD_OPS_AUTO_OOB;
 =09ops.ooblen =3D NR_OOB_SCAN_PAGES * c->oobavail;
@@ -1076,7 +1076,7 @@ int jffs2_check_oob_empty(struct jffs2_sb_info *c,
 int jffs2_check_nand_cleanmarker(struct jffs2_sb_info *c,
 =09=09=09=09 struct jffs2_eraseblock *jeb)
 {
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int ret, cmlen =3D min_t(int, c->oobavail, OOB_CM_SIZE);
=20
 =09ops.mode =3D MTD_OPS_AUTO_OOB;
@@ -1101,7 +1101,7 @@ int jffs2_write_nand_cleanmarker(struct jffs2_sb_info=
 *c,
 =09=09=09=09 struct jffs2_eraseblock *jeb)
 {
 =09int ret;
-=09struct mtd_oob_ops ops;
+=09struct mtd_oob_ops ops =3D { };
 =09int cmlen =3D min_t(int, c->oobavail, OOB_CM_SIZE);
=20
 =09ops.mode =3D MTD_OPS_AUTO_OOB;
--=20
2.37.0


