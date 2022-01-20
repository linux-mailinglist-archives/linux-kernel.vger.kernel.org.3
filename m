Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 86A8F495569
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 21:26:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377682AbiATU0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 15:26:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377645AbiATU0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 15:26:23 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7735BC061574;
        Thu, 20 Jan 2022 12:26:23 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso24558978wmj.2;
        Thu, 20 Jan 2022 12:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=bFvuHlWBlhLrQ+Wqzd7mZdO7/KSfytbRxINKe6WN5eE=;
        b=XpDnnLyRe3o+MVTmrl6vqky0nXyAmWk4qCjC4veYaXRI1Y/G6cKAk7YsAFLJmxRUqh
         LOMrNJCRQR1uN9kKzqsoImINJr2O/qUMhfFg/U5oWi2cBwnJdeY31sYlP8u3c+FeYVt7
         geDunL98zItlxnDP0dxncde7Lcu4HXn0sDPKfqeuRPTig/s2Qj+hyEOLXavH4a/JZdOU
         IyY1fMzRqtPvJKHBLGn4e2s7UJRMwRUBvQ684CGhmX1v/aNGaNzVGsEFbmBeeKSTLwWp
         wW5EAOmqrqyTbewOOG0kK7uDV9bFbNhqKNxtC39SX1gx1g2UvD8XY1QNOGNmrFOHfBxG
         z5Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bFvuHlWBlhLrQ+Wqzd7mZdO7/KSfytbRxINKe6WN5eE=;
        b=jFSMM0K0PdF1+12fJs1NNs53tl0+7Di4DckEhApNMK3Dgh3fQSwrS7Ah+EH26pV92o
         1ytk0f/yyF9qJSEVYrjpPSY1rgzeEkfNgHJD1yVTtqqUU/YbNmDuQKN5j3yDonp/qwql
         W21dV4Y5TUL/TXJvE6MGMniLOIjAj0CRhP3UtlgS3xdAdIy2W00YzXqtYuJBPxW8PjKu
         bjetR9ZuFunfGMA2ZU0gJ1JNdObGd2G2x/NxeKxEOqK4I7UiUaljrARWOIXqpQiMA49N
         JpL5BsFRdP/Kh/S9uSCstbMeurgzSSXwNHOKlL2kPaRg2nwF9+SAg6Bj79XYaGetZinp
         0vMQ==
X-Gm-Message-State: AOAM532Q0oVlGCv48r2Z0/oFYxsv6T+8xZ+egLKg0TaLJDIwVVdtwHow
        J/BX+lU1igKH+QMqe4sHnTY=
X-Google-Smtp-Source: ABdhPJy4+EZNqDhc98GJ7UGzRSXGekPNjSWG4HtF0A8Nj0VApqAotQncU4wsGvPNIsfYdQI1OzY1sg==
X-Received: by 2002:a05:600c:4ca7:: with SMTP id g39mr3847605wmp.158.1642710381739;
        Thu, 20 Jan 2022 12:26:21 -0800 (PST)
Received: from localhost.localdomain (93-42-71-246.ip85.fastwebnet.it. [93.42.71.246])
        by smtp.googlemail.com with ESMTPSA id n11sm862919wms.3.2022.01.20.12.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 12:26:21 -0800 (PST)
From:   Ansuel Smith <ansuelsmth@gmail.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Ansuel Smith <ansuelsmth@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [RFC PATCH 2/2] mtd: core: introduce of support for dynamic partitions
Date:   Thu, 20 Jan 2022 21:26:15 +0100
Message-Id: <20220120202615.28076-3-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20220120202615.28076-1-ansuelsmth@gmail.com>
References: <20220120202615.28076-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We have many parser that register mtd partitions at runtime. One example
is the cmdlinepart or the smem partition where the compatible is defined
in the dts and the partitions gets detected and registered by the
parser. This is problematic for the Nvmem system that requires an of node
to detect nvmem cells. To fix this problem, introduce an additional node
called "dynamic-partitions" that must be defined at the same level of
the "partitions" node that will contain all the required partitions
where a nvmem cell has to be declared. When a mtd_get_of_node() is
called, the function will first check the default dev_of_node() and then
check this alternative partitions node and optionally if a "nvmem-cells"
compatible is detected, sets the of node for the mtd.

The "dynamic-partitions" requires the label set to the mtd name from the
dynamic partition. All the nvmem-cells will be declared in this node and
nvmem will use this node to register the nvmem cells.

Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
---
 drivers/mtd/mtdcore.c   | 45 +++++++++++++++++++++++++++++++++++++++++
 include/linux/mtd/mtd.h |  6 +-----
 2 files changed, 46 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 9186268d361b..ccf350337811 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -563,6 +563,51 @@ static int mtd_nvmem_add(struct mtd_info *mtd)
 	return 0;
 }
 
+struct device_node *mtd_get_of_node(struct mtd_info *mtd)
+{
+	struct device_node *dynamic_partitions, *parent_dn, *dn, *mtd_dn = NULL;
+	struct mtd_info *parent;
+	const char *mtd_name;
+	int plen;
+
+	/* Check if mtd has a device node */
+	dn = dev_of_node(&mtd->dev);
+	if (dn)
+		return dn;
+
+	/* Check if a dynamic-partitions node exist */
+	parent = mtd->parent;
+	parent_dn = dev_of_node(&parent->dev);
+	if (!parent_dn)
+		return NULL;
+
+	dynamic_partitions = of_get_compatible_child(parent_dn, "dynamic-partitions");
+	if (!dynamic_partitions)
+		goto exit_parent;
+
+	/* Search if a dynamic partition is defined with the same name */
+	for_each_child_of_node(dynamic_partitions, dn) {
+		mtd_name = of_get_property(dn, "label", &plen);
+		if (!strncmp(mtd->name, mtd_name, plen)) {
+			mtd_dn = dn;
+			break;
+		}
+	}
+
+	if (!mtd_dn)
+		goto exit_partitions;
+
+	/* Set of_node only for nvmem */
+	if (of_device_is_compatible(mtd_dn, "nvmem-cells"))
+		mtd_set_of_node(mtd, mtd_dn);
+
+exit_partitions:
+	of_node_put(dynamic_partitions);
+exit_parent:
+	of_node_put(parent_dn);
+	return mtd_dn;
+}
+
 /**
  *	add_mtd_device - register an MTD device
  *	@mtd: pointer to new MTD device info structure
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index f5e7dfc2e4e9..f73d65817468 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -464,11 +464,6 @@ static inline void mtd_set_of_node(struct mtd_info *mtd,
 		of_property_read_string(np, "label", &mtd->name);
 }
 
-static inline struct device_node *mtd_get_of_node(struct mtd_info *mtd)
-{
-	return dev_of_node(&mtd->dev);
-}
-
 static inline u32 mtd_oobavail(struct mtd_info *mtd, struct mtd_oob_ops *ops)
 {
 	return ops->mode == MTD_OPS_AUTO_OOB ? mtd->oobavail : mtd->oobsize;
@@ -489,6 +484,7 @@ static inline int mtd_max_bad_blocks(struct mtd_info *mtd,
 				       len);
 }
 
+struct device_node *mtd_get_of_node(struct mtd_info *mtd);
 int mtd_wunit_to_pairing_info(struct mtd_info *mtd, int wunit,
 			      struct mtd_pairing_info *info);
 int mtd_pairing_info_to_wunit(struct mtd_info *mtd,
-- 
2.33.1

