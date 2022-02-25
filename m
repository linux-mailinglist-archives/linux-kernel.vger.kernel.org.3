Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373584C47E0
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:47:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241870AbiBYOrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:47:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241183AbiBYOrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:47:47 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E6333AA6A
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:47:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645800434; x=1677336434;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dkGAyHEWVTQl3NiL0UwoSudZNIgtkk6fnodpWJNCbOI=;
  b=ZjNNR6khxbrnrGRQ9rHZ7YTHt4lD8/AlrU+wRdT/tQtYRlr3iM7gU6/1
   FKaUokNhtNpTqXKGYkfmgKmmkfTxfAs2WQbiDyZq7GPlU37PoaQcOZ8B7
   cv5lvXXYMkNJxPRWzYVlzwuN0c64MWituu8vB7xDBR3GafCT8nmDVXtEL
   OFCUVV8XyXIziEopBsIUmDNwUx1CP02rBQTG2Q1cXc0SXqGaF7EbS39Xn
   MvIiK9K0/r7zsSkt9pOp+qYfISqcXVylEQCzqsvDSSnGFq9zDg5xCI4nc
   nh6iOpAnMwtIPbwPlV3VLPKnK3/BiqRZSHMgx4E/Pu/04DX5OTRYEN/gS
   A==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="87026717"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 07:47:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 07:47:05 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 25 Feb 2022 07:47:03 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tudor Ambarus" <tudor.ambarus@microchip.com>,
        Pratyush Yadav <p.yadav@ti.com>
Subject: [PATCH v2] mtd: core: Remove partid and partname debugfs files
Date:   Fri, 25 Feb 2022 16:46:56 +0200
Message-ID: <20220225144656.634682-1-tudor.ambarus@microchip.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

partid and partname debugfs files were used just by SPI NOR, but they were
replaced by sysfs entries. Since these debugfs files are no longer used in
mtd, remove dead code. The directory is kept as it is used by nandsim,
mtdswap and docg3.

Signed-off-by: Tudor Ambarus <tudor.ambarus@microchip.com>
Reviewed-by: Pratyush Yadav <p.yadav@ti.com>
---
v2:
- update commit message
- collect R-b tag

 drivers/mtd/mtdcore.c   | 35 +----------------------------------
 include/linux/mtd/mtd.h |  3 ---
 2 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 1e7f3bbf847e..7dd105daf19d 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -336,28 +336,6 @@ static const struct device_type mtd_devtype = {
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
 static bool mtd_expert_analysis_mode;
 
 #ifdef CONFIG_DEBUG_FS
@@ -377,23 +355,12 @@ static struct dentry *dfs_dir_mtd;
 
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
index 1b3fc8c71ab3..151607e9d64a 100644
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

