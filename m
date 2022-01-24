Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 619DF498785
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 19:01:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244843AbiAXSBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 13:01:14 -0500
Received: from mga05.intel.com ([192.55.52.43]:37762 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244853AbiAXSAj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 13:00:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1643047239; x=1674583239;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CNrKOx69eGmZ3K24njISK38bi6jWQ4/aJUl4ds2Q64o=;
  b=lpplnq9ZraUq2IUgH394GMZmMuZ3Q1W+XuqpXvRsyzm9tUtphpqxYc2f
   mgLZUkY9jfvTO+2DVa0BjEf5fxX4YyR3DF0Csl0OKmUo1gO+O+fuEpBty
   HBFuSV2vV9AD7DQGvNhHq1pfQUd5okOhOv6K9aroiTIJoiKjwFFmH6PVq
   aKQe6A0buznioDFzlEoddl02IPd+4TP1hCgVn4nZ6+F+c5Vv5IWCVBptp
   od6YQybGF79kdBw7THo7YDwrMwBTaMXaH8t4S+XWBWWnv2NidpcxIxEpO
   LRJdpPB69yIBueFobesiJygsWJ2EaZOqeBs1qtYPU/QsmxHJjrUXXHgcR
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10237"; a="332462054"
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="332462054"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2022 10:00:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,311,1635231600"; 
   d="scan'208";a="617333123"
Received: from black.fi.intel.com ([10.237.72.28])
  by FMSMGA003.fm.intel.com with ESMTP; 24 Jan 2022 10:00:29 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 751A49E7; Mon, 24 Jan 2022 20:00:42 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>
Subject: [PATCH v2 4/5] mtd: core: Drop duplicate NULL checks around nvmem_unregister()
Date:   Mon, 24 Jan 2022 20:00:39 +0200
Message-Id: <20220124180040.50660-4-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220124180040.50660-1-andriy.shevchenko@linux.intel.com>
References: <20220124180040.50660-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since nvmem_unregister() checks for NULL, no need to repeat in
the caller. Drop duplicate NULL checks.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
---
v2: added tag (Miquel)
 drivers/mtd/mtdcore.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index 70f492dce158..010ffc34532a 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -742,8 +742,7 @@ int del_mtd_device(struct mtd_info *mtd)
 		debugfs_remove_recursive(mtd->dbg.dfs_dir);
 
 		/* Try to remove the NVMEM provider */
-		if (mtd->nvmem)
-			nvmem_unregister(mtd->nvmem);
+		nvmem_unregister(mtd->nvmem);
 
 		device_unregister(&mtd->dev);
 
@@ -921,8 +920,7 @@ static int mtd_otp_nvmem_add(struct mtd_info *mtd)
 	return 0;
 
 err:
-	if (mtd->otp_user_nvmem)
-		nvmem_unregister(mtd->otp_user_nvmem);
+	nvmem_unregister(mtd->otp_user_nvmem);
 	return err;
 }
 
@@ -1026,11 +1024,8 @@ int mtd_device_unregister(struct mtd_info *master)
 		memset(&master->reboot_notifier, 0, sizeof(master->reboot_notifier));
 	}
 
-	if (master->otp_user_nvmem)
-		nvmem_unregister(master->otp_user_nvmem);
-
-	if (master->otp_factory_nvmem)
-		nvmem_unregister(master->otp_factory_nvmem);
+	nvmem_unregister(master->otp_user_nvmem);
+	nvmem_unregister(master->otp_factory_nvmem);
 
 	err = del_mtd_partitions(master);
 	if (err)
-- 
2.34.1

