Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE36F476C09
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 09:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbhLPIei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 03:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234871AbhLPIee (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 03:34:34 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFB5CC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:33 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id a37so36257987ljq.13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 00:34:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kempniu.pl; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d9xG9ybZ2bk07KpDBvmq82bns44VBsEgiEAlMx6te1s=;
        b=EL5H03Zai7OslD+sRoxg4Ca1bToBiabJY7e6fM9ZBF736bqRNHbC+11Arp8slesx7A
         DgtBdsiNDp1F523aavgsM+itrGr6/HkY2+ckzYnQMnbBCJbbsAkXTIVNG0x79jmD7T4k
         +yqKLCxFjwTsxnwC+Y+laQ+hO6+H9ODTHhu3g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d9xG9ybZ2bk07KpDBvmq82bns44VBsEgiEAlMx6te1s=;
        b=v+wTqFQxkUIwKRKwRX2xRgnbjbcchJlOduQKXwmt/XBX50h726SZUozxMb2oDI6Nws
         UIvxwSMFygAZjitQZDnXW7jzmVbMHMG42iaDigjBU77MsdcDkg0ylJDljFGOZxzLHEUl
         hqxWdFuGXmlEsZBSF55MKXKbxbEYcYvwMM5NDlk1nGvqetHlRlCJ/mjo5L4jI4/+aiT4
         v1e2MxE+1B4quGKsDCsGzHXm/H8dDke0qNeA+Dzii7QFkUcA7hEyRNnjLJeo7gi9kCLY
         bXjFVGkL633nyCnOBIwipbAD/8iiXhZgYUfxeb5ZCXlj6JUV5LmGjmbqhxiehuhvOf7u
         XJEw==
X-Gm-Message-State: AOAM533qjt03j5kXHZItL8HDX+rN1LLwRyE9zZxdM61R6rrosfh/xIU1
        Q/nZSO0xAfINeV6J0b+h3EOy3A==
X-Google-Smtp-Source: ABdhPJw4VE/C2/MpPNkCdwWh5LOV3Q5TdtkU8i1fVdAAld1AH2ZrFUFYk0mb/wPEKjYx1AZbheRK0A==
X-Received: by 2002:a2e:920a:: with SMTP id k10mr14270298ljg.234.1639643672217;
        Thu, 16 Dec 2021 00:34:32 -0800 (PST)
Received: from larwa.hq.kempniu.pl ([2001:470:64df:111::e02])
        by smtp.gmail.com with ESMTPSA id c2sm985679ljf.50.2021.12.16.00.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 00:34:31 -0800 (PST)
From:   =?UTF-8?q?Micha=C5=82=20K=C4=99pie=C5=84?= <kernel@kempniu.pl>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <boris.brezillon@collabora.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/5] mtd: track maximum number of bitflips for each read request
Date:   Thu, 16 Dec 2021 09:34:15 +0100
Message-Id: <20211216083418.13512-3-kernel@kempniu.pl>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20211216083418.13512-1-kernel@kempniu.pl>
References: <20211216083418.13512-1-kernel@kempniu.pl>
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

