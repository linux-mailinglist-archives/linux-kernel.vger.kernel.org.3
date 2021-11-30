Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B1FD46326D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 12:32:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239473AbhK3Lfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 06:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbhK3LfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 06:35:25 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0F9EC061574
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:32:06 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id d11so40491964ljg.8
        for <linux-kernel@vger.kernel.org>; Tue, 30 Nov 2021 03:32:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5b3YvPegq03gYSzvbahWzi/UFXFsEzYj5ZGA/leSgI=;
        b=Tp3Exh9ExxwZfrNgUk6Robd0zH/IDARvYBvLqEcDHNyml8HU7O5L7dKk2+DQjJIVCr
         19F3gmzZ+XRr/lwW/yizWqnQFQwh6UNSqW+uxEw/XDK3xfxvvgKL+Wvu6yW65O7VFfXx
         6Qxg2JYbAhqLQPybdJeXOGDl8dZhxi24lHo6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=X5b3YvPegq03gYSzvbahWzi/UFXFsEzYj5ZGA/leSgI=;
        b=SzzJ/IYt/vy45JXDoNQNhxpMFDD7WpF8RX/ntBE0mbwQ7f9M98w0O4dkDiZDn78o4s
         sJz/hAU2erZ9KnWpMHtTZNGUzBCBId1EPhh5nPknnUnaf/IDLYf2IuAUd9HitfOnM29H
         bRFi+UOy/ytERMEXodp6CPAmW0z5qX2xt3xXLunXEwmc/4WrxcRSJWdVYh3SPOlAmZNM
         1K66pX/O0dALWYSVY7eIvrfdngEfPyMV0vfKw7rn7suzW04i9A8gi/aRj9j7A9ntCPwu
         4Jds/GpbgXMvpHIVLzvOIf5OjwUO3KKXAUJtXrCbgIFE2131BytEv9v+/NJg/MQ/XG0u
         KYbw==
X-Gm-Message-State: AOAM533TKGkGw27wl5kuKdK7qC9qJkXBTN7Mqgji52UO+z7JTRGxGrlI
        X39Q07Ce1ZU3WBE4ZXOzMwYGoA==
X-Google-Smtp-Source: ABdhPJzAJGMoIxxVFHK0gKBc56Pb+vSejIdKsa+bAgLTX9Vh0Ck6xGqoELcgMnNmXlnt4jC9PGB4NQ==
X-Received: by 2002:a2e:144a:: with SMTP id 10mr51970178lju.75.1638271925020;
        Tue, 30 Nov 2021 03:32:05 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::221])
        by smtp.gmail.com with ESMTPSA id l16sm1884472lfg.90.2021.11.30.03.32.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 03:32:04 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] mtdchar: prevent unbounded allocation in MEMWRITE ioctl
Date:   Tue, 30 Nov 2021 12:31:49 +0100
Message-Id: <20211130113149.21848-1-kernel@kempniu.pl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the mtdchar_write_ioctl() function, memdup_user() is called with its
'len' parameter set to verbatim values provided by user space via a
struct mtd_write_req.  Both the 'len' and 'ooblen' fields of that
structure are 64-bit unsigned integers, which means the MEMWRITE ioctl
can trigger unbounded kernel memory allocation requests.

Fix by iterating over the buffers provided by user space in a loop,
processing at most mtd->erasesize bytes in each iteration.  Adopt some
checks from mtd_check_oob_ops() to retain backward user space
compatibility.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
Changes from v1:

  - Fixed splitting certain large writes with OOB data missing for some
    pages.

  - Fixed splitting large non-page-aligned writes.

  - Reworked OOB length adjustment code to fix other cases of
    mishandling non-page-aligned writes.

  - Extracted OOB length adjustment code to a helper function for better
    readability.

 drivers/mtd/mtdchar.c | 110 +++++++++++++++++++++++++++++++++---------
 1 file changed, 87 insertions(+), 23 deletions(-)

diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 155e991d9d75..d0f9c4b0285c 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -573,14 +573,32 @@ static int mtdchar_blkpg_ioctl(struct mtd_info *mtd,
 	}
 }
 
+static void adjust_oob_length(struct mtd_info *mtd, uint64_t start,
+			      struct mtd_oob_ops *ops)
+{
+	uint32_t start_page, end_page;
+	u32 oob_per_page;
+
+	if (ops->len == 0 || ops->ooblen == 0)
+		return;
+
+	start_page = mtd_div_by_ws(start, mtd);
+	end_page = mtd_div_by_ws(start + ops->len - 1, mtd);
+	oob_per_page = mtd_oobavail(mtd, ops);
+
+	ops->ooblen = min_t(size_t, ops->ooblen,
+			    (end_page - start_page + 1) * oob_per_page);
+}
+
 static int mtdchar_write_ioctl(struct mtd_info *mtd,
 		struct mtd_write_req __user *argp)
 {
 	struct mtd_info *master = mtd_get_master(mtd);
 	struct mtd_write_req req;
-	struct mtd_oob_ops ops = {};
 	const void __user *usr_data, *usr_oob;
-	int ret;
+	uint8_t *datbuf = NULL, *oobbuf = NULL;
+	size_t datbuf_len, oobbuf_len;
+	int ret = 0;
 
 	if (copy_from_user(&req, argp, sizeof(req)))
 		return -EFAULT;
@@ -590,33 +608,79 @@ static int mtdchar_write_ioctl(struct mtd_info *mtd,
 
 	if (!master->_write_oob)
 		return -EOPNOTSUPP;
-	ops.mode = req.mode;
-	ops.len = (size_t)req.len;
-	ops.ooblen = (size_t)req.ooblen;
-	ops.ooboffs = 0;
-
-	if (usr_data) {
-		ops.datbuf = memdup_user(usr_data, ops.len);
-		if (IS_ERR(ops.datbuf))
-			return PTR_ERR(ops.datbuf);
-	} else {
-		ops.datbuf = NULL;
+
+	if (!usr_data)
+		req.len = 0;
+
+	if (!usr_oob)
+		req.ooblen = 0;
+
+	if (req.start + req.len > mtd->size)
+		return -EINVAL;
+
+	datbuf_len = min_t(size_t, req.len, mtd->erasesize);
+	if (datbuf_len > 0) {
+		datbuf = kmalloc(datbuf_len, GFP_KERNEL);
+		if (!datbuf)
+			return -ENOMEM;
 	}
 
-	if (usr_oob) {
-		ops.oobbuf = memdup_user(usr_oob, ops.ooblen);
-		if (IS_ERR(ops.oobbuf)) {
-			kfree(ops.datbuf);
-			return PTR_ERR(ops.oobbuf);
+	oobbuf_len = min_t(size_t, req.ooblen, mtd->erasesize);
+	if (oobbuf_len > 0) {
+		oobbuf = kmalloc(oobbuf_len, GFP_KERNEL);
+		if (!oobbuf) {
+			kfree(datbuf);
+			return -ENOMEM;
 		}
-	} else {
-		ops.oobbuf = NULL;
 	}
 
-	ret = mtd_write_oob(mtd, (loff_t)req.start, &ops);
+	while (req.len > 0 || (!usr_data && req.ooblen > 0)) {
+		struct mtd_oob_ops ops = {
+			.mode = req.mode,
+			.len = min_t(size_t, req.len, datbuf_len),
+			.ooblen = min_t(size_t, req.ooblen, oobbuf_len),
+			.datbuf = datbuf,
+			.oobbuf = oobbuf,
+		};
 
-	kfree(ops.datbuf);
-	kfree(ops.oobbuf);
+		/*
+		 * Shorten non-page-aligned, eraseblock-sized writes so that
+		 * the write ends on an eraseblock boundary.  This is necessary
+		 * for adjust_oob_length() to properly handle non-page-aligned
+		 * writes.
+		 */
+		if (ops.len == mtd->erasesize)
+			ops.len -= mtd_mod_by_ws(req.start + ops.len, mtd);
+
+		/*
+		 * For writes which are not OOB-only, adjust the amount of OOB
+		 * data written according to the number of data pages written.
+		 * This is necessary to prevent OOB data from being skipped
+		 * over in data+OOB writes requiring multiple mtd_write_oob()
+		 * calls to be completed.
+		 */
+		adjust_oob_length(mtd, req.start, &ops);
+
+		if (copy_from_user(datbuf, usr_data, ops.len) ||
+		    copy_from_user(oobbuf, usr_oob, ops.ooblen)) {
+			ret = -EFAULT;
+			break;
+		}
+
+		ret = mtd_write_oob(mtd, req.start, &ops);
+		if (ret)
+			break;
+
+		req.start += ops.retlen;
+		req.len -= ops.retlen;
+		usr_data += ops.retlen;
+
+		req.ooblen -= ops.oobretlen;
+		usr_oob += ops.oobretlen;
+	}
+
+	kfree(datbuf);
+	kfree(oobbuf);
 
 	return ret;
 }
-- 
2.34.1

