Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6491E549C4E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 20:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238959AbiFMSzv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 14:55:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345077AbiFMSz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 14:55:27 -0400
Received: from mx4.veeam.com (mx4.veeam.com [104.41.138.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 570C4FC833;
        Mon, 13 Jun 2022 08:59:53 -0700 (PDT)
Received: from mail.veeam.com (prgmbx01.amust.local [172.24.128.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx4.veeam.com (Postfix) with ESMTPS id 6F344CCE27;
        Mon, 13 Jun 2022 18:54:16 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=veeam.com;
        s=mx4-2022; t=1655135656;
        bh=JeE4IDLZnrkgWQvxzU/0/BAJVvEljvMQrQHfVZ+A+xM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References:From;
        b=MSw3FLACURP7Fe6FANRB+tcHjJCINeI7ZI37CTeiDgUlFR2XJRltn5tsnfM+yuHoY
         FNZzluNQuZfT5fgGj7Dcv08r5DiisCtJFpSprCrkfXsnBWz1/fcTVJa5crAORO937f
         /TIeBLgrdXB6E3zjchji9n92+F5Vc05RW2Ok72gfeBH7C6pSHj08jsvA7geN3fxp9s
         7MFxLla0NsIDOSijG+vNB96pTrm4mA0Riizc0DHk5XOnhOk7szGX/es7cWzCDLBMO2
         Oigk8zuPXYS00O1nzCWmIzxttXAAJht/mND7KsB69RtWjyLMdzDP+Dy7WsPt4KCkvO
         W+R01to3DUp4A==
Received: from prgdevlinuxpatch01.amust.local (172.24.14.5) by
 prgmbx01.amust.local (172.24.128.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.9; Mon, 13 Jun 2022 17:54:14 +0200
From:   Sergei Shtepa <sergei.shtepa@veeam.com>
To:     <axboe@kernel.dk>, <linux-block@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Sergei Shtepa <sergei.shtepa@veeam.com>
Subject: [PATCH 05/20] block, blksnap: interaction with sysfs
Date:   Mon, 13 Jun 2022 18:52:58 +0300
Message-ID: <1655135593-1900-6-git-send-email-sergei.shtepa@veeam.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
References: <1655135593-1900-1-git-send-email-sergei.shtepa@veeam.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [172.24.14.5]
X-ClientProxiedBy: prgmbx01.amust.local (172.24.128.102) To
 prgmbx01.amust.local (172.24.128.102)
X-EsetResult: clean, is OK
X-EsetId: 37303A29D2A50A536D7766
X-Veeam-MMEX: True
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provides creation of a class file /sys/class/blksnap and a device file
/dev/blksnap for module management.

Signed-off-by: Sergei Shtepa <sergei.shtepa@veeam.com>
---
 drivers/block/blksnap/sysfs.c | 81 +++++++++++++++++++++++++++++++++++
 drivers/block/blksnap/sysfs.h |  5 +++
 2 files changed, 86 insertions(+)
 create mode 100644 drivers/block/blksnap/sysfs.c
 create mode 100644 drivers/block/blksnap/sysfs.h

diff --git a/drivers/block/blksnap/sysfs.c b/drivers/block/blksnap/sysfs.c
new file mode 100644
index 000000000000..32a34609d106
--- /dev/null
+++ b/drivers/block/blksnap/sysfs.c
@@ -0,0 +1,81 @@
+// SPDX-License-Identifier: GPL-2.0
+#define pr_fmt(fmt) KBUILD_MODNAME "-sysfs: " fmt
+#include <linux/blkdev.h>
+#include <linux/sysfs.h>
+#include <linux/device.h>
+#include <linux/blk_snap.h>
+#ifdef CONFIG_BLK_SNAP_DEBUG_MEMORY_LEAK
+#include "memory_checker.h"
+#endif
+#include "sysfs.h"
+#include "ctrl.h"
+
+static ssize_t major_show(struct class *class, struct class_attribute *attr,
+			  char *buf)
+{
+	sprintf(buf, "%d", get_blk_snap_major());
+	return strlen(buf);
+}
+
+/* Declare class_attr_major */
+CLASS_ATTR_RO(major);
+
+static struct class *blk_snap_class;
+
+static struct device *blk_snap_device;
+
+int sysfs_init(void)
+{
+	struct device *dev;
+	int res;
+
+	blk_snap_class = class_create(THIS_MODULE, BLK_SNAP_MODULE_NAME);
+	if (IS_ERR(blk_snap_class)) {
+		res = PTR_ERR(blk_snap_class);
+
+		pr_err("Bad class create. errno=%d\n", abs(res));
+		return res;
+	}
+
+	pr_info("Create 'major' sysfs attribute\n");
+	res = class_create_file(blk_snap_class, &class_attr_major);
+	if (res) {
+		pr_err("Failed to create 'major' sysfs file\n");
+
+		class_destroy(blk_snap_class);
+		blk_snap_class = NULL;
+		return res;
+	}
+
+	dev = device_create(blk_snap_class, NULL,
+			    MKDEV(get_blk_snap_major(), 0), NULL,
+			    BLK_SNAP_MODULE_NAME);
+	if (IS_ERR(dev)) {
+		res = PTR_ERR(dev);
+		pr_err("Failed to create device, errno=%d\n", abs(res));
+
+		class_remove_file(blk_snap_class, &class_attr_major);
+		class_destroy(blk_snap_class);
+		blk_snap_class = NULL;
+		return res;
+	}
+
+	blk_snap_device = dev;
+	return res;
+}
+
+void sysfs_done(void)
+{
+	pr_info("Cleanup sysfs\n");
+
+	if (blk_snap_device) {
+		device_unregister(blk_snap_device);
+		blk_snap_device = NULL;
+	}
+
+	if (blk_snap_class != NULL) {
+		class_remove_file(blk_snap_class, &class_attr_major);
+		class_destroy(blk_snap_class);
+		blk_snap_class = NULL;
+	}
+}
diff --git a/drivers/block/blksnap/sysfs.h b/drivers/block/blksnap/sysfs.h
new file mode 100644
index 000000000000..b41c301fe33b
--- /dev/null
+++ b/drivers/block/blksnap/sysfs.h
@@ -0,0 +1,5 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#pragma once
+
+int sysfs_init(void);
+void sysfs_done(void);
-- 
2.20.1

