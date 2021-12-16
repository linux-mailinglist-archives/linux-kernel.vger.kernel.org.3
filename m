Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94874476C0C
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:35:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234934AbhLPIep (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:34:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbhLPIej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:34:39 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C41A8C06173E
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:38 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b22so3623780lfb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qwPD1oVoFMF1xKkNcH8JUWEtU0QdLAHfHEEI/7F8aYs=;
        b=kuSV+mGPbS8eFy6r2iWUhUbWbv7aYfipqFVAu0qdsjtK16/kUISpJXaqm2zT5lmpYP
         ywVZiFfLgZjgz+uoLgaTovuG8o6zFid7nhx6NfZf+zsq6NPPvxAU73tNN6UFssA69rOD
         tTk+HJsco+i092uvMLHhr9ZXWVqyGG761JsgI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qwPD1oVoFMF1xKkNcH8JUWEtU0QdLAHfHEEI/7F8aYs=;
        b=H9eD9gq3HaPumeACs3Ql6yyqnHWneBjAVVQkBgxERLQ3TR3CTFb4HGtc7MjXJnJXku
         e4SzonYlXW/ap7UsNJACNSaxLJRemrjsneKxl5GFJViws5kPLZx4nCymBVQ4gOyOLCGJ
         VQi7DyWixF/wy75SAAItjpH2JMXJS53ZLKIpq9jAAnhP0s5Jlb9X6lUo/jDAPojHkG3s
         o8mmrqjEhOCDD4JDaHTyaw07PxUSAKlxbOU8ZlnRCIPeWk0mXiruaGdlfcLPWIXDfYvX
         qtmkf6pG++06gQjh4IDLoehHy/GrU9UCXVvHlzHLhqxI2ywkWlstXnuTpSe4mcmmw9eA
         RYng==
X-Gm-Message-State: AOAM530qc4dRaKCTvs7MNdKcAutavk4zjCo0JCXxMndOcqOG40IJkQcc
        NgWeGqB1tdb/Pa+ptA85Z2Q1yA==
X-Google-Smtp-Source: ABdhPJzOFC29Fkjce3PbS8M3TLJIzWi4sdkId0NcfoQej12qB3XgRav1dnZstsrb/rUGigQkcVljew==
X-Received: by 2002:ac2:4c55:: with SMTP id o21mr13343931lfk.408.1639643675579;
        Thu, 16 Dec 2021 00:34:35 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id c2sm985679ljf.50.2021.12.16.00.34.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:34:35 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 5/5] mtdchar: extend MEMREAD ioctl to return ECC statistics
Date:   Thu, 16 Dec 2021 09:34:18 +0100
Message-Id: <20211216083418.13512-6-kernel@kempniu.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216083418.13512-1-kernel@kempniu.pl>
References: <20211216083418.13512-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

While returning -EUCLEAN or -EBADMSG is a valid signal for user space
that the ECC algorithm detected errors during a read operation, that
signal is not granular enough to cover all use cases.  For example,
knowing the maximum number of bitflips detected in a single ECC step
during a read operation performed on a given page may be useful when
dealing with an MTD partition whose ECC layout varies across pages (e.g.
a partition consisting of a bootloader area using a "custom" ECC layout
followed by data pages using a "standard" ECC layout).

Extend struct mtd_read_req with a newly introduced struct
mtd_read_req_ecc_stats and set the fields of that structure in
mtdchar_read_ioctl().  Use ECC statistics to ensure the error code
returned by the MEMREAD ioctl accounts for all ECC errors detected
during the read operation.

Link: https://www.infradead.org/pipermail/linux-mtd/2016-April/067085.html

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/mtd/mtdchar.c      | 26 ++++++++++++++++++++++++++
 include/uapi/mtd/mtd-abi.h | 21 +++++++++++++++++++++
 2 files changed, 47 insertions(+)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 6ad59c9eed2f..68cc91d82a5d 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -714,6 +714,10 @@ static int mtdchar_read_ioctl(struct mtd_info *mtd,
 	if (!usr_oob)
 		req.ooblen = 0;
 
+	req.ecc_stats.uncorrectable_errors = 0;
+	req.ecc_stats.corrected_bitflips = 0;
+	req.ecc_stats.max_bitflips = 0;
+
 	if (req.start + req.len > mtd->size) {
 		ret = -EINVAL;
 		goto out;
@@ -738,12 +742,14 @@ static int mtdchar_read_ioctl(struct mtd_info *mtd,
 	}
 
 	while (req.len > 0 || (!usr_data && req.ooblen > 0)) {
+		struct mtd_req_stats stats;
 		struct mtd_oob_ops ops = {
 			.mode = req.mode,
 			.len = min_t(size_t, req.len, datbuf_len),
 			.ooblen = min_t(size_t, req.ooblen, oobbuf_len),
 			.datbuf = datbuf,
 			.oobbuf = oobbuf,
+			.stats = &stats,
 		};
 
 		/*
@@ -757,6 +763,13 @@ static int mtdchar_read_ioctl(struct mtd_info *mtd,
 			ops.len -= mtd_mod_by_ws(req.start + ops.len, mtd);
 
 		ret = mtd_read_oob(mtd, (loff_t)req.start, &ops);
+
+		req.ecc_stats.uncorrectable_errors +=
+			stats.uncorrectable_errors;
+		req.ecc_stats.corrected_bitflips += stats.corrected_bitflips;
+		req.ecc_stats.max_bitflips =
+			max(req.ecc_stats.max_bitflips, stats.max_bitflips);
+
 		if (ret && !mtd_is_bitflip_or_eccerr(ret))
 			break;
 
@@ -774,6 +787,19 @@ static int mtdchar_read_ioctl(struct mtd_info *mtd,
 		usr_oob += ops.oobretlen;
 	}
 
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
 out:
 	req.len = orig_len - req.len;
 	req.ooblen = orig_ooblen - req.ooblen;
diff --git a/include/uapi/mtd/mtd-abi.h b/include/uapi/mtd/mtd-abi.h
index 337e6e597fad..bc68f266c174 100644
--- a/include/uapi/mtd/mtd-abi.h
+++ b/include/uapi/mtd/mtd-abi.h
@@ -91,6 +91,25 @@ struct mtd_write_req {
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
 /**
  * struct mtd_read_req - data structure for requesting a read operation
  *
@@ -101,6 +120,7 @@ struct mtd_write_req {
  * @usr_oob:	user-provided OOB buffer
  * @mode:	MTD mode (see "MTD operation modes")
  * @padding:	reserved, must be set to 0
+ * @ecc_stats:	ECC statistics for the read operation
  *
  * This structure supports ioctl(MEMREAD) operations, allowing data and/or OOB
  * reads in various modes. To read from OOB-only, set @usr_data == NULL, and to
@@ -115,6 +135,7 @@ struct mtd_read_req {
 	__u64 usr_oob;
 	__u8 mode;
 	__u8 padding[7];
+	struct mtd_read_req_ecc_stats ecc_stats;
 };
 
 #define MTD_ABSENT		0
-- 
2.34.1

