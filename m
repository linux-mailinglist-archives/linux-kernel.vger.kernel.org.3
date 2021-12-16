Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 650E2476C08
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbhLPIeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:34:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbhLPIed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:34:33 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04E66C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:33 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id d38so3828039lfv.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OQEpf9YSE4WlXym+m2bXKtZ6xH4+6+evZLHUlWSG5Zg=;
        b=oQxjJXxt/5X2CkAbL1i1WKLq+hOKSCHRf8sv2aSr3ZWG2B0l4fJHH66K8+5/9PXeGE
         r0IN+naKq8jRMjh56xVkkDQmxfOtkaceuGRlshESBZrKGjt7cxE0gkbt7xKYqm/NrJcj
         lwWDbwMw8WAow0tXSYL8mRjVDmxGMhYZPs6q4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OQEpf9YSE4WlXym+m2bXKtZ6xH4+6+evZLHUlWSG5Zg=;
        b=F0dsbdZsQ9Z9sbGTmFZLrIe6l6/gx2tgTRFiwYeIb2wOysGHkiEIiEY8SqnFP0D9UL
         HFiF+v45NTu9CHYa9e9GgQhaoSgCkJNAYysszDSIr3qvHZNKujvS7itV/mtfgj3hDCtn
         COAlg83gPkzDNH8Hjo3kfMFs6bC1gulmw7H+ju7ddsrHyiCFXf8C8XvPG0TmXjIeEwWP
         /ue4dffOTM4Dqs2lOwCv9ybPcvxTOurlIeawsqIsbRNAvrmUSVHa4DxC0RWuhfsbLy6T
         7j/ETCEahatOEVjf3mYbbNoomchqLolu84GRkAfN5C6p9sUdB/Twhe7BzQH9/Gu0N9Sx
         ndEQ==
X-Gm-Message-State: AOAM5324Jua/cBHrYH4PhyPHFBQ/8WtwZA1oAxu7IVg+mhV3yjsQE2RY
        ty6MPzDQqW+RfU7wSz7VA7Ecgw==
X-Google-Smtp-Source: ABdhPJx0Yh8n5gvriK4hezyJX/u2/VXOTMK0LrA4Tj19OncSBwa4XidqFBfZP6E4Ilh4j3/5KnrmHg==
X-Received: by 2002:a19:490f:: with SMTP id w15mr3081878lfa.278.1639643671247;
        Thu, 16 Dec 2021 00:34:31 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id c2sm985679ljf.50.2021.12.16.00.34.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:34:30 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] mtdchar: add MEMREAD ioctl
Date:   Thu, 16 Dec 2021 09:34:14 +0100
Message-Id: <20211216083418.13512-2-kernel@kempniu.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216083418.13512-1-kernel@kempniu.pl>
References: <20211216083418.13512-1-kernel@kempniu.pl>
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

Update include/uapi/mtd/mtd-abi.h accordingly.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/mtd/mtdchar.c      | 110 +++++++++++++++++++++++++++++++++++++
 include/uapi/mtd/mtd-abi.h |  43 +++++++++++++--
 2 files changed, 148 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index d0f9c4b0285c..6ad59c9eed2f 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -685,6 +685,108 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
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
+		struct mtd_oob_ops ops = {
+			.mode = req.mode,
+			.len = min_t(size_t, req.len, datbuf_len),
+			.ooblen = min_t(size_t, req.ooblen, oobbuf_len),
+			.datbuf = datbuf,
+			.oobbuf = oobbuf,
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
@@ -707,6 +809,7 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 	case MEMGETINFO:
 	case MEMREADOOB:
 	case MEMREADOOB64:
+	case MEMREAD:
 	case MEMISLOCKED:
 	case MEMGETOOBSEL:
 	case MEMGETBADBLOCK:
@@ -881,6 +984,13 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
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
index b869990c2db2..337e6e597fad 100644
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
@@ -91,6 +91,32 @@ struct mtd_write_req {
 	__u8 padding[7];
 };
 
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
+};
+
 #define MTD_ABSENT		0
 #define MTD_RAM			1
 #define MTD_ROM			2
@@ -207,6 +233,12 @@ struct otp_info {
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
@@ -270,8 +302,9 @@ struct mtd_ecc_stats {
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

