Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C877C49B25E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 11:54:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378486AbiAYKvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 05:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377101AbiAYKse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 05:48:34 -0500
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8D8C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:48:34 -0800 (PST)
Received: by mail-lf1-x134.google.com with SMTP id x11so55966421lfa.2
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 02:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9xG9ybZ2bk07KpDBvmq82bns44VBsEgiEAlMx6te1s=;
        b=eTJDRtWMkEvwumN/PwbV2huigDmLkT28unqbUV95ieTvhEIBFIBcQmS5F3rAP4iw0T
         u2NLpilk2JA7ikJHhtF8x48nDW44SgBjQq1lwptwzdVZ3DekZna5erMk1hsHWGC0Z6Xe
         vWakmhEdOvQ+Y5hDQHdKBPfF9FUoH3rmjwS+c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9xG9ybZ2bk07KpDBvmq82bns44VBsEgiEAlMx6te1s=;
        b=Pt3Btzv1nYVLCKhBHJc19N9wWwfIzG/KCSRcJq1HmQv2X0R6FNIUmMIg9PtmBPBjs1
         Uujc2HCeaL/gsyLOyG5rxbe1hRy6FK/xZFKv08cNbpEdpOqvREq8ZMWAsRr4Xq7op5XG
         xV3KoSfyRiHf1JeMc9zoPGytdaA0znvlUKEejKU65vZrYqepNn92jCxlLIp9CXrlKCW+
         8K/vcqphhNZgOnj0njtU6gI6ewS3PRT3lUCnqUgUuMYO73bzvsDabW8Y/P9zddv7t+sI
         1b5Kde1qKaHy79Nzrwv1/CYCP8ex5DoTJM72kirQx+lTF1/0gIsEE1PmXYc7UPv6y5HU
         Olvw==
X-Gm-Message-State: AOAM533uPqxhzgDlOPFTq92AnQ1Pg9jmobbVgmny7fzm0bsm4aXAyCtC
        8jF3G030RjkNRo0BVH24nVSqVA==
X-Google-Smtp-Source: ABdhPJyPoI4pr0FWAy7hwPYul1Esicj+vsWk1Mau25ZduQKEDQHI+lXIprhR4ONeMk6RTCJceyebzg==
X-Received: by 2002:a19:500c:: with SMTP id e12mr8091350lfb.18.1643107712251;
        Tue, 25 Jan 2022 02:48:32 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::221])
        by smtp.gmail.com with ESMTPSA id d16sm461896ljj.74.2022.01.25.02.48.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 02:48:31 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] mtd: track maximum number of bitflips for each read request
Date:   Tue, 25 Jan 2022 11:48:19 +0100
Message-Id: <20220125104822.8420-2-kernel@kempniu.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220125104822.8420-1-kernel@kempniu.pl>
References: <20220125104822.8420-1-kernel@kempniu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

mtd_read_oob() callers are currently oblivious to the details of ECC
errors detected during the read operation - they only learn (through the
return value) whether any corrected bitflips or uncorrectable errors
occurred.  More detailed ECC information can be useful to user-space
applications for making better-informed choices about moving data
around.

Extend struct mtd_oob_ops with a pointer to a newly-introduced struct
mtd_req_stats and set its 'max_bitflips' field to the maximum number of
bitflips found in a single ECC step during the read operation performed
by mtd_read_oob(). This is a prerequisite for ultimately passing that
value back to user space.

Suggested-by: Boris Brezillon <boris.brezillon@collabora.com>
Signed-off-by: Michał Kępień <kernel@kempniu.pl>
---
 drivers/mtd/mtdcore.c   | 5 +++++
 include/linux/mtd/mtd.h | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 70f492dce158..9423af6db385 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -1575,6 +1575,9 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 	if (!master->_read_oob && (!master->_read || ops->oobbuf))
 		return -EOPNOTSUPP;
 
+	if (ops->stats)
+		memset(ops->stats, 0, sizeof(*ops->stats));
+
 	if (mtd->flags & MTD_SLC_ON_MLC_EMULATION)
 		ret_code = mtd_io_emulated_slc(mtd, from, true, ops);
 	else
@@ -1592,6 +1595,8 @@ int mtd_read_oob(struct mtd_info *mtd, loff_t from, struct mtd_oob_ops *ops)
 		return ret_code;
 	if (mtd->ecc_strength == 0)
 		return 0;	/* device lacks ecc */
+	if (ops->stats)
+		ops->stats->max_bitflips = ret_code;
 	return ret_code >= mtd->bitflip_threshold ? -EUCLEAN : 0;
 }
 EXPORT_SYMBOL_GPL(mtd_read_oob);
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 1ffa933121f6..f976aabcb378 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -40,6 +40,10 @@ struct mtd_erase_region_info {
 	unsigned long *lockmap;		/* If keeping bitmap of locks */
 };
 
+struct mtd_req_stats {
+	unsigned int max_bitflips;
+};
+
 /**
  * struct mtd_oob_ops - oob operation operands
  * @mode:	operation mode
@@ -70,6 +74,7 @@ struct mtd_oob_ops {
 	uint32_t	ooboffs;
 	uint8_t		*datbuf;
 	uint8_t		*oobbuf;
+	struct mtd_req_stats *stats;
 };
 
 /**
-- 
2.34.1

