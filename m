Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0897D48FA74
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 04:22:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234153AbiAPDW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jan 2022 22:22:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiAPDW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jan 2022 22:22:27 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB1FC061574;
        Sat, 15 Jan 2022 19:22:26 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id d18-20020a05600c251200b0034974323cfaso15706987wma.4;
        Sat, 15 Jan 2022 19:22:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y0RvgzcdSRbA/gXGiR6apnZgPu9pepPQ0gbrYqOPoLE=;
        b=Gw9tlcGHUBA7nL9vDVhM/NR8f84EcT3JgkX2vsS43sjZNMI5lvgxcXzixbJDkgIvEh
         zNH7DFhwQfJguxA87AAG2RHmLDCQiKzuCrWBcp90ZLjiG7kIuwTXxjOTYwSjgH1otBCv
         sVWyXVWCEZCx2xDOY5GWVIjLoieRuMbZIw1sxJ7bnD4Nl/BdsRgevK2VKY4LAH+Qraif
         /pUjmBC1JS+s1kxJ2d8rzdUkfSh0bRfhGRY7wvD7WhepJyYjLSS3tVoUIyzy0eH4Qx3S
         wL66lAN0rchlXkF55movnqeEnYd0bYJZ+lNkDkmc+PvwRQ/gMc4fJIRVmT0rWkuBRx1y
         KGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=y0RvgzcdSRbA/gXGiR6apnZgPu9pepPQ0gbrYqOPoLE=;
        b=Rk7QMWOTHLJ02vR8M3bp+rpDCyFtl9LW0SMJu06i/wFVw0sHlnGMfddpl1+pI2peab
         /wlmAdBudDFjrxFpNGs4VKeQVvNfcy2EyHp4tUSgh8DhbxbK6dfb4V75oZcnbkfLEFYL
         LvEhfw1UPIcAWHghDgJVHAZhrlcJWxVygLl3HDOWiYkc7jMAd51dskdNxoXh36S9S9Of
         TEjyEPaeiGrKdXWxVYSwSgBGEGt3QkGY0RFa4CeOxEZVw01eTfhRu6Y6qJSzuOVll+9t
         As2R9TvkGZT+JHPYYAHK9qtZsSFEMkxpHR433JdIweQEDw6ZJ3KOjoonKbscOyABAa6R
         keTA==
X-Gm-Message-State: AOAM532iAd9FtUxBk69kDjsYvEXh2zsRyq0+QZJ2GSeNEqpZw2rxaLdd
        Uszmn4ngZEMcMqBuKez6T9cPFoL4uzE=
X-Google-Smtp-Source: ABdhPJyo4nf0cRPn+sy7h83rr4UPkcSsMjlYgG5pSzjHC4ZsPh7KLffkSIuV75Wl41iYNRMVu+k8hg==
X-Received: by 2002:adf:f94a:: with SMTP id q10mr13990771wrr.263.1642303345120;
        Sat, 15 Jan 2022 19:22:25 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id u16sm1446785wmq.23.2022.01.15.19.22.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jan 2022 19:22:24 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH 1/2] mtd: parsers: qcom: Fix kernel panic on skipped partition
Date:   Sun, 16 Jan 2022 04:22:10 +0100
Message-Id: <20220116032211.9728-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the event of a skipped partition (case when the entry name is empty)
the kernel panics in the cleanup function as the name entry is NULL.
Rework the parser logic by first checking the real partition number and
then allocate the space and set the data for the valid partitions.

The logic was also fundamentally wrong as with a skipped partition, the
parts number returned was incorrect by not decreasing it for the skipped
partitions.

Fixes: 803eb12 ("mtd: parsers: Add Qcom SMEM parser")
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/parsers/qcomsmempart.c | 31 ++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/drivers/mtd/parsers/qcomsmempart.c b/drivers/mtd/parsers/qcomsmempart.c
index 06a818cd2433..f4fc7635c1f3 100644
--- a/drivers/mtd/parsers/qcomsmempart.c
+++ b/drivers/mtd/parsers/qcomsmempart.c
@@ -58,11 +58,11 @@ static int parse_qcomsmem_part(struct mtd_info *mtd,
 			       const struct mtd_partition **pparts,
 			       struct mtd_part_parser_data *data)
 {
+	size_t len = SMEM_FLASH_PTABLE_HDR_LEN;
+	int ret, i, j, tmpparts, numparts = 0;
 	struct smem_flash_pentry *pentry;
 	struct smem_flash_ptable *ptable;
-	size_t len = SMEM_FLASH_PTABLE_HDR_LEN;
 	struct mtd_partition *parts;
-	int ret, i, numparts;
 	char *name, *c;
 
 	if (IS_ENABLED(CONFIG_MTD_SPI_NOR_USE_4K_SECTORS)
@@ -87,8 +87,8 @@ static int parse_qcomsmem_part(struct mtd_info *mtd,
 	}
 
 	/* Ensure that # of partitions is less than the max we have allocated */
-	numparts = le32_to_cpu(ptable->numparts);
-	if (numparts > SMEM_FLASH_PTABLE_MAX_PARTS_V4) {
+	tmpparts = le32_to_cpu(ptable->numparts);
+	if (tmpparts > SMEM_FLASH_PTABLE_MAX_PARTS_V4) {
 		pr_err("Partition numbers exceed the max limit\n");
 		return -EINVAL;
 	}
@@ -116,11 +116,17 @@ static int parse_qcomsmem_part(struct mtd_info *mtd,
 		return PTR_ERR(ptable);
 	}
 
+	for (i = 0; i < tmpparts; i++) {
+		pentry = &ptable->pentry[i];
+		if (pentry->name[0] != '\0')
+			numparts++;
+	}
+
 	parts = kcalloc(numparts, sizeof(*parts), GFP_KERNEL);
 	if (!parts)
 		return -ENOMEM;
 
-	for (i = 0; i < numparts; i++) {
+	for (i = 0, j = 0; i < tmpparts; i++) {
 		pentry = &ptable->pentry[i];
 		if (pentry->name[0] == '\0')
 			continue;
@@ -135,24 +141,25 @@ static int parse_qcomsmem_part(struct mtd_info *mtd,
 		for (c = name; *c != '\0'; c++)
 			*c = tolower(*c);
 
-		parts[i].name = name;
-		parts[i].offset = le32_to_cpu(pentry->offset) * mtd->erasesize;
-		parts[i].mask_flags = pentry->attr;
-		parts[i].size = le32_to_cpu(pentry->length) * mtd->erasesize;
+		parts[j].name = name;
+		parts[j].offset = le32_to_cpu(pentry->offset) * mtd->erasesize;
+		parts[j].mask_flags = pentry->attr;
+		parts[j].size = le32_to_cpu(pentry->length) * mtd->erasesize;
 		pr_debug("%d: %s offs=0x%08x size=0x%08x attr:0x%08x\n",
 			 i, pentry->name, le32_to_cpu(pentry->offset),
 			 le32_to_cpu(pentry->length), pentry->attr);
+		j++;
 	}
 
 	pr_debug("SMEM partition table found: ver: %d len: %d\n",
-		 le32_to_cpu(ptable->version), numparts);
+		 le32_to_cpu(ptable->version), tmpparts);
 	*pparts = parts;
 
 	return numparts;
 
 out_free_parts:
-	while (--i >= 0)
-		kfree(parts[i].name);
+	while (--j >= 0)
+		kfree(parts[j].name);
 	kfree(parts);
 	*pparts = NULL;
 
-- 
2.33.1

