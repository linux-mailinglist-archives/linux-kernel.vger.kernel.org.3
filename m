Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE5478B58
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 13:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236330AbhLQM1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 07:27:04 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:31989 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236322AbhLQM0v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 07:26:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639744010; x=1671280010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=o0b6NEaAdzRZp/oj1QR5jmYHPgsawDkmnu8lKNhP8dA=;
  b=ifY5eA6dVX2Vvqt8Y2RDgIDxF7a8DYdDmGZ3w31/V09uUWuWc1usfq+B
   8tioqOGDnMAXIA9idLY58I8wcPSKhM4XaBRCAZFP0Za2b2a9ynqJaArBE
   d4ZscUzz8DzxXV5Fbj36tXL34nIZ/To/6huBFbYtvUCUCKoAFmywIWIcj
   Dt9ZQ8JTNyvCRJCoSqRK2tMOSRcKtbuRinI5+hNxVq4acDzWVMYtQFKul
   bTae2ZrBYuvbyBdc6ZZYDpyG7HpAubHoVkRMreJzxYLWu3p4/3dAP8PNZ
   hsmv+kuTFSmjaJ1VeTdcnf34gHvL8pR8Ck2neD41ZidvAYuTlG6acJ7Y8
   A==;
IronPort-SDR: FXsndbt7yXlNiJ4sCLGUWhx1mMiHe7cPP9NtEGIoqGaRmhTM7/L2AAVFoc+5tzYl9BpDrZ0iII
 z7dv0P6qRQ7zIyDKgDZvoFVwSGcfGkBQB47b5N2INR8JAN24MgwzMO6hLGH9/+tdY7DHop6rCQ
 uGYS9TiSsvSudvW5CZjt8YZmWcsYX8aKCRuIWVehzLOMqldRqiXB3yEEwo98nMJDQ6BH6U+8/+
 WzJSQDlmjda6Rxvhbd14lCaCvNnrkPJT3hjChcgB01rodpc5XjfM8YmN76qbhzPr4Smf0sAXpt
 36ykzbXkd7hI4a0LjMbsaRSs
X-IronPort-AV: E=Sophos;i="5.88,213,1635231600"; 
   d="scan'208";a="140126610"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Dec 2021 05:26:49 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Dec 2021 05:26:46 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 17 Dec 2021 05:26:44 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <zhuohao@chromium.org>, <p.yadav@ti.com>, <michael@walle.cc>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>
Subject: [PATCH 2/2] mtd: core: Remove partid and partname debugfs files
Date:   Fri, 17 Dec 2021 14:26:36 +0200
Message-ID: <20211217122636.474976-3-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211217122636.474976-1-tudor.ambarus@microchip.com>
References: <20211217122636.474976-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

partid and partname debugfs file are no longer used in mtd, remove
dead code.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
---
 drivers/mtd/mtdcore.c   | 35 +----------------------------------
 include/linux/mtd/mtd.h |  3 ---
 2 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 9186268d361b..1977755fc955 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -336,49 +336,16 @@ static const struct device_type mtd_devtype = {
 	.release	= mtd_release,
 };
 
-static int mtd_partid_debug_show(struct seq_file *s, void *p)
-{
-	struct mtd_info *mtd = s->private;
-
-	seq_printf(s, "%s\n", mtd->dbg.partid);
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(mtd_partid_debug);
-
-static int mtd_partname_debug_show(struct seq_file *s, void *p)
-{
-	struct mtd_info *mtd = s->private;
-
-	seq_printf(s, "%s\n", mtd->dbg.partname);
-
-	return 0;
-}
-
-DEFINE_SHOW_ATTRIBUTE(mtd_partname_debug);
-
 static struct dentry *dfs_dir_mtd;
 
 static void mtd_debugfs_populate(struct mtd_info *mtd)
 {
-	struct mtd_info *master = mtd_get_master(mtd);
 	struct device *dev = &mtd->dev;
-	struct dentry *root;
 
 	if (IS_ERR_OR_NULL(dfs_dir_mtd))
 		return;
 
-	root = debugfs_create_dir(dev_name(dev), dfs_dir_mtd);
-	mtd->dbg.dfs_dir = root;
-
-	if (master->dbg.partid)
-		debugfs_create_file("partid", 0400, root, master,
-				    &mtd_partid_debug_fops);
-
-	if (master->dbg.partname)
-		debugfs_create_file("partname", 0400, root, master,
-				    &mtd_partname_debug_fops);
+	mtd->dbg.dfs_dir = debugfs_create_dir(dev_name(dev), dfs_dir_mtd);
 }
 
 #ifndef CONFIG_MMU
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index f5e7dfc2e4e9..00cb269d0261 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -188,9 +188,6 @@ struct module;	/* only needed for owner field in mtd_info */
  */
 struct mtd_debug_info {
 	struct dentry *dfs_dir;
-
-	const char *partname;
-	const char *partid;
 };
 
 /**
-- 
2.25.1

