Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 548D056010D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233739AbiF2NN2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:13:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232255AbiF2NNW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:13:22 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0641415A05
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656507468; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=khdzA+apAbjE7ctC3OaZLQUkGLKdwMt1a1cc7FvfnlG/AhFz71iityM75XdouUXncfjJ9HpcllI0IWIPwvW57cesqDXCb+sU2FbKf8vnt8EIww/Jx5gSndu4GuFLZf5Vwltl38Y6u2GGRJMcwG/pqsANGEhF/PH7s/y4aTmd3dM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1656507468; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=LD7PQCegOnl8aPefonBZBsOnRG+o8w5EZIYTSLjVePE=; 
        b=AL9//TN6Sd/JtirJxNSY2esPlJRdvbjImVuu+k1T82B46zMZM9EuQdihSz6OUOaAo55MiGFNCqs7RKR1eSFOC6gqGJPK50F8J8rXEHJbm2fluRU0n6DOsn1eG15I0cOk9PY8K70q9P7Vk5Q4lMxzgupw60N6ypSYk2AegEcZpIw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=kempniu.pl;
        spf=pass  smtp.mailfrom=kernel@kempniu.pl;
        dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656507468;
        s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=LD7PQCegOnl8aPefonBZBsOnRG+o8w5EZIYTSLjVePE=;
        b=OmYmD1WkSTStOBqj9Tx6K+F31538yKiFYrJ131zZLuxfc7M5rCfOv5f8JlqJr7+e
        pZyfMGTfkh/nyodxVf06CRP9MBU7CkWPXaAvfno6Ju2pD5b9UhjsFtkc7L0Z/gmsk8p
        DG2jpj1CHHDGkWyw+4j72n7cGWDDN9fy0TTDV1b4=
Received: from larwa.hq.kempniu.pl (212.180.138.61 [212.180.138.61]) by mx.zoho.eu
        with SMTPS id 1656507467209677.4938477840163; Wed, 29 Jun 2022 14:57:47 +0200 (CEST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20220629125737.14418-4-kernel@kempniu.pl>
Subject: [PATCH v4 3/4] mtd: add ECC error accounting for each read request
Date:   Wed, 29 Jun 2022 14:57:36 +0200
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
Signed-off-by: Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempniu.pl>
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
@@ -871,6 +871,7 @@ static int doc_read_oob(struct mtd_info *mtd, loff_t fr=
om,
 =09u8 *buf =3D ops->datbuf;
 =09size_t len, ooblen, nbdata, nboob;
 =09u8 hwecc[DOC_ECC_BCH_SIZE], eccconf1;
+=09struct mtd_ecc_stats old_stats;
 =09int max_bitflips =3D 0;
=20
 =09if (buf)
@@ -895,6 +896,7 @@ static int doc_read_oob(struct mtd_info *mtd, loff_t fr=
om,
 =09ret =3D 0;
 =09skip =3D from % DOC_LAYOUT_PAGE_SIZE;
 =09mutex_lock(&docg3->cascade->lock);
+=09old_stats =3D mtd->ecc_stats;
 =09while (ret >=3D 0 && (len > 0 || ooblen > 0)) {
 =09=09calc_block_sector(from - skip, &block0, &block1, &page, &ofs,
 =09=09=09docg3->reliable);
@@ -966,6 +968,12 @@ static int doc_read_oob(struct mtd_info *mtd, loff_t f=
rom,
 =09}
=20
 out:
+=09if (ops->stats) {
+=09=09ops->stats->uncorrectable_errors +=3D
+=09=09=09mtd->ecc_stats.failed - old_stats.failed;
+=09=09ops->stats->corrected_bitflips +=3D
+=09=09=09mtd->ecc_stats.corrected - old_stats.corrected;
+=09}
 =09mutex_unlock(&docg3->cascade->lock);
 =09return ret;
 err_in_read:
diff --git a/drivers/mtd/nand/onenand/onenand_base.c b/drivers/mtd/nand/one=
nand/onenand_base.c
index 5810104420a2..f66385faf631 100644
--- a/drivers/mtd/nand/onenand/onenand_base.c
+++ b/drivers/mtd/nand/onenand/onenand_base.c
@@ -1440,6 +1440,7 @@ static int onenand_read_oob(struct mtd_info *mtd, lof=
f_t from,
 =09=09=09    struct mtd_oob_ops *ops)
 {
 =09struct onenand_chip *this =3D mtd->priv;
+=09struct mtd_ecc_stats old_stats;
 =09int ret;
=20
 =09switch (ops->mode) {
@@ -1453,12 +1454,23 @@ static int onenand_read_oob(struct mtd_info *mtd, l=
off_t from,
 =09}
=20
 =09onenand_get_device(mtd, FL_READING);
+
+=09old_stats =3D mtd->ecc_stats;
+
 =09if (ops->datbuf)
 =09=09ret =3D ONENAND_IS_4KB_PAGE(this) ?
 =09=09=09onenand_mlc_read_ops_nolock(mtd, from, ops) :
 =09=09=09onenand_read_ops_nolock(mtd, from, ops);
 =09else
 =09=09ret =3D onenand_read_oob_nolock(mtd, from, ops);
+
+=09if (ops->stats) {
+=09=09ops->stats->uncorrectable_errors +=3D
+=09=09=09mtd->ecc_stats.failed - old_stats.failed;
+=09=09ops->stats->corrected_bitflips +=3D
+=09=09=09mtd->ecc_stats.corrected - old_stats.corrected;
+=09}
+
 =09onenand_release_device(mtd);
=20
 =09return ret;
diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand_b=
ase.c
index 6b67b7dfe7ce..3e20de1e145c 100644
--- a/drivers/mtd/nand/raw/nand_base.c
+++ b/drivers/mtd/nand/raw/nand_base.c
@@ -3818,6 +3818,7 @@ static int nand_read_oob(struct mtd_info *mtd, loff_t=
 from,
 =09=09=09 struct mtd_oob_ops *ops)
 {
 =09struct nand_chip *chip =3D mtd_to_nand(mtd);
+=09struct mtd_ecc_stats old_stats;
 =09int ret;
=20
 =09ops->retlen =3D 0;
@@ -3829,11 +3830,20 @@ static int nand_read_oob(struct mtd_info *mtd, loff=
_t from,
=20
 =09nand_get_device(chip);
=20
+=09old_stats =3D mtd->ecc_stats;
+
 =09if (!ops->datbuf)
 =09=09ret =3D nand_do_read_oob(chip, from, ops);
 =09else
 =09=09ret =3D nand_do_read_ops(chip, from, ops);
=20
+=09if (ops->stats) {
+=09=09ops->stats->uncorrectable_errors +=3D
+=09=09=09mtd->ecc_stats.failed - old_stats.failed;
+=09=09ops->stats->corrected_bitflips +=3D
+=09=09=09mtd->ecc_stats.corrected - old_stats.corrected;
+=09}
+
 =09nand_release_device(chip);
 =09return ret;
 }
diff --git a/drivers/mtd/nand/spi/core.c b/drivers/mtd/nand/spi/core.c
index d5b685d1605e..90d8a88c9326 100644
--- a/drivers/mtd/nand/spi/core.c
+++ b/drivers/mtd/nand/spi/core.c
@@ -635,6 +635,7 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_=
t from,
 {
 =09struct spinand_device *spinand =3D mtd_to_spinand(mtd);
 =09struct nand_device *nand =3D mtd_to_nanddev(mtd);
+=09struct mtd_ecc_stats old_stats;
 =09unsigned int max_bitflips =3D 0;
 =09struct nand_io_iter iter;
 =09bool disable_ecc =3D false;
@@ -646,6 +647,8 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff_=
t from,
=20
 =09mutex_lock(&spinand->lock);
=20
+=09old_stats =3D mtd->ecc_stats;
+
 =09nanddev_io_for_each_page(nand, NAND_PAGE_READ, from, ops, &iter) {
 =09=09if (disable_ecc)
 =09=09=09iter.req.mode =3D MTD_OPS_RAW;
@@ -668,6 +671,13 @@ static int spinand_mtd_read(struct mtd_info *mtd, loff=
_t from,
 =09=09ops->oobretlen +=3D iter.req.ooblen;
 =09}
=20
+=09if (ops->stats) {
+=09=09ops->stats->uncorrectable_errors +=3D
+=09=09=09mtd->ecc_stats.failed - old_stats.failed;
+=09=09ops->stats->corrected_bitflips +=3D
+=09=09=09mtd->ecc_stats.corrected - old_stats.corrected;
+=09}
+
 =09mutex_unlock(&spinand->lock);
=20
 =09if (ecc_failed && !ret)
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index fccad1766458..c12a5930f32c 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -41,6 +41,8 @@ struct mtd_erase_region_info {
 };
=20
 struct mtd_req_stats {
+=09unsigned int uncorrectable_errors;
+=09unsigned int corrected_bitflips;
 =09unsigned int max_bitflips;
 };
=20
--=20
2.37.0


