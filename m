Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B3C560105
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 15:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233756AbiF2NNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 09:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233594AbiF2NNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 09:13:23 -0400
Received: from sender11-op-o11.zoho.eu (sender11-op-o11.zoho.eu [31.186.226.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 063A115A03
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 06:13:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656507469; cv=none; 
        d=zohomail.eu; s=zohoarc; 
        b=gx1wTM/ATeqJNPaFBcWGMffgzbnCu241llIkg8zQbJkuqcYDeHji7ddzGwqYOT6Lo8AmYRZcUNQAyZMzTlz5ZJzPw5B6X+T0kpdu+LyS8oiwNyOiK/b4JRHn3lllBau1zDtLq147D16ZCRTPGgdsehph7pnBeuljjvY8jVk6hnU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
        t=1656507469; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=Qm3Rh5y/q8c+81HrLMGaq/yQ8HATBahzYOkp615GaFE=; 
        b=eDaXFsk0Tn4FvAN9LjdHmoVv30xgeG66MyyPWOlfBzwPxNcsrPOVglJGra68NFJW2enohbWHnETe+R/vaZ0TzVFq/8AKmLsmWZOweASeIv+DH26WjwYPzr5BoGShvufwdY9PTA5vTLc6IynqTXjWx7Mi2rzn2McFbnTP4sQzsbg=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
        dkim=pass  header.i=kempniu.pl;
        spf=pass  smtp.mailfrom=kernel@kempniu.pl;
        dmarc=pass header.from=<kernel@kempniu.pl>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656507469;
        s=zmail; d=kempniu.pl; i=kernel@kempniu.pl;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
        bh=Qm3Rh5y/q8c+81HrLMGaq/yQ8HATBahzYOkp615GaFE=;
        b=gIpzOLhLdXLDqe2MMAqczyfstdMRLIzKXQwgFIYPeJn07V5RerxNALUUpUU9U05G
        q4lalgB1oyZi1I8ibwWfCE+vk8vBoIeMmtw7/b6Z5M9Cq3XVwGROf+PRZ2MNjqRlXm9
        BkAJowHU/9KPEMTUkucsBZKPhw6YdmwK3KZCscz4=
Received: from larwa.hq.kempniu.pl (212.180.138.61 [212.180.138.61]) by mx.zoho.eu
        with SMTPS id 1656507467671664.497666101054; Wed, 29 Jun 2022 14:57:47 +0200 (CEST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Message-ID: <20220629125737.14418-5-kernel@kempniu.pl>
Subject: [PATCH v4 4/4] mtdchar: add MEMREAD ioctl
Date:   Wed, 29 Jun 2022 14:57:37 +0200
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

User-space applications making use of MTD devices via /dev/mtd*
character devices currently have limited capabilities for reading data:

  - only deprecated methods of accessing OOB layout information exist,

  - there is no way to explicitly specify MTD operation mode to use; it
    is auto-selected based on the MTD file mode (MTD_FILE_MODE_*) set
    for the character device; in particular, this prevents using
    MTD_OPS_AUTO_OOB for reads,

  - all existing user-space interfaces which cause mtd_read() or
    mtd_read_oob() to be called (via mtdchar_read() and
    mtdchar_read_oob(), respectively) return success even when those
    functions return -EUCLEAN or -EBADMSG; this renders user-space
    applications using these interfaces unaware of any corrected
    bitflips or uncorrectable ECC errors detected during reads.

Note that the existing MEMWRITE ioctl allows the MTD operation mode to
be explicitly set, allowing user-space applications to write page data
and OOB data without requiring them to know anything about the OOB
layout of the MTD device they are writing to (MTD_OPS_AUTO_OOB).  Also,
the MEMWRITE ioctl does not mangle the return value of mtd_write_oob().

Add a new ioctl, MEMREAD, which addresses the above issues.  It is
intended to be a read-side counterpart of the existing MEMWRITE ioctl.
Similarly to the latter, the read operation is performed in a loop which
processes at most mtd->erasesize bytes in each iteration.  This is done
to prevent unbounded memory allocations caused by calling kmalloc() with
the 'size' argument taken directly from the struct mtd_read_req provided
by user space.  However, the new ioctl is implemented so that the values
it returns match those that would have been returned if just a single
mtd_read_oob() call was issued to handle the entire read operation in
one go.

Note that while just returning -EUCLEAN or -EBADMSG to user space would
already be a valid and useful indication of the ECC algorithm detecting
errors during a read operation, that signal would not be granular enough
to cover all use cases.  For example, knowing the maximum number of
bitflips detected in a single ECC step during a read operation performed
on a given page may be useful when dealing with an MTD partition whose
ECC layout varies across pages (e.g. a partition consisting of a
bootloader area using a "custom" ECC layout followed by data pages using
a "standard" ECC layout).  To address that, include ECC statistics in
the structure returned to user space by the new MEMREAD ioctl.

Link: https://www.infradead.org/pipermail/linux-mtd/2016-April/067085.html

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Micha=C5=82 K=C4=99pie=C5=84 <kernel@kempniu.pl>
---
 drivers/mtd/mtdchar.c      | 139 +++++++++++++++++++++++++++++++++++++
 include/uapi/mtd/mtd-abi.h |  64 +++++++++++++++--
 2 files changed, 198 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 05860288a7af..01f1c6792df9 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -688,6 +688,137 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
 =09return ret;
 }
=20
+static int mtdchar_read_ioctl(struct mtd_info *mtd,
+=09=09struct mtd_read_req __user *argp)
+{
+=09struct mtd_info *master =3D mtd_get_master(mtd);
+=09struct mtd_read_req req;
+=09void __user *usr_data, *usr_oob;
+=09uint8_t *datbuf =3D NULL, *oobbuf =3D NULL;
+=09size_t datbuf_len, oobbuf_len;
+=09size_t orig_len, orig_ooblen;
+=09int ret =3D 0;
+
+=09if (copy_from_user(&req, argp, sizeof(req)))
+=09=09return -EFAULT;
+
+=09orig_len =3D req.len;
+=09orig_ooblen =3D req.ooblen;
+
+=09usr_data =3D (void __user *)(uintptr_t)req.usr_data;
+=09usr_oob =3D (void __user *)(uintptr_t)req.usr_oob;
+
+=09if (!master->_read_oob)
+=09=09return -EOPNOTSUPP;
+
+=09if (!usr_data)
+=09=09req.len =3D 0;
+
+=09if (!usr_oob)
+=09=09req.ooblen =3D 0;
+
+=09req.ecc_stats.uncorrectable_errors =3D 0;
+=09req.ecc_stats.corrected_bitflips =3D 0;
+=09req.ecc_stats.max_bitflips =3D 0;
+
+=09req.len &=3D 0xffffffff;
+=09req.ooblen &=3D 0xffffffff;
+
+=09if (req.start + req.len > mtd->size) {
+=09=09ret =3D -EINVAL;
+=09=09goto out;
+=09}
+
+=09datbuf_len =3D min_t(size_t, req.len, mtd->erasesize);
+=09if (datbuf_len > 0) {
+=09=09datbuf =3D kvmalloc(datbuf_len, GFP_KERNEL);
+=09=09if (!datbuf) {
+=09=09=09ret =3D -ENOMEM;
+=09=09=09goto out;
+=09=09}
+=09}
+
+=09oobbuf_len =3D min_t(size_t, req.ooblen, mtd->erasesize);
+=09if (oobbuf_len > 0) {
+=09=09oobbuf =3D kvmalloc(oobbuf_len, GFP_KERNEL);
+=09=09if (!oobbuf) {
+=09=09=09ret =3D -ENOMEM;
+=09=09=09goto out;
+=09=09}
+=09}
+
+=09while (req.len > 0 || (!usr_data && req.ooblen > 0)) {
+=09=09struct mtd_req_stats stats;
+=09=09struct mtd_oob_ops ops =3D {
+=09=09=09.mode =3D req.mode,
+=09=09=09.len =3D min_t(size_t, req.len, datbuf_len),
+=09=09=09.ooblen =3D min_t(size_t, req.ooblen, oobbuf_len),
+=09=09=09.datbuf =3D datbuf,
+=09=09=09.oobbuf =3D oobbuf,
+=09=09=09.stats =3D &stats,
+=09=09};
+
+=09=09/*
+=09=09 * Shorten non-page-aligned, eraseblock-sized reads so that the
+=09=09 * read ends on an eraseblock boundary.  This is necessary in
+=09=09 * order to prevent OOB data for some pages from being
+=09=09 * duplicated in the output of non-page-aligned reads requiring
+=09=09 * multiple mtd_read_oob() calls to be completed.
+=09=09 */
+=09=09if (ops.len =3D=3D mtd->erasesize)
+=09=09=09ops.len -=3D mtd_mod_by_ws(req.start + ops.len, mtd);
+
+=09=09ret =3D mtd_read_oob(mtd, (loff_t)req.start, &ops);
+
+=09=09req.ecc_stats.uncorrectable_errors +=3D
+=09=09=09stats.uncorrectable_errors;
+=09=09req.ecc_stats.corrected_bitflips +=3D stats.corrected_bitflips;
+=09=09req.ecc_stats.max_bitflips =3D
+=09=09=09max(req.ecc_stats.max_bitflips, stats.max_bitflips);
+
+=09=09if (ret && !mtd_is_bitflip_or_eccerr(ret))
+=09=09=09break;
+
+=09=09if (copy_to_user(usr_data, ops.datbuf, ops.retlen) ||
+=09=09    copy_to_user(usr_oob, ops.oobbuf, ops.oobretlen)) {
+=09=09=09ret =3D -EFAULT;
+=09=09=09break;
+=09=09}
+
+=09=09req.start +=3D ops.retlen;
+=09=09req.len -=3D ops.retlen;
+=09=09usr_data +=3D ops.retlen;
+
+=09=09req.ooblen -=3D ops.oobretlen;
+=09=09usr_oob +=3D ops.oobretlen;
+=09}
+
+=09/*
+=09 * As multiple iterations of the above loop (and therefore multiple
+=09 * mtd_read_oob() calls) may be necessary to complete the read request,
+=09 * adjust the final return code to ensure it accounts for all detected
+=09 * ECC errors.
+=09 */
+=09if (!ret || mtd_is_bitflip(ret)) {
+=09=09if (req.ecc_stats.uncorrectable_errors > 0)
+=09=09=09ret =3D -EBADMSG;
+=09=09else if (req.ecc_stats.corrected_bitflips > 0)
+=09=09=09ret =3D -EUCLEAN;
+=09}
+
+out:
+=09req.len =3D orig_len - req.len;
+=09req.ooblen =3D orig_ooblen - req.ooblen;
+
+=09if (copy_to_user(argp, &req, sizeof(req)))
+=09=09ret =3D -EFAULT;
+
+=09kvfree(datbuf);
+=09kvfree(oobbuf);
+
+=09return ret;
+}
+
 static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 {
 =09struct mtd_file_info *mfi =3D file->private_data;
@@ -710,6 +841,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, =
u_long arg)
 =09case MEMGETINFO:
 =09case MEMREADOOB:
 =09case MEMREADOOB64:
+=09case MEMREAD:
 =09case MEMISLOCKED:
 =09case MEMGETOOBSEL:
 =09case MEMGETBADBLOCK:
@@ -884,6 +1016,13 @@ static int mtdchar_ioctl(struct file *file, u_int cmd=
, u_long arg)
 =09=09break;
 =09}
=20
+=09case MEMREAD:
+=09{
+=09=09ret =3D mtdchar_read_ioctl(mtd,
+=09=09      (struct mtd_read_req __user *)arg);
+=09=09break;
+=09}
+
 =09case MEMLOCK:
 =09{
 =09=09struct erase_info_user einfo;
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index 890d9e5b76d7..714d55b49d2a 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -55,9 +55,9 @@ struct mtd_oob_buf64 {
  * @MTD_OPS_RAW:=09data are transferred as-is, with no error correction;
  *=09=09=09this mode implies %MTD_OPS_PLACE_OOB
  *
- * These modes can be passed to ioctl(MEMWRITE) and are also used internal=
ly.
- * See notes on "MTD file modes" for discussion on %MTD_OPS_RAW vs.
- * %MTD_FILE_MODE_RAW.
+ * These modes can be passed to ioctl(MEMWRITE) and ioctl(MEMREAD); they a=
re
+ * also used internally. See notes on "MTD file modes" for discussion on
+ * %MTD_OPS_RAW vs. %MTD_FILE_MODE_RAW.
  */
 enum {
 =09MTD_OPS_PLACE_OOB =3D 0,
@@ -91,6 +91,53 @@ struct mtd_write_req {
 =09__u8 padding[7];
 };
=20
+/**
+ * struct mtd_read_req_ecc_stats - ECC statistics for a read operation
+ *
+ * @uncorrectable_errors: the number of uncorrectable errors that happened
+ *=09=09=09  during the read operation
+ * @corrected_bitflips: the number of bitflips corrected during the read
+ *=09=09=09operation
+ * @max_bitflips: the maximum number of bitflips detected in any single EC=
C
+ *=09=09  step for the data read during the operation; this information
+ *=09=09  can be used to decide whether the data stored in a specific
+ *=09=09  region of the MTD device should be moved somewhere else to
+ *=09=09  avoid data loss.
+ */
+struct mtd_read_req_ecc_stats {
+=09__u32 uncorrectable_errors;
+=09__u32 corrected_bitflips;
+=09__u32 max_bitflips;
+};
+
+/**
+ * struct mtd_read_req - data structure for requesting a read operation
+ *
+ * @start:=09start address
+ * @len:=09length of data buffer (only lower 32 bits are used)
+ * @ooblen:=09length of OOB buffer (only lower 32 bits are used)
+ * @usr_data:=09user-provided data buffer
+ * @usr_oob:=09user-provided OOB buffer
+ * @mode:=09MTD mode (see "MTD operation modes")
+ * @padding:=09reserved, must be set to 0
+ * @ecc_stats:=09ECC statistics for the read operation
+ *
+ * This structure supports ioctl(MEMREAD) operations, allowing data and/or=
 OOB
+ * reads in various modes. To read from OOB-only, set @usr_data =3D=3D NUL=
L, and to
+ * read data-only, set @usr_oob =3D=3D NULL. However, setting both @usr_da=
ta and
+ * @usr_oob to NULL is not allowed.
+ */
+struct mtd_read_req {
+=09__u64 start;
+=09__u64 len;
+=09__u64 ooblen;
+=09__u64 usr_data;
+=09__u64 usr_oob;
+=09__u8 mode;
+=09__u8 padding[7];
+=09struct mtd_read_req_ecc_stats ecc_stats;
+};
+
 #define MTD_ABSENT=09=090
 #define MTD_RAM=09=09=091
 #define MTD_ROM=09=09=092
@@ -207,6 +254,12 @@ struct otp_info {
 #define MEMWRITE=09=09_IOWR('M', 24, struct mtd_write_req)
 /* Erase a given range of user data (must be in mode %MTD_FILE_MODE_OTP_US=
ER) */
 #define OTPERASE=09=09_IOW('M', 25, struct otp_info)
+/*
+ * Most generic read interface; can read in-band and/or out-of-band in var=
ious
+ * modes (see "struct mtd_read_req"). This ioctl is not supported for flas=
hes
+ * without OOB, e.g., NOR flash.
+ */
+#define MEMREAD=09=09=09_IOWR('M', 26, struct mtd_read_req)
=20
 /*
  * Obsolete legacy interface. Keep it in order not to break userspace
@@ -270,8 +323,9 @@ struct mtd_ecc_stats {
  * Note: %MTD_FILE_MODE_RAW provides the same functionality as %MTD_OPS_RA=
W -
  * raw access to the flash, without error correction or autoplacement sche=
mes.
  * Wherever possible, the MTD_OPS_* mode will override the MTD_FILE_MODE_*=
 mode
- * (e.g., when using ioctl(MEMWRITE)), but in some cases, the MTD_FILE_MOD=
E is
- * used out of necessity (e.g., `write()', ioctl(MEMWRITEOOB64)).
+ * (e.g., when using ioctl(MEMWRITE) or ioctl(MEMREAD)), but in some cases=
, the
+ * MTD_FILE_MODE is used out of necessity (e.g., `write()',
+ * ioctl(MEMWRITEOOB64)).
  */
 enum mtd_file_modes {
 =09MTD_FILE_MODE_NORMAL =3D MTD_OTP_OFF,
--=20
2.37.0


