Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B129949B261
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378859AbiAYKvv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377120AbiAYKsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:48:38 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A7FC061763
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:48:37 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p27so55990835lfa.1
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Sf9nrV5/kUOfqh7Ut1el0haMtz7O6/Ny9NDQ0JFCQPM=;
        b=pSbHTYznoEntrQOfMJgW8oBiLaIAnaz+fivV0dJK37Pn6EFNyiEpzzTsOqvzujO15m
         E5IXRmVel55lbvo/aQmMYJhkjbXX3rKn8zimo9H3KzZChS2slwWUl2dS1t/I1943ZPxq
         9lHpNnuwyFxWF5fSDNNt3OCyERwGkQ09WE8Qc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Sf9nrV5/kUOfqh7Ut1el0haMtz7O6/Ny9NDQ0JFCQPM=;
        b=jgHyrg88ACmeKDWrxtTP8a6o9PBDMMmlD+bZ9V2Cuka5HejRw7kHDFhn8sm98gm4SX
         nbdtEgXyfZxzzvjOXWqlX9htWps6Xb3W24NX+gkKgBaY/qVg4wNxbpgAUP//SqXb8xzb
         cc0Ct03pzKgG7wyP04vA0Okhehqq/soXjwsShdErS0j04zCGvH82AkyRInrx7FZSPImP
         6NGr6+5v6T7yF31LSQdFJQEBq1pSbz2GCevzDTI7t0JQQMv+01qUkq4TDTtDFx2fk2eJ
         w+3juwCtwShEAI/QkXkE1intEWR1Pga2a9gfLYzNYZUUAEVOBg+Y+p5vVVgG8jzYFI7g
         PAYw==
X-Gm-Message-State: AOAM532tbeIQYH0y7+CqVn4NjC8ymatH83gV+hMghNLTLFPOS5RNuYBv
        aHcT0isb6RRXkchmYn01eJ1pvg==
X-Google-Smtp-Source: ABdhPJyVXeacxbN+b4V6r34793Ew+j+qOhKWV1p/c0+XiPNFprQm+umQesxyMzMWTnt+CSrQghWVwg==
X-Received: by 2002:a05:6512:22c6:: with SMTP id g6mr15738795lfu.1.1643107715715;
        Tue, 25 Jan 2022 02:48:35 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::221])
        by smtp.gmail.com with ESMTPSA id d16sm461896ljj.74.2022.01.25.02.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 02:48:35 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/4] mtdchar: add MEMREAD ioctl
Date:   Tue, 25 Jan 2022 11:48:22 +0100
Message-Id: <20220125104822.8420-5-kernel@kempniu.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125104822.8420-1-kernel@kempniu.pl>
References: <20220125104822.8420-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/mtd/mtdchar.c      | 136 +++++++++++++++++++++++++++++++++++++
 include/uapi/mtd/mtd-abi.h |  64 +++++++++++++++--
 2 files changed, 195 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index d0f9c4b0285c..68cc91d82a5d 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -685,6 +685,134 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
 	return ret;
 }
 
+static int mtdchar_read_ioctl(struct mtd_info *mtd,
+		struct mtd_read_req __user *argp)
+{
+	struct mtd_info *master = mtd_get_master(mtd);
+	struct mtd_read_req req;
+	void __user *usr_data, *usr_oob;
+	uint8_t *datbuf = NULL, *oobbuf = NULL;
+	size_t datbuf_len, oobbuf_len;
+	size_t orig_len, orig_ooblen;
+	int ret = 0;
+
+	if (copy_from_user(&req, argp, sizeof(req)))
+		return -EFAULT;
+
+	orig_len = req.len;
+	orig_ooblen = req.ooblen;
+
+	usr_data = (void __user *)(uintptr_t)req.usr_data;
+	usr_oob = (void __user *)(uintptr_t)req.usr_oob;
+
+	if (!master->_read_oob)
+		return -EOPNOTSUPP;
+
+	if (!usr_data)
+		req.len = 0;
+
+	if (!usr_oob)
+		req.ooblen = 0;
+
+	req.ecc_stats.uncorrectable_errors = 0;
+	req.ecc_stats.corrected_bitflips = 0;
+	req.ecc_stats.max_bitflips = 0;
+
+	if (req.start + req.len > mtd->size) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	datbuf_len = min_t(size_t, req.len, mtd->erasesize);
+	if (datbuf_len > 0) {
+		datbuf = kmalloc(datbuf_len, GFP_KERNEL);
+		if (!datbuf) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	oobbuf_len = min_t(size_t, req.ooblen, mtd->erasesize);
+	if (oobbuf_len > 0) {
+		oobbuf = kmalloc(oobbuf_len, GFP_KERNEL);
+		if (!oobbuf) {
+			ret = -ENOMEM;
+			goto out;
+		}
+	}
+
+	while (req.len > 0 || (!usr_data && req.ooblen > 0)) {
+		struct mtd_req_stats stats;
+		struct mtd_oob_ops ops = {
+			.mode = req.mode,
+			.len = min_t(size_t, req.len, datbuf_len),
+			.ooblen = min_t(size_t, req.ooblen, oobbuf_len),
+			.datbuf = datbuf,
+			.oobbuf = oobbuf,
+			.stats = &stats,
+		};
+
+		/*
+		 * Shorten non-page-aligned, eraseblock-sized reads so that the
+		 * read ends on an eraseblock boundary.  This is necessary in
+		 * order to prevent OOB data for some pages from being
+		 * duplicated in the output of non-page-aligned reads requiring
+		 * multiple mtd_read_oob() calls to be completed.
+		 */
+		if (ops.len == mtd->erasesize)
+			ops.len -= mtd_mod_by_ws(req.start + ops.len, mtd);
+
+		ret = mtd_read_oob(mtd, (loff_t)req.start, &ops);
+
+		req.ecc_stats.uncorrectable_errors +=
+			stats.uncorrectable_errors;
+		req.ecc_stats.corrected_bitflips += stats.corrected_bitflips;
+		req.ecc_stats.max_bitflips =
+			max(req.ecc_stats.max_bitflips, stats.max_bitflips);
+
+		if (ret && !mtd_is_bitflip_or_eccerr(ret))
+			break;
+
+		if (copy_to_user(usr_data, ops.datbuf, ops.retlen) ||
+		    copy_to_user(usr_oob, ops.oobbuf, ops.oobretlen)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		req.start += ops.retlen;
+		req.len -= ops.retlen;
+		usr_data += ops.retlen;
+
+		req.ooblen -= ops.oobretlen;
+		usr_oob += ops.oobretlen;
+	}
+
+	/*
+	 * As multiple iterations of the above loop (and therefore multiple
+	 * mtd_read_oob() calls) may be necessary to complete the read request,
+	 * adjust the final return code to ensure it accounts for all detected
+	 * ECC errors.
+	 */
+	if (!ret || mtd_is_bitflip(ret)) {
+		if (req.ecc_stats.uncorrectable_errors > 0)
+			ret = -EBADMSG;
+		else if (req.ecc_stats.corrected_bitflips > 0)
+			ret = -EUCLEAN;
+	}
+
+out:
+	req.len = orig_len - req.len;
+	req.ooblen = orig_ooblen - req.ooblen;
+
+	if (copy_to_user(argp, &req, sizeof(req)))
+		ret = -EFAULT;
+
+	kfree(datbuf);
+	kfree(oobbuf);
+
+	return ret;
+}
+
 static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 {
 	struct mtd_file_info *mfi = file->private_data;
@@ -707,6 +835,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	case MEMGETINFO:
 	case MEMREADOOB:
 	case MEMREADOOB64:
+	case MEMREAD:
 	case MEMISLOCKED:
 	case MEMGETOOBSEL:
 	case MEMGETBADBLOCK:
@@ -881,6 +1010,13 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 		break;
 	}
 
+	case MEMREAD:
+	{
+		ret = mtdchar_read_ioctl(mtd,
+		      (struct mtd_read_req __user *)arg);
+		break;
+	}
+
 	case MEMLOCK:
 	{
 		struct erase_info_user einfo;
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index b869990c2db2..bc68f266c174 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -55,9 +55,9 @@ struct mtd_oob_buf64 {
  * @MTD_OPS_RAW:	data are transferred as-is, with no error correction;
  *			this mode implies %MTD_OPS_PLACE_OOB
  *
- * These modes can be passed to ioctl(MEMWRITE) and are also used internally.
- * See notes on "MTD file modes" for discussion on %MTD_OPS_RAW vs.
- * %MTD_FILE_MODE_RAW.
+ * These modes can be passed to ioctl(MEMWRITE) and ioctl(MEMREAD); they are
+ * also used internally. See notes on "MTD file modes" for discussion on
+ * %MTD_OPS_RAW vs. %MTD_FILE_MODE_RAW.
  */
 enum {
 	MTD_OPS_PLACE_OOB = 0,
@@ -91,6 +91,53 @@ struct mtd_write_req {
 	__u8 padding[7];
 };
 
+/**
+ * struct mtd_read_req_ecc_stats - ECC statistics for a read operation
+ *
+ * @uncorrectable_errors: the number of uncorrectable errors that happened
+ *			  during the read operation
+ * @corrected_bitflips: the number of bitflips corrected during the read
+ *			operation
+ * @max_bitflips: the maximum number of bitflips detected in any single ECC
+ *		  step for the data read during the operation; this information
+ *		  can be used to decide whether the data stored in a specific
+ *		  region of the MTD device should be moved somewhere else to
+ *		  avoid data loss.
+ */
+struct mtd_read_req_ecc_stats {
+	__u32 uncorrectable_errors;
+	__u32 corrected_bitflips;
+	__u32 max_bitflips;
+};
+
+/**
+ * struct mtd_read_req - data structure for requesting a read operation
+ *
+ * @start:	start address
+ * @len:	length of data buffer
+ * @ooblen:	length of OOB buffer
+ * @usr_data:	user-provided data buffer
+ * @usr_oob:	user-provided OOB buffer
+ * @mode:	MTD mode (see "MTD operation modes")
+ * @padding:	reserved, must be set to 0
+ * @ecc_stats:	ECC statistics for the read operation
+ *
+ * This structure supports ioctl(MEMREAD) operations, allowing data and/or OOB
+ * reads in various modes. To read from OOB-only, set @usr_data == NULL, and to
+ * read data-only, set @usr_oob == NULL. However, setting both @usr_data and
+ * @usr_oob to NULL is not allowed.
+ */
+struct mtd_read_req {
+	__u64 start;
+	__u64 len;
+	__u64 ooblen;
+	__u64 usr_data;
+	__u64 usr_oob;
+	__u8 mode;
+	__u8 padding[7];
+	struct mtd_read_req_ecc_stats ecc_stats;
+};
+
 #define MTD_ABSENT		0
 #define MTD_RAM			1
 #define MTD_ROM			2
@@ -207,6 +254,12 @@ struct otp_info {
 #define MEMWRITE		_IOWR('M', 24, struct mtd_write_req)
 /* Erase a given range of user data (must be in mode %MTD_FILE_MODE_OTP_USER) */
 #define OTPERASE		_IOW('M', 25, struct otp_info)
+/*
+ * Most generic read interface; can read in-band and/or out-of-band in various
+ * modes (see "struct mtd_read_req"). This ioctl is not supported for flashes
+ * without OOB, e.g., NOR flash.
+ */
+#define MEMREAD			_IOWR('M', 26, struct mtd_read_req)
 
 /*
  * Obsolete legacy interface. Keep it in order not to break userspace
@@ -270,8 +323,9 @@ struct mtd_ecc_stats {
  * Note: %MTD_FILE_MODE_RAW provides the same functionality as %MTD_OPS_RAW -
  * raw access to the flash, without error correction or autoplacement schemes.
  * Wherever possible, the MTD_OPS_* mode will override the MTD_FILE_MODE_* mode
- * (e.g., when using ioctl(MEMWRITE)), but in some cases, the MTD_FILE_MODE is
- * used out of necessity (e.g., `write()', ioctl(MEMWRITEOOB64)).
+ * (e.g., when using ioctl(MEMWRITE) or ioctl(MEMREAD)), but in some cases, the
+ * MTD_FILE_MODE is used out of necessity (e.g., `write()',
+ * ioctl(MEMWRITEOOB64)).
  */
 enum mtd_file_modes {
 	MTD_FILE_MODE_NORMAL = MTD_OTP_OFF,
-- 
2.34.1

